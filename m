Received: from eggs.gnu.org ([2001:4830:134:3::10]:56640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70P-0001Tx-G5
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70O-000477-BF
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:43:04 +1000
Message-Id: <20170927074316.4454-15-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/26] spapr: introduce helpers to migrate HPT
 chunks and the end marker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

This consolidates some duplicated code in a dedicated helpers.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 90a94952c3..0ce3ec87ac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1709,6 +1709,23 @@ static int htab_save_setup(QEMUFile *f, void *opaque)
     return 0;
 }
 
+static void htab_save_chunk(QEMUFile *f, sPAPRMachineState *spapr,
+                            int chunkstart, int n_valid, int n_invalid)
+{
+    qemu_put_be32(f, chunkstart);
+    qemu_put_be16(f, n_valid);
+    qemu_put_be16(f, n_invalid);
+    qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
+                    HASH_PTE_SIZE_64 * n_valid);
+}
+
+static void htab_save_end_marker(QEMUFile *f)
+{
+    qemu_put_be32(f, 0);
+    qemu_put_be16(f, 0);
+    qemu_put_be16(f, 0);
+}
+
 static void htab_save_first_pass(QEMUFile *f, sPAPRMachineState *spapr,
                                  int64_t max_ns)
 {
@@ -1740,11 +1757,7 @@ static void htab_save_first_pass(QEMUFile *f, sPAPRMachineState *spapr,
         if (index > chunkstart) {
             int n_valid = index - chunkstart;
 
-            qemu_put_be32(f, chunkstart);
-            qemu_put_be16(f, n_valid);
-            qemu_put_be16(f, 0);
-            qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
-                            HASH_PTE_SIZE_64 * n_valid);
+            htab_save_chunk(f, spapr, chunkstart, n_valid, 0);
 
             if (has_timeout &&
                 (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - starttime) > max_ns) {
@@ -1806,11 +1819,7 @@ static int htab_save_later_pass(QEMUFile *f, sPAPRMachineState *spapr,
             int n_valid = invalidstart - chunkstart;
             int n_invalid = index - invalidstart;
 
-            qemu_put_be32(f, chunkstart);
-            qemu_put_be16(f, n_valid);
-            qemu_put_be16(f, n_invalid);
-            qemu_put_buffer(f, HPTE(spapr->htab, chunkstart),
-                            HASH_PTE_SIZE_64 * n_valid);
+            htab_save_chunk(f, spapr, chunkstart, n_valid, n_invalid);
             sent += index - chunkstart;
 
             if (!final && (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) - starttime) > max_ns) {
@@ -1873,10 +1882,7 @@ static int htab_save_iterate(QEMUFile *f, void *opaque)
         rc = htab_save_later_pass(f, spapr, MAX_ITERATION_NS);
     }
 
-    /* End marker */
-    qemu_put_be32(f, 0);
-    qemu_put_be16(f, 0);
-    qemu_put_be16(f, 0);
+    htab_save_end_marker(f);
 
     return rc;
 }
@@ -1916,9 +1922,7 @@ static int htab_save_complete(QEMUFile *f, void *opaque)
     }
 
     /* End marker */
-    qemu_put_be32(f, 0);
-    qemu_put_be16(f, 0);
-    qemu_put_be16(f, 0);
+    htab_save_end_marker(f);
 
     return 0;
 }
-- 
2.13.5

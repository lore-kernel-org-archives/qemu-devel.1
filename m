Received: from eggs.gnu.org ([2001:4830:134:3::10]:43402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1duJF7-0004Xk-J7
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1duJF4-000300-6p
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:11:17 -0400
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:34663)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1duJF3-0002z1-W4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:11:14 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 4CA1A95A6A
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 16:11:12 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Tue, 19 Sep 2017 16:11:07 +0200
Message-ID: <150583026752.26236.7284148199846043137.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2] spapr: introduce helpers to migrate HPT
 chunks and the end marker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>

This consolidates some duplicated code in a dedicated helpers.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - open-code writes for the end marker
---
 hw/ppc/spapr.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f680f28a15ea..c18c36da71d6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1708,6 +1708,23 @@ static int htab_save_setup(QEMUFile *f, void *opaque)
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
@@ -1739,11 +1756,7 @@ static void htab_save_first_pass(QEMUFile *f, sPAPRMachineState *spapr,
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
@@ -1805,11 +1818,7 @@ static int htab_save_later_pass(QEMUFile *f, sPAPRMachineState *spapr,
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
@@ -1872,10 +1881,7 @@ static int htab_save_iterate(QEMUFile *f, void *opaque)
         rc = htab_save_later_pass(f, spapr, MAX_ITERATION_NS);
     }
 
-    /* End marker */
-    qemu_put_be32(f, 0);
-    qemu_put_be16(f, 0);
-    qemu_put_be16(f, 0);
+    htab_save_end_marker(f);
 
     return rc;
 }
@@ -1915,9 +1921,7 @@ static int htab_save_complete(QEMUFile *f, void *opaque)
     }
 
     /* End marker */
-    qemu_put_be32(f, 0);
-    qemu_put_be16(f, 0);
-    qemu_put_be16(f, 0);
+    htab_save_end_marker(f);
 
     return 0;
 }

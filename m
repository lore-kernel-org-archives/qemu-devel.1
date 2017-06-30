Received: from eggs.gnu.org ([2001:4830:134:3::10]:34349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRj-0008SK-UN
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRi-0007u8-RB
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:17 +1000
Message-Id: <20170630104632.27942-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/21] spapr: Add a "no HPT" encoding to HTAB
 migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

Add a "no HPT" encoding (using value -1) to the HTAB migration
stream (in the place of HPT size) when the guest doesn't allocate HPT.
This will help the target side to match target HPT with the source HPT
and thus enable successful migration.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 52f4e72..f3e0b9b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1560,13 +1560,19 @@ static int htab_save_setup(QEMUFile *f, void *opaque)
     sPAPRMachineState *spapr = opaque;
 
     /* "Iteration" header */
-    qemu_put_be32(f, spapr->htab_shift);
+    if (!spapr->htab_shift) {
+        qemu_put_be32(f, -1);
+    } else {
+        qemu_put_be32(f, spapr->htab_shift);
+    }
 
     if (spapr->htab) {
         spapr->htab_save_index = 0;
         spapr->htab_first_pass = true;
     } else {
-        assert(kvm_enabled());
+        if (spapr->htab_shift) {
+            assert(kvm_enabled());
+        }
     }
 
 
@@ -1712,7 +1718,12 @@ static int htab_save_iterate(QEMUFile *f, void *opaque)
     int rc = 0;
 
     /* Iteration header */
-    qemu_put_be32(f, 0);
+    if (!spapr->htab_shift) {
+        qemu_put_be32(f, -1);
+        return 0;
+    } else {
+        qemu_put_be32(f, 0);
+    }
 
     if (!spapr->htab) {
         assert(kvm_enabled());
@@ -1746,7 +1757,12 @@ static int htab_save_complete(QEMUFile *f, void *opaque)
     int fd;
 
     /* Iteration header */
-    qemu_put_be32(f, 0);
+    if (!spapr->htab_shift) {
+        qemu_put_be32(f, -1);
+        return 0;
+    } else {
+        qemu_put_be32(f, 0);
+    }
 
     if (!spapr->htab) {
         int rc;
@@ -1790,6 +1806,11 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
 
     section_hdr = qemu_get_be32(f);
 
+    if (section_hdr == -1) {
+        spapr_free_hpt(spapr);
+        return 0;
+    }
+
     if (section_hdr) {
         Error *local_err = NULL;
 
-- 
2.9.4

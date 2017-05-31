Received: from eggs.gnu.org ([2001:4830:134:3::10]:37732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dG1n9-0004Pm-RX
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dG1n6-0001J2-NL
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:27:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dG1n6-0001Gw-Dw
	for qemu-devel@nongnu.org; Wed, 31 May 2017 07:27:52 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4VBPPxV087368
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:27:51 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2asvxa8222-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:27:51 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 31 May 2017 21:27:48 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 31 May 2017 16:56:44 +0530
In-Reply-To: <1496230005-12265-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1496230005-12265-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1496230005-12265-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 1/2] spapr: Add a "no HPT" encoding to HTAB
 migration stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

Add a "no HPT" encoding (using value -1) to the HTAB migration
stream (in the place of HPT size) when the guest doesn't allocate HPT.
This will help the target side to match target HPT with the source HPT
and thus enable successful migration.

A few more fixes to enable TCG migration to work correctly are also
included in this commit:

- HTAB savevm handlers have a few asserts on kvm_enabled() when
  spapr->htab != 0. Convert these into conditional checks as it is now
  possible to have no HTAB with TCG radix guests.
- htab_save_setup() asserts for kvm_enabled() when spapr->htab != 0.
  Remove this as we can't assert this for TCG radix guests.

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
              [no HPT encoding suggestion]
Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ab3aab1..b589ed4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1559,17 +1559,18 @@ static int htab_save_setup(QEMUFile *f, void *opaque)
 {
     sPAPRMachineState *spapr = opaque;
 
-    /* "Iteration" header */
-    qemu_put_be32(f, spapr->htab_shift);
+    /* "Iteration" header: no-HPT or HPT size encoding */
+    if (!spapr->htab_shift) {
+        qemu_put_be32(f, -1);
+    } else {
+        qemu_put_be32(f, spapr->htab_shift);
+    }
 
     if (spapr->htab) {
         spapr->htab_save_index = 0;
         spapr->htab_first_pass = true;
-    } else {
-        assert(kvm_enabled());
     }
 
-
     return 0;
 }
 
@@ -1714,9 +1715,7 @@ static int htab_save_iterate(QEMUFile *f, void *opaque)
     /* Iteration header */
     qemu_put_be32(f, 0);
 
-    if (!spapr->htab) {
-        assert(kvm_enabled());
-
+    if (!spapr->htab && kvm_enabled()) {
         fd = get_htab_fd(spapr);
         if (fd < 0) {
             return fd;
@@ -1748,7 +1747,7 @@ static int htab_save_complete(QEMUFile *f, void *opaque)
     /* Iteration header */
     qemu_put_be32(f, 0);
 
-    if (!spapr->htab) {
+    if (!spapr->htab && kvm_enabled()) {
         int rc;
 
         assert(kvm_enabled());
@@ -1793,6 +1792,12 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
     if (section_hdr) {
         Error *local_err = NULL;
 
+        if (section_hdr == -1) {
+            spapr_free_hpt(spapr);
+            unregister_savevm(NULL, "spapr/htab", spapr);
+            return 0;
+        }
+
         /* First section gives the htab size */
         spapr_reallocate_hpt(spapr, section_hdr, &local_err);
         if (local_err) {
@@ -1802,9 +1807,7 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
         return 0;
     }
 
-    if (!spapr->htab) {
-        assert(kvm_enabled());
-
+    if (!spapr->htab && kvm_enabled()) {
         fd = kvmppc_get_htab_fd(true);
         if (fd < 0) {
             error_report("Unable to open fd to restore KVM hash table: %s",
@@ -1843,7 +1846,7 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
                 memset(HPTE(spapr->htab, index + n_valid), 0,
                        HASH_PTE_SIZE_64 * n_invalid);
             }
-        } else {
+        } else if (kvm_enabled()) {
             int rc;
 
             assert(fd >= 0);
@@ -1855,7 +1858,7 @@ static int htab_load(QEMUFile *f, void *opaque, int version_id)
         }
     }
 
-    if (!spapr->htab) {
+    if (!spapr->htab && kvm_enabled()) {
         assert(fd >= 0);
         close(fd);
     }
-- 
2.7.4

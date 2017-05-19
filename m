Received: from eggs.gnu.org ([2001:4830:134:3::10]:56131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBafh-0007hI-1v
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dBafd-0005Z8-W1
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dBafd-0005Yr-Mo
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:41:49 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4J5f51l141793
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 01:41:48 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahmq651u4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 01:41:48 -0400
Received: from localhost
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Fri, 19 May 2017 15:41:45 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Fri, 19 May 2017 11:10:37 +0530
In-Reply-To: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1495172439-1504-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 2/4] spapr: Unregister HPT savevm
 handlers for radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

HPT gets created by default for TCG guests and later when the guest turns
out to be a radix guest, the HPT is destroyed when guest does
H_REGISTER_PROC_TBL hcall. Let HTAB savevm handlers registration and
unregistration follow the same model so that we don't end up having
unrequired HTAB savevm handlers for radix guests.

This also ensures that HTAB savevm handlers seemlessly get destroyed and
recreated like HTAB itself when hash guest reboots.

HTAB savevm handlers registration/unregistration is now done from
spapr_reallocate_hpt() which itself is called from one of the
savevm_htab_handlers.htab_load(). To cater to this circular dependency
spapr_reallocate_hpt() is made global.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         | 99 +++++++++++++++++++++++++-------------------------
 include/hw/ppc/spapr.h |  2 +
 2 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91f7434..daf335c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1233,53 +1233,7 @@ void spapr_free_hpt(sPAPRMachineState *spapr)
     spapr->htab = NULL;
     spapr->htab_shift = 0;
     close_htab_fd(spapr);
-}
-
-static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
-                                 Error **errp)
-{
-    long rc;
-
-    /* Clean up any HPT info from a previous boot */
-    spapr_free_hpt(spapr);
-
-    rc = kvmppc_reset_htab(shift);
-    if (rc < 0) {
-        /* kernel-side HPT needed, but couldn't allocate one */
-        error_setg_errno(errp, errno,
-                         "Failed to allocate KVM HPT of order %d (try smaller maxmem?)",
-                         shift);
-        /* This is almost certainly fatal, but if the caller really
-         * wants to carry on with shift == 0, it's welcome to try */
-    } else if (rc > 0) {
-        /* kernel-side HPT allocated */
-        if (rc != shift) {
-            error_setg(errp,
-                       "Requested order %d HPT, but kernel allocated order %ld (try smaller maxmem?)",
-                       shift, rc);
-        }
-
-        spapr->htab_shift = shift;
-        spapr->htab = NULL;
-    } else {
-        /* kernel-side HPT not needed, allocate in userspace instead */
-        size_t size = 1ULL << shift;
-        int i;
-
-        spapr->htab = qemu_memalign(size, size);
-        if (!spapr->htab) {
-            error_setg_errno(errp, errno,
-                             "Could not allocate HPT of order %d", shift);
-            return;
-        }
-
-        memset(spapr->htab, 0, size);
-        spapr->htab_shift = shift;
-
-        for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
-            DIRTY_HPTE(HPTE(spapr->htab, i));
-        }
-    }
+    unregister_savevm_live(NULL, "spapr/htab", spapr);
 }
 
 void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
@@ -1879,6 +1833,55 @@ static SaveVMHandlers savevm_htab_handlers = {
     .load_state = htab_load,
 };
 
+void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
+                                 Error **errp)
+{
+    long rc;
+
+    /* Clean up any HPT info from a previous boot */
+    spapr_free_hpt(spapr);
+
+    rc = kvmppc_reset_htab(shift);
+    if (rc < 0) {
+        /* kernel-side HPT needed, but couldn't allocate one */
+        error_setg_errno(errp, errno,
+                         "Failed to allocate KVM HPT of order %d (try smaller maxmem?)",
+                         shift);
+        /* This is almost certainly fatal, but if the caller really
+         * wants to carry on with shift == 0, it's welcome to try */
+    } else if (rc > 0) {
+        /* kernel-side HPT allocated */
+        if (rc != shift) {
+            error_setg(errp,
+                       "Requested order %d HPT, but kernel allocated order %ld (try smaller maxmem?)",
+                       shift, rc);
+        }
+
+        spapr->htab_shift = shift;
+        spapr->htab = NULL;
+    } else {
+        /* kernel-side HPT not needed, allocate in userspace instead */
+        size_t size = 1ULL << shift;
+        int i;
+
+        spapr->htab = qemu_memalign(size, size);
+        if (!spapr->htab) {
+            error_setg_errno(errp, errno,
+                             "Could not allocate HPT of order %d", shift);
+            return;
+        }
+
+        memset(spapr->htab, 0, size);
+        spapr->htab_shift = shift;
+
+        for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
+            DIRTY_HPTE(HPTE(spapr->htab, i));
+        }
+    }
+    register_savevm_live(NULL, "spapr/htab", -1, 1,
+                         &savevm_htab_handlers, spapr);
+}
+
 static void spapr_boot_set(void *opaque, const char *boot_device,
                            Error **errp)
 {
@@ -2341,8 +2344,6 @@ static void ppc_spapr_init(MachineState *machine)
      * interface, this is a legacy from the sPAPREnvironment structure
      * which predated MachineState but had a similar function */
     vmstate_register(NULL, 0, &vmstate_spapr, spapr);
-    register_savevm_live(NULL, "spapr/htab", -1, 1,
-                         &savevm_htab_handlers, spapr);
 
     /* used by RTAS */
     QTAILQ_INIT(&spapr->ccs_list);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f875dc4..e581c4a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -637,6 +637,8 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
                                                uint32_t count, uint32_t index);
 void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
                                     sPAPRMachineState *spapr);
+void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
+                                 Error **errp);
 
 /* rtas-configure-connector state */
 struct sPAPRConfigureConnectorState {
-- 
2.7.4

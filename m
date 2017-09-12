Received: from eggs.gnu.org ([2001:4830:134:3::10]:52157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drtc6-000358-DF
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drtc1-0005ar-Sx
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:25:02 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:42428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drtc1-0005Za-JV
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 18:24:57 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 523D3AA673
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 00:24:56 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 13 Sep 2017 00:24:53 +0200
Message-ID: <150525509384.11068.12660058285712851211.stgit@bahia.lan>
In-Reply-To: <150525508489.11068.5231444460720976552.stgit@bahia.lan>
References: <150525508489.11068.5231444460720976552.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 1/2] spapr: introduce common helper to write
 HPT address to KVM PR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

When running with KVM PR, if a new HPT is allocated we need to inform
KVM about the HPT address and size. This is currently done with a hack
which is open-coded in several places.

This patch consolidate the code in a dedicated helper that records
the HPT address and size in the sPAPR context, and then does the
magic for KVM PR.

Note that ppc_spapr_reset() now resets all devices and CPUs before
allocating the HPT. This allows to drop the hack from spapr_cpu_reset().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c          |   31 ++++++++++++++++++++++++++-----
 hw/ppc/spapr_cpu_core.c |   15 ---------------
 hw/ppc/spapr_hcall.c    |   16 +---------------
 include/hw/ppc/spapr.h  |    1 +
 4 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f680f28a15ea..97f8afdbd7fe 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1309,6 +1309,25 @@ void spapr_free_hpt(sPAPRMachineState *spapr)
     close_htab_fd(spapr);
 }
 
+void spapr_install_hpt(sPAPRMachineState *spapr, void *htab, uint32_t shift)
+{
+    assert(htab);
+
+    spapr->htab = htab;
+    spapr->htab_shift = shift;
+
+    /*
+     * This is a hack for the benefit of KVM PR - it abuses the SDR1
+     * slot in kvm_sregs to communicate the userspace address of the
+     * HPT
+     */
+    if (kvm_enabled()) {
+        target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
+            | (spapr->htab_shift - 18);
+        kvmppc_update_sdr1(sdr1);
+    }
+}
+
 void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
                           Error **errp)
 {
@@ -1339,16 +1358,17 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
         /* kernel-side HPT not needed, allocate in userspace instead */
         size_t size = 1ULL << shift;
         int i;
+        void *htab;
 
-        spapr->htab = qemu_memalign(size, size);
-        if (!spapr->htab) {
+        htab = qemu_memalign(size, size);
+        if (!htab) {
             error_setg_errno(errp, errno,
                              "Could not allocate HPT of order %d", shift);
             return;
         }
 
-        memset(spapr->htab, 0, size);
-        spapr->htab_shift = shift;
+        memset(htab, 0, size);
+        spapr_install_hpt(spapr, htab, shift);
 
         for (i = 0; i < size / HASH_PTE_SIZE_64; i++) {
             DIRTY_HPTE(HPTE(spapr->htab, i));
@@ -1405,6 +1425,8 @@ static void ppc_spapr_reset(void)
     /* Check for unknown sysbus devices */
     foreach_dynamic_sysbus_device(find_unknown_sysbus_device, NULL);
 
+    qemu_devices_reset();
+
     if (kvm_enabled() && kvmppc_has_cap_mmu_radix()) {
         /* If using KVM with radix mode available, VCPUs can be started
          * without a HPT because KVM will start them in radix mode.
@@ -1414,7 +1436,6 @@ static void ppc_spapr_reset(void)
         spapr_setup_hpt_and_vrma(spapr);
     }
 
-    qemu_devices_reset();
     spapr_clear_pending_events(spapr);
 
     /*
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index c08ee7571a50..c20b5c64b045 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -73,7 +73,6 @@ void spapr_cpu_parse_features(sPAPRMachineState *spapr)
 
 static void spapr_cpu_reset(void *opaque)
 {
-    sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     PowerPCCPU *cpu = opaque;
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
@@ -86,20 +85,6 @@ static void spapr_cpu_reset(void *opaque)
     cs->halted = 1;
 
     env->spr[SPR_HIOR] = 0;
-
-    /*
-     * This is a hack for the benefit of KVM PR - it abuses the SDR1
-     * slot in kvm_sregs to communicate the userspace address of the
-     * HPT
-     */
-    if (kvm_enabled()) {
-        env->spr[SPR_SDR1] = (target_ulong)(uintptr_t)spapr->htab
-            | (spapr->htab_shift - 18);
-        if (kvmppc_put_books_sregs(cpu) < 0) {
-            error_report("Unable to update SDR1 in KVM");
-            exit(1);
-        }
-    }
 }
 
 static void spapr_cpu_destroy(PowerPCCPU *cpu)
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 57bb411394ed..7892cd3e7ffa 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -730,15 +730,7 @@ static target_ulong h_resize_hpt_commit(PowerPCCPU *cpu,
                     pending->hpt, newsize);
     if (rc == H_SUCCESS) {
         qemu_vfree(spapr->htab);
-        spapr->htab = pending->hpt;
-        spapr->htab_shift = pending->shift;
-
-        if (kvm_enabled()) {
-            /* For KVM PR, update the HPT pointer */
-            target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                | (spapr->htab_shift - 18);
-            kvmppc_update_sdr1(sdr1);
-        }
+        spapr_install_hpt(spapr, pending->hpt, pending->shift);
 
         pending->hpt = NULL; /* so it's not free()d */
     }
@@ -1564,12 +1556,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
              * the point this is called, nothing should have been
              * entered into the existing HPT */
             spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
-            if (kvm_enabled()) {
-                /* For KVM PR, update the HPT pointer */
-                target_ulong sdr1 = (target_ulong)(uintptr_t)spapr->htab
-                    | (spapr->htab_shift - 18);
-                kvmppc_update_sdr1(sdr1);
-            }
         }
     }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c1b365f56431..30e5805acca4 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -709,4 +709,5 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_on_cpu_data arg);
 int spapr_vcpu_id(PowerPCCPU *cpu);
 PowerPCCPU *spapr_find_cpu(int vcpu_id);
 
+void spapr_install_hpt(sPAPRMachineState *spapr, void *htab, uint32_t shift);
 #endif /* HW_SPAPR_H */

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRhA-00058A-M7
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eKRh8-00038I-Er
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 11:28:16 -0500
From: David Hildenbrand <david@redhat.com>
Date: Thu, 30 Nov 2017 17:27:33 +0100
Message-Id: <20171130162744.25442-6-david@redhat.com>
In-Reply-To: <20171130162744.25442-1-david@redhat.com>
References: <20171130162744.25442-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.12 05/16] s390x/pci: pass the retaddr
 to all PCI instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

Once we wire up TCG, we will need the retaddr to correctly inject
program interrupts. As we want to get rid of the function
program_interrupt(), convert PCI code too.

For KVM, we can simply use RA_IGNORED.

Convert program_interrupt() to s390_program_interrupt() directly, making
use of the passed address.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-inst.c | 83 +++++++++++++++++++++++++-----------------------
 hw/s390x/s390-pci-inst.h | 16 ++++++----
 target/s390x/kvm.c       | 14 ++++----
 3 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 8e088f3dc9..8123705dfd 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -142,7 +142,7 @@ out:
     return rc;
 }
 
-int clp_service_call(S390CPU *cpu, uint8_t r2)
+int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
 {
     ClpReqHdr *reqh;
     ClpRspHdr *resh;
@@ -158,7 +158,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2)
     cpu_synchronize_state(CPU(cpu));
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, 4);
+        s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
         return 0;
     }
 
@@ -168,7 +168,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2)
     reqh = (ClpReqHdr *)buffer;
     req_len = lduw_p(&reqh->len);
     if (req_len < 16 || req_len > 8184 || (req_len % 8 != 0)) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return 0;
     }
 
@@ -179,11 +179,11 @@ int clp_service_call(S390CPU *cpu, uint8_t r2)
     resh = (ClpRspHdr *)(buffer + req_len);
     res_len = lduw_p(&resh->len);
     if (res_len < 8 || res_len > 8176 || (res_len % 8 != 0)) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return 0;
     }
     if ((req_len + res_len) > 8192) {
-        program_interrupt(env, PGM_OPERAND, 4);
+        s390_program_interrupt(env, PGM_OPERAND, 4, ra);
         return 0;
     }
 
@@ -314,7 +314,7 @@ out:
     return 0;
 }
 
-int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
+int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     S390PCIBusDevice *pbdev;
@@ -329,12 +329,12 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     cpu_synchronize_state(CPU(cpu));
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, 4);
+        s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
         return 0;
     }
 
     if (r2 & 0x1) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         return 0;
     }
 
@@ -367,19 +367,19 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
 
     if (pcias < 6) {
         if ((8 - (offset & 0x7)) < len) {
-            program_interrupt(env, PGM_OPERAND, 4);
+            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
         mr = pbdev->pdev->io_regions[pcias].memory;
         result = memory_region_dispatch_read(mr, offset, &data, len,
                                              MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
-            program_interrupt(env, PGM_OPERAND, 4);
+            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
     } else if (pcias == 15) {
         if ((4 - (offset & 0x3)) < len) {
-            program_interrupt(env, PGM_OPERAND, 4);
+            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
         data =  pci_host_config_read_common(
@@ -398,7 +398,7 @@ int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
             data = bswap64(data);
             break;
         default:
-            program_interrupt(env, PGM_OPERAND, 4);
+            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
     } else {
@@ -425,7 +425,7 @@ static int trap_msix(S390PCIBusDevice *pbdev, uint64_t offset, uint8_t pcias)
     }
 }
 
-int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
+int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     uint64_t offset, data;
@@ -439,12 +439,12 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     cpu_synchronize_state(CPU(cpu));
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, 4);
+        s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
         return 0;
     }
 
     if (r2 & 0x1) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         return 0;
     }
 
@@ -478,7 +478,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     data = env->regs[r1];
     if (pcias < 6) {
         if ((8 - (offset & 0x7)) < len) {
-            program_interrupt(env, PGM_OPERAND, 4);
+            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
 
@@ -492,12 +492,12 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
         result = memory_region_dispatch_write(mr, offset, data, len,
                                      MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
-            program_interrupt(env, PGM_OPERAND, 4);
+            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
     } else if (pcias == 15) {
         if ((4 - (offset & 0x3)) < len) {
-            program_interrupt(env, PGM_OPERAND, 4);
+            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
         switch (len) {
@@ -513,7 +513,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
             data = bswap64(data);
             break;
         default:
-            program_interrupt(env, PGM_OPERAND, 4);
+            s390_program_interrupt(env, PGM_OPERAND, 4, ra);
             return 0;
         }
 
@@ -531,7 +531,7 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     return 0;
 }
 
-int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
+int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     uint32_t fh;
@@ -545,12 +545,12 @@ int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2)
     cpu_synchronize_state(CPU(cpu));
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, 4);
+        s390_program_interrupt(env, PGM_PRIVILEGED, 4, ra);
         goto out;
     }
 
     if (r2 & 0x1) {
-        program_interrupt(env, PGM_SPECIFICATION, 4);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 4, ra);
         goto out;
     }
 
@@ -624,7 +624,7 @@ out:
 }
 
 int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
-                        uint8_t ar)
+                        uint8_t ar, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     S390PCIBusDevice *pbdev;
@@ -637,7 +637,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     uint8_t buffer[128];
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, 6);
+        s390_program_interrupt(env, PGM_PRIVILEGED, 6, ra);
         return 0;
     }
 
@@ -659,7 +659,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     case 128:
         break;
     default:
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
         return 0;
     }
 
@@ -687,7 +687,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
 
     mr = pbdev->pdev->io_regions[pcias].memory;
     if (!memory_region_access_valid(mr, env->regs[r3], len, true)) {
-        program_interrupt(env, PGM_OPERAND, 6);
+        s390_program_interrupt(env, PGM_OPERAND, 6, ra);
         return 0;
     }
 
@@ -700,7 +700,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
                                      ldq_p(buffer + i * 8), 8,
                                      MEMTXATTRS_UNSPECIFIED);
         if (result != MEMTX_OK) {
-            program_interrupt(env, PGM_OPERAND, 6);
+            s390_program_interrupt(env, PGM_OPERAND, 6, ra);
             return 0;
         }
     }
@@ -767,7 +767,8 @@ int pci_dereg_irqs(S390PCIBusDevice *pbdev)
     return 0;
 }
 
-static int reg_ioat(CPUS390XState *env, S390PCIIOMMU *iommu, ZpciFib fib)
+static int reg_ioat(CPUS390XState *env, S390PCIIOMMU *iommu, ZpciFib fib,
+                    uintptr_t ra)
 {
     uint64_t pba = ldq_p(&fib.pba);
     uint64_t pal = ldq_p(&fib.pal);
@@ -776,14 +777,14 @@ static int reg_ioat(CPUS390XState *env, S390PCIIOMMU *iommu, ZpciFib fib)
     uint8_t t = (g_iota >> 11) & 0x1;
 
     if (pba > pal || pba < ZPCI_SDMA_ADDR || pal > ZPCI_EDMA_ADDR) {
-        program_interrupt(env, PGM_OPERAND, 6);
+        s390_program_interrupt(env, PGM_OPERAND, 6, ra);
         return -EINVAL;
     }
 
     /* currently we only support designation type 1 with translation */
     if (!(dt == ZPCI_IOTA_RTTO && t)) {
         error_report("unsupported ioat dt %d t %d", dt, t);
-        program_interrupt(env, PGM_OPERAND, 6);
+        s390_program_interrupt(env, PGM_OPERAND, 6, ra);
         return -EINVAL;
     }
 
@@ -804,7 +805,8 @@ void pci_dereg_ioat(S390PCIIOMMU *iommu)
     iommu->g_iota = 0;
 }
 
-int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
+int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
+                        uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     uint8_t oc, dmaas;
@@ -814,7 +816,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
     uint64_t cc = ZPCI_PCI_LS_OK;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, 6);
+        s390_program_interrupt(env, PGM_PRIVILEGED, 6, ra);
         return 0;
     }
 
@@ -823,7 +825,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
     fh = env->regs[r1] >> 32;
 
     if (fiba & 0x7) {
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
         return 0;
     }
 
@@ -850,7 +852,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
     }
 
     if (fib.fmt != 0) {
-        program_interrupt(env, PGM_OPERAND, 6);
+        s390_program_interrupt(env, PGM_OPERAND, 6, ra);
         return 0;
     }
 
@@ -879,7 +881,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
         } else if (pbdev->iommu->enabled) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
-        } else if (reg_ioat(env, pbdev->iommu, fib)) {
+        } else if (reg_ioat(env, pbdev->iommu, fib, ra)) {
             cc = ZPCI_PCI_LS_ERR;
             s390_set_status_code(env, r1, ZPCI_MOD_ST_INSUF_RES);
         }
@@ -904,7 +906,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
             s390_set_status_code(env, r1, ZPCI_MOD_ST_SEQUENCE);
         } else {
             pci_dereg_ioat(pbdev->iommu);
-            if (reg_ioat(env, pbdev->iommu, fib)) {
+            if (reg_ioat(env, pbdev->iommu, fib, ra)) {
                 cc = ZPCI_PCI_LS_ERR;
                 s390_set_status_code(env, r1, ZPCI_MOD_ST_INSUF_RES);
             }
@@ -935,7 +937,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
         pbdev->fmb_addr = ldq_p(&fib.fmb_addr);
         break;
     default:
-        program_interrupt(&cpu->env, PGM_OPERAND, 6);
+        s390_program_interrupt(&cpu->env, PGM_OPERAND, 6, ra);
         cc = ZPCI_PCI_LS_ERR;
     }
 
@@ -943,7 +945,8 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
     return 0;
 }
 
-int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
+int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
+                         uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
     uint8_t dmaas;
@@ -954,7 +957,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
     uint64_t cc = ZPCI_PCI_LS_OK;
 
     if (env->psw.mask & PSW_MASK_PSTATE) {
-        program_interrupt(env, PGM_PRIVILEGED, 6);
+        s390_program_interrupt(env, PGM_PRIVILEGED, 6, ra);
         return 0;
     }
 
@@ -968,7 +971,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar)
     }
 
     if (fiba & 0x7) {
-        program_interrupt(env, PGM_SPECIFICATION, 6);
+        s390_program_interrupt(env, PGM_SPECIFICATION, 6, ra);
         return 0;
     }
 
diff --git a/hw/s390x/s390-pci-inst.h b/hw/s390x/s390-pci-inst.h
index 94a959f91c..93ef290101 100644
--- a/hw/s390x/s390-pci-inst.h
+++ b/hw/s390x/s390-pci-inst.h
@@ -293,13 +293,15 @@ typedef struct ZpciFib {
 
 int pci_dereg_irqs(S390PCIBusDevice *pbdev);
 void pci_dereg_ioat(S390PCIIOMMU *iommu);
-int clp_service_call(S390CPU *cpu, uint8_t r2);
-int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2);
-int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2);
-int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2);
+int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra);
+int pcilg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
+int pcistg_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
+int rpcit_service_call(S390CPU *cpu, uint8_t r1, uint8_t r2, uintptr_t ra);
 int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
-                        uint8_t ar);
-int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar);
-int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar);
+                        uint8_t ar, uintptr_t ra);
+int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
+                        uintptr_t ra);
+int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
+                         uintptr_t ra);
 
 #endif
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index b3ed3db2c2..fb20435e50 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1230,7 +1230,7 @@ static int kvm_clp_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
     if (s390_has_feat(S390_FEAT_ZPCI)) {
-        return clp_service_call(cpu, r2);
+        return clp_service_call(cpu, r2, RA_IGNORED);
     } else {
         return -1;
     }
@@ -1242,7 +1242,7 @@ static int kvm_pcilg_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
     if (s390_has_feat(S390_FEAT_ZPCI)) {
-        return pcilg_service_call(cpu, r1, r2);
+        return pcilg_service_call(cpu, r1, r2, RA_IGNORED);
     } else {
         return -1;
     }
@@ -1254,7 +1254,7 @@ static int kvm_pcistg_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
     if (s390_has_feat(S390_FEAT_ZPCI)) {
-        return pcistg_service_call(cpu, r1, r2);
+        return pcistg_service_call(cpu, r1, r2, RA_IGNORED);
     } else {
         return -1;
     }
@@ -1270,7 +1270,7 @@ static int kvm_stpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
         cpu_synchronize_state(CPU(cpu));
         fiba = get_base_disp_rxy(cpu, run, &ar);
 
-        return stpcifc_service_call(cpu, r1, fiba, ar);
+        return stpcifc_service_call(cpu, r1, fiba, ar, RA_IGNORED);
     } else {
         return -1;
     }
@@ -1302,7 +1302,7 @@ static int kvm_rpcit_service_call(S390CPU *cpu, struct kvm_run *run)
     uint8_t r2 = (run->s390_sieic.ipb & 0x000f0000) >> 16;
 
     if (s390_has_feat(S390_FEAT_ZPCI)) {
-        return rpcit_service_call(cpu, r1, r2);
+        return rpcit_service_call(cpu, r1, r2, RA_IGNORED);
     } else {
         return -1;
     }
@@ -1319,7 +1319,7 @@ static int kvm_pcistb_service_call(S390CPU *cpu, struct kvm_run *run)
         cpu_synchronize_state(CPU(cpu));
         gaddr = get_base_disp_rsy(cpu, run, &ar);
 
-        return pcistb_service_call(cpu, r1, r3, gaddr, ar);
+        return pcistb_service_call(cpu, r1, r3, gaddr, ar, RA_IGNORED);
     } else {
         return -1;
     }
@@ -1335,7 +1335,7 @@ static int kvm_mpcifc_service_call(S390CPU *cpu, struct kvm_run *run)
         cpu_synchronize_state(CPU(cpu));
         fiba = get_base_disp_rxy(cpu, run, &ar);
 
-        return mpcifc_service_call(cpu, r1, fiba, ar);
+        return mpcifc_service_call(cpu, r1, fiba, ar, RA_IGNORED);
     } else {
         return -1;
     }
-- 
2.14.3

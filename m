Received: from eggs.gnu.org ([2001:4830:134:3::10]:47040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dWxTB-0006Mj-NB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dWxT7-0004Bf-6k
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:17:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dWxT6-000488-TM
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:17:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6H4DckZ088293
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 00:17:10 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bqdcrbx22-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 00:17:10 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Mon, 17 Jul 2017 14:17:08 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Mon, 17 Jul 2017 09:46:39 +0530
Message-Id: <20170717041639.16137-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3] spapr: disable decrementer during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.

When reset happens, all the CPUs are in halted state. First CPU is brought out
of reset and secondary CPUs would be initialized by the guest kernel using a
rtas call start-cpu.

However, in case of TCG, decrementer interrupts keep on coming and waking the
secondary CPUs up.

These secondary CPUs would see the decrementer interrupt pending, which makes
cpu::has_work() to bring them out of wait loop and start executing
tcg_exec_cpu().

The problem with this is all the CPUs wake up and start booting SLOF image,
causing the following exception(4 CPUs TCG VM):

[   81.440850] reboot: Restarting system

SLOF
S
SLOF
SLOFLOF[0[0m **********************************************************************
QEMU Starting
 Build Date = Mar  3 2017 13:29:19
 FW Version = git-66d250ef0fd06bb8
[0m **********************************************************************
QEMU Starting
 Build Date = Mar  3 2017 13:29:19
 FW Version = git-66d250ef0fd06bb8
[0m *************************************m**********[?25l **********************************************************************
QEMU Starting
 Build Date = Mar  3 2017 13:29:19
 FW Version = git-66d250ef0fd06bb8
***********************
QEMU Starting
 Build Date = Mar  3 2017 13:29:19
 FW Version = git-66d250ef0fd06bb8
ERROR: Flatten device tree not available!

 exception 300
SRR0 = 00000000000060e4  SRR1 = 800000008000000000000000
SPRG2 = 0000000000400000  SPRG3 = 0000000000004bd8
ERROR: Flatten device tree not available!

 exception 300
SRR0 = 00000000000060e4  SRR1 = 800000008000000000000000
SPRG2 = 0000000000400000  SPRG3 = 0000000000004bd8

During reset, disable decrementer interrupt for secondary CPUs and enable them
when the secondary CPUs are brought online by rtas start-cpu call.

Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---
 hw/ppc/spapr_cpu_core.c | 9 +++++++++
 hw/ppc/spapr_rtas.c     | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index ea278ce..bbfe8c2 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -87,6 +87,15 @@ static void spapr_cpu_reset(void *opaque)
 
     env->spr[SPR_HIOR] = 0;
 
+    /* Disable DECR for secondary cpus */
+    if (cs != first_cpu) {
+        if (env->mmu_model == POWERPC_MMU_3_00) {
+            env->spr[SPR_LPCR] &= ~LPCR_DEE;
+        } else {
+            /* P7 and P8 both have same bit for DECR */
+            env->spr[SPR_LPCR] &= ~LPCR_P8_PECE3;
+        }
+    }
     /*
      * This is a hack for the benefit of KVM PR - it abuses the SDR1
      * slot in kvm_sregs to communicate the userspace address of the
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 94a2799..4623d1d 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -174,6 +174,14 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
         kvm_cpu_synchronize_state(cs);
 
         env->msr = (1ULL << MSR_SF) | (1ULL << MSR_ME);
+
+        /* Enable DECR interrupt */
+        if (env->mmu_model == POWERPC_MMU_3_00) {
+            env->spr[SPR_LPCR] |= LPCR_DEE;
+        } else {
+            /* P7 and P8 both have same bit for DECR */
+            env->spr[SPR_LPCR] |= LPCR_P8_PECE3;
+        }
         env->nip = start;
         env->gpr[3] = r3;
         cs->halted = 0;
-- 
2.9.3

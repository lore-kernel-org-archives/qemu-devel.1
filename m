Received: from eggs.gnu.org ([2001:4830:134:3::10]:50581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dIr3g-00083Q-Jm
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj@linux.vnet.ibm.com>) id 1dIr3d-0006Db-F3
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:36:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nikunj@linux.vnet.ibm.com>)
	id 1dIr3d-0006DT-4l
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 02:36:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v586YU16015074
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 02:36:35 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2axvmx2xuh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 02:36:34 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <nikunj@linux.vnet.ibm.com>;
	Thu, 8 Jun 2017 16:36:32 +1000
From: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Date: Thu,  8 Jun 2017 12:06:08 +0530
Message-Id: <20170608063608.17855-1-nikunj@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC] spapr: ignore interrupts during reset state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, rth@twiddle.net, alex.bennee@linaro.org, bharata@linux.vnet.ibm.com, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

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

Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
---

Note: Similar changes would be required for powernv as well.
Haven't got time to test it there.

---
 hw/ppc/spapr.c              | 1 +
 hw/ppc/spapr_cpu_core.c     | 1 +
 hw/ppc/spapr_rtas.c         | 1 +
 target/ppc/cpu.h            | 7 +++++++
 target/ppc/translate_init.c | 9 +++++++++
 5 files changed, 19 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 01dda9e..fba2ef5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1370,6 +1370,7 @@ static void ppc_spapr_reset(void)
     first_ppc_cpu->env.gpr[3] = fdt_addr;
     first_ppc_cpu->env.gpr[5] = 0;
     first_cpu->halted = 0;
+    first_ppc_cpu->env.in_reset = 0;
     first_ppc_cpu->env.nip = SPAPR_ENTRY_POINT;
 
     spapr->cas_reboot = false;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 029a141..c100213 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -33,6 +33,7 @@ static void spapr_cpu_reset(void *opaque)
      * reset code and the rest are explicitly started up by the guest
      * using an RTAS call */
     cs->halted = 1;
+    env->in_reset = 1;
 
     env->spr[SPR_HIOR] = 0;
 
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 94a2799..eaf0afb 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -177,6 +177,7 @@ static void rtas_start_cpu(PowerPCCPU *cpu_, sPAPRMachineState *spapr,
         env->nip = start;
         env->gpr[3] = r3;
         cs->halted = 0;
+        env->in_reset = 0;
         spapr_cpu_set_endianness(cpu);
         spapr_cpu_update_tb_offset(cpu);
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d10808d..eb88bcb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1013,6 +1013,13 @@ struct CPUPPCState {
     int access_type; /* when a memory exception occurs, the access
                         type is stored here */
 
+    /* CPU in reset, shouldn't process any interrupts.
+     *
+     * Decrementer interrupts in TCG can still wake the CPU up. Make sure that
+     * when this variable is set, cpu_has_work_* should return false.
+     */
+    int in_reset;
+
     CPU_COMMON
 
     /* MMU context - only relevant for full system emulation */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 56a0ab2..64f4348 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8561,6 +8561,9 @@ static bool cpu_has_work_POWER7(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cs->halted) {
+        if (env->in_reset) {
+            return false;
+        }
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
@@ -8718,6 +8721,9 @@ static bool cpu_has_work_POWER8(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cs->halted) {
+        if (env->in_reset) {
+            return false;
+        }
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
@@ -8899,6 +8905,9 @@ static bool cpu_has_work_POWER9(CPUState *cs)
     CPUPPCState *env = &cpu->env;
 
     if (cs->halted) {
+        if (env->in_reset) {
+            return false;
+        }
         if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
             return false;
         }
-- 
2.9.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4D9q-0002Kq-Jj
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4D9n-0007d6-E1
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:10:30 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4D9n-0007cm-5b
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 17:10:27 -0400
Received: by mail-pf0-x241.google.com with SMTP id o68so3871pfj.2
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 14:10:27 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Sat, 29 Apr 2017 06:10:18 +0900
Message-Id: <20170428211018.2927-1-shorne@gmail.com>
Subject: [Qemu-devel] [PATCH] target/openrisc: Support non-busy idle state
 using PMR SPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Richard Henderson <rth@twiddle.net>, Stafford Horne <shorne@gmail.com>

The OpenRISC architecture has the Power Management Register (PMR)
special purpose register to manage cpu power states.  The interesting
modes are:

 * Doze Mode (DME) - Stop cpu except timer & pic - wake on interrupt
 * Sleep Mode (SME) - Stop cpu and all units - wake on interrupt
 * Suspend Model (SUME) - Stop cpu and all units - wake on reset

The linux kernel will set DME when idle.

This patch implements the PMR SPR and halts the qemu cpu when there is a
change to DME or SME.  This means that openrisc qemu in no longer peggs
a host cpu at 100%.

In order for this to work we need to kick the CPU when timers are
expired.  Update the cpu timer to kick the cpu upon each timer event.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---

Changes since last RFC - none

 hw/openrisc/cputimer.c       |  1 +
 target/openrisc/cpu.c        |  3 ++-
 target/openrisc/cpu.h        | 10 ++++++++++
 target/openrisc/interrupt.c  |  2 ++
 target/openrisc/machine.c    |  1 +
 target/openrisc/sys_helper.c | 13 +++++++++++++
 6 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/openrisc/cputimer.c b/hw/openrisc/cputimer.c
index a98c799..febc469 100644
--- a/hw/openrisc/cputimer.c
+++ b/hw/openrisc/cputimer.c
@@ -61,6 +61,7 @@ void cpu_openrisc_timer_update(OpenRISCCPU *cpu)
     }
     next = now + (uint64_t)wait * TIMER_PERIOD;
     timer_mod(cpu->env.timer, next);
+    qemu_cpu_kick(CPU(cpu));
 }
 
 void cpu_openrisc_count_start(OpenRISCCPU *cpu)
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index c9b3f22..1d6330c 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -51,7 +51,8 @@ static void openrisc_cpu_reset(CPUState *s)
     cpu->env.lock_addr = -1;
     s->exception_index = -1;
 
-    cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP;
+    cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP |
+                   UPR_PMP;
     cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2)) | (DMMUCFGR_NTS & (6 << 2));
     cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2)) | (IMMUCFGR_NTS & (6 << 2));
 
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 938ccc3..2721432 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -140,6 +140,15 @@ enum {
     IMMUCFGR_HTR = (1 << 11),
 };
 
+/* Power management register */
+enum {
+    PMR_SDF = (15 << 0),
+    PMR_DME = (1 << 4),
+    PMR_SME = (1 << 5),
+    PMR_DCGE = (1 << 6),
+    PMR_SUME = (1 << 7),
+};
+
 /* Float point control status register */
 enum {
     FPCSR_FPEE = 1,
@@ -284,6 +293,7 @@ typedef struct CPUOpenRISCState {
     uint32_t immucfgr;        /* IMMU configure register */
     uint32_t esr;             /* Exception supervisor register */
     uint32_t evbar;           /* Exception vector base address register */
+    uint32_t pmr;             /* Power Management Register */
     uint32_t fpcsr;           /* Float register */
     float_status fp_status;
 
diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 2c91fab..3959671 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -60,6 +60,8 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     env->sr |= SR_SM;
     env->sr &= ~SR_IEE;
     env->sr &= ~SR_TEE;
+    env->pmr &= ~PMR_DME;
+    env->pmr &= ~PMR_SME;
     env->tlb->cpu_openrisc_map_address_data = &cpu_openrisc_get_phys_nommu;
     env->tlb->cpu_openrisc_map_address_code = &cpu_openrisc_get_phys_nommu;
     env->lock_addr = -1;
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index a82be62..a20cce7 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -138,6 +138,7 @@ static const VMStateDescription vmstate_env = {
         VMSTATE_UINT32(dmmucfgr, CPUOpenRISCState),
         VMSTATE_UINT32(immucfgr, CPUOpenRISCState),
         VMSTATE_UINT32(evbar, CPUOpenRISCState),
+        VMSTATE_UINT32(pmr, CPUOpenRISCState),
         VMSTATE_UINT32(esr, CPUOpenRISCState),
         VMSTATE_UINT32(fpcsr, CPUOpenRISCState),
         VMSTATE_UINT64(mac, CPUOpenRISCState),
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index fa3d6a4..44acf0d 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exception.h"
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
@@ -141,6 +142,15 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
     case TO_SPR(5, 2):  /* MACHI */
         env->mac = deposit64(env->mac, 32, 32, rb);
         break;
+    case TO_SPR(8, 0):  /* PMR */
+        env->pmr = rb;
+        if (env->pmr & PMR_DME || env->pmr & PMR_SME) {
+            cpu_restore_state(cs, GETPC());
+            env->pc += 4;
+            cs->halted = 1;
+            raise_exception(cpu, EXCP_HLT);
+        }
+        break;
     case TO_SPR(9, 0):  /* PICMR */
         env->picmr |= rb;
         break;
@@ -287,6 +297,9 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
         return env->mac >> 32;
         break;
 
+    case TO_SPR(8, 0):  /* PMR */
+        return env->pmr;
+
     case TO_SPR(9, 0):  /* PICMR */
         return env->picmr;
 
-- 
2.9.3

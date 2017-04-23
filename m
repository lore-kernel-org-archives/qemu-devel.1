Received: from eggs.gnu.org ([2001:4830:134:3::10]:47625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d2PTA-0002Eu-Nm
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 17:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d2PT5-0004Ul-Rw
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 17:55:00 -0400
Received: from mail-it0-x243.google.com ([2607:f8b0:4001:c0b::243]:36770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d2PT5-0004Uh-MN
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 17:54:55 -0400
Received: by mail-it0-x243.google.com with SMTP id x188so10999412itb.3
	for <qemu-devel@nongnu.org>; Sun, 23 Apr 2017 14:54:55 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon, 24 Apr 2017 06:54:20 +0900
Message-Id: <20170423215420.27098-1-shorne@gmail.com>
In-Reply-To: <ab4f029c-8264-7d35-b0e0-9b35a8e80d9d@twiddle.net>
References: <ab4f029c-8264-7d35-b0e0-9b35a8e80d9d@twiddle.net>
Subject: [Qemu-devel] [PATCH RFC] target/openrisc: Support non-busy idle
 state using PMR SPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Development <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>, Stafford Horne <shorne@gmail.com>

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

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
(Sorry, resending this again, there was something wrong with my mail setup
on the last)

Hello,

This patch seems work fine but I am not sure if it is the right way to do
trigger the halt signal.  Should I do it via raising an interrupt or
exception and exitting the cpu?

Also, I don't know if its due to this patch of an issue with the timer
interrupts.  After applying this patch the timer interrupts do not trigger
until a keypress is make.  i.e. something like this...

  $ sleep 5
  <hangs forever until a key is pressed>

It may or may not be related to this patch as I noticed sometime things
like this happened before this patch.


 target/openrisc/cpu.c        |  3 ++-
 target/openrisc/cpu.h        | 10 ++++++++++
 target/openrisc/interrupt.c  |  2 ++
 target/openrisc/machine.c    |  1 +
 target/openrisc/sys_helper.c | 12 ++++++++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

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
index fa3d6a4..cb1e085 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -22,6 +22,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "exception.h"
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
@@ -141,6 +142,14 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
     case TO_SPR(5, 2):  /* MACHI */
         env->mac = deposit64(env->mac, 32, 32, rb);
         break;
+    case TO_SPR(8, 0):  /* PMR */
+        env->pmr = rb;
+        if (env->pmr & PMR_DME || env->pmr & PMR_SME) {
+            cpu_restore_state(cs, GETPC() + 4);
+            cs->halted = 1;
+            raise_exception(cpu, EXCP_HLT);
+        }
+        break;
     case TO_SPR(9, 0):  /* PICMR */
         env->picmr |= rb;
         break;
@@ -287,6 +296,9 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
         return env->mac >> 32;
         break;
 
+    case TO_SPR(8, 0):  /* PMR */
+        return env->pmr;
+
     case TO_SPR(9, 0):  /* PICMR */
         return env->picmr;
 
-- 
2.9.3

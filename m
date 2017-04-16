Received: from eggs.gnu.org ([2001:4830:134:3::10]:37956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cztWj-0003mN-EL
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 19:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cztWh-0007y7-Qb
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 19:24:17 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35018)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cztWh-0007xc-JK
	for qemu-devel@nongnu.org; Sun, 16 Apr 2017 19:24:15 -0400
Received: by mail-pg0-x242.google.com with SMTP id g2so24007635pge.2
	for <qemu-devel@nongnu.org>; Sun, 16 Apr 2017 16:24:15 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon, 17 Apr 2017 08:23:53 +0900
Message-Id: <b1be5af9a1d304f55847efeab706e88e3b9b1afa.1492384862.git.shorne@gmail.com>
In-Reply-To: <cover.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
In-Reply-To: <cover.1492384862.git.shorne@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
Subject: [Qemu-devel] [PATCH 4/7] target/openrisc: implement shadow registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>

Shadow registers are part of the openrisc spec along with sr[cid], as
part of the fast context switching feature.  When exceptions occur,
instead of having to save registers to the stack if enabled the CID will
increment and a new set of registers will be available.

This patch only implements shadow registers which can be used as extra
scratch registers via the mfspr and mtspr if required.  This is
implemented in a way where it would be easy to add on the fast context
switching, currently cid is hardcoded to 0.

This is need for openrisc linux smp kernels to boot correctly.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/cpu.c        |  5 ++++-
 target/openrisc/cpu.h        |  4 +++-
 target/openrisc/machine.c    | 16 +++++++++++++---
 target/openrisc/sys_helper.c |  9 +++++++++
 target/openrisc/translate.c  |  3 ++-
 5 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index 7fd2b9a..dc8be21 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -46,13 +46,14 @@ static void openrisc_cpu_reset(CPUState *s)
 
     memset(&cpu->env, 0, offsetof(CPUOpenRISCState, end_reset_fields));
 
+    cpu->env.gpr = cpu->env.shadow_gpr[0];
     cpu->env.pc = 0x100;
     cpu->env.sr = SR_FO | SR_SM;
     cpu->env.lock_addr = -1;
     s->exception_index = -1;
 
     cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP;
-    cpu->env.cpucfgr = CPUCFGR_OB32S | CPUCFGR_OF32S;
+    cpu->env.cpucfgr = CPUCFGR_OB32S | CPUCFGR_OF32S | CPUCFGR_NSGF;
     cpu->env.dmmucfgr = (DMMUCFGR_NTW & (0 << 2)) | (DMMUCFGR_NTS & (6 << 2));
     cpu->env.immucfgr = (IMMUCFGR_NTW & (0 << 2)) | (IMMUCFGR_NTS & (6 << 2));
 
@@ -132,6 +133,7 @@ static void or1200_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
+    set_feature(cpu, OPENRISC_FEATURE_NSGF);
     set_feature(cpu, OPENRISC_FEATURE_OB32S);
     set_feature(cpu, OPENRISC_FEATURE_OF32S);
 }
@@ -140,6 +142,7 @@ static void openrisc_any_initfn(Object *obj)
 {
     OpenRISCCPU *cpu = OPENRISC_CPU(obj);
 
+    set_feature(cpu, OPENRISC_FEATURE_NSGF);
     set_feature(cpu, OPENRISC_FEATURE_OB32S);
 }
 
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 418a0e6..78675e0 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -269,7 +269,9 @@ typedef struct CPUOpenRISCTLBContext {
 #endif
 
 typedef struct CPUOpenRISCState {
-    target_ulong gpr[32];     /* General registers */
+    target_ulong shadow_gpr[16][32]; /* Shadow registers */
+    target_ulong * gpr;       /* General registers (backed by shadow) */
+
     target_ulong pc;          /* Program counter */
     target_ulong ppc;         /* Prev PC */
     target_ulong jmp_pc;      /* Jump PC */
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 686eaa3..27cc751 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -24,6 +24,15 @@
 #include "hw/boards.h"
 #include "migration/cpu.h"
 
+static int env_post_load(void *opaque, int version_id)
+{
+    CPUOpenRISCState *env = opaque;
+
+    env->gpr = env->shadow_gpr[0];
+
+    return 0;
+}
+
 static int get_sr(QEMUFile *f, void *opaque, size_t size, VMStateField *field)
 {
     CPUOpenRISCState *env = opaque;
@@ -47,10 +56,11 @@ static const VMStateInfo vmstate_sr = {
 
 static const VMStateDescription vmstate_env = {
     .name = "env",
-    .version_id = 4,
-    .minimum_version_id = 4,
+    .version_id = 5,
+    .minimum_version_id = 5,
+    .post_load = env_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(gpr, CPUOpenRISCState, 32),
+        VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
         VMSTATE_UINTTL(pc, CPUOpenRISCState),
         VMSTATE_UINTTL(ppc, CPUOpenRISCState),
         VMSTATE_UINTTL(jmp_pc, CPUOpenRISCState),
diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index bd5051b..04ff302 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -89,6 +89,11 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 64): /* ESR */
         env->esr = rb;
         break;
+
+    case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
+        idx = (spr - 1024);
+        env->shadow_gpr[idx / 32][idx % 32] = rb;
+
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         if (!(rb & 1)) {
@@ -233,6 +238,10 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 129): /* NUMCORES */
         return 1;
 
+    case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
+        idx = (spr - 1024);
+        return env->shadow_gpr[idx / 32][idx % 32];
+
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
         return env->tlb->dtlb[0][idx].mr;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 74df245..c7261cb 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -107,7 +107,8 @@ void openrisc_translate_init(void)
                                      "mac");
     for (i = 0; i < 32; i++) {
         cpu_R[i] = tcg_global_mem_new(cpu_env,
-                                      offsetof(CPUOpenRISCState, gpr[i]),
+                                      offsetof(CPUOpenRISCState,
+                                               shadow_gpr[0][i]),
                                       regnames[i]);
     }
     cpu_R0 = cpu_R[0];
-- 
2.9.3

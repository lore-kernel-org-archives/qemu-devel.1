Received: from eggs.gnu.org ([2001:4830:134:3::10]:49295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfW-0004eK-Ow
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfT-0005tE-MH
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:34 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:35078 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1eovfT-0005Pd-2y
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:31 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 22 Feb 2018 19:31:38 +0100
Message-Id: <1519324303-5674-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 1/6] target/mips: compare virtual addresses
 in LL/SC sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>

From: Leon Alrae <leon.alrae@imgtec.com>

Do only virtual addresses comaprisons in LL/SC sequence emulations.

Until this patch, physical addresses had been compared in SC part of
LL/SC sequence, even though such comparisons could be avoided. Getting
rid of them allows throwing away SC helpers and having common SC
implementations in user and system mode, avoiding the need for two
separate implementations selected by #ifdef CONFIG_USER_ONLY.

Correct guest software should not rely on LL/SC if they accesses the
same physical address via different virtual addresses or if page
mapping gets changed between LL/SC due to manipulating TLB entries.
MIPS Instruction Set Manual clearly says that an RMW sequence must
use the same address in the LL and SC (virtual address, physical
address, cacheability and coherency attributes must be identical).
Otherwise, the result of the SC is not predictable. This patch takes
advantage of this fact and removes the virtual->physical address
translation from SC helper.

lladdr served as Coprocessor 0 LLAddr register which captures physical
address of the most recent LL instruction, and also lladdr was used
for comparison with following SC physical address. This patch changes
the meaning of lladdr - now it will only keep the virtual address of
the most recent LL. Additionally, CP0_LLAddr field is introduced which
is the actual Coperocessor 0 LLAddr register that guest can access.

Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 target/mips/cpu.h       |  3 ++-
 target/mips/machine.c   |  7 ++++---
 target/mips/op_helper.c | 29 +++++++++++++++++------------
 target/mips/translate.c |  4 ++--
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7f8ba5f..57ca861 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -480,10 +480,11 @@ struct CPUMIPSState {
 #define CP0C5_NFExists   0
     int32_t CP0_Config6;
     int32_t CP0_Config7;
+    uint64_t CP0_LLAddr;
     uint64_t CP0_MAAR[MIPS_MAAR_MAX];
     int32_t CP0_MAARI;
     /* XXX: Maybe make LLAddr per-TC? */
-    uint64_t lladdr;
+    target_ulong lladdr; /* LL virtual address compared against SC */
     target_ulong llval;
     target_ulong llnewval;
     target_ulong llreg;
diff --git a/target/mips/machine.c b/target/mips/machine.c
index 20100d5..155170c 100644
--- a/target/mips/machine.c
+++ b/target/mips/machine.c
@@ -212,8 +212,8 @@ const VMStateDescription vmstate_tlb = {
 
 const VMStateDescription vmstate_mips_cpu = {
     .name = "cpu",
-    .version_id = 10,
-    .minimum_version_id = 10,
+    .version_id = 11,
+    .minimum_version_id = 11,
     .post_load = cpu_post_load,
     .fields = (VMStateField[]) {
         /* Active TC */
@@ -283,9 +283,10 @@ const VMStateDescription vmstate_mips_cpu = {
         VMSTATE_INT32(env.CP0_Config3, MIPSCPU),
         VMSTATE_INT32(env.CP0_Config6, MIPSCPU),
         VMSTATE_INT32(env.CP0_Config7, MIPSCPU),
+        VMSTATE_UINT64(env.CP0_LLAddr, MIPSCPU),
         VMSTATE_UINT64_ARRAY(env.CP0_MAAR, MIPSCPU, MIPS_MAAR_MAX),
         VMSTATE_INT32(env.CP0_MAARI, MIPSCPU),
-        VMSTATE_UINT64(env.lladdr, MIPSCPU),
+        VMSTATE_UINTTL(env.lladdr, MIPSCPU),
         VMSTATE_UINTTL_ARRAY(env.CP0_WatchLo, MIPSCPU, 8),
         VMSTATE_INT32_ARRAY(env.CP0_WatchHi, MIPSCPU, 8),
         VMSTATE_UINTTL(env.CP0_XContext, MIPSCPU),
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 798cdad..cc5cd4e 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -255,15 +255,15 @@ static inline hwaddr do_translate_address(CPUMIPSState *env,
                                                       target_ulong address,
                                                       int rw, uintptr_t retaddr)
 {
-    hwaddr lladdr;
+    hwaddr paddr;
     CPUState *cs = CPU(mips_env_get_cpu(env));
 
-    lladdr = cpu_mips_translate_address(env, address, rw);
+    paddr = cpu_mips_translate_address(env, address, rw);
 
-    if (lladdr == -1LL) {
+    if (paddr == -1LL) {
         cpu_loop_exit_restore(cs, retaddr);
     } else {
-        return lladdr;
+        return paddr;
     }
 }
 
@@ -274,7 +274,8 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_idx)  \
         env->CP0_BadVAddr = arg;                                              \
         do_raise_exception(env, EXCP_AdEL, GETPC());                          \
     }                                                                         \
-    env->lladdr = do_translate_address(env, arg, 0, GETPC());                 \
+    env->CP0_LLAddr = do_translate_address(env, arg, 0, GETPC());             \
+    env->lladdr = arg;                                                        \
     env->llval = do_##insn(env, arg, mem_idx, GETPC());                       \
     return env->llval;                                                        \
 }
@@ -294,7 +295,7 @@ target_ulong helper_##name(CPUMIPSState *env, target_ulong arg1,              \
         env->CP0_BadVAddr = arg2;                                             \
         do_raise_exception(env, EXCP_AdES, GETPC());                          \
     }                                                                         \
-    if (do_translate_address(env, arg2, 1, GETPC()) == env->lladdr) {         \
+    if (arg2 == env->lladdr) {                                                \
         tmp = do_##ld_insn(env, arg2, mem_idx, GETPC());                      \
         if (tmp == env->llval) {                                              \
             do_##st_insn(env, arg2, arg1, mem_idx, GETPC());                  \
@@ -873,7 +874,7 @@ target_ulong helper_mftc0_status(CPUMIPSState *env)
 
 target_ulong helper_mfc0_lladdr(CPUMIPSState *env)
 {
-    return (int32_t)(env->lladdr >> env->CP0_LLAddr_shift);
+    return (int32_t)(env->CP0_LLAddr >> env->CP0_LLAddr_shift);
 }
 
 target_ulong helper_mfc0_maar(CPUMIPSState *env)
@@ -949,7 +950,7 @@ target_ulong helper_dmfc0_tcschefback(CPUMIPSState *env)
 
 target_ulong helper_dmfc0_lladdr(CPUMIPSState *env)
 {
-    return env->lladdr >> env->CP0_LLAddr_shift;
+    return env->CP0_LLAddr >> env->CP0_LLAddr_shift;
 }
 
 target_ulong helper_dmfc0_maar(CPUMIPSState *env)
@@ -1177,7 +1178,8 @@ void helper_mtc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
 {
     env->active_tc.PC = arg1;
     env->active_tc.CP0_TCStatus &= ~(1 << CP0TCSt_TDS);
-    env->lladdr = 0ULL;
+    env->CP0_LLAddr = 0;
+    env->lladdr = 0;
     /* MIPS16 not implemented. */
 }
 
@@ -1189,12 +1191,14 @@ void helper_mttc0_tcrestart(CPUMIPSState *env, target_ulong arg1)
     if (other_tc == other->current_tc) {
         other->active_tc.PC = arg1;
         other->active_tc.CP0_TCStatus &= ~(1 << CP0TCSt_TDS);
-        other->lladdr = 0ULL;
+        other->CP0_LLAddr = 0;
+        other->lladdr = 0;
         /* MIPS16 not implemented. */
     } else {
         other->tcs[other_tc].PC = arg1;
         other->tcs[other_tc].CP0_TCStatus &= ~(1 << CP0TCSt_TDS);
-        other->lladdr = 0ULL;
+        other->CP0_LLAddr = 0;
+        other->lladdr = 0;
         /* MIPS16 not implemented. */
     }
 }
@@ -1620,7 +1624,7 @@ void helper_mtc0_lladdr(CPUMIPSState *env, target_ulong arg1)
 {
     target_long mask = env->CP0_LLAddr_rw_bitmask;
     arg1 = arg1 << env->CP0_LLAddr_shift;
-    env->lladdr = (env->lladdr & ~mask) | (arg1 & mask);
+    env->CP0_LLAddr = (env->CP0_LLAddr & ~mask) | (arg1 & mask);
 }
 
 #define MTC0_MAAR_MASK(env) \
@@ -2318,6 +2322,7 @@ static inline void exception_return(CPUMIPSState *env)
 void helper_eret(CPUMIPSState *env)
 {
     exception_return(env);
+    env->CP0_LLAddr = 1;
     env->lladdr = 1;
 }
 
diff --git a/target/mips/translate.c b/target/mips/translate.c
index d05ee67..c9104a7 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -4913,7 +4913,7 @@ static void gen_mfhc0(DisasContext *ctx, TCGv arg, int reg, int sel)
     case 17:
         switch (sel) {
         case 0:
-            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, lladdr),
+            gen_mfhc0_load64(arg, offsetof(CPUMIPSState, CP0_LLAddr),
                              ctx->CP0_LLAddr_shift);
             rn = "LLAddr";
             break;
@@ -20440,7 +20440,7 @@ void mips_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
                 env->CP0_Status, env->CP0_Cause, env->CP0_EPC);
     cpu_fprintf(f, "    Config0 0x%08x Config1 0x%08x LLAddr 0x%016"
                 PRIx64 "\n",
-                env->CP0_Config0, env->CP0_Config1, env->lladdr);
+                env->CP0_Config0, env->CP0_Config1, env->CP0_LLAddr);
     cpu_fprintf(f, "    Config2 0x%08x Config3 0x%08x\n",
                 env->CP0_Config2, env->CP0_Config3);
     cpu_fprintf(f, "    Config4 0x%08x Config5 0x%08x\n",
-- 
2.7.4

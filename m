Received: from eggs.gnu.org ([2001:4830:134:3::10]:46225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmb-0001Aw-RY
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmV-0008K9-QN
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57525)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmV-0008JT-M4
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:01 -0400
Message-Id: <1500235468-15341-19-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 18/45] target/m68k: check CF_PARALLEL
 instead of parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Thereby decoupling the resulting translated code from the current state
of the system.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/m68k/helper.h    |  2 ++
 target/m68k/op_helper.c | 32 ++++++++++++++++++++++++++++----
 target/m68k/translate.c | 12 ++++++++++--
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 475a1f2..137ef48 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -10,7 +10,9 @@ DEF_HELPER_4(divsll, void, env, int, int, s32)
 DEF_HELPER_2(set_sr, void, env, i32)
 DEF_HELPER_3(movec, void, env, i32, i32)
 DEF_HELPER_4(cas2w, void, env, i32, i32, i32)
+DEF_HELPER_4(cas2w_parallel, void, env, i32, i32, i32)
 DEF_HELPER_4(cas2l, void, env, i32, i32, i32)
+DEF_HELPER_4(cas2l_parallel, void, env, i32, i32, i32)
 
 #define dh_alias_fp ptr
 #define dh_ctype_fp FPReg *
diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 7b5126c..061d468 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -361,7 +361,8 @@ void HELPER(divsll)(CPUM68KState *env, int numr, int regr, int32_t den)
     env->dregs[numr] = quot;
 }
 
-void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
+static void do_cas2w(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
+                     bool parallel)
 {
     uint32_t Dc1 = extract32(regs, 9, 3);
     uint32_t Dc2 = extract32(regs, 6, 3);
@@ -374,7 +375,7 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
     int16_t l1, l2;
     uintptr_t ra = GETPC();
 
-    if (parallel_cpus) {
+    if (parallel) {
         /* Tell the main loop we need to serialize this insn.  */
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
     } else {
@@ -399,7 +400,19 @@ void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
     env->dregs[Dc2] = deposit32(env->dregs[Dc2], 0, 16, l2);
 }
 
-void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
+void HELPER(cas2w)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
+{
+    do_cas2w(env, regs, a1, a2, false);
+}
+
+void HELPER(cas2w_parallel)(CPUM68KState *env, uint32_t regs, uint32_t a1,
+                            uint32_t a2)
+{
+    do_cas2w(env, regs, a1, a2, true);
+}
+
+static void do_cas2l(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2,
+                     bool parallel)
 {
     uint32_t Dc1 = extract32(regs, 9, 3);
     uint32_t Dc2 = extract32(regs, 6, 3);
@@ -416,7 +429,7 @@ void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
     TCGMemOpIdx oi;
 #endif
 
-    if (parallel_cpus) {
+    if (parallel) {
         /* We're executing in a parallel context -- must be atomic.  */
 #ifdef CONFIG_ATOMIC64
         uint64_t c, u, l;
@@ -470,6 +483,17 @@ void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
     env->dregs[Dc2] = l2;
 }
 
+void HELPER(cas2l)(CPUM68KState *env, uint32_t regs, uint32_t a1, uint32_t a2)
+{
+    do_cas2l(env, regs, a1, a2, false);
+}
+
+void HELPER(cas2l_parallel)(CPUM68KState *env, uint32_t regs, uint32_t a1,
+                            uint32_t a2)
+{
+    do_cas2l(env, regs, a1, a2, true);
+}
+
 struct bf_data {
     uint32_t addr;
     uint32_t bofs;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 3a519b7..5cfa25f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2308,7 +2308,11 @@ DISAS_INSN(cas2w)
                          (REG(ext1, 6) << 3) |
                          (REG(ext2, 0) << 6) |
                          (REG(ext1, 0) << 9));
-    gen_helper_cas2w(cpu_env, regs, addr1, addr2);
+    if (s->tb->cflags & CF_PARALLEL) {
+        gen_helper_cas2w_parallel(cpu_env, regs, addr1, addr2);
+    } else {
+        gen_helper_cas2w(cpu_env, regs, addr1, addr2);
+    }
     tcg_temp_free(regs);
 
     /* Note that cas2w also assigned to env->cc_op.  */
@@ -2354,7 +2358,11 @@ DISAS_INSN(cas2l)
                          (REG(ext1, 6) << 3) |
                          (REG(ext2, 0) << 6) |
                          (REG(ext1, 0) << 9));
-    gen_helper_cas2l(cpu_env, regs, addr1, addr2);
+    if (s->tb->cflags & CF_PARALLEL) {
+        gen_helper_cas2l_parallel(cpu_env, regs, addr1, addr2);
+    } else {
+        gen_helper_cas2l(cpu_env, regs, addr1, addr2);
+    }
     tcg_temp_free(regs);
 
     /* Note that cas2l also assigned to env->cc_op.  */
-- 
2.7.4

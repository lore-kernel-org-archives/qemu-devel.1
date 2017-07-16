Received: from eggs.gnu.org ([2001:4830:134:3::10]:46287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmd-0001B4-7Q
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmV-0008K2-QA
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmV-0008Jm-MW
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:43 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:02 -0400
Message-Id: <1500235468-15341-20-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 19/45] target/s390x: check CF_PARALLEL
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
 target/s390x/helper.h     |  3 +++
 target/s390x/mem_helper.c | 50 +++++++++++++++++++++++++++++++++++++++--------
 target/s390x/translate.c  | 20 +++++++++++++++----
 3 files changed, 61 insertions(+), 12 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 964097b..db697d9 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -33,6 +33,7 @@ DEF_HELPER_3(celgb, i64, env, i64, i32)
 DEF_HELPER_3(cdlgb, i64, env, i64, i32)
 DEF_HELPER_3(cxlgb, i64, env, i64, i32)
 DEF_HELPER_4(cdsg, void, env, i64, i32, i32)
+DEF_HELPER_4(cdsg_parallel, void, env, i64, i32, i32)
 DEF_HELPER_FLAGS_3(aeb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_3(adb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_5(axb, TCG_CALL_NO_WG, i64, env, i64, i64, i64, i64)
@@ -104,7 +105,9 @@ DEF_HELPER_FLAGS_1(popcnt, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_1(stfl, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_2(stfle, i32, env, i64)
 DEF_HELPER_FLAGS_2(lpq, TCG_CALL_NO_WG, i64, env, i64)
+DEF_HELPER_FLAGS_2(lpq_parallel, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_4(stpq, TCG_CALL_NO_WG, void, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(stpq_parallel, TCG_CALL_NO_WG, void, env, i64, i64, i64)
 DEF_HELPER_4(mvcos, i32, env, i64, i64, i64)
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index ede8471..2d9cdb1 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -1312,8 +1312,8 @@ uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
     return cc;
 }
 
-void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
-                  uint32_t r1, uint32_t r3)
+static void do_cdsg(CPUS390XState *env, uint64_t addr,
+                    uint32_t r1, uint32_t r3, bool parallel)
 {
     uintptr_t ra = GETPC();
     Int128 cmpv = int128_make128(env->regs[r1 + 1], env->regs[r1]);
@@ -1321,7 +1321,7 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
     Int128 oldv;
     bool fail;
 
-    if (parallel_cpus) {
+    if (parallel) {
 #ifndef CONFIG_ATOMIC128
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #else
@@ -1353,6 +1353,18 @@ void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
     env->regs[r1 + 1] = int128_getlo(oldv);
 }
 
+void HELPER(cdsg)(CPUS390XState *env, uint64_t addr,
+                  uint32_t r1, uint32_t r3)
+{
+    do_cdsg(env, addr, r1, r3, false);
+}
+
+void HELPER(cdsg_parallel)(CPUS390XState *env, uint64_t addr,
+                           uint32_t r1, uint32_t r3)
+{
+    do_cdsg(env, addr, r1, r3, true);
+}
+
 #if !defined(CONFIG_USER_ONLY)
 void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
 {
@@ -1795,12 +1807,12 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
 #endif
 
 /* load pair from quadword */
-uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
+static uint64_t do_lpq(CPUS390XState *env, uint64_t addr, bool parallel)
 {
     uintptr_t ra = GETPC();
     uint64_t hi, lo;
 
-    if (parallel_cpus) {
+    if (parallel) {
 #ifndef CONFIG_ATOMIC128
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #else
@@ -1821,13 +1833,23 @@ uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
     return hi;
 }
 
+uint64_t HELPER(lpq)(CPUS390XState *env, uint64_t addr)
+{
+    return do_lpq(env, addr, false);
+}
+
+uint64_t HELPER(lpq_parallel)(CPUS390XState *env, uint64_t addr)
+{
+    return do_lpq(env, addr, true);
+}
+
 /* store pair to quadword */
-void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
-                  uint64_t low, uint64_t high)
+static void do_stpq(CPUS390XState *env, uint64_t addr,
+                    uint64_t low, uint64_t high, bool parallel)
 {
     uintptr_t ra = GETPC();
 
-    if (parallel_cpus) {
+    if (parallel) {
 #ifndef CONFIG_ATOMIC128
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #else
@@ -1845,6 +1867,18 @@ void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
     }
 }
 
+void HELPER(stpq)(CPUS390XState *env, uint64_t addr,
+                  uint64_t low, uint64_t high)
+{
+    do_stpq(env, addr, low, high, false);
+}
+
+void HELPER(stpq_parallel)(CPUS390XState *env, uint64_t addr,
+                           uint64_t low, uint64_t high)
+{
+    do_stpq(env, addr, low, high, true);
+}
+
 /* Execute instruction.  This instruction executes an insn modified with
    the contents of r1.  It does not change the executed instruction in memory;
    it does not change the program counter.
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b503c2c..6535f6c 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2024,7 +2024,11 @@ static ExitStatus op_cdsg(DisasContext *s, DisasOps *o)
     addr = get_address(s, 0, b2, d2);
     t_r1 = tcg_const_i32(r1);
     t_r3 = tcg_const_i32(r3);
-    gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
+    if (s->tb->cflags & CF_PARALLEL) {
+        gen_helper_cdsg_parallel(cpu_env, addr, t_r1, t_r3);
+    } else {
+        gen_helper_cdsg(cpu_env, addr, t_r1, t_r3);
+    }
     tcg_temp_free_i64(addr);
     tcg_temp_free_i32(t_r1);
     tcg_temp_free_i32(t_r3);
@@ -2881,7 +2885,7 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
     TCGMemOp mop = s->insn->data;
 
     /* In a parallel context, stop the world and single step.  */
-    if (parallel_cpus) {
+    if (s->tb->cflags & CF_PARALLEL) {
         potential_page_fault(s);
         gen_exception(EXCP_ATOMIC);
         return EXIT_NORETURN;
@@ -2902,7 +2906,11 @@ static ExitStatus op_lpd(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_lpq(DisasContext *s, DisasOps *o)
 {
-    gen_helper_lpq(o->out, cpu_env, o->in2);
+    if (s->tb->cflags & CF_PARALLEL) {
+        gen_helper_lpq_parallel(o->out, cpu_env, o->in2);
+    } else {
+        gen_helper_lpq(o->out, cpu_env, o->in2);
+    }
     return_low128(o->out2);
     return NO_EXIT;
 }
@@ -4219,7 +4227,11 @@ static ExitStatus op_stmh(DisasContext *s, DisasOps *o)
 
 static ExitStatus op_stpq(DisasContext *s, DisasOps *o)
 {
-    gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
+    if (s->tb->cflags & CF_PARALLEL) {
+        gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
+    } else {
+        gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
+    }
     return NO_EXIT;
 }
 
-- 
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmc-0001Ay-2w
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmV-0008I6-31
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38477)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008H0-TQ
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:58 -0400
Message-Id: <1500235468-15341-16-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 15/45] target/arm: check CF_PARALLEL instead
 of parallel_cpus
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
 target/arm/helper-a64.h    |  4 ++++
 target/arm/helper-a64.c    | 38 ++++++++++++++++++++++++++++++++------
 target/arm/op_helper.c     |  7 -------
 target/arm/translate-a64.c | 31 +++++++++++++++++++++++++------
 target/arm/translate.c     |  9 +++++++--
 5 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 6f9eaba..85d8674 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -43,4 +43,8 @@ DEF_HELPER_FLAGS_2(fcvtx_f64_to_f32, TCG_CALL_NO_RWG, f32, f64, env)
 DEF_HELPER_FLAGS_3(crc32_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(crc32c_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_le, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(paired_cmpxchg64_le_parallel, TCG_CALL_NO_WG,
+                   i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
+DEF_HELPER_FLAGS_4(paired_cmpxchg64_be_parallel, TCG_CALL_NO_WG,
+                   i64, env, i64, i64, i64)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index d9df82c..d0e435c 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -430,8 +430,9 @@ uint64_t HELPER(crc32c_64)(uint64_t acc, uint64_t val, uint32_t bytes)
 }
 
 /* Returns 0 on success; 1 otherwise.  */
-uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
-                                     uint64_t new_lo, uint64_t new_hi)
+static uint64_t do_paired_cmpxchg64_le(CPUARMState *env, uint64_t addr,
+                                       uint64_t new_lo, uint64_t new_hi,
+                                       bool parallel)
 {
     uintptr_t ra = GETPC();
     Int128 oldv, cmpv, newv;
@@ -440,7 +441,7 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
     cmpv = int128_make128(env->exclusive_val, env->exclusive_high);
     newv = int128_make128(new_lo, new_hi);
 
-    if (parallel_cpus) {
+    if (parallel) {
 #ifndef CONFIG_ATOMIC128
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #else
@@ -484,8 +485,21 @@ uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
     return !success;
 }
 
-uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
-                                     uint64_t new_lo, uint64_t new_hi)
+uint64_t HELPER(paired_cmpxchg64_le)(CPUARMState *env, uint64_t addr,
+                                              uint64_t new_lo, uint64_t new_hi)
+{
+    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, false);
+}
+
+uint64_t HELPER(paired_cmpxchg64_le_parallel)(CPUARMState *env, uint64_t addr,
+                                              uint64_t new_lo, uint64_t new_hi)
+{
+    return do_paired_cmpxchg64_le(env, addr, new_lo, new_hi, true);
+}
+
+static uint64_t do_paired_cmpxchg64_be(CPUARMState *env, uint64_t addr,
+                                       uint64_t new_lo, uint64_t new_hi,
+                                       bool parallel)
 {
     uintptr_t ra = GETPC();
     Int128 oldv, cmpv, newv;
@@ -494,7 +508,7 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
     cmpv = int128_make128(env->exclusive_val, env->exclusive_high);
     newv = int128_make128(new_lo, new_hi);
 
-    if (parallel_cpus) {
+    if (parallel) {
 #ifndef CONFIG_ATOMIC128
         cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
 #else
@@ -537,3 +551,15 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
 
     return !success;
 }
+
+uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
+                                     uint64_t new_lo, uint64_t new_hi)
+{
+    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, false);
+}
+
+uint64_t HELPER(paired_cmpxchg64_be_parallel)(CPUARMState *env, uint64_t addr,
+                                     uint64_t new_lo, uint64_t new_hi)
+{
+    return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true);
+}
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 2a85666..a28f254 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -450,13 +450,6 @@ void HELPER(yield)(CPUARMState *env)
     ARMCPU *cpu = arm_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
 
-    /* When running in MTTCG we don't generate jumps to the yield and
-     * WFE helpers as it won't affect the scheduling of other vCPUs.
-     * If we wanted to more completely model WFE/SEV so we don't busy
-     * spin unnecessarily we would need to do something more involved.
-     */
-    g_assert(!parallel_cpus);
-
     /* This is a non-trappable hint instruction that generally indicates
      * that the guest is currently busy-looping. Yield control back to the
      * top level loop so that a more deserving VCPU has a chance to run.
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 49d35c2..af28b26 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1333,13 +1333,18 @@ static void handle_hint(DisasContext *s, uint32_t insn,
     case 3: /* WFI */
         s->is_jmp = DISAS_WFI;
         return;
+        /* When running in MTTCG we don't generate jumps to the yield and
+         * WFE helpers as it won't affect the scheduling of other vCPUs.
+         * If we wanted to more completely model WFE/SEV so we don't busy
+         * spin unnecessarily we would need to do something more involved.
+         */
     case 1: /* YIELD */
-        if (!parallel_cpus) {
+        if (!(s->tb->cflags & CF_PARALLEL)) {
             s->is_jmp = DISAS_YIELD;
         }
         return;
     case 2: /* WFE */
-        if (!parallel_cpus) {
+        if (!(s->tb->cflags & CF_PARALLEL)) {
             s->is_jmp = DISAS_WFE;
         }
         return;
@@ -1916,11 +1921,25 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
             tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, val);
             tcg_temp_free_i64(val);
         } else if (s->be_data == MO_LE) {
-            gen_helper_paired_cmpxchg64_le(tmp, cpu_env, addr, cpu_reg(s, rt),
-                                           cpu_reg(s, rt2));
+            if (s->tb->cflags & CF_PARALLEL) {
+                gen_helper_paired_cmpxchg64_le_parallel(tmp, cpu_env, addr,
+                                                        cpu_reg(s, rt),
+                                                        cpu_reg(s, rt2));
+            } else {
+                gen_helper_paired_cmpxchg64_le(tmp, cpu_env, addr,
+                                               cpu_reg(s, rt),
+                                               cpu_reg(s, rt2));
+            }
         } else {
-            gen_helper_paired_cmpxchg64_be(tmp, cpu_env, addr, cpu_reg(s, rt),
-                                           cpu_reg(s, rt2));
+            if (s->tb->cflags & CF_PARALLEL) {
+                gen_helper_paired_cmpxchg64_be_parallel(tmp, cpu_env, addr,
+                                                        cpu_reg(s, rt),
+                                                        cpu_reg(s, rt2));
+            } else {
+                gen_helper_paired_cmpxchg64_be(tmp, cpu_env, addr,
+                                               cpu_reg(s, rt),
+                                               cpu_reg(s, rt2));
+            }
         }
     } else {
         TCGv_i64 val = cpu_reg(s, rt);
diff --git a/target/arm/translate.c b/target/arm/translate.c
index ebbe407..34aa95d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4492,8 +4492,13 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
 static void gen_nop_hint(DisasContext *s, int val)
 {
     switch (val) {
+        /* When running in MTTCG we don't generate jumps to the yield and
+         * WFE helpers as it won't affect the scheduling of other vCPUs.
+         * If we wanted to more completely model WFE/SEV so we don't busy
+         * spin unnecessarily we would need to do something more involved.
+         */
     case 1: /* yield */
-        if (!parallel_cpus) {
+        if (!(s->tb->cflags & CF_PARALLEL)) {
             gen_set_pc_im(s, s->pc);
             s->is_jmp = DISAS_YIELD;
         }
@@ -4503,7 +4508,7 @@ static void gen_nop_hint(DisasContext *s, int val)
         s->is_jmp = DISAS_WFI;
         break;
     case 2: /* wfe */
-        if (!parallel_cpus) {
+        if (!(s->tb->cflags & CF_PARALLEL)) {
             gen_set_pc_im(s, s->pc);
             s->is_jmp = DISAS_WFE;
         }
-- 
2.7.4

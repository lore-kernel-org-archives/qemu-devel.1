Received: from eggs.gnu.org ([2001:4830:134:3::10]:45737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6g-0008RJ-Jc
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6e-0008Ms-Q3
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:14 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:43316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6e-0008MM-Gq
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:12 -0400
Received: by mail-wm0-x244.google.com with SMTP id m72so15234645wmc.0
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:10 +0200
Message-Id: <20171025093535.10175-27-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 26/51] target/arm: check CF_PARALLEL instead of
 parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    |  4 ++++
 target/arm/helper-a64.c    | 38 ++++++++++++++++++++++++++++++++------
 target/arm/op_helper.c     |  7 -------
 target/arm/translate-a64.c | 31 +++++++++++++++++++++++++------
 target/arm/translate.c     |  9 +++++++--
 5 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 6f9eaba533..85d86741db 100644
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
index d9df82cff5..d0e435ca4b 100644
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
index 3914145709..138d0df82f 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -502,13 +502,6 @@ void HELPER(yield)(CPUARMState *env)
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
index e9bee8c196..f6b364c04b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1336,13 +1336,18 @@ static void handle_hint(DisasContext *s, uint32_t insn,
     case 3: /* WFI */
         s->base.is_jmp = DISAS_WFI;
         return;
+        /* When running in MTTCG we don't generate jumps to the yield and
+         * WFE helpers as it won't affect the scheduling of other vCPUs.
+         * If we wanted to more completely model WFE/SEV so we don't busy
+         * spin unnecessarily we would need to do something more involved.
+         */
     case 1: /* YIELD */
-        if (!parallel_cpus) {
+        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
             s->base.is_jmp = DISAS_YIELD;
         }
         return;
     case 2: /* WFE */
-        if (!parallel_cpus) {
+        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
             s->base.is_jmp = DISAS_WFE;
         }
         return;
@@ -1931,11 +1936,25 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
                                        MO_64 | MO_ALIGN | s->be_data);
             tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
         } else if (s->be_data == MO_LE) {
-            gen_helper_paired_cmpxchg64_le(tmp, cpu_env, cpu_exclusive_addr,
-                                           cpu_reg(s, rt), cpu_reg(s, rt2));
+            if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+                gen_helper_paired_cmpxchg64_le_parallel(tmp, cpu_env,
+                                                        cpu_exclusive_addr,
+                                                        cpu_reg(s, rt),
+                                                        cpu_reg(s, rt2));
+            } else {
+                gen_helper_paired_cmpxchg64_le(tmp, cpu_env, cpu_exclusive_addr,
+                                               cpu_reg(s, rt), cpu_reg(s, rt2));
+            }
         } else {
-            gen_helper_paired_cmpxchg64_be(tmp, cpu_env, cpu_exclusive_addr,
-                                           cpu_reg(s, rt), cpu_reg(s, rt2));
+            if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+                gen_helper_paired_cmpxchg64_be_parallel(tmp, cpu_env,
+                                                        cpu_exclusive_addr,
+                                                        cpu_reg(s, rt),
+                                                        cpu_reg(s, rt2));
+            } else {
+                gen_helper_paired_cmpxchg64_be(tmp, cpu_env, cpu_exclusive_addr,
+                                               cpu_reg(s, rt), cpu_reg(s, rt2));
+            }
         }
     } else {
         tcg_gen_atomic_cmpxchg_i64(tmp, cpu_exclusive_addr, cpu_exclusive_val,
diff --git a/target/arm/translate.c b/target/arm/translate.c
index dfa547b1db..397cc7afea 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4546,8 +4546,13 @@ static void gen_exception_return(DisasContext *s, TCGv_i32 pc)
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
+        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
             gen_set_pc_im(s, s->pc);
             s->base.is_jmp = DISAS_YIELD;
         }
@@ -4557,7 +4562,7 @@ static void gen_nop_hint(DisasContext *s, int val)
         s->base.is_jmp = DISAS_WFI;
         break;
     case 2: /* wfe */
-        if (!parallel_cpus) {
+        if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
             gen_set_pc_im(s, s->pc);
             s->base.is_jmp = DISAS_WFE;
         }
-- 
2.13.6

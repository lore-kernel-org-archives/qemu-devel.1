Received: from eggs.gnu.org ([2001:4830:134:3::10]:52480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AE-0002U5-On
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e49AD-0003gM-ER
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:54 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:53056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e49AD-0003fm-6W
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 13:26:53 -0400
Received: by mail-pf0-x22a.google.com with SMTP id e64so16286014pfk.9
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 10:26:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Oct 2017 10:25:46 -0700
Message-Id: <20171016172609.23422-28-richard.henderson@linaro.org>
In-Reply-To: <20171016172609.23422-1-richard.henderson@linaro.org>
References: <20171016172609.23422-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 27/50] target/arm: check CF_PARALLEL instead
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

Thereby decoupling the resulting translated code from the current state
of the system.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
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

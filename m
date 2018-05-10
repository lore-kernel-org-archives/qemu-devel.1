Received: from eggs.gnu.org ([2001:4830:134:3::10]:48609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdI-000593-7M
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdG-0000vN-Ro
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fGpdG-0000uH-Il
	for qemu-devel@nongnu.org; Thu, 10 May 2018 13:45:34 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fGpdF-0003a1-Hl
	for qemu-devel@nongnu.org; Thu, 10 May 2018 18:45:33 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 18:45:14 +0100
Message-Id: <20180510174519.11264-17-peter.maydell@linaro.org>
In-Reply-To: <20180510174519.11264-1-peter.maydell@linaro.org>
References: <20180510174519.11264-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 16/21] target/arm: Implement CAS and CASP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180508151437.4232-10-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |   2 +
 target/arm/helper-a64.c    |  43 ++++++++++++++
 target/arm/translate-a64.c | 119 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index ef4ddfe9d8..b8028ac98c 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -51,6 +51,8 @@ DEF_HELPER_FLAGS_4(paired_cmpxchg64_le_parallel, TCG_CALL_NO_WG,
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be_parallel, TCG_CALL_NO_WG,
                    i64, env, i64, i64, i64)
+DEF_HELPER_5(casp_le_parallel, void, env, i32, i64, i64, i64)
+DEF_HELPER_5(casp_be_parallel, void, env, i32, i64, i64, i64)
 DEF_HELPER_FLAGS_3(advsimd_maxh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
 DEF_HELPER_FLAGS_3(advsimd_minh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
 DEF_HELPER_FLAGS_3(advsimd_maxnumh, TCG_CALL_NO_RWG, f16, f16, f16, ptr)
diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index afb25ad20c..549ed3513e 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -636,6 +636,49 @@ uint64_t HELPER(paired_cmpxchg64_be_parallel)(CPUARMState *env, uint64_t addr,
     return do_paired_cmpxchg64_be(env, addr, new_lo, new_hi, true, GETPC());
 }
 
+/* Writes back the old data into Rs.  */
+void HELPER(casp_le_parallel)(CPUARMState *env, uint32_t rs, uint64_t addr,
+                              uint64_t new_lo, uint64_t new_hi)
+{
+    uintptr_t ra = GETPC();
+#ifndef CONFIG_ATOMIC128
+    cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+#else
+    Int128 oldv, cmpv, newv;
+
+    cmpv = int128_make128(env->xregs[rs], env->xregs[rs + 1]);
+    newv = int128_make128(new_lo, new_hi);
+
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOpIdx oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
+    oldv = helper_atomic_cmpxchgo_le_mmu(env, addr, cmpv, newv, oi, ra);
+
+    env->xregs[rs] = int128_getlo(oldv);
+    env->xregs[rs + 1] = int128_gethi(oldv);
+#endif
+}
+
+void HELPER(casp_be_parallel)(CPUARMState *env, uint32_t rs, uint64_t addr,
+                              uint64_t new_hi, uint64_t new_lo)
+{
+    uintptr_t ra = GETPC();
+#ifndef CONFIG_ATOMIC128
+    cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
+#else
+    Int128 oldv, cmpv, newv;
+
+    cmpv = int128_make128(env->xregs[rs + 1], env->xregs[rs]);
+    newv = int128_make128(new_lo, new_hi);
+
+    int mem_idx = cpu_mmu_index(env, false);
+    TCGMemOpIdx oi = make_memop_idx(MO_LEQ | MO_ALIGN_16, mem_idx);
+    oldv = helper_atomic_cmpxchgo_be_mmu(env, addr, cmpv, newv, oi, ra);
+
+    env->xregs[rs + 1] = int128_getlo(oldv);
+    env->xregs[rs] = int128_gethi(oldv);
+#endif
+}
+
 /*
  * AdvSIMD half-precision
  */
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 86989fda6c..fa60cf908f 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -2114,6 +2114,103 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
     tcg_gen_movi_i64(cpu_exclusive_addr, -1);
 }
 
+static void gen_compare_and_swap(DisasContext *s, int rs, int rt,
+                                 int rn, int size)
+{
+    TCGv_i64 tcg_rs = cpu_reg(s, rs);
+    TCGv_i64 tcg_rt = cpu_reg(s, rt);
+    int memidx = get_mem_index(s);
+    TCGv_i64 addr = cpu_reg_sp(s, rn);
+
+    if (rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    tcg_gen_atomic_cmpxchg_i64(tcg_rs, addr, tcg_rs, tcg_rt, memidx,
+                               size | MO_ALIGN | s->be_data);
+}
+
+static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
+                                      int rn, int size)
+{
+    TCGv_i64 s1 = cpu_reg(s, rs);
+    TCGv_i64 s2 = cpu_reg(s, rs + 1);
+    TCGv_i64 t1 = cpu_reg(s, rt);
+    TCGv_i64 t2 = cpu_reg(s, rt + 1);
+    TCGv_i64 addr = cpu_reg_sp(s, rn);
+    int memidx = get_mem_index(s);
+
+    if (rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    if (size == 2) {
+        TCGv_i64 cmp = tcg_temp_new_i64();
+        TCGv_i64 val = tcg_temp_new_i64();
+
+        if (s->be_data == MO_LE) {
+            tcg_gen_concat32_i64(val, t1, t2);
+            tcg_gen_concat32_i64(cmp, s1, s2);
+        } else {
+            tcg_gen_concat32_i64(val, t2, t1);
+            tcg_gen_concat32_i64(cmp, s2, s1);
+        }
+
+        tcg_gen_atomic_cmpxchg_i64(cmp, addr, cmp, val, memidx,
+                                   MO_64 | MO_ALIGN | s->be_data);
+        tcg_temp_free_i64(val);
+
+        if (s->be_data == MO_LE) {
+            tcg_gen_extr32_i64(s1, s2, cmp);
+        } else {
+            tcg_gen_extr32_i64(s2, s1, cmp);
+        }
+        tcg_temp_free_i64(cmp);
+    } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+        TCGv_i32 tcg_rs = tcg_const_i32(rs);
+
+        if (s->be_data == MO_LE) {
+            gen_helper_casp_le_parallel(cpu_env, tcg_rs, addr, t1, t2);
+        } else {
+            gen_helper_casp_be_parallel(cpu_env, tcg_rs, addr, t1, t2);
+        }
+        tcg_temp_free_i32(tcg_rs);
+    } else {
+        TCGv_i64 d1 = tcg_temp_new_i64();
+        TCGv_i64 d2 = tcg_temp_new_i64();
+        TCGv_i64 a2 = tcg_temp_new_i64();
+        TCGv_i64 c1 = tcg_temp_new_i64();
+        TCGv_i64 c2 = tcg_temp_new_i64();
+        TCGv_i64 zero = tcg_const_i64(0);
+
+        /* Load the two words, in memory order.  */
+        tcg_gen_qemu_ld_i64(d1, addr, memidx,
+                            MO_64 | MO_ALIGN_16 | s->be_data);
+        tcg_gen_addi_i64(a2, addr, 8);
+        tcg_gen_qemu_ld_i64(d2, addr, memidx, MO_64 | s->be_data);
+
+        /* Compare the two words, also in memory order.  */
+        tcg_gen_setcond_i64(TCG_COND_EQ, c1, d1, s1);
+        tcg_gen_setcond_i64(TCG_COND_EQ, c2, d2, s2);
+        tcg_gen_and_i64(c2, c2, c1);
+
+        /* If compare equal, write back new data, else write back old data.  */
+        tcg_gen_movcond_i64(TCG_COND_NE, c1, c2, zero, t1, d1);
+        tcg_gen_movcond_i64(TCG_COND_NE, c2, c2, zero, t2, d2);
+        tcg_gen_qemu_st_i64(c1, addr, memidx, MO_64 | s->be_data);
+        tcg_gen_qemu_st_i64(c2, a2, memidx, MO_64 | s->be_data);
+        tcg_temp_free_i64(a2);
+        tcg_temp_free_i64(c1);
+        tcg_temp_free_i64(c2);
+        tcg_temp_free_i64(zero);
+
+        /* Write back the data from memory to Rs.  */
+        tcg_gen_mov_i64(s1, d1);
+        tcg_gen_mov_i64(s2, d2);
+        tcg_temp_free_i64(d1);
+        tcg_temp_free_i64(d2);
+    }
+}
+
 /* Update the Sixty-Four bit (SF) registersize. This logic is derived
  * from the ARMv8 specs for LDR (Shared decode for all encodings).
  */
@@ -2214,10 +2311,16 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             gen_store_exclusive(s, rs, rt, rt2, tcg_addr, size, true);
             return;
         }
-        /* CASP / CASPL */
+        if (rt2 == 31
+            && ((rt | rs) & 1) == 0
+            && arm_dc_feature(s, ARM_FEATURE_V8_ATOMICS)) {
+            /* CASP / CASPL */
+            gen_compare_and_swap_pair(s, rs, rt, rn, size | 2);
+            return;
+        }
         break;
 
-    case 0x6: case 0x7: /* CASP / LDXP */
+    case 0x6: case 0x7: /* CASPA / LDXP */
         if (size & 2) { /* LDXP / LDAXP */
             if (rn == 31) {
                 gen_check_sp_alignment(s);
@@ -2230,13 +2333,23 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             }
             return;
         }
-        /* CASPA / CASPAL */
+        if (rt2 == 31
+            && ((rt | rs) & 1) == 0
+            && arm_dc_feature(s, ARM_FEATURE_V8_ATOMICS)) {
+            /* CASPA / CASPAL */
+            gen_compare_and_swap_pair(s, rs, rt, rn, size | 2);
+            return;
+        }
         break;
 
     case 0xa: /* CAS */
     case 0xb: /* CASL */
     case 0xe: /* CASA */
     case 0xf: /* CASAL */
+        if (rt2 == 31 && arm_dc_feature(s, ARM_FEATURE_V8_ATOMICS)) {
+            gen_compare_and_swap(s, rs, rt, rn, size);
+            return;
+        }
         break;
     }
     unallocated_encoding(s);
-- 
2.17.0

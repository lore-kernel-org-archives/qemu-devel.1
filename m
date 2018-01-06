Received: from eggs.gnu.org ([2001:4830:134:3::10]:48324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevx-0007WH-4k
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eXevu-000561-EH
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:09 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:46285)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eXevu-00053t-55
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 22:14:06 -0500
Received: by mail-pl0-x244.google.com with SMTP id i6so4222971plt.13
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 19:14:06 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-183-164.tukw.qwest.net.
	[97.113.183.164]) by smtp.gmail.com with ESMTPSA id
	g10sm17740595pfe.77.2018.01.05.19.14.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Jan 2018 19:14:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  5 Jan 2018 19:13:32 -0800
Message-Id: <20180106031346.6650-10-richard.henderson@linaro.org>
In-Reply-To: <20180106031346.6650-1-richard.henderson@linaro.org>
References: <20180106031346.6650-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v8 09/23] tcg: Add generic vector ops for
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h      |   8 +++
 tcg/tcg-op-gvec.h            |   9 +++
 tcg/tcg-op.h                 |   5 ++
 tcg/tcg-opc.h                |   5 ++
 tcg/tcg.h                    |   2 +
 accel/tcg/tcg-runtime-gvec.c |  26 ++++++++
 tcg/tcg-op-gvec.c            | 154 ++++++++++++++++++++++++++++++++++++++++---
 tcg/tcg-op-vec.c             |  39 +++++++++++
 tcg/tcg.c                    |   6 ++
 tcg/README                   |  13 ++++
 10 files changed, 259 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index c4a2e6b215..d1b3542946 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -199,6 +199,14 @@ DEF_HELPER_FLAGS_4(gvec_trn16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_trn32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_trn64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(gvec_extu8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_extu16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_extu32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(gvec_exts8, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_exts16, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(gvec_exts32, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(gvec_eq8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_eq16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_eq32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 41839a61a6..91daf9e6ef 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -222,6 +222,15 @@ void tcg_gen_gvec_trne(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_trno(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_extul(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_extuh(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_extsl(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_extsh(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
                       uint32_t aofs, uint32_t bofs,
                       uint32_t oprsz, uint32_t maxsz);
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index f967790cd9..28a5cbe47a 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -940,6 +940,11 @@ void tcg_gen_uzpo_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_trne_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_trno_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 
+void tcg_gen_extul_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+void tcg_gen_extuh_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+void tcg_gen_extsl_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+void tcg_gen_extsh_vec(unsigned vece, TCGv_vec r, TCGv_vec a);
+
 void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
                      TCGv_vec a, TCGv_vec b);
 
diff --git a/tcg/tcg-opc.h b/tcg/tcg-opc.h
index b21a30273c..3dfd872a0f 100644
--- a/tcg/tcg-opc.h
+++ b/tcg/tcg-opc.h
@@ -249,6 +249,11 @@ DEF(uzpo_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_uzp_vec))
 DEF(trne_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_trn_vec))
 DEF(trno_vec, 1, 2, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_trn_vec))
 
+DEF(extul_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_extl_vec))
+DEF(extuh_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_exth_vec))
+DEF(extsl_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_extl_vec))
+DEF(extsh_vec, 1, 1, 0, IMPLVEC | IMPL(TCG_TARGET_HAS_exth_vec))
+
 DEF(cmp_vec, 1, 2, 1, IMPLVEC)
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 64078a2e92..737550385d 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -186,6 +186,8 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_trn_vec          0
 #define TCG_TARGET_HAS_cmp_vec          0
 #define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_extl_vec         0
+#define TCG_TARGET_HAS_exth_vec         0
 #else
 #define TCG_TARGET_MAYBE_vec            1
 #endif
diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 9406ccd769..ff26be0744 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -588,3 +588,29 @@ DO_CMP2(8)
 DO_CMP2(16)
 DO_CMP2(32)
 DO_CMP2(64)
+
+#define DO_EXT(NAME, TYPE1, TYPE2) \
+void HELPER(NAME)(void *d, void *a, uint32_t desc)                           \
+{                                                                            \
+    intptr_t oprsz = simd_oprsz(desc);                                       \
+    intptr_t oprsz_2 = oprsz / 2;                                            \
+    intptr_t i;                                                              \
+    /* We produce output faster than we consume input.                       \
+       Therefore we must be mindful of possible overlap.  */                 \
+    if (unlikely((a - d) < (uintptr_t)oprsz)) {                              \
+        void *a_new = alloca(oprsz_2);                                       \
+        memcpy(a_new, a, oprsz_2);                                           \
+        a = a_new;                                                           \
+    }                                                                        \
+    for (i = 0; i < oprsz_2; i += sizeof(TYPE1)) {                           \
+        *(TYPE2 *)(d + 2 * i) = *(TYPE1 *)(a + i);                           \
+    }                                                                        \
+    clear_high(d, oprsz, desc);                                              \
+}
+
+DO_EXT(gvec_extu8, uint8_t, uint16_t)
+DO_EXT(gvec_extu16, uint16_t, uint32_t)
+DO_EXT(gvec_extu32, uint32_t, uint64_t)
+DO_EXT(gvec_exts8, int8_t, int16_t)
+DO_EXT(gvec_exts16, int16_t, int32_t)
+DO_EXT(gvec_exts32, int32_t, int64_t)
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 5e970cb2aa..ec273de3dc 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1405,7 +1405,7 @@ void tcg_gen_gvec_sub(unsigned vece, uint32_t dofs, uint32_t aofs,
 }
 
 void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
-                      uint32_t bofs, uint32_t opsz, uint32_t maxsz)
+                      uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
     static const GVecGen3 g[4] = {
         { .fniv = tcg_gen_mul_vec,
@@ -1430,7 +1430,7 @@ void tcg_gen_gvec_mul(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     tcg_debug_assert(vece <= MO_64);
-    tcg_gen_gvec_3(dofs, aofs, bofs, opsz, maxsz, &g[vece]);
+    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
 }
 
 /* Perform a vector negation using normal negation and a mask.
@@ -2052,13 +2052,13 @@ void tcg_gen_gvec_trno(unsigned vece, uint32_t dofs, uint32_t aofs,
 
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
 static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                           uint32_t opsz, TCGCond cond)
+                           uint32_t oprsz, TCGCond cond)
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
     TCGv_i32 t1 = tcg_temp_new_i32();
     uint32_t i;
 
-    for (i = 0; i < opsz; i += 4) {
+    for (i = 0; i < oprsz; i += 4) {
         tcg_gen_ld_i32(t0, cpu_env, aofs + i);
         tcg_gen_ld_i32(t1, cpu_env, bofs + i);
         tcg_gen_setcond_i32(cond, t0, t0, t1);
@@ -2070,13 +2070,13 @@ static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 }
 
 static void expand_cmp_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
-                           uint32_t opsz, TCGCond cond)
+                           uint32_t oprsz, TCGCond cond)
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
     TCGv_i64 t1 = tcg_temp_new_i64();
     uint32_t i;
 
-    for (i = 0; i < opsz; i += 8) {
+    for (i = 0; i < oprsz; i += 8) {
         tcg_gen_ld_i64(t0, cpu_env, aofs + i);
         tcg_gen_ld_i64(t1, cpu_env, bofs + i);
         tcg_gen_setcond_i64(cond, t0, t0, t1);
@@ -2088,14 +2088,14 @@ static void expand_cmp_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 }
 
 static void expand_cmp_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
-                           uint32_t bofs, uint32_t opsz, uint32_t tysz,
+                           uint32_t bofs, uint32_t oprsz, uint32_t tysz,
                            TCGType type, TCGCond cond)
 {
     TCGv_vec t0 = tcg_temp_new_vec(type);
     TCGv_vec t1 = tcg_temp_new_vec(type);
     uint32_t i;
 
-    for (i = 0; i < opsz; i += tysz) {
+    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, cpu_env, aofs + i);
         tcg_gen_ld_vec(t1, cpu_env, bofs + i);
         tcg_gen_cmp_vec(cond, vece, t0, t0, t1);
@@ -2251,3 +2251,141 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     }
     tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, 0, fn);
 }
+
+static void do_ext(unsigned vece, uint32_t dofs, uint32_t aofs,
+                   uint32_t oprsz, uint32_t maxsz, bool high, bool is_sign)
+{
+    static gen_helper_gvec_2 * const extu_fn[3] = {
+        gen_helper_gvec_extu8, gen_helper_gvec_extu16, gen_helper_gvec_extu32
+    };
+    static gen_helper_gvec_2 * const exts_fn[3] = {
+        gen_helper_gvec_exts8, gen_helper_gvec_exts16, gen_helper_gvec_exts32
+    };
+
+    TCGType type;
+    uint32_t step, i, n;
+    TCGOpcode opc;
+
+    check_size_align(oprsz, maxsz, dofs | aofs);
+    check_overlap_2(dofs, aofs, oprsz);
+    tcg_debug_assert(vece < MO_64);
+
+    /* Quick check for sizes we won't support inline.  */
+    if (oprsz > 4 * 32 || maxsz > MAX_UNROLL * 32) {
+        goto do_ool;
+    }
+
+    opc = is_sign ? (high ? INDEX_op_extsh_vec : INDEX_op_extsl_vec)
+                  : (high ? INDEX_op_extuh_vec : INDEX_op_extul_vec);
+
+    /* Since these operations don't operate in lock-step lanes,
+       we must care for overlap.  */
+    if (TCG_TARGET_HAS_v256 && oprsz % 32 == 0 && oprsz / 32 <= 8
+        && tcg_can_emit_vec_op(opc, TCG_TYPE_V256, vece)) {
+        type = TCG_TYPE_V256;
+        step = 32;
+        n = oprsz / 32;
+    } else if (TCG_TARGET_HAS_v128 && oprsz % 16 == 0 && oprsz / 16 <= 8
+               && tcg_can_emit_vec_op(opc, TCG_TYPE_V128, vece)) {
+        type = TCG_TYPE_V128;
+        step = 16;
+        n = oprsz / 16;
+    } else if (TCG_TARGET_HAS_v64 && oprsz % 8 == 0 && oprsz / 8 <= 8
+               && tcg_can_emit_vec_op(opc, TCG_TYPE_V64, vece)) {
+        type = TCG_TYPE_V64;
+        step = 8;
+        n = oprsz / 8;
+    } else {
+        goto do_ool;
+    }
+
+    if (n == 1) {
+        TCGv_vec t1 = tcg_temp_new_vec(type);
+
+        tcg_gen_ld_vec(t1, cpu_env, aofs);
+        if (high) {
+            if (is_sign) {
+                tcg_gen_extsh_vec(vece, t1, t1);
+            } else {
+                tcg_gen_extuh_vec(vece, t1, t1);
+            }
+        } else {
+            if (is_sign) {
+                tcg_gen_extsl_vec(vece, t1, t1);
+            } else {
+                tcg_gen_extul_vec(vece, t1, t1);
+            }
+        }
+        tcg_gen_st_vec(t1, cpu_env, dofs);
+        tcg_temp_free_vec(t1);
+    } else {
+        TCGv_vec ta[4], tmp;
+
+        if (high) {
+            aofs += oprsz / 2;
+        }
+
+        for (i = 0; i < (n / 2 + n % 2); ++i) {
+            ta[i] = tcg_temp_new_vec(type);
+            tcg_gen_ld_vec(ta[i], cpu_env, aofs + i * step);
+        }
+
+        tmp = tcg_temp_new_vec(type);
+        for (i = 0; i < n; ++i) {
+            if (i & 1) {
+                if (is_sign) {
+                    tcg_gen_extsh_vec(vece, tmp, ta[i / 2]);
+                } else {
+                    tcg_gen_extuh_vec(vece, tmp, ta[i / 2]);
+                }
+            } else {
+                if (is_sign) {
+                    tcg_gen_extsl_vec(vece, tmp, ta[i / 2]);
+                } else {
+                    tcg_gen_extul_vec(vece, tmp, ta[i / 2]);
+                }
+            }
+            tcg_gen_st_vec(tmp, cpu_env, dofs + i * step);
+        }
+        tcg_temp_free_vec(tmp);
+
+        for (i = 0; i < (n / 2 + n % 2); ++i) {
+            tcg_temp_free_vec(ta[i]);
+        }
+    }
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+    return;
+
+ do_ool:
+    if (high) {
+        aofs += oprsz / 2;
+    }
+    tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, 0,
+                       is_sign ? exts_fn[vece] : extu_fn[vece]);
+}
+
+void tcg_gen_gvec_extul(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz)
+{
+    do_ext(vece, dofs, aofs, oprsz, maxsz, false, false);
+}
+
+void tcg_gen_gvec_extuh(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz)
+{
+    do_ext(vece, dofs, aofs, oprsz, maxsz, true, false);
+}
+
+void tcg_gen_gvec_extsl(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz)
+{
+    do_ext(vece, dofs, aofs, oprsz, maxsz, false, true);
+}
+
+void tcg_gen_gvec_extsh(unsigned vece, uint32_t dofs, uint32_t aofs,
+                        uint32_t oprsz, uint32_t maxsz)
+{
+    do_ext(vece, dofs, aofs, oprsz, maxsz, true, true);
+}
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 9038cc6c84..a73d094ddb 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -525,3 +525,42 @@ void tcg_gen_mul_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
         tcg_expand_vec_op(INDEX_op_mul_vec, type, vece, ri, ai, bi);
     }
 }
+
+static void do_ext(TCGOpcode opc, unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGType type = rt->base_type;
+    int can;
+
+    tcg_debug_assert(at->base_type == type);
+    can = tcg_can_emit_vec_op(opc, type, vece);
+    if (can > 0) {
+        vec_gen_2(opc, type, vece, ri, ai);
+    } else {
+        tcg_debug_assert(can < 0);
+        tcg_expand_vec_op(opc, type, vece, ri, ai);
+    }
+}
+
+void tcg_gen_extul_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    do_ext(INDEX_op_extul_vec, vece, r, a);
+}
+
+void tcg_gen_extuh_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    do_ext(INDEX_op_extuh_vec, vece, r, a);
+}
+
+void tcg_gen_extsl_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    do_ext(INDEX_op_extsl_vec, vece, r, a);
+}
+
+void tcg_gen_extsh_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
+{
+    do_ext(INDEX_op_extsh_vec, vece, r, a);
+}
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5608391dca..8c0ee0a9db 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1427,6 +1427,12 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_trne_vec:
     case INDEX_op_trno_vec:
         return have_vec && TCG_TARGET_HAS_trn_vec;
+    case INDEX_op_extul_vec:
+    case INDEX_op_extsl_vec:
+        return have_vec && TCG_TARGET_HAS_extl_vec;
+    case INDEX_op_extuh_vec:
+    case INDEX_op_extsh_vec:
+        return have_vec && TCG_TARGET_HAS_exth_vec;
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
diff --git a/tcg/README b/tcg/README
index 17695ff7f6..56c70764bc 100644
--- a/tcg/README
+++ b/tcg/README
@@ -634,6 +634,19 @@ E.g. VECL=1 -> 64 << 1 -> v128, and VECE=2 -> 1 << 2 -> i32.
       v0[2i + 1] = v2[2i + part];
     }
 
+* extul_vec  v0, v1
+
+  Extend unsigned the low VECL/VECE/2 elements of v1 into v0.
+
+* extuh_vec  v0, v1
+
+  Similarly for the high VECL/VECE/2 elements.
+
+* extsl_vec  v0, v1
+* extsh_vec  v0, v1
+
+  Similarly with signed extension.
+
 * cmp_vec  v0, v1, v2, cond
 
   Compare vectors by element, storing -1 for true and 0 for false.
-- 
2.14.3

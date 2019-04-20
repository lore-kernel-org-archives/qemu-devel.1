Received: from eggs.gnu.org ([209.51.188.92]:40305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWr-0000E4-7x
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWp-0008KI-IA
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWp-0008IT-8r
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:15 -0400
Received: by mail-pf1-x443.google.com with SMTP id c207so3461875pfc.7
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 19 Apr 2019 21:34:21 -1000
Message-Id: <20190420073442.7488-18-richard.henderson@linaro.org>
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 17/38] tcg: Add gvec expanders for vector shift
 by scalar
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@redhat.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.h |   7 ++
 tcg/tcg-op.h      |   4 +
 tcg/tcg-op-gvec.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++
 tcg/tcg-op-vec.c  |  54 ++++++++++++
 4 files changed, 275 insertions(+)

diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index a0e0902f6c..f9c6058e92 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -318,6 +318,13 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t shift, uint32_t oprsz, uint32_t maxsz);
 
+void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz);
+
 void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
 void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index 833c6330b5..472b73cb38 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -986,6 +986,10 @@ void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
 
+void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 s);
+
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
 void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 40858a83e0..4eb0747ddd 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2617,6 +2617,216 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
     }
 }
 
+/*
+ * Specialized generation vector shifts by a non-constant scalar.
+ */
+
+static void expand_2sh_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                           uint32_t oprsz, uint32_t tysz, TCGType type,
+                           TCGv_i32 shift,
+                           void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_i32))
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += tysz) {
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
+        fni(vece, t0, t0, shift);
+        tcg_gen_st_vec(t0, cpu_env, dofs + i);
+    }
+    tcg_temp_free_vec(t0);
+}
+
+static void do_shifts(unsigned vece, uint32_t dofs, uint32_t aofs,
+                      TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz,
+                      void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32),
+                      void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64),
+                      void (*fniv_s)(unsigned, TCGv_vec, TCGv_vec, TCGv_i32),
+                      void (*fniv_v)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec),
+                      gen_helper_gvec_2 *fno,
+                      const TCGOpcode *s_list, const TCGOpcode *v_list)
+{
+    TCGType type;
+    uint32_t some;
+
+    check_size_align(oprsz, maxsz, dofs | aofs);
+    check_overlap_2(dofs, aofs, maxsz);
+
+    /* If the backend has a scalar expansion, great.  */
+    type = choose_vector_type(s_list, vece, oprsz, vece == MO_64);
+    if (type) {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
+        switch (type) {
+        case TCG_TYPE_V256:
+            some = QEMU_ALIGN_DOWN(oprsz, 32);
+            expand_2sh_vec(vece, dofs, aofs, some, 32,
+                           TCG_TYPE_V256, shift, fniv_s);
+            if (some == oprsz) {
+                break;
+            }
+            dofs += some;
+            aofs += some;
+            oprsz -= some;
+            maxsz -= some;
+            /* fallthru */
+        case TCG_TYPE_V128:
+            expand_2sh_vec(vece, dofs, aofs, oprsz, 16,
+                           TCG_TYPE_V128, shift, fniv_s);
+            break;
+        case TCG_TYPE_V64:
+            expand_2sh_vec(vece, dofs, aofs, oprsz, 8,
+                           TCG_TYPE_V64, shift, fniv_s);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        tcg_swap_vecop_list(hold_list);
+        goto clear_tail;
+    }
+
+    /* If the backend supports variable vector shifts, also cool.  */
+    type = choose_vector_type(v_list, vece, oprsz, vece == MO_64);
+    if (type) {
+        const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
+        TCGv_vec v_shift = tcg_temp_new_vec(type);
+
+        if (vece == MO_64) {
+            TCGv_i64 sh64 = tcg_temp_new_i64();
+            tcg_gen_extu_i32_i64(sh64, shift);
+            tcg_gen_dup_i64_vec(MO_64, v_shift, sh64);
+            tcg_temp_free_i64(sh64);
+        } else {
+            tcg_gen_dup_i32_vec(vece, v_shift, shift);
+        }
+
+        switch (type) {
+        case TCG_TYPE_V256:
+            some = QEMU_ALIGN_DOWN(oprsz, 32);
+            expand_2s_vec(vece, dofs, aofs, some, 32, TCG_TYPE_V256,
+                          v_shift, false, fniv_v);
+            if (some == oprsz) {
+                break;
+            }
+            dofs += some;
+            aofs += some;
+            oprsz -= some;
+            maxsz -= some;
+            /* fallthru */
+        case TCG_TYPE_V128:
+            expand_2s_vec(vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
+                          v_shift, false, fniv_v);
+            break;
+        case TCG_TYPE_V64:
+            expand_2s_vec(vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
+                          v_shift, false, fniv_v);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        tcg_temp_free_vec(v_shift);
+        tcg_swap_vecop_list(hold_list);
+        goto clear_tail;
+    }
+
+    /* Otherwise fall back to integral... */
+    if (fni8) {
+        TCGv_i64 sh64 = tcg_temp_new_i64();
+        tcg_gen_extu_i32_i64(sh64, shift);
+        expand_2s_i64(dofs, aofs, oprsz, sh64, false, fni8);
+        tcg_temp_free_i64(sh64);
+        goto clear_tail;
+    }
+    if (fni4) {
+        expand_2s_i32(dofs, aofs, oprsz, shift, false, fni4);
+        goto clear_tail;
+    }
+
+    /* Otherwise fall back to out of line.  */
+    tcg_debug_assert(fno);
+    {
+        TCGv_ptr a0 = tcg_temp_new_ptr();
+        TCGv_ptr a1 = tcg_temp_new_ptr();
+        TCGv_i32 desc = tcg_temp_new_i32();
+
+        tcg_gen_shli_i32(desc, shift, SIMD_DATA_SHIFT);
+        tcg_gen_ori_i32(desc, desc, simd_desc(oprsz, maxsz, 0));
+        tcg_gen_addi_ptr(a0, cpu_env, dofs);
+        tcg_gen_addi_ptr(a1, cpu_env, aofs);
+
+        fno(a0, a1, desc);
+
+        tcg_temp_free_ptr(a0);
+        tcg_temp_free_ptr(a1);
+        tcg_temp_free_i32(desc);
+        return;
+    }
+
+ clear_tail:
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
+void tcg_gen_gvec_shls(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode scalar_list[] = { INDEX_op_shls_vec, 0 };
+    static const TCGOpcode vector_list[] = { INDEX_op_shlv_vec, 0 };
+    static gen_helper_gvec_2 * const fno[4] = {
+        gen_helper_gvec_shl8i,
+        gen_helper_gvec_shl16i,
+        gen_helper_gvec_shl32i,
+        gen_helper_gvec_shl64i,
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    do_shifts(vece, dofs, aofs, shift, oprsz, maxsz,
+              vece == MO_32 ? tcg_gen_shl_i32 : NULL,
+              vece == MO_64 ? tcg_gen_shl_i64 : NULL,
+              tcg_gen_shls_vec, tcg_gen_shlv_vec, fno[vece],
+              scalar_list, vector_list);
+}
+
+void tcg_gen_gvec_shrs(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode scalar_list[] = { INDEX_op_shrs_vec, 0 };
+    static const TCGOpcode vector_list[] = { INDEX_op_shrv_vec, 0 };
+    static gen_helper_gvec_2 * const fno[4] = {
+        gen_helper_gvec_shr8i,
+        gen_helper_gvec_shr16i,
+        gen_helper_gvec_shr32i,
+        gen_helper_gvec_shr64i,
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    do_shifts(vece, dofs, aofs, shift, oprsz, maxsz,
+              vece == MO_32 ? tcg_gen_shr_i32 : NULL,
+              vece == MO_64 ? tcg_gen_shr_i64 : NULL,
+              tcg_gen_shrs_vec, tcg_gen_shrv_vec, fno[vece],
+              scalar_list, vector_list);
+}
+
+void tcg_gen_gvec_sars(unsigned vece, uint32_t dofs, uint32_t aofs,
+                       TCGv_i32 shift, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode scalar_list[] = { INDEX_op_sars_vec, 0 };
+    static const TCGOpcode vector_list[] = { INDEX_op_sarv_vec, 0 };
+    static gen_helper_gvec_2 * const fno[4] = {
+        gen_helper_gvec_sar8i,
+        gen_helper_gvec_sar16i,
+        gen_helper_gvec_sar32i,
+        gen_helper_gvec_sar64i,
+    };
+
+    tcg_debug_assert(vece <= MO_64);
+    do_shifts(vece, dofs, aofs, shift, oprsz, maxsz,
+              vece == MO_32 ? tcg_gen_sar_i32 : NULL,
+              vece == MO_64 ? tcg_gen_sar_i64 : NULL,
+              tcg_gen_sars_vec, tcg_gen_sarv_vec, fno[vece],
+              scalar_list, vector_list);
+}
+
 void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
                        uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
 {
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 8d80e37f72..5ec8e0b1a0 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -514,3 +514,57 @@ void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
     do_op3(vece, r, a, b, INDEX_op_sarv_vec);
 }
+
+static void do_shifts(unsigned vece, TCGv_vec r, TCGv_vec a,
+                      TCGv_i32 s, TCGOpcode opc_s, TCGOpcode opc_v)
+{
+    TCGTemp *rt = tcgv_vec_temp(r);
+    TCGTemp *at = tcgv_vec_temp(a);
+    TCGTemp *st = tcgv_i32_temp(s);
+    TCGArg ri = temp_arg(rt);
+    TCGArg ai = temp_arg(at);
+    TCGArg si = temp_arg(st);
+    TCGType type = rt->base_type;
+    const TCGOpcode *hold_list;
+    int can;
+
+    tcg_debug_assert(at->base_type >= type);
+    tcg_assert_listed_vecop(opc_s);
+    hold_list = tcg_swap_vecop_list(NULL);
+
+    can = tcg_can_emit_vec_op(opc_s, type, vece);
+    if (can > 0) {
+        vec_gen_3(opc_s, type, vece, ri, ai, si);
+    } else if (can < 0) {
+        tcg_expand_vec_op(opc_s, type, vece, ri, ai, si);
+    } else {
+        TCGv_vec vec_s = tcg_temp_new_vec(type);
+
+        if (vece == MO_64) {
+            TCGv_i64 s64 = tcg_temp_new_i64();
+            tcg_gen_extu_i32_i64(s64, s);
+            tcg_gen_dup_i64_vec(MO_64, vec_s, s64);
+            tcg_temp_free_i64(s64);
+        } else {
+            tcg_gen_dup_i32_vec(vece, vec_s, s);
+        }
+        do_op3(vece, r, a, vec_s, opc_v);
+        tcg_temp_free_vec(vec_s);
+    }
+    tcg_swap_vecop_list(hold_list);
+}
+
+void tcg_gen_shls_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
+{
+    do_shifts(vece, r, a, b, INDEX_op_shls_vec, INDEX_op_shlv_vec);
+}
+
+void tcg_gen_shrs_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
+{
+    do_shifts(vece, r, a, b, INDEX_op_shrs_vec, INDEX_op_shrv_vec);
+}
+
+void tcg_gen_sars_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_i32 b)
+{
+    do_shifts(vece, r, a, b, INDEX_op_sars_vec, INDEX_op_sarv_vec);
+}
-- 
2.17.1

Received: from eggs.gnu.org ([209.51.188.92]:43538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Grt-0003uB-F2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3Grq-0006V6-Ry
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 05:05:08 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 11 Mar 2019 10:03:09 +0100
Message-Id: <20190311090322.21603-21-cohuck@redhat.com>
In-Reply-To: <20190311090322.21603-1-cohuck@redhat.com>
References: <20190311090322.21603-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 20/33] s390x/tcg: Implement VECTOR PACK *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

This is a big one. Luckily we only have a limited set of such nasty
instructions.

We'll implement all variants with helpers, except when sources and
the destination don't overlap for VECTOR PACK. Provide different helpers
when the cc is to be modified. We'll return the cc then via env->cc_op.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190307121539.12842-20-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/helper.h           |  15 +++++
 target/s390x/insn-data.def      |   6 ++
 target/s390x/translate_vx.inc.c |  89 +++++++++++++++++++++++++++
 target/s390x/vec_helper.c       | 105 ++++++++++++++++++++++++++++++++
 4 files changed, 215 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6c745ba0f6ad..315495f49fc2 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -126,6 +126,21 @@ DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
 
 /* === Vector Support Instructions === */
 DEF_HELPER_FLAGS_4(vll, TCG_CALL_NO_WG, void, env, ptr, i64, i64)
+DEF_HELPER_FLAGS_4(gvec_vpk16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vpk32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vpk64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vpks16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vpks32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vpks64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
+DEF_HELPER_5(gvec_vpks_cc16, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vpks_cc32, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vpks_cc64, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_FLAGS_4(gvec_vpkls16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vpkls32, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vpkls64, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
+DEF_HELPER_5(gvec_vpkls_cc16, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vpkls_cc32, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vpkls_cc64, void, ptr, cptr, cptr, env, i32)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index f7232f861575..39cd6f27c159 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1014,6 +1014,12 @@
     F(0xe761, VMRH,    VRR_c, V,   0, 0, 0, 0, vmr, 0, IF_VEC)
 /* VECTOR MERGE LOW */
     F(0xe760, VMRL,    VRR_c, V,   0, 0, 0, 0, vmr, 0, IF_VEC)
+/* VECTOR PACK */
+    F(0xe794, VPK,     VRR_c, V,   0, 0, 0, 0, vpk, 0, IF_VEC)
+/* VECTOR PACK SATURATE */
+    F(0xe797, VPKS,    VRR_b, V,   0, 0, 0, 0, vpk, 0, IF_VEC)
+/* VECTOR PACK LOGICAL SATURATE */
+    F(0xe795, VPKLS,   VRR_b, V,   0, 0, 0, 0, vpk, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 9c2cf8a77b8f..7ae38f71f75e 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -135,6 +135,12 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
     tcg_temp_free_i64(tmp);
 }
 
+#define gen_gvec_3_ool(v1, v2, v3, data, fn) \
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                       vec_full_reg_offset(v3), 16, 16, data, fn)
+#define gen_gvec_3_ptr(v1, v2, v3, ptr, data, fn) \
+    tcg_gen_gvec_3_ptr(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                       vec_full_reg_offset(v3), ptr, 16, 16, data, fn)
 #define gen_gvec_dup_i64(es, v1, c) \
     tcg_gen_gvec_dup_i64(es, vec_full_reg_offset(v1), 16, 16, c)
 #define gen_gvec_mov(v1, v2) \
@@ -574,3 +580,86 @@ static DisasJumpType op_vmr(DisasContext *s, DisasOps *o)
     tcg_temp_free_i64(tmp);
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vpk(DisasContext *s, DisasOps *o)
+{
+    const uint8_t v1 = get_field(s->fields, v1);
+    const uint8_t v2 = get_field(s->fields, v2);
+    const uint8_t v3 = get_field(s->fields, v3);
+    const uint8_t es = get_field(s->fields, m4);
+    static gen_helper_gvec_3 * const vpk[3] = {
+        gen_helper_gvec_vpk16,
+        gen_helper_gvec_vpk32,
+        gen_helper_gvec_vpk64,
+    };
+     static gen_helper_gvec_3 * const vpks[3] = {
+        gen_helper_gvec_vpks16,
+        gen_helper_gvec_vpks32,
+        gen_helper_gvec_vpks64,
+    };
+    static gen_helper_gvec_3_ptr * const vpks_cc[3] = {
+        gen_helper_gvec_vpks_cc16,
+        gen_helper_gvec_vpks_cc32,
+        gen_helper_gvec_vpks_cc64,
+    };
+    static gen_helper_gvec_3 * const vpkls[3] = {
+        gen_helper_gvec_vpkls16,
+        gen_helper_gvec_vpkls32,
+        gen_helper_gvec_vpkls64,
+    };
+    static gen_helper_gvec_3_ptr * const vpkls_cc[3] = {
+        gen_helper_gvec_vpkls_cc16,
+        gen_helper_gvec_vpkls_cc32,
+        gen_helper_gvec_vpkls_cc64,
+    };
+
+    if (es == ES_8 || es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0x97:
+        if (get_field(s->fields, m5) & 0x1) {
+            gen_gvec_3_ptr(v1, v2, v3, cpu_env, 0, vpks_cc[es - 1]);
+            set_cc_static(s);
+        } else {
+            gen_gvec_3_ool(v1, v2, v3, 0, vpks[es - 1]);
+        }
+        break;
+    case 0x95:
+        if (get_field(s->fields, m5) & 0x1) {
+            gen_gvec_3_ptr(v1, v2, v3, cpu_env, 0, vpkls_cc[es - 1]);
+            set_cc_static(s);
+        } else {
+            gen_gvec_3_ool(v1, v2, v3, 0, vpkls[es - 1]);
+        }
+        break;
+    case 0x94:
+        /* If sources and destination dont't overlap -> fast path */
+        if (v1 != v2 && v1 != v3) {
+            const uint8_t src_es = get_field(s->fields, m4);
+            const uint8_t dst_es = src_es - 1;
+            TCGv_i64 tmp = tcg_temp_new_i64();
+            int dst_idx, src_idx;
+
+            for (dst_idx = 0; dst_idx < NUM_VEC_ELEMENTS(dst_es); dst_idx++) {
+                src_idx = dst_idx;
+                if (src_idx < NUM_VEC_ELEMENTS(src_es)) {
+                    read_vec_element_i64(tmp, v2, src_idx, src_es);
+                } else {
+                    src_idx -= NUM_VEC_ELEMENTS(src_es);
+                    read_vec_element_i64(tmp, v3, src_idx, src_es);
+                }
+                write_vec_element_i64(tmp, v1, dst_idx, dst_es);
+            }
+            tcg_temp_free_i64(tmp);
+        } else {
+            gen_gvec_3_ool(v1, v2, v3, 0, vpk[es - 1]);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_helper.c b/target/s390x/vec_helper.c
index 5b2333a8d666..7f680201b5f5 100644
--- a/target/s390x/vec_helper.c
+++ b/target/s390x/vec_helper.c
@@ -15,6 +15,7 @@
 #include "internal.h"
 #include "vec.h"
 #include "tcg/tcg.h"
+#include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
 #include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
@@ -42,3 +43,107 @@ void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
         *(S390Vector *)v1 = tmp;
     }
 }
+
+#define DEF_VPK_HFN(BITS, TBITS)                                               \
+typedef uint##TBITS##_t (*vpk##BITS##_fn)(uint##BITS##_t, int *);              \
+static int vpk##BITS##_hfn(S390Vector *v1, const S390Vector *v2,               \
+                           const S390Vector *v3, vpk##BITS##_fn fn)            \
+{                                                                              \
+    int i, saturated = 0;                                                      \
+    S390Vector tmp;                                                            \
+                                                                               \
+    for (i = 0; i < (128 / TBITS); i++) {                                      \
+        uint##BITS##_t src;                                                    \
+                                                                               \
+        if (i < (128 / BITS)) {                                                \
+            src = s390_vec_read_element##BITS(v2, i);                          \
+        } else {                                                               \
+            src = s390_vec_read_element##BITS(v3, i - (128 / BITS));           \
+        }                                                                      \
+        s390_vec_write_element##TBITS(&tmp, i, fn(src, &saturated));           \
+    }                                                                          \
+    *v1 = tmp;                                                                 \
+    return saturated;                                                          \
+}
+DEF_VPK_HFN(64, 32)
+DEF_VPK_HFN(32, 16)
+DEF_VPK_HFN(16, 8)
+
+#define DEF_VPK(BITS, TBITS)                                                   \
+static uint##TBITS##_t vpk##BITS##e(uint##BITS##_t src, int *saturated)        \
+{                                                                              \
+    return src;                                                                \
+}                                                                              \
+void HELPER(gvec_vpk##BITS)(void *v1, const void *v2, const void *v3,          \
+                            uint32_t desc)                                     \
+{                                                                              \
+    vpk##BITS##_hfn(v1, v2, v3, vpk##BITS##e);                                 \
+}
+DEF_VPK(64, 32)
+DEF_VPK(32, 16)
+DEF_VPK(16, 8)
+
+#define DEF_VPKS(BITS, TBITS)                                                  \
+static uint##TBITS##_t vpks##BITS##e(uint##BITS##_t src, int *saturated)       \
+{                                                                              \
+    if ((int##BITS##_t)src > INT##TBITS##_MAX) {                               \
+        (*saturated)++;                                                        \
+        return INT##TBITS##_MAX;                                               \
+    } else if ((int##BITS##_t)src < INT##TBITS##_MIN) {                        \
+        (*saturated)++;                                                        \
+        return INT##TBITS##_MIN;                                               \
+    }                                                                          \
+    return src;                                                                \
+}                                                                              \
+void HELPER(gvec_vpks##BITS)(void *v1, const void *v2, const void *v3,         \
+                             uint32_t desc)                                    \
+{                                                                              \
+    vpk##BITS##_hfn(v1, v2, v3, vpks##BITS##e);                                \
+}                                                                              \
+void HELPER(gvec_vpks_cc##BITS)(void *v1, const void *v2, const void *v3,      \
+                                CPUS390XState *env, uint32_t desc)             \
+{                                                                              \
+    int saturated = vpk##BITS##_hfn(v1, v2, v3, vpks##BITS##e);                \
+                                                                               \
+    if (saturated == (128 / TBITS)) {                                          \
+        env->cc_op = 3;                                                        \
+    } else if (saturated) {                                                    \
+        env->cc_op = 1;                                                        \
+    } else {                                                                   \
+        env->cc_op = 0;                                                        \
+    }                                                                          \
+}
+DEF_VPKS(64, 32)
+DEF_VPKS(32, 16)
+DEF_VPKS(16, 8)
+
+#define DEF_VPKLS(BITS, TBITS)                                                 \
+static uint##TBITS##_t vpkls##BITS##e(uint##BITS##_t src, int *saturated)      \
+{                                                                              \
+    if (src > UINT##TBITS##_MAX) {                                             \
+        (*saturated)++;                                                        \
+        return UINT##TBITS##_MAX;                                              \
+    }                                                                          \
+    return src;                                                                \
+}                                                                              \
+void HELPER(gvec_vpkls##BITS)(void *v1, const void *v2, const void *v3,        \
+                              uint32_t desc)                                   \
+{                                                                              \
+    vpk##BITS##_hfn(v1, v2, v3, vpkls##BITS##e);                               \
+}                                                                              \
+void HELPER(gvec_vpkls_cc##BITS)(void *v1, const void *v2, const void *v3,     \
+                                 CPUS390XState *env, uint32_t desc)            \
+{                                                                              \
+    int saturated = vpk##BITS##_hfn(v1, v2, v3, vpkls##BITS##e);               \
+                                                                               \
+    if (saturated == (128 / TBITS)) {                                          \
+        env->cc_op = 3;                                                        \
+    } else if (saturated) {                                                    \
+        env->cc_op = 1;                                                        \
+    } else {                                                                   \
+        env->cc_op = 0;                                                        \
+    }                                                                          \
+}
+DEF_VPKLS(64, 32)
+DEF_VPKLS(32, 16)
+DEF_VPKLS(16, 8)
-- 
2.17.2

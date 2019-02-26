Received: from eggs.gnu.org ([209.51.188.92]:47869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5q-00053y-AD
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gyb5o-0007KO-Et
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 06:40:13 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 26 Feb 2019 12:39:03 +0100
Message-Id: <20190226113915.20150-22-david@redhat.com>
In-Reply-To: <20190226113915.20150-1-david@redhat.com>
References: <20190226113915.20150-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 21/33] s390x/tcg: Implement VECTOR PACK
 (LOGICAL) SATURATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>

We'll implement both via gvec ool helpers. As these can't return
values, we'll return the CC via env->cc_op. Generate different C
functions for the different cases using makros.

In the future we might want to do a translation like VECTOR PACK or
use separate handlers in case no CC update is needed. As linux does
not seem to use the function right now, no need to tune for performance.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/helper.h           |  6 +++
 target/s390x/insn-data.def      |  4 ++
 target/s390x/translate_vx.inc.c | 37 ++++++++++++++++
 target/s390x/vec_helper.c       | 75 +++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 6c745ba0f6..4ea51618a5 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -126,6 +126,12 @@ DEF_HELPER_FLAGS_1(stck, TCG_CALL_NO_RWG_SE, i64, env)
 
 /* === Vector Support Instructions === */
 DEF_HELPER_FLAGS_4(vll, TCG_CALL_NO_WG, void, env, ptr, i64, i64)
+DEF_HELPER_5(gvec_vpks16, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vpks32, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vpks64, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vpkls16, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vpkls32, void, ptr, cptr, cptr, env, i32)
+DEF_HELPER_5(gvec_vpkls64, void, ptr, cptr, cptr, env, i32)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(servc, i32, env, i64, i64)
diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 8374a663bd..c0a011c118 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -1016,6 +1016,10 @@
     F(0xe760, VMRL,    VRR_c, V,   0, 0, 0, 0, vmr, 0, IF_VEC)
 /* VECTOR PACK */
     F(0xe794, VPK,     VRR_c, V,   0, 0, 0, 0, vpk, 0, IF_VEC)
+/* VECTOR PACK SATURATE */
+    F(0xe797, VPKS,    VRR_b, V,   0, 0, 0, 0, vpks, 0, IF_VEC)
+/* VECTOR PACK LOGICAL SATURATE */
+    F(0xe795, VPKLS,   VRR_b, V,   0, 0, 0, 0, vpks, 0, IF_VEC)
 
 #ifndef CONFIG_USER_ONLY
 /* COMPARE AND SWAP AND PURGE */
diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 842ff6a02f..d70ae3db3c 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -159,6 +159,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
     tcg_temp_free_i64(tmp);
 }
 
+#define gen_gvec_3_ptr(v1, v2, v3, ptr, data, fn) \
+    tcg_gen_gvec_3_ptr(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                       vec_full_reg_offset(v3), ptr, 16, 16, data, fn)
 #define gen_gvec_dup_i64(es, v1, c) \
     tcg_gen_gvec_dup_i64(es, vec_full_reg_offset(v1), 16, 16, c)
 #define gen_gvec_mov(v1, v2) \
@@ -565,3 +568,37 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *o)
     }
     return DISAS_NEXT;
 }
+
+static DisasJumpType op_vpks(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m4);
+    const uint8_t m5 = get_field(s->fields, m5);
+    static gen_helper_gvec_3_ptr * vpks[3] = {
+        gen_helper_gvec_vpks16,
+        gen_helper_gvec_vpks32,
+        gen_helper_gvec_vpks64,
+    };
+    static gen_helper_gvec_3_ptr * vpkls[3] = {
+        gen_helper_gvec_vpkls16,
+        gen_helper_gvec_vpkls32,
+        gen_helper_gvec_vpkls64,
+    };
+
+    if (es == MO_8 || es > MO_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    /* TODO: Separate translation/handlers in case we don't update the CC. */
+    if (s->fields->op2 == 0x97) {
+        gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+                       get_field(s->fields, v3), cpu_env, m5, vpks[es - 1]);
+    } else {
+        gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
+                       get_field(s->fields, v3), cpu_env, m5, vpkls[es - 1]);
+    }
+    if (m5 & 0x1) {
+        set_cc_static(s);
+    }
+    return DISAS_NEXT;
+}
diff --git a/target/s390x/vec_helper.c b/target/s390x/vec_helper.c
index d2f510ed07..9974471cc8 100644
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
@@ -108,3 +109,77 @@ void HELPER(vll)(CPUS390XState *env, void *v1, uint64_t addr, uint64_t bytes)
     }
     *(S390Vector *)v1 = tmp;
 }
+
+#define DEF_VPK_HFN(_BITS, _TBITS)                                             \
+typedef uint##_TBITS##_t (*vpk##_BITS##_fn)(uint##_BITS##_t, int *);           \
+static void vpk##_BITS##_hfn(CPUS390XState *env, S390Vector *v1,               \
+                             const S390Vector *v2, const S390Vector *v3,       \
+                             uint8_t m5, vpk##_BITS##_fn fn)                   \
+{                                                                              \
+    const uint8_t set_cc = m5 & 0x1;                                           \
+    int i, saturated = 0;                                                      \
+    S390Vector tmp;                                                            \
+                                                                               \
+    for (i = 0; i < (128 / _TBITS); i++) {                                     \
+        uint##_BITS##_t src;                                                   \
+                                                                               \
+        if (i < (128 / _BITS)) {                                               \
+            src = s390_vec_read_element##_BITS(v2, i);                         \
+        } else {                                                               \
+            src = s390_vec_read_element##_BITS(v3, i - (128 / _BITS));         \
+        }                                                                      \
+        s390_vec_write_element##_TBITS(&tmp, i, fn(src, &saturated));          \
+    }                                                                          \
+    *v1 = tmp;                                                                 \
+    if (set_cc) {                                                              \
+        if (saturated == i) {                                                  \
+            env->cc_op = 3;                                                    \
+        } else if (saturated) {                                                \
+            env->cc_op = 1;                                                    \
+        } else {                                                               \
+            env->cc_op = 0;                                                    \
+        }                                                                      \
+    }                                                                          \
+}
+DEF_VPK_HFN(64, 32)
+DEF_VPK_HFN(32, 16)
+DEF_VPK_HFN(16, 8)
+
+#define DEF_VPKS(_BITS, _TBITS)                                                \
+static uint##_TBITS##_t vpks##_BITS##e(uint##_BITS##_t src, int *saturated)    \
+{                                                                              \
+    if ((int##_BITS##_t)src > INT##_TBITS##_MAX) {                             \
+        (*saturated)++;                                                        \
+        return INT##_TBITS##_MAX;                                              \
+    } else if ((int##_BITS##_t)src < INT##_TBITS##_MIN) {                      \
+        (*saturated)++;                                                        \
+        return INT##_TBITS##_MIN;                                              \
+    }                                                                          \
+    return src;                                                                \
+}                                                                              \
+void HELPER(gvec_vpks##_BITS)(void *v1, const void *v2, const void *v3,        \
+                              CPUS390XState *env, uint32_t desc)               \
+{                                                                              \
+    vpk##_BITS##_hfn(env, v1, v2, v3, simd_data(desc), vpks##_BITS##e);        \
+}
+DEF_VPKS(64, 32)
+DEF_VPKS(32, 16)
+DEF_VPKS(16, 8)
+
+#define DEF_VPKLS(_BITS, _TBITS)                                               \
+static uint##_TBITS##_t vpkls##_BITS##e(uint##_BITS##_t src, int *saturated)   \
+{                                                                              \
+    if (src > UINT##_TBITS##_MAX) {                                            \
+        (*saturated)++;                                                        \
+        return UINT##_TBITS##_MAX;                                             \
+    }                                                                          \
+    return src;                                                                \
+}                                                                              \
+void HELPER(gvec_vpkls##_BITS)(void *v1, const void *v2, const void *v3,       \
+                               CPUS390XState *env, uint32_t desc)              \
+{                                                                              \
+    vpk##_BITS##_hfn(env, v1, v2, v3, simd_data(desc), vpkls##_BITS##e);       \
+}
+DEF_VPKLS(64, 32)
+DEF_VPKLS(32, 16)
+DEF_VPKLS(16, 8)
-- 
2.17.2

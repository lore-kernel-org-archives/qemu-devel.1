Received: from eggs.gnu.org ([2001:4830:134:3::10]:36088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3L-0000mM-Is
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3J-0007Yd-EZ
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:27 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3J-0007Rj-0q
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:25 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3I-0004rv-3W
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:24 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:56 +0100
Message-Id: <20180518172009.14416-20-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/32] target/arm: Implement SVE bitwise shift
 by wide elements (predicated)
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
Message-id: 20180516223007.10256-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 21 +++++++++++++++++++++
 target/arm/sve_helper.c    | 35 +++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 24 ++++++++++++++++++++++++
 target/arm/sve.decode      |  6 ++++++
 4 files changed, 86 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0cc02ee59e..d516580134 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -195,6 +195,27 @@ DEF_HELPER_FLAGS_5(sve_lsl_zpzz_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_5(sve_lsl_zpzz_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_asr_zpzw_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_asr_zpzw_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_asr_zpzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_lsr_zpzw_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsr_zpzw_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsr_zpzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_lsl_zpzw_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsl_zpzw_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_lsl_zpzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sve_orv_b, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_orv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_orv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ece3a81ad3..a5d12603e5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -465,6 +465,41 @@ DO_ZPZZ_D(sve_lsl_zpzz_d, uint64_t, DO_LSL)
 #undef DO_ZPZZ
 #undef DO_ZPZZ_D
 
+/* Three-operand expander, controlled by a predicate, in which the
+ * third operand is "wide".  That is, for D = N op M, the same 64-bit
+ * value of M is used with all of the narrower values of N.
+ */
+#define DO_ZPZW(NAME, TYPE, TYPEW, H, OP)                               \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
+{                                                                       \
+    intptr_t i, opr_sz = simd_oprsz(desc);                              \
+    for (i = 0; i < opr_sz; ) {                                         \
+        uint8_t pg = *(uint8_t *)(vg + H1(i >> 3));                     \
+        TYPEW mm = *(TYPEW *)(vm + i);                                  \
+        do {                                                            \
+            if (pg & 1) {                                               \
+                TYPE nn = *(TYPE *)(vn + H(i));                         \
+                *(TYPE *)(vd + H(i)) = OP(nn, mm);                      \
+            }                                                           \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);                     \
+        } while (i & 7);                                                \
+    }                                                                   \
+}
+
+DO_ZPZW(sve_asr_zpzw_b, int8_t, uint64_t, H1, DO_ASR)
+DO_ZPZW(sve_lsr_zpzw_b, uint8_t, uint64_t, H1, DO_LSR)
+DO_ZPZW(sve_lsl_zpzw_b, uint8_t, uint64_t, H1, DO_LSL)
+
+DO_ZPZW(sve_asr_zpzw_h, int16_t, uint64_t, H1_2, DO_ASR)
+DO_ZPZW(sve_lsr_zpzw_h, uint16_t, uint64_t, H1_2, DO_LSR)
+DO_ZPZW(sve_lsl_zpzw_h, uint16_t, uint64_t, H1_2, DO_LSL)
+
+DO_ZPZW(sve_asr_zpzw_s, int32_t, uint64_t, H1_4, DO_ASR)
+DO_ZPZW(sve_lsr_zpzw_s, uint32_t, uint64_t, H1_4, DO_LSR)
+DO_ZPZW(sve_lsl_zpzw_s, uint32_t, uint64_t, H1_4, DO_LSL)
+
+#undef DO_ZPZW
+
 /* Two-operand reduction expander, controlled by a predicate.
  * The difference between TYPERED and TYPERET has to do with
  * sign-extension.  E.g. for SMAX, TYPERED must be signed,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f0400e35d9..438df6359e 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -497,6 +497,30 @@ static bool trans_ASRD(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
     }
 }
 
+/*
+ *** SVE Bitwise Shift - Predicated Group
+ */
+
+#define DO_ZPZW(NAME, name) \
+static bool trans_##NAME##_zpzw(DisasContext *s, arg_rprr_esz *a,         \
+                                uint32_t insn)                            \
+{                                                                         \
+    static gen_helper_gvec_4 * const fns[3] = {                           \
+        gen_helper_sve_##name##_zpzw_b, gen_helper_sve_##name##_zpzw_h,   \
+        gen_helper_sve_##name##_zpzw_s,                                   \
+    };                                                                    \
+    if (a->esz < 0 || a->esz >= 3) {                                      \
+        return false;                                                     \
+    }                                                                     \
+    return do_zpzz_ool(s, a, fns[a->esz]);                                \
+}
+
+DO_ZPZW(ASR, asr)
+DO_ZPZW(LSR, lsr)
+DO_ZPZW(LSL, lsl)
+
+#undef DO_ZPZW
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 8267963b6b..1de289e55d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -157,6 +157,12 @@ ASR_zpzz        00000100 .. 010 100 100 ... ..... .....   @rdm_pg_rn # ASRR
 LSR_zpzz        00000100 .. 010 101 100 ... ..... .....   @rdm_pg_rn # LSRR
 LSL_zpzz        00000100 .. 010 111 100 ... ..... .....   @rdm_pg_rn # LSLR
 
+# SVE bitwise shift by wide elements (predicated)
+# Note these require size != 3.
+ASR_zpzw        00000100 .. 011 000 100 ... ..... .....         @rdn_pg_rm
+LSR_zpzw        00000100 .. 011 001 100 ... ..... .....         @rdn_pg_rm
+LSL_zpzw        00000100 .. 011 011 100 ... ..... .....         @rdn_pg_rm
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.17.0

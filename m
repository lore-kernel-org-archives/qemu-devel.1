Received: from eggs.gnu.org ([2001:4830:134:3::10]:41140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wI-0007gT-BF
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wE-0007Se-TH
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:30 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:41222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4wE-0007Rm-10
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:26 -0400
Received: by mail-pf0-x242.google.com with SMTP id v63-v6so1047963pfk.8
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:29:50 -0700
Message-Id: <20180516223007.10256-11-richard.henderson@linaro.org>
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3-a 10/27] target/arm: Implement SVE bitwise
 shift by immediate (predicated)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  25 ++++
 target/arm/sve_helper.c    | 264 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 130 ++++++++++++++++++
 target/arm/sve.decode      |  26 ++++
 4 files changed, 445 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 6b6bbeb272..b3c89579af 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -212,6 +212,31 @@ DEF_HELPER_FLAGS_3(sve_uminv_h, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_uminv_s, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_uminv_d, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(sve_clr_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_clr_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_clr_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sve_clr_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_asr_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_asr_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_asr_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_asr_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_lsr_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsr_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsr_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsr_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_lsl_zpzi_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsl_zpzi_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsl_zpzi_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_lsl_zpzi_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_asrd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_asrd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_asrd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_asrd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index c1719e407a..b6b9a08965 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -93,6 +93,150 @@ uint32_t HELPER(sve_predtest)(void *vd, void *vg, uint32_t words)
     return flags;
 }
 
+/* Expand active predicate bits to bytes, for byte elements.
+ *  for (i = 0; i < 256; ++i) {
+ *      unsigned long m = 0;
+ *      for (j = 0; j < 8; j++) {
+ *          if ((i >> j) & 1) {
+ *              m |= 0xfful << (j << 3);
+ *          }
+ *      }
+ *      printf("0x%016lx,\n", m);
+ *  }
+ */
+static inline uint64_t expand_pred_b(uint8_t byte)
+{
+    static const uint64_t word[256] = {
+        0x0000000000000000, 0x00000000000000ff, 0x000000000000ff00,
+        0x000000000000ffff, 0x0000000000ff0000, 0x0000000000ff00ff,
+        0x0000000000ffff00, 0x0000000000ffffff, 0x00000000ff000000,
+        0x00000000ff0000ff, 0x00000000ff00ff00, 0x00000000ff00ffff,
+        0x00000000ffff0000, 0x00000000ffff00ff, 0x00000000ffffff00,
+        0x00000000ffffffff, 0x000000ff00000000, 0x000000ff000000ff,
+        0x000000ff0000ff00, 0x000000ff0000ffff, 0x000000ff00ff0000,
+        0x000000ff00ff00ff, 0x000000ff00ffff00, 0x000000ff00ffffff,
+        0x000000ffff000000, 0x000000ffff0000ff, 0x000000ffff00ff00,
+        0x000000ffff00ffff, 0x000000ffffff0000, 0x000000ffffff00ff,
+        0x000000ffffffff00, 0x000000ffffffffff, 0x0000ff0000000000,
+        0x0000ff00000000ff, 0x0000ff000000ff00, 0x0000ff000000ffff,
+        0x0000ff0000ff0000, 0x0000ff0000ff00ff, 0x0000ff0000ffff00,
+        0x0000ff0000ffffff, 0x0000ff00ff000000, 0x0000ff00ff0000ff,
+        0x0000ff00ff00ff00, 0x0000ff00ff00ffff, 0x0000ff00ffff0000,
+        0x0000ff00ffff00ff, 0x0000ff00ffffff00, 0x0000ff00ffffffff,
+        0x0000ffff00000000, 0x0000ffff000000ff, 0x0000ffff0000ff00,
+        0x0000ffff0000ffff, 0x0000ffff00ff0000, 0x0000ffff00ff00ff,
+        0x0000ffff00ffff00, 0x0000ffff00ffffff, 0x0000ffffff000000,
+        0x0000ffffff0000ff, 0x0000ffffff00ff00, 0x0000ffffff00ffff,
+        0x0000ffffffff0000, 0x0000ffffffff00ff, 0x0000ffffffffff00,
+        0x0000ffffffffffff, 0x00ff000000000000, 0x00ff0000000000ff,
+        0x00ff00000000ff00, 0x00ff00000000ffff, 0x00ff000000ff0000,
+        0x00ff000000ff00ff, 0x00ff000000ffff00, 0x00ff000000ffffff,
+        0x00ff0000ff000000, 0x00ff0000ff0000ff, 0x00ff0000ff00ff00,
+        0x00ff0000ff00ffff, 0x00ff0000ffff0000, 0x00ff0000ffff00ff,
+        0x00ff0000ffffff00, 0x00ff0000ffffffff, 0x00ff00ff00000000,
+        0x00ff00ff000000ff, 0x00ff00ff0000ff00, 0x00ff00ff0000ffff,
+        0x00ff00ff00ff0000, 0x00ff00ff00ff00ff, 0x00ff00ff00ffff00,
+        0x00ff00ff00ffffff, 0x00ff00ffff000000, 0x00ff00ffff0000ff,
+        0x00ff00ffff00ff00, 0x00ff00ffff00ffff, 0x00ff00ffffff0000,
+        0x00ff00ffffff00ff, 0x00ff00ffffffff00, 0x00ff00ffffffffff,
+        0x00ffff0000000000, 0x00ffff00000000ff, 0x00ffff000000ff00,
+        0x00ffff000000ffff, 0x00ffff0000ff0000, 0x00ffff0000ff00ff,
+        0x00ffff0000ffff00, 0x00ffff0000ffffff, 0x00ffff00ff000000,
+        0x00ffff00ff0000ff, 0x00ffff00ff00ff00, 0x00ffff00ff00ffff,
+        0x00ffff00ffff0000, 0x00ffff00ffff00ff, 0x00ffff00ffffff00,
+        0x00ffff00ffffffff, 0x00ffffff00000000, 0x00ffffff000000ff,
+        0x00ffffff0000ff00, 0x00ffffff0000ffff, 0x00ffffff00ff0000,
+        0x00ffffff00ff00ff, 0x00ffffff00ffff00, 0x00ffffff00ffffff,
+        0x00ffffffff000000, 0x00ffffffff0000ff, 0x00ffffffff00ff00,
+        0x00ffffffff00ffff, 0x00ffffffffff0000, 0x00ffffffffff00ff,
+        0x00ffffffffffff00, 0x00ffffffffffffff, 0xff00000000000000,
+        0xff000000000000ff, 0xff0000000000ff00, 0xff0000000000ffff,
+        0xff00000000ff0000, 0xff00000000ff00ff, 0xff00000000ffff00,
+        0xff00000000ffffff, 0xff000000ff000000, 0xff000000ff0000ff,
+        0xff000000ff00ff00, 0xff000000ff00ffff, 0xff000000ffff0000,
+        0xff000000ffff00ff, 0xff000000ffffff00, 0xff000000ffffffff,
+        0xff0000ff00000000, 0xff0000ff000000ff, 0xff0000ff0000ff00,
+        0xff0000ff0000ffff, 0xff0000ff00ff0000, 0xff0000ff00ff00ff,
+        0xff0000ff00ffff00, 0xff0000ff00ffffff, 0xff0000ffff000000,
+        0xff0000ffff0000ff, 0xff0000ffff00ff00, 0xff0000ffff00ffff,
+        0xff0000ffffff0000, 0xff0000ffffff00ff, 0xff0000ffffffff00,
+        0xff0000ffffffffff, 0xff00ff0000000000, 0xff00ff00000000ff,
+        0xff00ff000000ff00, 0xff00ff000000ffff, 0xff00ff0000ff0000,
+        0xff00ff0000ff00ff, 0xff00ff0000ffff00, 0xff00ff0000ffffff,
+        0xff00ff00ff000000, 0xff00ff00ff0000ff, 0xff00ff00ff00ff00,
+        0xff00ff00ff00ffff, 0xff00ff00ffff0000, 0xff00ff00ffff00ff,
+        0xff00ff00ffffff00, 0xff00ff00ffffffff, 0xff00ffff00000000,
+        0xff00ffff000000ff, 0xff00ffff0000ff00, 0xff00ffff0000ffff,
+        0xff00ffff00ff0000, 0xff00ffff00ff00ff, 0xff00ffff00ffff00,
+        0xff00ffff00ffffff, 0xff00ffffff000000, 0xff00ffffff0000ff,
+        0xff00ffffff00ff00, 0xff00ffffff00ffff, 0xff00ffffffff0000,
+        0xff00ffffffff00ff, 0xff00ffffffffff00, 0xff00ffffffffffff,
+        0xffff000000000000, 0xffff0000000000ff, 0xffff00000000ff00,
+        0xffff00000000ffff, 0xffff000000ff0000, 0xffff000000ff00ff,
+        0xffff000000ffff00, 0xffff000000ffffff, 0xffff0000ff000000,
+        0xffff0000ff0000ff, 0xffff0000ff00ff00, 0xffff0000ff00ffff,
+        0xffff0000ffff0000, 0xffff0000ffff00ff, 0xffff0000ffffff00,
+        0xffff0000ffffffff, 0xffff00ff00000000, 0xffff00ff000000ff,
+        0xffff00ff0000ff00, 0xffff00ff0000ffff, 0xffff00ff00ff0000,
+        0xffff00ff00ff00ff, 0xffff00ff00ffff00, 0xffff00ff00ffffff,
+        0xffff00ffff000000, 0xffff00ffff0000ff, 0xffff00ffff00ff00,
+        0xffff00ffff00ffff, 0xffff00ffffff0000, 0xffff00ffffff00ff,
+        0xffff00ffffffff00, 0xffff00ffffffffff, 0xffffff0000000000,
+        0xffffff00000000ff, 0xffffff000000ff00, 0xffffff000000ffff,
+        0xffffff0000ff0000, 0xffffff0000ff00ff, 0xffffff0000ffff00,
+        0xffffff0000ffffff, 0xffffff00ff000000, 0xffffff00ff0000ff,
+        0xffffff00ff00ff00, 0xffffff00ff00ffff, 0xffffff00ffff0000,
+        0xffffff00ffff00ff, 0xffffff00ffffff00, 0xffffff00ffffffff,
+        0xffffffff00000000, 0xffffffff000000ff, 0xffffffff0000ff00,
+        0xffffffff0000ffff, 0xffffffff00ff0000, 0xffffffff00ff00ff,
+        0xffffffff00ffff00, 0xffffffff00ffffff, 0xffffffffff000000,
+        0xffffffffff0000ff, 0xffffffffff00ff00, 0xffffffffff00ffff,
+        0xffffffffffff0000, 0xffffffffffff00ff, 0xffffffffffffff00,
+        0xffffffffffffffff,
+    };
+    return word[byte];
+}
+
+/* Similarly for half-word elements.
+ *  for (i = 0; i < 256; ++i) {
+ *      unsigned long m = 0;
+ *      if (i & 0xaa) {
+ *          continue;
+ *      }
+ *      for (j = 0; j < 8; j += 2) {
+ *          if ((i >> j) & 1) {
+ *              m |= 0xfffful << (j << 3);
+ *          }
+ *      }
+ *      printf("[0x%x] = 0x%016lx,\n", i, m);
+ *  }
+ */
+static inline uint64_t expand_pred_h(uint8_t byte)
+{
+    static const uint64_t word[] = {
+        [0x01] = 0x000000000000ffff, [0x04] = 0x00000000ffff0000,
+        [0x05] = 0x00000000ffffffff, [0x10] = 0x0000ffff00000000,
+        [0x11] = 0x0000ffff0000ffff, [0x14] = 0x0000ffffffff0000,
+        [0x15] = 0x0000ffffffffffff, [0x40] = 0xffff000000000000,
+        [0x41] = 0xffff00000000ffff, [0x44] = 0xffff0000ffff0000,
+        [0x45] = 0xffff0000ffffffff, [0x50] = 0xffffffff00000000,
+        [0x51] = 0xffffffff0000ffff, [0x54] = 0xffffffffffff0000,
+        [0x55] = 0xffffffffffffffff,
+    };
+    return word[byte & 0x55];
+}
+
+/* Similarly for single word elements.  */
+static inline uint64_t expand_pred_s(uint8_t byte)
+{
+    static const uint64_t word[] = {
+        [0x01] = 0x00000000ffffffffull,
+        [0x10] = 0xffffffff00000000ull,
+        [0x11] = 0xffffffffffffffffull,
+    };
+    return word[byte & 0x11];
+}
+
 #define LOGICAL_PPPP(NAME, FUNC) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
 {                                                                         \
@@ -484,3 +628,123 @@ uint32_t HELPER(sve_pnext)(void *vd, void *vg, uint32_t pred_desc)
 
     return flags;
 }
+
+/* Store zero into every active element of Zd.  We will use this for two
+ * and three-operand predicated instructions for which logic dictates a
+ * zero result.  In particular, logical shift by element size, which is
+ * otherwise undefined on the host.
+ *
+ * For element sizes smaller than uint64_t, we use tables to expand
+ * the N bits of the controlling predicate to a byte mask, and clear
+ * those bytes.
+ */
+void HELPER(sve_clr_b)(void *vd, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] &= ~expand_pred_b(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_clr_h)(void *vd, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] &= ~expand_pred_h(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_clr_s)(void *vd, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        d[i] &= ~expand_pred_s(pg[H1(i)]);
+    }
+}
+
+void HELPER(sve_clr_d)(void *vd, void *vg, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd;
+    uint8_t *pg = vg;
+    for (i = 0; i < opr_sz; i += 1) {
+        if (pg[H1(i)] & 1) {
+            d[i] = 0;
+        }
+    }
+}
+
+/* Three-operand expander, immediate operand, controlled by a predicate.
+ */
+#define DO_ZPZI(NAME, TYPE, H, OP)                              \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)  \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc);                      \
+    TYPE imm = simd_data(desc);                                 \
+    for (i = 0; i < opr_sz; ) {                                 \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));         \
+        do {                                                    \
+            if (pg & 1) {                                       \
+                TYPE nn = *(TYPE *)(vn + H(i));                 \
+                *(TYPE *)(vd + H(i)) = OP(nn, imm);             \
+            }                                                   \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);             \
+        } while (i & 15);                                       \
+    }                                                           \
+}
+
+/* Similarly, specialized for 64-bit operands.  */
+#define DO_ZPZI_D(NAME, TYPE, OP)                               \
+void HELPER(NAME)(void *vd, void *vn, void *vg, uint32_t desc)  \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;                  \
+    TYPE *d = vd, *n = vn;                                      \
+    TYPE imm = simd_data(desc);                                 \
+    uint8_t *pg = vg;                                           \
+    for (i = 0; i < opr_sz; i += 1) {                           \
+        if (pg[H1(i)] & 1) {                                    \
+            TYPE nn = n[i];                                     \
+            d[i] = OP(nn, imm);                                 \
+        }                                                       \
+    }                                                           \
+}
+
+#define DO_SHR(N, M)  (N >> M)
+#define DO_SHL(N, M)  (N << M)
+
+/* Arithmetic shift right for division.  This rounds negative numbers
+   toward zero as per signed division.  Therefore before shifting,
+   when N is negative, add 2**M-1.  */
+#define DO_ASRD(N, M) ((N + (N < 0 ? ((__typeof(N))1 << M) - 1 : 0)) >> M)
+
+DO_ZPZI(sve_asr_zpzi_b, int8_t, H1, DO_SHR)
+DO_ZPZI(sve_asr_zpzi_h, int16_t, H1_2, DO_SHR)
+DO_ZPZI(sve_asr_zpzi_s, int32_t, H1_4, DO_SHR)
+DO_ZPZI_D(sve_asr_zpzi_d, int64_t, DO_SHR)
+
+DO_ZPZI(sve_lsr_zpzi_b, uint8_t, H1, DO_SHR)
+DO_ZPZI(sve_lsr_zpzi_h, uint16_t, H1_2, DO_SHR)
+DO_ZPZI(sve_lsr_zpzi_s, uint32_t, H1_4, DO_SHR)
+DO_ZPZI_D(sve_lsr_zpzi_d, uint64_t, DO_SHR)
+
+DO_ZPZI(sve_lsl_zpzi_b, uint8_t, H1, DO_SHL)
+DO_ZPZI(sve_lsl_zpzi_h, uint16_t, H1_2, DO_SHL)
+DO_ZPZI(sve_lsl_zpzi_s, uint32_t, H1_4, DO_SHL)
+DO_ZPZI_D(sve_lsl_zpzi_d, uint64_t, DO_SHL)
+
+DO_ZPZI(sve_asrd_b, int8_t, H1, DO_ASRD)
+DO_ZPZI(sve_asrd_h, int16_t, H1_2, DO_ASRD)
+DO_ZPZI(sve_asrd_s, int32_t, H1_4, DO_ASRD)
+DO_ZPZI_D(sve_asrd_d, int64_t, DO_ASRD)
+
+#undef DO_SHR
+#undef DO_SHL
+#undef DO_ASRD
+#undef DO_ZPZI
+#undef DO_ZPZI_D
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 66ef01712d..7607a90a4a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -33,6 +33,30 @@
 #include "trace-tcg.h"
 #include "translate-a64.h"
 
+/*
+ * Helpers for extracting complex instruction fields.
+ */
+
+/* See e.g. ASR (immediate, predicated).
+ * Returns -1 for unallocated encoding; diagnose later.
+ */
+static int tszimm_esz(int x)
+{
+    x >>= 3;  /* discard imm3 */
+    return 31 - clz32(x);
+}
+
+static int tszimm_shr(int x)
+{
+    return (16 << tszimm_esz(x)) - x;
+}
+
+/* See e.g. LSL (immediate, predicated).  */
+static int tszimm_shl(int x)
+{
+    return x - (8 << tszimm_esz(x));
+}
+
 /*
  * Include the generated decoder.
  */
@@ -363,6 +387,112 @@ static bool trans_SADDV(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
 
 #undef DO_VPZ
 
+/*
+ *** SVE Shift by Immediate - Predicated Group
+ */
+
+/* Store zero into every active element of Zd.  We will use this for two
+ * and three-operand predicated instructions for which logic dictates a
+ * zero result.
+ */
+static bool do_clr_zp(DisasContext *s, int rd, int pg, int esz)
+{
+    static gen_helper_gvec_2 * const fns[4] = {
+        gen_helper_sve_clr_b, gen_helper_sve_clr_h,
+        gen_helper_sve_clr_s, gen_helper_sve_clr_d,
+    };
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, rd),
+                           pred_full_reg_offset(s, pg),
+                           vsz, vsz, 0, fns[esz]);
+    }
+    return true;
+}
+
+static bool do_zpzi_ool(DisasContext *s, arg_rpri_esz *a,
+                        gen_helper_gvec_3 *fn)
+{
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           pred_full_reg_offset(s, a->pg),
+                           vsz, vsz, a->imm, fn);
+    }
+    return true;
+}
+
+static bool trans_ASR_zpzi(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_asr_zpzi_b, gen_helper_sve_asr_zpzi_h,
+        gen_helper_sve_asr_zpzi_s, gen_helper_sve_asr_zpzi_d,
+    };
+    if (a->esz < 0) {
+        /* Invalid tsz encoding -- see tszimm_esz. */
+        return false;
+    }
+    /* Shift by element size is architecturally valid.  For
+       arithmetic right-shift, it's the same as by one less. */
+    a->imm = MIN(a->imm, (8 << a->esz) - 1);
+    return do_zpzi_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_LSR_zpzi(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_lsr_zpzi_b, gen_helper_sve_lsr_zpzi_h,
+        gen_helper_sve_lsr_zpzi_s, gen_helper_sve_lsr_zpzi_d,
+    };
+    if (a->esz < 0) {
+        return false;
+    }
+    /* Shift by element size is architecturally valid.
+       For logical shifts, it is a zeroing operation.  */
+    if (a->imm >= (8 << a->esz)) {
+        return do_clr_zp(s, a->rd, a->pg, a->esz);
+    } else {
+        return do_zpzi_ool(s, a, fns[a->esz]);
+    }
+}
+
+static bool trans_LSL_zpzi(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_lsl_zpzi_b, gen_helper_sve_lsl_zpzi_h,
+        gen_helper_sve_lsl_zpzi_s, gen_helper_sve_lsl_zpzi_d,
+    };
+    if (a->esz < 0) {
+        return false;
+    }
+    /* Shift by element size is architecturally valid.
+       For logical shifts, it is a zeroing operation.  */
+    if (a->imm >= (8 << a->esz)) {
+        return do_clr_zp(s, a->rd, a->pg, a->esz);
+    } else {
+        return do_zpzi_ool(s, a, fns[a->esz]);
+    }
+}
+
+static bool trans_ASRD(DisasContext *s, arg_rpri_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_asrd_b, gen_helper_sve_asrd_h,
+        gen_helper_sve_asrd_s, gen_helper_sve_asrd_d,
+    };
+    if (a->esz < 0) {
+        return false;
+    }
+    /* Shift by element size is architecturally valid.  For arithmetic
+       right shift for division, it is a zeroing operation.  */
+    if (a->imm >= (8 << a->esz)) {
+        return do_clr_zp(s, a->rd, a->pg, a->esz);
+    } else {
+        return do_zpzi_ool(s, a, fns[a->esz]);
+    }
+}
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index ba27ff0979..a1791c1d7b 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -22,8 +22,16 @@
 ###########################################################################
 # Named fields.  These are primarily for disjoint fields.
 
+%imm6_22_5      22:1 5:5
 %imm9_16_10     16:s6 10:3
 
+# A combination of tsz:imm3 -- extract esize.
+%tszimm_esz     22:2 5:5 !function=tszimm_esz
+# A combination of tsz:imm3 -- extract (2 * esize) - (tsz:imm3)
+%tszimm_shr     22:2 5:5 !function=tszimm_shr
+# A combination of tsz:imm3 -- extract (tsz:imm3) - esize
+%tszimm_shl     22:2 5:5 !function=tszimm_shl
+
 # Either a copy of rd (at bit 0), or a different source
 # as propagated via the MOVPRFX instruction.
 %reg_movprfx    0:5
@@ -39,6 +47,7 @@
 &rpr_esz        rd pg rn esz
 &rprr_s         rd pg rn rm s
 &rprr_esz       rd pg rn rm esz
+&rpri_esz       rd pg rn imm esz
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -65,6 +74,11 @@
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
 
+# Two register operand, one immediate operand, with predicate,
+# element size encoded as TSZHL.  User must fill in imm.
+@rdn_pg_tszimm  ........ .. ... ... ... pg:3 ..... rd:5 \
+                &rpri_esz rn=%reg_movprfx esz=%tszimm_esz
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9       ........ ........ ...... rn:5 . rd:4    \
                 &rri imm=%imm9_16_10
@@ -123,6 +137,18 @@ UMAXV           00000100 .. 001 001 001 ... ..... .....         @rd_pg_rn
 SMINV           00000100 .. 001 010 001 ... ..... .....         @rd_pg_rn
 UMINV           00000100 .. 001 011 001 ... ..... .....         @rd_pg_rn
 
+### SVE Shift by Immediate - Predicated Group
+
+# SVE bitwise shift by immediate (predicated)
+ASR_zpzi        00000100 .. 000 000 100 ... .. ... ..... \
+                @rdn_pg_tszimm imm=%tszimm_shr
+LSR_zpzi        00000100 .. 000 001 100 ... .. ... ..... \
+                @rdn_pg_tszimm imm=%tszimm_shr
+LSL_zpzi        00000100 .. 000 011 100 ... .. ... ..... \
+                @rdn_pg_tszimm imm=%tszimm_shl
+ASRD            00000100 .. 000 100 100 ... .. ... ..... \
+                @rdn_pg_tszimm imm=%tszimm_shr
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.17.0

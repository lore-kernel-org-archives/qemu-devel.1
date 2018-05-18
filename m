Received: from eggs.gnu.org ([2001:4830:134:3::10]:36079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3L-0000ld-4y
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3H-0007Vk-2C
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41784)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3F-0007Rj-UF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3E-0004q9-Su
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:20 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:52 +0100
Message-Id: <20180518172009.14416-16-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/32] target/arm: Implement SVE Integer Binary
 Arithmetic - Predicated Group
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180516223007.10256-9-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 145 +++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 194 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  68 +++++++++++++
 target/arm/sve.decode      |  42 ++++++++
 4 files changed, 449 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0c04afff8c..5b82ba1501 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -23,6 +23,151 @@ DEF_HELPER_FLAGS_3(sve_predtest, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_pfirst, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_pnext, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_and_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_and_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_and_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_and_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_eor_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_eor_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_eor_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_eor_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_orr_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_orr_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_orr_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_orr_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_bic_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_bic_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_bic_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_bic_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_add_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_add_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_add_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_add_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_sub_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sub_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sub_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sub_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_smax_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_smax_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_smax_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_smax_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_umax_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_umax_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_umax_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_umax_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_smin_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_smin_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_smin_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_smin_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_umin_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_umin_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_umin_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_umin_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_sabd_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sabd_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sabd_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sabd_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_uabd_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_uabd_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_uabd_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_uabd_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_mul_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_mul_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_mul_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_mul_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_smulh_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_smulh_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_smulh_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_smulh_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_umulh_zpzz_b, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_umulh_zpzz_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_umulh_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_umulh_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_sdiv_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_sdiv_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_udiv_zpzz_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_udiv_zpzz_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index cc164edfe8..b8c8a06122 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -25,6 +25,22 @@
 #include "tcg/tcg-gvec-desc.h"
 
 
+/* Note that vector data is stored in host-endian 64-bit chunks,
+   so addressing units smaller than that needs a host-endian fixup.  */
+#ifdef HOST_WORDS_BIGENDIAN
+#define H1(x)   ((x) ^ 7)
+#define H1_2(x) ((x) ^ 6)
+#define H1_4(x) ((x) ^ 4)
+#define H2(x)   ((x) ^ 3)
+#define H4(x)   ((x) ^ 1)
+#else
+#define H1(x)   (x)
+#define H1_2(x) (x)
+#define H1_4(x) (x)
+#define H2(x)   (x)
+#define H4(x)   (x)
+#endif
+
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
  *
  * The return value has bit 31 set if N is set, bit 1 set if Z is clear,
@@ -116,6 +132,184 @@ LOGICAL_PPPP(sve_nand_pppp, DO_NAND)
 #undef DO_SEL
 #undef LOGICAL_PPPP
 
+/* Fully general three-operand expander, controlled by a predicate.
+ * This is complicated by the host-endian storage of the register file.
+ */
+/* ??? I don't expect the compiler could ever vectorize this itself.
+ * With some tables we can convert bit masks to byte masks, and with
+ * extra care wrt byte/word ordering we could use gcc generic vectors
+ * and do 16 bytes at a time.
+ */
+#define DO_ZPZZ(NAME, TYPE, H, OP)                                       \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
+{                                                                       \
+    intptr_t i, opr_sz = simd_oprsz(desc);                              \
+    for (i = 0; i < opr_sz; ) {                                         \
+        uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
+        do {                                                            \
+            if (pg & 1) {                                               \
+                TYPE nn = *(TYPE *)(vn + H(i));                         \
+                TYPE mm = *(TYPE *)(vm + H(i));                         \
+                *(TYPE *)(vd + H(i)) = OP(nn, mm);                      \
+            }                                                           \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);                     \
+        } while (i & 15);                                               \
+    }                                                                   \
+}
+
+/* Similarly, specialized for 64-bit operands.  */
+#define DO_ZPZZ_D(NAME, TYPE, OP)                                \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
+{                                                               \
+    intptr_t i, opr_sz = simd_oprsz(desc) / 8;                  \
+    TYPE *d = vd, *n = vn, *m = vm;                             \
+    uint8_t *pg = vg;                                           \
+    for (i = 0; i < opr_sz; i += 1) {                           \
+        if (pg[H1(i)] & 1) {                                    \
+            TYPE nn = n[i], mm = m[i];                          \
+            d[i] = OP(nn, mm);                                  \
+        }                                                       \
+    }                                                           \
+}
+
+#define DO_AND(N, M)  (N & M)
+#define DO_EOR(N, M)  (N ^ M)
+#define DO_ORR(N, M)  (N | M)
+#define DO_BIC(N, M)  (N & ~M)
+#define DO_ADD(N, M)  (N + M)
+#define DO_SUB(N, M)  (N - M)
+#define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
+#define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
+#define DO_ABD(N, M)  ((N) >= (M) ? (N) - (M) : (M) - (N))
+#define DO_MUL(N, M)  (N * M)
+#define DO_DIV(N, M)  (M ? N / M : 0)
+
+DO_ZPZZ(sve_and_zpzz_b, uint8_t, H1, DO_AND)
+DO_ZPZZ(sve_and_zpzz_h, uint16_t, H1_2, DO_AND)
+DO_ZPZZ(sve_and_zpzz_s, uint32_t, H1_4, DO_AND)
+DO_ZPZZ_D(sve_and_zpzz_d, uint64_t, DO_AND)
+
+DO_ZPZZ(sve_orr_zpzz_b, uint8_t, H1, DO_ORR)
+DO_ZPZZ(sve_orr_zpzz_h, uint16_t, H1_2, DO_ORR)
+DO_ZPZZ(sve_orr_zpzz_s, uint32_t, H1_4, DO_ORR)
+DO_ZPZZ_D(sve_orr_zpzz_d, uint64_t, DO_ORR)
+
+DO_ZPZZ(sve_eor_zpzz_b, uint8_t, H1, DO_EOR)
+DO_ZPZZ(sve_eor_zpzz_h, uint16_t, H1_2, DO_EOR)
+DO_ZPZZ(sve_eor_zpzz_s, uint32_t, H1_4, DO_EOR)
+DO_ZPZZ_D(sve_eor_zpzz_d, uint64_t, DO_EOR)
+
+DO_ZPZZ(sve_bic_zpzz_b, uint8_t, H1, DO_BIC)
+DO_ZPZZ(sve_bic_zpzz_h, uint16_t, H1_2, DO_BIC)
+DO_ZPZZ(sve_bic_zpzz_s, uint32_t, H1_4, DO_BIC)
+DO_ZPZZ_D(sve_bic_zpzz_d, uint64_t, DO_BIC)
+
+DO_ZPZZ(sve_add_zpzz_b, uint8_t, H1, DO_ADD)
+DO_ZPZZ(sve_add_zpzz_h, uint16_t, H1_2, DO_ADD)
+DO_ZPZZ(sve_add_zpzz_s, uint32_t, H1_4, DO_ADD)
+DO_ZPZZ_D(sve_add_zpzz_d, uint64_t, DO_ADD)
+
+DO_ZPZZ(sve_sub_zpzz_b, uint8_t, H1, DO_SUB)
+DO_ZPZZ(sve_sub_zpzz_h, uint16_t, H1_2, DO_SUB)
+DO_ZPZZ(sve_sub_zpzz_s, uint32_t, H1_4, DO_SUB)
+DO_ZPZZ_D(sve_sub_zpzz_d, uint64_t, DO_SUB)
+
+DO_ZPZZ(sve_smax_zpzz_b, int8_t, H1, DO_MAX)
+DO_ZPZZ(sve_smax_zpzz_h, int16_t, H1_2, DO_MAX)
+DO_ZPZZ(sve_smax_zpzz_s, int32_t, H1_4, DO_MAX)
+DO_ZPZZ_D(sve_smax_zpzz_d, int64_t, DO_MAX)
+
+DO_ZPZZ(sve_umax_zpzz_b, uint8_t, H1, DO_MAX)
+DO_ZPZZ(sve_umax_zpzz_h, uint16_t, H1_2, DO_MAX)
+DO_ZPZZ(sve_umax_zpzz_s, uint32_t, H1_4, DO_MAX)
+DO_ZPZZ_D(sve_umax_zpzz_d, uint64_t, DO_MAX)
+
+DO_ZPZZ(sve_smin_zpzz_b, int8_t,  H1, DO_MIN)
+DO_ZPZZ(sve_smin_zpzz_h, int16_t,  H1_2, DO_MIN)
+DO_ZPZZ(sve_smin_zpzz_s, int32_t,  H1_4, DO_MIN)
+DO_ZPZZ_D(sve_smin_zpzz_d, int64_t,  DO_MIN)
+
+DO_ZPZZ(sve_umin_zpzz_b, uint8_t, H1, DO_MIN)
+DO_ZPZZ(sve_umin_zpzz_h, uint16_t, H1_2, DO_MIN)
+DO_ZPZZ(sve_umin_zpzz_s, uint32_t, H1_4, DO_MIN)
+DO_ZPZZ_D(sve_umin_zpzz_d, uint64_t, DO_MIN)
+
+DO_ZPZZ(sve_sabd_zpzz_b, int8_t,  H1, DO_ABD)
+DO_ZPZZ(sve_sabd_zpzz_h, int16_t,  H1_2, DO_ABD)
+DO_ZPZZ(sve_sabd_zpzz_s, int32_t,  H1_4, DO_ABD)
+DO_ZPZZ_D(sve_sabd_zpzz_d, int64_t,  DO_ABD)
+
+DO_ZPZZ(sve_uabd_zpzz_b, uint8_t, H1, DO_ABD)
+DO_ZPZZ(sve_uabd_zpzz_h, uint16_t, H1_2, DO_ABD)
+DO_ZPZZ(sve_uabd_zpzz_s, uint32_t, H1_4, DO_ABD)
+DO_ZPZZ_D(sve_uabd_zpzz_d, uint64_t, DO_ABD)
+
+/* Because the computation type is at least twice as large as required,
+   these work for both signed and unsigned source types.  */
+static inline uint8_t do_mulh_b(int32_t n, int32_t m)
+{
+    return (n * m) >> 8;
+}
+
+static inline uint16_t do_mulh_h(int32_t n, int32_t m)
+{
+    return (n * m) >> 16;
+}
+
+static inline uint32_t do_mulh_s(int64_t n, int64_t m)
+{
+    return (n * m) >> 32;
+}
+
+static inline uint64_t do_smulh_d(uint64_t n, uint64_t m)
+{
+    uint64_t lo, hi;
+    muls64(&lo, &hi, n, m);
+    return hi;
+}
+
+static inline uint64_t do_umulh_d(uint64_t n, uint64_t m)
+{
+    uint64_t lo, hi;
+    mulu64(&lo, &hi, n, m);
+    return hi;
+}
+
+DO_ZPZZ(sve_mul_zpzz_b, uint8_t, H1, DO_MUL)
+DO_ZPZZ(sve_mul_zpzz_h, uint16_t, H1_2, DO_MUL)
+DO_ZPZZ(sve_mul_zpzz_s, uint32_t, H1_4, DO_MUL)
+DO_ZPZZ_D(sve_mul_zpzz_d, uint64_t, DO_MUL)
+
+DO_ZPZZ(sve_smulh_zpzz_b, int8_t, H1, do_mulh_b)
+DO_ZPZZ(sve_smulh_zpzz_h, int16_t, H1_2, do_mulh_h)
+DO_ZPZZ(sve_smulh_zpzz_s, int32_t, H1_4, do_mulh_s)
+DO_ZPZZ_D(sve_smulh_zpzz_d, uint64_t, do_smulh_d)
+
+DO_ZPZZ(sve_umulh_zpzz_b, uint8_t, H1, do_mulh_b)
+DO_ZPZZ(sve_umulh_zpzz_h, uint16_t, H1_2, do_mulh_h)
+DO_ZPZZ(sve_umulh_zpzz_s, uint32_t, H1_4, do_mulh_s)
+DO_ZPZZ_D(sve_umulh_zpzz_d, uint64_t, do_umulh_d)
+
+DO_ZPZZ(sve_sdiv_zpzz_s, int32_t, H1_4, DO_DIV)
+DO_ZPZZ_D(sve_sdiv_zpzz_d, int64_t, DO_DIV)
+
+DO_ZPZZ(sve_udiv_zpzz_s, uint32_t, H1_4, DO_DIV)
+DO_ZPZZ_D(sve_udiv_zpzz_d, uint64_t, DO_DIV)
+
+#undef DO_ZPZZ
+#undef DO_ZPZZ_D
+#undef DO_AND
+#undef DO_ORR
+#undef DO_EOR
+#undef DO_BIC
+#undef DO_ADD
+#undef DO_SUB
+#undef DO_MAX
+#undef DO_MIN
+#undef DO_ABD
+#undef DO_MUL
+#undef DO_DIV
+
 /* Similar to the ARM LastActiveElement pseudocode function, except the
    result is multiplied by the element size.  This includes the not found
    indication; e.g. not found for esz=3 is -8.  */
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 4bb40da119..bba04ea0af 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -227,6 +227,74 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     return do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
 }
 
+/*
+ *** SVE Integer Arithmetic - Binary Predicated Group
+ */
+
+static bool do_zpzz_ool(DisasContext *s, arg_rprr_esz *a, gen_helper_gvec_4 *fn)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    if (fn == NULL) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           pred_full_reg_offset(s, a->pg),
+                           vsz, vsz, 0, fn);
+    }
+    return true;
+}
+
+#define DO_ZPZZ(NAME, name) \
+static bool trans_##NAME##_zpzz(DisasContext *s, arg_rprr_esz *a,         \
+                                uint32_t insn)                            \
+{                                                                         \
+    static gen_helper_gvec_4 * const fns[4] = {                           \
+        gen_helper_sve_##name##_zpzz_b, gen_helper_sve_##name##_zpzz_h,   \
+        gen_helper_sve_##name##_zpzz_s, gen_helper_sve_##name##_zpzz_d,   \
+    };                                                                    \
+    return do_zpzz_ool(s, a, fns[a->esz]);                                \
+}
+
+DO_ZPZZ(AND, and)
+DO_ZPZZ(EOR, eor)
+DO_ZPZZ(ORR, orr)
+DO_ZPZZ(BIC, bic)
+
+DO_ZPZZ(ADD, add)
+DO_ZPZZ(SUB, sub)
+
+DO_ZPZZ(SMAX, smax)
+DO_ZPZZ(UMAX, umax)
+DO_ZPZZ(SMIN, smin)
+DO_ZPZZ(UMIN, umin)
+DO_ZPZZ(SABD, sabd)
+DO_ZPZZ(UABD, uabd)
+
+DO_ZPZZ(MUL, mul)
+DO_ZPZZ(SMULH, smulh)
+DO_ZPZZ(UMULH, umulh)
+
+static bool trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_4 * const fns[4] = {
+        NULL, NULL, gen_helper_sve_sdiv_zpzz_s, gen_helper_sve_sdiv_zpzz_d
+    };
+    return do_zpzz_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_4 * const fns[4] = {
+        NULL, NULL, gen_helper_sve_udiv_zpzz_s, gen_helper_sve_udiv_zpzz_d
+    };
+    return do_zpzz_ool(s, a, fns[a->esz]);
+}
+
+#undef DO_ZPZZ
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a390abb537..c444357c82 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -24,6 +24,10 @@
 
 %imm9_16_10     16:s6 10:3
 
+# Either a copy of rd (at bit 0), or a different source
+# as propagated via the MOVPRFX instruction.
+%reg_movprfx    0:5
+
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
 # when creating helpers common to those for the individual
@@ -33,6 +37,7 @@
 &rri            rd rn imm
 &rrr_esz        rd rn rm esz
 &rprr_s         rd pg rn rm s
+&rprr_esz       rd pg rn rm esz
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -50,6 +55,12 @@
 # Three predicate operand, with governing predicate, flag setting
 @pd_pg_pn_pm_s  ........ . s:1 .. rm:4 .. pg:4 . rn:4 . rd:4    &rprr_s
 
+# Two register operand, with governing predicate, vector element size
+@rdn_pg_rm      ........ esz:2 ... ... ... pg:3 rm:5 rd:5 \
+                &rprr_esz rn=%reg_movprfx
+@rdm_pg_rn      ........ esz:2 ... ... ... pg:3 rn:5 rd:5 \
+                &rprr_esz rm=%reg_movprfx
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9       ........ ........ ...... rn:5 . rd:4    \
                 &rri imm=%imm9_16_10
@@ -59,6 +70,37 @@
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
+### SVE Integer Arithmetic - Binary Predicated Group
+
+# SVE bitwise logical vector operations (predicated)
+ORR_zpzz        00000100 .. 011 000 000 ... ..... .....   @rdn_pg_rm
+EOR_zpzz        00000100 .. 011 001 000 ... ..... .....   @rdn_pg_rm
+AND_zpzz        00000100 .. 011 010 000 ... ..... .....   @rdn_pg_rm
+BIC_zpzz        00000100 .. 011 011 000 ... ..... .....   @rdn_pg_rm
+
+# SVE integer add/subtract vectors (predicated)
+ADD_zpzz        00000100 .. 000 000 000 ... ..... .....   @rdn_pg_rm
+SUB_zpzz        00000100 .. 000 001 000 ... ..... .....   @rdn_pg_rm
+SUB_zpzz        00000100 .. 000 011 000 ... ..... .....   @rdm_pg_rn # SUBR
+
+# SVE integer min/max/difference (predicated)
+SMAX_zpzz       00000100 .. 001 000 000 ... ..... .....   @rdn_pg_rm
+UMAX_zpzz       00000100 .. 001 001 000 ... ..... .....   @rdn_pg_rm
+SMIN_zpzz       00000100 .. 001 010 000 ... ..... .....   @rdn_pg_rm
+UMIN_zpzz       00000100 .. 001 011 000 ... ..... .....   @rdn_pg_rm
+SABD_zpzz       00000100 .. 001 100 000 ... ..... .....   @rdn_pg_rm
+UABD_zpzz       00000100 .. 001 101 000 ... ..... .....   @rdn_pg_rm
+
+# SVE integer multiply/divide (predicated)
+MUL_zpzz        00000100 .. 010 000 000 ... ..... .....   @rdn_pg_rm
+SMULH_zpzz      00000100 .. 010 010 000 ... ..... .....   @rdn_pg_rm
+UMULH_zpzz      00000100 .. 010 011 000 ... ..... .....   @rdn_pg_rm
+# Note that divide requires size >= 2; below 2 is unallocated.
+SDIV_zpzz       00000100 .. 010 100 000 ... ..... .....   @rdn_pg_rm
+UDIV_zpzz       00000100 .. 010 101 000 ... ..... .....   @rdn_pg_rm
+SDIV_zpzz       00000100 .. 010 110 000 ... ..... .....   @rdm_pg_rn # SDIVR
+UDIV_zpzz       00000100 .. 010 111 000 ... ..... .....   @rdm_pg_rn # UDIVR
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.17.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUQ-0008AO-DV
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUN-0001ue-F3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:10 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUN-0001tp-7C
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:07 -0500
Received: by mail-pg0-x241.google.com with SMTP id k134so9433356pga.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:36 -0800
Message-Id: <20171218174552.18871-8-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/23] target/arm: Implement SVE Integer Binary
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 145 ++++++++++++++++++++++++++++++++
 target/arm/sve_helper.c    | 203 +++++++++++++++++++++++++++++++++++++++++++--
 target/arm/translate-sve.c |  75 +++++++++++++++++
 target/arm/sve.def         |  39 +++++++++
 4 files changed, 455 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 8b382a962d..964b15b104 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -17,6 +17,151 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
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
 DEF_HELPER_FLAGS_5(sve_and_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pred, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a605e623f7..b617ea2c04 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -28,13 +28,17 @@
 /* Note that vector data is stored in host-endian 64-bit chunks,
    so addressing units smaller than that needs a host-endian fixup.  */
 #ifdef HOST_WORDS_BIGENDIAN
-#define H1(x)  ((x) ^ 7)
-#define H2(x)  ((x) ^ 3)
-#define H4(x)  ((x) ^ 1)
+#define H1(x)   ((x) ^ 7)
+#define H1_2(x) ((x) ^ 6)
+#define H1_4(x) ((x) ^ 4)
+#define H2(x)   ((x) ^ 3)
+#define H4(x)   ((x) ^ 1)
 #else
-#define H1(x)  (x)
-#define H2(x)  (x)
-#define H4(x)  (x)
+#define H1(x)   (x)
+#define H1_2(x) (x)
+#define H1_4(x) (x)
+#define H2(x)   (x)
+#define H4(x)   (x)
 #endif
 
 
@@ -117,7 +121,7 @@ LOGICAL_PRED_FLAGS(sve_nands_pred, DO_NAND)
 
 #undef LOGICAL_PRED
 #undef LOGICAL_PRED_FLAGS
-#undef DO_ADD
+#undef DO_AND
 #undef DO_BIC
 #undef DO_EOR
 #undef DO_ORR
@@ -126,6 +130,191 @@ LOGICAL_PRED_FLAGS(sve_nands_pred, DO_NAND)
 #undef DO_NAND
 #undef DO_SEL
 
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
+    intptr_t iv = 0, ib = 0, opr_sz = simd_oprsz(desc);                 \
+    for (iv = ib = 0; iv < opr_sz; iv += 16, ib += 2) {                 \
+        uint16_t pg = *(uint16_t *)(vg + H2(ib));                       \
+        intptr_t i = 0;                                                 \
+        do {                                                            \
+            if (pg & 1) {                                               \
+                TYPE nn = *(TYPE *)(vn + iv + H(i));                    \
+                TYPE mm = *(TYPE *)(vm + iv + H(i));                    \
+                *(TYPE *)(vd + iv + H(i)) = OP(nn, mm);                 \
+            }                                                           \
+            i += sizeof(TYPE), pg >>= sizeof(TYPE);                     \
+        } while (pg);                                                   \
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
+#define DO_BIC(N, M)  (N &~ M)
+
+DO_ZPZZ(sve_and_zpzz_b, uint8_t, H1, DO_AND)
+DO_ZPZZ(sve_orr_zpzz_b, uint8_t, H1, DO_ORR)
+DO_ZPZZ(sve_eor_zpzz_b, uint8_t, H1, DO_EOR)
+DO_ZPZZ(sve_bic_zpzz_b, uint8_t, H1, DO_BIC)
+
+DO_ZPZZ(sve_and_zpzz_h, uint16_t, H1_2, DO_AND)
+DO_ZPZZ(sve_orr_zpzz_h, uint16_t, H1_2, DO_ORR)
+DO_ZPZZ(sve_eor_zpzz_h, uint16_t, H1_2, DO_EOR)
+DO_ZPZZ(sve_bic_zpzz_h, uint16_t, H1_2, DO_BIC)
+
+DO_ZPZZ(sve_and_zpzz_s, uint32_t, H1_4, DO_AND)
+DO_ZPZZ(sve_orr_zpzz_s, uint32_t, H1_4, DO_ORR)
+DO_ZPZZ(sve_eor_zpzz_s, uint32_t, H1_4, DO_EOR)
+DO_ZPZZ(sve_bic_zpzz_s, uint32_t, H1_4, DO_BIC)
+
+DO_ZPZZ_D(sve_and_zpzz_d, uint64_t, DO_AND)
+DO_ZPZZ_D(sve_orr_zpzz_d, uint64_t, DO_ORR)
+DO_ZPZZ_D(sve_eor_zpzz_d, uint64_t, DO_EOR)
+DO_ZPZZ_D(sve_bic_zpzz_d, uint64_t, DO_BIC)
+
+#undef DO_AND
+#undef DO_ORR
+#undef DO_EOR
+#undef DO_BIC
+
+#define DO_ADD(N, M)  (N + M)
+#define DO_SUB(N, M)  (N - M)
+
+DO_ZPZZ(sve_add_zpzz_b, uint8_t, H1, DO_ADD)
+DO_ZPZZ(sve_sub_zpzz_b, uint8_t, H1, DO_SUB)
+
+DO_ZPZZ(sve_add_zpzz_h, uint16_t, H1_2, DO_ADD)
+DO_ZPZZ(sve_sub_zpzz_h, uint16_t, H1_2, DO_SUB)
+
+DO_ZPZZ(sve_add_zpzz_s, uint32_t, H1_4, DO_ADD)
+DO_ZPZZ(sve_sub_zpzz_s, uint32_t, H1_4, DO_SUB)
+
+DO_ZPZZ_D(sve_add_zpzz_d, uint64_t, DO_ADD)
+DO_ZPZZ_D(sve_sub_zpzz_d, uint64_t, DO_SUB)
+
+#undef DO_ADD
+#undef DO_SUB
+
+#define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
+#define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
+#define DO_ABD(N, M)  ((N) >= (M) ? (N) - (M) : (M) - (N))
+
+DO_ZPZZ(sve_smax_zpzz_b, int8_t,  H1, DO_MAX)
+DO_ZPZZ(sve_umax_zpzz_b, uint8_t, H1, DO_MAX)
+DO_ZPZZ(sve_smin_zpzz_b, int8_t,  H1, DO_MIN)
+DO_ZPZZ(sve_umin_zpzz_b, uint8_t, H1, DO_MIN)
+DO_ZPZZ(sve_sabd_zpzz_b, int8_t,  H1, DO_ABD)
+DO_ZPZZ(sve_uabd_zpzz_b, uint8_t, H1, DO_ABD)
+
+DO_ZPZZ(sve_smax_zpzz_h, int16_t,  H1_2, DO_MAX)
+DO_ZPZZ(sve_umax_zpzz_h, uint16_t, H1_2, DO_MAX)
+DO_ZPZZ(sve_smin_zpzz_h, int16_t,  H1_2, DO_MIN)
+DO_ZPZZ(sve_umin_zpzz_h, uint16_t, H1_2, DO_MIN)
+DO_ZPZZ(sve_sabd_zpzz_h, int16_t,  H1_2, DO_ABD)
+DO_ZPZZ(sve_uabd_zpzz_h, uint16_t, H1_2, DO_ABD)
+
+DO_ZPZZ(sve_smax_zpzz_s, int32_t,  H1_4, DO_MAX)
+DO_ZPZZ(sve_umax_zpzz_s, uint32_t, H1_4, DO_MAX)
+DO_ZPZZ(sve_smin_zpzz_s, int32_t,  H1_4, DO_MIN)
+DO_ZPZZ(sve_umin_zpzz_s, uint32_t, H1_4, DO_MIN)
+DO_ZPZZ(sve_sabd_zpzz_s, int32_t,  H1_4, DO_ABD)
+DO_ZPZZ(sve_uabd_zpzz_s, uint32_t, H1_4, DO_ABD)
+
+DO_ZPZZ_D(sve_smax_zpzz_d, int64_t,  DO_MAX)
+DO_ZPZZ_D(sve_umax_zpzz_d, uint64_t, DO_MAX)
+DO_ZPZZ_D(sve_smin_zpzz_d, int64_t,  DO_MIN)
+DO_ZPZZ_D(sve_umin_zpzz_d, uint64_t, DO_MIN)
+DO_ZPZZ_D(sve_sabd_zpzz_d, int64_t,  DO_ABD)
+DO_ZPZZ_D(sve_uabd_zpzz_d, uint64_t, DO_ABD)
+
+#undef DO_MAX
+#undef DO_MIN
+#undef DO_ABD
+
+#define DO_MUL(N, M)  (N * M)
+#define DO_DIV(N, M)  (M ? N / M : 0)
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
+DO_ZPZZ(sve_smulh_zpzz_b, int8_t, H1, do_mulh_b)
+DO_ZPZZ(sve_umulh_zpzz_b, uint8_t, H1, do_mulh_b)
+
+DO_ZPZZ(sve_mul_zpzz_h, uint16_t, H1_2, DO_MUL)
+DO_ZPZZ(sve_smulh_zpzz_h, int16_t, H1_2, do_mulh_h)
+DO_ZPZZ(sve_umulh_zpzz_h, uint16_t, H1_2, do_mulh_h)
+
+DO_ZPZZ(sve_mul_zpzz_s, uint32_t, H1_4, DO_MUL)
+DO_ZPZZ(sve_smulh_zpzz_s, int32_t, H1_4, do_mulh_s)
+DO_ZPZZ(sve_umulh_zpzz_s, uint32_t, H1_4, do_mulh_s)
+DO_ZPZZ(sve_sdiv_zpzz_s, int32_t, H1_4, DO_DIV)
+DO_ZPZZ(sve_udiv_zpzz_s, uint32_t, H1_4, DO_DIV)
+
+DO_ZPZZ_D(sve_mul_zpzz_d, uint64_t, DO_MUL)
+DO_ZPZZ_D(sve_smulh_zpzz_d, uint64_t, do_smulh_d)
+DO_ZPZZ_D(sve_umulh_zpzz_d, uint64_t, do_umulh_d)
+DO_ZPZZ_D(sve_sdiv_zpzz_d, int64_t, DO_DIV)
+DO_ZPZZ_D(sve_udiv_zpzz_d, uint64_t, DO_DIV)
+
+#undef DO_MUL
+#undef DO_DIV
+
+#undef DO_ZPZZ
+#undef DO_ZPZZ_D
+
 void HELPER(sve_ldr)(CPUARMState *env, void *d, target_ulong addr, uint32_t len)
 {
     intptr_t i, len_align = QEMU_ALIGN_DOWN(len, 8);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0e988c03aa..d8b34020bb 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -126,6 +126,81 @@ void trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn)
     do_zzz_genfn(s, a, tcg_gen_gvec_andc);
 }
 
+static void do_zpzz_ool(DisasContext *s, arg_rprr_esz *a, gen_helper_gvec_4 *fn)
+{
+    unsigned vsz = size_for_gvec(vec_full_reg_size(s));
+    tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
+                       vec_full_reg_offset(s, a->rn),
+                       vec_full_reg_offset(s, a->rm),
+                       pred_full_reg_offset(s, a->pg),
+                       vsz, vsz, 0, fn);
+}
+
+#define DO_ZPZZ(NAME, name) \
+void trans_##NAME##_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn) \
+{                                                                         \
+    static gen_helper_gvec_4 * const fns[4] = {                           \
+        gen_helper_sve_##name##_zpzz_b, gen_helper_sve_##name##_zpzz_h,   \
+        gen_helper_sve_##name##_zpzz_s, gen_helper_sve_##name##_zpzz_d,   \
+    };                                                                    \
+    do_zpzz_ool(s, a, fns[a->esz]);                                       \
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
+void trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    gen_helper_gvec_4 *fn;
+    switch (a->esz) {
+    default:
+        unallocated_encoding(s);
+        return;
+    case 2:
+        fn = gen_helper_sve_sdiv_zpzz_s;
+        break;
+    case 3:
+        fn = gen_helper_sve_sdiv_zpzz_d;
+        break;
+    };
+    do_zpzz_ool(s, a, fn);
+}
+
+void trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+{
+    gen_helper_gvec_4 *fn;
+    switch (a->esz) {
+    default:
+        unallocated_encoding(s);
+        return;
+    case 2:
+        fn = gen_helper_sve_udiv_zpzz_s;
+        break;
+    case 3:
+        fn = gen_helper_sve_udiv_zpzz_d;
+        break;
+    };
+    do_zpzz_ool(s, a, fn);
+}
+
+#undef DO_ZPZZ
+
 static uint64_t pred_esz_mask[4] = {
     0xffffffffffffffffull, 0x5555555555555555ull,
     0x1111111111111111ull, 0x0101010101010101ull
diff --git a/target/arm/sve.def b/target/arm/sve.def
index d1172296e0..3bb4faaf89 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -24,6 +24,10 @@
 
 %imm9_16_10		16:s6 10:3
 
+# Either a copy of rd (at bit 0), or a different source
+# as propagated via the MOVPRFX instruction.
+%reg_movprfx		0:5
+
 ###########################################################################
 # Named attribute sets.  These are used to make nice(er) names
 # when creating helpers common to those for the individual
@@ -44,6 +48,10 @@
 # Three prediate operand, with governing predicate, unused vector element size
 @pd_pg_pn_pm		........ .... rm:4 .. pg:4 . rn:4 . rd:4	&rprr_esz esz=0
 
+# Two register operand, with governing predicate, vector element size
+@rdn_pg_rm_esz		........ esz:2 ... ... ... pg:3 rm:5 rd:5	&rprr_esz rn=%reg_movprfx
+@rdm_pg_rn_esz		........ esz:2 ... ... ... pg:3 rn:5 rd:5	&rprr_esz rm=%reg_movprfx
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9		........ ........ ...... rn:5 . rd:4		&rri imm=%imm9_16_10
 @rd_rn_i9		........ ........ ...... rn:5 rd:5		&rri imm=%imm9_16_10
@@ -51,6 +59,37 @@
 ###########################################################################
 # Instruction patterns.  Grouped according to the SVE encodingindex.xhtml.
 
+### SVE Integer Arithmetic - Binary Predicated Group
+
+# SVE bitwise logical vector operations (predicated)
+ORR_zpzz		00000100 .. 011 000 000 ... ..... .....		@rdn_pg_rm_esz
+EOR_zpzz		00000100 .. 011 001 000 ... ..... .....		@rdn_pg_rm_esz
+AND_zpzz		00000100 .. 011 010 000 ... ..... .....		@rdn_pg_rm_esz
+BIC_zpzz		00000100 .. 011 011 000 ... ..... .....		@rdn_pg_rm_esz
+
+# SVE integer add/subtract vectors (predicated)
+ADD_zpzz		00000100 .. 000 000 000 ... ..... .....		@rdn_pg_rm_esz
+SUB_zpzz		00000100 .. 000 001 000 ... ..... .....		@rdn_pg_rm_esz
+SUB_zpzz		00000100 .. 000 011 000 ... ..... .....		@rdm_pg_rn_esz # SUBR
+
+# SVE integer min/max/difference (predicated)
+SMAX_zpzz		00000100 .. 001 000 000 ... ..... .....		@rdn_pg_rm_esz
+UMAX_zpzz		00000100 .. 001 001 000 ... ..... .....		@rdn_pg_rm_esz
+SMIN_zpzz		00000100 .. 001 010 000 ... ..... .....		@rdn_pg_rm_esz
+UMIN_zpzz		00000100 .. 001 011 000 ... ..... .....		@rdn_pg_rm_esz
+SABD_zpzz		00000100 .. 001 100 000 ... ..... .....		@rdn_pg_rm_esz
+UABD_zpzz		00000100 .. 001 101 000 ... ..... .....		@rdn_pg_rm_esz
+
+# SVE integer multiply/divide (predicated)
+MUL_zpzz		00000100 .. 010 000 000 ... ..... .....		@rdn_pg_rm_esz
+SMULH_zpzz		00000100 .. 010 010 000 ... ..... .....		@rdn_pg_rm_esz
+UMULH_zpzz		00000100 .. 010 011 000 ... ..... .....		@rdn_pg_rm_esz
+# Note that divide requires size >= 2; below 2 is unallocated.
+SDIV_zpzz		00000100 .. 010 100 000 ... ..... .....		@rdn_pg_rm_esz
+UDIV_zpzz		00000100 .. 010 101 000 ... ..... .....		@rdn_pg_rm_esz
+SDIV_zpzz		00000100 .. 010 110 000 ... ..... .....		@rdm_pg_rn_esz # SDIVR
+UDIV_zpzz		00000100 .. 010 111 000 ... ..... .....		@rdm_pg_rn_esz # UDIVR
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.14.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:32784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpff-0001qW-Le
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfd-0006Nc-8E
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfc-0006My-PA
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:45 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfb-0003nL-Qa
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:43 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:07 +0100
Message-Id: <20180615142521.19143-30-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 29/43] target/arm: Implement SVE Integer Compare
 - Vectors Group
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
Message-id: 20180613015641.5667-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    | 115 +++++++++++++++++++++++
 target/arm/sve_helper.c    | 187 +++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c |  91 ++++++++++++++++++
 target/arm/sve.decode      |  24 +++++
 4 files changed, 417 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0f57f64895b..6ffd1fbe8ef 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -490,6 +490,121 @@ DEF_HELPER_FLAGS_4(sve_rbit_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(sve_splice, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(sve_cmpeq_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpne_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpge_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpgt_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphi_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphs_ppzz_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_cmpeq_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpne_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpge_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpgt_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphi_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphs_ppzz_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_cmpeq_ppzz_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpne_ppzz_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpge_ppzz_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpgt_ppzz_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphi_ppzz_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphs_ppzz_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_cmpeq_ppzz_d, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpne_ppzz_d, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpge_ppzz_d, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpgt_ppzz_d, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphi_ppzz_d, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphs_ppzz_d, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_cmpeq_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpne_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpge_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpgt_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphi_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphs_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmple_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmplt_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmplo_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpls_ppzw_b, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_cmpeq_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpne_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpge_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpgt_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphi_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphs_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmple_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmplt_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmplo_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpls_ppzw_h, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve_cmpeq_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpne_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpge_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpgt_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphi_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmphs_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmple_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmplt_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmplo_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve_cmpls_ppzw_s, TCG_CALL_NO_RWG,
+                   i32, ptr, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f55fdc7dbef..d11f591661e 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -74,6 +74,28 @@ static uint32_t iter_predtest_fwd(uint64_t d, uint64_t g, uint32_t flags)
     return flags;
 }
 
+/* This is an iterative function, called for each Pd and Pg word
+ * moving backward.
+ */
+static uint32_t iter_predtest_bwd(uint64_t d, uint64_t g, uint32_t flags)
+{
+    if (likely(g)) {
+        /* Compute C from first (i.e last) !(D & G).
+           Use bit 2 to signal first G bit seen.  */
+        if (!(flags & 4)) {
+            flags += 4 - 1; /* add bit 2, subtract C from PREDTEST_INIT */
+            flags |= (d & pow2floor(g)) == 0;
+        }
+
+        /* Accumulate Z from each D & G.  */
+        flags |= ((d & g) != 0) << 1;
+
+        /* Compute N from last (i.e first) D & G.  Replace previous.  */
+        flags = deposit32(flags, 31, 1, (d & (g & -g)) != 0);
+    }
+    return flags;
+}
+
 /* The same for a single word predicate.  */
 uint32_t HELPER(sve_predtest1)(uint64_t d, uint64_t g)
 {
@@ -2201,3 +2223,168 @@ void HELPER(sve_sel_zpzz_d)(void *vd, void *vn, void *vm,
         d[i] = (pg[H1(i)] & 1 ? nn : mm);
     }
 }
+
+/* Two operand comparison controlled by a predicate.
+ * ??? It is very tempting to want to be able to expand this inline
+ * with x86 instructions, e.g.
+ *
+ *    vcmpeqw    zm, zn, %ymm0
+ *    vpmovmskb  %ymm0, %eax
+ *    and        $0x5555, %eax
+ *    and        pg, %eax
+ *
+ * or even aarch64, e.g.
+ *
+ *    // mask = 4000 1000 0400 0100 0040 0010 0004 0001
+ *    cmeq       v0.8h, zn, zm
+ *    and        v0.8h, v0.8h, mask
+ *    addv       h0, v0.8h
+ *    and        v0.8b, pg
+ *
+ * However, coming up with an abstraction that allows vector inputs and
+ * a scalar output, and also handles the byte-ordering of sub-uint64_t
+ * scalar outputs, is tricky.
+ */
+#define DO_CMP_PPZZ(NAME, TYPE, OP, H, MASK)                                 \
+uint32_t HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
+{                                                                            \
+    intptr_t opr_sz = simd_oprsz(desc);                                      \
+    uint32_t flags = PREDTEST_INIT;                                          \
+    intptr_t i = opr_sz;                                                     \
+    do {                                                                     \
+        uint64_t out = 0, pg;                                                \
+        do {                                                                 \
+            i -= sizeof(TYPE), out <<= sizeof(TYPE);                         \
+            TYPE nn = *(TYPE *)(vn + H(i));                                  \
+            TYPE mm = *(TYPE *)(vm + H(i));                                  \
+            out |= nn OP mm;                                                 \
+        } while (i & 63);                                                    \
+        pg = *(uint64_t *)(vg + (i >> 3)) & MASK;                            \
+        out &= pg;                                                           \
+        *(uint64_t *)(vd + (i >> 3)) = out;                                  \
+        flags = iter_predtest_bwd(out, pg, flags);                           \
+    } while (i > 0);                                                         \
+    return flags;                                                            \
+}
+
+#define DO_CMP_PPZZ_B(NAME, TYPE, OP) \
+    DO_CMP_PPZZ(NAME, TYPE, OP, H1,   0xffffffffffffffffull)
+#define DO_CMP_PPZZ_H(NAME, TYPE, OP) \
+    DO_CMP_PPZZ(NAME, TYPE, OP, H1_2, 0x5555555555555555ull)
+#define DO_CMP_PPZZ_S(NAME, TYPE, OP) \
+    DO_CMP_PPZZ(NAME, TYPE, OP, H1_4, 0x1111111111111111ull)
+#define DO_CMP_PPZZ_D(NAME, TYPE, OP) \
+    DO_CMP_PPZZ(NAME, TYPE, OP,     , 0x0101010101010101ull)
+
+DO_CMP_PPZZ_B(sve_cmpeq_ppzz_b, uint8_t,  ==)
+DO_CMP_PPZZ_H(sve_cmpeq_ppzz_h, uint16_t, ==)
+DO_CMP_PPZZ_S(sve_cmpeq_ppzz_s, uint32_t, ==)
+DO_CMP_PPZZ_D(sve_cmpeq_ppzz_d, uint64_t, ==)
+
+DO_CMP_PPZZ_B(sve_cmpne_ppzz_b, uint8_t,  !=)
+DO_CMP_PPZZ_H(sve_cmpne_ppzz_h, uint16_t, !=)
+DO_CMP_PPZZ_S(sve_cmpne_ppzz_s, uint32_t, !=)
+DO_CMP_PPZZ_D(sve_cmpne_ppzz_d, uint64_t, !=)
+
+DO_CMP_PPZZ_B(sve_cmpgt_ppzz_b, int8_t,  >)
+DO_CMP_PPZZ_H(sve_cmpgt_ppzz_h, int16_t, >)
+DO_CMP_PPZZ_S(sve_cmpgt_ppzz_s, int32_t, >)
+DO_CMP_PPZZ_D(sve_cmpgt_ppzz_d, int64_t, >)
+
+DO_CMP_PPZZ_B(sve_cmpge_ppzz_b, int8_t,  >=)
+DO_CMP_PPZZ_H(sve_cmpge_ppzz_h, int16_t, >=)
+DO_CMP_PPZZ_S(sve_cmpge_ppzz_s, int32_t, >=)
+DO_CMP_PPZZ_D(sve_cmpge_ppzz_d, int64_t, >=)
+
+DO_CMP_PPZZ_B(sve_cmphi_ppzz_b, uint8_t,  >)
+DO_CMP_PPZZ_H(sve_cmphi_ppzz_h, uint16_t, >)
+DO_CMP_PPZZ_S(sve_cmphi_ppzz_s, uint32_t, >)
+DO_CMP_PPZZ_D(sve_cmphi_ppzz_d, uint64_t, >)
+
+DO_CMP_PPZZ_B(sve_cmphs_ppzz_b, uint8_t,  >=)
+DO_CMP_PPZZ_H(sve_cmphs_ppzz_h, uint16_t, >=)
+DO_CMP_PPZZ_S(sve_cmphs_ppzz_s, uint32_t, >=)
+DO_CMP_PPZZ_D(sve_cmphs_ppzz_d, uint64_t, >=)
+
+#undef DO_CMP_PPZZ_B
+#undef DO_CMP_PPZZ_H
+#undef DO_CMP_PPZZ_S
+#undef DO_CMP_PPZZ_D
+#undef DO_CMP_PPZZ
+
+/* Similar, but the second source is "wide".  */
+#define DO_CMP_PPZW(NAME, TYPE, TYPEW, OP, H, MASK)                     \
+uint32_t HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc) \
+{                                                                            \
+    intptr_t opr_sz = simd_oprsz(desc);                                      \
+    uint32_t flags = PREDTEST_INIT;                                          \
+    intptr_t i = opr_sz;                                                     \
+    do {                                                                     \
+        uint64_t out = 0, pg;                                                \
+        do {                                                                 \
+            TYPEW mm = *(TYPEW *)(vm + i - 8);                               \
+            do {                                                             \
+                i -= sizeof(TYPE), out <<= sizeof(TYPE);                     \
+                TYPE nn = *(TYPE *)(vn + H(i));                              \
+                out |= nn OP mm;                                             \
+            } while (i & 7);                                                 \
+        } while (i & 63);                                                    \
+        pg = *(uint64_t *)(vg + (i >> 3)) & MASK;                            \
+        out &= pg;                                                           \
+        *(uint64_t *)(vd + (i >> 3)) = out;                                  \
+        flags = iter_predtest_bwd(out, pg, flags);                           \
+    } while (i > 0);                                                         \
+    return flags;                                                            \
+}
+
+#define DO_CMP_PPZW_B(NAME, TYPE, TYPEW, OP) \
+    DO_CMP_PPZW(NAME, TYPE, TYPEW, OP, H1,   0xffffffffffffffffull)
+#define DO_CMP_PPZW_H(NAME, TYPE, TYPEW, OP) \
+    DO_CMP_PPZW(NAME, TYPE, TYPEW, OP, H1_2, 0x5555555555555555ull)
+#define DO_CMP_PPZW_S(NAME, TYPE, TYPEW, OP) \
+    DO_CMP_PPZW(NAME, TYPE, TYPEW, OP, H1_4, 0x1111111111111111ull)
+
+DO_CMP_PPZW_B(sve_cmpeq_ppzw_b, uint8_t,  uint64_t, ==)
+DO_CMP_PPZW_H(sve_cmpeq_ppzw_h, uint16_t, uint64_t, ==)
+DO_CMP_PPZW_S(sve_cmpeq_ppzw_s, uint32_t, uint64_t, ==)
+
+DO_CMP_PPZW_B(sve_cmpne_ppzw_b, uint8_t,  uint64_t, !=)
+DO_CMP_PPZW_H(sve_cmpne_ppzw_h, uint16_t, uint64_t, !=)
+DO_CMP_PPZW_S(sve_cmpne_ppzw_s, uint32_t, uint64_t, !=)
+
+DO_CMP_PPZW_B(sve_cmpgt_ppzw_b, int8_t,   int64_t, >)
+DO_CMP_PPZW_H(sve_cmpgt_ppzw_h, int16_t,  int64_t, >)
+DO_CMP_PPZW_S(sve_cmpgt_ppzw_s, int32_t,  int64_t, >)
+
+DO_CMP_PPZW_B(sve_cmpge_ppzw_b, int8_t,   int64_t, >=)
+DO_CMP_PPZW_H(sve_cmpge_ppzw_h, int16_t,  int64_t, >=)
+DO_CMP_PPZW_S(sve_cmpge_ppzw_s, int32_t,  int64_t, >=)
+
+DO_CMP_PPZW_B(sve_cmphi_ppzw_b, uint8_t,  uint64_t, >)
+DO_CMP_PPZW_H(sve_cmphi_ppzw_h, uint16_t, uint64_t, >)
+DO_CMP_PPZW_S(sve_cmphi_ppzw_s, uint32_t, uint64_t, >)
+
+DO_CMP_PPZW_B(sve_cmphs_ppzw_b, uint8_t,  uint64_t, >=)
+DO_CMP_PPZW_H(sve_cmphs_ppzw_h, uint16_t, uint64_t, >=)
+DO_CMP_PPZW_S(sve_cmphs_ppzw_s, uint32_t, uint64_t, >=)
+
+DO_CMP_PPZW_B(sve_cmplt_ppzw_b, int8_t,   int64_t, <)
+DO_CMP_PPZW_H(sve_cmplt_ppzw_h, int16_t,  int64_t, <)
+DO_CMP_PPZW_S(sve_cmplt_ppzw_s, int32_t,  int64_t, <)
+
+DO_CMP_PPZW_B(sve_cmple_ppzw_b, int8_t,   int64_t, <=)
+DO_CMP_PPZW_H(sve_cmple_ppzw_h, int16_t,  int64_t, <=)
+DO_CMP_PPZW_S(sve_cmple_ppzw_s, int32_t,  int64_t, <=)
+
+DO_CMP_PPZW_B(sve_cmplo_ppzw_b, uint8_t,  uint64_t, <)
+DO_CMP_PPZW_H(sve_cmplo_ppzw_h, uint16_t, uint64_t, <)
+DO_CMP_PPZW_S(sve_cmplo_ppzw_s, uint32_t, uint64_t, <)
+
+DO_CMP_PPZW_B(sve_cmpls_ppzw_b, uint8_t,  uint64_t, <=)
+DO_CMP_PPZW_H(sve_cmpls_ppzw_h, uint16_t, uint64_t, <=)
+DO_CMP_PPZW_S(sve_cmpls_ppzw_s, uint32_t, uint64_t, <=)
+
+#undef DO_CMP_PPZW_B
+#undef DO_CMP_PPZW_H
+#undef DO_CMP_PPZW_S
+#undef DO_CMP_PPZW
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 0de9118fdfb..1510af6ece8 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -33,6 +33,10 @@
 #include "trace-tcg.h"
 #include "translate-a64.h"
 
+
+typedef void gen_helper_gvec_flags_4(TCGv_i32, TCGv_ptr, TCGv_ptr,
+                                     TCGv_ptr, TCGv_ptr, TCGv_i32);
+
 /*
  * Helpers for extracting complex instruction fields.
  */
@@ -2696,6 +2700,93 @@ static bool trans_SPLICE(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
     return true;
 }
 
+/*
+ *** SVE Integer Compare - Vectors Group
+ */
+
+static bool do_ppzz_flags(DisasContext *s, arg_rprr_esz *a,
+                          gen_helper_gvec_flags_4 *gen_fn)
+{
+    TCGv_ptr pd, zn, zm, pg;
+    unsigned vsz;
+    TCGv_i32 t;
+
+    if (gen_fn == NULL) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    vsz = vec_full_reg_size(s);
+    t = tcg_const_i32(simd_desc(vsz, vsz, 0));
+    pd = tcg_temp_new_ptr();
+    zn = tcg_temp_new_ptr();
+    zm = tcg_temp_new_ptr();
+    pg = tcg_temp_new_ptr();
+
+    tcg_gen_addi_ptr(pd, cpu_env, pred_full_reg_offset(s, a->rd));
+    tcg_gen_addi_ptr(zn, cpu_env, vec_full_reg_offset(s, a->rn));
+    tcg_gen_addi_ptr(zm, cpu_env, vec_full_reg_offset(s, a->rm));
+    tcg_gen_addi_ptr(pg, cpu_env, pred_full_reg_offset(s, a->pg));
+
+    gen_fn(t, pd, zn, zm, pg, t);
+
+    tcg_temp_free_ptr(pd);
+    tcg_temp_free_ptr(zn);
+    tcg_temp_free_ptr(zm);
+    tcg_temp_free_ptr(pg);
+
+    do_pred_flags(t);
+
+    tcg_temp_free_i32(t);
+    return true;
+}
+
+#define DO_PPZZ(NAME, name) \
+static bool trans_##NAME##_ppzz(DisasContext *s, arg_rprr_esz *a,         \
+                                uint32_t insn)                            \
+{                                                                         \
+    static gen_helper_gvec_flags_4 * const fns[4] = {                     \
+        gen_helper_sve_##name##_ppzz_b, gen_helper_sve_##name##_ppzz_h,   \
+        gen_helper_sve_##name##_ppzz_s, gen_helper_sve_##name##_ppzz_d,   \
+    };                                                                    \
+    return do_ppzz_flags(s, a, fns[a->esz]);                              \
+}
+
+DO_PPZZ(CMPEQ, cmpeq)
+DO_PPZZ(CMPNE, cmpne)
+DO_PPZZ(CMPGT, cmpgt)
+DO_PPZZ(CMPGE, cmpge)
+DO_PPZZ(CMPHI, cmphi)
+DO_PPZZ(CMPHS, cmphs)
+
+#undef DO_PPZZ
+
+#define DO_PPZW(NAME, name) \
+static bool trans_##NAME##_ppzw(DisasContext *s, arg_rprr_esz *a,         \
+                                uint32_t insn)                            \
+{                                                                         \
+    static gen_helper_gvec_flags_4 * const fns[4] = {                     \
+        gen_helper_sve_##name##_ppzw_b, gen_helper_sve_##name##_ppzw_h,   \
+        gen_helper_sve_##name##_ppzw_s, NULL                              \
+    };                                                                    \
+    return do_ppzz_flags(s, a, fns[a->esz]);                              \
+}
+
+DO_PPZW(CMPEQ, cmpeq)
+DO_PPZW(CMPNE, cmpne)
+DO_PPZW(CMPGT, cmpgt)
+DO_PPZW(CMPGE, cmpge)
+DO_PPZW(CMPHI, cmphi)
+DO_PPZW(CMPHS, cmphs)
+DO_PPZW(CMPLT, cmplt)
+DO_PPZW(CMPLE, cmple)
+DO_PPZW(CMPLO, cmplo)
+DO_PPZW(CMPLS, cmpls)
+
+#undef DO_PPZW
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 91522d8e137..76a42193e4b 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -99,6 +99,7 @@
 @rdm_pg_rn      ........ esz:2 ... ... ... pg:3 rn:5 rd:5 \
                 &rprr_esz rm=%reg_movprfx
 @rd_pg4_rn_rm   ........ esz:2 . rm:5  .. pg:4  rn:5 rd:5       &rprr_esz
+@pd_pg_rn_rm    ........ esz:2 . rm:5 ... pg:3 rn:5 . rd:4      &rprr_esz
 
 # Three register operand, with governing predicate, vector element size
 @rda_pg_rn_rm   ........ esz:2 . rm:5  ... pg:3 rn:5 rd:5 \
@@ -472,6 +473,29 @@ SPLICE          00000101 .. 101 100 100 ... ..... .....         @rdn_pg_rm
 # SVE select vector elements (predicated)
 SEL_zpzz        00000101 .. 1 ..... 11 .... ..... .....         @rd_pg4_rn_rm
 
+### SVE Integer Compare - Vectors Group
+
+# SVE integer compare_vectors
+CMPHS_ppzz      00100100 .. 0 ..... 000 ... ..... 0 ....        @pd_pg_rn_rm
+CMPHI_ppzz      00100100 .. 0 ..... 000 ... ..... 1 ....        @pd_pg_rn_rm
+CMPGE_ppzz      00100100 .. 0 ..... 100 ... ..... 0 ....        @pd_pg_rn_rm
+CMPGT_ppzz      00100100 .. 0 ..... 100 ... ..... 1 ....        @pd_pg_rn_rm
+CMPEQ_ppzz      00100100 .. 0 ..... 101 ... ..... 0 ....        @pd_pg_rn_rm
+CMPNE_ppzz      00100100 .. 0 ..... 101 ... ..... 1 ....        @pd_pg_rn_rm
+
+# SVE integer compare with wide elements
+# Note these require esz != 3.
+CMPEQ_ppzw      00100100 .. 0 ..... 001 ... ..... 0 ....        @pd_pg_rn_rm
+CMPNE_ppzw      00100100 .. 0 ..... 001 ... ..... 1 ....        @pd_pg_rn_rm
+CMPGE_ppzw      00100100 .. 0 ..... 010 ... ..... 0 ....        @pd_pg_rn_rm
+CMPGT_ppzw      00100100 .. 0 ..... 010 ... ..... 1 ....        @pd_pg_rn_rm
+CMPLT_ppzw      00100100 .. 0 ..... 011 ... ..... 0 ....        @pd_pg_rn_rm
+CMPLE_ppzw      00100100 .. 0 ..... 011 ... ..... 1 ....        @pd_pg_rn_rm
+CMPHS_ppzw      00100100 .. 0 ..... 110 ... ..... 0 ....        @pd_pg_rn_rm
+CMPHI_ppzw      00100100 .. 0 ..... 110 ... ..... 1 ....        @pd_pg_rn_rm
+CMPLO_ppzw      00100100 .. 0 ..... 111 ... ..... 0 ....        @pd_pg_rn_rm
+CMPLS_ppzw      00100100 .. 0 ..... 111 ... ..... 1 ....        @pd_pg_rn_rm
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1

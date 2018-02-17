Received: from eggs.gnu.org ([2001:4830:134:3::10]:40298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79q-00011l-8N
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79o-0001tQ-To
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:22 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79o-0001t2-NF
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:20 -0500
Received: by mail-pl0-x242.google.com with SMTP id w21so3426846plp.11
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:49 -0800
Message-Id: <20180217182323.25885-34-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 33/67] target/arm: Implement SVE reverse
 within elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 14 ++++++++++++++
 target/arm/sve_helper.c    | 41 ++++++++++++++++++++++++++++++++++-------
 target/arm/translate-sve.c | 38 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      |  7 +++++++
 4 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index a58fb4ba01..3b7c54905d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -465,6 +465,20 @@ DEF_HELPER_FLAGS_4(sve_compact_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_2(sve_last_active_element, TCG_CALL_NO_RWG, s32, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_revb_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_revb_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_revb_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_revh_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_revh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_revw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve_rbit_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_rbit_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_rbit_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_rbit_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index ee289be642..a67bb579b8 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -237,6 +237,26 @@ static inline uint64_t expand_pred_s(uint8_t byte)
     return word[byte & 0x11];
 }
 
+/* Swap 16-bit words within a 32-bit word.  */
+static inline uint32_t hswap32(uint32_t h)
+{
+    return rol32(h, 16);
+}
+
+/* Swap 16-bit words within a 64-bit word.  */
+static inline uint64_t hswap64(uint64_t h)
+{
+    uint64_t m = 0x0000ffff0000ffffull;
+    h = rol64(h, 32);
+    return ((h & m) << 16) | ((h >> 16) & m);
+}
+
+/* Swap 32-bit words within a 64-bit word.  */
+static inline uint64_t wswap64(uint64_t h)
+{
+    return rol64(h, 32);
+}
+
 #define LOGICAL_PPPP(NAME, FUNC) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *vg, uint32_t desc)  \
 {                                                                         \
@@ -615,6 +635,20 @@ DO_ZPZ(sve_neg_h, uint16_t, H1_2, DO_NEG)
 DO_ZPZ(sve_neg_s, uint32_t, H1_4, DO_NEG)
 DO_ZPZ_D(sve_neg_d, uint64_t, DO_NEG)
 
+DO_ZPZ(sve_revb_h, uint16_t, H1_2, bswap16)
+DO_ZPZ(sve_revb_s, uint32_t, H1_4, bswap32)
+DO_ZPZ_D(sve_revb_d, uint64_t, bswap64)
+
+DO_ZPZ(sve_revh_s, uint32_t, H1_4, hswap32)
+DO_ZPZ_D(sve_revh_d, uint64_t, hswap64)
+
+DO_ZPZ_D(sve_revw_d, uint64_t, wswap64)
+
+DO_ZPZ(sve_rbit_b, uint8_t, H1, revbit8)
+DO_ZPZ(sve_rbit_h, uint16_t, H1_2, revbit16)
+DO_ZPZ(sve_rbit_s, uint32_t, H1_4, revbit32)
+DO_ZPZ_D(sve_rbit_d, uint64_t, revbit64)
+
 /* Three-operand expander, unpredicated, in which the third operand is "wide".
  */
 #define DO_ZZW(NAME, TYPE, TYPEW, H, OP)                       \
@@ -1577,13 +1611,6 @@ void HELPER(sve_rev_b)(void *vd, void *vn, uint32_t desc)
     }
 }
 
-static inline uint64_t hswap64(uint64_t h)
-{
-    uint64_t m = 0x0000ffff0000ffffull;
-    h = rol64(h, 32);
-    return ((h & m) << 16) | ((h >> 16) & m);
-}
-
 void HELPER(sve_rev_h)(void *vd, void *vn, uint32_t desc)
 {
     intptr_t i, j, opr_sz = simd_oprsz(desc);
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index fc2a295ab7..5a1ed379ad 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2435,6 +2435,44 @@ static void trans_CPY_m_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     tcg_temp_free_i64(t);
 }
 
+static void trans_REVB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        gen_helper_sve_revb_h,
+        gen_helper_sve_revb_s,
+        gen_helper_sve_revb_d,
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
+static void trans_REVH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        NULL,
+        gen_helper_sve_revh_s,
+        gen_helper_sve_revh_d,
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
+static void trans_REVW(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    do_zpz_ool(s, a, a->esz == 3 ? gen_helper_sve_revw_d : NULL);
+}
+
+static void trans_RBIT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_rbit_b,
+        gen_helper_sve_rbit_h,
+        gen_helper_sve_rbit_s,
+        gen_helper_sve_rbit_d,
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5e127de88c..8903fb6592 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -457,6 +457,13 @@ CPY_m_v		00000101 .. 100000 100 ... ..... .....		@rd_pg_rn
 # SVE copy element from general register to vector (predicated)
 CPY_m_r		00000101 .. 101000 101 ... ..... .....		@rd_pg_rn
 
+# SVE reverse within elements
+# Note esz >= operation size
+REVB		00000101 .. 1001 00 100 ... ..... .....		@rd_pg_rn
+REVH		00000101 .. 1001 01 100 ... ..... .....		@rd_pg_rn
+REVW		00000101 .. 1001 10 100 ... ..... .....		@rd_pg_rn
+RBIT		00000101 .. 1001 11 100 ... ..... .....		@rd_pg_rn
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.14.3

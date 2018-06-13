Received: from eggs.gnu.org ([2001:4830:134:3::10]:44069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv29-0002KF-J5
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fSv28-0006Gh-Am
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:13 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:46041)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fSv28-0006GW-2I
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 21:57:12 -0400
Received: by mail-pf0-x22f.google.com with SMTP id a22-v6so497620pfo.12
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 18:57:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 12 Jun 2018 15:56:31 -1000
Message-Id: <20180613015641.5667-9-richard.henderson@linaro.org>
In-Reply-To: <20180613015641.5667-1-richard.henderson@linaro.org>
References: <20180613015641.5667-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4b 08/18] target/arm: Implement SVE reverse
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
Cc: peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 14 +++++++++++++
 target/arm/sve_helper.c    | 41 +++++++++++++++++++++++++++++++-------
 target/arm/translate-sve.c | 38 +++++++++++++++++++++++++++++++++++
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
index cb7d101b57..4017b9eed1 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -238,6 +238,26 @@ static inline uint64_t expand_pred_s(uint8_t byte)
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
@@ -616,6 +636,20 @@ DO_ZPZ(sve_neg_h, uint16_t, H1_2, DO_NEG)
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
@@ -1587,13 +1621,6 @@ void HELPER(sve_rev_b)(void *vd, void *vn, uint32_t desc)
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
index eed59524a9..f8d8cf1547 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2643,6 +2643,44 @@ static bool trans_CPY_m_v(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
     return true;
 }
 
+static bool trans_REVB(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        gen_helper_sve_revb_h,
+        gen_helper_sve_revb_s,
+        gen_helper_sve_revb_d,
+    };
+    return do_zpz_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_REVH(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL,
+        NULL,
+        gen_helper_sve_revh_s,
+        gen_helper_sve_revh_d,
+    };
+    return do_zpz_ool(s, a, fns[a->esz]);
+}
+
+static bool trans_REVW(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    return do_zpz_ool(s, a, a->esz == 3 ? gen_helper_sve_revw_d : NULL);
+}
+
+static bool trans_RBIT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve_rbit_b,
+        gen_helper_sve_rbit_h,
+        gen_helper_sve_rbit_s,
+        gen_helper_sve_rbit_d,
+    };
+    return do_zpz_ool(s, a, fns[a->esz]);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 519139f684..95eb4968a9 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -456,6 +456,13 @@ CPY_m_v         00000101 .. 100000 100 ... ..... .....          @rd_pg_rn
 # SVE copy element from general register to vector (predicated)
 CPY_m_r         00000101 .. 101000 101 ... ..... .....          @rd_pg_rn
 
+# SVE reverse within elements
+# Note esz >= operation size
+REVB            00000101 .. 1001 00 100 ... ..... .....         @rd_pg_rn
+REVH            00000101 .. 1001 01 100 ... ..... .....         @rd_pg_rn
+REVW            00000101 .. 1001 10 100 ... ..... .....         @rd_pg_rn
+RBIT            00000101 .. 1001 11 100 ... ..... .....         @rd_pg_rn
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1

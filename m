Received: from eggs.gnu.org ([2001:4830:134:3::10]:40218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79l-0000uS-Bg
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79k-0001r8-AB
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:17 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:37119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79k-0001qY-1h
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:16 -0500
Received: by mail-pg0-x241.google.com with SMTP id o1so4353677pgn.4
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:46 -0800
Message-Id: <20180217182323.25885-31-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 30/67] target/arm: Implement SVE compress
 active elements
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
 target/arm/helper-sve.h    |  3 +++
 target/arm/sve_helper.c    | 34 ++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 12 ++++++++++++
 target/arm/sve.decode      |  6 ++++++
 4 files changed, 55 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index bab20345c6..d977aea00d 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -460,6 +460,9 @@ DEF_HELPER_FLAGS_4(sve_trn_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_trn_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_compact_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve_compact_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_5(sve_and_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_bic_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_eor_pppp, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 62982bd099..87a1a32232 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2016,3 +2016,37 @@ DO_TRN(sve_trn_d, uint64_t, )
 #undef DO_ZIP
 #undef DO_UZP
 #undef DO_TRN
+
+void HELPER(sve_compact_s)(void *vd, void *vn, void *vg, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc) / 4;
+    uint32_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+
+    for (i = j = 0; i < opr_sz; i++) {
+        if (pg[H1(i / 2)] & (i & 1 ? 0x10 : 0x01)) {
+            d[H4(j)] = n[H4(i)];
+            j++;
+        }
+    }
+    for (; j < opr_sz; j++) {
+        d[H4(j)] = 0;
+    }
+}
+
+void HELPER(sve_compact_d)(void *vd, void *vn, void *vg, uint32_t desc)
+{
+    intptr_t i, j, opr_sz = simd_oprsz(desc) / 8;
+    uint64_t *d = vd, *n = vn;
+    uint8_t *pg = vg;
+
+    for (i = j = 0; i < opr_sz; i++) {
+        if (pg[H1(i)] & 1) {
+            d[j] = n[i];
+            j++;
+        }
+    }
+    for (; j < opr_sz; j++) {
+        d[j] = 0;
+    }
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 09ac955a36..21531b259c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2111,6 +2111,18 @@ static void trans_TRN2_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     do_zzz_data_ool(s, a, 1 << a->esz, trn_fns[a->esz]);
 }
 
+/*
+ *** SVE Permute Vector - Predicated Group
+ */
+
+static void trans_COMPACT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL, NULL, gen_helper_sve_compact_s, gen_helper_sve_compact_d
+    };
+    do_zpz_ool(s, a, fns[a->esz]);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 2efa3773fc..a89bd37eeb 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -425,6 +425,12 @@ UZP2_z		00000101 .. 1 ..... 011 011 ..... .....		@rd_rn_rm
 TRN1_z		00000101 .. 1 ..... 011 100 ..... .....		@rd_rn_rm
 TRN2_z		00000101 .. 1 ..... 011 101 ..... .....		@rd_rn_rm
 
+### SVE Permute - Predicated Group
+
+# SVE compress active elements
+# Note esz >= 2
+COMPACT		00000101 .. 100001 100 ... ..... .....		@rd_pg_rn
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.14.3

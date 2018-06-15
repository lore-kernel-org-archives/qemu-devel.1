Received: from eggs.gnu.org ([2001:4830:134:3::10]:60914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfZ-0001iX-RP
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfY-0006Iu-Lx
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfY-0006IB-EM
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:40 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfX-0003kg-FF
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:39 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:25:01 +0100
Message-Id: <20180615142521.19143-24-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 23/43] target/arm: Implement SVE compress active
 elements
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
Message-id: 20180613015641.5667-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h    |  3 +++
 target/arm/sve_helper.c    | 34 ++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 12 ++++++++++++
 target/arm/sve.decode      |  6 ++++++
 4 files changed, 55 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index bab20345c62..d977aea00d8 100644
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
index f114e9ab635..ed3c6d4ca9d 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -2036,3 +2036,37 @@ DO_TRN(sve_trn_d, uint64_t, )
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
index 21319518d70..ed0f48a927c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -2284,6 +2284,18 @@ static bool trans_TRN2_z(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     return do_zzz_data_ool(s, a, 1 << a->esz, trn_fns[a->esz]);
 }
 
+/*
+ *** SVE Permute Vector - Predicated Group
+ */
+
+static bool trans_COMPACT(DisasContext *s, arg_rpr_esz *a, uint32_t insn)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        NULL, NULL, gen_helper_sve_compact_s, gen_helper_sve_compact_d
+    };
+    return do_zpz_ool(s, a, fns[a->esz]);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index df2b94dc0a8..9da6566d325 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -424,6 +424,12 @@ UZP2_z          00000101 .. 1 ..... 011 011 ..... .....         @rd_rn_rm
 TRN1_z          00000101 .. 1 ..... 011 100 ..... .....         @rd_rn_rm
 TRN2_z          00000101 .. 1 ..... 011 101 ..... .....         @rd_rn_rm
 
+### SVE Permute - Predicated Group
+
+# SVE compress active elements
+# Note esz >= 2
+COMPACT         00000101 .. 100001 100 ... ..... .....          @rd_pg_rn
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.1

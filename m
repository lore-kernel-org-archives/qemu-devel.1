Received: from eggs.gnu.org ([2001:4830:134:3::10]:40068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79b-0000hM-OU
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79a-0001lB-MY
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:07 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:43777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79a-0001ks-Gz
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:24:06 -0500
Received: by mail-pg0-x243.google.com with SMTP id f6so4342993pgs.10
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:24:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:40 -0800
Message-Id: <20180217182323.25885-25-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 24/67] target/arm: Implement SVE Bitwise
 Immediate Group
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
 target/arm/translate-sve.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 17 ++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 702f20e97b..21b1e4df85 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -34,6 +34,8 @@
 #include "translate-a64.h"
 
 typedef void GVecGen2Fn(unsigned, uint32_t, uint32_t, uint32_t, uint32_t);
+typedef void GVecGen2iFn(unsigned, uint32_t, uint32_t,
+                         int64_t, uint32_t, uint32_t);
 typedef void GVecGen3Fn(unsigned, uint32_t, uint32_t,
                         uint32_t, uint32_t, uint32_t);
 
@@ -1648,6 +1650,54 @@ static void trans_SINCDEC_v(DisasContext *s, arg_incdec2_cnt *a,
     }
 }
 
+/*
+ *** SVE Bitwise Immediate Group
+ */
+
+static void do_zz_dbm(DisasContext *s, arg_rr_dbm *a, GVecGen2iFn *gvec_fn)
+{
+    unsigned vsz;
+    uint64_t imm;
+
+    if (!logic_imm_decode_wmask(&imm, extract32(a->dbm, 12, 1),
+                                extract32(a->dbm, 0, 6),
+                                extract32(a->dbm, 6, 6))) {
+        unallocated_encoding(s);
+        return;
+    }
+
+    vsz = vec_full_reg_size(s);
+    gvec_fn(MO_64, vec_full_reg_offset(s, a->rd),
+            vec_full_reg_offset(s, a->rn), imm, vsz, vsz);
+}
+
+static void trans_AND_zzi(DisasContext *s, arg_rr_dbm *a, uint32_t insn)
+{
+    do_zz_dbm(s, a, tcg_gen_gvec_andi);
+}
+
+static void trans_ORR_zzi(DisasContext *s, arg_rr_dbm *a, uint32_t insn)
+{
+    do_zz_dbm(s, a, tcg_gen_gvec_ori);
+}
+
+static void trans_EOR_zzi(DisasContext *s, arg_rr_dbm *a, uint32_t insn)
+{
+    do_zz_dbm(s, a, tcg_gen_gvec_xori);
+}
+
+static void trans_DUPM(DisasContext *s, arg_DUPM *a, uint32_t insn)
+{
+    uint64_t imm;
+    if (!logic_imm_decode_wmask(&imm, extract32(a->dbm, 12, 1),
+                                extract32(a->dbm, 0, 6),
+                                extract32(a->dbm, 6, 6))) {
+        unallocated_encoding(s);
+        return;
+    }
+    do_dupi_z(s, a->rd, imm);
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5690b5fcb9..0990d135f4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -50,6 +50,7 @@
 
 &rr_esz		rd rn esz
 &rri		rd rn imm
+&rr_dbm		rd rn dbm
 &rrri		rd rn rm imm
 &rri_esz	rd rn imm esz
 &rrr_esz	rd rn rm esz
@@ -112,6 +113,10 @@
 @rd_rn_tszimm	........ .. ... ... ...... rn:5 rd:5 \
 		&rri_esz esz=%tszimm16_esz
 
+# Two register operand, one encoded bitmask.
+@rdn_dbm	........ .. .... dbm:13 rd:5 \
+		&rr_dbm rn=%reg_movprfx
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9	........ ........ ...... rn:5 . rd:4	\
 		&rri imm=%imm9_16_10
@@ -331,6 +336,18 @@ INCDEC_v	00000100 .. 1 1 .... 1100 0 d:1 ..... .....    @incdec2_cnt u=1
 # Note these require esz != 0.
 SINCDEC_v	00000100 .. 1 0 .... 1100 d:1 u:1 ..... .....	@incdec2_cnt
 
+### SVE Bitwise Immediate Group
+
+# SVE bitwise logical with immediate (unpredicated)
+ORR_zzi		00000101 00 0000 ............. .....		@rdn_dbm
+EOR_zzi		00000101 01 0000 ............. .....		@rdn_dbm
+AND_zzi		00000101 10 0000 ............. .....		@rdn_dbm
+
+# SVE broadcast bitmask immediate
+DUPM		00000101 11 0000 dbm:13 rd:5
+
+### SVE Predicate Logical Operations Group
+
 # SVE predicate logical operations
 AND_pppp	00100101 0. 00 .... 01 .... 0 .... 0 ....	@pd_pg_pn_pm_s
 BIC_pppp	00100101 0. 00 .... 01 .... 0 .... 1 ....	@pd_pg_pn_pm_s
-- 
2.14.3

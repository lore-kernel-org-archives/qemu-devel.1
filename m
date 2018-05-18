Received: from eggs.gnu.org ([2001:4830:134:3::10]:36237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3T-0000tA-F2
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3R-0007gW-Uu
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:35 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3R-0007fI-EO
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:33 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3Q-0004x4-3J
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:32 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:20:07 +0100
Message-Id: <20180518172009.14416-31-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 30/32] target/arm: Implement SVE Bitwise
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180516223007.10256-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 49 ++++++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 17 +++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 2a0bf6b47c..9d7c18c48d 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1785,6 +1785,55 @@ static bool trans_SINCDEC_v(DisasContext *s, arg_incdec2_cnt *a,
     return true;
 }
 
+/*
+ *** SVE Bitwise Immediate Group
+ */
+
+static bool do_zz_dbm(DisasContext *s, arg_rr_dbm *a, GVecGen2iFn *gvec_fn)
+{
+    uint64_t imm;
+    if (!logic_imm_decode_wmask(&imm, extract32(a->dbm, 12, 1),
+                                extract32(a->dbm, 0, 6),
+                                extract32(a->dbm, 6, 6))) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        gvec_fn(MO_64, vec_full_reg_offset(s, a->rd),
+                vec_full_reg_offset(s, a->rn), imm, vsz, vsz);
+    }
+    return true;
+}
+
+static bool trans_AND_zzi(DisasContext *s, arg_rr_dbm *a, uint32_t insn)
+{
+    return do_zz_dbm(s, a, tcg_gen_gvec_andi);
+}
+
+static bool trans_ORR_zzi(DisasContext *s, arg_rr_dbm *a, uint32_t insn)
+{
+    return do_zz_dbm(s, a, tcg_gen_gvec_ori);
+}
+
+static bool trans_EOR_zzi(DisasContext *s, arg_rr_dbm *a, uint32_t insn)
+{
+    return do_zz_dbm(s, a, tcg_gen_gvec_xori);
+}
+
+static bool trans_DUPM(DisasContext *s, arg_DUPM *a, uint32_t insn)
+{
+    uint64_t imm;
+    if (!logic_imm_decode_wmask(&imm, extract32(a->dbm, 12, 1),
+                                extract32(a->dbm, 0, 6),
+                                extract32(a->dbm, 6, 6))) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        do_dupi_z(s, a->rd, imm);
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index b6890d0410..a3277a0d21 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -49,6 +49,7 @@
 
 &rr_esz         rd rn esz
 &rri            rd rn imm
+&rr_dbm         rd rn dbm
 &rrri           rd rn rm imm
 &rri_esz        rd rn imm esz
 &rrr_esz        rd rn rm esz
@@ -111,6 +112,10 @@
 @rd_rn_tszimm   ........ .. ... ... ...... rn:5 rd:5 \
                 &rri_esz esz=%tszimm16_esz
 
+# Two register operand, one encoded bitmask.
+@rdn_dbm        ........ .. .... dbm:13 rd:5 \
+                &rr_dbm rn=%reg_movprfx
+
 # Basic Load/Store with 9-bit immediate offset
 @pd_rn_i9       ........ ........ ...... rn:5 . rd:4    \
                 &rri imm=%imm9_16_10
@@ -330,6 +335,18 @@ INCDEC_v        00000100 .. 1 1 .... 1100 0 d:1 ..... .....    @incdec2_cnt u=1
 # Note these require esz != 0.
 SINCDEC_v       00000100 .. 1 0 .... 1100 d:1 u:1 ..... .....   @incdec2_cnt
 
+### SVE Bitwise Immediate Group
+
+# SVE bitwise logical with immediate (unpredicated)
+ORR_zzi         00000101 00 0000 ............. .....            @rdn_dbm
+EOR_zzi         00000101 01 0000 ............. .....            @rdn_dbm
+AND_zzi         00000101 10 0000 ............. .....            @rdn_dbm
+
+# SVE broadcast bitmask immediate
+DUPM            00000101 11 0000 dbm:13 rd:5
+
+### SVE Predicate Logical Operations Group
+
 # SVE predicate logical operations
 AND_pppp        00100101 0. 00 .... 01 .... 0 .... 0 ....       @pd_pg_pn_pm_s
 BIC_pppp        00100101 0. 00 .... 01 .... 0 .... 1 ....       @pd_pg_pn_pm_s
-- 
2.17.0

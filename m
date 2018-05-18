Received: from eggs.gnu.org ([2001:4830:134:3::10]:36150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3O-0000oy-N7
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3N-0007d6-3e
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj3M-0007bv-Nh
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:29 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3L-0004uA-L0
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:20:01 +0100
Message-Id: <20180518172009.14416-25-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 24/32] target/arm: Implement SVE Stack
 Allocation Group
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
Message-id: 20180516223007.10256-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 27 +++++++++++++++++++++++++++
 target/arm/sve.decode      | 12 ++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index e3a8e9506e..f95efa3c72 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -781,6 +781,33 @@ static bool trans_INDEX_rr(DisasContext *s, arg_INDEX_rr *a, uint32_t insn)
     return true;
 }
 
+/*
+ *** SVE Stack Allocation Group
+ */
+
+static bool trans_ADDVL(DisasContext *s, arg_ADDVL *a, uint32_t insn)
+{
+    TCGv_i64 rd = cpu_reg_sp(s, a->rd);
+    TCGv_i64 rn = cpu_reg_sp(s, a->rn);
+    tcg_gen_addi_i64(rd, rn, a->imm * vec_full_reg_size(s));
+    return true;
+}
+
+static bool trans_ADDPL(DisasContext *s, arg_ADDPL *a, uint32_t insn)
+{
+    TCGv_i64 rd = cpu_reg_sp(s, a->rd);
+    TCGv_i64 rn = cpu_reg_sp(s, a->rn);
+    tcg_gen_addi_i64(rd, rn, a->imm * pred_full_reg_size(s));
+    return true;
+}
+
+static bool trans_RDVL(DisasContext *s, arg_RDVL *a, uint32_t insn)
+{
+    TCGv_i64 reg = cpu_reg(s, a->rd);
+    tcg_gen_movi_i64(reg, a->imm * vec_full_reg_size(s));
+    return true;
+}
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 4f9f64f5ab..9d5c061165 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -84,6 +84,9 @@
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn       ........ esz:2 ... ... ... pg:3 rn:5 rd:5       &rpr_esz
 
+# Two register operands with a 6-bit signed immediate.
+@rd_rn_i6       ........ ... rn:5 ..... imm:s6 rd:5             &rri
+
 # Two register operand, one immediate operand, with predicate,
 # element size encoded as TSZHL.  User must fill in imm.
 @rdn_pg_tszimm  ........ .. ... ... ... pg:3 ..... rd:5 \
@@ -238,6 +241,15 @@ INDEX_ri        00000100 esz:2 1 imm:s5 010001 rn:5 rd:5
 # SVE index generation (register start, register increment)
 INDEX_rr        00000100 .. 1 ..... 010011 ..... .....          @rd_rn_rm
 
+### SVE Stack Allocation Group
+
+# SVE stack frame adjustment
+ADDVL           00000100 001 ..... 01010 ...... .....           @rd_rn_i6
+ADDPL           00000100 011 ..... 01010 ...... .....           @rd_rn_i6
+
+# SVE stack frame size
+RDVL            00000100 101 11111 01010 imm:s6 rd:5
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.17.0

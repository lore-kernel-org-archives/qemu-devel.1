Received: from eggs.gnu.org ([2001:4830:134:3::10]:41296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wP-0007o5-3V
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wN-0007Zf-UI
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:36 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:40160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4wN-0007Xx-Bv
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:35 -0400
Received: by mail-pl0-x244.google.com with SMTP id t12-v6so1244693plo.7
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:29:57 -0700
Message-Id: <20180516223007.10256-18-richard.henderson@linaro.org>
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3-a 17/27] target/arm: Implement SVE Stack
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79S-0000ae-J7
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79R-0001g3-BH
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:58 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:41240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79R-0001fc-5R
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:57 -0500
Received: by mail-pf0-x244.google.com with SMTP id 68so590897pfj.8
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:23:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:34 -0800
Message-Id: <20180217182323.25885-19-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 18/67] target/arm: Implement SVE Stack
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
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 24 ++++++++++++++++++++++++
 target/arm/sve.decode      | 12 ++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 773f0bfded..4a38020c8a 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -742,6 +742,30 @@ static void trans_INDEX_rr(DisasContext *s, arg_INDEX_rr *a, uint32_t insn)
     do_index(s, a->esz, a->rd, start, incr);
 }
 
+/*
+ *** SVE Stack Allocation Group
+ */
+
+static void trans_ADDVL(DisasContext *s, arg_ADDVL *a, uint32_t insn)
+{
+    TCGv_i64 rd = cpu_reg_sp(s, a->rd);
+    TCGv_i64 rn = cpu_reg_sp(s, a->rn);
+    tcg_gen_addi_i64(rd, rn, a->imm * vec_full_reg_size(s));
+}
+
+static void trans_ADDPL(DisasContext *s, arg_ADDPL *a, uint32_t insn)
+{
+    TCGv_i64 rd = cpu_reg_sp(s, a->rd);
+    TCGv_i64 rn = cpu_reg_sp(s, a->rn);
+    tcg_gen_addi_i64(rd, rn, a->imm * pred_full_reg_size(s));
+}
+
+static void trans_RDVL(DisasContext *s, arg_RDVL *a, uint32_t insn)
+{
+    TCGv_i64 reg = cpu_reg(s, a->rd);
+    tcg_gen_movi_i64(reg, a->imm * vec_full_reg_size(s));
+}
+
 /*
  *** SVE Predicate Logical Operations Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index d7b078e92f..0b47869dcd 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -86,6 +86,9 @@
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn	........ esz:2 ... ... ... pg:3 rn:5 rd:5	&rpr_esz
 
+# Two register operands with a 6-bit signed immediate.
+@rd_rn_i6	........ ... rn:5 ..... imm:s6 rd:5		&rri
+
 # Two register operand, one immediate operand, with predicate,
 # element size encoded as TSZHL.  User must fill in imm.
 @rdn_pg_tszimm	........ .. ... ... ... pg:3 ..... rd:5 \
@@ -240,6 +243,15 @@ INDEX_ri	00000100 esz:2 1 imm:s5 010001 rn:5 rd:5
 # SVE index generation (register start, register increment)
 INDEX_rr	00000100 .. 1 ..... 010011 ..... .....		@rd_rn_rm
 
+### SVE Stack Allocation Group
+
+# SVE stack frame adjustment
+ADDVL		00000100 001 ..... 01010 ...... .....		@rd_rn_i6
+ADDPL		00000100 011 ..... 01010 ...... .....		@rd_rn_i6
+
+# SVE stack frame size
+RDVL		00000100 101 11111 01010 imm:s6 rd:5
+
 ### SVE Predicate Logical Operations Group
 
 # SVE predicate logical operations
-- 
2.14.3

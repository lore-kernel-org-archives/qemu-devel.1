Received: from eggs.gnu.org ([2001:4830:134:3::10]:55975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUe-0008Pi-Rw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUd-0002Eh-SN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:24 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:39419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUd-0002Do-NC
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:23 -0500
Received: by mail-pf0-x244.google.com with SMTP id l24so9973261pfj.6
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:47 -0800
Message-Id: <20171218174552.18871-19-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 18/23] target/arm: Implement SVE Stack
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 18 ++++++++++++++++++
 target/arm/sve.def         | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7e1bf7d623..026af7a162 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -639,6 +639,24 @@ void trans_INDEX_rr(DisasContext *s, arg_INDEX_rr *a, uint32_t insn)
     do_index(s, a->esz, a->rd, start, incr);
 }
 
+void trans_ADDVL(DisasContext *s, arg_ADDVL *a, uint32_t insn)
+{
+    TCGv_i64 reg = cpu_reg_sp(s, a->rd);
+    tcg_gen_addi_i64(reg, reg, a->imm * vec_full_reg_size(s));
+}
+
+void trans_ADDPL(DisasContext *s, arg_ADDPL *a, uint32_t insn)
+{
+    TCGv_i64 reg = cpu_reg_sp(s, a->rd);
+    tcg_gen_addi_i64(reg, reg, a->imm * pred_full_reg_size(s));
+}
+
+void trans_RDVL(DisasContext *s, arg_RDVL *a, uint32_t insn)
+{
+    TCGv_i64 reg = cpu_reg(s, a->rd);
+    tcg_gen_movi_i64(reg, a->imm * vec_full_reg_size(s));
+}
+
 static uint64_t pred_esz_mask[4] = {
     0xffffffffffffffffull, 0x5555555555555555ull,
     0x1111111111111111ull, 0x0101010101010101ull
diff --git a/target/arm/sve.def b/target/arm/sve.def
index 0cac3a974f..7428ebc5cd 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -73,6 +73,9 @@
 # One register operand, with governing predicate, vector element size
 @rd_pg_rn_esz		........ esz:2 ... ... ... pg:3 rn:5 rd:5	&rpr_esz
 
+# Two register operands with a 6-bit signed immediate.
+@rd_rn_i6		........ ... rn:5 ..... imm:s6 rd:5		&rri
+
 # Two register operand, one immediate operand, with predicate, element size encoded as TSZHL.
 # User must fill in imm.
 @rdn_pg_tszimm		........ .. ... ... ... pg:3 ..... rd:5		&rpri_esz rn=%reg_movprfx esz=%tszimm_esz
@@ -218,6 +221,15 @@ INDEX_ri		00000100 esz:2 1 imm:s5 010001 rn:5 rd:5
 # SVE index generation (register start, register increment)
 INDEX_rr		00000100 .. 1 ..... 010011 ..... .....		@rd_rn_rm_esz
 
+### SVE Stack Allocation Group
+
+# SVE stack frame adjustment
+ADDVL			00000100 001 ..... 01010 ...... .....		@rd_rn_i6
+ADDPL			00000100 011 ..... 01010 ...... .....		@rd_rn_i6
+
+# SVE stack frame size
+RDVL			00000100 101 11111 01010 imm:s6 rd:5
+
 ### SVE Predicate Generation Group
 
 # SVE initialize predicate (PTRUE, PTRUES)
-- 
2.14.3

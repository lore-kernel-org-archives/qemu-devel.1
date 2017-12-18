Received: from eggs.gnu.org ([2001:4830:134:3::10]:55921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUd-0008Nn-99
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUb-0002By-2f
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:23 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:40519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUa-0002BG-Sw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:20 -0500
Received: by mail-pg0-x243.google.com with SMTP id k15so9432982pgr.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:45 -0800
Message-Id: <20171218174552.18871-17-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 16/23] target/arm: Implement SVE Integer
 Arithmetic - Unpredicated Group
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
 target/arm/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 target/arm/sve.def         | 13 +++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 83793ab169..7edec8ba96 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -127,6 +127,36 @@ static void do_zzz_genfn(DisasContext *s, arg_rrr_esz *a, GVecGen3Fn *fn)
     do_genfn3(s, fn, a->esz, a->rd, a->rn, a->rm);
 }
 
+void trans_ADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_zzz_genfn(s, a, tcg_gen_gvec_add);
+}
+
+void trans_SUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_zzz_genfn(s, a, tcg_gen_gvec_sub);
+}
+
+void trans_SQADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_zzz_genfn(s, a, tcg_gen_gvec_ssadd);
+}
+
+void trans_SQSUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_zzz_genfn(s, a, tcg_gen_gvec_sssub);
+}
+
+void trans_UQADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_zzz_genfn(s, a, tcg_gen_gvec_usadd);
+}
+
+void trans_UQSUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_zzz_genfn(s, a, tcg_gen_gvec_ussub);
+}
+
 void trans_AND_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
 {
     do_zzz_genfn(s, a, tcg_gen_gvec_and);
diff --git a/target/arm/sve.def b/target/arm/sve.def
index 3ae871394c..a33fec4f33 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -53,6 +53,9 @@
 # Named instruction formats.  These are generally used to
 # reduce the amount of duplication between instruction patterns.
 
+# Three operand
+@rd_rn_rm_esz		........ esz:2 . rm:5  ... ...  rn:5 rd:5	&rrr_esz
+
 # Three operand with unused vector element size
 @rd_rn_rm		........ ... rm:5  ... ...  rn:5 rd:5		&rrr_esz esz=0
 
@@ -183,6 +186,16 @@ MLS			00000100 .. 0 ..... 011 ... ..... .....		@rda_pg_rn_rm_esz
 MLA			00000100 .. 0 ..... 110 ... ..... .....		@rdn_pg_ra_rm_esz # MAD
 MLS			00000100 .. 0 ..... 111 ... ..... .....		@rdn_pg_ra_rm_esz # MSB
 
+### SVE Integer Arithmetic - Unpredicated Group
+
+# SVE integer add/subtract vectors (unpredicated)
+ADD_zzz			00000100 .. 1 ..... 000 000 ..... .....		@rd_rn_rm_esz
+SUB_zzz			00000100 .. 1 ..... 000 001 ..... .....		@rd_rn_rm_esz
+SQADD_zzz		00000100 .. 1 ..... 000 100 ..... .....		@rd_rn_rm_esz
+UQADD_zzz		00000100 .. 1 ..... 000 101 ..... .....		@rd_rn_rm_esz
+SQSUB_zzz		00000100 .. 1 ..... 000 110 ..... .....		@rd_rn_rm_esz
+UQSUB_zzz		00000100 .. 1 ..... 000 111 ..... .....		@rd_rn_rm_esz
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.14.3

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79P-0000Ws-Jx
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en79O-0001eU-EZ
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:55 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:45434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en79O-0001eA-AO
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 13:23:54 -0500
Received: by mail-pl0-x243.google.com with SMTP id p5so3428335plo.12
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 10:23:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 10:22:32 -0800
Message-Id: <20180217182323.25885-17-richard.henderson@linaro.org>
In-Reply-To: <20180217182323.25885-1-richard.henderson@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 16/67] target/arm: Implement SVE Integer
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
Cc: qemu-arm@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 41 ++++++++++++++++++++++++++++++++++++++---
 target/arm/sve.decode      | 13 +++++++++++++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b956d87636..8baec6c674 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -235,6 +235,40 @@ static void trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn)
     do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
 }
 
+/*
+ *** SVE Integer Arithmetic - Unpredicated Group
+ */
+
+static void trans_ADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_vector3_z(s, tcg_gen_gvec_add, a->esz, a->rd, a->rn, a->rm);
+}
+
+static void trans_SUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_vector3_z(s, tcg_gen_gvec_sub, a->esz, a->rd, a->rn, a->rm);
+}
+
+static void trans_SQADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_vector3_z(s, tcg_gen_gvec_ssadd, a->esz, a->rd, a->rn, a->rm);
+}
+
+static void trans_SQSUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_vector3_z(s, tcg_gen_gvec_sssub, a->esz, a->rd, a->rn, a->rm);
+}
+
+static void trans_UQADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_vector3_z(s, tcg_gen_gvec_usadd, a->esz, a->rd, a->rn, a->rm);
+}
+
+static void trans_UQSUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    do_vector3_z(s, tcg_gen_gvec_ussub, a->esz, a->rd, a->rn, a->rm);
+}
+
 /*
  *** SVE Integer Arithmetic - Binary Predicated Group
  */
@@ -254,7 +288,8 @@ static void do_zpzz_ool(DisasContext *s, arg_rprr_esz *a, gen_helper_gvec_4 *fn)
 }
 
 #define DO_ZPZZ(NAME, name) \
-void trans_##NAME##_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn) \
+static void trans_##NAME##_zpzz(DisasContext *s, arg_rprr_esz *a,         \
+                                uint32_t insn)                            \
 {                                                                         \
     static gen_helper_gvec_4 * const fns[4] = {                           \
         gen_helper_sve_##name##_zpzz_b, gen_helper_sve_##name##_zpzz_h,   \
@@ -286,7 +321,7 @@ DO_ZPZZ(ASR, asr)
 DO_ZPZZ(LSR, lsr)
 DO_ZPZZ(LSL, lsl)
 
-void trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+static void trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
 {
     static gen_helper_gvec_4 * const fns[4] = {
         NULL, NULL, gen_helper_sve_sdiv_zpzz_s, gen_helper_sve_sdiv_zpzz_d
@@ -294,7 +329,7 @@ void trans_SDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
     do_zpzz_ool(s, a, fns[a->esz]);
 }
 
-void trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
+static void trans_UDIV_zpzz(DisasContext *s, arg_rprr_esz *a, uint32_t insn)
 {
     static gen_helper_gvec_4 * const fns[4] = {
         NULL, NULL, gen_helper_sve_udiv_zpzz_s, gen_helper_sve_udiv_zpzz_d
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 68a1823b72..b40d7dc9a2 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -68,6 +68,9 @@
 # Three prediate operand, with governing predicate, flag setting
 @pd_pg_pn_pm_s	........ . s:1 .. rm:4 .. pg:4 . rn:4 . rd:4	&rprr_s
 
+# Three operand, vector element size
+@rd_rn_rm	........ esz:2 . rm:5  ... ...  rn:5 rd:5	&rrr_esz
+
 # Two register operand, with governing predicate, vector element size
 @rdn_pg_rm	........ esz:2 ... ... ... pg:3 rm:5 rd:5 \
 		&rprr_esz rn=%reg_movprfx
@@ -205,6 +208,16 @@ MLS		00000100 .. 0 ..... 011 ... ..... .....   @rda_pg_rn_rm
 MLA		00000100 .. 0 ..... 110 ... ..... .....   @rdn_pg_ra_rm # MAD
 MLS		00000100 .. 0 ..... 111 ... ..... .....   @rdn_pg_ra_rm # MSB
 
+### SVE Integer Arithmetic - Unpredicated Group
+
+# SVE integer add/subtract vectors (unpredicated)
+ADD_zzz		00000100 .. 1 ..... 000 000 ..... .....		@rd_rn_rm
+SUB_zzz		00000100 .. 1 ..... 000 001 ..... .....		@rd_rn_rm
+SQADD_zzz	00000100 .. 1 ..... 000 100 ..... .....		@rd_rn_rm
+UQADD_zzz	00000100 .. 1 ..... 000 101 ..... .....		@rd_rn_rm
+SQSUB_zzz	00000100 .. 1 ..... 000 110 ..... .....		@rd_rn_rm
+UQSUB_zzz	00000100 .. 1 ..... 000 111 ..... .....		@rd_rn_rm
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.14.3

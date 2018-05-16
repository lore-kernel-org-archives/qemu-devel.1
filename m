Received: from eggs.gnu.org ([2001:4830:134:3::10]:41220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wL-0007kO-TL
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4wK-0007Wk-Sa
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:33 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:40157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4wK-0007W7-HN
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:32 -0400
Received: by mail-pl0-x241.google.com with SMTP id t12-v6so1244645plo.7
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:29:55 -0700
Message-Id: <20180516223007.10256-16-richard.henderson@linaro.org>
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3-a 15/27] target/arm: Implement SVE Integer
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 34 ++++++++++++++++++++++++++++++++++
 target/arm/sve.decode      | 13 +++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f14bb2196a..d9c4118d46 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -251,6 +251,40 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     return do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
 }
 
+/*
+ *** SVE Integer Arithmetic - Unpredicated Group
+ */
+
+static bool trans_ADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_vector3_z(s, tcg_gen_gvec_add, a->esz, a->rd, a->rn, a->rm);
+}
+
+static bool trans_SUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_vector3_z(s, tcg_gen_gvec_sub, a->esz, a->rd, a->rn, a->rm);
+}
+
+static bool trans_SQADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_vector3_z(s, tcg_gen_gvec_ssadd, a->esz, a->rd, a->rn, a->rm);
+}
+
+static bool trans_SQSUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_vector3_z(s, tcg_gen_gvec_sssub, a->esz, a->rd, a->rn, a->rm);
+}
+
+static bool trans_UQADD_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_vector3_z(s, tcg_gen_gvec_usadd, a->esz, a->rd, a->rn, a->rm);
+}
+
+static bool trans_UQSUB_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
+{
+    return do_vector3_z(s, tcg_gen_gvec_ussub, a->esz, a->rd, a->rn, a->rm);
+}
+
 /*
  *** SVE Integer Arithmetic - Binary Predicated Group
  */
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5e4335b2ae..58d59c7b77 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -66,6 +66,9 @@
 # Three predicate operand, with governing predicate, flag setting
 @pd_pg_pn_pm_s  ........ . s:1 .. rm:4 .. pg:4 . rn:4 . rd:4    &rprr_s
 
+# Three operand, vector element size
+@rd_rn_rm       ........ esz:2 . rm:5 ... ... rn:5 rd:5         &rrr_esz
+
 # Two register operand, with governing predicate, vector element size
 @rdn_pg_rm      ........ esz:2 ... ... ... pg:3 rm:5 rd:5 \
                 &rprr_esz rn=%reg_movprfx
@@ -203,6 +206,16 @@ MLS             00000100 .. 0 ..... 011 ... ..... .....   @rda_pg_rn_rm
 MLA             00000100 .. 0 ..... 110 ... ..... .....   @rdn_pg_ra_rm # MAD
 MLS             00000100 .. 0 ..... 111 ... ..... .....   @rdn_pg_ra_rm # MSB
 
+### SVE Integer Arithmetic - Unpredicated Group
+
+# SVE integer add/subtract vectors (unpredicated)
+ADD_zzz         00000100 .. 1 ..... 000 000 ..... .....         @rd_rn_rm
+SUB_zzz         00000100 .. 1 ..... 000 001 ..... .....         @rd_rn_rm
+SQADD_zzz       00000100 .. 1 ..... 000 100 ..... .....         @rd_rn_rm
+UQADD_zzz       00000100 .. 1 ..... 000 101 ..... .....         @rd_rn_rm
+SQSUB_zzz       00000100 .. 1 ..... 000 110 ..... .....         @rd_rn_rm
+UQSUB_zzz       00000100 .. 1 ..... 000 111 ..... .....         @rd_rn_rm
+
 ### SVE Logical - Unpredicated Group
 
 # SVE bitwise logical operations (unpredicated)
-- 
2.17.0

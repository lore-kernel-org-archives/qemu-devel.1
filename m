Received: from eggs.gnu.org ([2001:4830:134:3::10]:55455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwM-0004Fo-1s
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwK-0008V4-Nh
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:34 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILwK-0008Tx-Ez
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:32 -0400
Received: by mail-pf0-x244.google.com with SMTP id a20-v6so2737543pfo.0
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:27:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:27:11 -0700
Message-Id: <20180514222714.7982-11-richard.henderson@linaro.org>
In-Reply-To: <20180514222714.7982-1-richard.henderson@linaro.org>
References: <20180514222714.7982-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 10/13] target/openrisc: Convert dec_comp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, peter.maydell@linaro.org

Acked-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c  | 120 +++++++++++++++++------------------
 target/openrisc/insns.decode |  15 +++++
 2 files changed, 73 insertions(+), 62 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index bdd4626c02..8743b5e96e 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1047,74 +1047,74 @@ static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a, uint32_t insn)
     return true;
 }
 
-static void dec_comp(DisasContext *dc, uint32_t insn)
+static bool trans_l_sfeq(DisasContext *dc, arg_ab *a, TCGCond cond)
 {
-    uint32_t op0;
-    uint32_t ra, rb;
+    LOG_DIS("l.sfeq r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    op0 = extract32(insn, 21, 5);
-    ra = extract32(insn, 16, 5);
-    rb = extract32(insn, 11, 5);
+static bool trans_l_sfne(DisasContext *dc, arg_ab *a, TCGCond cond)
+{
+    LOG_DIS("l.sfne r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    /* unsigned integers  */
-    tcg_gen_ext32u_tl(cpu_R[ra], cpu_R[ra]);
-    tcg_gen_ext32u_tl(cpu_R[rb], cpu_R[rb]);
+static bool trans_l_sfgtu(DisasContext *dc, arg_ab *a, TCGCond cond)
+{
+    LOG_DIS("l.sfgtu r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    switch (op0) {
-    case 0x0:    /* l.sfeq */
-        LOG_DIS("l.sfeq  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
+static bool trans_l_sfgeu(DisasContext *dc, arg_ab *a, TCGCond cond)
+{
+    LOG_DIS("l.sfgeu r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    case 0x1:    /* l.sfne */
-        LOG_DIS("l.sfne  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
+static bool trans_l_sfltu(DisasContext *dc, arg_ab *a, TCGCond cond)
+{
+    LOG_DIS("l.sfltu r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    case 0x2:    /* l.sfgtu */
-        LOG_DIS("l.sfgtu  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
+static bool trans_l_sfleu(DisasContext *dc, arg_ab *a, TCGCond cond)
+{
+    LOG_DIS("l.sfleu r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    case 0x3:    /* l.sfgeu */
-        LOG_DIS("l.sfgeu  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
+static bool trans_l_sfgts(DisasContext *dc, arg_ab *a, TCGCond cond)
+{
+    LOG_DIS("l.sfgts r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_GT, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    case 0x4:    /* l.sfltu */
-        LOG_DIS("l.sfltu  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
+static bool trans_l_sfges(DisasContext *dc, arg_ab *a, TCGCond cond)
+{
+    LOG_DIS("l.sfges r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_GE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    case 0x5:    /* l.sfleu */
-        LOG_DIS("l.sfleu  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
+static bool trans_l_sflts(DisasContext *dc, arg_ab *a, TCGCond cond)
+{
+    LOG_DIS("l.sflts r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_LT, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    case 0xa:    /* l.sfgts */
-        LOG_DIS("l.sfgts  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_GT, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
-
-    case 0xb:    /* l.sfges */
-        LOG_DIS("l.sfges  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_GE, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
-
-    case 0xc:    /* l.sflts */
-        LOG_DIS("l.sflts  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_LT, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
-
-    case 0xd:    /* l.sfles */
-        LOG_DIS("l.sfles  r%d, r%d\n", ra, rb);
-        tcg_gen_setcond_tl(TCG_COND_LE, cpu_sr_f, cpu_R[ra], cpu_R[rb]);
-        break;
-
-    default:
-        gen_illegal_exception(dc);
-        break;
-    }
+static bool trans_l_sfles(DisasContext *dc, arg_ab *a, TCGCond cond)
+{
+    LOG_DIS("l.sfles r%d, r%d\n", a->a, a->b);
+    tcg_gen_setcond_tl(TCG_COND_LE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    return true;
 }
 
 static void dec_compi(DisasContext *dc, uint32_t insn)
@@ -1477,10 +1477,6 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
         dec_float(dc, insn);
         break;
 
-    case 0x39:
-        dec_comp(dc, insn);
-        break;
-
     default:
         gen_illegal_exception(dc);
         break;
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 84f71c13b3..29d28ff5be 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -139,3 +139,18 @@ l_slli          101110 d:5 a:5 -------- 00 l:6
 l_srli          101110 d:5 a:5 -------- 01 l:6
 l_srai          101110 d:5 a:5 -------- 10 l:6
 l_rori          101110 d:5 a:5 -------- 11 l:6
+
+####
+# Compare Instructions
+####
+
+l_sfeq          111001 00000 a:5 b:5 -----------
+l_sfne          111001 00001 a:5 b:5 -----------
+l_sfgtu         111001 00010 a:5 b:5 -----------
+l_sfgeu         111001 00011 a:5 b:5 -----------
+l_sfltu         111001 00100 a:5 b:5 -----------
+l_sfleu         111001 00101 a:5 b:5 -----------
+l_sfgts         111001 01010 a:5 b:5 -----------
+l_sfges         111001 01011 a:5 b:5 -----------
+l_sflts         111001 01100 a:5 b:5 -----------
+l_sfles         111001 01101 a:5 b:5 -----------
-- 
2.17.0

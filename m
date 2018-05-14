Received: from eggs.gnu.org ([2001:4830:134:3::10]:55474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwN-0004Hp-Kf
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILwM-000068-AV
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:35 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:43200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILwM-00004x-1r
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:27:34 -0400
Received: by mail-pg0-x242.google.com with SMTP id p8-v6so2551999pgq.10
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:27:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:27:12 -0700
Message-Id: <20180514222714.7982-12-richard.henderson@linaro.org>
In-Reply-To: <20180514222714.7982-1-richard.henderson@linaro.org>
References: <20180514222714.7982-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 11/13] target/openrisc: Convert dec_compi
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
 target/openrisc/translate.c  | 116 +++++++++++++++++------------------
 target/openrisc/insns.decode |  12 ++++
 2 files changed, 70 insertions(+), 58 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 8743b5e96e..c4256518cb 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1117,70 +1117,74 @@ static bool trans_l_sfles(DisasContext *dc, arg_ab *a, TCGCond cond)
     return true;
 }
 
-static void dec_compi(DisasContext *dc, uint32_t insn)
+static bool trans_l_sfeqi(DisasContext *dc, arg_ai *a, TCGCond cond)
 {
-    uint32_t op0, ra;
-    int32_t I16;
+    LOG_DIS("l.sfeqi r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
+}
 
-    op0 = extract32(insn, 21, 5);
-    ra = extract32(insn, 16, 5);
-    I16 = sextract32(insn, 0, 16);
+static bool trans_l_sfnei(DisasContext *dc, arg_ai *a, TCGCond cond)
+{
+    LOG_DIS("l.sfnei r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
+}
 
-    switch (op0) {
-    case 0x0:    /* l.sfeqi */
-        LOG_DIS("l.sfeqi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[ra], I16);
-        break;
+static bool trans_l_sfgtui(DisasContext *dc, arg_ai *a, TCGCond cond)
+{
+    LOG_DIS("l.sfgtui r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
+}
 
-    case 0x1:    /* l.sfnei */
-        LOG_DIS("l.sfnei  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_f, cpu_R[ra], I16);
-        break;
+static bool trans_l_sfgeui(DisasContext *dc, arg_ai *a, TCGCond cond)
+{
+    LOG_DIS("l.sfgeui r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
+}
 
-    case 0x2:    /* l.sfgtui */
-        LOG_DIS("l.sfgtui  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[ra], I16);
-        break;
+static bool trans_l_sfltui(DisasContext *dc, arg_ai *a, TCGCond cond)
+{
+    LOG_DIS("l.sfltui r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
+}
 
-    case 0x3:    /* l.sfgeui */
-        LOG_DIS("l.sfgeui  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[ra], I16);
-        break;
+static bool trans_l_sfleui(DisasContext *dc, arg_ai *a, TCGCond cond)
+{
+    LOG_DIS("l.sfleui r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
+}
 
-    case 0x4:    /* l.sfltui */
-        LOG_DIS("l.sfltui  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[ra], I16);
-        break;
+static bool trans_l_sfgtsi(DisasContext *dc, arg_ai *a, TCGCond cond)
+{
+    LOG_DIS("l.sfgtsi r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_GT, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
+}
 
-    case 0x5:    /* l.sfleui */
-        LOG_DIS("l.sfleui  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[ra], I16);
-        break;
+static bool trans_l_sfgesi(DisasContext *dc, arg_ai *a, TCGCond cond)
+{
+    LOG_DIS("l.sfgesi r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_GE, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
+}
 
-    case 0xa:    /* l.sfgtsi */
-        LOG_DIS("l.sfgtsi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_GT, cpu_sr_f, cpu_R[ra], I16);
-        break;
+static bool trans_l_sfltsi(DisasContext *dc, arg_ai *a, TCGCond cond)
+{
+    LOG_DIS("l.sfltsi r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_LT, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
+}
 
-    case 0xb:    /* l.sfgesi */
-        LOG_DIS("l.sfgesi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_GE, cpu_sr_f, cpu_R[ra], I16);
-        break;
-
-    case 0xc:    /* l.sfltsi */
-        LOG_DIS("l.sfltsi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_LT, cpu_sr_f, cpu_R[ra], I16);
-        break;
-
-    case 0xd:    /* l.sflesi */
-        LOG_DIS("l.sflesi  r%d, %d\n", ra, I16);
-        tcg_gen_setcondi_tl(TCG_COND_LE, cpu_sr_f, cpu_R[ra], I16);
-        break;
-
-    default:
-        gen_illegal_exception(dc);
-        break;
-    }
+static bool trans_l_sflesi(DisasContext *dc, arg_ai *a, TCGCond cond)
+{
+    LOG_DIS("l.sflesi r%d, %d\n", a->a, a->i);
+    tcg_gen_setcondi_tl(TCG_COND_LE, cpu_sr_f, cpu_R[a->a], a->i);
+    return true;
 }
 
 static bool trans_l_sys(DisasContext *dc, arg_l_sys *a, uint32_t insn)
@@ -1469,10 +1473,6 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
 
     op0 = extract32(insn, 26, 6);
     switch (op0) {
-    case 0x2f:
-        dec_compi(dc, insn);
-        break;
-
     case 0x32:
         dec_float(dc, insn);
         break;
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 29d28ff5be..4ec0e2de3a 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -21,6 +21,7 @@
 &da             d a
 &ab             a b
 &dal            d a l
+&ai             a i
 
 ####
 # System Instructions
@@ -154,3 +155,14 @@ l_sfgts         111001 01010 a:5 b:5 -----------
 l_sfges         111001 01011 a:5 b:5 -----------
 l_sflts         111001 01100 a:5 b:5 -----------
 l_sfles         111001 01101 a:5 b:5 -----------
+
+l_sfeqi         101111 00000 a:5 i:s16
+l_sfnei         101111 00001 a:5 i:s16
+l_sfgtui        101111 00010 a:5 i:s16
+l_sfgeui        101111 00011 a:5 i:s16
+l_sfltui        101111 00100 a:5 i:s16
+l_sfleui        101111 00101 a:5 i:s16
+l_sfgtsi        101111 01010 a:5 i:s16
+l_sfgesi        101111 01011 a:5 i:s16
+l_sfltsi        101111 01100 a:5 i:s16
+l_sflesi        101111 01101 a:5 i:s16
-- 
2.17.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKj-0006hv-7W
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKP-0000CE-NU
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:50 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKP-00005r-Gv
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:49 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:34 -0400
Message-Id: <20181025172057.20414-26-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 25/48] target/arm: prepare for 2-pass translation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate-a64.c |  8 ++++++--
 target/arm/translate.c     | 25 +++++++++++++++++++++----
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 8b1e20dd59..dab5f6efd3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13783,11 +13783,13 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
 }
 
 /* C3.1 A64 instruction index by encoding */
-static void disas_a64_insn(CPUARMState *env, DisasContext *s)
+static void disas_a64_insn(CPUARMState *env, DisasContext *s,
+                           struct qemu_plugin_insn *plugin_insn)
 {
     uint32_t insn;
 
     insn = arm_ldl_code(env, s->pc, s->sctlr_b);
+    qemu_plugin_insn_append(plugin_insn, &insn, sizeof(insn));
     s->insn = insn;
     s->pc += 4;
 
@@ -13959,7 +13961,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
                       default_exception_el(dc));
         dc->base.is_jmp = DISAS_NORETURN;
     } else {
-        disas_a64_insn(env, dc);
+        disas_a64_insn(env, dc, plugin_insn);
     }
 
     dc->base.pc_next = dc->pc;
@@ -14058,4 +14060,6 @@ const TranslatorOps aarch64_translator_ops = {
     .translate_insn     = aarch64_tr_translate_insn,
     .tb_stop            = aarch64_tr_tb_stop,
     .disas_log          = aarch64_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2fd32a2684..015153a260 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10198,7 +10198,8 @@ gen_thumb2_data_op(DisasContext *s, int op, int conds, uint32_t shifter_out,
 }
 
 /* Translate a 32-bit thumb instruction. */
-static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
+static void disas_thumb2_insn(DisasContext *s, uint32_t insn,
+                              struct qemu_plugin_insn *plugin_insn)
 {
     uint32_t imm, shift, offset;
     uint32_t rd, rn, rm, rs;
@@ -11736,7 +11737,8 @@ illegal_op:
                        default_exception_el(s));
 }
 
-static void disas_thumb_insn(DisasContext *s, uint32_t insn)
+static void disas_thumb_insn(DisasContext *s, uint32_t insn,
+                             struct qemu_plugin_insn *plugin_insn)
 {
     uint32_t val, op, rm, rn, rd, shift, cond;
     int32_t offset;
@@ -12800,6 +12802,7 @@ static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
 
     insn = arm_ldl_code(env, dc->pc, dc->sctlr_b);
     dc->insn = insn;
+    qemu_plugin_insn_append(plugin_insn, &insn, sizeof(insn));
     dc->pc += 4;
     disas_arm_insn(dc, insn);
 
@@ -12870,11 +12873,21 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
     insn = arm_lduw_code(env, dc->pc, dc->sctlr_b);
     is_16bit = thumb_insn_is_16bit(dc, insn);
     dc->pc += 2;
+    if (plugin_insn) {
+        uint16_t insn16 = insn;
+
+        qemu_plugin_insn_append(plugin_insn, &insn16, sizeof(insn16));
+    }
     if (!is_16bit) {
         uint32_t insn2 = arm_lduw_code(env, dc->pc, dc->sctlr_b);
 
         insn = insn << 16 | insn2;
         dc->pc += 2;
+        if (plugin_insn) {
+            uint16_t insn16 = insn2;
+
+            qemu_plugin_insn_append(plugin_insn, &insn16, sizeof(insn16));
+        }
     }
     dc->insn = insn;
 
@@ -12887,9 +12900,9 @@ static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
     }
 
     if (is_16bit) {
-        disas_thumb_insn(dc, insn);
+        disas_thumb_insn(dc, insn, plugin_insn);
     } else {
-        disas_thumb2_insn(dc, insn);
+        disas_thumb2_insn(dc, insn, plugin_insn);
     }
 
     /* Advance the Thumb condexec condition.  */
@@ -13064,6 +13077,8 @@ static const TranslatorOps arm_translator_ops = {
     .translate_insn     = arm_tr_translate_insn,
     .tb_stop            = arm_tr_tb_stop,
     .disas_log          = arm_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 static const TranslatorOps thumb_translator_ops = {
@@ -13074,6 +13089,8 @@ static const TranslatorOps thumb_translator_ops = {
     .translate_insn     = thumb_tr_translate_insn,
     .tb_stop            = arm_tr_tb_stop,
     .disas_log          = arm_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 /* generate intermediate code for basic block 'tb'.  */
-- 
2.17.1

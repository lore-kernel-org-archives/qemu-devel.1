Received: from eggs.gnu.org ([2001:4830:134:3::10]:40232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKf-0006h0-DT
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKX-0000J8-Vp
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKW-00009D-0x
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:43 -0400
Message-Id: <20181025172057.20414-35-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 34/48] target/s390x: prepare for 2-pass
 translation
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
 target/s390x/translate.c | 49 ++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 6ac1a8d821..0c41e0d83a 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5934,13 +5934,39 @@ static void extract_field(DisasFields *o, const DisasField *f, uint64_t insn)
     o->c[f->indexC] = r;
 }
 
+static inline void
+s390_plugin_insn(uint64_t insn, struct qemu_plugin_insn *plugin_insn, int len)
+{
+    uint16_t insn2;
+    uint32_t insn4;
+
+    if (plugin_insn == NULL) {
+        return;
+    }
+
+    switch (len) {
+    case 2:
+        insn2 = insn;
+        qemu_plugin_insn_append(plugin_insn, &insn2, sizeof(insn2));
+        break;
+    case 4:
+        insn4 = insn;
+        qemu_plugin_insn_append(plugin_insn, &insn4, sizeof(insn4));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Lookup the insn at the current PC, extracting the operands into O and
    returning the info struct for the insn.  Returns NULL for invalid insn.  */
 
 static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
-                                     DisasFields *f)
+                                     DisasFields *f,
+                                     struct qemu_plugin_insn *plugin_insn)
 {
     uint64_t insn, pc = s->base.pc_next;
+    uint64_t insn4;
     int op, op2, ilen;
     const DisasInsn *info;
 
@@ -5960,13 +5986,19 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
         ilen = get_ilen(op);
         switch (ilen) {
         case 2:
-            insn = insn << 48;
+            s390_plugin_insn(insn, plugin_insn, 2);
+            insn <<= 48;
             break;
         case 4:
-            insn = ld_code4(env, pc) << 32;
+            insn = ld_code4(env, pc);
+            s390_plugin_insn(insn, plugin_insn, 4);
+            insn <<= 32;
             break;
         case 6:
-            insn = (insn << 48) | (ld_code4(env, pc + 2) << 16);
+            s390_plugin_insn(insn, plugin_insn, 2);
+            insn4 = ld_code4(env, pc + 2);
+            s390_plugin_insn(insn4, plugin_insn, 4);
+            insn = (insn << 48) | (insn4 << 16);
             break;
         default:
             g_assert_not_reached();
@@ -6049,7 +6081,8 @@ static bool is_fp_pair(int reg)
     return !(reg & 0x2);
 }
 
-static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
+static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s,
+                                   struct qemu_plugin_insn *plugin_insn)
 {
     const DisasInsn *insn;
     DisasJumpType ret = DISAS_NEXT;
@@ -6057,7 +6090,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     DisasOps o;
 
     /* Search for the insn in the table.  */
-    insn = extract_insn(env, s, &f);
+    insn = extract_insn(env, s, &f, plugin_insn);
 
     /* Not found means unimplemented/illegal opcode.  */
     if (insn == NULL) {
@@ -6234,7 +6267,7 @@ static void s390x_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs,
     CPUS390XState *env = cs->env_ptr;
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    dc->base.is_jmp = translate_one(env, dc);
+    dc->base.is_jmp = translate_one(env, dc, plugin_insn);
     if (dc->base.is_jmp == DISAS_NEXT) {
         uint64_t page_start;
 
@@ -6300,6 +6333,8 @@ static const TranslatorOps s390x_tr_ops = {
     .translate_insn     = s390x_tr_translate_insn,
     .tb_stop            = s390x_tr_tb_stop,
     .disas_log          = s390x_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
-- 
2.17.1

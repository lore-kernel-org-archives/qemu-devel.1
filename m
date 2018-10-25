Received: from eggs.gnu.org ([2001:4830:134:3::10]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKj-0006hm-30
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKT-0000Fe-TS
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:56 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKT-00007T-2J
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:37 -0400
Message-Id: <20181025172057.20414-29-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 28/48] target/i386: prepare for 2-pass translation
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
 target/i386/translate.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 86e59d7bf7..1d7b20bce3 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -142,6 +142,7 @@ typedef struct DisasContext {
     TCGv_i32 tmp3_i32;
     TCGv_i64 tmp1_i64;
 
+    struct qemu_plugin_insn *plugin_insn;
     sigjmp_buf jmpbuf;
 } DisasContext;
 
@@ -1900,28 +1901,43 @@ static uint64_t advance_pc(CPUX86State *env, DisasContext *s, int num_bytes)
 
 static inline uint8_t x86_ldub_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_ldub_code(env, advance_pc(env, s, 1));
+    uint8_t ret = cpu_ldub_code(env, advance_pc(env, s, 1));
+
+    qemu_plugin_insn_append(s->plugin_insn, &ret, sizeof(ret));
+    return ret;
 }
 
 static inline int16_t x86_ldsw_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_ldsw_code(env, advance_pc(env, s, 2));
+    int16_t ret = cpu_ldsw_code(env, advance_pc(env, s, 2));
+
+    qemu_plugin_insn_append(s->plugin_insn, &ret, sizeof(ret));
+    return ret;
 }
 
 static inline uint16_t x86_lduw_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_lduw_code(env, advance_pc(env, s, 2));
+    uint16_t ret = cpu_lduw_code(env, advance_pc(env, s, 2));
+
+    qemu_plugin_insn_append(s->plugin_insn, &ret, sizeof(ret));
+    return ret;
 }
 
 static inline uint32_t x86_ldl_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_ldl_code(env, advance_pc(env, s, 4));
+    uint32_t ret = cpu_ldl_code(env, advance_pc(env, s, 4));
+
+    qemu_plugin_insn_append(s->plugin_insn, &ret, sizeof(ret));
+    return ret;
 }
 
 #ifdef TARGET_X86_64
 static inline uint64_t x86_ldq_code(CPUX86State *env, DisasContext *s)
 {
-    return cpu_ldq_code(env, advance_pc(env, s, 8));
+    uint64_t ret = cpu_ldq_code(env, advance_pc(env, s, 8));
+
+    qemu_plugin_insn_append(s->plugin_insn, &ret, sizeof(ret));
+    return ret;
 }
 #endif
 
@@ -4473,7 +4489,8 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
 
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
-static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
+static target_ulong disas_insn(DisasContext *s, CPUState *cpu,
+                               struct qemu_plugin_insn *plugin_insn)
 {
     CPUX86State *env = cpu->env_ptr;
     int b, prefixes;
@@ -4484,6 +4501,8 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
     int rex_w, rex_r;
     target_ulong pc_start = s->base.pc_next;
 
+    s->plugin_insn = plugin_insn;
+
     s->pc_start = s->pc = pc_start;
     s->override = -1;
 #ifdef TARGET_X86_64
@@ -8529,7 +8548,7 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu,
                                    struct qemu_plugin_insn *plugin_insn)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    target_ulong pc_next = disas_insn(dc, cpu);
+    target_ulong pc_next = disas_insn(dc, cpu, plugin_insn);
 
     if (dc->tf || (dc->base.tb->flags & HF_INHIBIT_IRQ_MASK)) {
         /* if single step mode, we generate only one instruction and
@@ -8584,6 +8603,8 @@ static const TranslatorOps i386_tr_ops = {
     .translate_insn     = i386_tr_translate_insn,
     .tb_stop            = i386_tr_tb_stop,
     .disas_log          = i386_tr_disas_log,
+    .ctx_base_offset    = offsetof(DisasContext, base),
+    .ctx_size           = sizeof(DisasContext),
 };
 
 /* generate intermediate code for basic block 'tb'.  */
-- 
2.17.1

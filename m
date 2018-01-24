Received: from eggs.gnu.org ([2001:4830:134:3::10]:50909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUR9-0004Mc-D3
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeUR8-0001bG-Aq
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:35 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeUR8-0001b3-4G
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 18:26:34 -0500
Received: by mail-pg0-x243.google.com with SMTP id y27so3814540pgc.5
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 15:26:33 -0800 (PST)
Received: from cloudburst.twiddle.net (174-21-6-47.tukw.qwest.net.
	[174.21.6.47]) by smtp.gmail.com with ESMTPSA id
	z19sm9760028pfh.185.2018.01.24.15.26.31 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 24 Jan 2018 15:26:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Jan 2018 15:25:43 -0800
Message-Id: <20180124232625.30105-4-richard.henderson@linaro.org>
In-Reply-To: <20180124232625.30105-1-richard.henderson@linaro.org>
References: <20180124232625.30105-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 03/45] target/hppa: Disable gateway page
 emulation for system mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 31d9a2a31b..8e357cc60c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1543,6 +1543,7 @@ static DisasJumpType do_ibranch(DisasContext *ctx, TCGv dest,
     return DISAS_NEXT;
 }
 
+#ifdef CONFIG_USER_ONLY
 /* On Linux, page zero is normally marked execute only + gateway.
    Therefore normal read or write is supposed to fail, but specific
    offsets have kernel code mapped to raise permissions to implement
@@ -1600,6 +1601,7 @@ static DisasJumpType do_page_zero(DisasContext *ctx)
         return DISAS_NORETURN;
     }
 }
+#endif
 
 static DisasJumpType trans_nop(DisasContext *ctx, uint32_t insn,
                                const DisasInsn *di)
@@ -3787,10 +3789,13 @@ static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     int i, n;
 
     /* Execute one insn.  */
+#ifdef CONFIG_USER_ONLY
     if (ctx->iaoq_f < TARGET_PAGE_SIZE) {
         ret = do_page_zero(ctx);
         assert(ret != DISAS_NEXT);
-    } else {
+    } else
+#endif
+    {
         /* Always fetch the insn, even if nullified, so that we check
            the page permissions for execute.  */
         uint32_t insn = cpu_ldl_code(env, ctx->iaoq_f);
@@ -3885,25 +3890,27 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 static void hppa_tr_disas_log(const DisasContextBase *dcbase, CPUState *cs)
 {
     TranslationBlock *tb = dcbase->tb;
+    target_ulong pc = tb->pc;
 
-    switch (tb->pc) {
+#ifdef CONFIG_USER_ONLY
+    switch (pc) {
     case 0x00:
         qemu_log("IN:\n0x00000000:  (null)\n");
-        break;
+        return;
     case 0xb0:
         qemu_log("IN:\n0x000000b0:  light-weight-syscall\n");
-        break;
+        return;
     case 0xe0:
         qemu_log("IN:\n0x000000e0:  set-thread-pointer-syscall\n");
-        break;
+        return;
     case 0x100:
         qemu_log("IN:\n0x00000100:  syscall\n");
-        break;
-    default:
-        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
-        log_target_disas(cs, tb->pc, tb->size);
-        break;
+        return;
     }
+#endif
+
+    qemu_log("IN: %s\n", lookup_symbol(pc));
+    log_target_disas(cs, pc, tb->size);
 }
 
 static const TranslatorOps hppa_tr_ops = {
-- 
2.14.3

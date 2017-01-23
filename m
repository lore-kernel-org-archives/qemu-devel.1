Received: from eggs.gnu.org ([2001:4830:134:3::10]:46718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUDA-0007uh-Dj
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUD9-0004x9-Bn
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:24 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUD9-0004x3-6k
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:23 -0500
Received: by mail-qt0-x241.google.com with SMTP id l7so14117119qtd.3
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:23 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:44 -0800
Message-Id: <20170123021748.13170-23-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 22/26] target-hppa: Implement linux-user gateway
 page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

For linux, page 0 is mapped as an execute-only gateway.  A gateway
page is a special bit in the page table that allows a B,GATE insn
within that page to raise processor permissions.  This is how system
calls are implemented for HPPA.

Rather than actually map anything here, or handle permissions at all,
implement the semantics of the actual linux syscall entry points.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/hppa/translate.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 1d0976f..14fe4bb 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1123,6 +1123,64 @@ static ExitStatus do_ibranch(DisasContext *ctx, TCGv dest,
     return NO_EXIT;
 }
 
+/* On Linux, page zero is normally marked execute only + gateway.
+   Therefore normal read or write is supposed to fail, but specific
+   offsets have kernel code mapped to raise permissions to implement
+   system calls.  Handling this via an explicit check here, rather
+   in than the "be disp(sr2,r0)" instruction that probably sent us
+   here, is the easiest way to handle the branch delay slot on the
+   aforementioned BE.  */
+static ExitStatus do_page_zero(DisasContext *ctx)
+{
+    /* If by some means we get here with PSW[N]=1, that implies that
+       the B,GATE instruction would be skipped, and we'd fault on the
+       next insn within the privilaged page.  */
+    switch (ctx->null_cond.c) {
+    case TCG_COND_NEVER:
+        break;
+    case TCG_COND_ALWAYS:
+        tcg_gen_movi_tl(cpu_psw_n, 0);
+        goto do_sigill;
+    default:
+        /* Since this is always the first (and only) insn within the
+           TB, we should know the state of PSW[N] from TB->FLAGS.  */
+        g_assert_not_reached();
+    }
+
+    /* Check that we didn't arrive here via some means that allowed
+       non-sequential instruction execution.  Normally the PSW[B] bit
+       detects this by disallowing the B,GATE instruction to execute
+       under such conditions.  */
+    if (ctx->iaoq_b != ctx->iaoq_f + 4) {
+        goto do_sigill;
+    }
+
+    switch (ctx->iaoq_f) {
+    case 0x00: /* Null pointer call */
+        gen_excp_1(EXCP_SIGSEGV);
+        return EXIT_NORETURN;
+
+    case 0xb0: /* LWS */
+        gen_excp_1(EXCP_SYSCALL_LWS);
+        return EXIT_NORETURN;
+
+    case 0xe0: /* SET_THREAD_POINTER */
+        tcg_gen_mov_tl(cpu_cr27, cpu_gr[26]);
+        tcg_gen_mov_tl(cpu_iaoq_f, cpu_gr[31]);
+        tcg_gen_addi_tl(cpu_iaoq_b, cpu_iaoq_f, 4);
+        return EXIT_IAQ_N_UPDATED;
+
+    case 0x100: /* SYSCALL */
+        gen_excp_1(EXCP_SYSCALL);
+        return EXIT_NORETURN;
+
+    default:
+    do_sigill:
+        gen_excp_1(EXCP_SIGILL);
+        return EXIT_NORETURN;
+    }
+}
+
 static ExitStatus trans_nop(DisasContext *ctx, uint32_t insn,
                             const DisasInsn *di)
 {
@@ -1884,7 +1942,10 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
             gen_io_start();
         }
 
-        {
+        if (ctx.iaoq_f < TARGET_PAGE_SIZE) {
+            ret = do_page_zero(&ctx);
+            assert(ret != NO_EXIT);
+        } else {
             /* Always fetch the insn, even if nullified, so that we check
                the page permissions for execute.  */
             uint32_t insn = cpu_ldl_code(env, ctx.iaoq_f);
@@ -1986,9 +2047,25 @@ void gen_intermediate_code(CPUHPPAState *env, struct TranslationBlock *tb)
     if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
         && qemu_log_in_addr_range(tb->pc)) {
         qemu_log_lock();
-        qemu_log("IN: %s\n", lookup_symbol(tb->pc));
-        log_target_disas(cs, tb->pc, tb->size, 1);
-        qemu_log("\n");
+        switch (tb->pc) {
+        case 0x00:
+            qemu_log("IN:\n0x00000000:  (null)\n\n");
+            break;
+        case 0xb0:
+            qemu_log("IN:\n0x000000b0:  light-weight-syscall\n\n");
+            break;
+        case 0xe0:
+            qemu_log("IN:\n0x000000e0:  set-thread-pointer-syscall\n\n");
+            break;
+        case 0x100:
+            qemu_log("IN:\n0x00000100:  syscall\n\n");
+            break;
+        default:
+            qemu_log("IN: %s\n", lookup_symbol(tb->pc));
+            log_target_disas(cs, tb->pc, tb->size, 1);
+            qemu_log("\n");
+            break;
+        }
         qemu_log_unlock();
     }
 #endif
-- 
2.9.3

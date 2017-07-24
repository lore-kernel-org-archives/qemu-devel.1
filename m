Received: from eggs.gnu.org ([2001:4830:134:3::10]:47817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxZ-00030C-Nl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZjxY-0000rQ-Rp
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:09 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZjxY-0000rA-NY
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 16:28:08 -0400
Received: by mail-qk0-x242.google.com with SMTP id k2so3509537qkf.2
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:28:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 24 Jul 2017 13:27:01 -0700
Message-Id: <20170724202728.25960-6-rth@twiddle.net>
In-Reply-To: <20170724202728.25960-1-rth@twiddle.net>
References: <20170724202728.25960-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v15 05/32] target/arm: Delay check for magic
 kernel page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, vilanova@ac.upc.edu

There's nothing magic about the exception that we generate in order
to execute the magic kernel page.  We can and should allow gdb to
set a breakpoint at this location.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2bde418ddf..a2f368bacd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11938,17 +11938,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
                            0);
         num_insns++;
 
-#ifdef CONFIG_USER_ONLY
-        /* Intercept jump to the magic kernel page.  */
-        if (dc->pc >= 0xffff0000) {
-            /* We always get here via a jump, so know we are not in a
-               conditional execution block.  */
-            gen_exception_internal(EXCP_KERNEL_TRAP);
-            dc->is_jmp = DISAS_NORETURN;
-            break;
-        }
-#endif
-
         if (unlikely(!QTAILQ_EMPTY(&cs->breakpoints))) {
             CPUBreakpoint *bp;
             QTAILQ_FOREACH(bp, &cs->breakpoints, entry) {
@@ -11980,6 +11969,17 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
             gen_io_start();
         }
 
+#ifdef CONFIG_USER_ONLY
+        /* Intercept jump to the magic kernel page.  */
+        if (dc->pc >= 0xffff0000) {
+            /* We always get here via a jump, so know we are not in a
+               conditional execution block.  */
+            gen_exception_internal(EXCP_KERNEL_TRAP);
+            dc->is_jmp = DISAS_NORETURN;
+            break;
+        }
+#endif
+
         if (dc->ss_active && !dc->pstate_ss) {
             /* Singlestep state is Active-pending.
              * If we're in this state at the start of a TB then either
-- 
2.13.3

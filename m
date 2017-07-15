Received: from eggs.gnu.org ([2001:4830:134:3::10]:38070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbM-0003bW-Es
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dWJbL-0003E5-K1
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:04 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:34322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dWJbL-0003Dt-ED
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 05:43:03 -0400
Received: by mail-pg0-x242.google.com with SMTP id j186so13345946pge.1
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 02:43:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 14 Jul 2017 23:42:15 -1000
Message-Id: <20170715094243.28371-7-rth@twiddle.net>
In-Reply-To: <20170715094243.28371-1-rth@twiddle.net>
References: <20170715094243.28371-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v14 06/34] target/arm: Delay check for magic
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
Cc: vilanova@ac.upc.edu, cota@braap.org, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

There's nothing magic about the exception that we generate in order
to execute the magic kernel page.  We can and should allow gdb to
set a breakpoint at this location.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fea76fb..2ae68ce 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11930,17 +11930,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
@@ -11972,6 +11961,17 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
2.9.4

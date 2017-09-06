Received: from eggs.gnu.org ([2001:4830:134:3::10]:41649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqV-0008Qv-Sa
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpcqM-0001eo-GW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:31 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:33604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpcqM-0001cE-B5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 12:06:22 -0400
Received: by mail-pg0-x22a.google.com with SMTP id t3so16077697pgt.0
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 09:06:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  6 Sep 2017 09:05:45 -0700
Message-Id: <20170906160612.22769-6-richard.henderson@linaro.org>
In-Reply-To: <20170906160612.22769-1-richard.henderson@linaro.org>
References: <20170906160612.22769-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 05/32] target/arm: Delay check for magic kernel
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
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

There's nothing magic about the exception that we generate in order
to execute the magic kernel page.  We can and should allow gdb to
set a breakpoint at this location.

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0c39c2b996..746193eebc 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -11968,17 +11968,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
@@ -12010,6 +11999,17 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
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
2.13.5

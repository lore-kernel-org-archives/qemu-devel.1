Received: from eggs.gnu.org ([2001:4830:134:3::10]:47883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzMH-0002y3-W9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzMH-0008Tv-AC
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:59:14 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:32904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzMH-0008Tk-3U
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:59:13 -0400
Received: by mail-pl0-x243.google.com with SMTP id 6-v6so8012958plb.0
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:59:12 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:58:05 +0900
Message-Id: <20180702135806.7087-25-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL 24/25] target/openrisc: Fix delay slot exception
 flag to match spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

The delay slot exception flag is only set on the SR register during
exception.  Previously it was being set on both the ESR and SR this
caused QEMU to differ from the spec.  The was apparent as the linux
kernel had a bug where it could boot on QEMU but not on real hardware.

The fixed logic now matches hardware.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/interrupt.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 138ad17f00..bbae956361 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -35,13 +35,6 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     int exception = cs->exception_index;
 
     env->epcr = env->pc;
-    if (env->dflag) {
-        env->dflag = 0;
-        env->sr |= SR_DSX;
-        env->epcr -= 4;
-    } else {
-        env->sr &= ~SR_DSX;
-    }
     if (exception == EXCP_SYSCALL) {
         env->epcr += 4;
     }
@@ -51,7 +44,10 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         env->eear = env->pc;
     }
 
+    /* During exceptions esr is populared with the pre-exception sr.  */
     env->esr = cpu_get_sr(env);
+    /* In parallel sr is updated to disable mmu, interrupts, timers and
+       set the delay slot exception flag.  */
     env->sr &= ~SR_DME;
     env->sr &= ~SR_IME;
     env->sr |= SR_SM;
@@ -61,6 +57,15 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
     env->pmr &= ~PMR_SME;
     env->lock_addr = -1;
 
+    /* Set/clear dsx to indicate if we are in a delay slot exception.  */
+    if (env->dflag) {
+        env->dflag = 0;
+        env->sr |= SR_DSX;
+        env->epcr -= 4;
+    } else {
+        env->sr &= ~SR_DSX;
+    }
+
     if (exception > 0 && exception < EXCP_NR) {
         static const char * const int_name[EXCP_NR] = {
             [EXCP_RESET]    = "RESET",
-- 
2.17.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:59466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRlTi-0001kc-5K
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dRlTh-0001H2-Bm
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:22 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:41558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dRlTh-0001GI-4X
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 16:28:21 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sun,  2 Jul 2017 22:28:12 +0200
Message-Id: <20170702202814.27793-4-aurelien@aurel32.net>
In-Reply-To: <20170702202814.27793-1-aurelien@aurel32.net>
References: <20170702202814.27793-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH v2 3/5] target/sh4: fix FPSCR cause vs flag
 inversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Bruno Haible <bruno@clisp.org>, Aurelien Jarno <aurelien@aurel32.net>

The floating-point status/control register contains cause and flag
bits. The cause bits are set to 0 before executing the instruction,
while the flag bits hold the status of the exception generated after
the field was last cleared.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/op_helper.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index f228daf125..f2e39c5ca6 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -219,29 +219,29 @@ static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
 
     xcpt = get_float_exception_flags(&env->fp_status);
 
-    /* Clear the flag entries */
-    env->fpscr &= ~FPSCR_FLAG_MASK;
+    /* Clear the cause entries */
+    env->fpscr &= ~FPSCR_CAUSE_MASK;
 
     if (unlikely(xcpt)) {
         if (xcpt & float_flag_invalid) {
-            env->fpscr |= FPSCR_FLAG_V;
+            env->fpscr |= FPSCR_CAUSE_V;
         }
         if (xcpt & float_flag_divbyzero) {
-            env->fpscr |= FPSCR_FLAG_Z;
+            env->fpscr |= FPSCR_CAUSE_Z;
         }
         if (xcpt & float_flag_overflow) {
-            env->fpscr |= FPSCR_FLAG_O;
+            env->fpscr |= FPSCR_CAUSE_O;
         }
         if (xcpt & float_flag_underflow) {
-            env->fpscr |= FPSCR_FLAG_U;
+            env->fpscr |= FPSCR_CAUSE_U;
         }
         if (xcpt & float_flag_inexact) {
-            env->fpscr |= FPSCR_FLAG_I;
+            env->fpscr |= FPSCR_CAUSE_I;
         }
 
-        /* Accumulate in cause entries */
-        env->fpscr |= (env->fpscr & FPSCR_FLAG_MASK)
-                      << (FPSCR_CAUSE_SHIFT - FPSCR_FLAG_SHIFT);
+        /* Accumulate in flag entries */
+        env->fpscr |= (env->fpscr & FPSCR_CAUSE_MASK)
+                      >> (FPSCR_CAUSE_SHIFT - FPSCR_FLAG_SHIFT);
 
         /* Generate an exception if enabled */
         cause = (env->fpscr & FPSCR_CAUSE_MASK) >> FPSCR_CAUSE_SHIFT;
-- 
2.11.0

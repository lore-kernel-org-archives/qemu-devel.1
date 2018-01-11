Received: from eggs.gnu.org ([2001:4830:134:3::10]:52187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd41-0007SB-Ua
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd41-00007a-6u
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:37 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eZd41-0008Ve-03
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 08:38:37 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eZd3q-0005cA-0T
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:38:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 13:37:59 +0000
Message-Id: <1515677902-23436-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
References: <1515677902-23436-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/26] linux-user: Fix endianess of aarch64
 signal trampoline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Weiser <michael.weiser@gmx.de>

Since for aarch64 the signal trampoline is synthesized directly into the
signal frame we need to make sure the instructions end up little-endian.
Otherwise the wrong endianness will cause a SIGILL upon return from the
signal handler on big-endian targets.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20171220212308.12614-4-michael.weiser@gmx.de
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/signal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 74fa03f..f85f0dd 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -1599,9 +1599,13 @@ static void target_setup_frame(int usig, struct target_sigaction *ka,
     if (ka->sa_flags & TARGET_SA_RESTORER) {
         return_addr = ka->sa_restorer;
     } else {
-        /* mov x8,#__NR_rt_sigreturn; svc #0 */
-        __put_user(0xd2801168, &frame->tramp[0]);
-        __put_user(0xd4000001, &frame->tramp[1]);
+        /*
+         * mov x8,#__NR_rt_sigreturn; svc #0
+         * Since these are instructions they need to be put as little-endian
+         * regardless of target default or current CPU endianness.
+         */
+        __put_user_e(0xd2801168, &frame->tramp[0], le);
+        __put_user_e(0xd4000001, &frame->tramp[1], le);
         return_addr = frame_addr + offsetof(struct target_rt_sigframe, tramp);
     }
     env->xregs[0] = usig;
-- 
2.7.4

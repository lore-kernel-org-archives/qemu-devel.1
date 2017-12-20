Received: from eggs.gnu.org ([2001:4830:134:3::10]:56630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRlxW-0006bk-R9
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRlxV-0007bN-Ti
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:31:26 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:49840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eRlxV-0007Y4-NF
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:31:25 -0500
From: Michael Weiser <michael.weiser@gmx.de>
Date: Wed, 20 Dec 2017 22:23:04 +0100
Message-Id: <20171220212308.12614-4-michael.weiser@gmx.de>
In-Reply-To: <20171220212308.12614-1-michael.weiser@gmx.de>
References: <20171220212308.12614-1-michael.weiser@gmx.de>
Subject: [Qemu-devel] [PATCH v3 3/7] linux-user: Fix endianess of aarch64
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
Cc: Michael Weiser <michael.weiser@gmx.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Since for aarch64 the signal trampoline is synthesized directly into the
signal frame we need to make sure the instructions end up little-endian.
Otherwise the wrong endianness will cause a SIGILL upon return from the
signal handler on big-endian targets.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index dae14d4a89..81b7fbeb1e 100644
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
2.15.1

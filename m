Received: from eggs.gnu.org ([2001:4830:134:3::10]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciTrn-0001WK-5W
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ciTrj-0004fo-1r
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:34:03 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:64160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ciTri-0004Y8-NU
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 17:33:58 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 27 Feb 2017 23:33:36 +0100
Message-Id: <20170227223337.17434-6-laurent@vivier.eu>
In-Reply-To: <20170227223337.17434-1-laurent@vivier.eu>
References: <20170227223337.17434-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 5/6] linux-user: fix do_rt_sigreturn on m68k
 linux userspace emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Michael Karcher <karcher@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>

From: Michael Karcher <karcher@physik.fu-berlin.de>

do_rt_sigreturn uses an uninitialised local variable instead of fetching
the old signal mask directly from the signal frame when restoring the mask,
so the signal mask is undefined after do_rt_sigreturn. As the signal
frame data is in target-endian order, target_to_host_sigset instead of
target_to_host_sigset_internal is required.

do_sigreturn is correct in using target_to_host_sigset_internal, because
get_user already did the endianness conversion.

Signed-off-by: Michael Karcher <karcher@physik.fu-berlin.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20170225110517.2832-3-laurent@vivier.eu>
---
 linux-user/signal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 99adfc2..a67db04 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -5851,14 +5851,13 @@ long do_rt_sigreturn(CPUM68KState *env)
 {
     struct target_rt_sigframe *frame;
     abi_ulong frame_addr = env->aregs[7] - 4;
-    target_sigset_t target_set;
     sigset_t set;
 
     trace_user_do_rt_sigreturn(env, frame_addr);
     if (!lock_user_struct(VERIFY_READ, frame, frame_addr, 1))
         goto badframe;
 
-    target_to_host_sigset_internal(&set, &target_set);
+    target_to_host_sigset(&set, &frame->uc.tuc_sigmask);
     set_sigmask(&set);
 
     /* restore registers */
-- 
2.9.3

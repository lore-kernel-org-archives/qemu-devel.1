Received: from eggs.gnu.org ([2001:4830:134:3::10]:45181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chaAO-0007ao-EO
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1chaAM-0007dN-Jy
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:05:32 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:52387)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1chaAM-0007az-9P
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 06:05:30 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 25 Feb 2017 12:05:17 +0100
Message-Id: <20170225110517.2832-3-laurent@vivier.eu>
In-Reply-To: <20170225110517.2832-1-laurent@vivier.eu>
References: <20170225110517.2832-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 2/2] linux-user: fix do_rt_sigreturn on m68k
 linux userspace emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, Michael Karcher <karcher@physik.fu-berlin.de>, Laurent Vivier <laurent@vivier.eu>

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
---
 linux-user/signal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index df452ba..8382561 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -5670,14 +5670,13 @@ long do_rt_sigreturn(CPUM68KState *env)
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

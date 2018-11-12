Received: from eggs.gnu.org ([2001:4830:134:3::10]:39496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMJ9c-0003MY-BU
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMJ9b-00088f-B2
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:49:52 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:34581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMJ9a-000882-Vp
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:49:51 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Nov 2018 21:49:26 +0100
Message-Id: <20181112204929.12625-2-laurent@vivier.eu>
In-Reply-To: <20181112204929.12625-1-laurent@vivier.eu>
References: <20181112204929.12625-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 1/4] linux-user: Remove dead error-checking code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Remove some dead code spotted by Coverity (CID 1009855,
1390854, 1390847). The underlying cause in all these cases
is the same: QEMU's put_user operations can't result in
errors, but the kernel's equivalent does. So when code
was copied from the kernel signal-frame-setup/teardown
code, checks on error flags that were needed in the kernel
became dead code for us.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20181019161715.12122-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/m68k/signal.c  | 3 ---
 linux-user/sh4/signal.c   | 4 ----
 linux-user/sparc/signal.c | 2 --
 3 files changed, 9 deletions(-)

diff --git a/linux-user/m68k/signal.c b/linux-user/m68k/signal.c
index 38bd77ec16..49ff87c77b 100644
--- a/linux-user/m68k/signal.c
+++ b/linux-user/m68k/signal.c
@@ -334,9 +334,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
                (uint32_t *)(frame->retcode + 0));
     __put_user(0x4e40, (uint16_t *)(frame->retcode + 4));
 
-    if (err)
-        goto give_sigsegv;
-
     /* Set up to return from userspace */
 
     env->aregs[7] = frame_addr;
diff --git a/linux-user/sh4/signal.c b/linux-user/sh4/signal.c
index c6752baa7e..cc89a48ff8 100644
--- a/linux-user/sh4/signal.c
+++ b/linux-user/sh4/signal.c
@@ -279,7 +279,6 @@ long do_sigreturn(CPUSH4State *regs)
     sigset_t blocked;
     target_sigset_t target_set;
     int i;
-    int err = 0;
 
     frame_addr = regs->gregs[15];
     trace_user_do_sigreturn(regs, frame_addr);
@@ -292,9 +291,6 @@ long do_sigreturn(CPUSH4State *regs)
         __get_user(target_set.sig[i], &frame->extramask[i - 1]);
     }
 
-    if (err)
-        goto badframe;
-
     target_to_host_sigset_internal(&blocked, &target_set);
     set_sigmask(&blocked);
 
diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
index e44e99993c..295e415b1e 100644
--- a/linux-user/sparc/signal.c
+++ b/linux-user/sparc/signal.c
@@ -256,8 +256,6 @@ void setup_frame(int sig, struct target_sigaction *ka,
         /* t 0x10 */
         val32 = 0x91d02010;
         __put_user(val32, &sf->insns[1]);
-        if (err)
-            goto sigsegv;
     }
     unlock_user(sf, sf_addr, sizeof(struct target_signal_frame));
     return;
-- 
2.17.2

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxT-0002ef-B1
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ceMxS-0002NN-0e
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:55 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:64491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ceMxR-0002Ml-Ls
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:22:53 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 16 Feb 2017 15:22:23 +0100
Message-Id: <20170216142227.27448-11-laurent@vivier.eu>
In-Reply-To: <20170216142227.27448-1-laurent@vivier.eu>
References: <20170216142227.27448-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/14] linux-user: fix settime old value location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>, Laurent Vivier <laurent@vivier.eu>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

old_value is the 4th argument of timer_settime(), not the 2nd.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20170119151533.29328-1-bobby.prani@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d982a27..f569f82 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12043,10 +12043,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             timer_t htimer = g_posix_timers[timerid];
             struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
 
-            target_to_host_itimerspec(&hspec_new, arg3);
+            if (target_to_host_itimerspec(&hspec_new, arg3)) {
+                goto efault;
+            }
             ret = get_errno(
                           timer_settime(htimer, arg2, &hspec_new, &hspec_old));
-            host_to_target_itimerspec(arg2, &hspec_old);
+            if (arg4 && host_to_target_itimerspec(arg4, &hspec_old)) {
+                goto efault;
+            }
         }
         break;
     }
-- 
2.9.3

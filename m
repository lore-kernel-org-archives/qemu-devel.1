Received: from eggs.gnu.org ([2001:4830:134:3::10]:50219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUDcT-0003UO-Dj
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cUDcQ-0004Z5-Aj
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:23:17 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:35175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cUDcQ-0004Yy-6Y
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:23:14 -0500
Received: by mail-yw0-x244.google.com with SMTP id 17so4408161ywk.2
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 06:23:14 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 19 Jan 2017 09:23:10 -0500
Message-Id: <20170119142311.8310-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/2] linux-user: fix settime old value
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, peter.maydell@linaro.org, laurent@vivier.eu, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

old_value is the 4th argument of timer_settime(), not the 2nd.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 linux-user/syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7b77503f94..a393764a17 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12024,10 +12024,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             timer_t htimer = g_posix_timers[timerid];
             struct itimerspec hspec_new = {{0},}, hspec_old = {{0},};
 
-            target_to_host_itimerspec(&hspec_new, arg3);
+            if (arg3 && target_to_host_itimerspec(&hspec_new, arg3)) {
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
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTvqU-0002OG-1P
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTvqR-0002uk-0L
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:24:34 -0500
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:33324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cTvqQ-0002uN-Rl
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 14:24:30 -0500
Received: by mail-yw0-x242.google.com with SMTP id u68so1983152ywg.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 11:24:30 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 18 Jan 2017 14:24:27 -0500
Message-Id: <20170118192428.2661-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/2] linux-user: fix settime old value
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

CC: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
[pranith: review comments]
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7b77503f94..724607be43 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12027,7 +12027,9 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             target_to_host_itimerspec(&hspec_new, arg3);
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

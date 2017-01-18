Received: from eggs.gnu.org ([2001:4830:134:3::10]:48829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTrl6-00043e-7u
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1cTrl3-0001yA-3i
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:02:44 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:34782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1cTrl2-0001xh-VX
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:02:41 -0500
Received: by mail-yw0-x243.google.com with SMTP id v73so1191209ywg.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 07:02:39 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 18 Jan 2017 10:02:34 -0500
Message-Id: <20170118150235.23850-1-bobby.prani@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] linux-user: fix settime old value location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

old_value is the 4th argument of timer_settime(), not the 2nd.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 7b77503f94..5bd477a71b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12027,7 +12027,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             target_to_host_itimerspec(&hspec_new, arg3);
             ret = get_errno(
                           timer_settime(htimer, arg2, &hspec_new, &hspec_old));
-            host_to_target_itimerspec(arg2, &hspec_old);
+            host_to_target_itimerspec(arg4, &hspec_old);
         }
         break;
     }
-- 
2.11.0

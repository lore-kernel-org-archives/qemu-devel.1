Received: from eggs.gnu.org ([2001:4830:134:3::10]:40758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2jjp-00073A-RG
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:38:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2jjp-0004Z2-1d
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:38:05 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:39204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f2jjo-0004YE-Pb
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:38:04 -0400
Received: by mail-lf0-x244.google.com with SMTP id p142-v6so18286054lfd.6
	for <qemu-devel@nongnu.org>; Sun, 01 Apr 2018 13:38:04 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun,  1 Apr 2018 13:37:39 -0700
Message-Id: <20180401203739.31670-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] linux-user: fix error propagation in
 clock_gettime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>

host_to_target_timespec may return error if target address could not be
locked, but it is ignored.
Propagate return value of host_to_target_timespec to the caller of
clock_gettime.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d51e2a00ee31..52e2f9c16479 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11884,7 +11884,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         struct timespec ts;
         ret = get_errno(clock_gettime(arg1, &ts));
         if (!is_error(ret)) {
-            host_to_target_timespec(arg2, &ts);
+            ret = host_to_target_timespec(arg2, &ts);
         }
         break;
     }
-- 
2.11.0

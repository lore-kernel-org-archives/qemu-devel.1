Received: from eggs.gnu.org ([2001:4830:134:3::10]:36506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332R-0004QK-2A
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332Q-0004fr-7L
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:35 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f332Q-0004fi-0h
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:34 -0400
Received: by mail-wr0-x242.google.com with SMTP id n2so11403831wrj.7
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 10:14:33 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  2 Apr 2018 10:13:52 -0700
Message-Id: <20180402171354.27706-7-jcmvbkbc@gmail.com>
In-Reply-To: <20180402171354.27706-1-jcmvbkbc@gmail.com>
References: <20180402171354.27706-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 6/8] linux-user: fix error propagation in
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

host_to_target_timespec may return error if target address could not be
locked, but it is ignored.
Propagate return value of host_to_target_timespec to the caller of
clock_gettime.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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

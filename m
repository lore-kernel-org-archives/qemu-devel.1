Received: from eggs.gnu.org ([2001:4830:134:3::10]:57539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2lDp-0004NR-1n
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 18:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2lDo-0007jy-72
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 18:13:09 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:39547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f2lDo-0007j9-0Y
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 18:13:08 -0400
Received: by mail-lf0-x244.google.com with SMTP id p142-v6so18411504lfd.6
	for <qemu-devel@nongnu.org>; Sun, 01 Apr 2018 15:13:07 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun,  1 Apr 2018 15:12:53 -0700
Message-Id: <20180401221253.1382-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: linux-user: fix fadvise64 call
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

fadvise64_64 on xtensa passes advice as the second argument and so must
be handled similar to PPC.

This fixes glibc testsuite tests posix/tst-posix_fadvise and
posix/tst-posix_fadvise64.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 924fd68efcdd..5ef517613577 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11509,7 +11509,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 
 #ifdef TARGET_NR_fadvise64_64
     case TARGET_NR_fadvise64_64:
-#if defined(TARGET_PPC)
+#if defined(TARGET_PPC) || defined(TARGET_XTENSA)
         /* 6 args: fd, advice, offset (high, low), len (high, low) */
         ret = arg2;
         arg2 = arg3;
-- 
2.11.0

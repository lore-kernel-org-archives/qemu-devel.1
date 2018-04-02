Received: from eggs.gnu.org ([2001:4830:134:3::10]:36536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332W-0004VB-F9
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332V-0004ie-Ki
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:40 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:41039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f332V-0004hz-DO
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:39 -0400
Received: by mail-wr0-x244.google.com with SMTP id s12so4130973wrc.8
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 10:14:39 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  2 Apr 2018 10:13:54 -0700
Message-Id: <20180402171354.27706-9-jcmvbkbc@gmail.com>
In-Reply-To: <20180402171354.27706-1-jcmvbkbc@gmail.com>
References: <20180402171354.27706-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 8/8] target/xtensa: linux-user: fix fadvise64
 call
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

fadvise64_64 on xtensa passes advice as the second argument and so must
be handled similar to PPC.

This fixes glibc testsuite tests posix/tst-posix_fadvise and
posix/tst-posix_fadvise64.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
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

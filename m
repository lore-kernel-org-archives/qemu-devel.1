Received: from eggs.gnu.org ([2001:4830:134:3::10]:40745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeN-00034o-70
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fRqeM-0003iZ-69
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:15 -0400
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:42131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fRqeM-0003iF-0Y
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 23:04:14 -0400
Received: by mail-pl0-x232.google.com with SMTP id w17-v6so10390336pll.9
	for <qemu-devel@nongnu.org>; Sat, 09 Jun 2018 20:04:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat,  9 Jun 2018 17:01:21 -1000
Message-Id: <20180610030220.3777-50-richard.henderson@linaro.org>
In-Reply-To: <20180610030220.3777-1-richard.henderson@linaro.org>
References: <20180610030220.3777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 049/108] linux-user: Fix stub gettid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

A "proper" implementation of the stub would assign ENOSYS to
errno and return -1.  As it is, the subsequent get_error will
return whatever garbage value was in errno.

Use the bogus syscall method for defining the stub function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 4dc2312ae6..46c7c485fd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -256,17 +256,12 @@ static type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,	\
 #ifndef __NR_getrandom
 #define __NR_getrandom  -1
 #endif
-
-#ifdef __NR_gettid
-_syscall0(int, gettid)
-#else
-/* This is a replacement for the host gettid() and must return a host
-   errno. */
-static int gettid(void) {
-    return -ENOSYS;
-}
+#ifndef __NR_gettid
+#define __NR_gettid  -1
 #endif
 
+_syscall0(int, gettid)
+
 /* For the 64-bit guest on 32-bit host case we must emulate
  * getdents using getdents64, because otherwise the host
  * might hand us back more dirent records than we can fit
-- 
2.17.1

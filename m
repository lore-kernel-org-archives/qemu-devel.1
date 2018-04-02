Received: from eggs.gnu.org ([2001:4830:134:3::10]:36448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332L-0004MW-Up
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332K-0004dU-Rj
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:29 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f332K-0004d7-L7
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:28 -0400
Received: by mail-wm0-x244.google.com with SMTP id i3so4827587wmf.3
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 10:14:28 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  2 Apr 2018 10:13:50 -0700
Message-Id: <20180402171354.27706-5-jcmvbkbc@gmail.com>
In-Reply-To: <20180402171354.27706-1-jcmvbkbc@gmail.com>
References: <20180402171354.27706-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 4/8] linux-user: fix mq_getsetattr implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Lionel Landwerlin <lionel.landwerlin@openwide.fr>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Aurelien Jarno <aurelien@aurel32.net>

mq_getsetattr implementation does not set errno correctly in case of
error. Also in the presence of both 2nd and 3rd arguments it calls both
mq_getattr and mq_setattr, whereas only the latter call would suffice.

Don't call mq_getattr in the presence of the 2nd argument. Don't copy
output back to user in case of error. Use get_errno to set errno value.

This fixes test rt/tst-mqueue2 from the glibc testsuite.

Cc: Lionel Landwerlin <lionel.landwerlin@openwide.fr>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Riku Voipio <riku.voipio@iki.fi>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/syscall.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 18ea79140f16..d51e2a00ee31 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12092,15 +12092,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         {
             struct mq_attr posix_mq_attr_in, posix_mq_attr_out;
             ret = 0;
-            if (arg3 != 0) {
-                ret = mq_getattr(arg1, &posix_mq_attr_out);
-                copy_to_user_mq_attr(arg3, &posix_mq_attr_out);
-            }
             if (arg2 != 0) {
                 copy_from_user_mq_attr(&posix_mq_attr_in, arg2);
-                ret |= mq_setattr(arg1, &posix_mq_attr_in, &posix_mq_attr_out);
+                ret = get_errno(mq_setattr(arg1, &posix_mq_attr_in,
+                                           &posix_mq_attr_out));
+            } else if (arg3 != 0) {
+                ret = get_errno(mq_getattr(arg1, &posix_mq_attr_out));
+            }
+            if (ret == 0 && arg3 != 0) {
+                copy_to_user_mq_attr(arg3, &posix_mq_attr_out);
             }
-
         }
         break;
 #endif
-- 
2.11.0

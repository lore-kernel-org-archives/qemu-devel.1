Received: from eggs.gnu.org ([2001:4830:134:3::10]:51197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <franklinmathieu@gmail.com>) id 1ceHu7-0004R8-AR
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 03:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <franklinmathieu@gmail.com>) id 1ceHu3-0000BE-EJ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 03:59:07 -0500
From: Franklin Snaipe Mathieu <snaipe@diacritic.io>
Date: Thu, 16 Feb 2017 08:58:57 +0000
Message-Id: <20170216085857.23501-1-snaipe@diacritic.io>
Subject: [Qemu-devel] [PATCH] syscall: fixed mincore(2) not failing with
 ENOMEM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, snaipe@arista.com, "Franklin \"Snaipe\" Mathieu" <snaipe@diacritic.io>, Riku Voipio <riku.voipio@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Franklin \"Snaipe\" Mathieu" <snaipe@diacritic.io>

The current implementation of the mincore(2) syscall sets errno to
EFAULT when the region identified by the first two parameters is
invalid.

This goes against the man page specification, where mincore(2) should
only fail with EFAULT when the third parameter is an invalid address;
and fail with ENOMEM when the checked region does not point to mapped
memory.

Signed-off-by: Franklin "Snaipe" Mathieu <snaipe@diacritic.io>
Cc: Riku Voipio <riku.voipio@linaro.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 linux-user/syscall.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9be8e9530e..af0dd40631 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11061,11 +11061,16 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_mincore:
         {
             void *a;
+            ret = -TARGET_ENOMEM;
+            a = lock_user(VERIFY_READ, arg1, arg2, 0);
+            if (!a) {
+                goto fail;
+            }
             ret = -TARGET_EFAULT;
-            if (!(a = lock_user(VERIFY_READ, arg1,arg2, 0)))
-                goto efault;
-            if (!(p = lock_user_string(arg3)))
+            p = lock_user_string(arg3)
+            if (!p) {
                 goto mincore_fail;
+            }
             ret = get_errno(mincore(a, arg2, p));
             unlock_user(p, arg3, ret);
             mincore_fail:
-- 
2.11.0

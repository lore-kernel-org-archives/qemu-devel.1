Received: from eggs.gnu.org ([209.51.188.92]:57813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggwR0-0001ZG-E1
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:49:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggwQz-00051z-Dk
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:49:06 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52331)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggwQz-0004wF-3I
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 13:49:05 -0500
Received: by mail-wm1-x344.google.com with SMTP id m1so5168344wml.2
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 10:49:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  8 Jan 2019 18:49:00 +0000
Message-Id: <20190108184900.9654-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: make pwrite64/pread64(fd, NULL, 0,
 offset) return 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Linux returns success if pwrite64() or pread64() are called with a
zero length NULL buffer, but QEMU was returning -TARGET_EFAULT.

This is the same bug that we fixed in commit 58cfa6c2e6eb51b23cc9
for the write syscall, and long before that in 38d840e6790c29f59
for the read syscall.

Fixes: https://bugs.launchpad.net/qemu/+bug/1810433

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I chose to fix this by setting p to NULL and falling through
to the normal-case codepath rather than having a call to
pread/pwrite in the special-case if like 58cfa6c2e6eb5,
because here the normal-case is a bit more complicated as
it has the target_offset64() call in it.
38d840e6790c29f59 has "just return 0" for the NULL buffer
case, but we can't do that here as that would not get the
"negative offset should return -EINVAL" case write.
---
 linux-user/syscall.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 280137da8c2..b13a170e52e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9677,8 +9677,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             arg4 = arg5;
             arg5 = arg6;
         }
-        if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-            return -TARGET_EFAULT;
+        if (arg2 == 0 && arg3 == 0) {
+            /* Special-case NULL buffer and zero length, which should succeed */
+            p = 0;
+        } else {
+            p = lock_user(VERIFY_WRITE, arg2, arg3, 0);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+        }
         ret = get_errno(pread64(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, ret);
         return ret;
@@ -9687,8 +9694,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             arg4 = arg5;
             arg5 = arg6;
         }
-        if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-            return -TARGET_EFAULT;
+        if (arg2 == 0 && arg3 == 0) {
+            /* Special-case NULL buffer and zero length, which should succeed */
+            p = 0;
+        } else {
+            p = lock_user(VERIFY_READ, arg2, arg3, 1);
+            if (!p) {
+                return -TARGET_EFAULT;
+            }
+        }
         ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
         unlock_user(p, arg2, 0);
         return ret;
-- 
2.20.1

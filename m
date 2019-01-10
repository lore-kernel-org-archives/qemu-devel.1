Received: from eggs.gnu.org ([209.51.188.92]:55290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghW3h-00009G-5E
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghVqm-00015j-TN
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:38:06 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:46975)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ghVqm-000157-44
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:38:04 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 10 Jan 2019 09:37:37 +0100
Message-Id: <20190110083737.5036-3-laurent@vivier.eu>
In-Reply-To: <20190110083737.5036-1-laurent@vivier.eu>
References: <20190110083737.5036-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/2] linux-user: make pwrite64/pread64(fd, NULL,
 0, offset) return 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

Linux returns success if pwrite64() or pread64() are called with a
zero length NULL buffer, but QEMU was returning -TARGET_EFAULT.

This is the same bug that we fixed in commit 58cfa6c2e6eb51b23cc9
for the write syscall, and long before that in 38d840e6790c29f59
for the read syscall.

Fixes: https://bugs.launchpad.net/qemu/+bug/1810433

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190108184900.9654-1-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 29bac79b61..d6605b8b50 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -9716,8 +9716,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
@@ -9726,8 +9733,15 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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

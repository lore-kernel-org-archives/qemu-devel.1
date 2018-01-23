Received: from eggs.gnu.org ([2001:4830:134:3::10]:43441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzs2-00075d-3t
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edzry-0002MS-7W
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:18 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:61908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edzrx-0002KF-Ta
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 09:48:14 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 23 Jan 2018 15:47:59 +0100
Message-Id: <20180123144807.5618-6-laurent@vivier.eu>
In-Reply-To: <20180123144807.5618-1-laurent@vivier.eu>
References: <20180123144807.5618-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 05/13] linux-user: Translate flags argument to
 dup3 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

From: Peter Maydell <peter.maydell@linaro.org>

The third argument to dup3() is a flags word which may be
O_CLOEXEC. We weren't translating this flag from target to
host value, which meant that if the target used a different
value from the host (eg sparc guest and x86 host) the dup3()
call would fail EINVAL. Do the correct translation.

Fixes: https://bugs.launchpad.net/qemu/+bug/1704658
Reported-by: Bruno Haible  <bruno@clisp.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1513351080-25917-1-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 39553c81b6..41ded90ee6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8490,11 +8490,19 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
 #endif
 #if defined(CONFIG_DUP3) && defined(TARGET_NR_dup3)
     case TARGET_NR_dup3:
-        ret = get_errno(dup3(arg1, arg2, arg3));
+    {
+        int host_flags;
+
+        if ((arg3 & ~TARGET_O_CLOEXEC) != 0) {
+            return -EINVAL;
+        }
+        host_flags = target_to_host_bitmask(arg3, fcntl_flags_tbl);
+        ret = get_errno(dup3(arg1, arg2, host_flags));
         if (ret >= 0) {
             fd_trans_dup(arg1, arg2);
         }
         break;
+    }
 #endif
 #ifdef TARGET_NR_getppid /* not on alpha */
     case TARGET_NR_getppid:
-- 
2.14.3

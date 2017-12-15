Received: from eggs.gnu.org ([2001:4830:134:3::10]:46158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePrkY-0005RX-Ui
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePrkT-0008Re-B0
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:18:10 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePrkT-0008QM-43
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 10:18:05 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Dec 2017 15:18:00 +0000
Message-Id: <1513351080-25917-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] linux-user: Translate flags argument to dup3
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Bruno Haible <bruno@clisp.org>

The third argument to dup3() is a flags word which may be
O_CLOEXEC. We weren't translating this flag from target to
host value, which meant that if the target used a different
value from the host (eg sparc guest and x86 host) the dup3()
call would fail EINVAL. Do the correct translation.

Fixes: https://bugs.launchpad.net/qemu/+bug/1704658
Reported-by: Bruno Haible  <bruno@clisp.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/syscall.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 39553c8..41ded90 100644
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
2.7.4

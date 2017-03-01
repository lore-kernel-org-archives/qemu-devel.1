Received: from eggs.gnu.org ([2001:4830:134:3::10]:33541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cj0hy-0006XL-Cf
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cj0ht-0006pi-Iy
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:38:06 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:62166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cj0ht-0006p8-A0
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 04:38:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  1 Mar 2017 10:37:47 +0100
Message-Id: <20170301093748.28033-2-laurent@vivier.eu>
In-Reply-To: <20170301093748.28033-1-laurent@vivier.eu>
References: <20170301093748.28033-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/2] linux-user: call
 fd_trans_target_to_host_data() for write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

As for sendmsg() or sendto(), we must call the target to
host data translator if it is defined. This is needed for
eventfd(): the write() syscall allows to add a value to
the internal counter, and so, it must be byte-swapped to
the host order.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cec8428..b2b563e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7767,7 +7767,17 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
     case TARGET_NR_write:
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
-        ret = get_errno(safe_write(arg1, p, arg3));
+        if (fd_trans_target_to_host_data(arg1)) {
+            void *copy = g_malloc(arg3);
+            memcpy(copy, p, arg3);
+            ret = fd_trans_target_to_host_data(arg1)(copy, arg3);
+            if (ret >= 0) {
+                ret = get_errno(safe_write(arg1, copy, ret));
+            }
+            g_free(copy);
+        } else {
+            ret = get_errno(safe_write(arg1, p, arg3));
+        }
         unlock_user(p, arg2, 0);
         break;
 #ifdef TARGET_NR_open
-- 
2.9.3

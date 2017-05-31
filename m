Received: from eggs.gnu.org ([2001:4830:134:3::10]:36668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3Ma-0007S5-Bk
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riku.voipio@linaro.org>) id 1dG3MX-0003bN-N2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:36 -0400
Received: from mail-lf0-x229.google.com ([2a00:1450:4010:c07::229]:35899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <riku.voipio@linaro.org>)
	id 1dG3MX-0003au-Fw
	for qemu-devel@nongnu.org; Wed, 31 May 2017 09:08:33 -0400
Received: by mail-lf0-x229.google.com with SMTP id h4so8613228lfj.3
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 06:08:33 -0700 (PDT)
From: riku.voipio@linaro.org
Date: Wed, 31 May 2017 16:08:13 +0300
Message-Id: <04b9bcf911af2b4563b1f1b2e8a103b796dcc9eb.1496234766.git.riku.voipio@linaro.org>
In-Reply-To: <cover.1496234766.git.riku.voipio@linaro.org>
References: <cover.1496234766.git.riku.voipio@linaro.org>
Subject: [Qemu-devel] [PULL 01/15] linux-user: call
 fd_trans_target_to_host_data() for write()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com, Laurent Vivier <laurent@vivier.eu>

From: Laurent Vivier <laurent@vivier.eu>

As for sendmsg() or sendto(), we must call the target to
host data translator if it is defined. This is needed for
eventfd(): the write() syscall allows to add a value to
the internal counter, and so, it must be byte-swapped to
the host order.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 linux-user/syscall.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cec8428589..b2b563e388 100644
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
2.11.0

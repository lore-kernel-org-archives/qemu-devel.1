Received: from eggs.gnu.org ([2001:4830:134:3::10]:45878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhuoweizhang@yahoo.com>) id 1dxyUs-0007H7-Jr
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:50:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhuoweizhang@yahoo.com>) id 1dxyUo-000124-Ne
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:50:42 -0400
Received: from sonic315-20.consmr.mail.ne1.yahoo.com ([66.163.190.146]:45862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhuoweizhang@yahoo.com>)
	id 1dxyUo-00011E-HJ
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:50:38 -0400
From: zhuoweizhang@yahoo.com
Date: Fri, 29 Sep 2017 12:50:16 -0400
Message-Id: <1506703816-7359-1-git-send-email-zhuoweizhang@yahoo.com>
Subject: [Qemu-devel] [PATCH] syscall: fix special case of write(fd, NULL, 0)
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: riku.voipio@iki.fi, laurent@vivier.eu, Zhuowei Zhang <zhuoweizhang@yahoo.com>
List-ID: <qemu-devel.nongnu.org>

From: Zhuowei Zhang <zhuoweizhang@yahoo.com>

Linux returns success for the special case of calling write with a zero-length
NULL buffer: compiling and running

```

int main() {
   ssize_t ret = write(STDOUT_FILENO, NULL, 0);
   fprintf(stderr, "write returned %ld\n", ret);
   return 0;
}
```
gives "write returned 0" when run directly, but "write returned -1" in QEMU.

This commit checks for this situation and returns success if found.

Signed-off-by: Zhuowei Zhang <zhuoweizhang@yahoo.com>
---
 linux-user/syscall.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a..ecadf49 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7783,6 +7783,11 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         }
         break;
     case TARGET_NR_write:
+        if (arg2 == 0 && arg3 == 0) {
+            /* special case: write(fd, NULL, 0) returns success. */
+            ret = 0;
+            break;
+        }
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
         if (fd_trans_target_to_host_data(arg1)) {
-- 
1.9.1


.

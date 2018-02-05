Received: from eggs.gnu.org ([2001:4830:134:3::10]:53130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eifBH-0000AL-FR
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1eifBC-00031U-KY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:43:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:39161)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1eifBC-00030x-DK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 06:43:22 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 46511ACED
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 11:43:21 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
Date: Mon, 05 Feb 2018 12:43:20 +0100
Message-ID: <mvmmv0nk6g7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] linux-user: Implement copy_file_range
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

No attempt is made to emulate it on the host.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 07fb8de921..ff89016adc 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1033,6 +1033,12 @@ safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
 safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
               size_t, len, unsigned *, prio, const struct timespec *, timeout)
 #endif
+#if defined(TARGET_NR_copy_file_range) && defined(__NR_copy_file_range)
+safe_syscall6(ssize_t, copy_file_range, int, infd, loff_t *, pinoff,
+              int, outfd, loff_t *, poutoff, size_t, length,
+              unsigned int, flags)
+#endif
+
 /* We do ioctl like this rather than via safe_syscall3 to preserve the
  * "third argument might be integer or pointer or not present" behaviour of
  * the libc function.
@@ -12578,6 +12584,39 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         ret = get_errno(kcmp(arg1, arg2, arg3, arg4, arg5));
         break;
 #endif
+#if defined(TARGET_NR_copy_file_range) && defined(__NR_copy_file_range)
+    case TARGET_NR_copy_file_range:
+        {
+            loff_t inoff, outoff;
+            loff_t *pinoff = NULL, *poutoff = NULL;
+
+            if (arg2) {
+                if (get_user_u64(inoff, arg2)) {
+                    goto efault;
+                }
+                pinoff = &inoff;
+            }
+            if (arg4) {
+                if (get_user_u64(outoff, arg4)) {
+                    goto efault;
+                }
+                poutoff = &outoff;
+            }
+            ret = get_errno (safe_copy_file_range (arg1, pinoff, arg3, poutoff,
+                                                   arg5, arg6));
+            if (arg2) {
+                if (put_user_u64(inoff, arg2)) {
+                    goto efault;
+                }
+            }
+            if (arg4) {
+                if (put_user_u64(outoff, arg4)) {
+                    goto efault;
+                }
+            }
+        }
+        break;
+#endif
 
     default:
     unimplemented:
-- 
2.16.1


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

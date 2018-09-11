Received: from eggs.gnu.org ([2001:4830:134:3::10]:44943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1fzhNv-000585-Mj
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1fzhNp-00061S-Ut
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:03:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:54158 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1fzhNp-000601-OF
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 08:03:05 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx1.suse.de (Postfix) with ESMTP id AE247AF7C
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 12:03:04 +0000 (UTC)
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 11 Sep 2018 14:03:04 +0200
Message-ID: <mvmd0tkckcn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] linux-user: don't short-circuit read with zero
 length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

A zero-length read still needs to do the usual checks, thus it may return
errors like EBADF.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 643b8833de..202d3c287d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7930,18 +7930,14 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         ret = 0; /* avoid warning */
         break;
     case TARGET_NR_read:
-        if (arg3 == 0)
-            ret = 0;
-        else {
-            if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
-                goto efault;
-            ret = get_errno(safe_read(arg1, p, arg3));
-            if (ret >= 0 &&
-                fd_trans_host_to_target_data(arg1)) {
-                ret = fd_trans_host_to_target_data(arg1)(p, ret);
-            }
-            unlock_user(p, arg2, ret);
+        if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
+            goto efault;
+        ret = get_errno(safe_read(arg1, p, arg3));
+        if (ret >= 0 &&
+            fd_trans_host_to_target_data(arg1)) {
+            ret = fd_trans_host_to_target_data(arg1)(p, ret);
         }
+        unlock_user(p, arg2, ret);
         break;
     case TARGET_NR_write:
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
-- 
2.18.0

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

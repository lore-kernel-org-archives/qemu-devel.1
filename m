Received: from eggs.gnu.org ([209.51.188.92]:53407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1h1DBn-0007ye-Lz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <schwab@suse.de>) id 1h1DBm-0003DL-Up
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:45:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:36334 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <schwab@suse.de>) id 1h1DBk-000375-Vz
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:45:10 -0500
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 05 Mar 2019 17:45:05 +0100
Message-ID: <mvm5zsxz2we.fsf@suse.de>
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

A zero-length read still needs to do the usual checks, thus it may return
errors like EBADF.  This makes the read syscall emulation consistent with
the pread64 syscall emulation.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ff912e89e1..7fac8e318f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7047,8 +7047,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         _exit(arg1);
         return 0; /* avoid warning */
     case TARGET_NR_read:
-        if (arg3 == 0) {
-            return 0;
+        if (arg2 == 0 && arg3 == 0) {
+            return get_errno(safe_read(arg1, 0, 0));
         } else {
             if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
                 return -TARGET_EFAULT;
-- 
2.21.0

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

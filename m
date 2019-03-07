Received: from eggs.gnu.org ([209.51.188.92]:43983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvo-00042k-2k
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1pvn-0007Tf-2d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:16 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:43573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1h1pvm-0007St-FC
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 05:07:14 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  7 Mar 2019 11:06:53 +0100
Message-Id: <20190307100656.14044-7-laurent@vivier.eu>
In-Reply-To: <20190307100656.14044-1-laurent@vivier.eu>
References: <20190307100656.14044-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 6/9] linux-user: don't short-circuit read with
 zero length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, Andreas Schwab <schwab@suse.de>

From: Andreas Schwab <schwab@suse.de>

A zero-length read still needs to do the usual checks, thus it may return
errors like EBADF.  This makes the read syscall emulation consistent with
the pread64 syscall emulation.

Signed-off-by: Andreas Schwab <schwab@suse.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <mvm5zsxz2we.fsf@suse.de>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5f72209debc9..9f7eb7d7a896 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7009,8 +7009,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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
2.20.1

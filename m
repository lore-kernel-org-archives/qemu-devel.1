Received: from eggs.gnu.org ([2001:4830:134:3::10]:37898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdxfc-0000BE-O6
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fdxfY-0005AZ-So
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:59:36 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33887)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fdxfY-00057v-IG
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 08:59:32 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 13 Jul 2018 14:58:05 +0200
Message-Id: <20180713125805.10749-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH] linux-user: convert remaining fcntl() to
 safe_fcntl()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

Commit 435da5e709 didn't convert a fcntl() call to safe_fcntl()
for TARGET_NR_fcntl64 case. There is no reason to not use it
in this case.

Fixes: 435da5e709 linux-user: Use safe_syscall wrapper for fcntl
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e4b1b7d7da..a997ba914f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11730,7 +11730,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             if (ret) {
                 break;
             }
-            ret = get_errno(fcntl(arg1, cmd, &fl));
+            ret = get_errno(safe_fcntl(arg1, cmd, &fl));
             if (ret == 0) {
                 ret = copyto(arg3, &fl);
             }
-- 
2.17.1

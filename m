Received: from eggs.gnu.org ([2001:4830:134:3::10]:36524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332T-0004SW-QF
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f332S-0004hN-TF
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:37 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f332S-0004hB-MX
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 13:14:36 -0400
Received: by mail-wr0-x241.google.com with SMTP id c24so14737575wrc.6
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 10:14:36 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  2 Apr 2018 10:13:53 -0700
Message-Id: <20180402171354.27706-8-jcmvbkbc@gmail.com>
In-Reply-To: <20180402171354.27706-1-jcmvbkbc@gmail.com>
References: <20180402171354.27706-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 7/8] linux-user: implement clock_settime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

This fixes glibc testsuite test rt/tst-clock2.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/syscall.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 52e2f9c16479..924fd68efcdd 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11878,6 +11878,18 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
         goto unimplemented_nowarn;
 #endif
 
+#ifdef TARGET_NR_clock_settime
+    case TARGET_NR_clock_settime:
+    {
+        struct timespec ts;
+
+        ret = target_to_host_timespec(&ts, arg2);
+        if (!is_error(ret)) {
+            ret = get_errno(clock_settime(arg1, &ts));
+        }
+        break;
+    }
+#endif
 #ifdef TARGET_NR_clock_gettime
     case TARGET_NR_clock_gettime:
     {
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:40819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2jkA-0007F0-Vg
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:38:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f2jkA-0004i4-8q
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:38:27 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:39205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f2jkA-0004he-19
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 16:38:26 -0400
Received: by mail-lf0-x243.google.com with SMTP id p142-v6so18286496lfd.6
	for <qemu-devel@nongnu.org>; Sun, 01 Apr 2018 13:38:25 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun,  1 Apr 2018 13:38:11 -0700
Message-Id: <20180401203811.31714-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] linux-user: implement clock_settime
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>

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

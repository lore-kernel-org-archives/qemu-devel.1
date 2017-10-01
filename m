Received: from eggs.gnu.org ([2001:4830:134:3::10]:50337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dySDp-0006AF-EW
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 20:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dySDl-00058k-2Z
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 20:35:05 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:38127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <carenas@gmail.com>) id 1dySDk-00055I-Qa
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 20:35:00 -0400
Received: by mail-pg0-x242.google.com with SMTP id y192so2213868pgd.5
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 17:34:57 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Date: Sat, 30 Sep 2017 17:34:42 -0700
Message-Id: <20171001003442.26211-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] linux-user: fix special case pwrite64 with
 count = 0
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhuoweizhang@yahoo.com, laurent@vivier.eu, peter.maydell@linaro.com, =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
List-ID: <qemu-devel.nongnu.org>

building on the work from Zhuowei Zhang for making write return 0 instead
of -1 when called with: write(fd, NULL, 0)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 linux-user/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9b6364a266..89e883f187 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10509,6 +10509,10 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
             arg4 = arg5;
             arg5 = arg6;
         }
+        if (arg2 == 0 && arg3 == 0) {
+            ret = get_errno(pwrite64(arg1, NULL, arg3, target_offset64(arg4, arg5)));
+            break;
+        }
         if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
             goto efault;
         ret = get_errno(pwrite64(arg1, p, arg3, target_offset64(arg4, arg5)));
-- 
2.14.2

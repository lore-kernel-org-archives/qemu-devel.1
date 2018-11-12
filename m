Received: from eggs.gnu.org ([2001:4830:134:3::10]:39494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMJ9c-0003MT-7X
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gMJ9Z-00087C-Fl
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:49:52 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gMJ9Z-00085R-2m
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 15:49:49 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 12 Nov 2018 21:49:29 +0100
Message-Id: <20181112204929.12625-5-laurent@vivier.eu>
In-Reply-To: <20181112204929.12625-1-laurent@vivier.eu>
References: <20181112204929.12625-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 4/4] linux-user: Add support for SO_REUSEPORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Yunqiang Su <ysu@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

From: Yunqiang Su <ysu@wavecomp.com>

Add support for SO_REUSEPORT, including strace support. SO_REUSEPORT
was introduced relatively recently, since Linux 3.9, so use
'#if defined SO_REUSEPORT'.

Signed-off-by: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1540904108-30873-4-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c  |  3 +++
 linux-user/syscall.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 33f4a506a2..d1d14945f9 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1742,6 +1742,9 @@ print_optint:
         case TARGET_SO_REUSEADDR:
             gemu_log("SO_REUSEADDR,");
             goto print_optint;
+        case TARGET_SO_REUSEPORT:
+            gemu_log("SO_REUSEPORT,");
+            goto print_optint;
         case TARGET_SO_TYPE:
             gemu_log("SO_TYPE,");
             goto print_optint;
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 810a58b704..5c166928a4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2061,6 +2061,11 @@ set_timeout:
         case TARGET_SO_REUSEADDR:
 		optname = SO_REUSEADDR;
 		break;
+#ifdef SO_REUSEPORT
+        case TARGET_SO_REUSEPORT:
+                optname = SO_REUSEPORT;
+                break;
+#endif
         case TARGET_SO_TYPE:
 		optname = SO_TYPE;
 		break;
@@ -2222,6 +2227,11 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
         case TARGET_SO_REUSEADDR:
             optname = SO_REUSEADDR;
             goto int_case;
+#ifdef SO_REUSEPORT
+        case TARGET_SO_REUSEPORT:
+            optname = SO_REUSEPORT;
+            goto int_case;
+#endif
         case TARGET_SO_TYPE:
             optname = SO_TYPE;
             goto int_case;
-- 
2.17.2

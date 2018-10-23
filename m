Received: from eggs.gnu.org ([2001:4830:134:3::10]:42186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEtdP-0004WC-Lk
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 06:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gEtSN-0001CY-MI
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:58:39 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57610 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gEtSH-00010x-9M
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:58:32 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 23 Oct 2018 11:58:08 +0200
Message-Id: <1540288688-4482-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540288688-4482-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540288688-4482-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 3/3] linux-user: Add support for SO_REUSEPORT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, arikalo@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, laurent@vivier.eu, ysu@wavecomp.com

From: Yunqiang Su <ysu@wavecomp.com>

Add support for SO_REUSEPORT, including strace support. SO_REUSEPORT
was introduced relatively recently, since Linux 3.9, so use
'#if defined SO_REUSEPORT'.

Signed-off-by: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/strace.c  |  3 +++
 linux-user/syscall.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 33f4a50..d1d1494 100644
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
index 4b00b72..0e9dcfe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2057,6 +2057,11 @@ set_timeout:
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
@@ -2218,6 +2223,11 @@ static abi_long do_getsockopt(int sockfd, int level, int optname,
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
2.7.4

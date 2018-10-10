Received: from eggs.gnu.org ([2001:4830:134:3::10]:38831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6O-0002fv-O3
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6N-0000Qy-LH
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:39675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gAN6N-0000OZ-DK
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 18:37:11 -0400
Received: by mail-wr1-x42e.google.com with SMTP id 61-v6so7451271wrb.6
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 15:37:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 11 Oct 2018 00:36:53 +0200
Message-Id: <20181010223656.31632-8-f4bug@amsat.org>
In-Reply-To: <20181010223656.31632-1-f4bug@amsat.org>
References: <20181010223656.31632-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 07/10] linux-user/strace: Add print_sockfd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Extract common print_sockfd() from various socket related syscalls.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/strace.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 425c06d169..5435d01569 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1651,6 +1651,11 @@ static void do_print_socket(const char *name, abi_long arg1)
     gemu_log(")");
 }
 
+static void print_sockfd(abi_long sockfd, int last)
+{
+    print_raw_param(TARGET_ABI_FMT_ld, sockfd, last);
+}
+
 static void do_print_sockaddr(const char *name, abi_long arg1)
 {
     abi_ulong sockfd, addr, addrlen;
@@ -1660,7 +1665,7 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
     get_user_ualx(addrlen, arg1, 2);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_sockaddr(addr, addrlen);
     gemu_log(")");
 }
@@ -1673,7 +1678,7 @@ static void do_print_listen(const char *name, abi_long arg1)
     get_user_ualx(backlog, arg1, 1);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_raw_param(TARGET_ABI_FMT_ld, backlog, 1);
     gemu_log(")");
 }
@@ -1708,7 +1713,7 @@ static void do_print_sendrecv(const char *name, abi_long arg1)
     get_user_ualx(flags, arg1, 3);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 1);
@@ -1727,7 +1732,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
     get_user_ualx(addrlen, arg1, 5);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 0);
@@ -1743,7 +1748,7 @@ static void do_print_shutdown(const char *name, abi_long arg1)
     get_user_ualx(how, arg1, 1);
 
     gemu_log("shutdown(");
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     switch (how) {
     case SHUT_RD:
         gemu_log("SHUT_RD");
@@ -1770,7 +1775,7 @@ static void do_print_msg(const char *name, abi_long arg1)
     get_user_ualx(flags, arg1, 2);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     print_pointer(msg, 0);
     print_flags(msg_flags, flags, 1);
     gemu_log(")");
@@ -1787,7 +1792,7 @@ static void do_print_sockopt(const char *name, abi_long arg1)
     get_user_ualx(optlen, arg1, 4);
 
     gemu_log("%s(", name);
-    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
+    print_sockfd(sockfd, 0);
     switch (level) {
     case SOL_TCP:
         gemu_log("SOL_TCP,");
-- 
2.19.1

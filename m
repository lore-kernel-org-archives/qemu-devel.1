Received: from eggs.gnu.org ([2001:4830:134:3::10]:60710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yj-0005FR-AK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yi-0003oz-EZ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:09 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:35918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yi-0003ok-99
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:08 -0400
Received: by mail-ua0-x242.google.com with SMTP id y8-v6so10581617uan.3
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:51:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  2 Jul 2018 14:50:27 -0300
Message-Id: <20180702175030.18621-11-f4bug@amsat.org>
In-Reply-To: <20180702175030.18621-1-f4bug@amsat.org>
References: <20180702175030.18621-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 10/13] linux-user/strace: Let
 print_sockaddr() have a 'last' argument
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

If the format is not the syscall last argument, a comma is append.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/strace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 390a50d45a..85a1efef32 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -67,7 +67,7 @@ UNUSED static void print_timeval(abi_ulong, int);
 UNUSED static void print_timezone(abi_ulong, int);
 UNUSED static void print_number(abi_long, int);
 UNUSED static void print_signal(abi_ulong, int);
-UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen);
+UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen, int);
 UNUSED static void print_socket_domain(int domain);
 UNUSED static void print_socket_type(int type);
 UNUSED static void print_socket_protocol(int domain, int type, int protocol);
@@ -336,7 +336,7 @@ static void print_siginfo(const target_siginfo_t *tinfo)
 }
 
 static void
-print_sockaddr(abi_ulong addr, abi_long addrlen)
+print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
 {
     struct target_sockaddr *sa;
     int i;
@@ -418,7 +418,7 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
     } else {
         print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
     }
-    gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
+    gemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
 
 static void
@@ -1658,7 +1658,7 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
 
     gemu_log("%s(", name);
     print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
-    print_sockaddr(addr, addrlen);
+    print_sockaddr(addr, addrlen, 0);
     gemu_log(")");
 }
 
@@ -1728,7 +1728,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
     print_buf(msg, len, 0);
     print_raw_param(TARGET_ABI_FMT_ld, len, 0);
     print_flags(msg_flags, flags, 0);
-    print_sockaddr(addr, addrlen);
+    print_sockaddr(addr, addrlen, 0);
     gemu_log(")");
 }
 
@@ -1966,7 +1966,7 @@ print_bind(const struct syscallname *name,
 {
     print_syscall_prologue(name);
     print_raw_param("%d", arg0, 0);
-    print_sockaddr(arg1, arg2);
+    print_sockaddr(arg1, arg2, 1);
     print_syscall_epilogue(name);
 }
 #endif
@@ -1982,7 +1982,7 @@ print_sendto(const struct syscallname *name,
     print_buf(arg1, arg2, 0);
     print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
     print_flags(msg_flags, arg3, 0);
-    print_sockaddr(arg4, arg5);
+    print_sockaddr(arg4, arg5, 1);
     print_syscall_epilogue(name);
 }
 #endif
-- 
2.18.0

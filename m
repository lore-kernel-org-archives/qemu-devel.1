Received: from eggs.gnu.org ([2001:4830:134:3::10]:60835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yr-0005Is-Tq
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yr-0003ww-2R
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:17 -0400
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yq-0003wS-Us
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:17 -0400
Received: by mail-ua0-x22f.google.com with SMTP id t14-v6so3686655uao.8
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:51:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  2 Jul 2018 14:50:30 -0300
Message-Id: <20180702175030.18621-14-f4bug@amsat.org>
In-Reply-To: <20180702175030.18621-1-f4bug@amsat.org>
References: <20180702175030.18621-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 13/13] linux-user/strace: Improve recvfrom()
 output
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-By: Guido Günther <agx@sigxcpu.org>
---
 linux-user/strace.c    | 16 ++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index f80d655835..a85b4a10e5 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2008,6 +2008,22 @@ print_getsockname(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_recvfrom)
+static void
+print_recvfrom(const struct syscallname *name,
+               abi_long arg0, abi_long arg1, abi_long arg2,
+               abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_buf(arg1, arg2, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
+    print_flags(msg_flags, arg3, 0);
+    print_sockaddr_ptr(arg4, arg5, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_sendto)
 static void
 print_sendto(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 019bf54850..82012353f6 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1101,7 +1101,7 @@
 { TARGET_NR_recv, "recv" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_recvfrom
-{ TARGET_NR_recvfrom, "recvfrom" , NULL, NULL, NULL },
+{ TARGET_NR_recvfrom, "recvfrom" , NULL, print_recvfrom, NULL },
 #endif
 #ifdef TARGET_NR_recvmmsg
 { TARGET_NR_recvmmsg, "recvmmsg" , NULL, NULL, NULL },
-- 
2.18.0

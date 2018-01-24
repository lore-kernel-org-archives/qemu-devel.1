Received: from eggs.gnu.org ([2001:4830:134:3::10]:50787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgL-00033H-FW
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgK-0005MK-Oi
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:37 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgK-0005Lf-Lm
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:36 -0500
Received: by mail-qt0-x241.google.com with SMTP id l20so9972740qtj.11
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:01:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Jan 2018 10:01:17 -0300
Message-Id: <20180124130126.20871-3-f4bug@amsat.org>
In-Reply-To: <20180124130126.20871-1-f4bug@amsat.org>
References: <20180124130126.20871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 02/11] linux-user/strace: improve sendto()
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 linux-user/strace.c    | 16 ++++++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 7eb5e2ab48..e7272f4ede 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1922,6 +1922,22 @@ print_socketcall(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_sendto)
+static void
+print_sendto(const struct syscallname *name,
+             abi_long arg0, abi_long arg1, abi_long arg2,
+             abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param(TARGET_ABI_FMT_ld, arg0, 0);
+    print_buf(arg1, arg2, 0);
+    print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
+    print_flags(msg_flags, arg3, 0);
+    print_sockaddr(arg4, arg5);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) || \
     defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64)
 static void
diff --git a/linux-user/strace.list b/linux-user/strace.list
index a91e33f7e5..47669a2f50 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1248,7 +1248,7 @@
 { TARGET_NR_sendmsg, "sendmsg" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_sendto
-{ TARGET_NR_sendto, "sendto" , NULL, NULL, NULL },
+{ TARGET_NR_sendto, "sendto" , NULL, print_sendto, NULL },
 #endif
 #ifdef TARGET_NR_setdomainname
 { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
-- 
2.15.1

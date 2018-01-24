Received: from eggs.gnu.org ([2001:4830:134:3::10]:50964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgX-0003BY-3m
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgR-0005SD-J5
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:49 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:46694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eeKgR-0005S5-EF
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 08:01:43 -0500
Received: by mail-qt0-x241.google.com with SMTP id o35so9974637qtj.13
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 05:01:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 24 Jan 2018 10:01:20 -0300
Message-Id: <20180124130126.20871-6-f4bug@amsat.org>
In-Reply-To: <20180124130126.20871-1-f4bug@amsat.org>
References: <20180124130126.20871-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 05/11] linux-user/strace: improve getsockname()
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
 linux-user/strace.c    | 13 +++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 3537a3ae92..70ecb1fc98 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1935,6 +1935,19 @@ print_socketcall(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_getsockname)
+static void
+print_getsockname(const struct syscallname *name,
+                  abi_long arg0, abi_long arg1, abi_long arg2,
+                  abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param(TARGET_ABI_FMT_ld, arg0, 0);
+    print_sockaddr_ptr(arg1, arg2, true);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_recvfrom)
 static void
 print_recvfrom(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index bf4192fb47..947ff04eab 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -371,7 +371,7 @@
 { TARGET_NR_getsid, "getsid" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_getsockname
-{ TARGET_NR_getsockname, "getsockname" , NULL, NULL, NULL },
+{ TARGET_NR_getsockname, "getsockname" , NULL, print_getsockname, NULL },
 #endif
 #ifdef TARGET_NR_getsockopt
 { TARGET_NR_getsockopt, "getsockopt" , NULL, NULL, NULL },
-- 
2.15.1

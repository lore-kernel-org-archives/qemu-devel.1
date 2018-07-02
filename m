Received: from eggs.gnu.org ([2001:4830:134:3::10]:60782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yp-0005GY-Fg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yo-0003uO-6A
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:15 -0400
Received: from mail-vk0-x234.google.com ([2607:f8b0:400c:c05::234]:38194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yo-0003u8-1P
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:51:14 -0400
Received: by mail-vk0-x234.google.com with SMTP id b77-v6so9626997vkb.5
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:51:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  2 Jul 2018 14:50:29 -0300
Message-Id: <20180702175030.18621-13-f4bug@amsat.org>
In-Reply-To: <20180702175030.18621-1-f4bug@amsat.org>
References: <20180702175030.18621-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 12/13] linux-user/strace: Improve
 getsockname() output
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
 linux-user/strace.c    | 13 +++++++++++++
 linux-user/strace.list |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 9ab11059e4..f80d655835 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1995,6 +1995,19 @@ print_bind(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_getsockname)
+static void
+print_getsockname(const struct syscallname *name,
+                  abi_long arg0, abi_long arg1, abi_long arg2,
+                  abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_sockaddr_ptr(arg1, arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_sendto)
 static void
 print_sendto(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 06597fd58c..019bf54850 100644
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
2.18.0

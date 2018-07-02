Received: from eggs.gnu.org ([2001:4830:134:3::10]:60576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yU-00053e-Tp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yU-0003gi-2J
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:54 -0400
Received: from mail-ua0-x235.google.com ([2607:f8b0:400c:c08::235]:42086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fa2yT-0003gW-Tp
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 13:50:53 -0400
Received: by mail-ua0-x235.google.com with SMTP id x18-v6so10559136uaj.9
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 10:50:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  2 Jul 2018 14:50:22 -0300
Message-Id: <20180702175030.18621-6-f4bug@amsat.org>
In-Reply-To: <20180702175030.18621-1-f4bug@amsat.org>
References: <20180702175030.18621-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 05/13] linux-user/strace: Improve
 settimeofday()
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
index 49bdee6d83..8a21d3bcfc 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1502,6 +1502,19 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
+#ifdef TARGET_NR_settimeofday
+static void
+print_settimeofday(const struct syscallname *name,
+                abi_long arg0, abi_long arg1, abi_long arg2,
+                abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_timeval(arg0, 0);
+    print_timezone(arg1, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #ifdef TARGET_NR_link
 static void
 print_link(const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index afe4db07f3..90cf7e338a 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1345,7 +1345,7 @@
 { TARGET_NR_set_tid_address, "set_tid_address" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_settimeofday
-{ TARGET_NR_settimeofday, "settimeofday" , NULL, NULL, NULL },
+{ TARGET_NR_settimeofday, "settimeofday" , NULL, print_settimeofday, NULL },
 #endif
 #ifdef TARGET_NR_setuid
 { TARGET_NR_setuid, "setuid" , NULL, NULL, NULL },
-- 
2.18.0

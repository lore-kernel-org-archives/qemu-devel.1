Received: from eggs.gnu.org ([2001:4830:134:3::10]:46105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNts-0007vW-Te
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNtp-0000aO-Mt
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:16 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:34017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYNtp-0000Zv-J4
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 23:47:13 -0400
Received: by mail-qk0-x22c.google.com with SMTP id b66-v6so2266357qkj.1
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 20:47:13 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 00:46:44 -0300
Message-Id: <20180628034652.24152-5-f4bug@amsat.org>
In-Reply-To: <20180628034652.24152-1-f4bug@amsat.org>
References: <20180628034652.24152-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/12] linux-user/strace: Improve
 gettimeofday() and settimeofday() output
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
 linux-user/strace.list |  4 ++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b43a21f48b..955fe80ef2 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -1499,6 +1499,19 @@ print_futimesat(const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_gettimeofday) || defined(TARGET_NR_settimeofday)
+static void
+print_timeofday(const struct syscallname *name,
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
index afe4db07f3..9b477b7730 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -384,7 +384,7 @@
 { TARGET_NR_gettid, "gettid" , "%s()", NULL, NULL },
 #endif
 #ifdef TARGET_NR_gettimeofday
-{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, NULL, NULL },
+{ TARGET_NR_gettimeofday, "gettimeofday" , NULL, print_timeofday, NULL },
 #endif
 #ifdef TARGET_NR_getuid
 { TARGET_NR_getuid, "getuid" , "%s()", NULL, NULL },
@@ -1345,7 +1345,7 @@
 { TARGET_NR_set_tid_address, "set_tid_address" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_settimeofday
-{ TARGET_NR_settimeofday, "settimeofday" , NULL, NULL, NULL },
+{ TARGET_NR_settimeofday, "settimeofday" , NULL, print_timeofday, NULL },
 #endif
 #ifdef TARGET_NR_setuid
 { TARGET_NR_setuid, "setuid" , NULL, NULL, NULL },
-- 
2.18.0

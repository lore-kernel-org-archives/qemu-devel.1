Received: from eggs.gnu.org ([209.51.188.92]:55720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbju-0004hl-PD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbjt-0003xw-Jl
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:46 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbjt-0003vo-CZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:31:45 -0500
Received: by mail-pg1-x543.google.com with SMTP id c25so6648959pgb.4
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:31:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:30:40 +1100
Message-Id: <20190118213122.22865-7-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 07/49] linux-user: Split out close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall-defs.h     | 1 +
 linux-user/syscall-file.inc.c | 8 ++++++++
 linux-user/syscall.c          | 4 ----
 linux-user/strace.list        | 3 ---
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index d1a6c6fa3c..797426ae6f 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -16,6 +16,7 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+SYSCALL_DEF(close, ARG_DEC);
 #ifdef TARGET_NR_open
 SYSCALL_DEF(open, ARG_STR, ARG_OPENFLAG, ARG_MODEFLAG);
 #endif
diff --git a/linux-user/syscall-file.inc.c b/linux-user/syscall-file.inc.c
index 841795f8aa..feb83c4e87 100644
--- a/linux-user/syscall-file.inc.c
+++ b/linux-user/syscall-file.inc.c
@@ -16,6 +16,14 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+SYSCALL_IMPL(close)
+{
+    int fd = arg1;
+
+    fd_trans_unregister(fd);
+    return get_errno(close(fd));
+}
+
 /*
  * Helpers for do_openat, manipulating /proc/self/foo.
  */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 035f17c0d9..f230fe161e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6771,10 +6771,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
         fd_trans_unregister(ret);
         return ret;
 #endif
-    case TARGET_NR_close:
-        fd_trans_unregister(arg1);
-        return get_errno(close(arg1));
-
     case TARGET_NR_brk:
         return do_brk(arg1);
 #ifdef TARGET_NR_fork
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 2f466e5699..71a18123bf 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -97,9 +97,6 @@
 #ifdef TARGET_NR_clone
 { TARGET_NR_clone, "clone" , NULL, print_clone, NULL },
 #endif
-#ifdef TARGET_NR_close
-{ TARGET_NR_close, "close" , "%s(%d)", NULL, NULL },
-#endif
 #ifdef TARGET_NR_connect
 { TARGET_NR_connect, "connect" , "%s(%d,%#x,%d)", NULL, NULL },
 #endif
-- 
2.17.2

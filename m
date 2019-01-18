Received: from eggs.gnu.org ([209.51.188.92]:56369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkblA-0005hV-N3
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gkbl8-0005S4-Rz
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:04 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gkbl8-0005Qc-3b
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 16:33:02 -0500
Received: by mail-pl1-x644.google.com with SMTP id g9so6895762plo.3
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 13:33:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 19 Jan 2019 08:31:13 +1100
Message-Id: <20190118213122.22865-40-richard.henderson@linaro.org>
In-Reply-To: <20190118213122.22865-1-richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 40/49] linux-user: Split out kill
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
 linux-user/syscall-defs.h    |  1 +
 linux-user/syscall.h         |  7 +++-
 linux-user/strace.c          | 76 ++++++++++++++++++------------------
 linux-user/syscall-sig.inc.c |  5 +++
 linux-user/syscall.c         |  2 -
 linux-user/strace.list       |  3 --
 6 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/linux-user/syscall-defs.h b/linux-user/syscall-defs.h
index 497fbdba66..c672b5ad99 100644
--- a/linux-user/syscall-defs.h
+++ b/linux-user/syscall-defs.h
@@ -58,6 +58,7 @@ SYSCALL_DEF(getxpid);
 #ifdef TARGET_NR_ipc
 SYSCALL_DEF_ARGS(ipc, ARG_HEX, ARG_DEC, ARG_DEC, ARG_HEX, ARG_PTR, ARG_HEX);
 #endif
+SYSCALL_DEF(kill, ARG_DEC, ARG_SIGNAL);
 #ifdef TARGET_NR_link
 SYSCALL_DEF(link, ARG_STR, ARG_STR);
 #endif
diff --git a/linux-user/syscall.h b/linux-user/syscall.h
index 84a52b2d9a..642fb6dccb 100644
--- a/linux-user/syscall.h
+++ b/linux-user/syscall.h
@@ -55,8 +55,12 @@ typedef enum {
     ARG_HEX,
     ARG_OCT,
 
-    /* These print as sets of flags.  */
+    /* These numbers are interpreted.  */
     ARG_ATDIRFD,
+    ARG_SIGNAL,
+    ARG_LSEEKWHENCE,
+
+    /* These print as sets of flags.  */
     ARG_ACCESSFLAG,
     ARG_ATFLAG,
     ARG_CLONEFLAG,
@@ -67,7 +71,6 @@ typedef enum {
     ARG_OPENFLAG,
     ARG_UMOUNTFLAG,
     ARG_UNLINKATFLAG,
-    ARG_LSEEKWHENCE,
 
     /* These are interpreted as pointers.  */
     ARG_PTR,
diff --git a/linux-user/strace.c b/linux-user/strace.c
index da2cc30f82..ec36fcf2c2 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -70,35 +70,43 @@ UNUSED static void print_socket_protocol(int domain, int type, int protocol);
 /*
  * Utility functions
  */
+static int
+add_signal(char *buf, int size, int sig)
+{
+    static const char * const signals[] = {
+        [TARGET_SIGHUP]  = "SIGHUP",
+        [TARGET_SIGINT]  = "SIGINT",
+        [TARGET_SIGQUIT] = "SIGQUIT",
+        [TARGET_SIGILL]  = "SIGILL",
+        [TARGET_SIGABRT] = "SIGABRT",
+        [TARGET_SIGFPE]  = "SIGFPE",
+        [TARGET_SIGKILL] = "SIGKILL",
+        [TARGET_SIGSEGV] = "SIGSEGV",
+        [TARGET_SIGPIPE] = "SIGPIPE",
+        [TARGET_SIGALRM] = "SIGALRM",
+        [TARGET_SIGTERM] = "SIGTERM",
+        [TARGET_SIGUSR1] = "SIGUSR1",
+        [TARGET_SIGUSR2] = "SIGUSR2",
+        [TARGET_SIGCHLD] = "SIGCHLD",
+        [TARGET_SIGCONT] = "SIGCONT",
+        [TARGET_SIGSTOP] = "SIGSTOP",
+        [TARGET_SIGTTIN] = "SIGTTIN",
+        [TARGET_SIGTTOU] = "SIGTTOU",
+    };
+
+    if (sig >= 0 && sig < ARRAY_SIZE(signals) && signals[sig]) {
+        return snprintf(buf, size, "%s", signals[sig]);
+    } else {
+        return snprintf(buf, size, "%d", sig);
+    }
+}
+
 static void
 print_signal(abi_ulong arg, int last)
 {
-    const char *signal_name = NULL;
-    switch(arg) {
-    case TARGET_SIGHUP: signal_name = "SIGHUP"; break;
-    case TARGET_SIGINT: signal_name = "SIGINT"; break;
-    case TARGET_SIGQUIT: signal_name = "SIGQUIT"; break;
-    case TARGET_SIGILL: signal_name = "SIGILL"; break;
-    case TARGET_SIGABRT: signal_name = "SIGABRT"; break;
-    case TARGET_SIGFPE: signal_name = "SIGFPE"; break;
-    case TARGET_SIGKILL: signal_name = "SIGKILL"; break;
-    case TARGET_SIGSEGV: signal_name = "SIGSEGV"; break;
-    case TARGET_SIGPIPE: signal_name = "SIGPIPE"; break;
-    case TARGET_SIGALRM: signal_name = "SIGALRM"; break;
-    case TARGET_SIGTERM: signal_name = "SIGTERM"; break;
-    case TARGET_SIGUSR1: signal_name = "SIGUSR1"; break;
-    case TARGET_SIGUSR2: signal_name = "SIGUSR2"; break;
-    case TARGET_SIGCHLD: signal_name = "SIGCHLD"; break;
-    case TARGET_SIGCONT: signal_name = "SIGCONT"; break;
-    case TARGET_SIGSTOP: signal_name = "SIGSTOP"; break;
-    case TARGET_SIGTTIN: signal_name = "SIGTTIN"; break;
-    case TARGET_SIGTTOU: signal_name = "SIGTTOU"; break;
-    }
-    if (signal_name == NULL) {
-        print_raw_param("%ld", arg, last);
-        return;
-    }
-    gemu_log("%s%s", signal_name, get_comma(last));
+    char buf[16];
+    add_signal(buf, sizeof(buf), arg);
+    gemu_log("%s%s", buf, get_comma(last));
 }
 
 static void print_si_code(int arg)
@@ -2032,19 +2040,6 @@ print_futex(const struct syscallname *name,
 }
 #endif
 
-#ifdef TARGET_NR_kill
-static void
-print_kill(const struct syscallname *name,
-    abi_long arg0, abi_long arg1, abi_long arg2,
-    abi_long arg3, abi_long arg4, abi_long arg5)
-{
-    print_syscall_prologue(name);
-    print_raw_param("%d", arg0, 0);
-    print_signal(arg1, 1);
-    print_syscall_epilogue(name);
-}
-#endif
-
 #ifdef TARGET_NR_tkill
 static void
 print_tkill(const struct syscallname *name,
@@ -2178,6 +2173,9 @@ static void print_syscall_def1(const SyscallDef *def, int64_t args[6])
         case ARG_ATDIRFD:
             len = add_atdirfd(b, rest, arg);
             break;
+        case ARG_SIGNAL:
+            len = add_signal(b, rest, arg);
+            break;
         case ARG_ACCESSFLAG:
             len = add_flags(b, rest, access_flags, arg, false);
             break;
diff --git a/linux-user/syscall-sig.inc.c b/linux-user/syscall-sig.inc.c
index f4e43eb00e..a4fbcc567d 100644
--- a/linux-user/syscall-sig.inc.c
+++ b/linux-user/syscall-sig.inc.c
@@ -23,6 +23,11 @@ SYSCALL_IMPL(alarm)
 }
 #endif
 
+SYSCALL_IMPL(kill)
+{
+    return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
+}
+
 #ifdef TARGET_NR_pause
 SYSCALL_IMPL(pause)
 {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6668e4ada8..fef955ce66 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -5338,8 +5338,6 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
     void *p;
 
     switch(num) {
-    case TARGET_NR_kill:
-        return get_errno(safe_kill(arg1, target_to_host_signal(arg2)));
 #ifdef TARGET_NR_rename
     case TARGET_NR_rename:
         {
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 56f25c15b7..b120f11dc2 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -410,9 +410,6 @@
 #ifdef TARGET_NR_keyctl
 { TARGET_NR_keyctl, "keyctl" , NULL, NULL, NULL },
 #endif
-#ifdef TARGET_NR_kill
-{ TARGET_NR_kill, "kill", NULL, print_kill, NULL },
-#endif
 #ifdef TARGET_NR_lchown
 { TARGET_NR_lchown, "lchown" , NULL, NULL, NULL },
 #endif
-- 
2.17.2

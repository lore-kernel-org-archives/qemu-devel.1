Received: from eggs.gnu.org ([2001:4830:134:3::10]:38896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmCb-0000b0-Cd
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmCY-0003C2-9o
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dsmCY-0003Ah-0i
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:18 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 15 Sep 2017 10:41:37 +0200
Message-Id: <20170915084139.4481-5-otubo@redhat.com>
In-Reply-To: <20170915084139.4481-1-otubo@redhat.com>
References: <20170915084139.4481-1-otubo@redhat.com>
Subject: [Qemu-devel] [PULL 04/06] seccomp: add spawn argument to command
 line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

This patch adds [,spawn=deny] argument to `-sandbox on' option. It
blacklists fork and execve system calls, avoiding Qemu to spawn new
threads or processes.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          |  9 +++++++--
 qemu-seccomp.c           |  4 ++++
 vl.c                     | 16 ++++++++++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index 4a9e63c7cd..3ab5fc4f61 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -18,6 +18,7 @@
 #define QEMU_SECCOMP_SET_DEFAULT     (1 << 0)
 #define QEMU_SECCOMP_SET_OBSOLETE    (1 << 1)
 #define QEMU_SECCOMP_SET_PRIVILEGED  (1 << 2)
+#define QEMU_SECCOMP_SET_SPAWN       (1 << 3)
 
 #include <seccomp.h>
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 5c1b163fb5..2b04b9f170 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4018,6 +4018,7 @@ ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
     "-sandbox on[,obsolete=allow|deny][,elevateprivileges=allow|deny|children]\n" \
+    "          [,spawn=allow|deny]\n" \
     "                Enable seccomp mode 2 system call filter (default 'off').\n" \
     "                use 'obsolete' to allow obsolete system calls that are provided\n" \
     "                    by the kernel, but typically no longer used by modern\n" \
@@ -4025,10 +4026,12 @@ DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
     "                use 'elevateprivileges' to allow or deny QEMU process to elevate\n" \
     "                    its privileges by blacklisting all set*uid|gid system calls.\n" \
     "                    The value 'children' will deny set*uid|gid system calls for\n" \
-    "                    main QEMU process but will allow forks and execves to run unprivileged\n",
+    "                    main QEMU process but will allow forks and execves to run unprivileged\n" \
+    "                use 'spawn' to avoid QEMU to spawn new threads or processes by\n" \
+    "                     blacklisting *fork and execve\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -sandbox @var{arg}[,obsolete=@var{string}][,elevateprivileges=@var{string}]
+@item -sandbox @var{arg}[,obsolete=@var{string}][,elevateprivileges=@var{string}][,spawn=@var{string}]
 @findex -sandbox
 Enable Seccomp mode 2 system call filter. 'on' will enable syscall filtering and 'off' will
 disable it.  The default is 'off'.
@@ -4037,6 +4040,8 @@ disable it.  The default is 'off'.
 Enable Obsolete system calls
 @item elevateprivileges=@var{string}
 Disable set*uid|gid system calls
+@item spawn=@var{string}
+Disable *fork and execve
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 978d66bd28..f3878a5e29 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -78,6 +78,10 @@ static const struct QemuSeccompSyscall blacklist[] = {
     { SCMP_SYS(setresgid),              QEMU_SECCOMP_SET_PRIVILEGED },
     { SCMP_SYS(setfsuid),               QEMU_SECCOMP_SET_PRIVILEGED },
     { SCMP_SYS(setfsgid),               QEMU_SECCOMP_SET_PRIVILEGED },
+    /* spawn */
+    { SCMP_SYS(fork),                   QEMU_SECCOMP_SET_SPAWN },
+    { SCMP_SYS(vfork),                  QEMU_SECCOMP_SET_SPAWN },
+    { SCMP_SYS(execve),                 QEMU_SECCOMP_SET_SPAWN },
 };
 
 
diff --git a/vl.c b/vl.c
index d59b560276..984db0c399 100644
--- a/vl.c
+++ b/vl.c
@@ -280,6 +280,10 @@ static QemuOptsList qemu_sandbox_opts = {
             .name = "elevateprivileges",
             .type = QEMU_OPT_STRING,
         },
+        {
+            .name = "spawn",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -1083,6 +1087,18 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
             }
         }
 
+        value = qemu_opt_get(opts, "spawn");
+        if (value) {
+            if (g_str_equal(value, "deny")) {
+                seccomp_opts |= QEMU_SECCOMP_SET_SPAWN;
+            } else if (g_str_equal(value, "allow")) {
+                /* default value */
+            } else {
+                error_report("invalid argument for spawn");
+                return -1;
+            }
+        }
+
         if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
-- 
2.13.5

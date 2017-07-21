Received: from eggs.gnu.org ([2001:4830:134:3::10]:57647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dYXQD-0000rS-1R
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dYXQB-0000dc-TP
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:52:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dYXQB-0000bt-Kb
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:52:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 940B04E33A
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 12:52:42 +0000 (UTC)
Received: from vader.redhat.com (ovpn-116-236.ams2.redhat.com [10.36.116.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 004748B30B
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 12:52:41 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 21 Jul 2017 14:52:33 +0200
Message-Id: <20170721125235.11939-5-otubo@redhat.com>
In-Reply-To: <20170721125235.11939-1-otubo@redhat.com>
References: <20170721125235.11939-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] seccomp: add spawn argument to command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch adds [,spawn=deny] argument to `-sandbox on' option. It
blacklists fork and execve system calls, avoiding Qemu to spawn new
threads or processes.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          |  9 ++++++---
 qemu-seccomp.c           | 19 +++++++++++++++++++
 vl.c                     | 11 +++++++++++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index e6e78d85ce..f1614d6514 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -17,6 +17,7 @@
 
 #define OBSOLETE    0x0001
 #define PRIVILEGED  0x0010
+#define SPAWN       0x0100
 
 #include <seccomp.h>
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 34d33a812e..3d612f0fd1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4004,12 +4004,13 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox on[,obsolete=allow][,elevateprivileges=allow|deny|children]  Enable seccomp mode 2 system call filter (default 'off').\n" \
+    "-sandbox on[,obsolete=allow][,elevateprivileges=allow|deny|children][,spawn=deny]  Enable seccomp mode 2 system call filter (default 'off').\n" \
     "                obsolete: Allow obsolete system calls\n"
-    "                elevateprivileges: allows or denies Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls. 'children' will deny set*uid|gid system calls for main Qemu process but will allow forks and execves to run unprivileged\n",
+    "                elevateprivileges: allows or denies Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls. 'children' will deny set*uid|gid system calls for main Qemu process but will allow forks and execves to run unprivileged\n"
+    "                spawn: avoids Qemu to spawn new threads or processes by blacklisting *fork and execve\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -sandbox @var{arg}[,obsolete=@var{string}][,elevateprivileges=@var{string}]
+@item -sandbox @var{arg}[,obsolete=@var{string}][,elevateprivileges=@var{string}][,spawn=@var{string}]
 @findex -sandbox
 Enable Seccomp mode 2 system call filter. 'on' will enable syscall filtering and 'off' will
 disable it.  The default is 'off'.
@@ -4018,6 +4019,8 @@ disable it.  The default is 'off'.
 Enable Obsolete system calls
 @item elevateprivileges=@var{string}
 Disable set*uid|gid systema calls
+@item spawn=@var{string}
+Disable *fork and execve
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 6caa513edd..22a093ca1b 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -31,6 +31,12 @@ struct QemuSeccompSyscall {
     uint8_t priority;
 };
 
+static const struct QemuSeccompSyscall spawn_syscalls[] = {
+    { SCMP_SYS(fork), 255 },
+    { SCMP_SYS(vfork), 255 },
+    { SCMP_SYS(execve), 255 },
+};
+
 static const struct QemuSeccompSyscall privileged_syscalls[] = {
     { SCMP_SYS(setuid), 255 },
     { SCMP_SYS(setgid), 255 },
@@ -138,6 +144,19 @@ int seccomp_start(uint8_t seccomp_opts)
         }
     }
 
+    if (seccomp_opts & SPAWN) {
+        for (i = 0; i < ARRAY_SIZE(spawn_syscalls); i++) {
+            rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, spawn_syscalls[i].num, 0);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+            rc = seccomp_syscall_priority(ctx, spawn_syscalls[i].num,
+                                          spawn_syscalls[i].priority);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+        }
+    }
 
     rc = seccomp_load(ctx);
 
diff --git a/vl.c b/vl.c
index f2b2f10b7b..ae3fa8b139 100644
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
@@ -1065,6 +1069,13 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
             }
         }
 
+        value = qemu_opt_get(opts, "spawn");
+        if (value) {
+            if (strcmp(value, "deny") == 0) {
+                seccomp_opts |= SPAWN;
+            }
+        }
+
         if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
-- 
2.13.3

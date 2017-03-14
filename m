Received: from eggs.gnu.org ([2001:4830:134:3::10]:52980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkga-0000iA-A7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkgZ-00086u-6z
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:16 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cnkgZ-00084b-14
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:15 -0400
Received: by mail-wm0-x235.google.com with SMTP id t189so61367152wmt.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 04:32:14 -0700 (PDT)
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Date: Tue, 14 Mar 2017 12:32:08 +0100
Message-Id: <20170314113209.12025-5-eduardo.otubo@profitbricks.com>
In-Reply-To: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
Subject: [Qemu-devel] [PATCH 4/5] seccomp: add spawn argument to command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com

This patch adds [,spawn=deny] argument to `-sandbox on' option. It
blacklists fork and execve syste calls, avoiding Qemu to spawn new
threads or processes.

Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          |  7 +++++--
 qemu-seccomp.c           | 18 ++++++++++++++++++
 vl.c                     | 11 +++++++++++
 4 files changed, 35 insertions(+), 2 deletions(-)

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
index 47018db5aa..53f4f8cfd2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3732,10 +3732,11 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox on[,obsolete=allow][,elevateprivileges=deny]\n" \
+    "-sandbox on[,obsolete=allow][,elevateprivileges=deny][,spawn=deny]" \
     "                               Enable seccomp mode 2 system call filter (default 'off').\n" \
     "                               obsolete: Allow obsolete system calls\n" \
-    "                               elevateprivileges: avoids Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls",
+    "                               elevateprivileges: avoids Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls\n" \
+    "                               spawn: avoids Qemu to spawn new threads or processes by blacklisting *fork and execve\n"
     QEMU_ARCH_ALL)
 STEXI
 @item -sandbox @var{arg}[,obsolete=@var{string}]
@@ -3747,6 +3748,8 @@ disable it.  The default is 'off'.
 Enable Obsolete system calls
 @item elevateprivileges=@var{string}
 Disable set*uid|gid systema calls
+@item spawn=@var{string}
+Disable *fork and execve
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 5aa6590386..4c1f7b41ba 100644
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
@@ -152,6 +158,18 @@ int seccomp_start(uint8_t seccomp_opts)
         }
     }
 
+    if (seccomp_opts & SPAWN) {
+        for (i = 0; i < ARRAY_SIZE(spawn_syscalls); i++) {
+            rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, spawn_syscalls[i].num, 0);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+            rc = seccomp_syscall_priority(ctx, spawn_syscalls[i].num, spawn_syscalls[i].priority);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+        }
+    }
 
     rc = seccomp_load(ctx);
 
diff --git a/vl.c b/vl.c
index d071e240b0..6a6e9a69bf 100644
--- a/vl.c
+++ b/vl.c
@@ -277,6 +277,10 @@ static QemuOptsList qemu_sandbox_opts = {
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
@@ -1056,6 +1060,13 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
             }
         }
 
+        value = qemu_opt_get(opts,"spawn");
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
2.11.0

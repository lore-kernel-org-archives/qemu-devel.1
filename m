Received: from eggs.gnu.org ([2001:4830:134:3::10]:53019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkgb-0000iU-Gf
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkga-00088N-2F
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:17 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:37822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cnkgZ-000873-SM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:15 -0400
Received: by mail-wm0-x22f.google.com with SMTP id n11so61327877wma.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 04:32:15 -0700 (PDT)
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Date: Tue, 14 Mar 2017 12:32:09 +0100
Message-Id: <20170314113209.12025-6-eduardo.otubo@profitbricks.com>
In-Reply-To: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
Subject: [Qemu-devel] [PATCH 5/5] seccomp: add resourcecontrol argument to
 command line
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

This patch adds [,resourcecontrol=deny] to `-sandbox on' option. It
blacklists all process affinity and scheduler priority system calls to
avoid any bigger of the process.

Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          |  5 ++++-
 qemu-seccomp.c           | 26 ++++++++++++++++++++++++++
 vl.c                     | 11 +++++++++++
 4 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index f1614d6514..c7003dd197 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -18,6 +18,7 @@
 #define OBSOLETE    0x0001
 #define PRIVILEGED  0x0010
 #define SPAWN       0x0100
+#define RESOURCECTL 0x1000
 
 #include <seccomp.h>
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 53f4f8cfd2..5784ffe4b1 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3732,11 +3732,12 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox on[,obsolete=allow][,elevateprivileges=deny][,spawn=deny]" \
+    "-sandbox on[,obsolete=allow][,elevateprivileges=deny][,spawn=deny][,resourcecontrol=deny]\n" \
     "                               Enable seccomp mode 2 system call filter (default 'off').\n" \
     "                               obsolete: Allow obsolete system calls\n" \
     "                               elevateprivileges: avoids Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls\n" \
     "                               spawn: avoids Qemu to spawn new threads or processes by blacklisting *fork and execve\n"
+    "                               resourcecontrol: disable process affinity and schedular priority\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -sandbox @var{arg}[,obsolete=@var{string}]
@@ -3750,6 +3751,8 @@ Enable Obsolete system calls
 Disable set*uid|gid systema calls
 @item spawn=@var{string}
 Disable *fork and execve
+@item resourcecontrol=@var{string}
+Disable process affinity and schedular priority
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 4c1f7b41ba..dec47e9a74 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -31,6 +31,19 @@ struct QemuSeccompSyscall {
     uint8_t priority;
 };
 
+static const struct QemuSeccompSyscall resourcecontrol_syscalls[] = {
+    { SCMP_SYS(getpriority), 255 },
+    { SCMP_SYS(setpriority), 255 },
+    { SCMP_SYS(sched_setparam), 255 },
+    { SCMP_SYS(sched_getparam), 255 },
+    { SCMP_SYS(sched_setscheduler), 255 },
+    { SCMP_SYS(sched_getscheduler), 255 },
+    { SCMP_SYS(sched_setaffinity), 255 },
+    { SCMP_SYS(sched_getaffinity), 255 },
+    { SCMP_SYS(sched_get_priority_max), 255 },
+    { SCMP_SYS(sched_get_priority_min), 255 },
+};
+
 static const struct QemuSeccompSyscall spawn_syscalls[] = {
     { SCMP_SYS(fork), 255 },
     { SCMP_SYS(vfork), 255 },
@@ -171,6 +184,19 @@ int seccomp_start(uint8_t seccomp_opts)
         }
     }
 
+    if (seccomp_opts & RESOURCECTL) {
+        for (i = 0; i < ARRAY_SIZE(resourcecontrol_syscalls); i++) {
+            rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, resourcecontrol_syscalls[i].num, 0);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+            rc = seccomp_syscall_priority(ctx, resourcecontrol_syscalls[i].num, resourcecontrol_syscalls[i].priority);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+        }
+    }
+
     rc = seccomp_load(ctx);
 
   seccomp_return:
diff --git a/vl.c b/vl.c
index 6a6e9a69bf..3ceffef094 100644
--- a/vl.c
+++ b/vl.c
@@ -281,6 +281,10 @@ static QemuOptsList qemu_sandbox_opts = {
             .name = "spawn",
             .type = QEMU_OPT_STRING,
         },
+        {
+            .name = "resourcecontrol",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -1067,6 +1071,13 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
             }
         }
 
+        value = qemu_opt_get(opts,"resourcecontrol");
+        if (value) {
+            if (strcmp(value, "deny") == 0) {
+                seccomp_opts |= RESOURCECTL;
+            }
+        }
+
         if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
-- 
2.11.0

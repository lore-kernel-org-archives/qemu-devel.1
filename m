Received: from eggs.gnu.org ([2001:4830:134:3::10]:35196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dVyuP-00089Q-Ci
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dVyuO-0006rk-Bp
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:37:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dVyuO-0006qx-36
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:37:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B52B80478
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 11:37:19 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 14 Jul 2017 13:36:59 +0200
Message-Id: <20170714113700.21319-6-otubo@redhat.com>
In-Reply-To: <20170714113700.21319-1-otubo@redhat.com>
References: <20170714113700.21319-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] seccomp: add resourcecontrol argument to
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
Cc: Eduardo Otubo <otubo@redhat.com>

This patch adds [,resourcecontrol=deny] to `-sandbox on' option. It
blacklists all process affinity and scheduler priority system calls to
avoid any bigger of the process.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          |  5 ++++-
 qemu-seccomp.c           | 27 +++++++++++++++++++++++++++
 vl.c                     | 11 +++++++++++
 4 files changed, 43 insertions(+), 1 deletion(-)

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
index 611a501684..77b437a052 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4004,11 +4004,12 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox on[,obsolete=allow][,elevateprivileges=allow|deny|children][,spawn=deny]\n" \
+    "-sandbox on[,obsolete=allow][,elevateprivileges=allow|deny|children][,spawn=deny][,resourcecontrol=deny]\n" \
     "                               Enable seccomp mode 2 system call filter (default 'off').\n" \
     "                               obsolete: Allow obsolete system calls\n" \
     "                               elevateprivileges: allows or denies Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls. 'children' will deny set*uid|gid system calls for main Qemu process but will allow forks and execves to run unprivileged",
     "                               spawn: avoids Qemu to spawn new threads or processes by blacklisting *fork and execve\n"
+    "                               resourcecontrol: disable process affinity and schedular priority\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -sandbox @var{arg}[,obsolete=@var{string}]
@@ -4022,6 +4023,8 @@ Enable Obsolete system calls
 Disable set*uid|gid systema calls
 @item spawn=@var{string}
 Disable *fork and execve
+@item resourcecontrol=@var{string}
+Disable process affinity and schedular priority
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 075d87e27f..a9a35456e9 100644
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
@@ -158,6 +171,20 @@ int seccomp_start(uint8_t seccomp_opts)
         }
     }
 
+    if (seccomp_opts & RESOURCECTL) {
+        for (i = 0; i < ARRAY_SIZE(resourcecontrol_syscalls); i++) {
+            rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, resourcecontrol_syscalls[i].num, 0);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+            rc = seccomp_syscall_priority(ctx, resourcecontrol_syscalls[i].num,
+					  resourcecontrol_syscalls[i].priority);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+        }
+    }
+
     rc = seccomp_load(ctx);
 
   seccomp_return:
diff --git a/vl.c b/vl.c
index 456a518431..8e92052603 100644
--- a/vl.c
+++ b/vl.c
@@ -283,6 +283,10 @@ static QemuOptsList qemu_sandbox_opts = {
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
@@ -1075,6 +1079,13 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
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
2.13.0

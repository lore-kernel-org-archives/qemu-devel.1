Received: from eggs.gnu.org ([2001:4830:134:3::10]:35176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dVyuO-00088C-6F
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dVyuN-0006qo-9C
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:37:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58498)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dVyuN-0006qK-06
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:37:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F2BD8BAEC2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 11:37:17 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 14 Jul 2017 13:36:58 +0200
Message-Id: <20170714113700.21319-5-otubo@redhat.com>
In-Reply-To: <20170714113700.21319-1-otubo@redhat.com>
References: <20170714113700.21319-1-otubo@redhat.com>
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
Cc: Eduardo Otubo <otubo@redhat.com>

This patch adds [,spawn=deny] argument to `-sandbox on' option. It
blacklists fork and execve system calls, avoiding Qemu to spawn new
threads or processes.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          |  5 ++++-
 qemu-seccomp.c           | 19 +++++++++++++++++++
 vl.c                     | 11 +++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

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
index 6dc776aae3..611a501684 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4004,10 +4004,11 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox on[,obsolete=allow][,elevateprivileges=allow|deny|children]\n" \
+    "-sandbox on[,obsolete=allow][,elevateprivileges=allow|deny|children][,spawn=deny]\n" \
     "                               Enable seccomp mode 2 system call filter (default 'off').\n" \
     "                               obsolete: Allow obsolete system calls\n" \
     "                               elevateprivileges: allows or denies Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls. 'children' will deny set*uid|gid system calls for main Qemu process but will allow forks and execves to run unprivileged",
+    "                               spawn: avoids Qemu to spawn new threads or processes by blacklisting *fork and execve\n"
     QEMU_ARCH_ALL)
 STEXI
 @item -sandbox @var{arg}[,obsolete=@var{string}]
@@ -4019,6 +4020,8 @@ disable it.  The default is 'off'.
 Enable Obsolete system calls
 @item elevateprivileges=@var{string}
 Disable set*uid|gid systema calls
+@item spawn=@var{string}
+Disable *fork and execve
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index c204cef9ee..075d87e27f 100644
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
+					  spawn_syscalls[i].priority);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+        }
+    }
 
     rc = seccomp_load(ctx);
 
diff --git a/vl.c b/vl.c
index 0b857083a3..456a518431 100644
--- a/vl.c
+++ b/vl.c
@@ -279,6 +279,10 @@ static QemuOptsList qemu_sandbox_opts = {
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
@@ -1064,6 +1068,13 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
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
2.13.0

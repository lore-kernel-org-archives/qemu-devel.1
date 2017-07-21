Received: from eggs.gnu.org ([2001:4830:134:3::10]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dYXQC-0000qe-0E
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dYXQB-0000bz-2V
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dYXQA-0000bU-Pj
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:52:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D1FB8E685
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 12:52:41 +0000 (UTC)
Received: from vader.redhat.com (ovpn-116-236.ams2.redhat.com [10.36.116.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 08E2E8B31E
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 12:52:40 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 21 Jul 2017 14:52:32 +0200
Message-Id: <20170721125235.11939-4-otubo@redhat.com>
In-Reply-To: <20170721125235.11939-1-otubo@redhat.com>
References: <20170721125235.11939-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] seccomp: add elevateprivileges argument to
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

This patch introduces the new argument
[,elevateprivileges=allow|deny|children] to the `-sandbox on'. It allows
or denies Qemu process to elevate its privileges by blacklisting all
set*uid|gid system calls. The 'children' option will let forks and
execves run unprivileged.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          |  9 ++++++---
 qemu-seccomp.c           | 29 +++++++++++++++++++++++++++++
 vl.c                     | 19 +++++++++++++++++++
 4 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index 7a7bde246b..e6e78d85ce 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -16,6 +16,7 @@
 #define QEMU_SECCOMP_H
 
 #define OBSOLETE    0x0001
+#define PRIVILEGED  0x0010
 
 #include <seccomp.h>
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 54e492f36a..34d33a812e 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4004,17 +4004,20 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox on[,obsolete=allow]  Enable seccomp mode 2 system call filter (default 'off').\n" \
-    "                obsolete: Allow obsolete system calls\n",
+    "-sandbox on[,obsolete=allow][,elevateprivileges=allow|deny|children]  Enable seccomp mode 2 system call filter (default 'off').\n" \
+    "                obsolete: Allow obsolete system calls\n"
+    "                elevateprivileges: allows or denies Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls. 'children' will deny set*uid|gid system calls for main Qemu process but will allow forks and execves to run unprivileged\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -sandbox @var{arg}[,obsolete=@var{string}]
+@item -sandbox @var{arg}[,obsolete=@var{string}][,elevateprivileges=@var{string}]
 @findex -sandbox
 Enable Seccomp mode 2 system call filter. 'on' will enable syscall filtering and 'off' will
 disable it.  The default is 'off'.
 @table @option
 @item obsolete=@var{string}
 Enable Obsolete system calls
+@item elevateprivileges=@var{string}
+Disable set*uid|gid systema calls
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index c6a8b28260..6caa513edd 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -31,6 +31,19 @@ struct QemuSeccompSyscall {
     uint8_t priority;
 };
 
+static const struct QemuSeccompSyscall privileged_syscalls[] = {
+    { SCMP_SYS(setuid), 255 },
+    { SCMP_SYS(setgid), 255 },
+    { SCMP_SYS(setpgid), 255 },
+    { SCMP_SYS(setsid), 255 },
+    { SCMP_SYS(setreuid), 255 },
+    { SCMP_SYS(setregid), 255 },
+    { SCMP_SYS(setresuid), 255 },
+    { SCMP_SYS(setresgid), 255 },
+    { SCMP_SYS(setfsuid), 255 },
+    { SCMP_SYS(setfsgid), 255 },
+};
+
 static const struct QemuSeccompSyscall obsolete[] = {
     { SCMP_SYS(readdir), 255 },
     { SCMP_SYS(_sysctl), 255 },
@@ -110,6 +123,22 @@ int seccomp_start(uint8_t seccomp_opts)
         }
     }
 
+    if (seccomp_opts & PRIVILEGED) {
+        for (i = 0; i < ARRAY_SIZE(privileged_syscalls); i++) {
+            rc = seccomp_rule_add(ctx, SCMP_ACT_KILL,
+                                  privileged_syscalls[i].num, 0);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+            rc = seccomp_syscall_priority(ctx, privileged_syscalls[i].num,
+                    privileged_syscalls[i].priority);
+            if (rc < 0) {
+                goto seccomp_return;
+            }
+        }
+    }
+
+
     rc = seccomp_load(ctx);
 
   seccomp_return:
diff --git a/vl.c b/vl.c
index cbe09c94af..f2b2f10b7b 100644
--- a/vl.c
+++ b/vl.c
@@ -29,6 +29,7 @@
 
 #ifdef CONFIG_SECCOMP
 #include "sysemu/seccomp.h"
+#include "sys/prctl.h"
 #endif
 
 #if defined(CONFIG_VDE)
@@ -275,6 +276,10 @@ static QemuOptsList qemu_sandbox_opts = {
             .name = "obsolete",
             .type = QEMU_OPT_STRING,
         },
+        {
+            .name = "elevateprivileges",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -1046,6 +1051,20 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
             }
         }
 
+        value = qemu_opt_get(opts, "elevateprivileges");
+        if (value) {
+            if (strcmp(value, "deny") == 0) {
+                seccomp_opts |= PRIVILEGED;
+            }
+            if (strcmp(value, "children") == 0) {
+                seccomp_opts |= PRIVILEGED;
+
+                /* calling prctl directly because we're
+                 * not sure if host has CAP_SYS_ADMIN set*/
+                prctl(PR_SET_NO_NEW_PRIVS, 1);
+            }
+        }
+
         if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
-- 
2.13.3

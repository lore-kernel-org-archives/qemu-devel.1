Received: from eggs.gnu.org ([2001:4830:134:3::10]:52952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkgZ-0000i8-Ni
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkgY-00084n-H3
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:15 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cnkgY-00083z-AP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:14 -0400
Received: by mail-wr0-x233.google.com with SMTP id u48so122058950wrc.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 04:32:14 -0700 (PDT)
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Date: Tue, 14 Mar 2017 12:32:07 +0100
Message-Id: <20170314113209.12025-4-eduardo.otubo@profitbricks.com>
In-Reply-To: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
Subject: [Qemu-devel] [PATCH 3/5] seccomp: add elevateprivileges argument to
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

This patch introduces the new argument [,elevateprivileges=deny] to the
`-sandbox on'. It avoids Qemu process to elevate its privileges by
blacklisting all set*uid|gid system calls

Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          |  8 ++++++--
 qemu-seccomp.c           | 28 ++++++++++++++++++++++++++++
 vl.c                     | 11 +++++++++++
 4 files changed, 46 insertions(+), 2 deletions(-)

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
index 1403d0c85f..47018db5aa 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3732,8 +3732,10 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox on[,obsolete=allow]  Enable seccomp mode 2 system call filter (default 'off').\n" \
-    "                              obsolete: Allow obsolete system calls",
+    "-sandbox on[,obsolete=allow][,elevateprivileges=deny]\n" \
+    "                               Enable seccomp mode 2 system call filter (default 'off').\n" \
+    "                               obsolete: Allow obsolete system calls\n" \
+    "                               elevateprivileges: avoids Qemu process to elevate its privileges by blacklisting all set*uid|gid system calls",
     QEMU_ARCH_ALL)
 STEXI
 @item -sandbox @var{arg}[,obsolete=@var{string}]
@@ -3743,6 +3745,8 @@ disable it.  The default is 'off'.
 @table @option
 @item obsolete=@var{string}
 Enable Obsolete system calls
+@item elevateprivileges=@var{string}
+Disable set*uid|gid systema calls
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 5ef36890da..5aa6590386 100644
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
@@ -125,6 +138,21 @@ int seccomp_start(uint8_t seccomp_opts)
         }
     }
 
+    if (seccomp_opts & PRIVILEGED) {
+        for (i = 0; i < ARRAY_SIZE(privileged_syscalls); i++) {
+            rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, privileged_syscalls[i].num, 0);
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
index 7b08b3383b..d071e240b0 100644
--- a/vl.c
+++ b/vl.c
@@ -273,6 +273,10 @@ static QemuOptsList qemu_sandbox_opts = {
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
@@ -1045,6 +1049,13 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
             }
         }
 
+        value = qemu_opt_get(opts,"elevateprivileges");
+        if (value) {
+            if (strcmp(value, "deny") == 0) {
+                seccomp_opts |= PRIVILEGED;
+            }
+        }
+
         if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
-- 
2.11.0

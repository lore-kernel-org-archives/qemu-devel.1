Received: from eggs.gnu.org ([2001:4830:134:3::10]:51249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjey-000089-MJ
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjex-0001Gh-DL
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dnjex-0001E4-4Y
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:58:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29F52356F4
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 10:58:46 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri,  1 Sep 2017 12:58:15 +0200
Message-Id: <20170901105818.31956-4-otubo@redhat.com>
In-Reply-To: <20170901105818.31956-1-otubo@redhat.com>
References: <20170901105818.31956-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCHv4 3/6] seccomp: add elevateprivileges argument
 to command line
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

This patch introduces the new argument
[,elevateprivileges=allow|deny|children] to the `-sandbox on'. It allows
or denies Qemu process to elevate its privileges by blacklisting all
set*uid|gid system calls. The 'children' option will let forks and
execves run unprivileged.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          | 12 +++++++++---
 qemu-seccomp.c           | 29 ++++++++++++++++++-----------
 vl.c                     | 27 +++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index 215138a372..4a9e63c7cd 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -17,6 +17,7 @@
 
 #define QEMU_SECCOMP_SET_DEFAULT     (1 << 0)
 #define QEMU_SECCOMP_SET_OBSOLETE    (1 << 1)
+#define QEMU_SECCOMP_SET_PRIVILEGED  (1 << 2)
 
 #include <seccomp.h>
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 72150c6b84..5c1b163fb5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4017,20 +4017,26 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox on[,obsolete=allow|deny]\n" \
+    "-sandbox on[,obsolete=allow|deny][,elevateprivileges=allow|deny|children]\n" \
     "                Enable seccomp mode 2 system call filter (default 'off').\n" \
     "                use 'obsolete' to allow obsolete system calls that are provided\n" \
     "                    by the kernel, but typically no longer used by modern\n" \
-    "                    C library implementations.\n",
+    "                    C library implementations.\n" \
+    "                use 'elevateprivileges' to allow or deny QEMU process to elevate\n" \
+    "                    its privileges by blacklisting all set*uid|gid system calls.\n" \
+    "                    The value 'children' will deny set*uid|gid system calls for\n" \
+    "                    main QEMU process but will allow forks and execves to run unprivileged\n",
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
+Disable set*uid|gid system calls
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 3e3f15cc08..16c8c20132 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -57,17 +57,16 @@ static const struct QemuSeccompSyscall blacklist[] = {
     { SCMP_SYS(ulimit),                1, QEMU_SECCOMP_SET_DEFAULT },
     { SCMP_SYS(vserver),               1, QEMU_SECCOMP_SET_DEFAULT },
     /* obsolete */
-    { SCMP_SYS(readdir),               2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(_sysctl),               2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(bdflush),               2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(create_module),         2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(get_kernel_syms),       2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(query_module),          2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(sgetmask),              2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(ssetmask),              2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(sysfs),                 2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(uselib),                2, QEMU_SECCOMP_SET_OBSOLETE },
-    { SCMP_SYS(ustat),                 2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(setuid),                4, QEMU_SECCOMP_SET_PRIVILEGED },
+    { SCMP_SYS(setgid),                4, QEMU_SECCOMP_SET_PRIVILEGED },
+    { SCMP_SYS(setpgid),               4, QEMU_SECCOMP_SET_PRIVILEGED },
+    { SCMP_SYS(setsid),                4, QEMU_SECCOMP_SET_PRIVILEGED },
+    { SCMP_SYS(setreuid),              4, QEMU_SECCOMP_SET_PRIVILEGED },
+    { SCMP_SYS(setregid),              4, QEMU_SECCOMP_SET_PRIVILEGED },
+    { SCMP_SYS(setresuid),             4, QEMU_SECCOMP_SET_PRIVILEGED },
+    { SCMP_SYS(setresgid),             4, QEMU_SECCOMP_SET_PRIVILEGED },
+    { SCMP_SYS(setfsuid),              4, QEMU_SECCOMP_SET_PRIVILEGED },
+    { SCMP_SYS(setfsgid),              4, QEMU_SECCOMP_SET_PRIVILEGED },
 };
 
 
@@ -93,6 +92,14 @@ int seccomp_start(uint32_t seccomp_opts)
             }
 
             break;
+        case QEMU_SECCOMP_SET_PRIVILEGED:
+            if (seccomp_opts & QEMU_SECCOMP_SET_PRIVILEGED) {
+                goto add_syscall;
+            } else {
+                continue;
+            }
+
+            break;
         default:
             goto add_syscall;
         }
diff --git a/vl.c b/vl.c
index ca267f9918..1d44b05772 100644
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
@@ -1052,6 +1057,28 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
 	    }
         }
 
+        value = qemu_opt_get(opts, "elevateprivileges");
+        if (value) {
+            if (strcmp(value, "deny") == 0) {
+                seccomp_opts |= QEMU_SECCOMP_SET_PRIVILEGED;
+            } else if (strcmp(value, "children") == 0) {
+                seccomp_opts |= QEMU_SECCOMP_SET_PRIVILEGED;
+
+                /* calling prctl directly because we're
+                 * not sure if host has CAP_SYS_ADMIN set*/
+                if (prctl(PR_SET_NO_NEW_PRIVS, 1)) {
+                    error_report("failed to set no_new_privs "
+                                 "aborting");
+                    return -1;
+                }
+            } else if (strcmp(value, "allow") == 0) {
+                /* default value */
+            } else {
+                error_report("invalid argument for elevateprivileges");
+                return -1;
+            }
+        }
+
         if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
-- 
2.13.5

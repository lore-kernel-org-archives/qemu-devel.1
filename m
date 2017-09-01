Received: from eggs.gnu.org ([2001:4830:134:3::10]:51348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjfD-0000MN-0i
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjf8-0001QV-6X
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:59:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4049)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dnjf7-0001PX-UC
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:58:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E72ACC0467D7
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 10:58:56 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri,  1 Sep 2017 12:58:17 +0200
Message-Id: <20170901105818.31956-6-otubo@redhat.com>
In-Reply-To: <20170901105818.31956-1-otubo@redhat.com>
References: <20170901105818.31956-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCHv4 5/6] seccomp: add resourcecontrol argument to
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

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 include/sysemu/seccomp.h |  1 +
 qemu-options.hx          |  9 ++++++---
 qemu-seccomp.c           | 19 +++++++++++++++++++
 vl.c                     | 16 ++++++++++++++++
 4 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index 3ab5fc4f61..e67c2dc840 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -19,6 +19,7 @@
 #define QEMU_SECCOMP_SET_OBSOLETE    (1 << 1)
 #define QEMU_SECCOMP_SET_PRIVILEGED  (1 << 2)
 #define QEMU_SECCOMP_SET_SPAWN       (1 << 3)
+#define QEMU_SECCOMP_SET_RESOURCECTL (1 << 4)
 
 #include <seccomp.h>
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 2b04b9f170..600614f6e5 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4018,7 +4018,7 @@ ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
     "-sandbox on[,obsolete=allow|deny][,elevateprivileges=allow|deny|children]\n" \
-    "          [,spawn=allow|deny]\n" \
+    "          [,spawn=allow|deny][,resourcecontrol=allow|deny]\n" \
     "                Enable seccomp mode 2 system call filter (default 'off').\n" \
     "                use 'obsolete' to allow obsolete system calls that are provided\n" \
     "                    by the kernel, but typically no longer used by modern\n" \
@@ -4028,10 +4028,11 @@ DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
     "                    The value 'children' will deny set*uid|gid system calls for\n" \
     "                    main QEMU process but will allow forks and execves to run unprivileged\n" \
     "                use 'spawn' to avoid QEMU to spawn new threads or processes by\n" \
-    "                     blacklisting *fork and execve\n",
+    "                     blacklisting *fork and execve\n" \
+    "                use 'resourcecontrol' to disable process affinity and schedular priority\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -sandbox @var{arg}[,obsolete=@var{string}][,elevateprivileges=@var{string}][,spawn=@var{string}]
+@item -sandbox @var{arg}[,obsolete=@var{string}][,elevateprivileges=@var{string}][,spawn=@var{string}][,resourcecontrol=@var{string}]
 @findex -sandbox
 Enable Seccomp mode 2 system call filter. 'on' will enable syscall filtering and 'off' will
 disable it.  The default is 'off'.
@@ -4042,6 +4043,8 @@ Enable Obsolete system calls
 Disable set*uid|gid system calls
 @item spawn=@var{string}
 Disable *fork and execve
+@item resourcecontrol=@var{string}
+Disable process affinity and schedular priority
 @end table
 ETEXI
 
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 51754ace71..ae787a4312 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -71,6 +71,17 @@ static const struct QemuSeccompSyscall blacklist[] = {
     { SCMP_SYS(fork),                  8, QEMU_SECCOMP_SET_SPAWN },
     { SCMP_SYS(vfork),                 8, QEMU_SECCOMP_SET_SPAWN },
     { SCMP_SYS(execve),                8, QEMU_SECCOMP_SET_SPAWN },
+    /* resource control */
+    { SCMP_SYS(getpriority),           16, QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(setpriority),           16, QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(sched_setparam),        16, QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(sched_getparam),        16, QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(sched_setscheduler),    16, QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(sched_getscheduler),    16, QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(sched_setaffinity),     16, QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(sched_getaffinity),     16, QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(sched_get_priority_max),16, QEMU_SECCOMP_SET_RESOURCECTL },
+    { SCMP_SYS(sched_get_priority_min),16, QEMU_SECCOMP_SET_RESOURCECTL },
 };
 
 
@@ -112,6 +123,14 @@ int seccomp_start(uint32_t seccomp_opts)
             }
 
             break;
+        case QEMU_SECCOMP_SET_RESOURCECTL:
+            if (seccomp_opts & QEMU_SECCOMP_SET_RESOURCECTL) {
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
index 8e6b252f8f..563e7206ac 100644
--- a/vl.c
+++ b/vl.c
@@ -284,6 +284,10 @@ static QemuOptsList qemu_sandbox_opts = {
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
@@ -1095,6 +1099,18 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
             }
         }
 
+        value = qemu_opt_get(opts, "resourcecontrol");
+        if (value) {
+            if (strcmp(value, "deny") == 0) {
+                seccomp_opts |= QEMU_SECCOMP_SET_RESOURCECTL;
+            } else if (strcmp(value, "allow") == 0) {
+                /* default value */
+            } else {
+		error_report("invalid argument for resourcecontrol");
+		return -1;
+	    }
+        }
+
         if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
-- 
2.13.5

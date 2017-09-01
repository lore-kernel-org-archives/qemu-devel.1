Received: from eggs.gnu.org ([2001:4830:134:3::10]:51251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjey-00008G-Rj
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjet-0001DD-QU
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dnjet-0001Cz-IH
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 854967E456
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 10:58:42 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri,  1 Sep 2017 12:58:14 +0200
Message-Id: <20170901105818.31956-3-otubo@redhat.com>
In-Reply-To: <20170901105818.31956-1-otubo@redhat.com>
References: <20170901105818.31956-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCHv4 2/6] seccomp: add obsolete argument to
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

This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
option. It allows Qemu to run safely on old system that still relies on
old system calls.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 include/sysemu/seccomp.h |  3 ++-
 qemu-options.hx          | 12 ++++++++++--
 qemu-seccomp.c           | 23 ++++++++++++++++++++++-
 vl.c                     | 22 +++++++++++++++++++++-
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index 23b9c3c789..215138a372 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -16,8 +16,9 @@
 #define QEMU_SECCOMP_H
 
 #define QEMU_SECCOMP_SET_DEFAULT     (1 << 0)
+#define QEMU_SECCOMP_SET_OBSOLETE    (1 << 1)
 
 #include <seccomp.h>
 
-int seccomp_start(void);
+int seccomp_start(uint32_t seccomp_opts);
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 9f6e2adfff..72150c6b84 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4017,13 +4017,21 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox <arg>  Enable seccomp mode 2 system call filter (default 'off').\n",
+    "-sandbox on[,obsolete=allow|deny]\n" \
+    "                Enable seccomp mode 2 system call filter (default 'off').\n" \
+    "                use 'obsolete' to allow obsolete system calls that are provided\n" \
+    "                    by the kernel, but typically no longer used by modern\n" \
+    "                    C library implementations.\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -sandbox @var{arg}
+@item -sandbox @var{arg}[,obsolete=@var{string}]
 @findex -sandbox
 Enable Seccomp mode 2 system call filter. 'on' will enable syscall filtering and 'off' will
 disable it.  The default is 'off'.
+@table @option
+@item obsolete=@var{string}
+Enable Obsolete system calls
+@end table
 ETEXI
 
 DEF("readconfig", HAS_ARG, QEMU_OPTION_readconfig,
diff --git a/qemu-seccomp.c b/qemu-seccomp.c
index 585de42a97..3e3f15cc08 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -56,9 +56,22 @@ static const struct QemuSeccompSyscall blacklist[] = {
     { SCMP_SYS(tuxcall),               1, QEMU_SECCOMP_SET_DEFAULT },
     { SCMP_SYS(ulimit),                1, QEMU_SECCOMP_SET_DEFAULT },
     { SCMP_SYS(vserver),               1, QEMU_SECCOMP_SET_DEFAULT },
+    /* obsolete */
+    { SCMP_SYS(readdir),               2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(_sysctl),               2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(bdflush),               2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(create_module),         2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(get_kernel_syms),       2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(query_module),          2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(sgetmask),              2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(ssetmask),              2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(sysfs),                 2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(uselib),                2, QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(ustat),                 2, QEMU_SECCOMP_SET_OBSOLETE },
 };
 
-int seccomp_start(void)
+
+int seccomp_start(uint32_t seccomp_opts)
 {
     int rc = 0;
     unsigned int i = 0;
@@ -72,6 +85,14 @@ int seccomp_start(void)
 
     for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
         switch (blacklist[i].set) {
+        case QEMU_SECCOMP_SET_OBSOLETE:
+            if (!(seccomp_opts & QEMU_SECCOMP_SET_OBSOLETE)) {
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
index 305531aba8..ca267f9918 100644
--- a/vl.c
+++ b/vl.c
@@ -271,6 +271,10 @@ static QemuOptsList qemu_sandbox_opts = {
             .name = "enable",
             .type = QEMU_OPT_BOOL,
         },
+        {
+            .name = "obsolete",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -1032,7 +1036,23 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
 {
     if (qemu_opt_get_bool(opts, "enable", false)) {
 #ifdef CONFIG_SECCOMP
-        if (seccomp_start() < 0) {
+        uint32_t seccomp_opts = 0x00000;
+        const char *value = NULL;
+
+        value = qemu_opt_get(opts, "obsolete");
+        if (value) {
+            if (strcmp(value, "allow") == 0) {
+                seccomp_opts |= QEMU_SECCOMP_SET_OBSOLETE;
+            } else if (strcmp(value, "deny")) {
+                /* this is the default option, this if is here
+		 * to provide a little bit of consistency for
+		 * the command line */
+	    } else {
+		error_report("invalid argument for obsolete");
+	    }
+        }
+
+        if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
             return -1;
-- 
2.13.5

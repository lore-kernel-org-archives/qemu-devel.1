Received: from eggs.gnu.org ([2001:4830:134:3::10]:38808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmCV-0000Ug-0G
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dsmCT-00033o-TV
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dsmCT-00031y-Gl
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:42:13 -0400
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 15 Sep 2017 10:41:35 +0200
Message-Id: <20170915084139.4481-3-otubo@redhat.com>
In-Reply-To: <20170915084139.4481-1-otubo@redhat.com>
References: <20170915084139.4481-1-otubo@redhat.com>
Subject: [Qemu-devel] [PULL 02/06] seccomp: add obsolete argument to command
 line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
option. It allows Qemu to run safely on old system that still relies on
old system calls.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/sysemu/seccomp.h |  3 ++-
 qemu-options.hx          | 12 ++++++++++--
 qemu-seccomp.c           | 19 ++++++++++++++++++-
 vl.c                     | 24 +++++++++++++++++++++++-
 4 files changed, 53 insertions(+), 5 deletions(-)

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
index f66613fc71..8a5fbd2ff1 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -55,9 +55,22 @@ static const struct QemuSeccompSyscall blacklist[] = {
     { SCMP_SYS(tuxcall),                QEMU_SECCOMP_SET_DEFAULT },
     { SCMP_SYS(ulimit),                 QEMU_SECCOMP_SET_DEFAULT },
     { SCMP_SYS(vserver),                QEMU_SECCOMP_SET_DEFAULT },
+    /* obsolete */
+    { SCMP_SYS(readdir),                QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(_sysctl),                QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(bdflush),                QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(create_module),          QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(get_kernel_syms),        QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(query_module),           QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(sgetmask),               QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(ssetmask),               QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(sysfs),                  QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(uselib),                 QEMU_SECCOMP_SET_OBSOLETE },
+    { SCMP_SYS(ustat),                  QEMU_SECCOMP_SET_OBSOLETE },
 };
 
-int seccomp_start(void)
+
+int seccomp_start(uint32_t seccomp_opts)
 {
     int rc = 0;
     unsigned int i = 0;
@@ -70,6 +83,10 @@ int seccomp_start(void)
     }
 
     for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
+        if (!(seccomp_opts & blacklist[i].set)) {
+            continue;
+        }
+
         rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0);
         if (rc < 0) {
             goto seccomp_return;
diff --git a/vl.c b/vl.c
index 76e0b3a946..57c5e93c1a 100644
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
@@ -1034,7 +1038,25 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
 {
     if (qemu_opt_get_bool(opts, "enable", false)) {
 #ifdef CONFIG_SECCOMP
-        if (seccomp_start() < 0) {
+        uint32_t seccomp_opts = QEMU_SECCOMP_SET_DEFAULT
+                | QEMU_SECCOMP_SET_OBSOLETE;
+        const char *value = NULL;
+
+        value = qemu_opt_get(opts, "obsolete");
+        if (value) {
+            if (g_str_equal(value, "allow")) {
+                seccomp_opts &= ~QEMU_SECCOMP_SET_OBSOLETE;
+            } else if (g_str_equal(value, "deny")) {
+                /* this is the default option, this if is here
+                 * to provide a little bit of consistency for
+                 * the command line */
+            } else {
+                error_report("invalid argument for obsolete");
+                return -1;
+            }
+        }
+
+        if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
             return -1;
-- 
2.13.5

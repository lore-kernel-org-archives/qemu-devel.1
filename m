Received: from eggs.gnu.org ([2001:4830:134:3::10]:35134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dVyuL-00085f-JD
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dVyuI-0006nj-P7
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:37:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dVyuI-0006n3-Fk
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:37:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D7BC2DE3F
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 11:37:13 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 14 Jul 2017 13:36:56 +0200
Message-Id: <20170714113700.21319-3-otubo@redhat.com>
In-Reply-To: <20170714113700.21319-1-otubo@redhat.com>
References: <20170714113700.21319-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] seccomp: add obsolete argument to command
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
Cc: Eduardo Otubo <otubo@redhat.com>

This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
option. It allows Qemu to run safely on old system that still relies on
old system calls.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 include/sysemu/seccomp.h |  4 +++-
 qemu-options.hx          |  9 +++++++--
 qemu-seccomp.c           | 32 +++++++++++++++++++++++++++++++-
 vl.c                     | 16 +++++++++++++++-
 4 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
index cfc06008cb..7a7bde246b 100644
--- a/include/sysemu/seccomp.h
+++ b/include/sysemu/seccomp.h
@@ -15,7 +15,9 @@
 #ifndef QEMU_SECCOMP_H
 #define QEMU_SECCOMP_H
 
+#define OBSOLETE    0x0001
+
 #include <seccomp.h>
 
-int seccomp_start(void);
+int seccomp_start(uint8_t seccomp_opts);
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 2cc70b9cfc..c3200f303b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4004,13 +4004,18 @@ Old param mode (ARM only).
 ETEXI
 
 DEF("sandbox", HAS_ARG, QEMU_OPTION_sandbox, \
-    "-sandbox <arg>  Enable seccomp mode 2 system call filter (default 'off').\n",
+    "-sandbox on[,obsolete=allow]  Enable seccomp mode 2 system call filter (default 'off').\n" \
+    "                              obsolete: Allow obsolete system calls",
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
index f8877b07b5..c6a8b28260 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -31,6 +31,20 @@ struct QemuSeccompSyscall {
     uint8_t priority;
 };
 
+static const struct QemuSeccompSyscall obsolete[] = {
+    { SCMP_SYS(readdir), 255 },
+    { SCMP_SYS(_sysctl), 255 },
+    { SCMP_SYS(bdflush), 255 },
+    { SCMP_SYS(create_module), 255 },
+    { SCMP_SYS(get_kernel_syms), 255 },
+    { SCMP_SYS(query_module), 255 },
+    { SCMP_SYS(sgetmask), 255 },
+    { SCMP_SYS(ssetmask), 255 },
+    { SCMP_SYS(sysfs), 255 },
+    { SCMP_SYS(uselib), 255 },
+    { SCMP_SYS(ustat), 255 },
+};
+
 static const struct QemuSeccompSyscall blacklist[] = {
     { SCMP_SYS(reboot), 255 },
     { SCMP_SYS(swapon), 255 },
@@ -56,7 +70,20 @@ static const struct QemuSeccompSyscall blacklist[] = {
     { SCMP_SYS(vserver), 255 },
 };
 
-int seccomp_start(void)
+static int is_obsolete(int syscall)
+{
+    unsigned int i = 0;
+
+    for (i = 0; i < ARRAY_SIZE(obsolete); i++) {
+        if (syscall == obsolete[i].num) {
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+int seccomp_start(uint8_t seccomp_opts)
 {
     int rc = 0;
     unsigned int i = 0;
@@ -69,6 +96,9 @@ int seccomp_start(void)
     }
 
     for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
+        if ((seccomp_opts & OBSOLETE) && is_obsolete(blacklist[i].num)) {
+            continue;
+        }
         rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0);
         if (rc < 0) {
             goto seccomp_return;
diff --git a/vl.c b/vl.c
index 838ad3b11a..6a297851aa 100644
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
@@ -1032,7 +1036,17 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
 {
     if (qemu_opt_get_bool(opts, "enable", false)) {
 #ifdef CONFIG_SECCOMP
-        if (seccomp_start() < 0) {
+        uint8_t seccomp_opts = 0x0000;
+        const char * value = NULL;
+
+        value = qemu_opt_get(opts,"obsolete");
+        if (value) {
+            if (strcmp(value, "allow") == 0) {
+                seccomp_opts |= OBSOLETE;
+            }
+        }
+
+        if (seccomp_start(seccomp_opts) < 0) {
             error_report("failed to install seccomp syscall filter "
                          "in the kernel");
             return -1;
-- 
2.13.0

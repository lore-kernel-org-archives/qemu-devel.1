Received: from eggs.gnu.org ([2001:4830:134:3::10]:52941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkgZ-0000i3-8C
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkgX-00084A-QM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:15 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cnkgX-00083M-GM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:13 -0400
Received: by mail-wm0-x232.google.com with SMTP id v186so61502170wmd.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 04:32:13 -0700 (PDT)
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Date: Tue, 14 Mar 2017 12:32:06 +0100
Message-Id: <20170314113209.12025-3-eduardo.otubo@profitbricks.com>
In-Reply-To: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
References: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
Subject: [Qemu-devel] [PATCH 2/5] seccomp: add obsolete argument to command
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
Cc: berrange@redhat.com, thuth@redhat.com

This patch introduces the argument [,obsolete=allow] to the `-sandbox on'
option. It allows Qemu to run safely on old system that still relies on
old system calls.

Signed-off-by: Eduardo Otubo <eduardo.otubo@profitbricks.com>
---
 include/sysemu/seccomp.h |  4 +++-
 qemu-options.hx          |  9 +++++++--
 qemu-seccomp.c           | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 vl.c                     | 16 +++++++++++++++-
 4 files changed, 71 insertions(+), 5 deletions(-)

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
index 8dd8ee34a6..1403d0c85f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3732,13 +3732,18 @@ Old param mode (ARM only).
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
index f8877b07b5..5ef36890da 100644
--- a/qemu-seccomp.c
+++ b/qemu-seccomp.c
@@ -31,6 +31,35 @@ struct QemuSeccompSyscall {
     uint8_t priority;
 };
 
+static const struct QemuSeccompSyscall obsolete[] = {
+    { SCMP_SYS(readdir), 255 },
+    { SCMP_SYS(_sysctl), 255 },
+    { SCMP_SYS(afs_syscall), 255 },
+    { SCMP_SYS(bdflush), 255 },
+    { SCMP_SYS(break), 255 },
+    { SCMP_SYS(create_module), 255 },
+    { SCMP_SYS(ftime), 255 },
+    { SCMP_SYS(get_kernel_syms), 255 },
+    { SCMP_SYS(getpmsg), 255 },
+    { SCMP_SYS(gtty), 255 },
+    { SCMP_SYS(lock), 255 },
+    { SCMP_SYS(mpx), 255 },
+    { SCMP_SYS(prof), 255 },
+    { SCMP_SYS(profil), 255 },
+    { SCMP_SYS(putpmsg), 255 },
+    { SCMP_SYS(query_module), 255 },
+    { SCMP_SYS(security), 255 },
+    { SCMP_SYS(sgetmask), 255 },
+    { SCMP_SYS(ssetmask), 255 },
+    { SCMP_SYS(stty), 255 },
+    { SCMP_SYS(sysfs), 255 },
+    { SCMP_SYS(tuxcall), 255 },
+    { SCMP_SYS(ulimit), 255 },
+    { SCMP_SYS(uselib), 255 },
+    { SCMP_SYS(ustat), 255 },
+    { SCMP_SYS(vserver), 255 },
+};
+
 static const struct QemuSeccompSyscall blacklist[] = {
     { SCMP_SYS(reboot), 255 },
     { SCMP_SYS(swapon), 255 },
@@ -56,7 +85,20 @@ static const struct QemuSeccompSyscall blacklist[] = {
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
@@ -69,6 +111,9 @@ int seccomp_start(void)
     }
 
     for (i = 0; i < ARRAY_SIZE(blacklist); i++) {
+        if ((seccomp_opts & OBSOLETE) && is_obsolete(blacklist[i].num)) {
+            continue;
+        }
         rc = seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0);
         if (rc < 0) {
             goto seccomp_return;
diff --git a/vl.c b/vl.c
index 1a95500ac7..7b08b3383b 100644
--- a/vl.c
+++ b/vl.c
@@ -269,6 +269,10 @@ static QemuOptsList qemu_sandbox_opts = {
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
@@ -1031,7 +1035,17 @@ static int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
     /* FIXME: change this to true for 1.3 */
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
2.11.0

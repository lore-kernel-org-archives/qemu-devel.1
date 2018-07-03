Received: from eggs.gnu.org ([2001:4830:134:3::10]:41265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIz-0008QK-Kc
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIu-0000xh-K6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60146)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIu-0000xD-55
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:40 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnERk088367
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:39 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dpa6kec-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:38 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:38 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:17 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180703205221.24788-11-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 10/14] qga: bios_supports_mode: decoupling
 pm-utils and sys logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Daniel Henrique Barboza <danielhb413@gmail.com>

From: Daniel Henrique Barboza <danielhb413@gmail.com>

In bios_supports_mode there is a verification to assert if
the chosen suspend mode is supported by the pmutils tools and,
if not, we see if the Linux sys state files supports it.

This verification is done in the same function, one after
the other, and it works for now. But, when adding a new
suspend mechanism that will not necessarily follow the same
return 0 or 1 logic of pmutils, this code will be hard
to deal with.

This patch decouple the two existing logics into their own
functions, pmutils_supports_mode and linux_sys_state_supports_mode,
which in turn are used inside bios_support_mode. The existing
logic is kept but now it's easier to extend it.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 116 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 68 insertions(+), 48 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index bd2c3514d8..a8299ecc77 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1478,75 +1478,43 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 #define SUSPEND_MODE_RAM 2
 #define SUSPEND_MODE_HYBRID 3
 
-static void bios_supports_mode(int suspend_mode, Error **errp)
+static bool pmutils_supports_mode(int suspend_mode, Error **errp)
 {
     Error *local_err = NULL;
-    const char *pmutils_arg, *sysfile_str;
+    const char *pmutils_arg;
     const char *pmutils_bin = "pm-is-supported";
     char *pmutils_path;
     pid_t pid;
     int status;
+    bool ret = false;
 
     switch (suspend_mode) {
 
     case SUSPEND_MODE_DISK:
         pmutils_arg = "--hibernate";
-        sysfile_str = "disk";
         break;
     case SUSPEND_MODE_RAM:
         pmutils_arg = "--suspend";
-        sysfile_str = "mem";
         break;
     case SUSPEND_MODE_HYBRID:
         pmutils_arg = "--suspend-hybrid";
-        sysfile_str = NULL;
         break;
     default:
-        error_setg(errp, "guest suspend mode not supported");
-        return;
+        return ret;
     }
 
     pmutils_path = g_find_program_in_path(pmutils_bin);
+    if (!pmutils_path) {
+        return ret;
+    }
 
     pid = fork();
     if (!pid) {
-        char buf[32]; /* hopefully big enough */
-        ssize_t ret;
-        int fd;
-
         setsid();
-        reopen_fd_to_null(0);
-        reopen_fd_to_null(1);
-        reopen_fd_to_null(2);
-
-        if (pmutils_path) {
-            execle(pmutils_path, pmutils_bin, pmutils_arg, NULL, environ);
-        }
-
+        execle(pmutils_path, pmutils_bin, pmutils_arg, NULL, environ);
         /*
-         * If we get here either pm-utils is not installed or execle() has
-         * failed. Let's try the manual method if the caller wants it.
+         * If we get here execle() has failed.
          */
-
-        if (!sysfile_str) {
-            _exit(SUSPEND_NOT_SUPPORTED);
-        }
-
-        fd = open(LINUX_SYS_STATE_FILE, O_RDONLY);
-        if (fd < 0) {
-            _exit(SUSPEND_NOT_SUPPORTED);
-        }
-
-        ret = read(fd, buf, sizeof(buf)-1);
-        if (ret <= 0) {
-            _exit(SUSPEND_NOT_SUPPORTED);
-        }
-        buf[ret] = '\0';
-
-        if (strstr(buf, sysfile_str)) {
-            _exit(SUSPEND_SUPPORTED);
-        }
-
         _exit(SUSPEND_NOT_SUPPORTED);
     } else if (pid < 0) {
         error_setg_errno(errp, errno, "failed to create child process");
@@ -1559,17 +1527,11 @@ static void bios_supports_mode(int suspend_mode, Error **errp)
         goto out;
     }
 
-    if (!WIFEXITED(status)) {
-        error_setg(errp, "child process has terminated abnormally");
-        goto out;
-    }
-
     switch (WEXITSTATUS(status)) {
     case SUSPEND_SUPPORTED:
+        ret = true;
         goto out;
     case SUSPEND_NOT_SUPPORTED:
-        error_setg(errp,
-                   "the requested suspend mode is not supported by the guest");
         goto out;
     default:
         error_setg(errp,
@@ -1580,6 +1542,64 @@ static void bios_supports_mode(int suspend_mode, Error **errp)
 
 out:
     g_free(pmutils_path);
+    return ret;
+}
+
+static bool linux_sys_state_supports_mode(int suspend_mode, Error **errp)
+{
+    const char *sysfile_str;
+    char buf[32]; /* hopefully big enough */
+    int fd;
+    ssize_t ret;
+
+    switch (suspend_mode) {
+
+    case SUSPEND_MODE_DISK:
+        sysfile_str = "disk";
+        break;
+    case SUSPEND_MODE_RAM:
+        sysfile_str = "mem";
+        break;
+    default:
+        return false;
+    }
+
+    fd = open(LINUX_SYS_STATE_FILE, O_RDONLY);
+    if (fd < 0) {
+        return false;
+    }
+
+    ret = read(fd, buf, sizeof(buf) - 1);
+    if (ret <= 0) {
+        return false;
+    }
+    buf[ret] = '\0';
+
+    if (strstr(buf, sysfile_str)) {
+        return true;
+    }
+    return false;
+}
+
+static void bios_supports_mode(int suspend_mode, Error **errp)
+{
+    Error *local_err = NULL;
+    bool ret;
+
+    ret = pmutils_supports_mode(suspend_mode, &local_err);
+    if (ret) {
+        return;
+    }
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    ret = linux_sys_state_supports_mode(suspend_mode, errp);
+    if (!ret) {
+        error_setg(errp,
+                   "the requested suspend mode is not supported by the guest");
+        return;
+    }
 }
 
 static void guest_suspend(int suspend_mode, Error **errp)
-- 
2.11.0

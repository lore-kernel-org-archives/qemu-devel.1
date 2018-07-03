Received: from eggs.gnu.org ([2001:4830:134:3::10]:41257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIz-0008QH-IC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIu-0000xo-Ma
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45562
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIu-0000xH-FZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnBfL041238
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:39 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dp9pbym-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:39 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:38 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:18 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180703205221.24788-12-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 11/14] qga: guest_suspend: decoupling pm-utils
 and sys logic
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

Following the same logic of the previous patch, let's also
decouple the suspend logic from guest_suspend into specialized
functions, one for each strategy we support at this moment.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 170 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 108 insertions(+), 62 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index a8299ecc77..9ebd77b894 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1545,6 +1545,65 @@ out:
     return ret;
 }
 
+static void pmutils_suspend(int suspend_mode, Error **errp)
+{
+    Error *local_err = NULL;
+    const char *pmutils_bin;
+    char *pmutils_path;
+    pid_t pid;
+    int status;
+
+    switch (suspend_mode) {
+
+    case SUSPEND_MODE_DISK:
+        pmutils_bin = "pm-hibernate";
+        break;
+    case SUSPEND_MODE_RAM:
+        pmutils_bin = "pm-suspend";
+        break;
+    case SUSPEND_MODE_HYBRID:
+        pmutils_bin = "pm-suspend-hybrid";
+        break;
+    default:
+        error_setg(errp, "unknown guest suspend mode");
+        return;
+    }
+
+    pmutils_path = g_find_program_in_path(pmutils_bin);
+    if (!pmutils_path) {
+        error_setg(errp, "the helper program '%s' was not found", pmutils_bin);
+        return;
+    }
+
+    pid = fork();
+    if (!pid) {
+        setsid();
+        execle(pmutils_path, pmutils_bin, NULL, environ);
+        /*
+         * If we get here execle() has failed.
+         */
+        _exit(EXIT_FAILURE);
+    } else if (pid < 0) {
+        error_setg_errno(errp, errno, "failed to create child process");
+        goto out;
+    }
+
+    ga_wait_child(pid, &status, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+    if (WEXITSTATUS(status)) {
+        error_setg(errp,
+                   "the helper program '%s' returned an unexpected exit status"
+                   " code (%d)", pmutils_path, WEXITSTATUS(status));
+    }
+
+out:
+    g_free(pmutils_path);
+}
+
 static bool linux_sys_state_supports_mode(int suspend_mode, Error **errp)
 {
     const char *sysfile_str;
@@ -1581,64 +1640,28 @@ static bool linux_sys_state_supports_mode(int suspend_mode, Error **errp)
     return false;
 }
 
-static void bios_supports_mode(int suspend_mode, Error **errp)
-{
-    Error *local_err = NULL;
-    bool ret;
-
-    ret = pmutils_supports_mode(suspend_mode, &local_err);
-    if (ret) {
-        return;
-    }
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-    ret = linux_sys_state_supports_mode(suspend_mode, errp);
-    if (!ret) {
-        error_setg(errp,
-                   "the requested suspend mode is not supported by the guest");
-        return;
-    }
-}
-
-static void guest_suspend(int suspend_mode, Error **errp)
+static void linux_sys_state_suspend(int suspend_mode, Error **errp)
 {
     Error *local_err = NULL;
-    const char *pmutils_bin, *sysfile_str;
-    char *pmutils_path;
+    const char *sysfile_str;
     pid_t pid;
     int status;
 
-    bios_supports_mode(suspend_mode, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
     switch (suspend_mode) {
 
     case SUSPEND_MODE_DISK:
-        pmutils_bin = "pm-hibernate";
         sysfile_str = "disk";
         break;
     case SUSPEND_MODE_RAM:
-        pmutils_bin = "pm-suspend";
         sysfile_str = "mem";
         break;
-    case SUSPEND_MODE_HYBRID:
-        pmutils_bin = "pm-suspend-hybrid";
-        sysfile_str = NULL;
-        break;
     default:
         error_setg(errp, "unknown guest suspend mode");
         return;
     }
 
-    pmutils_path = g_find_program_in_path(pmutils_bin);
-
     pid = fork();
-    if (pid == 0) {
+    if (!pid) {
         /* child */
         int fd;
 
@@ -1647,19 +1670,6 @@ static void guest_suspend(int suspend_mode, Error **errp)
         reopen_fd_to_null(1);
         reopen_fd_to_null(2);
 
-        if (pmutils_path) {
-            execle(pmutils_path, pmutils_bin, NULL, environ);
-        }
-
-        /*
-         * If we get here either pm-utils is not installed or execle() has
-         * failed. Let's try the manual method if the caller wants it.
-         */
-
-        if (!sysfile_str) {
-            _exit(EXIT_FAILURE);
-        }
-
         fd = open(LINUX_SYS_STATE_FILE, O_WRONLY);
         if (fd < 0) {
             _exit(EXIT_FAILURE);
@@ -1672,27 +1682,63 @@ static void guest_suspend(int suspend_mode, Error **errp)
         _exit(EXIT_SUCCESS);
     } else if (pid < 0) {
         error_setg_errno(errp, errno, "failed to create child process");
-        goto out;
+        return;
     }
 
     ga_wait_child(pid, &status, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out;
-    }
-
-    if (!WIFEXITED(status)) {
-        error_setg(errp, "child process has terminated abnormally");
-        goto out;
+        return;
     }
 
     if (WEXITSTATUS(status)) {
         error_setg(errp, "child process has failed to suspend");
-        goto out;
     }
 
-out:
-    g_free(pmutils_path);
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
+}
+
+static void guest_suspend(int suspend_mode, Error **errp)
+{
+    Error *local_err = NULL;
+
+    bios_supports_mode(suspend_mode, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    pmutils_suspend(suspend_mode, &local_err);
+    if (!local_err) {
+        return;
+    }
+
+    error_free(local_err);
+
+    linux_sys_state_suspend(suspend_mode, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
 }
 
 void qmp_guest_suspend_disk(Error **errp)
-- 
2.11.0

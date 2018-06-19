Received: from eggs.gnu.org ([2001:4830:134:3::10]:52818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVMSd-0001mk-3q
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVMSb-00031b-Us
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:39 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:44707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fVMSb-00031F-PB
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:37 -0400
Received: by mail-qt0-x242.google.com with SMTP id l33-v6so854218qta.11
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 12:38:37 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 19 Jun 2018 16:38:03 -0300
Message-Id: <20180619193806.17419-4-danielhb413@gmail.com>
In-Reply-To: <20180619193806.17419-1-danielhb413@gmail.com>
References: <20180619193806.17419-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v1 3/6] qga: guest_suspend: decoupling pm-utils
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
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com, Daniel Henrique Barboza <danielhb413@gmail.com>

Following the same logic of the previous patch, let's also
decouple the suspend logic from guest_suspend into specialized
functions, one for each strategy we support at this moment.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 qga/commands-posix.c | 170 +++++++++++++++++++++++++++----------------
 1 file changed, 108 insertions(+), 62 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 89ffd8dc88..a2870f9ab9 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1509,6 +1509,65 @@ out:
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
@@ -1545,64 +1604,28 @@ static bool linux_sys_state_supports_mode(int suspend_mode, Error **errp)
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
 
@@ -1611,19 +1634,6 @@ static void guest_suspend(int suspend_mode, Error **errp)
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
@@ -1636,27 +1646,63 @@ static void guest_suspend(int suspend_mode, Error **errp)
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
+    local_err = NULL;
+
+    linux_sys_state_suspend(suspend_mode, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+    }
 }
 
 void qmp_guest_suspend_disk(Error **errp)
-- 
2.17.1

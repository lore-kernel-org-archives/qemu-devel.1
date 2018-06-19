Received: from eggs.gnu.org ([2001:4830:134:3::10]:52851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVMSf-0001pF-UW
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVMSe-00033R-Gn
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:41 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:45390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fVMSe-00032r-BH
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 15:38:40 -0400
Received: by mail-qt0-x22b.google.com with SMTP id i18-v6so851829qtp.12
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 12:38:40 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 19 Jun 2018 16:38:04 -0300
Message-Id: <20180619193806.17419-5-danielhb413@gmail.com>
In-Reply-To: <20180619193806.17419-1-danielhb413@gmail.com>
References: <20180619193806.17419-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v1 4/6] qga: removing switch statements,
 adding run_process_child
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

This is a cleanup of the resulting code after detaching
pmutils and Linux sys state file logic:

- remove the SUSPEND_MODE_* macros and use an enumeration
instead. At the same time, drop the switch statements
at the start of each function and use the enumeration
index to get the right binary/argument;

- create a new function called run_process_child(). This
function creates a child process and executes a (shell)
command, returning the command return code. This is a common
operation in the pmutils functions and will be used in the
systemd implementation as well, so this function will avoid
code repetition.

There are more places inside commands-posix.c where this new
run_process_child function can also be used, but one step
at a time.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 qga/commands-posix.c | 190 +++++++++++++++++--------------------------
 1 file changed, 76 insertions(+), 114 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index a2870f9ab9..d5e3805ce9 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1438,152 +1438,122 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 #define LINUX_SYS_STATE_FILE "/sys/power/state"
 #define SUSPEND_SUPPORTED 0
 #define SUSPEND_NOT_SUPPORTED 1
-#define SUSPEND_MODE_DISK 1
-#define SUSPEND_MODE_RAM 2
-#define SUSPEND_MODE_HYBRID 3
 
-static bool pmutils_supports_mode(int suspend_mode, Error **errp)
+typedef enum {
+    SUSPEND_MODE_DISK = 0,
+    SUSPEND_MODE_RAM = 1,
+    SUSPEND_MODE_HYBRID = 2,
+} SuspendMode;
+
+static int run_process_child(const char *command[], Error **errp)
 {
     Error *local_err = NULL;
-    const char *pmutils_arg;
-    const char *pmutils_bin = "pm-is-supported";
-    char *pmutils_path;
+    char *cmd_path = g_find_program_in_path(command[0]);
     pid_t pid;
-    int status;
-    bool ret = false;
-
-    switch (suspend_mode) {
-
-    case SUSPEND_MODE_DISK:
-        pmutils_arg = "--hibernate";
-        break;
-    case SUSPEND_MODE_RAM:
-        pmutils_arg = "--suspend";
-        break;
-    case SUSPEND_MODE_HYBRID:
-        pmutils_arg = "--suspend-hybrid";
-        break;
-    default:
-        return ret;
-    }
+    int status, ret = -1;
 
-    pmutils_path = g_find_program_in_path(pmutils_bin);
-    if (!pmutils_path) {
+    if (!cmd_path) {
         return ret;
     }
 
     pid = fork();
     if (!pid) {
         setsid();
-        execle(pmutils_path, pmutils_bin, pmutils_arg, NULL, environ);
         /*
-         * If we get here execle() has failed.
+         * execve receives a char* const argv[] as second arg but we're
+         * receiving a const char*[]. Since execve does not change the
+         * array contents it's tolerable to cast here.
          */
-        _exit(SUSPEND_NOT_SUPPORTED);
+        execve(cmd_path, (char* const*)command, environ);
+        _exit(errno);
     } else if (pid < 0) {
         error_setg_errno(errp, errno, "failed to create child process");
+        ret = EXIT_FAILURE;
         goto out;
     }
 
     ga_wait_child(pid, &status, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
+        ret = EXIT_FAILURE;
         goto out;
     }
 
-    switch (WEXITSTATUS(status)) {
-    case SUSPEND_SUPPORTED:
-        ret = true;
-        goto out;
-    case SUSPEND_NOT_SUPPORTED:
-        goto out;
-    default:
-        error_setg(errp,
-                   "the helper program '%s' returned an unexpected exit status"
-                   " code (%d)", pmutils_path, WEXITSTATUS(status));
-        goto out;
-    }
+    ret = WEXITSTATUS(status);
 
 out:
-    g_free(pmutils_path);
+    g_free(cmd_path);
     return ret;
 }
 
-static void pmutils_suspend(int suspend_mode, Error **errp)
+static bool pmutils_supports_mode(SuspendMode mode, Error **errp)
 {
     Error *local_err = NULL;
-    const char *pmutils_bin;
-    char *pmutils_path;
-    pid_t pid;
+    const char *pmutils_args[3] = {"--hibernate", "--suspend",
+                                   "--suspend-hybrid"};
+    const char *cmd[3] = {"pm-is-supported", pmutils_args[mode], NULL};
     int status;
 
-    switch (suspend_mode) {
-
-    case SUSPEND_MODE_DISK:
-        pmutils_bin = "pm-hibernate";
-        break;
-    case SUSPEND_MODE_RAM:
-        pmutils_bin = "pm-suspend";
-        break;
-    case SUSPEND_MODE_HYBRID:
-        pmutils_bin = "pm-suspend-hybrid";
-        break;
-    default:
-        error_setg(errp, "unknown guest suspend mode");
-        return;
-    }
+    status = run_process_child(cmd, &local_err);
 
-    pmutils_path = g_find_program_in_path(pmutils_bin);
-    if (!pmutils_path) {
-        error_setg(errp, "the helper program '%s' was not found", pmutils_bin);
-        return;
+    if (status == SUSPEND_SUPPORTED) {
+        return true;
     }
 
-    pid = fork();
-    if (!pid) {
-        setsid();
-        execle(pmutils_path, pmutils_bin, NULL, environ);
-        /*
-         * If we get here execle() has failed.
-         */
-        _exit(EXIT_FAILURE);
-    } else if (pid < 0) {
-        error_setg_errno(errp, errno, "failed to create child process");
-        goto out;
+    if (status == -1) {
+        return false;
     }
 
-    ga_wait_child(pid, &status, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out;
+    } else {
+        error_setg(errp,
+                   "the helper program '%s' returned an unexpected exit"
+                   " status code (%d)", "pm-is-supported", status);
     }
 
-    if (WEXITSTATUS(status)) {
-        error_setg(errp,
-                   "the helper program '%s' returned an unexpected exit status"
-                   " code (%d)", pmutils_path, WEXITSTATUS(status));
+    return false;
+}
+
+static void pmutils_suspend(SuspendMode mode, Error **errp)
+{
+    Error *local_err = NULL;
+    const char *pmutils_binaries[3] = {"pm-hibernate", "pm-suspend",
+                                       "pm-suspend-hybrid"};
+    const char *cmd[2] = {pmutils_binaries[mode], NULL};
+    int status;
+
+    status = run_process_child(cmd, &local_err);
+
+    if (status == 0) {
+        return;
     }
 
-out:
-    g_free(pmutils_path);
+    if (status == -1) {
+        error_setg(errp, "the helper program '%s' was not found",
+                    pmutils_binaries[mode]);
+        return;
+    }
+
+    if (local_err) {
+        error_propagate(errp, local_err);
+    } else {
+        error_setg(errp,
+                   "the helper program '%s' returned an unexpected exit"
+                   " status code (%d)", pmutils_binaries[mode], status);
+    }
 }
 
-static bool linux_sys_state_supports_mode(int suspend_mode, Error **errp)
+static bool linux_sys_state_supports_mode(SuspendMode mode, Error **errp)
 {
-    const char *sysfile_str;
+    const char *sysfile_strs[3] = {"disk", "mem", NULL};
+    const char *sysfile_str = sysfile_strs[mode];
     char buf[32]; /* hopefully big enough */
     int fd;
     ssize_t ret;
 
-    switch (suspend_mode) {
-
-    case SUSPEND_MODE_DISK:
-        sysfile_str = "disk";
-        break;
-    case SUSPEND_MODE_RAM:
-        sysfile_str = "mem";
-        break;
-    default:
+    if (!sysfile_str) {
+        error_setg(errp, "unknown guest suspend mode");
         return false;
     }
 
@@ -1604,22 +1574,15 @@ static bool linux_sys_state_supports_mode(int suspend_mode, Error **errp)
     return false;
 }
 
-static void linux_sys_state_suspend(int suspend_mode, Error **errp)
+static void linux_sys_state_suspend(SuspendMode mode, Error **errp)
 {
     Error *local_err = NULL;
-    const char *sysfile_str;
+    const char *sysfile_strs[3] = {"disk", "mem", NULL};
+    const char *sysfile_str = sysfile_strs[mode];
     pid_t pid;
     int status;
 
-    switch (suspend_mode) {
-
-    case SUSPEND_MODE_DISK:
-        sysfile_str = "disk";
-        break;
-    case SUSPEND_MODE_RAM:
-        sysfile_str = "mem";
-        break;
-    default:
+    if (!sysfile_str) {
         error_setg(errp, "unknown guest suspend mode");
         return;
     }
@@ -1661,12 +1624,12 @@ static void linux_sys_state_suspend(int suspend_mode, Error **errp)
 
 }
 
-static void bios_supports_mode(int suspend_mode, Error **errp)
+static void bios_supports_mode(SuspendMode mode, Error **errp)
 {
     Error *local_err = NULL;
     bool ret;
 
-    ret = pmutils_supports_mode(suspend_mode, &local_err);
+    ret = pmutils_supports_mode(mode, &local_err);
     if (ret) {
         return;
     }
@@ -1674,32 +1637,31 @@ static void bios_supports_mode(int suspend_mode, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
-    ret = linux_sys_state_supports_mode(suspend_mode, errp);
+    ret = linux_sys_state_supports_mode(mode, &local_err);
     if (!ret) {
         error_setg(errp,
                    "the requested suspend mode is not supported by the guest");
-        return;
     }
 }
 
-static void guest_suspend(int suspend_mode, Error **errp)
+static void guest_suspend(SuspendMode mode, Error **errp)
 {
     Error *local_err = NULL;
 
-    bios_supports_mode(suspend_mode, &local_err);
+    bios_supports_mode(mode, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
-    pmutils_suspend(suspend_mode, &local_err);
+    pmutils_suspend(mode, &local_err);
     if (!local_err) {
         return;
     }
 
     local_err = NULL;
 
-    linux_sys_state_suspend(suspend_mode, &local_err);
+    linux_sys_state_suspend(mode, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
     }
-- 
2.17.1

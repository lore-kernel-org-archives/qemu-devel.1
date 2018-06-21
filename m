Received: from eggs.gnu.org ([2001:4830:134:3::10]:53258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjH-0002lm-SB
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjG-0001ec-NT
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fVwjG-0001eS-IK
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:14 -0400
Received: by mail-qt0-x243.google.com with SMTP id e11-v6so1730310qtp.5
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 03:22:14 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 21 Jun 2018 07:21:49 -0300
Message-Id: <20180621102153.28443-3-danielhb413@gmail.com>
In-Reply-To: <20180621102153.28443-1-danielhb413@gmail.com>
References: <20180621102153.28443-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/6] qga: bios_supports_mode: decoupling
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
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, marcandre.lureau@gmail.com, Daniel Henrique Barboza <danielhb413@gmail.com>

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
---
 qga/commands-posix.c | 116 +++++++++++++++++++++++++------------------
 1 file changed, 68 insertions(+), 48 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 63c49791a4..89ffd8dc88 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1442,75 +1442,43 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
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
@@ -1523,17 +1491,11 @@ static void bios_supports_mode(int suspend_mode, Error **errp)
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
@@ -1544,6 +1506,64 @@ static void bios_supports_mode(int suspend_mode, Error **errp)
 
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
2.17.1

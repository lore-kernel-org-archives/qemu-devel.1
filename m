Received: from eggs.gnu.org ([2001:4830:134:3::10]:53246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjF-0002ka-VQ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fVwjE-0001e5-S0
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:13 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:41619)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fVwjE-0001dw-N6
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:22:12 -0400
Received: by mail-qt0-x243.google.com with SMTP id y20-v6so2308132qto.8
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 03:22:12 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 21 Jun 2018 07:21:48 -0300
Message-Id: <20180621102153.28443-2-danielhb413@gmail.com>
In-Reply-To: <20180621102153.28443-1-danielhb413@gmail.com>
References: <20180621102153.28443-1-danielhb413@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/6] qga: refactoring qmp_guest_suspend_*
 functions
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

To be able to add new suspend mechanisms we need to detach
the existing QMP functions from the current implementation
specifics.

At this moment we have functions such as qmp_guest_suspend_ram
calling bios_suspend_mode and guest_suspend passing the
pmutils command and arguments as parameters. This patch
removes this logic from the QMP functions, moving them to
the respective functions that will have to deal with which
binary to use.

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 qga/commands-posix.c | 87 ++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 32 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index eae817191b..63c49791a4 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1438,15 +1438,38 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 #define LINUX_SYS_STATE_FILE "/sys/power/state"
 #define SUSPEND_SUPPORTED 0
 #define SUSPEND_NOT_SUPPORTED 1
+#define SUSPEND_MODE_DISK 1
+#define SUSPEND_MODE_RAM 2
+#define SUSPEND_MODE_HYBRID 3
 
-static void bios_supports_mode(const char *pmutils_bin, const char *pmutils_arg,
-                               const char *sysfile_str, Error **errp)
+static void bios_supports_mode(int suspend_mode, Error **errp)
 {
     Error *local_err = NULL;
+    const char *pmutils_arg, *sysfile_str;
+    const char *pmutils_bin = "pm-is-supported";
     char *pmutils_path;
     pid_t pid;
     int status;
 
+    switch (suspend_mode) {
+
+    case SUSPEND_MODE_DISK:
+        pmutils_arg = "--hibernate";
+        sysfile_str = "disk";
+        break;
+    case SUSPEND_MODE_RAM:
+        pmutils_arg = "--suspend";
+        sysfile_str = "mem";
+        break;
+    case SUSPEND_MODE_HYBRID:
+        pmutils_arg = "--suspend-hybrid";
+        sysfile_str = NULL;
+        break;
+    default:
+        error_setg(errp, "guest suspend mode not supported");
+        return;
+    }
+
     pmutils_path = g_find_program_in_path(pmutils_bin);
 
     pid = fork();
@@ -1523,14 +1546,39 @@ out:
     g_free(pmutils_path);
 }
 
-static void guest_suspend(const char *pmutils_bin, const char *sysfile_str,
-                          Error **errp)
+static void guest_suspend(int suspend_mode, Error **errp)
 {
     Error *local_err = NULL;
+    const char *pmutils_bin, *sysfile_str;
     char *pmutils_path;
     pid_t pid;
     int status;
 
+    bios_supports_mode(suspend_mode, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    switch (suspend_mode) {
+
+    case SUSPEND_MODE_DISK:
+        pmutils_bin = "pm-hibernate";
+        sysfile_str = "disk";
+        break;
+    case SUSPEND_MODE_RAM:
+        pmutils_bin = "pm-suspend";
+        sysfile_str = "mem";
+        break;
+    case SUSPEND_MODE_HYBRID:
+        pmutils_bin = "pm-suspend-hybrid";
+        sysfile_str = NULL;
+        break;
+    default:
+        error_setg(errp, "unknown guest suspend mode");
+        return;
+    }
+
     pmutils_path = g_find_program_in_path(pmutils_bin);
 
     pid = fork();
@@ -1593,42 +1641,17 @@ out:
 
 void qmp_guest_suspend_disk(Error **errp)
 {
-    Error *local_err = NULL;
-
-    bios_supports_mode("pm-is-supported", "--hibernate", "disk", &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    guest_suspend("pm-hibernate", "disk", errp);
+    guest_suspend(SUSPEND_MODE_DISK, errp);
 }
 
 void qmp_guest_suspend_ram(Error **errp)
 {
-    Error *local_err = NULL;
-
-    bios_supports_mode("pm-is-supported", "--suspend", "mem", &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    guest_suspend("pm-suspend", "mem", errp);
+    guest_suspend(SUSPEND_MODE_RAM, errp);
 }
 
 void qmp_guest_suspend_hybrid(Error **errp)
 {
-    Error *local_err = NULL;
-
-    bios_supports_mode("pm-is-supported", "--suspend-hybrid", NULL,
-                       &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-
-    guest_suspend("pm-suspend-hybrid", NULL, errp);
+    guest_suspend(SUSPEND_MODE_HYBRID, errp);
 }
 
 static GuestNetworkInterfaceList *
-- 
2.17.1

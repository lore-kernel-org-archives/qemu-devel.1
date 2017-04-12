Received: from eggs.gnu.org ([2001:4830:134:3::10]:44410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huang.yong@zte.com.cn>) id 1cyGCa-0008FW-CC
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:12:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huang.yong@zte.com.cn>) id 1cyGCV-0006Dj-Gh
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:12:44 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:34780)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huang.yong@zte.com.cn>) id 1cyGCU-0006Ba-UE
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 07:12:39 -0400
From: Huang Yong <huang.yong@zte.com.cn>
Date: Wed, 12 Apr 2017 19:10:56 +0800
Message-Id: <1491995456-6411-1-git-send-email-huang.yong@zte.com.cn>
Subject: [Qemu-devel] [PATCH] QEMU Guest Agent: Add an interface to
 determine guest os type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, Huang Yong <huang.yong@zte.com.cn>

vm management tools (e.g.libvirt) may tell if guest os is linux or windows,
so they can design a customized application accordingly, we suggest to add
an interface (guest-ostype) in QEMU.

Signed-off-by: Huang Yong <huang.yong@zte.com.cn>
---
 qga/commands-posix.c | 10 ++++++++++
 qga/commands-win32.c | 10 ++++++++++
 qga/qapi-schema.json | 12 ++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 915df9e..24ec2b6 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -49,6 +49,11 @@ extern char **environ;
 #endif
 #endif
 
+typedef enum GuestArch {
+    ARCH_WINDOWS = 0,
+    ARCH_LINUX = 1,
+} GuestArch;
+
 static void ga_wait_child(pid_t pid, int *status, Error **errp)
 {
     pid_t rpid;
@@ -2470,6 +2475,11 @@ qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
 }
 #endif
 
+int64_t qmp_guest_ostype(Error **errp)
+{
+    return ARCH_LINUX;
+}
+
 /* add unsupported commands to the blacklist */
 GList *ga_command_blacklist_init(GList *blacklist)
 {
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 19d72b2..a6639dd 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -58,6 +58,11 @@ static struct {
     .filehandles = QTAILQ_HEAD_INITIALIZER(guest_file_state.filehandles),
 };
 
+typedef enum GuestArch {
+    ARCH_WINDOWS = 0,
+    ARCH_LINUX = 1,
+} GuestArch;
+
 #define FILE_GENERIC_APPEND (FILE_GENERIC_WRITE & ~FILE_WRITE_DATA)
 
 typedef struct OpenFlags {
@@ -214,6 +219,11 @@ void qmp_guest_file_close(int64_t handle, Error **errp)
     g_free(gfh);
 }
 
+int64_t qmp_guest_ostype(Error **errp)
+{
+    return ARCH_WINDOWS;
+}
+
 static void acquire_privilege(const char *name, Error **errp)
 {
     HANDLE token = NULL;
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..496ae55 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -26,6 +26,7 @@
         'guest-get-time',
         'guest-set-vcpus',
         'guest-sync',
+        'guest-ostype',
         'guest-sync-delimited' ] } }
 
 ##
@@ -1042,3 +1043,14 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
+
+##
+# @guest-ostype:
+#
+# Get guest os type info
+# Returns: os type, Linux/Windows
+#
+# Since: 2.5.0
+##
+{ 'command': 'guest-ostype',
+  'returns': 'int' }
-- 
1.8.3.1

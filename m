Received: from eggs.gnu.org ([2001:4830:134:3::10]:58398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fNrMf-0008BO-N9
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:01:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fNrMa-0005m8-Sa
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:01:29 -0400
Received: from m15-113.126.com ([220.181.15.113]:52691)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fNrMa-0005ix-3u
	for qemu-devel@nongnu.org; Tue, 29 May 2018 23:01:24 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Wed, 30 May 2018 11:01:09 +0800
Message-Id: <20180530030109.22404-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH] qga: add mountpoint usage to
 GuestFilesystemInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Chen Hanxiao <chen_han_xiao@126.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

This patch adds support for getting the usage of mounted
filesystem.
It's very useful when we try to monitor guest's filesystem.
Use df of coreutils for reference.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
---
 qga/commands-posix.c | 17 +++++++++++++++++
 qga/qapi-schema.json |  3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 0dc219dbcf..0d93c47a5d 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -46,6 +46,7 @@ extern char **environ;
 #include <arpa/inet.h>
 #include <sys/socket.h>
 #include <net/if.h>
+#include <sys/statvfs.h>
 
 #ifdef FIFREEZE
 #define CONFIG_FSFREEZE
@@ -1072,6 +1073,9 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
                                                Error **errp)
 {
     GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
+    struct statvfs buf;
+    unsigned long u100, used, nonroot_total;
+    int usage;
     char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
                                     mount->devmajor, mount->devminor);
 
@@ -1079,7 +1083,20 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
     fs->type = g_strdup(mount->devtype);
     build_guest_fsinfo_for_device(devpath, fs, errp);
 
+    if (statvfs(fs->mountpoint, &buf)) {
+        error_setg_errno(errp, errno, "Failed to get statvfs");
+        return NULL;
+    }
+
+    used = buf.f_blocks - buf.f_bfree;
+    u100 = 100 * used;
+    nonroot_total = used + buf.f_bavail;
+    usage = u100 / nonroot_total + (u100 % nonroot_total != 0);
+
+    fs->usage = usage;
+
     g_free(devpath);
+
     return fs;
 }
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..22c22d8a62 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -846,13 +846,14 @@
 # @name: disk name
 # @mountpoint: mount point path
 # @type: file system type string
+# @usage: file system usage
 # @disk: an array of disk hardware information that the volume lies on,
 #        which may be empty if the disk type is not supported
 #
 # Since: 2.2
 ##
 { 'struct': 'GuestFilesystemInfo',
-  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
+  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str', 'usage': 'int',
            'disk': ['GuestDiskAddress']} }
 
 ##
-- 
2.17.0

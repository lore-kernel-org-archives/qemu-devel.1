Received: from eggs.gnu.org ([2001:4830:134:3::10]:41458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fODC3-0008SF-Ew
	for qemu-devel@nongnu.org; Wed, 30 May 2018 22:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fODC0-0003jw-8L
	for qemu-devel@nongnu.org; Wed, 30 May 2018 22:19:59 -0400
Received: from m15-111.126.com ([220.181.15.111]:54021)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fODBz-0003Xk-EP
	for qemu-devel@nongnu.org; Wed, 30 May 2018 22:19:56 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Thu, 31 May 2018 10:19:24 +0800
Message-Id: <20180531021924.4836-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH v3] qga: add mountpoint usage to
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
Cc: Chen Hanxiao <chen_han_xiao@126.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

This patch adds support for getting the usage of mounted
filesystem.
It's very useful when we try to monitor guest's filesystem.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Eric Blake <eblake@redhat.com>

Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
---
v2:
   add description in qapi-schema and version numbers
v3:
   use float for usage to get more precision.

 qga/commands-posix.c | 16 ++++++++++++++++
 qga/qapi-schema.json |  3 ++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 0dc219dbcf..7601978a11 100644
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
+    unsigned long used, nonroot_total;
+    double usage;
     char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
                                     mount->devmajor, mount->devminor);
 
@@ -1079,7 +1083,19 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
     fs->type = g_strdup(mount->devtype);
     build_guest_fsinfo_for_device(devpath, fs, errp);
 
+    if (statvfs(fs->mountpoint, &buf)) {
+        error_setg_errno(errp, errno, "Failed to get statvfs");
+        return NULL;
+    }
+
+    used = buf.f_blocks - buf.f_bfree;
+    nonroot_total = used + buf.f_bavail;
+    usage = (double) used / nonroot_total;
+
+    fs->usage = usage;
+
     g_free(devpath);
+
     return fs;
 }
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..68b9f60824 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -846,13 +846,14 @@
 # @name: disk name
 # @mountpoint: mount point path
 # @type: file system type string
+# @usage: file system usage, fraction between 0 and 1 (since 3.0)
 # @disk: an array of disk hardware information that the volume lies on,
 #        which may be empty if the disk type is not supported
 #
 # Since: 2.2
 ##
 { 'struct': 'GuestFilesystemInfo',
-  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
+  'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str', 'usage': 'number',
            'disk': ['GuestDiskAddress']} }
 
 ##
-- 
2.17.0

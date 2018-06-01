Received: from eggs.gnu.org ([2001:4830:134:3::10]:45374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOdHv-00030w-G9
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 02:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOdHs-00026A-9j
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 02:11:47 -0400
Received: from m15-114.126.com ([220.181.15.114]:51558)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOdHr-0001xM-JH
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 02:11:44 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Fri,  1 Jun 2018 14:11:21 +0800
Message-Id: <20180601061121.13161-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH v4] qga: add mountpoint usage to
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
v4:
   make usage as a best-effort query and mark it as optional.

 qga/commands-posix.c | 17 +++++++++++++++++
 qga/qapi-schema.json |  3 ++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 0dc219dbcf..4facc76953 100644
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
 
@@ -1079,7 +1083,20 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
     fs->type = g_strdup(mount->devtype);
     build_guest_fsinfo_for_device(devpath, fs, errp);
 
+    if (statvfs(fs->mountpoint, &buf)) {
+        fs->has_usage = false;
+        fs->usage = -1;
+    } else {
+        used = buf.f_blocks - buf.f_bfree;
+        nonroot_total = used + buf.f_bavail;
+        usage = (double) used / nonroot_total;
+
+        fs->has_usage = true;
+        fs->usage = usage;
+    }
+
     g_free(devpath);
+
     return fs;
 }
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..fcd427e86d 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -846,6 +846,7 @@
 # @name: disk name
 # @mountpoint: mount point path
 # @type: file system type string
+# @usage: file system usage, fraction between 0 and 1 (since 3.0)
 # @disk: an array of disk hardware information that the volume lies on,
 #        which may be empty if the disk type is not supported
 #
@@ -853,7 +854,7 @@
 ##
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
-           'disk': ['GuestDiskAddress']} }
+           '*usage': 'number', 'disk': ['GuestDiskAddress']} }
 
 ##
 # @guest-get-fsinfo:
-- 
2.17.0

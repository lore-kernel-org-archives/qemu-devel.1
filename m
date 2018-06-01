Received: from eggs.gnu.org ([2001:4830:134:3::10]:54540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOlz0-0006L2-UG
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOlyw-0006R7-De
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:28:50 -0400
Received: from m15-112.126.com ([220.181.15.112]:45226)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOlyv-0006P4-G2
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:28:46 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Fri,  1 Jun 2018 23:27:45 +0800
Message-Id: <20180601152746.17169-2-chen_han_xiao@126.com>
In-Reply-To: <20180601152746.17169-1-chen_han_xiao@126.com>
References: <20180601152746.17169-1-chen_han_xiao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 1/2] qga: add mountpoint usage to
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
Cc: Chen Hanxiao <chen_han_xiao@126.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

This patch adds support for getting the usage of mounted
filesystem.
The usage of fs stored as used_bytes and total_bytes.
It's very useful when we try to monitor guest's filesystem.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>

---
v2:
   add description in qapi-schema and version numbers
v3:
   use float for usage to get more precision.
v4:
   make usage a best-effort query and mark it as optional.
v5:
   report used-bytes and total-bytes in usage

 qga/commands-posix.c | 19 +++++++++++++++++++
 qga/qapi-schema.json | 14 +++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 0dc219dbcf..83192f284c 100644
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
+    GuestFsUsage *usage;
+    struct statvfs buf;
+    unsigned long used, nonroot_total, fr_size;
     char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
                                     mount->devmajor, mount->devminor);
 
@@ -1079,7 +1083,22 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
     fs->type = g_strdup(mount->devtype);
     build_guest_fsinfo_for_device(devpath, fs, errp);
 
+    if (statvfs(fs->mountpoint, &buf)) {
+        fs->has_usage = false;
+    } else {
+        fr_size = buf.f_frsize;
+        used = buf.f_blocks - buf.f_bfree;
+        nonroot_total = used + buf.f_bavail;
+        usage = g_malloc0(sizeof(*usage));
+        usage->used_bytes = used * fr_size;
+        usage->total_bytes = nonroot_total * fr_size;
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
index 17884c7c70..2f742474f6 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -840,12 +840,24 @@
            'bus-type': 'GuestDiskBusType',
            'bus': 'int', 'target': 'int', 'unit': 'int'} }
 
+##
+# @GuestFsUsage:
+#
+# @used-bytes:  file system used bytes
+# @total-bytes: file system total bytes for nonroot user
+#
+# Since: 3.0
+##
+{ 'struct': 'GuestFsUsage',
+  'data': {'used-bytes': 'uint64', 'total-bytes': 'uint64'} }
+
 ##
 # @GuestFilesystemInfo:
 #
 # @name: disk name
 # @mountpoint: mount point path
 # @type: file system type string
+# @usage: file system usage struct (since 3.0)
 # @disk: an array of disk hardware information that the volume lies on,
 #        which may be empty if the disk type is not supported
 #
@@ -853,7 +865,7 @@
 ##
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
-           'disk': ['GuestDiskAddress']} }
+           '*usage': 'GuestFsUsage', 'disk': ['GuestDiskAddress']} }
 
 ##
 # @guest-get-fsinfo:
-- 
2.17.0

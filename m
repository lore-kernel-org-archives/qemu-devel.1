Received: from eggs.gnu.org ([2001:4830:134:3::10]:34025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fTNH7-0003Mb-Ra
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fTNH5-0001Ji-C8
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:33 -0400
Received: from m15-111.126.com ([220.181.15.111]:38878)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fTNH4-0001HE-Jp
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:31 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Thu, 14 Jun 2018 16:06:06 +0800
Message-Id: <20180614080607.16604-2-chen_han_xiao@126.com>
In-Reply-To: <20180614080607.16604-1-chen_han_xiao@126.com>
References: <20180614080607.16604-1-chen_han_xiao@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5.2 1/2] qga: add mountpoint usage info to
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
Cc: Chen Hanxiao <chen_han_xiao@126.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

This patch adds support for getting the usage of mounted
filesystem.
The usage of fs stored as used_bytes and total_bytes.
It's very useful when we try to monitor guest's filesystem.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
v5.1:
   unpack usage as used-bytes and total-bytes
v5.2:
   remove useless assigments and fix doc

 qga/commands-posix.c | 15 +++++++++++++++
 qga/qapi-schema.json |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index eae817191b..e0e7993bcf 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -46,6 +46,7 @@ extern char **environ;
 #include <arpa/inet.h>
 #include <sys/socket.h>
 #include <net/if.h>
+#include <sys/statvfs.h>
 
 #ifdef FIFREEZE
 #define CONFIG_FSFREEZE
@@ -1072,6 +1073,8 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
                                                Error **errp)
 {
     GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
+    struct statvfs buf;
+    unsigned long used, nonroot_total, fr_size;
     char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
                                     mount->devmajor, mount->devminor);
 
@@ -1079,7 +1082,19 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
     fs->type = g_strdup(mount->devtype);
     build_guest_fsinfo_for_device(devpath, fs, errp);
 
+    if (statvfs(fs->mountpoint, &buf) == 0) {
+        fr_size = buf.f_frsize;
+        used = buf.f_blocks - buf.f_bfree;
+        nonroot_total = used + buf.f_bavail;
+        fs->used_bytes = used * fr_size;
+        fs->total_bytes = nonroot_total * fr_size;
+
+        fs->has_total_bytes = true;
+        fs->has_used_bytes = true;
+    }
+
     g_free(devpath);
+
     return fs;
 }
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..b1bbb78c59 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -846,6 +846,8 @@
 # @name: disk name
 # @mountpoint: mount point path
 # @type: file system type string
+# @used-bytes: file system used bytes (since 3.0)
+# @total-bytes: non-root file system total bytes (since 3.0)
 # @disk: an array of disk hardware information that the volume lies on,
 #        which may be empty if the disk type is not supported
 #
@@ -853,6 +855,7 @@
 ##
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
+           '*used-bytes': 'uint64', '*total-bytes': 'uint64',
            'disk': ['GuestDiskAddress']} }
 
 ##
-- 
2.17.1

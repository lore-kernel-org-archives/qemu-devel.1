Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1faGid-0002Iv-Kg
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1faGia-0002cw-BY
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:31:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1faGia-0002cB-52
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:31:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so1287508wmf.3
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 01:31:23 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  3 Jul 2018 10:31:20 +0200
Message-Id: <0b2c142da5d44a4b645dee47b7c50dae87a90a05.1530606672.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] qga: report disk size and free space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Report total file system size and free space in output of command
"guest-get-fsinfo". Values are optional and it is not an error if they cannot
be retrieved for some reason.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-posix.c | 18 ++++++++++++++++++
 qga/commands-win32.c | 16 ++++++++++++++++
 qga/qapi-schema.json |  5 ++++-
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index eae817191b..1f2fb25b91 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
+#include <sys/statvfs.h>
 #include <sys/utsname.h>
 #include <sys/wait.h>
 #include <dirent.h>
@@ -1074,11 +1075,28 @@ static GuestFilesystemInfo *build_guest_fsinfo(struct FsMount *mount,
     GuestFilesystemInfo *fs = g_malloc0(sizeof(*fs));
     char *devpath = g_strdup_printf("/sys/dev/block/%u:%u",
                                     mount->devmajor, mount->devminor);
+    struct statvfs vfs_stats;
 
     fs->mountpoint = g_strdup(mount->dirname);
     fs->type = g_strdup(mount->devtype);
     build_guest_fsinfo_for_device(devpath, fs, errp);
 
+    g_debug(" get filesystem statistics for '%s'", mount->dirname);
+    if (statvfs(mount->dirname, &vfs_stats) != 0) {
+        /* This is not fatal, just log this incident */
+        Error *local_err = NULL;
+        error_setg_errno(&local_err, errno, "statfs(\"%s\")",
+            mount->dirname);
+        slog("failed to stat filesystem: %s",
+            error_get_pretty(local_err));
+        error_free(local_err);
+    } else {
+        fs->size = vfs_stats.f_frsize * vfs_stats.f_blocks;
+        fs->has_size = true;
+        fs->free = vfs_stats.f_frsize * vfs_stats.f_bfree;
+        fs->has_free = true;
+    }
+
     g_free(devpath);
     return fs;
 }
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 70ee5379f6..6d6ca05281 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -706,6 +706,22 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     }
     fs->type = g_strdup(fs_name);
     fs->disk = build_guest_disk_info(guid, errp);
+
+    if (len > 0) {
+        if (GetDiskFreeSpaceEx(mnt_point, 0, (PULARGE_INTEGER)&fs->size,
+                (PULARGE_INTEGER)&fs->free) != 0) {
+            /* This is not fatal, just log this incident */
+            Error *local_err = NULL;
+            error_setg_win32(&local_err, GetLastError(),
+                "failed to get free space on volume \"%s\"", mnt_point);
+            slog("%s", error_get_pretty(local_err));
+            error_free(local_err);
+        } else {
+            fs->has_size = true;
+            fs->has_free = true;
+        }
+    }
+
 free:
     g_free(mnt_point);
     return fs;
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 17884c7c70..28a32444d3 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -848,12 +848,15 @@
 # @type: file system type string
 # @disk: an array of disk hardware information that the volume lies on,
 #        which may be empty if the disk type is not supported
+# @size: total number of bytes on the file system (Since 2.13)
+# @free: number of bytes available on the file system (Since 2.13)
 #
 # Since: 2.2
 ##
 { 'struct': 'GuestFilesystemInfo',
   'data': {'name': 'str', 'mountpoint': 'str', 'type': 'str',
-           'disk': ['GuestDiskAddress']} }
+           'disk': ['GuestDiskAddress'], '*size': 'uint64',
+           '*free': 'uint64'} }
 
 ##
 # @guest-get-fsinfo:
-- 
2.17.1

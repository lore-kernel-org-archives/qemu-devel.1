Received: from eggs.gnu.org ([2001:4830:134:3::10]:34043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fTNHA-0003My-DH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fTNH4-0001J0-Nq
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:36 -0400
Received: from m15-111.126.com ([220.181.15.111]:38867)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fTNH3-0001Gz-Ua
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:30 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Thu, 14 Jun 2018 16:06:07 +0800
Message-Id: <20180614080607.16604-3-chen_han_xiao@126.com>
In-Reply-To: <20180614080607.16604-1-chen_han_xiao@126.com>
References: <20180614080607.16604-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH v5.2 2/2] qga-win: add driver path usage to
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

This patch adds support for getting the usage of
windows driver path.
The usage of fs stored as used_bytes and total_bytes.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
---
v2:
  unpack usage as used-bytes and total-bytes

 qga/commands-win32.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 70ee5379f6..0103c0695c 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -670,6 +670,7 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     char fs_name[32];
     char vol_info[MAX_PATH+1];
     size_t len;
+    uint64_t i64FreeBytesToCaller, i64TotalBytes, i64FreeBytes;
     GuestFilesystemInfo *fs = NULL;
 
     GetVolumePathNamesForVolumeName(guid, (LPCH)&mnt, 0, &info_size);
@@ -699,10 +700,21 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     fs_name[sizeof(fs_name) - 1] = 0;
     fs = g_malloc(sizeof(*fs));
     fs->name = g_strdup(guid);
+    fs->has_total_bytes = false;
+    fs->has_used_bytes = false;
     if (len == 0) {
         fs->mountpoint = g_strdup("System Reserved");
     } else {
         fs->mountpoint = g_strndup(mnt_point, len);
+        if (GetDiskFreeSpaceEx(fs->mountpoint,
+                               (PULARGE_INTEGER) & i64FreeBytesToCaller,
+                               (PULARGE_INTEGER) & i64TotalBytes,
+                               (PULARGE_INTEGER) & i64FreeBytes)) {
+            fs->used_bytes = i64TotalBytes - i64FreeBytes;
+            fs->total_bytes = i64TotalBytes;
+            fs->has_total_bytes = true;
+            fs->has_used_bytes = true;
+        }
     }
     fs->type = g_strdup(fs_name);
     fs->disk = build_guest_disk_info(guid, errp);
-- 
2.17.1

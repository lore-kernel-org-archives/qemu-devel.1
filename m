Received: from eggs.gnu.org ([2001:4830:134:3::10]:54539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOlz0-0006L1-U7
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:28:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOlyw-0006RD-EI
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:28:50 -0400
Received: from m15-112.126.com ([220.181.15.112]:45211)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen_han_xiao@126.com>) id 1fOlyv-0006Oa-50
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:28:46 -0400
From: Chen Hanxiao <chen_han_xiao@126.com>
Date: Fri,  1 Jun 2018 23:27:46 +0800
Message-Id: <20180601152746.17169-3-chen_han_xiao@126.com>
In-Reply-To: <20180601152746.17169-1-chen_han_xiao@126.com>
References: <20180601152746.17169-1-chen_han_xiao@126.com>
Subject: [Qemu-devel] [PATCH v5 2/2] qga-win: add driver path usage to
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
 qga/commands-win32.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2d48394748..badcc2e2e8 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -670,7 +670,9 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     char fs_name[32];
     char vol_info[MAX_PATH+1];
     size_t len;
+    uint64_t i64FreeBytesToCaller, i64TotalBytes, i64FreeBytes;
     GuestFilesystemInfo *fs = NULL;
+    GuestFsUsage *usage = NULL;
 
     GetVolumePathNamesForVolumeName(guid, (LPCH)&mnt, 0, &info_size);
     if (GetLastError() != ERROR_MORE_DATA) {
@@ -699,10 +701,21 @@ static GuestFilesystemInfo *build_guest_fsinfo(char *guid, Error **errp)
     fs_name[sizeof(fs_name) - 1] = 0;
     fs = g_malloc(sizeof(*fs));
     fs->name = g_strdup(guid);
+    fs->has_usage = false;
     if (len == 0) {
         fs->mountpoint = g_strdup("System Reserved");
     } else {
         fs->mountpoint = g_strndup(mnt_point, len);
+        if (GetDiskFreeSpaceEx(fs->mountpoint,
+                               (PULARGE_INTEGER) & i64FreeBytesToCaller,
+                               (PULARGE_INTEGER) & i64TotalBytes,
+                               (PULARGE_INTEGER) & i64FreeBytes)) {
+            usage = g_malloc(sizeof(*usage));
+            usage->used_bytes = i64TotalBytes - i64FreeBytes;
+            usage->total_bytes = i64TotalBytes;
+            fs->usage = usage;
+            fs->has_usage = true;
+        }
     }
     fs->type = g_strdup(fs_name);
     fs->disk = build_guest_disk_info(guid, errp);
-- 
2.17.0

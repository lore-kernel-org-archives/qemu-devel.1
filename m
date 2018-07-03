Received: from eggs.gnu.org ([2001:4830:134:3::10]:41281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIz-0008QO-VX
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIx-0000zz-HR
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46126
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIx-0000zd-Bp
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnB5D041206
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:42 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dp9pc0v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:42 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:42 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:11 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180703205221.24788-5-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 04/14] qga-win: add driver path usage to
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
Cc: peter.maydell@linaro.org, Chen Hanxiao <chenhanxiao@gmail.com>

From: Chen Hanxiao <chenhanxiao@gmail.com>

This patch adds support for getting the usage of
windows driver path.
The usage of fs stored as used_bytes and total_bytes.

Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Chen Hanxiao <chenhanxiao@gmail.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 73f31fa8c2..318d760a74 100644
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
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAqM-0008Hp-Rv
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cYAqJ-0000xi-N2
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38258
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cYAqJ-0000xS-Gx
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 07:13:55 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0UCDpv1027959
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:55 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28a1ah1nse-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 07:13:54 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 30 Jan 2017 05:13:45 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 30 Jan 2017 13:13:40 +0100
In-Reply-To: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
References: <148577817618.10533.9740628265078537215.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148577842061.10533.9523839559863367492.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH RFC 32/36] 9pfs: local: lstat: don't follow
 symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ppandit@redhat.com, jannh@google.com, Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This fixes CVE-2016-9602 for the "passthrough" and "mapped" security models.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |   36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 60edfb25f8a5..b46a81792ecf 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -168,12 +168,17 @@ static void local_mapped_file_attr(FsContext *ctx, const char *path,
 
 static int local_lstat(FsContext *fs_ctx, V9fsPath *fs_path, struct stat *stbuf)
 {
-    int err;
-    char *buffer;
-    char *path = fs_path->data;
+    int err = -1;
+    char *dirpath = local_dirname(fs_path->data);
+    char *name = local_basename(fs_path->data);
+    int dirfd;
 
-    buffer = rpath(fs_ctx, path);
-    err =  lstat(buffer, stbuf);
+    dirfd = local_opendir_nofollow(fs_ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
+
+    err = fstatat(dirfd, name, stbuf, AT_SYMLINK_NOFOLLOW);
     if (err) {
         goto err_out;
     }
@@ -183,25 +188,32 @@ static int local_lstat(FsContext *fs_ctx, V9fsPath *fs_path, struct stat *stbuf)
         gid_t tmp_gid;
         mode_t tmp_mode;
         dev_t tmp_dev;
-        if (getxattr(buffer, "user.virtfs.uid", &tmp_uid, sizeof(uid_t)) > 0) {
+
+        if (fgetxattrat(dirfd, name, "user.virtfs.uid", &tmp_uid,
+                        sizeof(uid_t)) > 0) {
             stbuf->st_uid = le32_to_cpu(tmp_uid);
         }
-        if (getxattr(buffer, "user.virtfs.gid", &tmp_gid, sizeof(gid_t)) > 0) {
+        if (fgetxattrat(dirfd, name, "user.virtfs.gid", &tmp_gid,
+                        sizeof(gid_t)) > 0) {
             stbuf->st_gid = le32_to_cpu(tmp_gid);
         }
-        if (getxattr(buffer, "user.virtfs.mode",
-                    &tmp_mode, sizeof(mode_t)) > 0) {
+        if (fgetxattrat(dirfd, name, "user.virtfs.mode", &tmp_mode,
+                        sizeof(mode_t)) > 0) {
             stbuf->st_mode = le32_to_cpu(tmp_mode);
         }
-        if (getxattr(buffer, "user.virtfs.rdev", &tmp_dev, sizeof(dev_t)) > 0) {
+        if (fgetxattrat(dirfd, name, "user.virtfs.rdev", &tmp_dev,
+                        sizeof(dev_t)) > 0) {
             stbuf->st_rdev = le64_to_cpu(tmp_dev);
         }
     } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        local_mapped_file_attr(fs_ctx, path, stbuf);
+        local_mapped_file_attr(fs_ctx, fs_path->data, stbuf);
     }
 
 err_out:
-    g_free(buffer);
+    close_preserve_errno(dirfd);
+out:
+    g_free(name);
+    g_free(dirpath);
     return err;
 }
 

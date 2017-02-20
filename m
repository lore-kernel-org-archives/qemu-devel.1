Received: from eggs.gnu.org ([2001:4830:134:3::10]:54625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpAd-0008GF-4A
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpAZ-00040l-U0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38949
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfpAZ-00040d-MV
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:42:27 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEdO9o114288
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:27 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28pgs4waut-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:42:26 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:42:26 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:42:19 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760173919.31154.7555675803159581620.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 23/29] 9pfs: local: chmod: don't follow symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

The local_chmod() callback is vulnerable to symlink attacks because it
calls:

(1) chmod() which follows symbolic links for all path elements
(2) local_set_xattr()->setxattr() which follows symbolic links for all
    path elements
(3) local_set_mapped_file_attr() which calls in turn local_fopen() and
    mkdir(), both functions following symbolic links for all path
    elements but the rightmost one

This patch converts local_chmod() to rely on open_nofollow() and
fchmod() to fix (1).

It introduces a local_set_xattrat() replacement to local_set_xattr()
based on fsetxattrat() to fix (2), and a local_set_mapped_file_attrat()
replacement to local_set_mapped_file_attr() based on local_fopenat()
and mkdirat() to fix (3). No effort is made to factor out code because
both local_set_xattr() and local_set_mapped_file_attr() will be dropped
when all users have been converted to use the "at" versions.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |  163 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 150 insertions(+), 13 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index fb536fdb3082..56d7731f7ce1 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -327,6 +327,87 @@ err_out:
     return ret;
 }
 
+static int local_set_mapped_file_attrat(int dirfd, const char *name,
+                                        FsCred *credp)
+{
+    FILE *fp;
+    int ret;
+    char buf[ATTR_MAX];
+    int uid = -1, gid = -1, mode = -1, rdev = -1;
+    int map_dirfd;
+
+    ret = mkdirat(dirfd, VIRTFS_META_DIR, 0700);
+    if (ret < 0 && errno != EEXIST) {
+        return -1;
+    }
+
+    map_dirfd = openat(dirfd, VIRTFS_META_DIR,
+                       O_RDONLY | O_DIRECTORY | O_NOFOLLOW);
+    if (map_dirfd == -1) {
+        return -1;
+    }
+
+    fp = local_fopenat(map_dirfd, name, "r");
+    if (!fp) {
+        if (errno == ENOENT) {
+            goto update_map_file;
+        } else {
+            close_preserve_errno(map_dirfd);
+            return -1;
+        }
+    }
+    memset(buf, 0, ATTR_MAX);
+    while (fgets(buf, ATTR_MAX, fp)) {
+        if (!strncmp(buf, "virtfs.uid", 10)) {
+            uid = atoi(buf + 11);
+        } else if (!strncmp(buf, "virtfs.gid", 10)) {
+            gid = atoi(buf + 11);
+        } else if (!strncmp(buf, "virtfs.mode", 11)) {
+            mode = atoi(buf + 12);
+        } else if (!strncmp(buf, "virtfs.rdev", 11)) {
+            rdev = atoi(buf + 12);
+        }
+        memset(buf, 0, ATTR_MAX);
+    }
+    fclose(fp);
+
+update_map_file:
+    fp = local_fopenat(map_dirfd, name, "w");
+    close_preserve_errno(map_dirfd);
+    if (!fp) {
+        return -1;
+    }
+
+    if (credp->fc_uid != -1) {
+        uid = credp->fc_uid;
+    }
+    if (credp->fc_gid != -1) {
+        gid = credp->fc_gid;
+    }
+    if (credp->fc_mode != -1) {
+        mode = credp->fc_mode;
+    }
+    if (credp->fc_rdev != -1) {
+        rdev = credp->fc_rdev;
+    }
+
+    if (uid != -1) {
+        fprintf(fp, "virtfs.uid=%d\n", uid);
+    }
+    if (gid != -1) {
+        fprintf(fp, "virtfs.gid=%d\n", gid);
+    }
+    if (mode != -1) {
+        fprintf(fp, "virtfs.mode=%d\n", mode);
+    }
+    if (rdev != -1) {
+        fprintf(fp, "virtfs.rdev=%d\n", rdev);
+    }
+    fclose(fp);
+
+    return 0;
+}
+
 static int local_set_xattr(const char *path, FsCred *credp)
 {
     int err;
@@ -362,6 +443,45 @@ static int local_set_xattr(const char *path, FsCred *credp)
     return 0;
 }
 
+static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
+{
+    int err;
+
+    if (credp->fc_uid != -1) {
+        uint32_t tmp_uid = cpu_to_le32(credp->fc_uid);
+        err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.uid", &tmp_uid,
+                                   sizeof(uid_t), 0);
+        if (err) {
+            return err;
+        }
+    }
+    if (credp->fc_gid != -1) {
+        uint32_t tmp_gid = cpu_to_le32(credp->fc_gid);
+        err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.gid", &tmp_gid,
+                                   sizeof(gid_t), 0);
+        if (err) {
+            return err;
+        }
+    }
+    if (credp->fc_mode != -1) {
+        uint32_t tmp_mode = cpu_to_le32(credp->fc_mode);
+        err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.mode", &tmp_mode,
+                                   sizeof(mode_t), 0);
+        if (err) {
+            return err;
+        }
+    }
+    if (credp->fc_rdev != -1) {
+        uint64_t tmp_rdev = cpu_to_le64(credp->fc_rdev);
+        err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.rdev", &tmp_rdev,
+                                   sizeof(dev_t), 0);
+        if (err) {
+            return err;
+        }
+    }
+    return 0;
+}
+
 static int local_post_create_passthrough(FsContext *fs_ctx, const char *path,
                                          FsCred *credp)
 {
@@ -553,21 +673,38 @@ static ssize_t local_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
 
 static int local_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 {
-    char *buffer;
     int ret = -1;
-    char *path = fs_path->data;
+    int dirfd;
 
-    if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        ret = local_set_xattr(buffer, credp);
-        g_free(buffer);
-    } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        return local_set_mapped_file_attr(fs_ctx, path, credp);
-    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
-               (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        ret = chmod(buffer, credp->fc_mode);
-        g_free(buffer);
+    if (fs_ctx->export_flags & V9FS_SM_MAPPED ||
+        fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
+        char *dirpath, *name;
+
+        dirpath = g_path_get_dirname(fs_path->data);
+        dirfd = local_opendir_nofollow(fs_ctx, dirpath);
+        g_free(dirpath);
+        if (dirfd == -1) {
+            return -1;
+        }
+
+        name = g_path_get_basename(fs_path->data);
+        if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
+            ret = local_set_xattrat(dirfd, name, credp);
+        } else {
+            ret = local_set_mapped_file_attrat(dirfd, name, credp);
+        }
+        g_free(name);
+        close_preserve_errno(dirfd);
+    } else if (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH ||
+               fs_ctx->export_flags & V9FS_SM_NONE) {
+        int fd;
+
+        fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
+        if (fd == -1) {
+            return -1;
+        }
+        ret = fchmod(fd, credp->fc_mode);
+        close_preserve_errno(fd);
     }
     return ret;
 }

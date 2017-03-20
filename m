Received: from eggs.gnu.org ([2001:4830:134:3::10]:40623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6Qb-0001YK-II
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cq6QW-0004oV-S5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44982
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cq6QW-0004nU-Hv
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 19:09:24 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2KN8opl008082
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:24 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29afu7a7xt-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 19:09:23 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 20 Mar 2017 19:09:23 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 20 Mar 2017 18:07:46 -0500
In-Reply-To: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1490051325-3770-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1490051325-3770-23-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 22/81] 9pfs: local: chmod: don't follow symlinks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, Greg Kurz <gkurz@linux.vnet.ibm.com>

From: Greg Kurz <groug@kaod.org>

The local_chmod() callback is vulnerable to symlink attacks because it
calls:

(1) chmod() which follows symbolic links for all path elements
(2) local_set_xattr()->setxattr() which follows symbolic links for all
    path elements
(3) local_set_mapped_file_attr() which calls in turn local_fopen() and
    mkdir(), both functions following symbolic links for all path
    elements but the rightmost one

We would need fchmodat() to implement AT_SYMLINK_NOFOLLOW to fix (1). This
isn't the case on linux unfortunately: the kernel doesn't even have a flags
argument to the syscall :-\ It is impossible to fix it in userspace in
a race-free manner. This patch hence converts local_chmod() to rely on
open_nofollow() and fchmod(). This fixes the vulnerability but introduces
a limitation: the target file must readable and/or writable for the call
to openat() to succeed.

It introduces a local_set_xattrat() replacement to local_set_xattr()
based on fsetxattrat() to fix (2), and a local_set_mapped_file_attrat()
replacement to local_set_mapped_file_attr() based on local_fopenat()
and mkdirat() to fix (3). No effort is made to factor out code because
both local_set_xattr() and local_set_mapped_file_attr() will be dropped
when all users have been converted to use the "at" versions.

This partly fixes CVE-2016-9602.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit e3187a45dd02a7490f9191c16527dc28a4ba45b9)
Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/9pfs/9p-local.c | 178 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 167 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 6a52ee6..225cc77 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -367,6 +367,155 @@ static int local_set_xattr(const char *path, FsCred *credp)
     return 0;
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
+    map_dirfd = openat_dir(dirfd, VIRTFS_META_DIR);
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
+static int fchmodat_nofollow(int dirfd, const char *name, mode_t mode)
+{
+    int fd, ret;
+
+    /* FIXME: this should be handled with fchmodat(AT_SYMLINK_NOFOLLOW).
+     * Unfortunately, the linux kernel doesn't implement it yet. As an
+     * alternative, let's open the file and use fchmod() instead. This
+     * may fail depending on the permissions of the file, but it is the
+     * best we can do to avoid TOCTTOU. We first try to open read-only
+     * in case name points to a directory. If that fails, we try write-only
+     * in case name doesn't point to a directory.
+     */
+    fd = openat_file(dirfd, name, O_RDONLY, 0);
+    if (fd == -1) {
+        /* In case the file is writable-only and isn't a directory. */
+        if (errno == EACCES) {
+            fd = openat_file(dirfd, name, O_WRONLY, 0);
+        }
+        if (fd == -1 && errno == EISDIR) {
+            errno = EACCES;
+        }
+    }
+    if (fd == -1) {
+        return -1;
+    }
+    ret = fchmod(fd, mode);
+    close_preserve_errno(fd);
+    return ret;
+}
+
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
@@ -559,22 +708,29 @@ static ssize_t local_pwritev(FsContext *ctx, V9fsFidOpenState *fs,
 
 static int local_chmod(FsContext *fs_ctx, V9fsPath *fs_path, FsCred *credp)
 {
-    char *buffer;
+    char *dirpath = g_path_get_dirname(fs_path->data);
+    char *name = g_path_get_basename(fs_path->data);
     int ret = -1;
-    char *path = fs_path->data;
+    int dirfd;
+
+    dirfd = local_opendir_nofollow(fs_ctx, dirpath);
+    if (dirfd == -1) {
+        goto out;
+    }
 
     if (fs_ctx->export_flags & V9FS_SM_MAPPED) {
-        buffer = rpath(fs_ctx, path);
-        ret = local_set_xattr(buffer, credp);
-        g_free(buffer);
+        ret = local_set_xattrat(dirfd, name, credp);
     } else if (fs_ctx->export_flags & V9FS_SM_MAPPED_FILE) {
-        return local_set_mapped_file_attr(fs_ctx, path, credp);
-    } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
-               (fs_ctx->export_flags & V9FS_SM_NONE)) {
-        buffer = rpath(fs_ctx, path);
-        ret = chmod(buffer, credp->fc_mode);
-        g_free(buffer);
+        ret = local_set_mapped_file_attrat(dirfd, name, credp);
+    } else if (fs_ctx->export_flags & V9FS_SM_PASSTHROUGH ||
+               fs_ctx->export_flags & V9FS_SM_NONE) {
+        ret = fchmodat_nofollow(dirfd, name, credp->fc_mode);
     }
+    close_preserve_errno(dirfd);
+
+out:
+    g_free(dirpath);
+    g_free(name);
     return ret;
 }
 
-- 
2.7.4

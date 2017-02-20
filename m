Received: from eggs.gnu.org ([2001:4830:134:3::10]:54901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpBQ-0000f4-DQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cfpBN-0004B0-6Z
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:43:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33317
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cfpBN-0004Au-05
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:43:17 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1KEf4eC143779
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:43:16 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28r16cbg9y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 09:43:15 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 20 Feb 2017 07:43:15 -0700
From: Greg Kurz <groug@kaod.org>
Date: Mon, 20 Feb 2017 15:43:07 +0100
In-Reply-To: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148760178735.31154.8978137672060558694.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 29/29] 9pfs: local: drop unused code
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

Now that the all callbacks have been converted to use "at" syscalls, we
can drop this code.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p-local.c |  198 ----------------------------------------------------
 1 file changed, 198 deletions(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 730cc37b765f..6d7d1d35bb6b 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -78,48 +78,6 @@ static void unlinkat_preserve_errno(int dirfd, const char *path, int flags)
 
 #define VIRTFS_META_DIR ".virtfs_metadata"
 
-static char *local_mapped_attr_path(FsContext *ctx, const char *path)
-{
-    int dirlen;
-    const char *name = strrchr(path, '/');
-    if (name) {
-        dirlen = name - path;
-        ++name;
-    } else {
-        name = path;
-        dirlen = 0;
-    }
-    return g_strdup_printf("%s/%.*s/%s/%s", ctx->fs_root,
-                           dirlen, path, VIRTFS_META_DIR, name);
-}
-
-static FILE *local_fopen(const char *path, const char *mode)
-{
-    int fd, o_mode = 0;
-    FILE *fp;
-    int flags = O_NOFOLLOW;
-    /*
-     * only supports two modes
-     */
-    if (mode[0] == 'r') {
-        flags |= O_RDONLY;
-    } else if (mode[0] == 'w') {
-        flags |= O_WRONLY | O_TRUNC | O_CREAT;
-        o_mode = S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH;
-    } else {
-        return NULL;
-    }
-    fd = open(path, flags, o_mode);
-    if (fd == -1) {
-        return NULL;
-    }
-    fp = fdopen(fd, mode);
-    if (!fp) {
-        close(fd);
-    }
-    return fp;
-}
-
 static FILE *local_fopenat(int dirfd, const char *name, const char *mode)
 {
     int fd, o_mode = 0;
@@ -233,100 +191,6 @@ out:
     return err;
 }
 
-static int local_create_mapped_attr_dir(FsContext *ctx, const char *path)
-{
-    int err;
-    char *attr_dir;
-    char *tmp_path = g_strdup(path);
-
-    attr_dir = g_strdup_printf("%s/%s/%s",
-             ctx->fs_root, dirname(tmp_path), VIRTFS_META_DIR);
-
-    err = mkdir(attr_dir, 0700);
-    if (err < 0 && errno == EEXIST) {
-        err = 0;
-    }
-    g_free(attr_dir);
-    g_free(tmp_path);
-    return err;
-}
-
-static int local_set_mapped_file_attr(FsContext *ctx,
-                                      const char *path, FsCred *credp)
-{
-    FILE *fp;
-    int ret = 0;
-    char buf[ATTR_MAX];
-    char *attr_path;
-    int uid = -1, gid = -1, mode = -1, rdev = -1;
-
-    attr_path = local_mapped_attr_path(ctx, path);
-    fp = local_fopen(attr_path, "r");
-    if (!fp) {
-        goto create_map_file;
-    }
-    memset(buf, 0, ATTR_MAX);
-    while (fgets(buf, ATTR_MAX, fp)) {
-        if (!strncmp(buf, "virtfs.uid", 10)) {
-            uid = atoi(buf+11);
-        } else if (!strncmp(buf, "virtfs.gid", 10)) {
-            gid = atoi(buf+11);
-        } else if (!strncmp(buf, "virtfs.mode", 11)) {
-            mode = atoi(buf+12);
-        } else if (!strncmp(buf, "virtfs.rdev", 11)) {
-            rdev = atoi(buf+12);
-        }
-        memset(buf, 0, ATTR_MAX);
-    }
-    fclose(fp);
-    goto update_map_file;
-
-create_map_file:
-    ret = local_create_mapped_attr_dir(ctx, path);
-    if (ret < 0) {
-        goto err_out;
-    }
-
-update_map_file:
-    fp = local_fopen(attr_path, "w");
-    if (!fp) {
-        ret = -1;
-        goto err_out;
-    }
-
-    if (credp->fc_uid != -1) {
-        uid = credp->fc_uid;
-    }
-    if (credp->fc_gid != -1) {
-        gid = credp->fc_gid;
-    }
-    if (credp->fc_mode != -1) {
-        mode = credp->fc_mode;
-    }
-    if (credp->fc_rdev != -1) {
-        rdev = credp->fc_rdev;
-    }
-
-
-    if (uid != -1) {
-        fprintf(fp, "virtfs.uid=%d\n", uid);
-    }
-    if (gid != -1) {
-        fprintf(fp, "virtfs.gid=%d\n", gid);
-    }
-    if (mode != -1) {
-        fprintf(fp, "virtfs.mode=%d\n", mode);
-    }
-    if (rdev != -1) {
-        fprintf(fp, "virtfs.rdev=%d\n", rdev);
-    }
-    fclose(fp);
-
-err_out:
-    g_free(attr_path);
-    return ret;
-}
-
 static int local_set_mapped_file_attrat(int dirfd, const char *name,
                                         FsCred *credp)
 {
@@ -408,41 +272,6 @@ update_map_file:
     return 0;
 }
 
-static int local_set_xattr(const char *path, FsCred *credp)
-{
-    int err;
-
-    if (credp->fc_uid != -1) {
-        uint32_t tmp_uid = cpu_to_le32(credp->fc_uid);
-        err = setxattr(path, "user.virtfs.uid", &tmp_uid, sizeof(uid_t), 0);
-        if (err) {
-            return err;
-        }
-    }
-    if (credp->fc_gid != -1) {
-        uint32_t tmp_gid = cpu_to_le32(credp->fc_gid);
-        err = setxattr(path, "user.virtfs.gid", &tmp_gid, sizeof(gid_t), 0);
-        if (err) {
-            return err;
-        }
-    }
-    if (credp->fc_mode != -1) {
-        uint32_t tmp_mode = cpu_to_le32(credp->fc_mode);
-        err = setxattr(path, "user.virtfs.mode", &tmp_mode, sizeof(mode_t), 0);
-        if (err) {
-            return err;
-        }
-    }
-    if (credp->fc_rdev != -1) {
-        uint64_t tmp_rdev = cpu_to_le64(credp->fc_rdev);
-        err = setxattr(path, "user.virtfs.rdev", &tmp_rdev, sizeof(dev_t), 0);
-        if (err) {
-            return err;
-        }
-    }
-    return 0;
-}
-
 static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
 {
     int err;
@@ -482,33 +311,6 @@ static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
     return 0;
 }
 
-static int local_post_create_passthrough(FsContext *fs_ctx, const char *path,
-                                         FsCred *credp)
-{
-    char *buffer;
-
-    buffer = rpath(fs_ctx, path);
-    if (lchown(buffer, credp->fc_uid, credp->fc_gid) < 0) {
-        /*
-         * If we fail to change ownership and if we are
-         * using security model none. Ignore the error
-         */
-        if ((fs_ctx->export_flags & V9FS_SEC_MASK) != V9FS_SM_NONE) {
-            goto err;
-        }
-    }
-
-    if (chmod(buffer, credp->fc_mode & 07777) < 0) {
-        goto err;
-    }
-
-    g_free(buffer);
-    return 0;
-err:
-    g_free(buffer);
-    return -1;
-}
-
 static int local_set_cred_passthrough(FsContext *fs_ctx, int dirfd,
                                       const char *name, FsCred *credp)
 {

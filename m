Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65091C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2A12073D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 15:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C69r9JDB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2A12073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j99IP-0007MP-8X
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 10:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j99HO-0005rP-Pz
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:16:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j99HM-0003zu-Vh
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:16:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j99HM-0003za-RR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 10:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583248576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nfD4pXQcSHNpJ9AJNnCTfG6O960MIWJ2esnID71DGGg=;
 b=C69r9JDBqId1WtilgIlhOgjXf0Elv+yjXuX0FZjaLZDWfBdH0+1F9w9aLK4RqPv9t1nhU5
 aRI/VHdjcil19zoFQIGtBTw1ow6QKFXHqPpkZsq6ax/d0CWEdzKRW4LnCZCk5w0Q8Ti2ln
 G6PlGwgwHm4KLuC6u8ZVl2oTgCSsITM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-DXghZn_7PvineX0MaS1ZVw-1; Tue, 03 Mar 2020 10:16:12 -0500
X-MC-Unique: DXghZn_7PvineX0MaS1ZVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5B0B8017CC
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 15:16:11 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-2.ams2.redhat.com
 [10.36.117.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F9DC90766
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 15:16:10 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] virtiofsd: Fix xattr operations
Date: Tue,  3 Mar 2020 15:16:06 +0000
Message-Id: <20200303151606.108736-3-dgilbert@redhat.com>
In-Reply-To: <20200303151606.108736-1-dgilbert@redhat.com>
References: <20200303151606.108736-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>

Current virtiofsd has problems about xattr operations and
they does not work properly for directory/symlink/special file.

The fundamental cause is that virtiofsd uses openat() + f...xattr()
systemcalls for xattr operation but we should not open symlink/special
file in the daemon. Therefore the function is restricted.

Fix this problem by:
 1. during setup of each thread, call unshare(CLONE_FS)
 2. in xattr operations (i.e. lo_getxattr), if inode is not a regular
    file or directory, use fchdir(proc_loot_fd) + ...xattr() +
    fchdir(root.fd) instead of openat() + f...xattr()

    (Note: for a regular file/directory openat() + f...xattr()
     is still used for performance reason)

With this patch, xfstests generic/062 passes on virtiofs.

This fix is suggested by Miklos Szeredi and Stefan Hajnoczi.
The original discussion can be found here:
  https://www.redhat.com/archives/virtio-fs/2019-October/msg00046.html

Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Message-Id: <20200227055927.24566-3-misono.tomohiro@jp.fujitsu.com>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/fuse_virtio.c    |  13 ++++
 tools/virtiofsd/passthrough_ll.c | 105 +++++++++++++++++--------------
 tools/virtiofsd/seccomp.c        |   6 ++
 3 files changed, 77 insertions(+), 47 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index dd1c605dbf..3b6d16a041 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -426,6 +426,8 @@ err:
     return ret;
 }
=20
+static __thread bool clone_fs_called;
+
 /* Process one FVRequest in a thread pool */
 static void fv_queue_worker(gpointer data, gpointer user_data)
 {
@@ -441,6 +443,17 @@ static void fv_queue_worker(gpointer data, gpointer us=
er_data)
=20
     assert(se->bufsize > sizeof(struct fuse_in_header));
=20
+    if (!clone_fs_called) {
+        int ret;
+
+        /* unshare FS for xattr operation */
+        ret =3D unshare(CLONE_FS);
+        /* should not fail */
+        assert(ret =3D=3D 0);
+
+        clone_fs_called =3D true;
+    }
+
     /*
      * An element contains one request and the space to send our response
      * They're spread over multiple descriptors in a scatter/gather set
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 4690a97947..4f259aac70 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -123,7 +123,7 @@ struct lo_inode {
     pthread_mutex_t plock_mutex;
     GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
=20
-    bool is_symlink;
+    mode_t filetype;
 };
=20
 struct lo_cred {
@@ -695,7 +695,7 @@ static int utimensat_empty(struct lo_data *lo, struct l=
o_inode *inode,
     struct lo_inode *parent;
     char path[PATH_MAX];
=20
-    if (inode->is_symlink) {
+    if (S_ISLNK(inode->filetype)) {
         res =3D utimensat(inode->fd, "", tv, AT_EMPTY_PATH);
         if (res =3D=3D -1 && errno =3D=3D EINVAL) {
             /* Sorry, no race free way to set times on symlink. */
@@ -928,7 +928,8 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
             goto out_err;
         }
=20
-        inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
+        /* cache only filetype */
+        inode->filetype =3D (e->attr.st_mode & S_IFMT);
=20
         /*
          * One for the caller and one for nlookup (released in
@@ -1135,7 +1136,7 @@ static int linkat_empty_nofollow(struct lo_data *lo, =
struct lo_inode *inode,
     struct lo_inode *parent;
     char path[PATH_MAX];
=20
-    if (inode->is_symlink) {
+    if (S_ISLNK(inode->filetype)) {
         res =3D linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
         if (res =3D=3D -1 && (errno =3D=3D ENOENT || errno =3D=3D EINVAL))=
 {
             /* Sorry, no race free way to hard-link a symlink. */
@@ -2189,12 +2190,6 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
     fuse_log(FUSE_LOG_DEBUG, "lo_getxattr(ino=3D%" PRIu64 ", name=3D%s siz=
e=3D%zd)\n",
              ino, name, size);
=20
-    if (inode->is_symlink) {
-        /* Sorry, no race free way to getxattr on symlink. */
-        saverr =3D EPERM;
-        goto out;
-    }
-
     if (size) {
         value =3D malloc(size);
         if (!value) {
@@ -2203,12 +2198,25 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
     }
=20
     sprintf(procname, "%i", inode->fd);
-    fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
-    if (fd < 0) {
-        goto out_err;
+    /*
+     * It is not safe to open() non-regular/non-dir files in file server
+     * unless O_PATH is used, so use that method for regular files/dir
+     * only (as it seems giving less performance overhead).
+     * Otherwise, call fchdir() to avoid open().
+     */
+    if (S_ISREG(inode->filetype) || S_ISDIR(inode->filetype)) {
+        fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
+        if (fd < 0) {
+            goto out_err;
+        }
+        ret =3D fgetxattr(fd, name, value, size);
+    } else {
+        /* fchdir should not fail here */
+        assert(fchdir(lo->proc_self_fd) =3D=3D 0);
+        ret =3D getxattr(procname, name, value, size);
+        assert(fchdir(lo->root.fd) =3D=3D 0);
     }
=20
-    ret =3D fgetxattr(fd, name, value, size);
     if (ret =3D=3D -1) {
         goto out_err;
     }
@@ -2262,12 +2270,6 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t =
ino, size_t size)
     fuse_log(FUSE_LOG_DEBUG, "lo_listxattr(ino=3D%" PRIu64 ", size=3D%zd)\=
n", ino,
              size);
=20
-    if (inode->is_symlink) {
-        /* Sorry, no race free way to listxattr on symlink. */
-        saverr =3D EPERM;
-        goto out;
-    }
-
     if (size) {
         value =3D malloc(size);
         if (!value) {
@@ -2276,12 +2278,19 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t=
 ino, size_t size)
     }
=20
     sprintf(procname, "%i", inode->fd);
-    fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
-    if (fd < 0) {
-        goto out_err;
+    if (S_ISREG(inode->filetype) || S_ISDIR(inode->filetype)) {
+        fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
+        if (fd < 0) {
+            goto out_err;
+        }
+        ret =3D flistxattr(fd, value, size);
+    } else {
+        /* fchdir should not fail here */
+        assert(fchdir(lo->proc_self_fd) =3D=3D 0);
+        ret =3D listxattr(procname, value, size);
+        assert(fchdir(lo->root.fd) =3D=3D 0);
     }
=20
-    ret =3D flistxattr(fd, value, size);
     if (ret =3D=3D -1) {
         goto out_err;
     }
@@ -2335,20 +2344,21 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
     fuse_log(FUSE_LOG_DEBUG, "lo_setxattr(ino=3D%" PRIu64
              ", name=3D%s value=3D%s size=3D%zd)\n", ino, name, value, siz=
e);
=20
-    if (inode->is_symlink) {
-        /* Sorry, no race free way to setxattr on symlink. */
-        saverr =3D EPERM;
-        goto out;
-    }
-
     sprintf(procname, "%i", inode->fd);
-    fd =3D openat(lo->proc_self_fd, procname, O_RDWR);
-    if (fd < 0) {
-        saverr =3D errno;
-        goto out;
+    if (S_ISREG(inode->filetype) || S_ISDIR(inode->filetype)) {
+        fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
+        if (fd < 0) {
+            saverr =3D errno;
+            goto out;
+        }
+        ret =3D fsetxattr(fd, name, value, size, flags);
+    } else {
+        /* fchdir should not fail here */
+        assert(fchdir(lo->proc_self_fd) =3D=3D 0);
+        ret =3D setxattr(procname, name, value, size, flags);
+        assert(fchdir(lo->root.fd) =3D=3D 0);
     }
=20
-    ret =3D fsetxattr(fd, name, value, size, flags);
     saverr =3D ret =3D=3D -1 ? errno : 0;
=20
 out:
@@ -2383,20 +2393,21 @@ static void lo_removexattr(fuse_req_t req, fuse_ino=
_t ino, const char *name)
     fuse_log(FUSE_LOG_DEBUG, "lo_removexattr(ino=3D%" PRIu64 ", name=3D%s)=
\n", ino,
              name);
=20
-    if (inode->is_symlink) {
-        /* Sorry, no race free way to setxattr on symlink. */
-        saverr =3D EPERM;
-        goto out;
-    }
-
     sprintf(procname, "%i", inode->fd);
-    fd =3D openat(lo->proc_self_fd, procname, O_RDWR);
-    if (fd < 0) {
-        saverr =3D errno;
-        goto out;
+    if (S_ISREG(inode->filetype) || S_ISDIR(inode->filetype)) {
+        fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
+        if (fd < 0) {
+            saverr =3D errno;
+            goto out;
+        }
+        ret =3D fremovexattr(fd, name);
+    } else {
+        /* fchdir should not fail here */
+        assert(fchdir(lo->proc_self_fd) =3D=3D 0);
+        ret =3D removexattr(procname, name);
+        assert(fchdir(lo->root.fd) =3D=3D 0);
     }
=20
-    ret =3D fremovexattr(fd, name);
     saverr =3D ret =3D=3D -1 ? errno : 0;
=20
 out:
@@ -2796,7 +2807,7 @@ static void setup_root(struct lo_data *lo, struct lo_=
inode *root)
         exit(1);
     }
=20
-    root->is_symlink =3D false;
+    root->filetype =3D S_IFDIR;
     root->fd =3D fd;
     root->key.ino =3D stat.st_ino;
     root->key.dev =3D stat.st_dev;
diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
index 2d9d4a7ec0..bd9e7b083c 100644
--- a/tools/virtiofsd/seccomp.c
+++ b/tools/virtiofsd/seccomp.c
@@ -41,6 +41,7 @@ static const int syscall_whitelist[] =3D {
     SCMP_SYS(exit),
     SCMP_SYS(exit_group),
     SCMP_SYS(fallocate),
+    SCMP_SYS(fchdir),
     SCMP_SYS(fchmodat),
     SCMP_SYS(fchownat),
     SCMP_SYS(fcntl),
@@ -62,7 +63,9 @@ static const int syscall_whitelist[] =3D {
     SCMP_SYS(getpid),
     SCMP_SYS(gettid),
     SCMP_SYS(gettimeofday),
+    SCMP_SYS(getxattr),
     SCMP_SYS(linkat),
+    SCMP_SYS(listxattr),
     SCMP_SYS(lseek),
     SCMP_SYS(madvise),
     SCMP_SYS(mkdirat),
@@ -85,6 +88,7 @@ static const int syscall_whitelist[] =3D {
     SCMP_SYS(recvmsg),
     SCMP_SYS(renameat),
     SCMP_SYS(renameat2),
+    SCMP_SYS(removexattr),
     SCMP_SYS(rt_sigaction),
     SCMP_SYS(rt_sigprocmask),
     SCMP_SYS(rt_sigreturn),
@@ -98,10 +102,12 @@ static const int syscall_whitelist[] =3D {
     SCMP_SYS(setresuid32),
 #endif
     SCMP_SYS(set_robust_list),
+    SCMP_SYS(setxattr),
     SCMP_SYS(symlinkat),
     SCMP_SYS(time), /* Rarely needed, except on static builds */
     SCMP_SYS(tgkill),
     SCMP_SYS(unlinkat),
+    SCMP_SYS(unshare),
     SCMP_SYS(utimensat),
     SCMP_SYS(write),
     SCMP_SYS(writev),
--=20
2.24.1



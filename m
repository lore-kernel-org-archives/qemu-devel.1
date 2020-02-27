Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C9BC4BA06
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 05:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF51724672
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 05:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF51724672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7C5T-0000Gt-Uw
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 00:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1j7C4K-0007Sd-SP
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 00:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <misono.tomohiro@fujitsu.com>) id 1j7C4J-0000ts-1g
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 00:50:44 -0500
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:34544)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <misono.tomohiro@fujitsu.com>)
 id 1j7C4I-0000pU-BH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 00:50:42 -0500
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [192.168.231.132]) by
 mgwkm04.jp.fujitsu.com with smtp
 id 0687_5148_ad2c6a87_73a2_42f2_828c_5ed06e1c8d12;
 Thu, 27 Feb 2020 14:50:33 +0900
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
 (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 20091AC004F
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 14:50:32 +0900 (JST)
Received: from g01jpexchyt35.g01.fujitsu.local (unknown [10.128.193.4])
 by g01jpfmpwyt02.exch.g01.fujitsu.local (Postfix) with ESMTP id 234DF5842E0;
 Thu, 27 Feb 2020 14:50:31 +0900 (JST)
Received: from luna3.soft.fujitsu.com (10.124.196.199) by
 g01jpexchyt35.g01.fujitsu.local (10.128.193.50) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 14:50:31 +0900
From: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
To: <virtio-fs@redhat.com>
Subject: [PATCH v4 2/2] virtiofsd: Fix xattr operations
Date: Thu, 27 Feb 2020 14:59:27 +0900
Message-ID: <20200227055927.24566-3-misono.tomohiro@jp.fujitsu.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200227055927.24566-1-misono.tomohiro@jp.fujitsu.com>
References: <20200227055927.24566-1-misono.tomohiro@jp.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.219.69.171
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
Cc: qemu-devel@nongnu.org, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 tools/virtiofsd/fuse_virtio.c    |  13 ++++
 tools/virtiofsd/passthrough_ll.c | 105 +++++++++++++++++--------------
 tools/virtiofsd/seccomp.c        |   6 ++
 3 files changed, 77 insertions(+), 47 deletions(-)

diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
index 655b9a1413..21c5d76d58 100644
--- a/tools/virtiofsd/fuse_virtio.c
+++ b/tools/virtiofsd/fuse_virtio.c
@@ -463,6 +463,8 @@ err:
     return ret;
 }
 
+static __thread bool clone_fs_called;
+
 /* Process one FVRequest in a thread pool */
 static void fv_queue_worker(gpointer data, gpointer user_data)
 {
@@ -478,6 +480,17 @@ static void fv_queue_worker(gpointer data, gpointer user_data)
 
     assert(se->bufsize > sizeof(struct fuse_in_header));
 
+    if (!clone_fs_called) {
+        int ret;
+
+        /* unshare FS for xattr operation */
+        ret = unshare(CLONE_FS);
+        /* should not fail */
+        assert(ret == 0);
+
+        clone_fs_called = true;
+    }
+
     /*
      * An element contains one request and the space to send our response
      * They're spread over multiple descriptors in a scatter/gather set
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
index 7b94300ae0..9d325be8a5 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -130,7 +130,7 @@ struct lo_inode {
     pthread_mutex_t plock_mutex;
     GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
 
-    bool is_symlink;
+    mode_t filetype;
 };
 
 struct lo_cred {
@@ -734,7 +734,7 @@ static int utimensat_empty(struct lo_data *lo, struct lo_inode *inode,
     struct lo_inode *parent;
     char path[PATH_MAX];
 
-    if (inode->is_symlink) {
+    if (S_ISLNK(inode->filetype)) {
         res = utimensat(inode->fd, "", tv, AT_EMPTY_PATH);
         if (res == -1 && errno == EINVAL) {
             /* Sorry, no race free way to set times on symlink. */
@@ -1037,7 +1037,8 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *name,
             goto out_err;
         }
 
-        inode->is_symlink = S_ISLNK(e->attr.st_mode);
+        /* cache only filetype */
+        inode->filetype = (e->attr.st_mode & S_IFMT);
 
         /*
          * One for the caller and one for nlookup (released in
@@ -1264,7 +1265,7 @@ static int linkat_empty_nofollow(struct lo_data *lo, struct lo_inode *inode,
     struct lo_inode *parent;
     char path[PATH_MAX];
 
-    if (inode->is_symlink) {
+    if (S_ISLNK(inode->filetype)) {
         res = linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
         if (res == -1 && (errno == ENOENT || errno == EINVAL)) {
             /* Sorry, no race free way to hard-link a symlink. */
@@ -2378,12 +2379,6 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
     fuse_log(FUSE_LOG_DEBUG, "lo_getxattr(ino=%" PRIu64 ", name=%s size=%zd)\n",
              ino, name, size);
 
-    if (inode->is_symlink) {
-        /* Sorry, no race free way to getxattr on symlink. */
-        saverr = EPERM;
-        goto out;
-    }
-
     if (size) {
         value = malloc(size);
         if (!value) {
@@ -2392,12 +2387,25 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
     }
 
     sprintf(procname, "%i", inode->fd);
-    fd = openat(lo->proc_self_fd, procname, O_RDONLY);
-    if (fd < 0) {
-        goto out_err;
+    /*
+     * It is not safe to open() non-regular/non-dir files in file server
+     * unless O_PATH is used, so use that method for regular files/dir
+     * only (as it seems giving less performance overhead).
+     * Otherwise, call fchdir() to avoid open().
+     */
+    if (S_ISREG(inode->filetype) || S_ISDIR(inode->filetype)) {
+        fd = openat(lo->proc_self_fd, procname, O_RDONLY);
+        if (fd < 0) {
+            goto out_err;
+        }
+        ret = fgetxattr(fd, name, value, size);
+    } else {
+        /* fchdir should not fail here */
+        assert(fchdir(lo->proc_self_fd) == 0);
+        ret = getxattr(procname, name, value, size);
+        assert(fchdir(lo->root.fd) == 0);
     }
 
-    ret = fgetxattr(fd, name, value, size);
     if (ret == -1) {
         goto out_err;
     }
@@ -2451,12 +2459,6 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
     fuse_log(FUSE_LOG_DEBUG, "lo_listxattr(ino=%" PRIu64 ", size=%zd)\n", ino,
              size);
 
-    if (inode->is_symlink) {
-        /* Sorry, no race free way to listxattr on symlink. */
-        saverr = EPERM;
-        goto out;
-    }
-
     if (size) {
         value = malloc(size);
         if (!value) {
@@ -2465,12 +2467,19 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
     }
 
     sprintf(procname, "%i", inode->fd);
-    fd = openat(lo->proc_self_fd, procname, O_RDONLY);
-    if (fd < 0) {
-        goto out_err;
+    if (S_ISREG(inode->filetype) || S_ISDIR(inode->filetype)) {
+        fd = openat(lo->proc_self_fd, procname, O_RDONLY);
+        if (fd < 0) {
+            goto out_err;
+        }
+        ret = flistxattr(fd, value, size);
+    } else {
+        /* fchdir should not fail here */
+        assert(fchdir(lo->proc_self_fd) == 0);
+        ret = listxattr(procname, value, size);
+        assert(fchdir(lo->root.fd) == 0);
     }
 
-    ret = flistxattr(fd, value, size);
     if (ret == -1) {
         goto out_err;
     }
@@ -2524,20 +2533,21 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
     fuse_log(FUSE_LOG_DEBUG, "lo_setxattr(ino=%" PRIu64
              ", name=%s value=%s size=%zd)\n", ino, name, value, size);
 
-    if (inode->is_symlink) {
-        /* Sorry, no race free way to setxattr on symlink. */
-        saverr = EPERM;
-        goto out;
-    }
-
     sprintf(procname, "%i", inode->fd);
-    fd = openat(lo->proc_self_fd, procname, O_RDWR);
-    if (fd < 0) {
-        saverr = errno;
-        goto out;
+    if (S_ISREG(inode->filetype) || S_ISDIR(inode->filetype)) {
+        fd = openat(lo->proc_self_fd, procname, O_RDONLY);
+        if (fd < 0) {
+            saverr = errno;
+            goto out;
+        }
+        ret = fsetxattr(fd, name, value, size, flags);
+    } else {
+        /* fchdir should not fail here */
+        assert(fchdir(lo->proc_self_fd) == 0);
+        ret = setxattr(procname, name, value, size, flags);
+        assert(fchdir(lo->root.fd) == 0);
     }
 
-    ret = fsetxattr(fd, name, value, size, flags);
     saverr = ret == -1 ? errno : 0;
 
     if (!saverr) {
@@ -2575,20 +2585,21 @@ static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *name)
     fuse_log(FUSE_LOG_DEBUG, "lo_removexattr(ino=%" PRIu64 ", name=%s)\n", ino,
              name);
 
-    if (inode->is_symlink) {
-        /* Sorry, no race free way to setxattr on symlink. */
-        saverr = EPERM;
-        goto out;
-    }
-
     sprintf(procname, "%i", inode->fd);
-    fd = openat(lo->proc_self_fd, procname, O_RDWR);
-    if (fd < 0) {
-        saverr = errno;
-        goto out;
+    if (S_ISREG(inode->filetype) || S_ISDIR(inode->filetype)) {
+        fd = openat(lo->proc_self_fd, procname, O_RDONLY);
+        if (fd < 0) {
+            saverr = errno;
+            goto out;
+        }
+        ret = fremovexattr(fd, name);
+    } else {
+        /* fchdir should not fail here */
+        assert(fchdir(lo->proc_self_fd) == 0);
+        ret = removexattr(procname, name);
+        assert(fchdir(lo->root.fd) == 0);
     }
 
-    ret = fremovexattr(fd, name);
     saverr = ret == -1 ? errno : 0;
 
     if (!saverr) {
@@ -3185,7 +3196,7 @@ static void setup_root(struct lo_data *lo, struct lo_inode *root)
         exit(1);
     }
 
-    root->is_symlink = false;
+    root->filetype = S_IFDIR;
     root->fd = fd;
     root->key.ino = stat.st_ino;
     root->key.dev = stat.st_dev;
diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
index 2d9d4a7ec0..bd9e7b083c 100644
--- a/tools/virtiofsd/seccomp.c
+++ b/tools/virtiofsd/seccomp.c
@@ -41,6 +41,7 @@ static const int syscall_whitelist[] = {
     SCMP_SYS(exit),
     SCMP_SYS(exit_group),
     SCMP_SYS(fallocate),
+    SCMP_SYS(fchdir),
     SCMP_SYS(fchmodat),
     SCMP_SYS(fchownat),
     SCMP_SYS(fcntl),
@@ -62,7 +63,9 @@ static const int syscall_whitelist[] = {
     SCMP_SYS(getpid),
     SCMP_SYS(gettid),
     SCMP_SYS(gettimeofday),
+    SCMP_SYS(getxattr),
     SCMP_SYS(linkat),
+    SCMP_SYS(listxattr),
     SCMP_SYS(lseek),
     SCMP_SYS(madvise),
     SCMP_SYS(mkdirat),
@@ -85,6 +88,7 @@ static const int syscall_whitelist[] = {
     SCMP_SYS(recvmsg),
     SCMP_SYS(renameat),
     SCMP_SYS(renameat2),
+    SCMP_SYS(removexattr),
     SCMP_SYS(rt_sigaction),
     SCMP_SYS(rt_sigprocmask),
     SCMP_SYS(rt_sigreturn),
@@ -98,10 +102,12 @@ static const int syscall_whitelist[] = {
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
-- 
2.21.1



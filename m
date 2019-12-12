Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88021C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B52205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAEqK/uV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B52205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifS4O-00046b-Rj
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51514)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVp-0005zD-PM
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRVn-0002Rl-Ty
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58283
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRVn-0002QS-Og
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Md4HEI+JKquQebSpG0iwdaAY53lNqWDrE1Anrw0ZPg=;
 b=iAEqK/uV76t/9eDeGzL+xoLVbQk18bsvZqxFD999O/cFHi89XPPsc0b2l0+EpkDUD8FsBT
 fCaWJ0O4xfW9sXyS0Lb88ChxbvGj7KNbx4h3k0edaLLGXqZ1iEj+0JMVOMTYQi3L0HSYQS
 iQVo5BM+msq5JbJQ0lHcs5DCinrnIBo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-MYhU_j2VP0Oiv4OJK84Qjw-1; Thu, 12 Dec 2019 11:40:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03B6D477
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:40:21 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08E0260BE1;
 Thu, 12 Dec 2019 16:40:19 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 046/104] virtiofsd: use /proc/self/fd/ O_PATH file descriptor
Date: Thu, 12 Dec 2019 16:38:06 +0000
Message-Id: <20191212163904.159893-47-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: MYhU_j2VP0Oiv4OJK84Qjw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Sandboxing will remove /proc from the mount namespace so we can no
longer build string paths into "/proc/self/fd/...".

Keep an O_PATH file descriptor so we can still re-open fds via
/proc/self/fd.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 129 ++++++++++++++++++++++++-------
 1 file changed, 102 insertions(+), 27 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 123f095990..006908f25a 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -110,6 +110,9 @@ struct lo_data {
     struct lo_map ino_map; /* protected by lo->mutex */
     struct lo_map dirp_map; /* protected by lo->mutex */
     struct lo_map fd_map; /* protected by lo->mutex */
+
+    /* An O_PATH file descriptor to /proc/self/fd/ */
+    int proc_self_fd;
 };
=20
 static const struct fuse_opt lo_opts[] =3D {
@@ -379,9 +382,9 @@ static int lo_parent_and_name(struct lo_data *lo, struc=
t lo_inode *inode,
     int res;
=20
 retry:
-    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(procname, "%i", inode->fd);
=20
-    res =3D readlink(procname, path, PATH_MAX);
+    res =3D readlinkat(lo->proc_self_fd, procname, path, PATH_MAX);
     if (res < 0) {
         fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: readlink failed: %=
m\n");
         goto fail_noretry;
@@ -477,9 +480,9 @@ static int utimensat_empty(struct lo_data *lo, struct l=
o_inode *inode,
         }
         return res;
     }
-    sprintf(path, "/proc/self/fd/%i", inode->fd);
+    sprintf(path, "%i", inode->fd);
=20
-    return utimensat(AT_FDCWD, path, tv, 0);
+    return utimensat(lo->proc_self_fd, path, tv, 0);
=20
 fallback:
     res =3D lo_parent_and_name(lo, inode, path, &parent);
@@ -535,8 +538,8 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, =
struct stat *attr,
         if (fi) {
             res =3D fchmod(fd, attr->st_mode);
         } else {
-            sprintf(procname, "/proc/self/fd/%i", ifd);
-            res =3D chmod(procname, attr->st_mode);
+            sprintf(procname, "%i", ifd);
+            res =3D fchmodat(lo->proc_self_fd, procname, attr->st_mode, 0)=
;
         }
         if (res =3D=3D -1) {
             goto out_err;
@@ -552,11 +555,23 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino=
, struct stat *attr,
         }
     }
     if (valid & FUSE_SET_ATTR_SIZE) {
+        int truncfd;
+
         if (fi) {
-            res =3D ftruncate(fd, attr->st_size);
+            truncfd =3D fd;
         } else {
-            sprintf(procname, "/proc/self/fd/%i", ifd);
-            res =3D truncate(procname, attr->st_size);
+            sprintf(procname, "%i", ifd);
+            truncfd =3D openat(lo->proc_self_fd, procname, O_RDWR);
+            if (truncfd < 0) {
+                goto out_err;
+            }
+        }
+
+        res =3D ftruncate(truncfd, attr->st_size);
+        if (!fi) {
+            saverr =3D errno;
+            close(truncfd);
+            errno =3D saverr;
         }
         if (res =3D=3D -1) {
             goto out_err;
@@ -857,9 +872,9 @@ static int linkat_empty_nofollow(struct lo_data *lo, st=
ruct lo_inode *inode,
         return res;
     }
=20
-    sprintf(path, "/proc/self/fd/%i", inode->fd);
+    sprintf(path, "%i", inode->fd);
=20
-    return linkat(AT_FDCWD, path, dfd, name, AT_SYMLINK_FOLLOW);
+    return linkat(lo->proc_self_fd, path, dfd, name, AT_SYMLINK_FOLLOW);
=20
 fallback:
     res =3D lo_parent_and_name(lo, inode, path, &parent);
@@ -1387,8 +1402,8 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, s=
truct fuse_file_info *fi)
         fi->flags &=3D ~O_APPEND;
     }
=20
-    sprintf(buf, "/proc/self/fd/%i", lo_fd(req, ino));
-    fd =3D open(buf, fi->flags & ~O_NOFOLLOW);
+    sprintf(buf, "%i", lo_fd(req, ino));
+    fd =3D openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
     if (fd =3D=3D -1) {
         return (void)fuse_reply_err(req, errno);
     }
@@ -1440,8 +1455,8 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
 static void lo_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
                      struct fuse_file_info *fi)
 {
+    struct lo_data *lo =3D lo_data(req);
     int res;
-    (void)ino;
     int fd;
     char *buf;
=20
@@ -1449,12 +1464,12 @@ static void lo_fsync(fuse_req_t req, fuse_ino_t ino=
, int datasync,
              (void *)fi);
=20
     if (!fi) {
-        res =3D asprintf(&buf, "/proc/self/fd/%i", lo_fd(req, ino));
+        res =3D asprintf(&buf, "%i", lo_fd(req, ino));
         if (res =3D=3D -1) {
             return (void)fuse_reply_err(req, errno);
         }
=20
-        fd =3D open(buf, O_RDWR);
+        fd =3D openat(lo->proc_self_fd, buf, O_RDWR);
         free(buf);
         if (fd =3D=3D -1) {
             return (void)fuse_reply_err(req, errno);
@@ -1570,11 +1585,13 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino=
, struct fuse_file_info *fi,
 static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
                         size_t size)
 {
+    struct lo_data *lo =3D lo_data(req);
     char *value =3D NULL;
     char procname[64];
     struct lo_inode *inode;
     ssize_t ret;
     int saverr;
+    int fd =3D -1;
=20
     inode =3D lo_inode(req, ino);
     if (!inode) {
@@ -1599,7 +1616,11 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
         goto out;
     }
=20
-    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(procname, "%i", inode->fd);
+    fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
+    if (fd < 0) {
+        goto out_err;
+    }
=20
     if (size) {
         value =3D malloc(size);
@@ -1607,7 +1628,7 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t in=
o, const char *name,
             goto out_err;
         }
=20
-        ret =3D getxattr(procname, name, value, size);
+        ret =3D fgetxattr(fd, name, value, size);
         if (ret =3D=3D -1) {
             goto out_err;
         }
@@ -1618,7 +1639,7 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t in=
o, const char *name,
=20
         fuse_reply_buf(req, value, ret);
     } else {
-        ret =3D getxattr(procname, name, NULL, 0);
+        ret =3D fgetxattr(fd, name, NULL, 0);
         if (ret =3D=3D -1) {
             goto out_err;
         }
@@ -1627,6 +1648,10 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
     }
 out_free:
     free(value);
+
+    if (fd >=3D 0) {
+        close(fd);
+    }
     return;
=20
 out_err:
@@ -1638,11 +1663,13 @@ out:
=20
 static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
 {
+    struct lo_data *lo =3D lo_data(req);
     char *value =3D NULL;
     char procname[64];
     struct lo_inode *inode;
     ssize_t ret;
     int saverr;
+    int fd =3D -1;
=20
     inode =3D lo_inode(req, ino);
     if (!inode) {
@@ -1666,7 +1693,11 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t =
ino, size_t size)
         goto out;
     }
=20
-    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(procname, "%i", inode->fd);
+    fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
+    if (fd < 0) {
+        goto out_err;
+    }
=20
     if (size) {
         value =3D malloc(size);
@@ -1674,7 +1705,7 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t i=
no, size_t size)
             goto out_err;
         }
=20
-        ret =3D listxattr(procname, value, size);
+        ret =3D flistxattr(fd, value, size);
         if (ret =3D=3D -1) {
             goto out_err;
         }
@@ -1685,7 +1716,7 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t i=
no, size_t size)
=20
         fuse_reply_buf(req, value, ret);
     } else {
-        ret =3D listxattr(procname, NULL, 0);
+        ret =3D flistxattr(fd, NULL, 0);
         if (ret =3D=3D -1) {
             goto out_err;
         }
@@ -1694,6 +1725,10 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t =
ino, size_t size)
     }
 out_free:
     free(value);
+
+    if (fd >=3D 0) {
+        close(fd);
+    }
     return;
=20
 out_err:
@@ -1707,9 +1742,11 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
                         const char *value, size_t size, int flags)
 {
     char procname[64];
+    struct lo_data *lo =3D lo_data(req);
     struct lo_inode *inode;
     ssize_t ret;
     int saverr;
+    int fd =3D -1;
=20
     inode =3D lo_inode(req, ino);
     if (!inode) {
@@ -1734,21 +1771,31 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
         goto out;
     }
=20
-    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(procname, "%i", inode->fd);
+    fd =3D openat(lo->proc_self_fd, procname, O_RDWR);
+    if (fd < 0) {
+        saverr =3D errno;
+        goto out;
+    }
=20
-    ret =3D setxattr(procname, name, value, size, flags);
+    ret =3D fsetxattr(fd, name, value, size, flags);
     saverr =3D ret =3D=3D -1 ? errno : 0;
=20
 out:
+    if (fd >=3D 0) {
+        close(fd);
+    }
     fuse_reply_err(req, saverr);
 }
=20
 static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *nam=
e)
 {
     char procname[64];
+    struct lo_data *lo =3D lo_data(req);
     struct lo_inode *inode;
     ssize_t ret;
     int saverr;
+    int fd =3D -1;
=20
     inode =3D lo_inode(req, ino);
     if (!inode) {
@@ -1772,12 +1819,20 @@ static void lo_removexattr(fuse_req_t req, fuse_ino=
_t ino, const char *name)
         goto out;
     }
=20
-    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(procname, "%i", inode->fd);
+    fd =3D openat(lo->proc_self_fd, procname, O_RDWR);
+    if (fd < 0) {
+        saverr =3D errno;
+        goto out;
+    }
=20
-    ret =3D removexattr(procname, name);
+    ret =3D fremovexattr(fd, name);
     saverr =3D ret =3D=3D -1 ? errno : 0;
=20
 out:
+    if (fd >=3D 0) {
+        close(fd);
+    }
     fuse_reply_err(req, saverr);
 }
=20
@@ -1870,12 +1925,25 @@ static void print_capabilities(void)
     printf("}\n");
 }
=20
+static void setup_proc_self_fd(struct lo_data *lo)
+{
+    lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
+    if (lo->proc_self_fd =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "open(/proc/self/fd, O_PATH): %m\n");
+        exit(1);
+    }
+}
+
 int main(int argc, char *argv[])
 {
     struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
     struct fuse_session *se;
     struct fuse_cmdline_opts opts;
-    struct lo_data lo =3D { .debug =3D 0, .writeback =3D 0 };
+    struct lo_data lo =3D {
+        .debug =3D 0,
+        .writeback =3D 0,
+        .proc_self_fd =3D -1,
+    };
     struct lo_map_elem *root_elem;
     int ret =3D -1;
=20
@@ -1986,6 +2054,9 @@ int main(int argc, char *argv[])
=20
     fuse_daemonize(opts.foreground);
=20
+    /* Must be after daemonize to get the right /proc/self/fd */
+    setup_proc_self_fd(&lo);
+
     /* Block until ctrl+c or fusermount -u */
     ret =3D virtio_loop(se);
=20
@@ -2001,6 +2072,10 @@ err_out1:
     lo_map_destroy(&lo.dirp_map);
     lo_map_destroy(&lo.ino_map);
=20
+    if (lo.proc_self_fd >=3D 0) {
+        close(lo.proc_self_fd);
+    }
+
     if (lo.root.fd >=3D 0) {
         close(lo.root.fd);
     }
--=20
2.23.0



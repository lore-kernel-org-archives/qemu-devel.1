Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34899C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECA3522464
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwLS7/ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA3522464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhh0-0000Hw-LR
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:59:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufe2-00052N-8M
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufe0-0006ac-Aw
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24839
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufe0-0006aU-89
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rocNf17Cmm6LMNLAi+Vk5YilItERbDJCMjcMFpiQKVM=;
 b=UwLS7/tso7hoCGwS1mIy94rCM4C6m7JllDJdA4bFpeki4Ni5wb8LLrzGb6g3WOgSSgnCUd
 6eV1iY8yre0tP7sgS6oU24kS9Cv42A+0cd2bakEdTYn4xCg0fNuI5azmKktvymTa+Sf1sz
 f6JpooJo/XRSz6cfL/CEEh1wDyojW8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-z4fsLo-zOdG7ioVPq4GipQ-1; Thu, 23 Jan 2020 11:47:46 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70E3F8024F7
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:45 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB13528994;
 Thu, 23 Jan 2020 16:47:44 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 048/108] virtiofsd: use /proc/self/fd/ O_PATH file descriptor
Date: Thu, 23 Jan 2020 16:45:30 +0000
Message-Id: <20200123164630.91498-49-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: z4fsLo-zOdG7ioVPq4GipQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Sandboxing will remove /proc from the mount namespace so we can no
longer build string paths into "/proc/self/fd/...".

Keep an O_PATH file descriptor so we can still re-open fds via
/proc/self/fd.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 130 ++++++++++++++++++++++++-------
 1 file changed, 103 insertions(+), 27 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index e3d65c3676..e2e2211ea1 100644
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
         fuse_log(FUSE_LOG_WARNING, "%s: readlink failed: %m\n", __func__);
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
@@ -874,9 +889,9 @@ static int linkat_empty_nofollow(struct lo_data *lo, st=
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
@@ -1404,8 +1419,8 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, s=
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
@@ -1458,7 +1473,6 @@ static void lo_fsync(fuse_req_t req, fuse_ino_t ino, =
int datasync,
                      struct fuse_file_info *fi)
 {
     int res;
-    (void)ino;
     int fd;
     char *buf;
=20
@@ -1466,12 +1480,14 @@ static void lo_fsync(fuse_req_t req, fuse_ino_t ino=
, int datasync,
              (void *)fi);
=20
     if (!fi) {
-        res =3D asprintf(&buf, "/proc/self/fd/%i", lo_fd(req, ino));
+        struct lo_data *lo =3D lo_data(req);
+
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
@@ -1587,11 +1603,13 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino=
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
@@ -1616,7 +1634,11 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t i=
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
@@ -1624,7 +1646,7 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t in=
o, const char *name,
             goto out_err;
         }
=20
-        ret =3D getxattr(procname, name, value, size);
+        ret =3D fgetxattr(fd, name, value, size);
         if (ret =3D=3D -1) {
             goto out_err;
         }
@@ -1635,7 +1657,7 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t in=
o, const char *name,
=20
         fuse_reply_buf(req, value, ret);
     } else {
-        ret =3D getxattr(procname, name, NULL, 0);
+        ret =3D fgetxattr(fd, name, NULL, 0);
         if (ret =3D=3D -1) {
             goto out_err;
         }
@@ -1644,6 +1666,10 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t i=
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
@@ -1655,11 +1681,13 @@ out:
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
@@ -1683,7 +1711,11 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t =
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
@@ -1691,7 +1723,7 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t i=
no, size_t size)
             goto out_err;
         }
=20
-        ret =3D listxattr(procname, value, size);
+        ret =3D flistxattr(fd, value, size);
         if (ret =3D=3D -1) {
             goto out_err;
         }
@@ -1702,7 +1734,7 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t i=
no, size_t size)
=20
         fuse_reply_buf(req, value, ret);
     } else {
-        ret =3D listxattr(procname, NULL, 0);
+        ret =3D flistxattr(fd, NULL, 0);
         if (ret =3D=3D -1) {
             goto out_err;
         }
@@ -1711,6 +1743,10 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t =
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
@@ -1724,9 +1760,11 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t i=
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
@@ -1751,21 +1789,31 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t =
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
@@ -1789,12 +1837,20 @@ static void lo_removexattr(fuse_req_t req, fuse_ino=
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
@@ -1887,12 +1943,25 @@ static void print_capabilities(void)
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
@@ -2003,6 +2072,9 @@ int main(int argc, char *argv[])
=20
     fuse_daemonize(opts.foreground);
=20
+    /* Must be after daemonize to get the right /proc/self/fd */
+    setup_proc_self_fd(&lo);
+
     /* Block until ctrl+c or fusermount -u */
     ret =3D virtio_loop(se);
=20
@@ -2018,6 +2090,10 @@ err_out1:
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
2.24.1



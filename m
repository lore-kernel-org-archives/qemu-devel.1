Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C92CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E81212084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsqTt+Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81212084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNczI-0005TT-Ke
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbID-0003oK-Ai
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIB-00006i-An
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIB-00005C-5S
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zat1t+hKG0Zk8YyYdD8I3eOrGeDc/SeMU3HKQTfuqnA=;
 b=NsqTt+UndQeVu2T1BsDPz3mjbx8VLxBBcvM6YPAv+b4DjJr5Xig+nvVH8AA1BMM4etO5mr
 80GkAukxPpZsah+JFconR6fucjV2FgGR1G/MZCrmmgUtCoiQvtCMr3ZfaUnQ3r64tuOLmI
 yxXdTkBKk8vviAGtOsk0qhqQqBqmLRw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-HpkeFZk8O3mtTFlMMPJkRQ-1; Thu, 24 Oct 2019 07:28:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 092FE107AD31;
 Thu, 24 Oct 2019 11:28:27 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81FD44524;
 Thu, 24 Oct 2019 11:28:24 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 15/25] virtiofsd: use /proc/self/fd/ O_PATH file descriptor
Date: Thu, 24 Oct 2019 12:27:08 +0100
Message-Id: <20191024112718.34657-16-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HpkeFZk8O3mtTFlMMPJkRQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 contrib/virtiofsd/passthrough_ll.c | 128 +++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 27 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index cb01e3f088..3ddf22d162 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -110,6 +110,9 @@ struct lo_data {
 =09struct lo_map ino_map; /* protected by lo->mutex */
 =09struct lo_map dirp_map; /* protected by lo->mutex */
 =09struct lo_map fd_map; /* protected by lo->mutex */
+
+=09/* An O_PATH file descriptor to /proc/self/fd/ */
+=09int proc_self_fd;
 };
=20
 static const struct fuse_opt lo_opts[] =3D {
@@ -378,9 +381,9 @@ static int lo_parent_and_name(struct lo_data *lo, struc=
t lo_inode *inode,
 =09int res;
=20
 retry:
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+=09sprintf(procname, "%i", inode->fd);
=20
-=09res =3D readlink(procname, path, PATH_MAX);
+=09res =3D readlinkat(lo->proc_self_fd, procname, path, PATH_MAX);
 =09if (res < 0) {
 =09=09fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: readlink failed: %m\=
n");
 =09=09goto fail_noretry;
@@ -465,9 +468,9 @@ static int utimensat_empty(struct lo_data *lo, struct l=
o_inode *inode,
 =09=09}
 =09=09return res;
 =09}
-=09sprintf(path, "/proc/self/fd/%i", inode->fd);
+=09sprintf(path, "%i", inode->fd);
=20
-=09return utimensat(AT_FDCWD, path, tv, 0);
+=09return utimensat(lo->proc_self_fd, path, tv, 0);
=20
 fallback:
 =09res =3D lo_parent_and_name(lo, inode, path, &parent);
@@ -521,8 +524,9 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, =
struct stat *attr,
 =09=09if (fi) {
 =09=09=09res =3D fchmod(fd, attr->st_mode);
 =09=09} else {
-=09=09=09sprintf(procname, "/proc/self/fd/%i", ifd);
-=09=09=09res =3D chmod(procname, attr->st_mode);
+=09=09=09sprintf(procname, "%i", ifd);
+=09=09=09res =3D fchmodat(lo->proc_self_fd, procname,
+=09=09=09=09       attr->st_mode, 0);
 =09=09}
 =09=09if (res =3D=3D -1)
 =09=09=09goto out_err;
@@ -539,11 +543,23 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino=
, struct stat *attr,
 =09=09=09goto out_err;
 =09}
 =09if (valid & FUSE_SET_ATTR_SIZE) {
+=09=09int truncfd;
+
 =09=09if (fi) {
-=09=09=09res =3D ftruncate(fd, attr->st_size);
+=09=09=09truncfd =3D fd;
 =09=09} else {
-=09=09=09sprintf(procname, "/proc/self/fd/%i", ifd);
-=09=09=09res =3D truncate(procname, attr->st_size);
+=09=09=09sprintf(procname, "%i", ifd);
+=09=09=09truncfd =3D openat(lo->proc_self_fd, procname, O_RDWR);
+=09=09=09if (truncfd < 0) {
+=09=09=09=09goto out_err;
+=09=09=09}
+=09=09}
+
+=09=09res =3D ftruncate(truncfd, attr->st_size);
+=09=09if (!fi) {
+=09=09=09saverr =3D errno;
+=09=09=09close(truncfd);
+=09=09=09errno =3D saverr;
 =09=09}
 =09=09if (res =3D=3D -1)
 =09=09=09goto out_err;
@@ -825,9 +841,9 @@ static int linkat_empty_nofollow(struct lo_data *lo, st=
ruct lo_inode *inode,
 =09=09return res;
 =09}
=20
-=09sprintf(path, "/proc/self/fd/%i", inode->fd);
+=09sprintf(path, "%i", inode->fd);
=20
-=09return linkat(AT_FDCWD, path, dfd, name, AT_SYMLINK_FOLLOW);
+=09return linkat(lo->proc_self_fd, path, dfd, name, AT_SYMLINK_FOLLOW);
=20
 fallback:
 =09res =3D lo_parent_and_name(lo, inode, path, &parent);
@@ -1325,8 +1341,8 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, s=
truct fuse_file_info *fi)
 =09if (lo->writeback && (fi->flags & O_APPEND))
 =09=09fi->flags &=3D ~O_APPEND;
=20
-=09sprintf(buf, "/proc/self/fd/%i", lo_fd(req, ino));
-=09fd =3D open(buf, fi->flags & ~O_NOFOLLOW);
+=09sprintf(buf, "%i", lo_fd(req, ino));
+=09fd =3D openat(lo->proc_self_fd, buf, fi->flags & ~O_NOFOLLOW);
 =09if (fd =3D=3D -1)
 =09=09return (void) fuse_reply_err(req, errno);
=20
@@ -1375,8 +1391,8 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
 static void lo_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
 =09=09     struct fuse_file_info *fi)
 {
+=09struct lo_data *lo =3D lo_data(req);
 =09int res;
-=09(void) ino;
 =09int fd;
 =09char *buf;
=20
@@ -1384,11 +1400,11 @@ static void lo_fsync(fuse_req_t req, fuse_ino_t ino=
, int datasync,
 =09=09 (void *)fi);
=20
 =09if (!fi) {
-=09=09res =3D asprintf(&buf, "/proc/self/fd/%i", lo_fd(req, ino));
+=09=09res =3D asprintf(&buf, "%i", lo_fd(req, ino));
 =09=09if (res =3D=3D -1)
 =09=09=09return (void) fuse_reply_err(req, errno);
=20
-=09=09fd =3D open(buf, O_RDWR);
+=09=09fd =3D openat(lo->proc_self_fd, buf, O_RDWR);
 =09=09free(buf);
 =09=09if (fd =3D=3D -1)
 =09=09=09return (void) fuse_reply_err(req, errno);
@@ -1493,11 +1509,13 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino=
, struct fuse_file_info *fi,
 static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
 =09=09=09size_t size)
 {
+=09struct lo_data *lo =3D lo_data(req);
 =09char *value =3D NULL;
 =09char procname[64];
 =09struct lo_inode *inode;
 =09ssize_t ret;
 =09int saverr;
+=09int fd =3D -1;
=20
 =09inode =3D lo_inode(req, ino);
 =09if (!inode) {
@@ -1520,14 +1538,18 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
 =09=09goto out;
 =09}
=20
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+=09sprintf(procname, "%i", inode->fd);
+=09fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
+=09if (fd < 0) {
+=09=09goto out_err;
+=09}
=20
 =09if (size) {
 =09=09value =3D malloc(size);
 =09=09if (!value)
 =09=09=09goto out_err;
=20
-=09=09ret =3D getxattr(procname, name, value, size);
+=09=09ret =3D fgetxattr(fd, name, value, size);
 =09=09if (ret =3D=3D -1)
 =09=09=09goto out_err;
 =09=09saverr =3D 0;
@@ -1536,7 +1558,7 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t in=
o, const char *name,
=20
 =09=09fuse_reply_buf(req, value, ret);
 =09} else {
-=09=09ret =3D getxattr(procname, name, NULL, 0);
+=09=09ret =3D fgetxattr(fd, name, NULL, 0);
 =09=09if (ret =3D=3D -1)
 =09=09=09goto out_err;
=20
@@ -1544,6 +1566,10 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
 =09}
 out_free:
 =09free(value);
+
+=09if (fd >=3D 0) {
+=09=09close(fd);
+=09}
 =09return;
=20
 out_err:
@@ -1555,11 +1581,13 @@ out:
=20
 static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
 {
+=09struct lo_data *lo =3D lo_data(req);
 =09char *value =3D NULL;
 =09char procname[64];
 =09struct lo_inode *inode;
 =09ssize_t ret;
 =09int saverr;
+=09int fd =3D -1;
=20
 =09inode =3D lo_inode(req, ino);
 =09if (!inode) {
@@ -1582,14 +1610,18 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t=
 ino, size_t size)
 =09=09goto out;
 =09}
=20
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+=09sprintf(procname, "%i", inode->fd);
+=09fd =3D openat(lo->proc_self_fd, procname, O_RDONLY);
+=09if (fd < 0) {
+=09=09goto out_err;
+=09}
=20
 =09if (size) {
 =09=09value =3D malloc(size);
 =09=09if (!value)
 =09=09=09goto out_err;
=20
-=09=09ret =3D listxattr(procname, value, size);
+=09=09ret =3D flistxattr(fd, value, size);
 =09=09if (ret =3D=3D -1)
 =09=09=09goto out_err;
 =09=09saverr =3D 0;
@@ -1598,7 +1630,7 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t i=
no, size_t size)
=20
 =09=09fuse_reply_buf(req, value, ret);
 =09} else {
-=09=09ret =3D listxattr(procname, NULL, 0);
+=09=09ret =3D flistxattr(fd, NULL, 0);
 =09=09if (ret =3D=3D -1)
 =09=09=09goto out_err;
=20
@@ -1606,6 +1638,10 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t =
ino, size_t size)
 =09}
 out_free:
 =09free(value);
+
+=09if (fd >=3D 0) {
+=09=09close(fd);
+=09}
 =09return;
=20
 out_err:
@@ -1619,9 +1655,11 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t i=
no, const char *name,
 =09=09=09const char *value, size_t size, int flags)
 {
 =09char procname[64];
+=09struct lo_data *lo =3D lo_data(req);
 =09struct lo_inode *inode;
 =09ssize_t ret;
 =09int saverr;
+=09int fd =3D -1;
=20
 =09inode =3D lo_inode(req, ino);
 =09if (!inode) {
@@ -1644,21 +1682,31 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
 =09=09goto out;
 =09}
=20
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+=09sprintf(procname, "%i", inode->fd);
+=09fd =3D openat(lo->proc_self_fd, procname, O_RDWR);
+=09if (fd < 0) {
+=09=09saverr =3D errno;
+=09=09goto out;
+=09}
=20
-=09ret =3D setxattr(procname, name, value, size, flags);
+=09ret =3D fsetxattr(fd, name, value, size, flags);
 =09saverr =3D ret =3D=3D -1 ? errno : 0;
=20
 out:
+=09if (fd >=3D 0) {
+=09=09close(fd);
+=09}
 =09fuse_reply_err(req, saverr);
 }
=20
 static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *nam=
e)
 {
 =09char procname[64];
+=09struct lo_data *lo =3D lo_data(req);
 =09struct lo_inode *inode;
 =09ssize_t ret;
 =09int saverr;
+=09int fd =3D -1;
=20
 =09inode =3D lo_inode(req, ino);
 =09if (!inode) {
@@ -1681,12 +1729,20 @@ static void lo_removexattr(fuse_req_t req, fuse_ino=
_t ino, const char *name)
 =09=09goto out;
 =09}
=20
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+=09sprintf(procname, "%i", inode->fd);
+=09fd =3D openat(lo->proc_self_fd, procname, O_RDWR);
+=09if (fd < 0) {
+=09=09saverr =3D errno;
+=09=09goto out;
+=09}
=20
-=09ret =3D removexattr(procname, name);
+=09ret =3D fremovexattr(fd, name);
 =09saverr =3D ret =3D=3D -1 ? errno : 0;
=20
 out:
+=09if (fd >=3D 0) {
+=09=09close(fd);
+=09}
 =09fuse_reply_err(req, saverr);
 }
=20
@@ -1765,13 +1821,24 @@ static void print_capabilities(void)
 =09printf("}\n");
 }
=20
+static void setup_proc_self_fd(struct lo_data *lo)
+{
+=09lo->proc_self_fd =3D open("/proc/self/fd", O_PATH);
+=09if (lo->proc_self_fd =3D=3D -1) {
+=09=09fuse_log(FUSE_LOG_ERR, "open(/proc/self/fd, O_PATH): %m\n");
+=09=09exit(1);
+=09}
+}
+
 int main(int argc, char *argv[])
 {
 =09struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
 =09struct fuse_session *se;
 =09struct fuse_cmdline_opts opts;
 =09struct lo_data lo =3D { .debug =3D 0,
-=09                      .writeback =3D 0 };
+=09                      .writeback =3D 0,
+=09                      .proc_self_fd =3D -1,
+=09};
 =09struct lo_map_elem *root_elem;
 =09int ret =3D -1;
=20
@@ -1878,6 +1945,9 @@ int main(int argc, char *argv[])
=20
 =09fuse_daemonize(opts.foreground);
=20
+=09/* Must be after daemonize to get the right /proc/self/fd */
+=09setup_proc_self_fd(&lo);
+
 =09/* Block until ctrl+c or fusermount -u */
 =09ret =3D virtio_loop(se);
=20
@@ -1893,6 +1963,10 @@ err_out1:
 =09lo_map_destroy(&lo.dirp_map);
 =09lo_map_destroy(&lo.ino_map);
=20
+=09if (lo.proc_self_fd >=3D 0) {
+=09=09close(lo.proc_self_fd);
+=09}
+
 =09if (lo.root.fd >=3D 0)
 =09=09close(lo.root.fd);
=20
--=20
2.23.0



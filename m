Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3784DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0041820856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hr9IPC/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0041820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbz4-0007sa-ID
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHX-0002MP-0A
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHU-0008NN-Cr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33757
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHU-0008N5-8f
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmdeBxGXJeXKGEo7YlK7OvPYcpMZQjpGIwy7oqHxlkg=;
 b=hr9IPC/6Ls4y7udWpPdll8bv4DsZ4CRorzx28yqth1sfIS7jJl3KXRjoW0b7VTVNOwvaiG
 P0sRU/RWOgRAlx43plEXz+B0bH9WHn+QQED5nR2ZiBXvN869jyYYKI/c+lPJAak0M0NPEI
 tT6OnfgY0w1KikrbD/opba38wyTwVOE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-i-rabJQhPwmiND5h1IXgng-1; Thu, 24 Oct 2019 07:27:47 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71EDF800D4C;
 Thu, 24 Oct 2019 11:27:46 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29177166A0;
 Thu, 24 Oct 2019 11:27:39 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 05/25] virtiofsd: passthrough_ll: add fd_map to hide file
 descriptors
Date: Thu, 24 Oct 2019 12:26:58 +0100
Message-Id: <20191024112718.34657-6-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: i-rabJQhPwmiND5h1IXgng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Do not expose file descriptor numbers to clients.  This prevents the
abuse of internal file descriptors (like stdin/stdout).

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 113 +++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 21 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 9f82166079..a71fbff143 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -60,6 +60,7 @@ struct lo_map_elem {
 =09union {
 =09=09struct lo_inode *inode;
 =09=09struct lo_dirp *dirp;
+=09=09int fd;
 =09=09ssize_t freelist;
 =09};
 =09bool in_use;
@@ -107,6 +108,7 @@ struct lo_data {
 =09struct lo_inode root; /* protected by lo->mutex */
 =09struct lo_map ino_map; /* protected by lo->mutex */
 =09struct lo_map dirp_map; /* protected by lo->mutex */
+=09struct lo_map fd_map; /* protected by lo->mutex */
 };
=20
 static const struct fuse_opt lo_opts[] =3D {
@@ -241,6 +243,19 @@ static void lo_map_remove(struct lo_map *map, size_t k=
ey)
 =09map->freelist =3D key;
 }
=20
+/* Assumes lo->mutex is held */
+static ssize_t lo_add_fd_mapping(fuse_req_t req, int fd)
+{
+=09struct lo_map_elem *elem;
+
+=09elem =3D lo_map_alloc_elem(&lo_data(req)->fd_map);
+=09if (!elem)
+=09=09return -1;
+
+=09elem->fd =3D fd;
+=09return elem - lo_data(req)->fd_map.elems;
+}
+
 /* Assumes lo->mutex is held */
 static ssize_t lo_add_dirp_mapping(fuse_req_t req, struct lo_dirp *dirp)
 {
@@ -350,6 +365,21 @@ static int utimensat_empty_nofollow(struct lo_inode *i=
node,
 =09return utimensat(AT_FDCWD, procname, tv, 0);
 }
=20
+static int lo_fi_fd(fuse_req_t req, struct fuse_file_info *fi)
+{
+=09struct lo_data *lo =3D lo_data(req);
+=09struct lo_map_elem *elem;
+
+=09pthread_mutex_lock(&lo->mutex);
+=09elem =3D lo_map_get(&lo->fd_map, fi->fh);
+=09pthread_mutex_unlock(&lo->mutex);
+
+=09if (!elem)
+=09=09return -1;
+
+=09return elem->fd;
+}
+
 static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
 =09=09       int valid, struct fuse_file_info *fi)
 {
@@ -358,6 +388,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, =
struct stat *attr,
 =09struct lo_inode *inode;
 =09int ifd;
 =09int res;
+=09int fd;
=20
 =09inode =3D lo_inode(req, ino);
 =09if (!inode) {
@@ -367,9 +398,13 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino,=
 struct stat *attr,
=20
 =09ifd =3D inode->fd;
=20
+=09/* If fi->fh is invalid we'll report EBADF later */
+=09if (fi)
+=09=09fd =3D lo_fi_fd(req, fi);
+
 =09if (valid & FUSE_SET_ATTR_MODE) {
 =09=09if (fi) {
-=09=09=09res =3D fchmod(fi->fh, attr->st_mode);
+=09=09=09res =3D fchmod(fd, attr->st_mode);
 =09=09} else {
 =09=09=09sprintf(procname, "/proc/self/fd/%i", ifd);
 =09=09=09res =3D chmod(procname, attr->st_mode);
@@ -390,7 +425,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, =
struct stat *attr,
 =09}
 =09if (valid & FUSE_SET_ATTR_SIZE) {
 =09=09if (fi) {
-=09=09=09res =3D ftruncate(fi->fh, attr->st_size);
+=09=09=09res =3D ftruncate(fd, attr->st_size);
 =09=09} else {
 =09=09=09sprintf(procname, "/proc/self/fd/%i", ifd);
 =09=09=09res =3D truncate(procname, attr->st_size);
@@ -417,7 +452,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, =
struct stat *attr,
 =09=09=09tv[1] =3D attr->st_mtim;
=20
 =09=09if (fi)
-=09=09=09res =3D futimens(fi->fh, tv);
+=09=09=09res =3D futimens(fd, tv);
 =09=09else
 =09=09=09res =3D utimensat_empty_nofollow(inode, tv);
 =09=09if (res =3D=3D -1)
@@ -1041,7 +1076,18 @@ static void lo_create(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
 =09lo_restore_cred(&old);
=20
 =09if (!err) {
-=09=09fi->fh =3D fd;
+=09=09ssize_t fh;
+
+=09=09pthread_mutex_lock(&lo->mutex);
+=09=09fh =3D lo_add_fd_mapping(req, fd);
+=09=09pthread_mutex_unlock(&lo->mutex);
+=09=09if (fh =3D=3D -1) {
+=09=09=09close(fd);
+=09=09=09fuse_reply_err(req, ENOMEM);
+=09=09=09return;
+=09=09}
+
+=09=09fi->fh =3D fh;
 =09=09err =3D lo_do_lookup(req, parent, name, &e);
 =09}
 =09if (lo->cache =3D=3D CACHE_NEVER)
@@ -1082,6 +1128,7 @@ static void lo_fsyncdir(fuse_req_t req, fuse_ino_t in=
o, int datasync,
 static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info =
*fi)
 {
 =09int fd;
+=09ssize_t fh;
 =09char buf[64];
 =09struct lo_data *lo =3D lo_data(req);
=20
@@ -1110,7 +1157,16 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
 =09if (fd =3D=3D -1)
 =09=09return (void) fuse_reply_err(req, errno);
=20
-=09fi->fh =3D fd;
+=09pthread_mutex_lock(&lo->mutex);
+=09fh =3D lo_add_fd_mapping(req, fd);
+=09pthread_mutex_unlock(&lo->mutex);
+=09if (fh =3D=3D -1) {
+=09=09close(fd);
+=09=09fuse_reply_err(req, ENOMEM);
+=09=09return;
+=09}
+
+=09fi->fh =3D fh;
 =09if (lo->cache =3D=3D CACHE_NEVER)
 =09=09fi->direct_io =3D 1;
 =09else if (lo->cache =3D=3D CACHE_ALWAYS)
@@ -1120,9 +1176,18 @@ static void lo_open(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
=20
 static void lo_release(fuse_req_t req, fuse_ino_t ino, struct fuse_file_in=
fo *fi)
 {
+=09struct lo_data *lo =3D lo_data(req);
+=09int fd;
+
 =09(void) ino;
=20
-=09close(fi->fh);
+=09fd =3D lo_fi_fd(req, fi);
+
+=09pthread_mutex_lock(&lo->mutex);
+=09lo_map_remove(&lo->fd_map, fi->fh);
+=09pthread_mutex_unlock(&lo->mutex);
+
+=09close(fd);
 =09fuse_reply_err(req, 0);
 }
=20
@@ -1130,7 +1195,7 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi)
 {
 =09int res;
 =09(void) ino;
-=09res =3D close(dup(fi->fh));
+=09res =3D close(dup(lo_fi_fd(req, fi)));
 =09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
@@ -1155,7 +1220,7 @@ static void lo_fsync(fuse_req_t req, fuse_ino_t ino, =
int datasync,
 =09=09if (fd =3D=3D -1)
 =09=09=09return (void) fuse_reply_err(req, errno);
 =09} else
-=09=09fd =3D fi->fh;
+=09=09fd =3D lo_fi_fd(req, fi);
=20
 =09if (datasync)
 =09=09res =3D fdatasync(fd);
@@ -1176,7 +1241,7 @@ static void lo_read(fuse_req_t req, fuse_ino_t ino, s=
ize_t size,
 =09=09=09"off=3D%lu)\n", ino, size, (unsigned long) offset);
=20
 =09buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
-=09buf.buf[0].fd =3D fi->fh;
+=09buf.buf[0].fd =3D lo_fi_fd(req, fi);
 =09buf.buf[0].pos =3D offset;
=20
 =09fuse_reply_data(req, &buf, FUSE_BUF_SPLICE_MOVE);
@@ -1191,7 +1256,7 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_t i=
no,
 =09struct fuse_bufvec out_buf =3D FUSE_BUFVEC_INIT(fuse_buf_size(in_buf));
=20
 =09out_buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
-=09out_buf.buf[0].fd =3D fi->fh;
+=09out_buf.buf[0].fd =3D lo_fi_fd(req, fi);
 =09out_buf.buf[0].pos =3D off;
=20
 =09if (lo_debug(req))
@@ -1234,7 +1299,8 @@ static void lo_fallocate(fuse_req_t req, fuse_ino_t i=
no, int mode,
 =09=09return;
 =09}
=20
-=09err =3D posix_fallocate(fi->fh, offset, length);
+=09err =3D posix_fallocate(lo_fi_fd(req, fi), offset,
+=09=09=09      length);
 #endif
=20
 =09fuse_reply_err(req, err);
@@ -1246,7 +1312,7 @@ static void lo_flock(fuse_req_t req, fuse_ino_t ino, =
struct fuse_file_info *fi,
 =09int res;
 =09(void) ino;
=20
-=09res =3D flock(fi->fh, op);
+=09res =3D flock(lo_fi_fd(req, fi), op);
=20
 =09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
@@ -1458,17 +1524,20 @@ static void lo_copy_file_range(fuse_req_t req, fuse=
_ino_t ino_in, off_t off_in,
 =09=09=09       struct fuse_file_info *fi_out, size_t len,
 =09=09=09       int flags)
 {
+=09int in_fd, out_fd;
 =09ssize_t res;
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_copy_file_range(ino=3D%" PRIu64 "/fd=3D=
%lu, "
-=09=09=09=09"off=3D%lu, ino=3D%" PRIu64 "/fd=3D%lu, "
-=09=09=09=09"off=3D%lu, size=3D%zd, flags=3D0x%x)\n",
-=09=09=09ino_in, fi_in->fh, off_in, ino_out, fi_out->fh, off_out,
-=09=09=09len, flags);
-
-=09res =3D copy_file_range(fi_in->fh, &off_in, fi_out->fh, &off_out, len,
-=09=09=09      flags);
+=09in_fd =3D lo_fi_fd(req, fi_in);
+=09out_fd =3D lo_fi_fd(req, fi_out);
+
+=09fuse_log(FUSE_LOG_DEBUG,
+=09=09 "lo_copy_file_range(ino=3D%" PRIu64 "/fd=3D%d, "
+=09=09 "off=3D%lu, ino=3D%" PRIu64 "/fd=3D%d, "
+=09=09 "off=3D%lu, size=3D%zd, flags=3D0x%x)\n",
+=09=09 ino_in, in_fd, off_in, ino_out, out_fd, off_out, len,
+=09=09 flags);
+
+=09res =3D copy_file_range(in_fd, &off_in, out_fd, &off_out, len, flags);
 =09if (res < 0)
 =09=09fuse_reply_err(req, -errno);
 =09else
@@ -1552,6 +1621,7 @@ int main(int argc, char *argv[])
 =09root_elem->inode =3D &lo.root;
=20
 =09lo_map_init(&lo.dirp_map);
+=09lo_map_init(&lo.fd_map);
=20
 =09if (fuse_parse_cmdline(&args, &opts) !=3D 0)
 =09=09return 1;
@@ -1646,6 +1716,7 @@ err_out2:
 err_out1:
 =09fuse_opt_free_args(&args);
=20
+=09lo_map_destroy(&lo.fd_map);
 =09lo_map_destroy(&lo.dirp_map);
 =09lo_map_destroy(&lo.ino_map);
=20
--=20
2.23.0



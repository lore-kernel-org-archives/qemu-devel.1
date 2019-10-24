Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64975CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:12:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFDE20659
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 13:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJTr2efv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFDE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcv8-0001Ta-Sk
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 09:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHZ-0002WB-JR
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHX-0008Pf-Sh
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60936
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHX-0008PW-OI
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEsV4kt4RcGXK33uIETfzcCcvDDHKf1bfkPu8hF69PM=;
 b=iJTr2efvLRoZrhD1gPVWQGlktCxgv9beEU4lCNDG5wpmUZxFn01fdoK0R3uwH/bojCt75W
 onjukkC76y9h36yTz2jvpV99uKA4Gsw4QclM2SjxMLs0s+56Psu4Ab0v9ZOpUQhymsM7UJ
 cr0UYy8iS4A7dA5k64YxC1kuyJu+eWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-Jk-BmLeHPgiYbrBw9DCxFQ-1; Thu, 24 Oct 2019 07:27:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F4BB5E4;
 Thu, 24 Oct 2019 11:27:49 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BAAA3166A0;
 Thu, 24 Oct 2019 11:27:46 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 06/25] virtiofsd: passthrough_ll: add fallback for racy ops
Date: Thu, 24 Oct 2019 12:26:59 +0100
Message-Id: <20191024112718.34657-7-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Jk-BmLeHPgiYbrBw9DCxFQ-1
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

From: Miklos Szeredi <mszeredi@redhat.com>

We have two operations that cannot be done race-free on a symlink in
certain cases: utimes and link.

Add racy fallback for these if the race-free method doesn't work.  We do
our best to avoid races even in this case:

  - get absolute path by reading /proc/self/fd/NN symlink

  - lookup parent directory: after this we are safe against renames in
    ancestors

  - lookup name in parent directory, and verify that we got to the original
    inode,  if not retry the whole thing

Both utimes(2) and link(2) hold i_lock on the inode across the operation,
so a racing rename/delete by this fuse instance is not possible, only from
other entities changing the filesystem.

If the "norace" option is given, then disable the racy fallbacks.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 149 +++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 18 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index a71fbff143..9f84419816 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -98,6 +98,7 @@ enum {
 struct lo_data {
 =09pthread_mutex_t mutex;
 =09int debug;
+=09int norace;
 =09int writeback;
 =09int flock;
 =09int xattr;
@@ -136,10 +137,16 @@ static const struct fuse_opt lo_opts[] =3D {
 =09  offsetof(struct lo_data, cache), CACHE_NORMAL },
 =09{ "cache=3Dalways",
 =09  offsetof(struct lo_data, cache), CACHE_ALWAYS },
-
+=09{ "norace",
+=09  offsetof(struct lo_data, norace), 1 },
 =09FUSE_OPT_END
 };
=20
+static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n);
+
+static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st);
+
+
 static struct lo_data *lo_data(fuse_req_t req)
 {
 =09return (struct lo_data *) fuse_req_userdata(req);
@@ -345,24 +352,116 @@ static void lo_getattr(fuse_req_t req, fuse_ino_t in=
o,
 =09fuse_reply_attr(req, &buf, lo->timeout);
 }
=20
-static int utimensat_empty_nofollow(struct lo_inode *inode,
-=09=09=09=09    const struct timespec *tv)
+static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *inode,
+=09=09=09      char path[PATH_MAX], struct lo_inode **parent)
 {
-=09int res;
 =09char procname[64];
+=09char *last;
+=09struct stat stat;
+=09struct lo_inode *p;
+=09int retries =3D 2;
+=09int res;
+
+retry:
+=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+=09res =3D readlink(procname, path, PATH_MAX);
+=09if (res < 0) {
+=09=09fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: readlink failed: %m\=
n");
+=09=09goto fail_noretry;
+=09}
+
+=09if (res >=3D PATH_MAX) {
+=09=09fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: readlink overflowed\=
n");
+=09=09goto fail_noretry;
+=09}
+=09path[res] =3D '\0';
+
+=09last =3D strrchr(path, '/');
+=09if (last =3D=3D NULL) {
+=09=09/* Shouldn't happen */
+=09=09fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: INTERNAL ERROR: bad =
path read from proc\n");
+=09=09goto fail_noretry;
+=09}
+=09if (last =3D=3D path) {
+=09=09p =3D &lo->root;
+=09=09pthread_mutex_lock(&lo->mutex);
+=09=09p->refcount++;
+=09=09pthread_mutex_unlock(&lo->mutex);
+=09} else {
+=09=09*last =3D '\0';
+=09=09res =3D fstatat(AT_FDCWD, last =3D=3D path ? "/" : path, &stat, 0);
+=09=09if (res =3D=3D -1) {
+=09=09=09if (!retries)
+=09=09=09=09fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: failed to stat=
 parent: %m\n");
+=09=09=09goto fail;
+=09=09}
+=09=09p =3D lo_find(lo, &stat);
+=09=09if (p =3D=3D NULL) {
+=09=09=09if (!retries)
+=09=09=09=09fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: failed to find=
 parent\n");
+=09=09=09goto fail;
+=09=09}
+=09}
+=09last++;
+=09res =3D fstatat(p->fd, last, &stat, AT_SYMLINK_NOFOLLOW);
+=09if (res =3D=3D -1) {
+=09=09if (!retries)
+=09=09=09fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: failed to stat la=
st\n");
+=09=09goto fail_unref;
+=09}
+=09if (stat.st_dev !=3D inode->dev || stat.st_ino !=3D inode->ino) {
+=09=09if (!retries)
+=09=09=09fuse_log(FUSE_LOG_WARNING, "lo_parent_and_name: failed to match l=
ast\n");
+=09=09goto fail_unref;
+=09}
+=09*parent =3D p;
+=09memmove(path, last, strlen(last) + 1);
+
+=09return 0;
+
+fail_unref:
+=09unref_inode(lo, p, 1);
+fail:
+=09if (retries) {
+=09=09retries--;
+=09=09goto retry;
+=09}
+fail_noretry:
+=09errno =3D EIO;
+=09return -1;
+}
+
+static int utimensat_empty(struct lo_data *lo, struct lo_inode *inode,
+=09=09=09   const struct timespec *tv)
+{
+=09int res;
+=09struct lo_inode *parent;
+=09char path[PATH_MAX];
=20
 =09if (inode->is_symlink) {
-=09=09res =3D utimensat(inode->fd, "", tv,
-=09=09=09=09AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
+=09=09res =3D utimensat(inode->fd, "", tv, AT_EMPTY_PATH);
 =09=09if (res =3D=3D -1 && errno =3D=3D EINVAL) {
 =09=09=09/* Sorry, no race free way to set times on symlink. */
-=09=09=09errno =3D EPERM;
+=09=09=09if (lo->norace)
+=09=09=09=09errno =3D EPERM;
+=09=09=09else
+=09=09=09=09goto fallback;
 =09=09}
 =09=09return res;
 =09}
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+=09sprintf(path, "/proc/self/fd/%i", inode->fd);
+
+=09return utimensat(AT_FDCWD, path, tv, 0);
+
+fallback:
+=09res =3D lo_parent_and_name(lo, inode, path, &parent);
+=09if (res !=3D -1) {
+=09=09res =3D utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
+=09=09unref_inode(lo, parent, 1);
+=09}
=20
-=09return utimensat(AT_FDCWD, procname, tv, 0);
+=09return res;
 }
=20
 static int lo_fi_fd(fuse_req_t req, struct fuse_file_info *fi)
@@ -385,6 +484,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, =
struct stat *attr,
 {
 =09int saverr;
 =09char procname[64];
+=09struct lo_data *lo =3D lo_data(req);
 =09struct lo_inode *inode;
 =09int ifd;
 =09int res;
@@ -454,7 +554,7 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino, =
struct stat *attr,
 =09=09if (fi)
 =09=09=09res =3D futimens(fd, tv);
 =09=09else
-=09=09=09res =3D utimensat_empty_nofollow(inode, tv);
+=09=09=09res =3D utimensat_empty(lo, inode, tv);
 =09=09if (res =3D=3D -1)
 =09=09=09goto out_err;
 =09}
@@ -673,24 +773,37 @@ static void lo_symlink(fuse_req_t req, const char *li=
nk,
 =09lo_mknod_symlink(req, parent, name, S_IFLNK, 0, link);
 }
=20
-static int linkat_empty_nofollow(struct lo_inode *inode, int dfd,
-=09=09=09=09 const char *name)
+static int linkat_empty_nofollow(struct lo_data *lo, struct lo_inode *inod=
e,
+=09=09=09=09 int dfd, const char *name)
 {
 =09int res;
-=09char procname[64];
+=09struct lo_inode *parent;
+=09char path[PATH_MAX];
=20
 =09if (inode->is_symlink) {
 =09=09res =3D linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
 =09=09if (res =3D=3D -1 && (errno =3D=3D ENOENT || errno =3D=3D EINVAL)) {
 =09=09=09/* Sorry, no race free way to hard-link a symlink. */
-=09=09=09errno =3D EPERM;
+=09=09=09if (lo->norace)
+=09=09=09=09errno =3D EPERM;
+=09=09=09else
+=09=09=09=09goto fallback;
 =09=09}
 =09=09return res;
 =09}
=20
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+=09sprintf(path, "/proc/self/fd/%i", inode->fd);
+
+=09return linkat(AT_FDCWD, path, dfd, name, AT_SYMLINK_FOLLOW);
=20
-=09return linkat(AT_FDCWD, procname, dfd, name, AT_SYMLINK_FOLLOW);
+fallback:
+=09res =3D lo_parent_and_name(lo, inode, path, &parent);
+=09if (res !=3D -1) {
+=09=09res =3D linkat(parent->fd, path, dfd, name, 0);
+=09=09unref_inode(lo, parent, 1);
+=09}
+
+=09return res;
 }
=20
 static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
@@ -712,7 +825,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fus=
e_ino_t parent,
 =09e.attr_timeout =3D lo->timeout;
 =09e.entry_timeout =3D lo->timeout;
=20
-=09res =3D linkat_empty_nofollow(inode, lo_fd(req, parent), name);
+=09res =3D linkat_empty_nofollow(lo, inode, lo_fd(req, parent), name);
 =09if (res =3D=3D -1)
 =09=09goto out_err;
=20
@@ -1466,7 +1579,7 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t in=
o, const char *name,
 =09}
=20
 =09if (inode->is_symlink) {
-=09=09/* Sorry, no race free way to setxattr on symlink. */
+=09=09/* Sorry, no race free way to removexattr on symlink. */
 =09=09saverr =3D EPERM;
 =09=09goto out;
 =09}
--=20
2.23.0



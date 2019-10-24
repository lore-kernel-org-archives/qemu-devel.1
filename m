Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08CDCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF7F820679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWkcTMQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7F820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbW4-0008UK-7y
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHN-0001vs-Nn
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHM-0008I3-4X
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33380
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHL-0008Hu-Uw
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HhF+ye4KeQJrro/A75A8XEgBNVYbuOMQSCicQJWTnRA=;
 b=MWkcTMQhnirqU2ST6NtsjyFPSY4bs/bwvG+/XxjvhIp5G7d5CpMtisdZlzyTggUzKf+l38
 tASdvt7QZMspDbBlJuJkAKv/2tqeD5o3oR60gB84M/FxTULF1QwRjp8xanpNxuhbrgRwPL
 M+Zfr5GKMiW4dmP8L7xBe1LvSmF4n+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-eF96tUi_O5iqZrrP75fdRw-1; Thu, 24 Oct 2019 07:27:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D25791800E00;
 Thu, 24 Oct 2019 11:27:38 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 59D144524;
 Thu, 24 Oct 2019 11:27:36 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 04/25] virtiofsd: passthrough_ll: add dirp_map to hide lo_dirp
 pointers
Date: Thu, 24 Oct 2019 12:26:57 +0100
Message-Id: <20191024112718.34657-5-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: eF96tUi_O5iqZrrP75fdRw-1
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

Do not expose lo_dirp pointers to clients.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 100 +++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 25 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index f718c951f7..9f82166079 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -56,22 +56,10 @@
=20
 #define HAVE_POSIX_FALLOCATE 1
=20
-/* We are re-using pointers to our `struct lo_dirp`
-   elements as inodes. This means that we must be able to
-   store uintptr_t values in a fuse_ino_t variable. The following
-   incantation checks this condition at compile time. */
-#if defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINO=
R__ >=3D 6) && !defined __cplusplus
-_Static_assert(sizeof(fuse_ino_t) >=3D sizeof(uintptr_t),
-=09       "fuse_ino_t too small to hold uintptr_t values!");
-#else
-struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct \
-=09{ unsigned _uintptr_to_must_hold_fuse_ino_t:
-=09=09=09((sizeof(fuse_ino_t) >=3D sizeof(uintptr_t)) ? 1 : -1); };
-#endif
-
 struct lo_map_elem {
 =09union {
 =09=09struct lo_inode *inode;
+=09=09struct lo_dirp *dirp;
 =09=09ssize_t freelist;
 =09};
 =09bool in_use;
@@ -118,6 +106,7 @@ struct lo_data {
 =09int timeout_set;
 =09struct lo_inode root; /* protected by lo->mutex */
 =09struct lo_map ino_map; /* protected by lo->mutex */
+=09struct lo_map dirp_map; /* protected by lo->mutex */
 };
=20
 static const struct fuse_opt lo_opts[] =3D {
@@ -252,6 +241,19 @@ static void lo_map_remove(struct lo_map *map, size_t k=
ey)
 =09map->freelist =3D key;
 }
=20
+/* Assumes lo->mutex is held */
+static ssize_t lo_add_dirp_mapping(fuse_req_t req, struct lo_dirp *dirp)
+{
+=09struct lo_map_elem *elem;
+
+=09elem =3D lo_map_alloc_elem(&lo_data(req)->dirp_map);
+=09if (!elem)
+=09=09return -1;
+
+=09elem->dirp =3D dirp;
+=09return elem - lo_data(req)->dirp_map.elems;
+}
+
 /* Assumes lo->mutex is held */
 static ssize_t lo_add_inode_mapping(fuse_req_t req, struct lo_inode *inode=
)
 {
@@ -820,16 +822,28 @@ struct lo_dirp {
 =09off_t offset;
 };
=20
-static struct lo_dirp *lo_dirp(struct fuse_file_info *fi)
+static struct lo_dirp *lo_dirp(fuse_req_t req, struct fuse_file_info *fi)
 {
-=09return (struct lo_dirp *) (uintptr_t) fi->fh;
+=09struct lo_data *lo =3D lo_data(req);
+=09struct lo_map_elem *elem;
+
+=09pthread_mutex_lock(&lo->mutex);
+=09elem =3D lo_map_get(&lo->dirp_map, fi->fh);
+=09pthread_mutex_unlock(&lo->mutex);
+=09if (!elem)
+=09=09return NULL;
+
+=09return elem->dirp;
 }
=20
 static void lo_opendir(fuse_req_t req, fuse_ino_t ino, struct fuse_file_in=
fo *fi)
 {
 =09int error =3D ENOMEM;
 =09struct lo_data *lo =3D lo_data(req);
-=09struct lo_dirp *d =3D calloc(1, sizeof(struct lo_dirp));
+=09struct lo_dirp *d;
+=09ssize_t fh;
+
+=09d =3D calloc(1, sizeof(struct lo_dirp));
 =09if (d =3D=3D NULL)
 =09=09goto out_err;
=20
@@ -844,7 +858,13 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t ino,=
 struct fuse_file_info *fi
 =09d->offset =3D 0;
 =09d->entry =3D NULL;
=20
-=09fi->fh =3D (uintptr_t) d;
+=09pthread_mutex_lock(&lo->mutex);
+=09fh =3D lo_add_dirp_mapping(req, d);
+=09pthread_mutex_unlock(&lo->mutex);
+=09if (fh =3D=3D -1)
+=09=09goto out_err;
+
+=09fi->fh =3D fh;
 =09if (lo->cache =3D=3D CACHE_ALWAYS)
 =09=09fi->keep_cache =3D 1;
 =09fuse_reply_open(req, fi);
@@ -854,6 +874,8 @@ out_errno:
 =09error =3D errno;
 out_err:
 =09if (d) {
+=09=09if (d->dp)
+=09=09=09closedir(d->dp);
 =09=09if (d->fd !=3D -1)
 =09=09=09close(d->fd);
 =09=09free(d);
@@ -870,19 +892,21 @@ static int is_dot_or_dotdot(const char *name)
 static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
 =09=09=09  off_t offset, struct fuse_file_info *fi, int plus)
 {
-=09struct lo_dirp *d =3D lo_dirp(fi);
-=09char *buf;
+=09struct lo_dirp *d;
+=09char *buf =3D NULL;
 =09char *p;
 =09size_t rem =3D size;
-=09int err;
+=09int err =3D ENOMEM;
=20
 =09(void) ino;
=20
+=09d =3D lo_dirp(req, fi);
+=09if (!d)
+=09=09goto error;
+
 =09buf =3D calloc(1, size);
-=09if (!buf) {
-=09=09err =3D ENOMEM;
+=09if (!buf)
 =09=09goto error;
-=09}
 =09p =3D buf;
=20
 =09if (offset !=3D d->offset) {
@@ -974,8 +998,21 @@ static void lo_readdirplus(fuse_req_t req, fuse_ino_t =
ino, size_t size,
=20
 static void lo_releasedir(fuse_req_t req, fuse_ino_t ino, struct fuse_file=
_info *fi)
 {
-=09struct lo_dirp *d =3D lo_dirp(fi);
+=09struct lo_data *lo =3D lo_data(req);
+=09struct lo_dirp *d;
+
 =09(void) ino;
+
+=09d =3D lo_dirp(req, fi);
+=09if (!d) {
+=09=09fuse_reply_err(req, EBADF);
+=09=09return;
+=09}
+
+=09pthread_mutex_lock(&lo->mutex);
+=09lo_map_remove(&lo->dirp_map, fi->fh);
+=09pthread_mutex_unlock(&lo->mutex);
+
 =09closedir(d->dp);
 =09free(d);
 =09fuse_reply_err(req, 0);
@@ -1023,8 +1060,18 @@ static void lo_fsyncdir(fuse_req_t req, fuse_ino_t i=
no, int datasync,
 =09=09=09struct fuse_file_info *fi)
 {
 =09int res;
-=09int fd =3D dirfd(lo_dirp(fi)->dp);
+=09struct lo_dirp *d;
+=09int fd;
+
 =09(void) ino;
+
+=09d =3D lo_dirp(req, fi);
+=09if (!d) {
+=09=09fuse_reply_err(req, EBADF);
+=09=09return;
+=09}
+
+=09fd =3D dirfd(d->dp);
 =09if (datasync)
 =09=09res =3D fdatasync(fd);
 =09else
@@ -1504,6 +1551,8 @@ int main(int argc, char *argv[])
 =09root_elem =3D lo_map_reserve(&lo.ino_map, lo.root.fuse_ino);
 =09root_elem->inode =3D &lo.root;
=20
+=09lo_map_init(&lo.dirp_map);
+
 =09if (fuse_parse_cmdline(&args, &opts) !=3D 0)
 =09=09return 1;
 =09if (opts.show_help) {
@@ -1597,6 +1646,7 @@ err_out2:
 err_out1:
 =09fuse_opt_free_args(&args);
=20
+=09lo_map_destroy(&lo.dirp_map);
 =09lo_map_destroy(&lo.ino_map);
=20
 =09if (lo.root.fd >=3D 0)
--=20
2.23.0



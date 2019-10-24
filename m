Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C149ECA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE9C21655
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGC4qO3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE9C21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbaP-0000rz-NT
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHR-00028h-G1
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbHP-0008Lh-O0
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42422
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbHP-0008LT-Jv
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=epYFexBAvojJruBQufHQ3wH4UK2rDrrqSsjxLR4oqMI=;
 b=jGC4qO3QM9S12lNtsOVfm+aUOwwBgcJ2fk5Reewm+xFWCyO186is6145jio1TAI1eYvPyw
 TjaBwxI2glGCJdJWt9tesY8A1I2xo2zXFBOJ/PJ31rVo409r0GwqP0OiWUCHrU+6Kcg4NN
 9G7iQhQBnWyCsgOdH3my/pqgc404klU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-Gc9NGrtTOcaMrzlHZizrbA-1; Thu, 24 Oct 2019 07:27:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DB3A800D49;
 Thu, 24 Oct 2019 11:27:36 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 899C11C93D;
 Thu, 24 Oct 2019 11:27:33 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 03/25] virtiofsd: passthrough_ll: add ino_map to hide lo_inode
 pointers
Date: Thu, 24 Oct 2019 12:26:56 +0100
Message-Id: <20191024112718.34657-4-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Gc9NGrtTOcaMrzlHZizrbA-1
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

Do not expose lo_inode pointers to clients.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 125 ++++++++++++++++++++++++-----
 1 file changed, 105 insertions(+), 20 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 3093d1171e..f718c951f7 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -56,8 +56,8 @@
=20
 #define HAVE_POSIX_FALLOCATE 1
=20
-/* We are re-using pointers to our `struct lo_inode` and `struct
-   lo_dirp` elements as inodes. This means that we must be able to
+/* We are re-using pointers to our `struct lo_dirp`
+   elements as inodes. This means that we must be able to
    store uintptr_t values in a fuse_ino_t variable. The following
    incantation checks this condition at compile time. */
 #if defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINO=
R__ >=3D 6) && !defined __cplusplus
@@ -71,7 +71,7 @@ struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct \
=20
 struct lo_map_elem {
 =09union {
-=09=09/* Element values will go here... */
+=09=09struct lo_inode *inode;
 =09=09ssize_t freelist;
 =09};
 =09bool in_use;
@@ -92,6 +92,7 @@ struct lo_inode {
 =09ino_t ino;
 =09dev_t dev;
 =09uint64_t refcount; /* protected by lo->mutex */
+=09fuse_ino_t fuse_ino;
 };
=20
 struct lo_cred {
@@ -116,6 +117,7 @@ struct lo_data {
 =09int cache;
 =09int timeout_set;
 =09struct lo_inode root; /* protected by lo->mutex */
+=09struct lo_map ino_map; /* protected by lo->mutex */
 };
=20
 static const struct fuse_opt lo_opts[] =3D {
@@ -250,17 +252,38 @@ static void lo_map_remove(struct lo_map *map, size_t =
key)
 =09map->freelist =3D key;
 }
=20
+/* Assumes lo->mutex is held */
+static ssize_t lo_add_inode_mapping(fuse_req_t req, struct lo_inode *inode=
)
+{
+=09struct lo_map_elem *elem;
+
+=09elem =3D lo_map_alloc_elem(&lo_data(req)->ino_map);
+=09if (!elem)
+=09=09return -1;
+
+=09elem->inode =3D inode;
+=09return elem - lo_data(req)->ino_map.elems;
+}
+
 static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
 {
-=09if (ino =3D=3D FUSE_ROOT_ID)
-=09=09return &lo_data(req)->root;
-=09else
-=09=09return (struct lo_inode *) (uintptr_t) ino;
+=09struct lo_data *lo =3D lo_data(req);
+=09struct lo_map_elem *elem;
+
+=09pthread_mutex_lock(&lo->mutex);
+=09elem =3D lo_map_get(&lo->ino_map, ino);
+=09pthread_mutex_unlock(&lo->mutex);
+
+=09if (!elem)
+=09=09return NULL;
+
+=09return elem->inode;
 }
=20
 static int lo_fd(fuse_req_t req, fuse_ino_t ino)
 {
-=09return lo_inode(req, ino)->fd;
+=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09return inode ? inode->fd : -1;
 }
=20
 static bool lo_debug(fuse_req_t req)
@@ -330,10 +353,18 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t ino=
, struct stat *attr,
 {
 =09int saverr;
 =09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
-=09int ifd =3D inode->fd;
+=09struct lo_inode *inode;
+=09int ifd;
 =09int res;
=20
+=09inode =3D lo_inode(req, ino);
+=09if (!inode) {
+=09=09fuse_reply_err(req, EBADF);
+=09=09return;
+=09}
+
+=09ifd =3D inode->fd;
+
 =09if (valid & FUSE_SET_ATTR_MODE) {
 =09=09if (fi) {
 =09=09=09res =3D fchmod(fi->fh, attr->st_mode);
@@ -456,6 +487,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
 =09=09inode->dev =3D e->attr.st_dev;
=20
 =09=09pthread_mutex_lock(&lo->mutex);
+=09=09inode->fuse_ino =3D lo_add_inode_mapping(req, inode);
 =09=09prev =3D &lo->root;
 =09=09next =3D prev->next;
 =09=09next->prev =3D inode;
@@ -464,7 +496,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
 =09=09prev->next =3D inode;
 =09=09pthread_mutex_unlock(&lo->mutex);
 =09}
-=09e->ino =3D (uintptr_t) inode;
+=09e->ino =3D inode->fuse_ino;
=20
 =09if (lo_debug(req))
 =09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
@@ -546,10 +578,16 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_ino=
_t parent,
 {
 =09int res;
 =09int saverr;
-=09struct lo_inode *dir =3D lo_inode(req, parent);
+=09struct lo_inode *dir;
 =09struct fuse_entry_param e;
 =09struct lo_cred old =3D {};
=20
+=09dir =3D lo_inode(req, parent);
+=09if (!dir) {
+=09=09fuse_reply_err(req, EBADF);
+=09=09return;
+=09}
+
 =09saverr =3D ENOMEM;
=20
 =09saverr =3D lo_change_cred(req, &old);
@@ -623,10 +661,16 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, f=
use_ino_t parent,
 {
 =09int res;
 =09struct lo_data *lo =3D lo_data(req);
-=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09struct lo_inode *inode;
 =09struct fuse_entry_param e;
 =09int saverr;
=20
+=09inode =3D lo_inode(req, ino);
+=09if (!inode) {
+=09=09fuse_reply_err(req, EBADF);
+=09=09return;
+=09}
+
 =09memset(&e, 0, sizeof(struct fuse_entry_param));
 =09e.attr_timeout =3D lo->timeout;
 =09e.entry_timeout =3D lo->timeout;
@@ -642,7 +686,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino, fus=
e_ino_t parent,
 =09pthread_mutex_lock(&lo->mutex);
 =09inode->refcount++;
 =09pthread_mutex_unlock(&lo->mutex);
-=09e.ino =3D (uintptr_t) inode;
+=09e.ino =3D inode->fuse_ino;
=20
 =09if (lo_debug(req))
 =09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
@@ -708,10 +752,10 @@ static void unref_inode(struct lo_data *lo, struct lo=
_inode *inode, uint64_t n)
 =09=09next->prev =3D prev;
 =09=09prev->next =3D next;
=20
+=09=09lo_map_remove(&lo->ino_map, inode->fuse_ino);
 =09=09pthread_mutex_unlock(&lo->mutex);
 =09=09close(inode->fd);
 =09=09free(inode);
-
 =09} else {
 =09=09pthread_mutex_unlock(&lo->mutex);
 =09}
@@ -720,7 +764,11 @@ static void unref_inode(struct lo_data *lo, struct lo_=
inode *inode, uint64_t n)
 static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup=
)
 {
 =09struct lo_data *lo =3D lo_data(req);
-=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09struct lo_inode *inode;
+
+=09inode =3D lo_inode(req, ino);
+=09if (!inode)
+=09=09return;
=20
 =09if (lo_debug(req)) {
 =09=09fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
@@ -1161,10 +1209,16 @@ static void lo_getxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
 {
 =09char *value =3D NULL;
 =09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09struct lo_inode *inode;
 =09ssize_t ret;
 =09int saverr;
=20
+=09inode =3D lo_inode(req, ino);
+=09if (!inode) {
+=09=09fuse_reply_err(req, EBADF);
+=09=09return;
+=09}
+
 =09saverr =3D ENOSYS;
 =09if (!lo_data(req)->xattr)
 =09=09goto out;
@@ -1217,10 +1271,16 @@ static void lo_listxattr(fuse_req_t req, fuse_ino_t=
 ino, size_t size)
 {
 =09char *value =3D NULL;
 =09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09struct lo_inode *inode;
 =09ssize_t ret;
 =09int saverr;
=20
+=09inode =3D lo_inode(req, ino);
+=09if (!inode) {
+=09=09fuse_reply_err(req, EBADF);
+=09=09return;
+=09}
+
 =09saverr =3D ENOSYS;
 =09if (!lo_data(req)->xattr)
 =09=09goto out;
@@ -1273,10 +1333,16 @@ static void lo_setxattr(fuse_req_t req, fuse_ino_t =
ino, const char *name,
 =09=09=09const char *value, size_t size, int flags)
 {
 =09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09struct lo_inode *inode;
 =09ssize_t ret;
 =09int saverr;
=20
+=09inode =3D lo_inode(req, ino);
+=09if (!inode) {
+=09=09fuse_reply_err(req, EBADF);
+=09=09return;
+=09}
+
 =09saverr =3D ENOSYS;
 =09if (!lo_data(req)->xattr)
 =09=09goto out;
@@ -1304,10 +1370,16 @@ out:
 static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *nam=
e)
 {
 =09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
+=09struct lo_inode *inode;
 =09ssize_t ret;
 =09int saverr;
=20
+=09inode =3D lo_inode(req, ino);
+=09if (!inode) {
+=09=09fuse_reply_err(req, EBADF);
+=09=09return;
+=09}
+
 =09saverr =3D ENOSYS;
 =09if (!lo_data(req)->xattr)
 =09=09goto out;
@@ -1411,6 +1483,7 @@ int main(int argc, char *argv[])
 =09struct fuse_cmdline_opts opts;
 =09struct lo_data lo =3D { .debug =3D 0,
 =09                      .writeback =3D 0 };
+=09struct lo_map_elem *root_elem;
 =09int ret =3D -1;
=20
 =09/* Don't mask creation mode, kernel already did that */
@@ -1419,8 +1492,18 @@ int main(int argc, char *argv[])
 =09pthread_mutex_init(&lo.mutex, NULL);
 =09lo.root.next =3D lo.root.prev =3D &lo.root;
 =09lo.root.fd =3D -1;
+=09lo.root.fuse_ino =3D FUSE_ROOT_ID;
 =09lo.cache =3D CACHE_NORMAL;
=20
+=09/* Set up the ino map like this:
+=09 * [0] Reserved (will not be used)
+=09 * [1] Root inode
+=09 */
+=09lo_map_init(&lo.ino_map);
+=09lo_map_reserve(&lo.ino_map, 0)->in_use =3D false;
+=09root_elem =3D lo_map_reserve(&lo.ino_map, lo.root.fuse_ino);
+=09root_elem->inode =3D &lo.root;
+
 =09if (fuse_parse_cmdline(&args, &opts) !=3D 0)
 =09=09return 1;
 =09if (opts.show_help) {
@@ -1514,6 +1597,8 @@ err_out2:
 err_out1:
 =09fuse_opt_free_args(&args);
=20
+=09lo_map_destroy(&lo.ino_map);
+
 =09if (lo.root.fd >=3D 0)
 =09=09close(lo.root.fd);
=20
--=20
2.23.0



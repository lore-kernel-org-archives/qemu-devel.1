Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EE7C32753
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7CE206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7CE206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42487 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrJr-0005HJ-Up
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41194)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hsrBf-0006dW-NF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hsrBd-0001xi-Be
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:10:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34956)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hsrBd-0001xX-3r
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:10:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1DEE930C134C;
 Wed, 31 Jul 2019 16:10:44 +0000 (UTC)
Received: from localhost (ovpn-117-27.ams2.redhat.com [10.36.117.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F21F2600D1;
 Wed, 31 Jul 2019 16:10:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:10:06 +0100
Message-Id: <20190731161006.9447-6-stefanha@redhat.com>
In-Reply-To: <20190731161006.9447-1-stefanha@redhat.com>
References: <20190731161006.9447-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 31 Jul 2019 16:10:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/5] virtiofsd: introduce inode refcount to
 prevent use-after-free
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If thread A is using an inode it must not be deleted by thread B when
processing a FUSE_FORGET request.

The FUSE protocol itself already has a counter called nlookup that is
used in FUSE_FORGET messages.  We cannot trust this counter since the
untrusted client can manipulate it via FUSE_FORGET messages.

Introduce a new refcount to keep inodes alive for the required lifespan.
lo_inode_put() must be called to release a reference.  FUSE's nlookup
counter holds exactly one reference so that the inode stays alive as
long as the client still wants to remember it.

Note that the lo_inode->is_symlink field is moved to avoid creating a
hole in the struct due to struct field alignment.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 212 ++++++++++++++++++++++++-----
 1 file changed, 178 insertions(+), 34 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
index 125e9d9f96..0c90e352d2 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -95,7 +95,12 @@ struct lo_key {
=20
 struct lo_inode {
 	int fd;
-	bool is_symlink;
+
+	/* Atomic reference count for this object.  The nlookup field holds a
+	 * reference and release it when nlookup reaches 0.
+	 */
+	gint refcount;
+
 	struct lo_key key;
=20
 	/* This counter keeps the inode alive during the FUSE session.
@@ -115,6 +120,8 @@ struct lo_inode {
 	fuse_ino_t fuse_ino;
 	pthread_mutex_t plock_mutex;
 	GHashTable *posix_locks; /* protected by lo_inode->plock_mutex */
+
+	bool is_symlink;
 };
=20
 struct lo_cred {
@@ -198,6 +205,7 @@ static const struct fuse_opt lo_opts[] =3D {
 	FUSE_OPT_END
 };
 static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint=
64_t n);
+static void put_shared(struct lo_data *lo, struct lo_inode *inode);
=20
 static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st);
=20
@@ -359,6 +367,24 @@ static ssize_t lo_add_inode_mapping(fuse_req_t req, =
struct lo_inode *inode)
 	return elem - lo_data(req)->ino_map.elems;
 }
=20
+static void lo_inode_put(struct lo_data *lo, struct lo_inode **inodep)
+{
+	struct lo_inode *inode =3D *inodep;
+
+	if (!inode) {
+		return;
+	}
+
+	*inodep =3D NULL;
+
+	if (g_atomic_int_dec_and_test(&inode->refcount)) {
+		close(inode->fd);
+		put_shared(lo, inode);
+		free(inode);
+	}
+}
+
+/* Caller must release refcount using lo_inode_put() */
 static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
 {
 	struct lo_data *lo =3D lo_data(req);
@@ -366,6 +392,9 @@ static struct lo_inode *lo_inode(fuse_req_t req, fuse=
_ino_t ino)
=20
 	pthread_mutex_lock(&lo->mutex);
 	elem =3D lo_map_get(&lo->ino_map, ino);
+	if (elem) {
+		g_atomic_int_inc(&elem->inode->refcount);
+	}
 	pthread_mutex_unlock(&lo->mutex);
=20
 	if (!elem)
@@ -374,10 +403,22 @@ static struct lo_inode *lo_inode(fuse_req_t req, fu=
se_ino_t ino)
 	return elem->inode;
 }
=20
+/* TODO Remove this helper and force callers to hold an inode refcount u=
ntil
+ * they are done with the fd.  This will be done in a later patch to mak=
e
+ * review easier.
+ */
 static int lo_fd(fuse_req_t req, fuse_ino_t ino)
 {
 	struct lo_inode *inode =3D lo_inode(req, ino);
-	return inode ? inode->fd : -1;
+	int fd;
+
+	if (!inode) {
+		return -1;
+	}
+
+	fd =3D inode->fd;
+	lo_inode_put(lo_data(req), &inode);
+	return fd;
 }
=20
 static bool lo_debug(fuse_req_t req)
@@ -463,6 +504,9 @@ static void lo_getattr(fuse_req_t req, fuse_ino_t ino=
,
 	fuse_reply_attr(req, &buf, lo->timeout);
 }
=20
+/* Increments parent->nlookup and caller must release refcount using
+ * lo_inode_put(&parent).
+ */
 static int lo_parent_and_name(struct lo_data *lo, struct lo_inode *inode=
,
 			      char path[PATH_MAX], struct lo_inode **parent)
 {
@@ -498,6 +542,7 @@ retry:
 		p =3D &lo->root;
 		pthread_mutex_lock(&lo->mutex);
 		p->nlookup++;
+		g_atomic_int_inc(&p->refcount);
 		pthread_mutex_unlock(&lo->mutex);
 	} else {
 		*last =3D '\0';
@@ -570,6 +615,7 @@ fallback:
 	if (res !=3D -1) {
 		res =3D utimensat(parent->fd, path, tv, AT_SYMLINK_NOFOLLOW);
 		unref_inode(lo, parent, 1);
+		lo_inode_put(lo, &parent);
 	}
=20
 	return res;
@@ -683,11 +729,13 @@ static void lo_setattr(fuse_req_t req, fuse_ino_t i=
no, struct stat *attr,
 			goto out_err;
 	}
 	update_version(lo, inode);
+	lo_inode_put(lo, &inode);
=20
 	return lo_getattr(req, ino, fi);
=20
 out_err:
 	saverr =3D errno;
+	lo_inode_put(lo, &inode);
 	fuse_reply_err(req, saverr);
 }
=20
@@ -704,6 +752,7 @@ static struct lo_inode *lo_find(struct lo_data *lo, s=
truct stat *st)
 	if (p) {
 		assert(p->nlookup > 0);
 		p->nlookup++;
+		g_atomic_int_inc(&p->refcount);
 	}
 	pthread_mutex_unlock(&lo->mutex);
=20
@@ -771,6 +820,9 @@ static void put_shared(struct lo_data *lo, struct lo_=
inode *inode)
 	}
 }
=20
+/* Increments nlookup and caller must release refcount using
+ * lo_inode_put(&parent).
+ */
 static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *n=
ame,
 			 struct fuse_entry_param *e)
 {
@@ -778,7 +830,8 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
 	int res;
 	int saverr;
 	struct lo_data *lo =3D lo_data(req);
-	struct lo_inode *inode, *dir =3D lo_inode(req, parent);
+	struct lo_inode *inode =3D NULL;
+	struct lo_inode *dir =3D lo_inode(req, parent);
=20
 	if (!dir) {
 		return EBADF;
@@ -811,6 +864,10 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t p=
arent, const char *name,
 			goto out_err;
=20
 		inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
+
+		/* One for the caller and one for nlookup (released in unref_inode()) =
*/
+		g_atomic_int_set(&inode->refcount, 2);
+
 		inode->nlookup =3D 1;
 		inode->fd =3D newfd;
 		newfd =3D -1;
@@ -839,6 +896,8 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
=20
 	e->ino =3D inode->fuse_ino;
 	e->version_offset =3D inode->version_offset;
+	lo_inode_put(lo, &inode);
+	lo_inode_put(lo, &dir);
=20
 	if (lo_debug(req))
 		fuse_debug("  %lli/%s -> %lli (version_table[%lli]=3D%lli)\n",
@@ -853,6 +912,8 @@ out_err:
 	saverr =3D errno;
 	if (newfd !=3D -1)
 		close(newfd);
+	lo_inode_put(lo, &inode);
+	lo_inode_put(lo, &dir);
 	return saverr;
 }
=20
@@ -963,7 +1024,7 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_in=
o_t parent,
 	if (res =3D=3D -1)
 		goto out;
=20
-	update_version(lo, lo_inode(req, parent));
+	update_version(lo, dir);
=20
 	saverr =3D lo_do_lookup(req, parent, name, &e);
 	if (saverr)
@@ -975,9 +1036,11 @@ static void lo_mknod_symlink(fuse_req_t req, fuse_i=
no_t parent,
 			   (unsigned long long) e.ino);
=20
 	fuse_reply_entry(req, &e, lo->shared);
+	lo_inode_put(lo, &dir);
 	return;
=20
 out:
+	lo_inode_put(lo, &dir);
 	if (newfd !=3D -1)
 		close(newfd);
 	fuse_reply_err(req, saverr);
@@ -1029,6 +1092,7 @@ fallback:
 	if (res !=3D -1) {
 		res =3D linkat(parent->fd, path, dfd, name, 0);
 		unref_inode(lo, parent, 1);
+		lo_inode_put(lo, &parent);
 	}
=20
 	return res;
@@ -1039,6 +1103,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino,=
 fuse_ino_t parent,
 {
 	int res;
 	struct lo_data *lo =3D lo_data(req);
+	struct lo_inode *parent_inode;
 	struct lo_inode *inode;
 	struct fuse_entry_param e;
 	int saverr;
@@ -1048,17 +1113,18 @@ static void lo_link(fuse_req_t req, fuse_ino_t in=
o, fuse_ino_t parent,
 		return;
 	}
=20
+	parent_inode =3D lo_inode(req, parent);
 	inode =3D lo_inode(req, ino);
-	if (!inode) {
-		fuse_reply_err(req, EBADF);
-		return;
+	if (!parent_inode || !inode) {
+		errno =3D EBADF;
+		goto out_err;
 	}
=20
 	memset(&e, 0, sizeof(struct fuse_entry_param));
 	e.attr_timeout =3D lo->timeout;
 	e.entry_timeout =3D lo->timeout;
=20
-	res =3D linkat_empty_nofollow(lo, inode, lo_fd(req, parent), name);
+	res =3D linkat_empty_nofollow(lo, inode, parent_inode->fd, name);
 	if (res =3D=3D -1)
 		goto out_err;
=20
@@ -1071,7 +1137,7 @@ static void lo_link(fuse_req_t req, fuse_ino_t ino,=
 fuse_ino_t parent,
 	pthread_mutex_unlock(&lo->mutex);
 	e.ino =3D inode->fuse_ino;
 	update_version(lo, inode);
-	update_version(lo, lo_inode(req, parent));
+	update_version(lo, parent_inode);
=20
 	if (lo_debug(req))
 		fuse_debug("  %lli/%s -> %lli\n",
@@ -1079,13 +1145,18 @@ static void lo_link(fuse_req_t req, fuse_ino_t in=
o, fuse_ino_t parent,
 			   (unsigned long long) e.ino);
=20
 	fuse_reply_entry(req, &e, lo->shared);
+	lo_inode_put(lo, &parent_inode);
+	lo_inode_put(lo, &inode);
 	return;
=20
 out_err:
 	saverr =3D errno;
+	lo_inode_put(lo, &parent_inode);
+	lo_inode_put(lo, &inode);
 	fuse_reply_err(req, saverr);
 }
=20
+/* Increments nlookup and caller must release refcount using lo_inode_pu=
t() */
 static struct lo_inode *lookup_name(fuse_req_t req, fuse_ino_t parent,
 				    const char *name)
 {
@@ -1121,11 +1192,20 @@ static void lo_rmdir(fuse_req_t req, fuse_ino_t p=
arent, const char *name)
 	if (res =3D=3D -1) {
 		fuse_reply_err(req, errno);
 	} else {
+		struct lo_inode *parent_inode;
+
 		update_version(lo, inode);
-		update_version(lo, lo_inode(req, parent));
+
+		parent_inode =3D lo_inode(req, parent);
+		if (parent_inode) {
+			update_version(lo, parent_inode);
+			lo_inode_put(lo, &parent_inode);
+		}
+
 		fuse_reply_err(req, 0);
 	}
 	unref_inode(lo, inode, 1);
+	lo_inode_put(lo, &inode);
 }
=20
 static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *nam=
e,
@@ -1133,8 +1213,10 @@ static void lo_rename(fuse_req_t req, fuse_ino_t p=
arent, const char *name,
 		      unsigned int flags)
 {
 	int res;
-	struct lo_inode *oldinode;
-	struct lo_inode *newinode;
+	struct lo_inode *parent_inode;
+	struct lo_inode *newparent_inode;
+	struct lo_inode *oldinode =3D NULL;
+	struct lo_inode *newinode =3D NULL;
 	struct lo_data *lo =3D lo_data(req);
=20
 	if (!is_safe_path_component(name) ||
@@ -1143,6 +1225,13 @@ static void lo_rename(fuse_req_t req, fuse_ino_t p=
arent, const char *name,
 		return;
 	}
=20
+	parent_inode =3D lo_inode(req, parent);
+	newparent_inode =3D lo_inode(req, newparent);
+	if (!parent_inode || !newparent_inode) {
+		fuse_reply_err(req, EBADF);
+		goto out;
+	}
+
 	oldinode =3D lookup_name(req, parent, name);
 	newinode =3D lookup_name(req, newparent, newname);
 	if (!oldinode) {
@@ -1155,8 +1244,8 @@ static void lo_rename(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
 #ifndef SYS_renameat2
 		fuse_reply_err(req, EINVAL);
 #else
-		res =3D syscall(SYS_renameat2, lo_fd(req, parent), name,
-			      lo_fd(req, newparent), newname, flags);
+		res =3D syscall(SYS_renameat2, parent_inode->fd, name,
+			      newparent_inode->fd, newname, flags);
 		if (res =3D=3D -1 && errno =3D=3D ENOSYS)
 			fuse_reply_err(req, EINVAL);
 		else
@@ -1165,21 +1254,24 @@ static void lo_rename(fuse_req_t req, fuse_ino_t =
parent, const char *name,
 		goto out;
 	}
=20
-	res =3D renameat(lo_fd(req, parent), name,
-			lo_fd(req, newparent), newname);
+	res =3D renameat(parent_inode->fd, name, newparent_inode->fd, newname);
 	if (res =3D=3D -1) {
 		fuse_reply_err(req, errno);
 	} else {
 		update_version(lo, oldinode);
 		if (newinode)
 			update_version(lo, newinode);
-		update_version(lo, lo_inode(req, parent));
-		update_version(lo, lo_inode(req, newparent));
+		update_version(lo, parent_inode);
+		update_version(lo, newparent_inode);
 		fuse_reply_err(req, 0);
 	}
 out:
 	unref_inode(lo, oldinode, 1);
 	unref_inode(lo, newinode, 1);
+	lo_inode_put(lo, &oldinode);
+	lo_inode_put(lo, &newinode);
+	lo_inode_put(lo, &parent_inode);
+	lo_inode_put(lo, &newparent_inode);
 }
=20
 static void lo_unlink(fuse_req_t req, fuse_ino_t parent, const char *nam=
e)
@@ -1203,11 +1295,20 @@ static void lo_unlink(fuse_req_t req, fuse_ino_t =
parent, const char *name)
 	if (res =3D=3D -1) {
 		fuse_reply_err(req, errno);
 	} else {
+		struct lo_inode *parent_inode;
+
 		update_version(lo, inode);
-		update_version(lo, lo_inode(req, parent));
+
+		parent_inode =3D lo_inode(req, parent);
+		if (parent_inode) {
+			update_version(lo, parent_inode);
+			lo_inode_put(lo, &parent_inode);
+		}
+
 		fuse_reply_err(req, 0);
 	}
 	unref_inode(lo, inode, 1);
+	lo_inode_put(lo, &inode);
 }
=20
 static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint=
64_t n)
@@ -1227,9 +1328,9 @@ static void unref_inode(struct lo_data *lo, struct =
lo_inode *inode, uint64_t n)
 		g_hash_table_destroy(inode->posix_locks);
 		pthread_mutex_destroy(&inode->plock_mutex);
 		pthread_mutex_unlock(&lo->mutex);
-		close(inode->fd);
-		put_shared(lo, inode);
-		free(inode);
+
+		/* Drop our refcount from lo_do_lookup() */
+		lo_inode_put(lo, &inode);
 	} else {
 		pthread_mutex_unlock(&lo->mutex);
 	}
@@ -1244,6 +1345,7 @@ static int unref_all_inodes_cb(gpointer key, gpoint=
er value,
 	inode->nlookup =3D 0;
 	lo_map_remove(&lo->ino_map, inode->fuse_ino);
 	close(inode->fd);
+	lo_inode_put(lo, &inode); /* Drop our refcount from lo_do_lookup() */
=20
 	return TRUE;
 }
@@ -1273,6 +1375,7 @@ static void lo_forget_one(fuse_req_t req, fuse_ino_=
t ino, uint64_t nlookup)
 	}
=20
 	unref_inode(lo, inode, nlookup);
+	lo_inode_put(lo, &inode);
 }
=20
 static void lo_forget(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup)
@@ -1492,6 +1595,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_=
t ino, size_t size,
     err =3D 0;
 error:
     lo_dirp_put(&d);
+    lo_inode_put(lo, &dinode);
=20
     // If there's an error, we can only signal it if we haven't stored
     // any entries yet - otherwise we'd end up with wrong lookup
@@ -1546,6 +1650,7 @@ static void lo_create(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
 {
 	int fd;
 	struct lo_data *lo =3D lo_data(req);
+	struct lo_inode *parent_inode;
 	struct fuse_entry_param e;
 	int err;
 	struct lo_cred old =3D {};
@@ -1559,11 +1664,17 @@ static void lo_create(fuse_req_t req, fuse_ino_t =
parent, const char *name,
 		return;
 	}
=20
+	parent_inode =3D lo_inode(req, parent);
+	if (!parent_inode) {
+		fuse_reply_err(req, EBADF);
+		return;
+	}
+
 	err =3D lo_change_cred(req, &old);
 	if (err)
 		goto out;
=20
-	fd =3D openat(lo_fd(req, parent), name,
+	fd =3D openat(parent_inode->fd, name,
 		    (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
 	err =3D fd =3D=3D -1 ? errno : 0;
 	lo_restore_cred(&old);
@@ -1571,15 +1682,15 @@ static void lo_create(fuse_req_t req, fuse_ino_t =
parent, const char *name,
 	if (!err) {
 		ssize_t fh;
=20
-		update_version(lo, lo_inode(req, parent));
+		update_version(lo, parent_inode);
=20
 		pthread_mutex_lock(&lo->mutex);
 		fh =3D lo_add_fd_mapping(req, fd);
 		pthread_mutex_unlock(&lo->mutex);
 		if (fh =3D=3D -1) {
 			close(fd);
-			fuse_reply_err(req, ENOMEM);
-			return;
+			err =3D ENOMEM;
+			goto out;
 		}
=20
 		fi->fh =3D fh;
@@ -1591,6 +1702,8 @@ static void lo_create(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
 		fi->keep_cache =3D 1;
=20
 out:
+	lo_inode_put(lo, &parent_inode);
+
 	if (err)
 		fuse_reply_err(req, err);
 	else
@@ -1660,15 +1773,17 @@ static void lo_getlk(fuse_req_t req, fuse_ino_t i=
no,
 	plock =3D lookup_create_plock_ctx(lo, inode, fi->lock_owner, lock->l_pi=
d,
 			&ret);
 	if (!plock) {
-		pthread_mutex_unlock(&inode->plock_mutex);
-		fuse_reply_err(req, ret);
-		return;
+		saverr =3D ret;
+		goto out;
 	}
=20
 	ret =3D fcntl(plock->fd, F_OFD_GETLK, lock);
 	if (ret =3D=3D -1)
 		saverr =3D errno;
+
+out:
 	pthread_mutex_unlock(&inode->plock_mutex);
+	lo_inode_put(lo, &inode);
=20
 	if (saverr)
 		fuse_reply_err(req, saverr);
@@ -1707,9 +1822,8 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t ino=
,
 			&ret);
=20
 	if (!plock) {
-		pthread_mutex_unlock(&inode->plock_mutex);
-		fuse_reply_err(req, ret);
-		return;
+		saverr =3D ret;
+		goto out;
 	}
=20
 	/* TODO: Is it alright to modify flock? */
@@ -1718,7 +1832,11 @@ static void lo_setlk(fuse_req_t req, fuse_ino_t in=
o,
 	if (ret =3D=3D -1) {
 		saverr =3D errno;
 	}
+
+out:
 	pthread_mutex_unlock(&inode->plock_mutex);
+	lo_inode_put(lo, &inode);
+
 	fuse_reply_err(req, saverr);
 }
=20
@@ -1849,6 +1967,8 @@ static void lo_flush(fuse_req_t req, fuse_ino_t ino=
, struct fuse_file_info *fi)
=20
 	res =3D close(dup(lo_fi_fd(req, fi)));
 	fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+
+	lo_inode_put(lo_data(req), &inode);
 }
=20
 static void lo_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
@@ -1921,7 +2041,14 @@ static void lo_write_buf(fuse_req_t req, fuse_ino_=
t ino,
 	if(res < 0) {
 		fuse_reply_err(req, -res);
 	} else {
-		update_version(lo, lo_inode(req, ino));
+		struct lo_inode *inode;
+
+		inode =3D lo_inode(req, ino);
+		if (inode) {
+			update_version(lo, inode);
+			lo_inode_put(lo, &inode);
+		}
+
 		fuse_reply_write(req, (size_t) res);
 	}
 }
@@ -1948,7 +2075,13 @@ static void lo_fallocate(fuse_req_t req, fuse_ino_=
t ino, int mode,
         if (err < 0) {
                 err =3D errno;
         } else {
-		update_version(lo, lo_inode(req, ino));
+		struct lo_inode *inode;
+
+		inode =3D lo_inode(req, ino);
+		if (inode) {
+			update_version(lo, inode);
+			lo_inode_put(lo, &inode);
+		}
 	}
=20
 	fuse_reply_err(req, err);
@@ -2029,11 +2162,14 @@ out_free:
 	if (fd >=3D 0) {
 		close(fd);
 	}
+
+	lo_inode_put(lo, &inode);
 	return;
=20
 out_err:
 	saverr =3D errno;
 out:
+	lo_inode_put(lo, &inode);
 	fuse_reply_err(req, saverr);
 	goto out_free;
 }
@@ -2101,11 +2237,14 @@ out_free:
 	if (fd >=3D 0) {
 		close(fd);
 	}
+
+	lo_inode_put(lo, &inode);
 	return;
=20
 out_err:
 	saverr =3D errno;
 out:
+	lo_inode_put(lo, &inode);
 	fuse_reply_err(req, saverr);
 	goto out_free;
 }
@@ -2157,6 +2296,8 @@ out:
 	if (fd >=3D 0) {
 		close(fd);
 	}
+
+	lo_inode_put(lo, &inode);
 	fuse_reply_err(req, saverr);
 }
=20
@@ -2206,6 +2347,8 @@ out:
 	if (fd >=3D 0) {
 		close(fd);
 	}
+
+	lo_inode_put(lo, &inode);
 	fuse_reply_err(req, saverr);
 }
=20
@@ -2598,6 +2741,7 @@ static void setup_root(struct lo_data *lo, struct l=
o_inode *root)
 	root->key.ino =3D stat.st_ino;
 	root->key.dev =3D stat.st_dev;
 	root->nlookup =3D 2;
+	g_atomic_int_set(&root->refcount, 2);
 }
=20
 static void setup_proc_self_fd(struct lo_data *lo)
--=20
2.21.0



Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C066C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:12:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3171C2238C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3171C2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwGu-0007Xr-Bm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32903)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hqwGM-0005Le-0U
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hqwGG-0005Vw-Kb
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:11:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58756)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hqwGG-0005PB-AY
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:11:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9EB3581F25
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 09:11:34 +0000 (UTC)
Received: from localhost (ovpn-117-212.ams2.redhat.com [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D86455D9C6;
 Fri, 26 Jul 2019 09:11:29 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:11:03 +0100
Message-Id: <20190726091103.23503-6-stefanha@redhat.com>
In-Reply-To: <20190726091103.23503-1-stefanha@redhat.com>
References: <20190726091103.23503-1-stefanha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 26 Jul 2019 09:11:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/5] virtiofsd: prevent races with lo_dirp_put()
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce lo_dirp_put() so that FUSE_RELEASEDIR does not cause
use-after-free races with other threads that are accessing lo_dirp.

Also make lo_releasedir() atomic to prevent FUSE_RELEASEDIR racing with
itself.  This prevents double-frees.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 42 +++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passt=
hrough_ll.c
index ad3abdd532..f74e7d2d21 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -1293,11 +1293,28 @@ static void lo_readlink(fuse_req_t req, fuse_ino_=
t ino)
 }
=20
 struct lo_dirp {
+	gint refcount;
 	DIR *dp;
 	struct dirent *entry;
 	off_t offset;
 };
=20
+static void lo_dirp_put(struct lo_dirp **dp)
+{
+	struct lo_dirp *d =3D *dp;
+
+	if (!d) {
+		return;
+	}
+	*dp =3D NULL;
+
+	if (g_atomic_int_dec_and_test(&d->refcount)) {
+		closedir(d->dp);
+		free(d);
+	}
+}
+
+/* Call lo_dirp_put() on the return value when no longer needed */
 static struct lo_dirp *lo_dirp(fuse_req_t req, struct fuse_file_info *fi=
)
 {
 	struct lo_data *lo =3D lo_data(req);
@@ -1305,6 +1322,9 @@ static struct lo_dirp *lo_dirp(fuse_req_t req, stru=
ct fuse_file_info *fi)
=20
 	pthread_mutex_lock(&lo->mutex);
 	elem =3D lo_map_get(&lo->dirp_map, fi->fh);
+	if (elem) {
+		g_atomic_int_inc(&elem->dirp->refcount);
+	}
 	pthread_mutex_unlock(&lo->mutex);
 	if (!elem)
 		return NULL;
@@ -1335,6 +1355,8 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t i=
no, struct fuse_file_info *fi
 	d->offset =3D 0;
 	d->entry =3D NULL;
=20
+	g_atomic_int_set(&d->refcount, 1); /* paired with lo_releasedir() */
+
 	fh =3D lo_add_dirp_mapping(req, d);
 	if (fh =3D=3D -1)
 		goto out_err;
@@ -1363,7 +1385,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_=
t ino, size_t size,
 			  off_t offset, struct fuse_file_info *fi, int plus)
 {
 	struct lo_data *lo =3D lo_data(req);
-	struct lo_dirp *d;
+	struct lo_dirp *d =3D NULL;
 	struct lo_inode *dinode;
 	char *buf =3D NULL;
 	char *p;
@@ -1451,6 +1473,8 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_=
t ino, size_t size,
=20
     err =3D 0;
 error:
+    lo_dirp_put(&d);
+
     // If there's an error, we can only signal it if we haven't stored
     // any entries yet - otherwise we'd end up with wrong lookup
     // counts for the entries that are already in the buffer. So we
@@ -1477,22 +1501,25 @@ static void lo_readdirplus(fuse_req_t req, fuse_i=
no_t ino, size_t size,
 static void lo_releasedir(fuse_req_t req, fuse_ino_t ino, struct fuse_fi=
le_info *fi)
 {
 	struct lo_data *lo =3D lo_data(req);
+	struct lo_map_elem *elem;
 	struct lo_dirp *d;
=20
 	(void) ino;
=20
-	d =3D lo_dirp(req, fi);
-	if (!d) {
+	pthread_mutex_lock(&lo->mutex);
+	elem =3D lo_map_get(&lo->dirp_map, fi->fh);
+	if (!elem) {
+		pthread_mutex_unlock(&lo->mutex);
 		fuse_reply_err(req, EBADF);
 		return;
 	}
=20
-	pthread_mutex_lock(&lo->mutex);
+	d =3D elem->dirp;
 	lo_map_remove(&lo->dirp_map, fi->fh);
 	pthread_mutex_unlock(&lo->mutex);
=20
-	closedir(d->dp);
-	free(d);
+	lo_dirp_put(&d); /* paired with lo_opendir() */
+
 	fuse_reply_err(req, 0);
 }
=20
@@ -1701,6 +1728,9 @@ static void lo_fsyncdir(fuse_req_t req, fuse_ino_t =
ino, int datasync,
 		res =3D fdatasync(fd);
 	else
 		res =3D fsync(fd);
+
+	lo_dirp_put(&d);
+
 	fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
--=20
2.21.0



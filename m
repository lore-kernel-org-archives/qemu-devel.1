Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6044C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:56:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA46422464
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVjz1BPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA46422464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuheT-0005pS-CA
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:56:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufep-00061W-Hz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufeo-0008Lu-7m
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39153
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufen-0008KB-Rl
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3ReKNj1rFDFIIQee82NxUM9rjpuTICrYfS2n3sBKG9Y=;
 b=LVjz1BPIElf3N7BO/Gh2MAfyGdv3Tx0hOWRjAC4aKLYDVvdssjZox6UxLHtaN5XSnM/pGz
 QdywsKUp0DnwOEbFMvagmxxIBbw1hKE7Q8ZYEVa5CTjsIDpqN2ly8oftR0M0E/oBlVCeqM
 t4GNrAjcKrX+dUhMBJwWKD68t77G56k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-CyXn6GHAMoyiKLwBxak2Ug-1; Thu, 23 Jan 2020 11:48:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDA288024D8
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:34 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 466E119C69;
 Thu, 23 Jan 2020 16:48:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 089/108] virtiofsd: prevent races with lo_dirp_put()
Date: Thu, 23 Jan 2020 16:46:11 +0000
Message-Id: <20200123164630.91498-90-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: CyXn6GHAMoyiKLwBxak2Ug-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Introduce lo_dirp_put() so that FUSE_RELEASEDIR does not cause
use-after-free races with other threads that are accessing lo_dirp.

Also make lo_releasedir() atomic to prevent FUSE_RELEASEDIR racing with
itself.  This prevents double-frees.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 41 +++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 690edbc4c5..2d703b57e5 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1284,11 +1284,28 @@ static void lo_readlink(fuse_req_t req, fuse_ino_t =
ino)
 }
=20
 struct lo_dirp {
+    gint refcount;
     DIR *dp;
     struct dirent *entry;
     off_t offset;
 };
=20
+static void lo_dirp_put(struct lo_dirp **dp)
+{
+    struct lo_dirp *d =3D *dp;
+
+    if (!d) {
+        return;
+    }
+    *dp =3D NULL;
+
+    if (g_atomic_int_dec_and_test(&d->refcount)) {
+        closedir(d->dp);
+        free(d);
+    }
+}
+
+/* Call lo_dirp_put() on the return value when no longer needed */
 static struct lo_dirp *lo_dirp(fuse_req_t req, struct fuse_file_info *fi)
 {
     struct lo_data *lo =3D lo_data(req);
@@ -1296,6 +1313,9 @@ static struct lo_dirp *lo_dirp(fuse_req_t req, struct=
 fuse_file_info *fi)
=20
     pthread_mutex_lock(&lo->mutex);
     elem =3D lo_map_get(&lo->dirp_map, fi->fh);
+    if (elem) {
+        g_atomic_int_inc(&elem->dirp->refcount);
+    }
     pthread_mutex_unlock(&lo->mutex);
     if (!elem) {
         return NULL;
@@ -1331,6 +1351,7 @@ static void lo_opendir(fuse_req_t req, fuse_ino_t ino=
,
     d->offset =3D 0;
     d->entry =3D NULL;
=20
+    g_atomic_int_set(&d->refcount, 1); /* paired with lo_releasedir() */
     pthread_mutex_lock(&lo->mutex);
     fh =3D lo_add_dirp_mapping(req, d);
     pthread_mutex_unlock(&lo->mutex);
@@ -1364,7 +1385,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t =
ino, size_t size,
                           off_t offset, struct fuse_file_info *fi, int plu=
s)
 {
     struct lo_data *lo =3D lo_data(req);
-    struct lo_dirp *d;
+    struct lo_dirp *d =3D NULL;
     struct lo_inode *dinode;
     char *buf =3D NULL;
     char *p;
@@ -1454,6 +1475,8 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t =
ino, size_t size,
=20
     err =3D 0;
 error:
+    lo_dirp_put(&d);
+
     /*
      * If there's an error, we can only signal it if we haven't stored
      * any entries yet - otherwise we'd end up with wrong lookup
@@ -1484,22 +1507,25 @@ static void lo_releasedir(fuse_req_t req, fuse_ino_=
t ino,
                           struct fuse_file_info *fi)
 {
     struct lo_data *lo =3D lo_data(req);
+    struct lo_map_elem *elem;
     struct lo_dirp *d;
=20
     (void)ino;
=20
-    d =3D lo_dirp(req, fi);
-    if (!d) {
+    pthread_mutex_lock(&lo->mutex);
+    elem =3D lo_map_get(&lo->dirp_map, fi->fh);
+    if (!elem) {
+        pthread_mutex_unlock(&lo->mutex);
         fuse_reply_err(req, EBADF);
         return;
     }
=20
-    pthread_mutex_lock(&lo->mutex);
+    d =3D elem->dirp;
     lo_map_remove(&lo->dirp_map, fi->fh);
     pthread_mutex_unlock(&lo->mutex);
=20
-    closedir(d->dp);
-    free(d);
+    lo_dirp_put(&d); /* paired with lo_opendir() */
+
     fuse_reply_err(req, 0);
 }
=20
@@ -1710,6 +1736,9 @@ static void lo_fsyncdir(fuse_req_t req, fuse_ino_t in=
o, int datasync,
     } else {
         res =3D fsync(fd);
     }
+
+    lo_dirp_put(&d);
+
     fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
--=20
2.24.1



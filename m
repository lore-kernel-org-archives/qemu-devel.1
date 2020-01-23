Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC69FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFCD21569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXSjruBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFCD21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuhdc-0004V0-Ne
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufe0-00051u-RX
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufdz-0006aC-NP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46384
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufdz-0006Zy-Kb
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0Lhh+I0+KtmU0zBtZkPdeAoo7iid017XA4V8Gz/OB8=;
 b=XXSjruBLqFbbmVq+u8Bz4QG27eNNe5tSGO74fUHM9xXZy5lgzdH+a3l5v4oqtpjGkM2Dhl
 MI05VfNlteZUWd0BDaLkToLZwGsU1OpFZTImzCkTe3q0QeIQi6Iv3VplTqeHC/imrnyKwl
 NuoI5g3vWbYVkYf/DAWmK29q3YH7JaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-_xKzQjFIPo2FbVgcWJo83Q-1; Thu, 23 Jan 2020 11:47:45 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7192C1034B40
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:47:44 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDB4B28994;
 Thu, 23 Jan 2020 16:47:43 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 047/108] virtiofsd: prevent ".." escape in lo_do_readdir()
Date: Thu, 23 Jan 2020 16:45:29 +0000
Message-Id: <20200123164630.91498-48-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _xKzQjFIPo2FbVgcWJo83Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

Construct a fake dirent for the root directory's ".." entry.  This hides
the parent directory from the FUSE client.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 36 +++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 79d5966eea..e3d65c3676 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1149,19 +1149,25 @@ out_err:
 static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
                           off_t offset, struct fuse_file_info *fi, int plu=
s)
 {
+    struct lo_data *lo =3D lo_data(req);
     struct lo_dirp *d;
+    struct lo_inode *dinode;
     char *buf =3D NULL;
     char *p;
     size_t rem =3D size;
-    int err =3D ENOMEM;
+    int err =3D EBADF;
=20
-    (void)ino;
+    dinode =3D lo_inode(req, ino);
+    if (!dinode) {
+        goto error;
+    }
=20
     d =3D lo_dirp(req, fi);
     if (!d) {
         goto error;
     }
=20
+    err =3D ENOMEM;
     buf =3D calloc(1, size);
     if (!buf) {
         goto error;
@@ -1192,15 +1198,21 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_=
t ino, size_t size,
         }
         nextoff =3D d->entry->d_off;
         name =3D d->entry->d_name;
+
         fuse_ino_t entry_ino =3D 0;
+        struct fuse_entry_param e =3D (struct fuse_entry_param){
+            .attr.st_ino =3D d->entry->d_ino,
+            .attr.st_mode =3D d->entry->d_type << 12,
+        };
+
+        /* Hide root's parent directory */
+        if (dinode =3D=3D &lo->root && strcmp(name, "..") =3D=3D 0) {
+            e.attr.st_ino =3D lo->root.ino;
+            e.attr.st_mode =3D DT_DIR << 12;
+        }
+
         if (plus) {
-            struct fuse_entry_param e;
-            if (is_dot_or_dotdot(name)) {
-                e =3D (struct fuse_entry_param){
-                    .attr.st_ino =3D d->entry->d_ino,
-                    .attr.st_mode =3D d->entry->d_type << 12,
-                };
-            } else {
+            if (!is_dot_or_dotdot(name)) {
                 err =3D lo_do_lookup(req, ino, name, &e);
                 if (err) {
                     goto error;
@@ -1210,11 +1222,7 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t=
 ino, size_t size,
=20
             entsize =3D fuse_add_direntry_plus(req, p, rem, name, &e, next=
off);
         } else {
-            struct stat st =3D {
-                .st_ino =3D d->entry->d_ino,
-                .st_mode =3D d->entry->d_type << 12,
-            };
-            entsize =3D fuse_add_direntry(req, p, rem, name, &st, nextoff)=
;
+            entsize =3D fuse_add_direntry(req, p, rem, name, &e.attr, next=
off);
         }
         if (entsize > rem) {
             if (entry_ino !=3D 0) {
--=20
2.24.1



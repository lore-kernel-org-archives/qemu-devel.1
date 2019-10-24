Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65635CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:24:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FB5A20679
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 12:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHnDL93w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB5A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNcAA-0003cA-RF
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 08:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iNbID-0003oH-9h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iNbIB-00006c-AB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iNbIB-000050-5y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 07:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571916509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gGhKQJOyOC1EYSaaw2IqzcvcqSb54BtgY89/1NGOOpE=;
 b=JHnDL93wBGY+8Ji1NCTBuYXF1XN1tQv4WcuWC78xty0XwsDC5PW2POgO44nImIiECOL2v8
 0mjGo6s5O+H8de6oVgOEN4CCoNVfFOy0cVV8wfGtLbVcFeV1jRhg35wJ1vqXCaGu4wuhR7
 kTtRRV8D1s79/jwo4mj90rXe3UfudIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-INLMrqsaP-C0pFLcigJtpQ-1; Thu, 24 Oct 2019 07:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 392EB1800E00;
 Thu, 24 Oct 2019 11:28:24 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-248.ams2.redhat.com
 [10.36.117.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9C4752DD;
 Thu, 24 Oct 2019 11:28:16 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, renzhen@linux.alibaba.com, eguan@linux.alibaba.com,
 ganesh.mahalingam@intel.com, m.mizuma@jp.fujitsu.com, mszeredi@redhat.com,
 misono.tomohiro@jp.fujitsu.com, tao.peng@linux.alibaba.com,
 piaojun@huawei.com, stefanha@redhat.com, vgoyal@redhat.com, mst@redhat.com,
 berrange@redhat.com
Subject: [PATCH 14/25] virtiofsd: prevent ".." escape in lo_do_readdir()
Date: Thu, 24 Oct 2019 12:27:07 +0100
Message-Id: <20191024112718.34657-15-dgilbert@redhat.com>
In-Reply-To: <20191024112718.34657-1-dgilbert@redhat.com>
References: <20191024112718.34657-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: INLMrqsaP-C0pFLcigJtpQ-1
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

Construct a fake dirent for the root directory's ".." entry.  This hides
the parent directory from the FUSE client.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 contrib/virtiofsd/passthrough_ll.c | 36 ++++++++++++++++++------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/contrib/virtiofsd/passthrough_ll.c b/contrib/virtiofsd/passthr=
ough_ll.c
index 7a61bf94fe..cb01e3f088 100644
--- a/contrib/virtiofsd/passthrough_ll.c
+++ b/contrib/virtiofsd/passthrough_ll.c
@@ -1087,18 +1087,24 @@ out_err:
 static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
 =09=09=09  off_t offset, struct fuse_file_info *fi, int plus)
 {
+=09struct lo_data *lo =3D lo_data(req);
 =09struct lo_dirp *d;
+=09struct lo_inode *dinode;
 =09char *buf =3D NULL;
 =09char *p;
 =09size_t rem =3D size;
-=09int err =3D ENOMEM;
+=09int err =3D EBADF;
=20
-=09(void) ino;
+=09dinode =3D lo_inode(req, ino);
+=09if (!dinode) {
+=09=09goto error;
+=09}
=20
 =09d =3D lo_dirp(req, fi);
 =09if (!d)
 =09=09goto error;
=20
+=09err =3D ENOMEM;
 =09buf =3D calloc(1, size);
 =09if (!buf)
 =09=09goto error;
@@ -1128,15 +1134,21 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_=
t ino, size_t size,
 =09=09}
 =09=09nextoff =3D d->entry->d_off;
 =09=09name =3D d->entry->d_name;
+
 =09=09fuse_ino_t entry_ino =3D 0;
+=09=09struct fuse_entry_param e =3D (struct fuse_entry_param) {
+=09=09=09.attr.st_ino =3D d->entry->d_ino,
+=09=09=09.attr.st_mode =3D d->entry->d_type << 12,
+=09=09};
+
+=09=09/* Hide root's parent directory */
+=09=09if (dinode =3D=3D &lo->root && strcmp(name, "..") =3D=3D 0) {
+=09=09=09e.attr.st_ino =3D lo->root.ino;
+=09=09=09e.attr.st_mode =3D DT_DIR << 12;
+=09=09}
+
 =09=09if (plus) {
-=09=09=09struct fuse_entry_param e;
-=09=09=09if (is_dot_or_dotdot(name)) {
-=09=09=09=09e =3D (struct fuse_entry_param) {
-=09=09=09=09=09.attr.st_ino =3D d->entry->d_ino,
-=09=09=09=09=09.attr.st_mode =3D d->entry->d_type << 12,
-=09=09=09=09};
-=09=09=09} else {
+=09=09=09if (!is_dot_or_dotdot(name)) {
 =09=09=09=09err =3D lo_do_lookup(req, ino, name, &e);
 =09=09=09=09if (err)
 =09=09=09=09=09goto error;
@@ -1146,12 +1158,8 @@ static void lo_do_readdir(fuse_req_t req, fuse_ino_t=
 ino, size_t size,
 =09=09=09entsize =3D fuse_add_direntry_plus(req, p, rem, name,
 =09=09=09=09=09=09=09 &e, nextoff);
 =09=09} else {
-=09=09=09struct stat st =3D {
-=09=09=09=09.st_ino =3D d->entry->d_ino,
-=09=09=09=09.st_mode =3D d->entry->d_type << 12,
-=09=09=09};
 =09=09=09entsize =3D fuse_add_direntry(req, p, rem, name,
-=09=09=09=09=09=09    &st, nextoff);
+=09=09=09=09=09=09    &e.attr, nextoff);
 =09=09}
 =09=09if (entsize > rem) {
 =09=09=09if (entry_ino !=3D 0)=20
--=20
2.23.0



Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842ACC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:25:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB5422522
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXJvDRHe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB5422522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iui6P-0006HW-1n
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iufeU-0005dE-CZ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iufeS-0007O6-VC
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34551
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iufeS-0007Mn-Ru
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 11:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579798096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqFHjCa63VjAQgCnqoCc+ezuVNFgz+GXcx/wbttabSY=;
 b=EXJvDRHe30dhHU/hc1h5b0g/aXcJp1ID3Aqv4a8C3xa0CSWhGP+yS2SHLqHGSt4pJAHwv0
 XQZ59V2kt/ULLaPS3eY0hq7SYEA1AduxnenP3F/F+iN1WqvIx5qaapGEsl9ycjczUnaPzJ
 R1Yy5oDHlPcqQUxksnPuXHbNGH5E6IE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-zFIm27ynNUWorRs7Chm_kQ-1; Thu, 23 Jan 2020 11:48:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4256108839E
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:48:12 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-110.ams2.redhat.com
 [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A2E838F;
 Thu, 23 Jan 2020 16:48:12 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Subject: [PULL 071/108] virtiofsd: fail when parent inode isn't known in
 lo_do_lookup()
Date: Thu, 23 Jan 2020 16:45:53 +0000
Message-Id: <20200123164630.91498-72-dgilbert@redhat.com>
In-Reply-To: <20200123164630.91498-1-dgilbert@redhat.com>
References: <20200123164630.91498-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: zFIm27ynNUWorRs7Chm_kQ-1
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

From: Miklos Szeredi <mszeredi@redhat.com>

The Linux file handle APIs (struct export_operations) can access inodes
that are not attached to parents because path name traversal is not
performed.  Refuse if there is no parent in lo_do_lookup().

Also clean up lo_do_lookup() while we're here.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 tools/virtiofsd/passthrough_ll.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index de12e75a9e..33bfb4d1f4 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -777,6 +777,15 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t par=
ent, const char *name,
     struct lo_data *lo =3D lo_data(req);
     struct lo_inode *inode, *dir =3D lo_inode(req, parent);
=20
+    /*
+     * name_to_handle_at() and open_by_handle_at() can reach here with fus=
e
+     * mount point in guest, but we don't have its inode info in the
+     * ino_map.
+     */
+    if (!dir) {
+        return ENOENT;
+    }
+
     memset(e, 0, sizeof(*e));
     e->attr_timeout =3D lo->timeout;
     e->entry_timeout =3D lo->timeout;
@@ -786,7 +795,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         name =3D ".";
     }
=20
-    newfd =3D openat(lo_fd(req, parent), name, O_PATH | O_NOFOLLOW);
+    newfd =3D openat(dir->fd, name, O_PATH | O_NOFOLLOW);
     if (newfd =3D=3D -1) {
         goto out_err;
     }
@@ -796,7 +805,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         goto out_err;
     }
=20
-    inode =3D lo_find(lo_data(req), &e->attr);
+    inode =3D lo_find(lo, &e->attr);
     if (inode) {
         close(newfd);
         newfd =3D -1;
@@ -812,6 +821,7 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pare=
nt, const char *name,
         inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
         inode->refcount =3D 1;
         inode->fd =3D newfd;
+        newfd =3D -1;
         inode->ino =3D e->attr.st_ino;
         inode->dev =3D e->attr.st_dev;
=20
--=20
2.24.1



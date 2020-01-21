Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF56C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38CCC206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 13:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NL2py8en"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38CCC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ittYw-0004t6-Uw
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 08:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itsgP-0002Zb-LH
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itsgM-0004Li-3m
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:31:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44597
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itsgL-0004LY-Vw
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 07:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579609857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gaEl8piEqPiD/Ywy09GGNeI1MpOB5XRCawXztqN1ZtY=;
 b=NL2py8enmbKF1b5KnASEDKSNhYP8kMc5jmxOTfRud5CyZr6cXBgi4UeVjJTcpBMIG9tiaL
 O/8Whl006fOo/KHLjiOQptsNIDfNfyh0ezAykbHG58Ibu2gfGNJGYrm/i/S3Yz9SI8QgQF
 fJmXMm/h/TfSeme9s+BT2Jsy9+My878=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-TuxXSrJyMYSooh0Ox3fLhg-1; Tue, 21 Jan 2020 07:30:55 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45ED28C7A4E;
 Tue, 21 Jan 2020 12:30:54 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0F3360BE0;
 Tue, 21 Jan 2020 12:30:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com, philmd@redhat.com
Subject: [PATCH v2 072/109] virtiofsd: fail when parent inode isn't known in
 lo_do_lookup()
Date: Tue, 21 Jan 2020 12:23:56 +0000
Message-Id: <20200121122433.50803-73-dgilbert@redhat.com>
In-Reply-To: <20200121122433.50803-1-dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: TuxXSrJyMYSooh0Ox3fLhg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
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
---
 tools/virtiofsd/passthrough_ll.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 57be7cf007..2d2c10ada9 100644
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



Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CECC35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BAC2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVS6ssZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BAC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz1uj-00034y-S2
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 12:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iz1i1-00040u-3J
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iz1hz-0003sx-UQ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iz1hz-0003r9-QZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 12:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580836195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25Vzx05ezmCCR9xfTapJ2wAy6GkhFkbul1CN8Vx0Bco=;
 b=XVS6ssZeUsL0XmTnzilh3dv10BjH9+mKHM7Sw11HVA4JoNR31jiYoq+xsHTMY0dHQkqnNG
 hjk6dc0ioyvP4SNGq0S26Jnu1/MoK5Wjp1DuEsTvTsAAv8BqhEsJm9XBEOYxN+P/EcZT32
 p6x8mBSBrSn36+CHC7wAvxx+/+LzJYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-cKj-kC3KPTqRjpcPFJS4Sw-1; Tue, 04 Feb 2020 12:09:51 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B18A0800D54;
 Tue,  4 Feb 2020 17:09:50 +0000 (UTC)
Received: from localhost (ovpn-117-98.ams2.redhat.com [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 104A51001B08;
 Tue,  4 Feb 2020 17:09:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 20/33] block: Switch child_format users to child_of_bds
Date: Tue,  4 Feb 2020 18:08:35 +0100
Message-Id: <20200204170848.614480-21-mreitz@redhat.com>
In-Reply-To: <20200204170848.614480-1-mreitz@redhat.com>
References: <20200204170848.614480-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: cKj-kC3KPTqRjpcPFJS4Sw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both users (quorum and blkverify) use child_format for
not-really-filtered children, so the appropriate BdrvChildRole in both
cases is DATA.  (Note that this will cause bdrv_inherited_options() to
force-allow format probing.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkverify.c | 4 ++--
 block/quorum.c    | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blkverify.c b/block/blkverify.c
index ba4f6d7b7c..1684b7aa2e 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -134,8 +134,8 @@ static int blkverify_open(BlockDriverState *bs, QDict *=
options, int flags,
=20
     /* Open the test file */
     s->test_file =3D bdrv_open_child(qemu_opt_get(opts, "x-image"), option=
s,
-                                   "test", bs, &child_format, 0, false,
-                                   &local_err);
+                                   "test", bs, &child_of_bds, BDRV_CHILD_D=
ATA,
+                                   false, &local_err);
     if (local_err) {
         ret =3D -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/quorum.c b/block/quorum.c
index 62fe37856d..1189ea209b 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -992,8 +992,8 @@ static int quorum_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
         assert(ret < 32);
=20
         s->children[i].child =3D bdrv_open_child(NULL, options, indexstr, =
bs,
-                                               &child_format, 0, false,
-                                               &local_err);
+                                               &child_of_bds, BDRV_CHILD_D=
ATA,
+                                               false, &local_err);
         if (local_err) {
             ret =3D -EINVAL;
             goto close_exit;
@@ -1069,7 +1069,8 @@ static void quorum_add_child(BlockDriverState *bs, Bl=
ockDriverState *child_bs,
     /* We can safely add the child now */
     bdrv_ref(child_bs);
=20
-    child =3D bdrv_attach_child(bs, child_bs, indexstr, &child_format, 0, =
errp);
+    child =3D bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
+                              BDRV_CHILD_DATA, errp);
     if (child =3D=3D NULL) {
         s->next_child_index--;
         goto out;
--=20
2.24.1



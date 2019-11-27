Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C3C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F13E020409
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoCwBabi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F13E020409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxgC-0001qg-3K
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:48:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxCy-0004pC-NQ
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:18:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxCu-0007gE-UU
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:18:14 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36215
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxCu-0007fr-Qe
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Om7D7T0ILN0H5CZC75Qty840QMLuJVIFJELdVcv3dqE=;
 b=RoCwBabikjTc8pxiuBwCn/OpGYO/bCNbOU7eGebsL+A/j7UWFqqLbYF3ibbrqmNKSwqQMo
 IKARG2ZD3lwqsPyi+o06ORqWTRwcGbzLAlRdpfT34HJIBp5zVrYECL7eD+f+A0JzhdTDVm
 03RmHkZ2Vr3nBzQYjG9HI3dcmDoSpTI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-HTP2YoFxOPyNPMBnbswvMg-1; Wed, 27 Nov 2019 08:17:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB61D8026A7;
 Wed, 27 Nov 2019 13:17:10 +0000 (UTC)
Received: from localhost (ovpn-205-186.brq.redhat.com [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54CFE67646;
 Wed, 27 Nov 2019 13:17:10 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 18/31] block: Switch child_format users to child_of_bds
Date: Wed, 27 Nov 2019 14:16:11 +0100
Message-Id: <20191127131624.1062403-19-mreitz@redhat.com>
In-Reply-To: <20191127131624.1062403-1-mreitz@redhat.com>
References: <20191127131624.1062403-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: HTP2YoFxOPyNPMBnbswvMg-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both users (quorum and blkverify) use child_format for
not-really-filtered children, so the appropriate BdrvChildRole in both
cases is DATA | FORMAT.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/blkverify.c | 5 +++--
 block/quorum.c    | 9 ++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/block/blkverify.c b/block/blkverify.c
index ba4f6d7b7c..4f4d079b12 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -134,8 +134,9 @@ static int blkverify_open(BlockDriverState *bs, QDict *=
options, int flags,
=20
     /* Open the test file */
     s->test_file =3D bdrv_open_child(qemu_opt_get(opts, "x-image"), option=
s,
-                                   "test", bs, &child_format, 0, false,
-                                   &local_err);
+                                   "test", bs, &child_of_bds,
+                                   BDRV_CHILD_DATA | BDRV_CHILD_FORMAT,
+                                   false, &local_err);
     if (local_err) {
         ret =3D -EINVAL;
         error_propagate(errp, local_err);
diff --git a/block/quorum.c b/block/quorum.c
index a6b2d73668..29f7a14e7c 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -997,8 +997,10 @@ static int quorum_open(BlockDriverState *bs, QDict *op=
tions, int flags,
         assert(ret < 32);
=20
         s->children[i].child =3D bdrv_open_child(NULL, options, indexstr, =
bs,
-                                               &child_format, 0, false,
-                                               &local_err);
+                                               &child_of_bds,
+                                               BDRV_CHILD_DATA |
+                                               BDRV_CHILD_FORMAT,
+                                               false, &local_err);
         if (local_err) {
             ret =3D -EINVAL;
             goto close_exit;
@@ -1074,7 +1076,8 @@ static void quorum_add_child(BlockDriverState *bs, Bl=
ockDriverState *child_bs,
     /* We can safely add the child now */
     bdrv_ref(child_bs);
=20
-    child =3D bdrv_attach_child(bs, child_bs, indexstr, &child_format, 0, =
errp);
+    child =3D bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
+                              BDRV_CHILD_DATA | BDRV_CHILD_FORMAT, errp);
     if (child =3D=3D NULL) {
         s->next_child_index--;
         goto out;
--=20
2.23.0



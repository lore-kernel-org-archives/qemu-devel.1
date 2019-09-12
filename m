Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D752C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80CE20684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80CE20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Ptf-00017Y-OQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8PaX-0006Uu-Ba
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:56:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8PaW-0006NE-9P
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:56:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8PaU-0006Lj-2q; Thu, 12 Sep 2019 09:56:42 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6D60F8E581;
 Thu, 12 Sep 2019 13:56:41 +0000 (UTC)
Received: from localhost (unknown [10.40.205.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A29AE600C4;
 Thu, 12 Sep 2019 13:56:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:56:29 +0200
Message-Id: <20190912135632.13925-2-mreitz@redhat.com>
In-Reply-To: <20190912135632.13925-1-mreitz@redhat.com>
References: <20190912135632.13925-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 12 Sep 2019 13:56:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/4] mirror: Do not dereference invalid pointers
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mirror_exit_common() may be called twice (if it is called from
mirror_prepare() and fails, it will be called from mirror_abort()
again).

In such a case, many of the pointers in the MirrorBlockJob object will
already be freed.  This can be seen most reliably for s->target, which
is set to NULL (and then dereferenced by blk_bs()).

Cc: qemu-stable@nongnu.org
Fixes: 737efc1eda23b904fbe0e66b37715fb0e5c3e58b
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index fe984efb90..706d80fced 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -620,11 +620,11 @@ static int mirror_exit_common(Job *job)
 {
     MirrorBlockJob *s =3D container_of(job, MirrorBlockJob, common.job);
     BlockJob *bjob =3D &s->common;
-    MirrorBDSOpaque *bs_opaque =3D s->mirror_top_bs->opaque;
+    MirrorBDSOpaque *bs_opaque;
     AioContext *replace_aio_context =3D NULL;
-    BlockDriverState *src =3D s->mirror_top_bs->backing->bs;
-    BlockDriverState *target_bs =3D blk_bs(s->target);
-    BlockDriverState *mirror_top_bs =3D s->mirror_top_bs;
+    BlockDriverState *src;
+    BlockDriverState *target_bs;
+    BlockDriverState *mirror_top_bs;
     Error *local_err =3D NULL;
     bool abort =3D job->ret < 0;
     int ret =3D 0;
@@ -634,6 +634,11 @@ static int mirror_exit_common(Job *job)
     }
     s->prepared =3D true;
=20
+    mirror_top_bs =3D s->mirror_top_bs;
+    bs_opaque =3D mirror_top_bs->opaque;
+    src =3D mirror_top_bs->backing->bs;
+    target_bs =3D blk_bs(s->target);
+
     if (bdrv_chain_contains(src, target_bs)) {
         bdrv_unfreeze_backing_chain(mirror_top_bs, target_bs);
     }
--=20
2.21.0



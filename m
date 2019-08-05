Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050DAC0650F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC647206C1
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 14:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC647206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huePO-0003Pz-4s
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 10:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41712)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hueOx-0002ru-Gz
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hueOv-0003u7-Ih
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 10:55:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hueOs-0003ru-3x; Mon, 05 Aug 2019 10:55:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE6D930833B0;
 Mon,  5 Aug 2019 14:55:48 +0000 (UTC)
Received: from localhost (unknown [10.40.205.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE8FE60CCE;
 Mon,  5 Aug 2019 14:55:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  5 Aug 2019 16:55:41 +0200
Message-Id: <20190805145541.3731-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Mon, 05 Aug 2019 14:55:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2] mirror: Only mirror granularity-aligned
 chunks
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In write-blocking mode, all writes to the top node directly go to the
target.  We must only mirror chunks of data that are aligned to the
job's granularity, because that is how the dirty bitmap works.
Therefore, the request alignment for writes must be the job's
granularity (in write-blocking mode).

Unfortunately, this forces all reads and writes to have the same
granularity (we only need this alignment for writes to the target, not
the source), but that is something to be fixed another time.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
v2: Fix the placement of our bdrv_refresh_limits() call [Vladimir]
---
 block/mirror.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 8cb75fb409..7f0ff01beb 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1481,6 +1481,15 @@ static void bdrv_mirror_top_child_perm(BlockDriver=
State *bs, BdrvChild *c,
     *nshared =3D BLK_PERM_ALL;
 }
=20
+static void bdrv_mirror_top_refresh_limits(BlockDriverState *bs, Error *=
*errp)
+{
+    MirrorBDSOpaque *s =3D bs->opaque;
+
+    if (s && s->job && s->job->copy_mode =3D=3D MIRROR_COPY_MODE_WRITE_B=
LOCKING) {
+        bs->bl.request_alignment =3D s->job->granularity;
+    }
+}
+
 /* Dummy node that provides consistent read to its users without requiri=
ng it
  * from its backing file and that allows writes on the backing file chai=
n. */
 static BlockDriver bdrv_mirror_top =3D {
@@ -1493,6 +1502,7 @@ static BlockDriver bdrv_mirror_top =3D {
     .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,
     .bdrv_refresh_filename      =3D bdrv_mirror_top_refresh_filename,
     .bdrv_child_perm            =3D bdrv_mirror_top_child_perm,
+    .bdrv_refresh_limits        =3D bdrv_mirror_top_refresh_limits,
 };
=20
 static BlockJob *mirror_start_job(
@@ -1637,6 +1647,21 @@ static BlockJob *mirror_start_job(
         s->should_complete =3D true;
     }
=20
+    /*
+     * Must be called before we start tracking writes, but after
+     *
+     *     ((MirrorBlockJob *)
+     *         ((MirrorBDSOpaque *)
+     *             mirror_top_bs->opaque
+     *         )->job
+     *     )->copy_mode
+     *
+     * has the correct value.
+     * (We start tracking writes as of the following
+     * bdrv_create_dirty_bitmap() call.)
+     */
+    bdrv_refresh_limits(mirror_top_bs, &error_abort);
+
     s->dirty_bitmap =3D bdrv_create_dirty_bitmap(bs, granularity, NULL, =
errp);
     if (!s->dirty_bitmap) {
         goto fail;
--=20
2.21.0



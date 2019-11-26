Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CA8C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C69E62071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOdkr+AZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C69E62071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZaw1-0005GD-Q4
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 08:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39891)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZauc-00049M-8p
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZaua-0000wJ-Be
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:29:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20701
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZaua-0000vG-42
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574774987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glXsvTzAqSGFnaZ7yF21zgS+6qUqfNQK+PSP38hQfcI=;
 b=IOdkr+AZ0KyQUMoeA9dmNjn85knJwJKno36JKmCdmt1i4KdSbhYOpvSA4DeeYfm9J6JcSk
 X6hCzoVR/PpP6ojgw/Z22aY1OLAjfFZ/i7T0wNPmBALS2pKNmSyuAa3TRVyc7yM0TGcNeo
 HBZd6COfgKB9aPiCVzprSas1xm4U7ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-7vltM02XPIubPBtDbuCzYQ-1; Tue, 26 Nov 2019 08:29:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D25E132914;
 Tue, 26 Nov 2019 13:29:41 +0000 (UTC)
Received: from localhost (ovpn-204-240.brq.redhat.com [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DAE3E60BE2;
 Tue, 26 Nov 2019 13:29:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 1/2] block/qcow2-bitmap: fix bitmap migration
Date: Tue, 26 Nov 2019 14:29:35 +0100
Message-Id: <20191126132936.1141588-2-mreitz@redhat.com>
In-Reply-To: <20191126132936.1141588-1-mreitz@redhat.com>
References: <20191126132936.1141588-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7vltM02XPIubPBtDbuCzYQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Fix bitmap migration with dirty-bitmaps capability enabled and shared
storage. We should ignore IN_USE bitmaps in the image on target, when
migrating bitmaps through migration channel, see new comment below.

Fixes: 74da6b943565c451
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191125125229.13531-2-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 809bbc5d20..8abaf632fc 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -988,7 +988,26 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Er=
ror **errp)
     }
=20
     QSIMPLEQ_FOREACH(bm, bm_list, entry) {
-        BdrvDirtyBitmap *bitmap =3D load_bitmap(bs, bm, errp);
+        BdrvDirtyBitmap *bitmap;
+
+        if ((bm->flags & BME_FLAG_IN_USE) &&
+            bdrv_find_dirty_bitmap(bs, bm->name))
+        {
+            /*
+             * We already have corresponding BdrvDirtyBitmap, and bitmap i=
n the
+             * image is marked IN_USE. Firstly, this state is valid, no re=
ason
+             * to consider existing BdrvDirtyBitmap to be bad. Secondly it=
's
+             * absolutely possible, when we do migration with shared stora=
ge
+             * with dirty-bitmaps capability enabled: if the bitmap was lo=
aded
+             * from this storage before migration start, the storage will
+             * of-course contain IN_USE outdated version of the bitmap, an=
d we
+             * should not load it on migration target, as we already have =
this
+             * bitmap, being migrated.
+             */
+            continue;
+        }
+
+        bitmap =3D load_bitmap(bs, bm, errp);
         if (bitmap =3D=3D NULL) {
             goto fail;
         }
--=20
2.23.0



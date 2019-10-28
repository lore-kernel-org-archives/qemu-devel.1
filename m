Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7433DCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D9620873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuvtLgZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D9620873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4T3-00075n-FK
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wg-0002XK-Gv
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wf-0001qQ-9M
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21591
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wf-0001q7-4Z
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZF9YymZ7kRE4bi8nH2i1Dm5sPp21aqCJLNHtMFDrRco=;
 b=ZuvtLgZ5U9PWtRm7IR/L8e2lPpdK0lVA3+HPdnR5f7GQdLWkUbXyx6gxIoZwAOCYQvQcj9
 9ZQEXaHp8C5Vr1lUHq7y/Nhs7KiEhelx0q0O8a2BtLGyC3KMMSsO1mscTIGhyTBn9fdCXf
 2lbPB9v829JnjB6RYk5WfYIabLtSjSM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-0S_vy_QCMxaxFNhVPt5wmQ-1; Mon, 28 Oct 2019 08:16:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C90FA476;
 Mon, 28 Oct 2019 12:16:19 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BE396084E;
 Mon, 28 Oct 2019 12:16:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 37/69] block/block-copy: limit copy_range_size to 16 MiB
Date: Mon, 28 Oct 2019 13:14:29 +0100
Message-Id: <20191028121501.15279-38-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 0S_vy_QCMxaxFNhVPt5wmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Large copy range may imply memory allocation and large io effort, so
using 2G copy range request may be bad idea. Let's limit it to 16 MiB.
It also helps the following patch to refactor copy-with-offload
fallback to copy-with-bounce-buffer.

Note, that total memory usage of backup is still not limited, it will
be fixed in further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191022111805.3432-3-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index ecd086010e..cd45b373a9 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -18,6 +18,9 @@
 #include "qapi/error.h"
 #include "block/block-copy.h"
 #include "sysemu/block-backend.h"
+#include "qemu/units.h"
+
+#define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
=20
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
                                                        int64_t start,
@@ -70,9 +73,12 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, =
BdrvChild *target,
 {
     BlockCopyState *s;
     BdrvDirtyBitmap *copy_bitmap;
+
+    /* Ignore BLOCK_COPY_MAX_COPY_RANGE if requested cluster_size is large=
r */
     uint32_t max_transfer =3D
-            MIN_NON_ZERO(INT_MAX, MIN_NON_ZERO(source->bs->bl.max_transfer=
,
-                                               target->bs->bl.max_transfer=
));
+            MIN_NON_ZERO(MAX(cluster_size, BLOCK_COPY_MAX_COPY_RANGE),
+                         MIN_NON_ZERO(source->bs->bl.max_transfer,
+                                      target->bs->bl.max_transfer));
=20
     copy_bitmap =3D bdrv_create_dirty_bitmap(source->bs, cluster_size, NUL=
L,
                                            errp);
--=20
2.21.0



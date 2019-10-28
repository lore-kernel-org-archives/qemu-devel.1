Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7CBCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0CA20659
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDjdQk4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0CA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4Vk-0003lF-85
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3wk-0002bl-Nk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3wj-0001sg-GV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57595
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3wj-0001sN-Bn
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXPmQau9KjGn9ZwtheUphXzz220rJhcKYzxel56lcL0=;
 b=QDjdQk4nbYcy+h3P5SpB+HJVakrYYBCbSyKpcaPkBiNoztoRiLnCOgNPub63LyUZAf/J+T
 lJOt+W6/ho5uw//5zFvZLb5zyth5bw5xxonS1YeedSt3q+uOhlkQ2bRo13rMN6c/t8c5u3
 y8T/sV6TVNmQk98JpzThK55nIJogKFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-HynnLaVeOwup4IXkt7awfQ-1; Mon, 28 Oct 2019 08:16:27 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32077180496E;
 Mon, 28 Oct 2019 12:16:26 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C868660C4B;
 Mon, 28 Oct 2019 12:16:25 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 40/69] block/block-copy: add memory limit
Date: Mon, 28 Oct 2019 13:14:32 +0100
Message-Id: <20191028121501.15279-41-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: HynnLaVeOwup4IXkt7awfQ-1
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

Currently total allocation for parallel requests to block-copy instance
is unlimited. Let's limit it to 128 MiB.

For now block-copy is used only in backup, so actually we limit total
allocation for backup job.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191022111805.3432-6-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block-copy.h | 3 +++
 block/block-copy.c         | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index e2e135ff1b..edcdf0072d 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -16,6 +16,7 @@
 #define BLOCK_COPY_H
=20
 #include "block/block.h"
+#include "qemu/co-shared-resource.h"
=20
 typedef struct BlockCopyInFlightReq {
     int64_t start_byte;
@@ -69,6 +70,8 @@ typedef struct BlockCopyState {
      */
     ProgressResetCallbackFunc progress_reset_callback;
     void *progress_opaque;
+
+    SharedResource *mem;
 } BlockCopyState;
=20
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
diff --git a/block/block-copy.c b/block/block-copy.c
index 845b2423dc..7f0ebb58f8 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -21,6 +21,7 @@
 #include "qemu/units.h"
=20
 #define BLOCK_COPY_MAX_COPY_RANGE (16 * MiB)
+#define BLOCK_COPY_MAX_MEM (128 * MiB)
=20
 static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s,
                                                        int64_t start,
@@ -64,6 +65,7 @@ void block_copy_state_free(BlockCopyState *s)
     }
=20
     bdrv_release_dirty_bitmap(s->copy_bitmap);
+    shres_destroy(s->mem);
     g_free(s);
 }
=20
@@ -95,6 +97,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, B=
drvChild *target,
         .cluster_size =3D cluster_size,
         .len =3D bdrv_dirty_bitmap_size(copy_bitmap),
         .write_flags =3D write_flags,
+        .mem =3D shres_create(BLOCK_COPY_MAX_MEM),
     };
=20
     s->copy_range_size =3D QEMU_ALIGN_DOWN(max_transfer, cluster_size),
@@ -313,7 +316,9 @@ int coroutine_fn block_copy(BlockCopyState *s,
=20
         bdrv_reset_dirty_bitmap(s->copy_bitmap, start, chunk_end - start);
=20
+        co_get_from_shres(s->mem, chunk_end - start);
         ret =3D block_copy_do_copy(s, start, chunk_end, error_is_read);
+        co_put_to_shres(s->mem, chunk_end - start);
         if (ret < 0) {
             bdrv_set_dirty_bitmap(s->copy_bitmap, start, chunk_end - start=
);
             break;
--=20
2.21.0



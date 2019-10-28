Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F87CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:31:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14C3208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/G9vZdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14C3208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP4An-0004UK-Rc
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vo-0001OB-0p
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vm-0001K2-Ku
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27848
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vm-0001Jv-HO
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1u7kdgL2BXgYlqlkUPf9AKtLZyipQBK0M1JmEjfhCWE=;
 b=W/G9vZdy6m+be1ev23y9cxQhXkzRcAJxlNCdT3fxEfuKBQ+27Kf8GHwTsaFDjQ7907Kcp7
 llsdTOrIsfSzQyDxnPhznY8GXxVRIxDLVCce+1LNp+IJkQ+BVxJfOsPiCV7O68qu65c4aJ
 kxLw72SIW3Hzuf//yr6ZysLPSvTBpIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-ZvY9vhjMM7qS95j5-pW0qw-1; Mon, 28 Oct 2019 08:15:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 974A6107AD28;
 Mon, 28 Oct 2019 12:15:24 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F04A600C7;
 Mon, 28 Oct 2019 12:15:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 10/69] block/block-backend: add blk_co_pwritev_part
Date: Mon, 28 Oct 2019 13:14:02 +0100
Message-Id: <20191028121501.15279-11-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ZvY9vhjMM7qS95j5-pW0qw-1
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

Add blk write function with qiov_offset parameter. It's needed for the
following commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191011090711.19940-4-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/sysemu/block-backend.h |  4 ++++
 block/block-backend.c          | 17 +++++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.=
h
index 368d53af77..73f2cef7fe 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -121,6 +121,10 @@ void blk_set_dev_ops(BlockBackend *blk, const BlockDev=
Ops *ops, void *opaque);
 int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
+int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
+                                     unsigned int bytes,
+                                     QEMUIOVector *qiov, size_t qiov_offse=
t,
+                                     BdrvRequestFlags flags);
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
                                unsigned int bytes, QEMUIOVector *qiov,
                                BdrvRequestFlags flags);
diff --git a/block/block-backend.c b/block/block-backend.c
index eb22ff306e..912c50678d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1178,9 +1178,10 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, in=
t64_t offset,
     return ret;
 }
=20
-int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
-                                unsigned int bytes, QEMUIOVector *qiov,
-                                BdrvRequestFlags flags)
+int coroutine_fn blk_co_pwritev_part(BlockBackend *blk, int64_t offset,
+                                     unsigned int bytes,
+                                     QEMUIOVector *qiov, size_t qiov_offse=
t,
+                                     BdrvRequestFlags flags)
 {
     int ret;
     BlockDriverState *bs;
@@ -1207,11 +1208,19 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, =
int64_t offset,
         flags |=3D BDRV_REQ_FUA;
     }
=20
-    ret =3D bdrv_co_pwritev(blk->root, offset, bytes, qiov, flags);
+    ret =3D bdrv_co_pwritev_part(blk->root, offset, bytes, qiov, qiov_offs=
et,
+                               flags);
     bdrv_dec_in_flight(bs);
     return ret;
 }
=20
+int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
+                                unsigned int bytes, QEMUIOVector *qiov,
+                                BdrvRequestFlags flags)
+{
+    return blk_co_pwritev_part(blk, offset, bytes, qiov, 0, flags);
+}
+
 typedef struct BlkRwCo {
     BlockBackend *blk;
     int64_t offset;
--=20
2.21.0



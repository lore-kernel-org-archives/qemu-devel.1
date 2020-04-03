Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A13C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F9AF20757
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QR9WBvVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9AF20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJpF-00050V-Kx
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jKJoP-0003xW-PU
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jKJoO-0006So-Mb
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:44:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37983
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jKJoO-0006SL-J7
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585910672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cnqegz23nW1hpOaxoaYKoairv6E6mI41M3cjbrLkcuk=;
 b=QR9WBvVNg9vOKMD6Lo8XymVCHmZk+IlazP9co2xc527Uqtgt1d/VB3wExG4IjkgusUlvaU
 7sN89N2jOeK1PW5sl7shZxb/TvSCnoR10PUf00f0FVgufjmZ8Aq84XEy0QoW0thgKPox14
 dl7o70kyZM4ONX5HmOgxyuv+BeaXh/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-RV6xt6xyO4uZDLQRYX4VfA-1; Fri, 03 Apr 2020 06:44:30 -0400
X-MC-Unique: RV6xt6xyO4uZDLQRYX4VfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B57368018A1;
 Fri,  3 Apr 2020 10:44:28 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-132.ams2.redhat.com
 [10.36.113.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EC1BB96F83;
 Fri,  3 Apr 2020 10:44:26 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 1/2] block: Don't blk_wait_while_drained() in
 blk_co_preadv/pwritev
Date: Fri,  3 Apr 2020 12:44:14 +0200
Message-Id: <20200403104415.20963-2-kwolf@redhat.com>
In-Reply-To: <20200403104415.20963-1-kwolf@redhat.com>
References: <20200403104415.20963-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, s.reiter@proxmox.com,
 qemu-devel@nongnu.org, dietmar@proxmox.com, stefanha@redhat.com,
 mreitz@redhat.com, t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Calling blk_wait_while_drained() while blk->in_flight is increased for
the current request is wrong because it will cause the drain operation
to deadlock.

In blk_co_preadv() and blk_co_pwritev_part(), this deadlock is easily
fixed by simply removing the blk_wait_while_drained() call. We already
wait in blk_aio_read_entry() and blk_aio_write_entry(), and if a request
didn't wait there because it started basically at the same time as the
drain, we can simply let it complete.

We still do need the wait for emulating synchronous operations, which
don't have a second call yet, so add blk_wait_while_drained() calls
there.

Fixes: cf3129323f900ef5ddbccbe86e4fa801e88c566e
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 8b8f2a80a0..3124e367b3 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1154,8 +1154,6 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int=
64_t offset,
     int ret;
     BlockDriverState *bs;
=20
-    blk_wait_while_drained(blk);
-
     /* Call blk_bs() only after waiting, the graph may have changed */
     bs =3D blk_bs(blk);
     trace_blk_co_preadv(blk, bs, offset, bytes, flags);
@@ -1186,8 +1184,6 @@ int coroutine_fn blk_co_pwritev_part(BlockBackend *bl=
k, int64_t offset,
     int ret;
     BlockDriverState *bs;
=20
-    blk_wait_while_drained(blk);
-
     /* Call blk_bs() only after waiting, the graph may have changed */
     bs =3D blk_bs(blk);
     trace_blk_co_pwritev(blk, bs, offset, bytes, flags);
@@ -1234,6 +1230,7 @@ static void blk_read_entry(void *opaque)
     BlkRwCo *rwco =3D opaque;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
+    blk_wait_while_drained(rwco->blk);
     rwco->ret =3D blk_co_preadv(rwco->blk, rwco->offset, qiov->size,
                               qiov, rwco->flags);
     aio_wait_kick();
@@ -1244,6 +1241,7 @@ static void blk_write_entry(void *opaque)
     BlkRwCo *rwco =3D opaque;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
+    blk_wait_while_drained(rwco->blk);
     rwco->ret =3D blk_co_pwritev(rwco->blk, rwco->offset, qiov->size,
                                qiov, rwco->flags);
     aio_wait_kick();
--=20
2.20.1



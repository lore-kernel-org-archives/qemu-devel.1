Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E074C2BA17
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B9B249BC
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 17:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="egkKj8O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B9B249BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLVM6-0001Wu-5h
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 13:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLVL6-0008Uv-OG
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLVL5-00080f-KF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:15:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29489
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLVL5-00080W-Gf
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 13:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586193311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HF/tVOpn66mmfW9If+9ev51Qxkj3zPw+qslEcdMudv8=;
 b=egkKj8O3laj8aKMNRdLbjYOcaOHJzYqMQsRXDB7kK3Ni8W/HGHuoarRwoevEIvPXOdcGIO
 QtyaPS5AuYc7+uaSkGWRzR+iVbPdXiDkNqUtKCDIqSdSAnNB06n6q0qhbhmY32BI2DcWyC
 QlIWvbTJ5CkbSSj+lKYhBYQQjkwbk7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-LD_WZfecP6qd_69ZXYcu1A-1; Mon, 06 Apr 2020 13:15:06 -0400
X-MC-Unique: LD_WZfecP6qd_69ZXYcu1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E020C10FD887;
 Mon,  6 Apr 2020 17:14:15 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-74.ams2.redhat.com [10.36.113.74])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1472611CC04;
 Mon,  6 Apr 2020 17:14:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 3/3] block: Fix blk->in_flight during
 blk_wait_while_drained()
Date: Mon,  6 Apr 2020 19:14:03 +0200
Message-Id: <20200406171403.6761-4-kwolf@redhat.com>
In-Reply-To: <20200406171403.6761-1-kwolf@redhat.com>
References: <20200406171403.6761-1-kwolf@redhat.com>
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

Waiting in blk_wait_while_drained() while blk->in_flight is increased
for the current request is wrong because it will cause the drain
operation to deadlock.

This patch makes sure that blk_wait_while_drained() is called with
blk->in_flight increased exactly once for the current request, and that
it temporarily decreases the counter while it waits.

Fixes: cf3129323f900ef5ddbccbe86e4fa801e88c566e
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index d330e08b05..f621435f0b 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1140,10 +1140,15 @@ static int blk_check_byte_request(BlockBackend *blk=
, int64_t offset,
     return 0;
 }
=20
+/* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
 {
+    assert(blk->in_flight > 0);
+
     if (blk->quiesce_counter && !blk->disable_request_queuing) {
+        blk_dec_in_flight(blk);
         qemu_co_queue_wait(&blk->queued_requests, NULL);
+        blk_inc_in_flight(blk);
     }
 }
=20
@@ -1416,12 +1421,6 @@ static void blk_aio_read_entry(void *opaque)
     BlkRwCo *rwco =3D &acb->rwco;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
-    if (rwco->blk->quiesce_counter) {
-        blk_dec_in_flight(rwco->blk);
-        blk_wait_while_drained(rwco->blk);
-        blk_inc_in_flight(rwco->blk);
-    }
-
     assert(qiov->size =3D=3D acb->bytes);
     rwco->ret =3D blk_do_preadv(rwco->blk, rwco->offset, acb->bytes,
                               qiov, rwco->flags);
@@ -1434,12 +1433,6 @@ static void blk_aio_write_entry(void *opaque)
     BlkRwCo *rwco =3D &acb->rwco;
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
-    if (rwco->blk->quiesce_counter) {
-        blk_dec_in_flight(rwco->blk);
-        blk_wait_while_drained(rwco->blk);
-        blk_inc_in_flight(rwco->blk);
-    }
-
     assert(!qiov || qiov->size =3D=3D acb->bytes);
     rwco->ret =3D blk_do_pwritev_part(rwco->blk, rwco->offset, acb->bytes,
                                     qiov, 0, rwco->flags);
--=20
2.20.1



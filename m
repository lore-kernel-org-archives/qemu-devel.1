Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4858C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3D82063A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TortaL5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3D82063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLn9D-0008Js-Lh
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59338)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLn6i-0004DL-T8
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLn6h-0007vx-Pt
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:13:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38544
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLn6e-0007uY-CT
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586261608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pMiFVC4L+HygQg9Mg6OCC0cV3b6Gd5JfBKsySZrux7Q=;
 b=TortaL5hO3hcjF7fA+oZ6QcetYDYOm886VDiqLwaTw0iGkP2Hwx8A+oFSlWpoJo7OPQfXh
 pB8IML/h2fS6Wi5LPBU5KsCmb3PDle8cZZD2FgUsP6E2sZ7SXdtMpJ1AN2nMrZQpyL+p1E
 cOFSgPDGQMh5wfRWqV9SIHHHZSavYGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-wz7_qe4QMOqHHgi8ReMmdQ-1; Tue, 07 Apr 2020 08:13:24 -0400
X-MC-Unique: wz7_qe4QMOqHHgi8ReMmdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C8E107B7D5;
 Tue,  7 Apr 2020 12:13:23 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-253.ams2.redhat.com
 [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B9BB10021B3;
 Tue,  7 Apr 2020 12:13:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v3 3/3] block: Fix blk->in_flight during
 blk_wait_while_drained()
Date: Tue,  7 Apr 2020 14:12:59 +0200
Message-Id: <20200407121259.21350-4-kwolf@redhat.com>
In-Reply-To: <20200407121259.21350-1-kwolf@redhat.com>
References: <20200407121259.21350-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/block-backend.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 610dbfa0b2..38ae413826 100644
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
@@ -1418,12 +1423,6 @@ static void blk_aio_read_entry(void *opaque)
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
@@ -1436,12 +1435,6 @@ static void blk_aio_write_entry(void *opaque)
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



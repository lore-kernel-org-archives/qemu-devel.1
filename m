Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630C0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:47:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E4FC2078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 10:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFhdz3ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4FC2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKJrT-0007Nv-CA
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 06:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jKJoR-0003zH-5t
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jKJoQ-0006Tx-13
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:44:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34956
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jKJoP-0006TY-Tb
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 06:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585910673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hWJ3MgFYCUe9wil/UcV5TKzmCD6udz1cDHjGIDwnDVI=;
 b=iFhdz3oupyEHYZyhr24xksxpn5uM0jdR9CASKo9SAb/jQzSXD4n+uzzNp1nZ5lzfhQ7A2/
 4mx2fmqWpNhxV5Z51EmlvI8ASSbAt0tK8fOblM4LG7KCgQ0cvGxnspoucnGj3PY4yKTEC/
 QhKHn0PyXuvTBnKg/lJ+mGmZGQOlMrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-oTZH3IZaO9SXNHyz7cdoYA-1; Fri, 03 Apr 2020 06:44:32 -0400
X-MC-Unique: oTZH3IZaO9SXNHyz7cdoYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFF15800D5C;
 Fri,  3 Apr 2020 10:44:30 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-132.ams2.redhat.com
 [10.36.113.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06D6C8EA1A;
 Fri,  3 Apr 2020 10:44:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 2/2] block: Fix blk->in_flight during
 blk_wait_while_drained()
Date: Fri,  3 Apr 2020 12:44:15 +0200
Message-Id: <20200403104415.20963-3-kwolf@redhat.com>
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

Many callers of blk_wait_while_drained() have already increased
blk->in_flight when called in a blk_aio_*() path, but can also be called
in synchonous code paths where blk->in_flight isn't increased. This
means that these calls of blk_wait_while_drained() are wrong at least in
some cases.

In order to fix this, increase blk->in_flight even for synchronous
operations and temporarily decrease the counter again in
blk_wait_while_drained().

Fixes: cf3129323f900ef5ddbccbe86e4fa801e88c566e
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 3124e367b3..7bd16402b8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1143,7 +1143,9 @@ static int blk_check_byte_request(BlockBackend *blk, =
int64_t offset,
 static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
 {
     if (blk->quiesce_counter && !blk->disable_request_queuing) {
+        blk_dec_in_flight(blk);
         qemu_co_queue_wait(&blk->queued_requests, NULL);
+        blk_inc_in_flight(blk);
     }
 }
=20
@@ -1260,6 +1262,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset,=
 uint8_t *buf,
         .ret    =3D NOT_DONE,
     };
=20
+    blk_inc_in_flight(blk);
     if (qemu_in_coroutine()) {
         /* Fast-path if already in coroutine context */
         co_entry(&rwco);
@@ -1268,6 +1271,7 @@ static int blk_prw(BlockBackend *blk, int64_t offset,=
 uint8_t *buf,
         bdrv_coroutine_enter(blk_bs(blk), co);
         BDRV_POLL_WHILE(blk_bs(blk), rwco.ret =3D=3D NOT_DONE);
     }
+    blk_dec_in_flight(blk);
=20
     return rwco.ret;
 }
@@ -1386,9 +1390,7 @@ static void blk_aio_read_entry(void *opaque)
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
     if (rwco->blk->quiesce_counter) {
-        blk_dec_in_flight(rwco->blk);
         blk_wait_while_drained(rwco->blk);
-        blk_inc_in_flight(rwco->blk);
     }
=20
     assert(qiov->size =3D=3D acb->bytes);
@@ -1404,9 +1406,7 @@ static void blk_aio_write_entry(void *opaque)
     QEMUIOVector *qiov =3D rwco->iobuf;
=20
     if (rwco->blk->quiesce_counter) {
-        blk_dec_in_flight(rwco->blk);
         blk_wait_while_drained(rwco->blk);
-        blk_inc_in_flight(rwco->blk);
     }
=20
     assert(!qiov || qiov->size =3D=3D acb->bytes);
--=20
2.20.1



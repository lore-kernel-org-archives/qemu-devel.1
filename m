Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5CFC2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 873A6206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHf38Dji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873A6206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLk6x-0005EY-M5
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jLk4w-0003dC-TG
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jLk4t-0001fI-Qp
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:59:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32928
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jLk4t-0001ee-Hg
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586249966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5p4DdLRno1fJd2d90NCTV2OP/d2DxNC9HSgqxZJNWY=;
 b=DHf38DjioK0xJl2PsvHDIZSyzclpxxPf4V44cSSjtMXsh4l1vYlBKrv0H3VyNu4ys2ChEk
 kRgjcsYKl0J+lO8/f8hAoGcl4KLjFMnMErfFpMbTiwb6wpuvHVP/P2UwOs2+JTumtz402L
 rg9L72PBP6Yuu5uIa5iXE5uMNrcZguw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-nP9nBw1qM2C2oDi31dJfgQ-1; Tue, 07 Apr 2020 04:59:22 -0400
X-MC-Unique: nP9nBw1qM2C2oDi31dJfgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EADC107ACC4;
 Tue,  7 Apr 2020 08:59:21 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-253.ams2.redhat.com [10.36.113.253])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 73903277A5;
 Tue,  7 Apr 2020 08:59:16 +0000 (UTC)
Date: Tue, 7 Apr 2020 10:59:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH for-5.0 v2 3/3] block: Fix blk->in_flight during
 blk_wait_while_drained()
Message-ID: <20200407085915.GB7695@linux.fritz.box>
References: <20200406171403.6761-1-kwolf@redhat.com>
 <20200406171403.6761-4-kwolf@redhat.com>
 <3c8fd1b8-5138-b6eb-1e9d-55e03ad078c7@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <3c8fd1b8-5138-b6eb-1e9d-55e03ad078c7@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-block@nongnu.org, s.reiter@proxmox.com, qemu-devel@nongnu.org,
 dietmar@proxmox.com, stefanha@redhat.com, mreitz@redhat.com,
 t.lamprecht@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.04.2020 um 08:52 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 06.04.2020 20:14, Kevin Wolf wrote:
> > Waiting in blk_wait_while_drained() while blk->in_flight is increased
> > for the current request is wrong because it will cause the drain
> > operation to deadlock.
> >=20
> > This patch makes sure that blk_wait_while_drained() is called with
> > blk->in_flight increased exactly once for the current request, and that
> > it temporarily decreases the counter while it waits.
> >=20
> > Fixes: cf3129323f900ef5ddbccbe86e4fa801e88c566e
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/block-backend.c | 17 +++++------------
> >   1 file changed, 5 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/block/block-backend.c b/block/block-backend.c
> > index d330e08b05..f621435f0b 100644
> > --- a/block/block-backend.c
> > +++ b/block/block-backend.c
> > @@ -1140,10 +1140,15 @@ static int blk_check_byte_request(BlockBackend =
*blk, int64_t offset,
> >       return 0;
> >   }
> > +/* To be called between exactly one pair of blk_inc/dec_in_flight() */
> >   static void coroutine_fn blk_wait_while_drained(BlockBackend *blk)
> >   {
> > +    assert(blk->in_flight > 0);
>=20
> Hmm. You promise to make sure that in_flight increased exactly once.
> Shouldn't it be assert(blk->in_flight =3D=3D 1) ?

Exactly once for this specific request, but if you have multiple
requests in flight, blk->in_flight will be the sum of all requests.

Just asserting > 0 should still catch potential bugs because you won't
always have multiple requests in flight.

> > +
> >       if (blk->quiesce_counter && !blk->disable_request_queuing) {
> > +        blk_dec_in_flight(blk);
> >           qemu_co_queue_wait(&blk->queued_requests, NULL);
> > +        blk_inc_in_flight(blk);
> >       }
> >   }
> > @@ -1416,12 +1421,6 @@ static void blk_aio_read_entry(void *opaque)
> >       BlkRwCo *rwco =3D &acb->rwco;
> >       QEMUIOVector *qiov =3D rwco->iobuf;
> > -    if (rwco->blk->quiesce_counter) {
> > -        blk_dec_in_flight(rwco->blk);
> > -        blk_wait_while_drained(rwco->blk);
> > -        blk_inc_in_flight(rwco->blk);
> > -    }
>=20
> Hm, you drop it as it's called from blk_do_preadv too. I think it
> worth mentioning in commit message still.

Okay, I can add a sentence like "The blk_wait_while_drained() call in
blk_aio_read/write_entry is redundant with the one in blk_co_*(), so
drop it."

> > -
> >       assert(qiov->size =3D=3D acb->bytes);
> >       rwco->ret =3D blk_do_preadv(rwco->blk, rwco->offset, acb->bytes,
> >                                 qiov, rwco->flags);
> > @@ -1434,12 +1433,6 @@ static void blk_aio_write_entry(void *opaque)
> >       BlkRwCo *rwco =3D &acb->rwco;
> >       QEMUIOVector *qiov =3D rwco->iobuf;
> > -    if (rwco->blk->quiesce_counter) {
> > -        blk_dec_in_flight(rwco->blk);
> > -        blk_wait_while_drained(rwco->blk);
> > -        blk_inc_in_flight(rwco->blk);
> > -    }
> > -
> >       assert(!qiov || qiov->size =3D=3D acb->bytes);
> >       rwco->ret =3D blk_do_pwritev_part(rwco->blk, rwco->offset, acb->b=
ytes,
> >                                       qiov, 0, rwco->flags);
> >=20
>=20
> With assert(blk->in_flight =3D=3D 1) and mention extra wait removing in c=
ommit message:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Thanks, and I hope you agree with blk->in_flight > 0 now.

Kevin



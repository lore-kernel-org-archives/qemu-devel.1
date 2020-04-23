Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467F5C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:12:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE0B20728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RK51dUfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE0B20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jReSd-0008Hn-4s
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jReKu-0002PZ-Dl
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jReKt-0006Qu-M1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:04:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39473
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jReKr-0006NU-NZ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587657860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLTlEnx5/DSVvwLde3bS+7wSh6Ikh6JitmcNsZOWuB0=;
 b=RK51dUfL3+4zxOtT62aXDMFQYKcbAo9RyoE9S9CHdarRg/neS50BhJTFdQJ2wL1i797Ta6
 71yVdR+PyxHp2JOWwkVCiZoYTz6Z31n9MKl6ZY1MBJWnbK26EKmfPhy+l6fnXTM4x4qd8z
 V9Myc50vSkj0AVu3SH8purexmXAU4aY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-vzGqFz8dPha2ffQCdzxZqQ-1; Thu, 23 Apr 2020 12:04:14 -0400
X-MC-Unique: vzGqFz8dPha2ffQCdzxZqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF0EA180F10E;
 Thu, 23 Apr 2020 16:04:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81DC9196AE;
 Thu, 23 Apr 2020 16:04:11 +0000 (UTC)
Date: Thu, 23 Apr 2020 18:04:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6 10/10] qcow2: Forward ZERO_WRITE flag for full
 preallocation
Message-ID: <20200423160410.GF23654@linux.fritz.box>
References: <20200423150127.142609-1-kwolf@redhat.com>
 <20200423150127.142609-11-kwolf@redhat.com>
 <fca340c2-5bee-b287-e43e-28dc679ea372@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fca340c2-5bee-b287-e43e-28dc679ea372@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: vsementsov@virtuozzo.com, berto@igalia.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 23.04.2020 um 17:36 hat Eric Blake geschrieben:
> On 4/23/20 10:01 AM, Kevin Wolf wrote:
> > The BDRV_REQ_ZERO_WRITE is currently implemented in a way that first th=
e
> > image is possibly preallocated and then the zero flag is added to all
> > clusters. This means that a copy-on-write operation may be needed when
> > writing to these clusters, despite having used preallocation, negating
> > one of the major benefits of preallocation.
> >=20
> > Instead, try to forward the BDRV_REQ_ZERO_WRITE to the protocol driver,
> > and if the protocol driver can ensure that the new area reads as zeros,
> > we can skip setting the zero flag in the qcow2 layer.
>=20
> Hmm.  When we get block status, it is very easy to tell that something re=
ads
> as zero when the qcow2 file has the zero bit set, but when the qcow2 file
> does not have the zero bit set, we have to then query the format layer
> whether it reads as zeros (which is expensive enough for some format laye=
rs
> that we no longer report things as reading as zero). I'm worried that
> optimizing this case could penalize later block status.

That's just how preallocation works. If you don't want that, you need
preallocation=3Doff.

> We already can tell the difference between a cluster that has the zero bi=
t
> set but is not preallocated, vs. has the zero bit set and is preallocated=
.
> Are we really forcing a copy-on-write to a cluster that is marked zero bu=
t
> preallocated?  Is the problem that we don't have a way to distinguish
> between 'reads as zeroes, allocated, but we don't know state of format
> layer' and 'reads as zeroes, allocated, and we know format layer reads as
> zeroes'?

Basically, yes. If we had this, we could have a type of cluster where
writing to it still involves a metadata update (to clear the zero flag),
but never copy-on-write, even for partial writes.

I'm not sure if this would cover a very relevant case, though.

> >=20
> > Unfortunately, the same approach doesn't work for metadata
> > preallocation, so we'll still set the zero flag there.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   block/qcow2.c              | 22 +++++++++++++++++++---
> >   tests/qemu-iotests/274.out |  4 ++--
> >   2 files changed, 21 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/block/qcow2.c b/block/qcow2.c
> > index ad621fe404..b28e588942 100644
> > --- a/block/qcow2.c
> > +++ b/block/qcow2.c
> > @@ -4170,9 +4170,25 @@ static int coroutine_fn qcow2_co_truncate(BlockD=
riverState *bs, int64_t offset,
> >           /* Allocate the data area */
> >           new_file_size =3D allocation_start +
> >                           nb_new_data_clusters * s->cluster_size;
> > -        /* Image file grows, so @exact does not matter */
> > -        ret =3D bdrv_co_truncate(bs->file, new_file_size, false, preal=
loc, 0,
> > -                               errp);
> > +        /*
> > +         * Image file grows, so @exact does not matter.
> > +         *
> > +         * If we need to zero out the new area, try first whether the =
protocol
> > +         * driver can already take care of this.
> > +         */
> > +        if (flags & BDRV_REQ_ZERO_WRITE) {
> > +            ret =3D bdrv_co_truncate(bs->file, new_file_size, false, p=
realloc,
> > +                                   BDRV_REQ_ZERO_WRITE, errp);
> > +            if (ret >=3D 0) {
> > +                flags &=3D ~BDRV_REQ_ZERO_WRITE;
> > +            }
>=20
> Hmm - just noticing things: how does this series interplay with the exist=
ing
> bdrv_has_zero_init_truncate?  Should this series automatically handle
> BDRV_REQ_ZERO_WRITE on a bdrv_co_truncate(PREALLOC_NONE) request for all
> drivers that report true, even if that driver does not advertise support =
for
> the BDRV_REQ_ZERO_WRITE flag?

Hmm... It feels risky to me.

> > +        } else {
> > +            ret =3D -1;
> > +        }
>=20
> Here, ret =3D=3D -1 does not imply whether errp is set - but annoyingly, =
errp
> CAN be set if bdrv_co_truncate() failed.
>=20
> > +        if (ret < 0) {
> > +            ret =3D bdrv_co_truncate(bs->file, new_file_size, false, p=
realloc, 0,
> > +                                   errp);
>=20
> And here, you are passing a possibly-set errp back to bdrv_co_truncate().
> That is a bug that can abort.  You need to pass NULL to the first
> bdrv_co_truncate() call or else clear errp prior to trying a fallback to
> this second bdrv_co_truncate() call.

Yes, you're right. If nothing else comes up, I'll fix this while
applying.

Kevin



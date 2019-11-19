Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CD3C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9350C222A9
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGN73yGh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9350C222A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4Rd-0002vV-FU
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:25:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43147)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iX4OH-0007x4-UH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:22:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iX4OF-0000vk-Sz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:22:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31453
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iX4OE-0000vQ-Va
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574173318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oBCVzXQkBQ4qlkvIyNzrJbmEBURHev0QbyEO1PogGjo=;
 b=YGN73yGh7hI9TxN6xiC8qGjHsDkX59+LL4WmdZvOSqb7UZGbN28dfN44KX5axTFdtJQY8+
 /4MWQ8ngjvqN6LYlYknigEs9jNfDlF+wIlGY0lnwsGWFoobHwVz3Tp8RV1XlIOEc0gm9Z0
 QOsKkcIbBlyo6YNyFW/lfnZaqU4woO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-Vww2adqhPn-azQLgMpe_IQ-1; Tue, 19 Nov 2019 09:21:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0620E1011EDF;
 Tue, 19 Nov 2019 14:21:54 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-75.ams2.redhat.com [10.36.116.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6A2129360;
 Tue, 19 Nov 2019 14:21:49 +0000 (UTC)
Date: Tue, 19 Nov 2019 15:21:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 0/4] fix & merge block_status_above and is_allocated_above
Message-ID: <20191119142148.GE5910@linux.fritz.box>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <20191119120552.GB5910@linux.fritz.box>
 <3b5a71bd-b247-fabe-824a-f0cde32deb13@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <3b5a71bd-b247-fabe-824a-f0cde32deb13@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: Vww2adqhPn-azQLgMpe_IQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 19.11.2019 um 13:17 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 19.11.2019 15:05, Kevin Wolf wrote:
> > Am 16.11.2019 um 17:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> Hi all!
> >>
> >> I wanted to understand, what is the real difference between
> >> bdrv_block_status_above and bdrv_is_allocated_above, IMHO
> >> bdrv_is_allocated_above should work through bdrv_block_status_above..
> >>
> >> And I found the problem: bdrv_is_allocated_above considers space after
> >> EOF as UNALLOCATED for intermediate nodes..
> >>
> >> UNALLOCATED is not about allocation at fs level, but about should we
> >> go to backing or not.. And it seems incorrect for me, as in case of
> >> short backing file, we'll read zeroes after EOF, instead of going
> >> further by backing chain.
> >=20
> > We actually have documentation what it means:
> >=20
> >   * BDRV_BLOCK_ALLOCATED: the content of the block is determined by thi=
s
> >   *                       layer rather than any backing, set by block l=
ayer
> >=20
> > Say we have a short overlay, like this:
> >=20
> > base.qcow2:     AAAAAAAA
> > overlay.qcow2:  BBBB
> >=20
> > Then of course the content of block 5 (the one after EOF of
> > overlay.qcow2) is still determined by overlay.qcow2, which can be easil=
y
> > verified by reading it from overlay.qcow2 (produces zeros) and from
> > base.qcow2 (produces As).
> >=20
> > So the correct result when querying the block status of block 5 on
> > overlay.qcow2 is BDRV_BLOCK_ALLOCATED | BDRV_BLOCK_ZERO.

Do you agree with this assessment?

> > Interestingly, we already fixed the opposite case (large overlay over
> > short backing file) in commit e88ae2264d9 from May 2014 according to th=
e
> > same logic.
> >=20
> >> This leads to the following effect:
> >>
> >> ./qemu-img create -f qcow2 base.qcow2 2M
> >> ./qemu-io -c "write -P 0x1 0 2M" base.qcow2
> >>
> >> ./qemu-img create -f qcow2 -b base.qcow2 mid.qcow2 1M
> >> ./qemu-img create -f qcow2 -b mid.qcow2 top.qcow2 2M
> >>
> >> Region 1M..2M is shadowed by short middle image, so guest sees zeroes:
> >> ./qemu-io -c "read -P 0 1M 1M" top.qcow2
> >> read 1048576/1048576 bytes at offset 1048576
> >> 1 MiB, 1 ops; 00.00 sec (22.795 GiB/sec and 23341.5807 ops/sec)
> >>
> >> But after commit guest visible state is changed, which seems wrong for=
 me:
> >> ./qemu-img commit top.qcow2 -b mid.qcow2
> >>
> >> ./qemu-io -c "read -P 0 1M 1M" mid.qcow2
> >> Pattern verification failed at offset 1048576, 1048576 bytes
> >> read 1048576/1048576 bytes at offset 1048576
> >> 1 MiB, 1 ops; 00.00 sec (4.981 GiB/sec and 5100.4794 ops/sec)
> >>
> >> ./qemu-io -c "read -P 1 1M 1M" mid.qcow2
> >> read 1048576/1048576 bytes at offset 1048576
> >> 1 MiB, 1 ops; 00.00 sec (3.365 GiB/sec and 3446.1606 ops/sec)
> >>
> >>
> >> I don't know, is it a real bug, as I don't know, do we support backing
> >> file larger than its parent. Still, I'm not sure that this behavior of
> >> bdrv_is_allocated_above don't lead to other problems.
> >=20
> > I agree it's a bug.
> >=20
> > Your fix doesn't look right to me, though. You leave the buggy behaviou=
r
> > of bdrv_co_block_status() as it is and then add four patches to work
> > around it in some (but not all) callers of it.
> >=20
> > All that it should take to fix this is making the bs->backing check
> > independent from want_zero and let it set ALLOCATED. What I expected
> > would be something like the below patch.
> >=20
> > But it doesn't seem to fully fix the problem (though 'alloc 1M 1M' in
> > qemu-io shows that the range is now considered allocated), so probably
> > there is still a separate bug in bdrv_is_allocated_above().
> >=20
> > And I think we'll want an iotests case for both cases (short overlay,
> > short backing file).
> >=20
> > Kevin
> >=20
> >=20
> > diff --git a/block/io.c b/block/io.c
> > index f75777f5ea..5eafcff01a 100644
> > --- a/block/io.c
> > +++ b/block/io.c
> > @@ -2359,16 +2359,17 @@ static int coroutine_fn bdrv_co_block_status(Bl=
ockDriverState *bs,
> >  =20
> >       if (ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ZERO)) {
> >           ret |=3D BDRV_BLOCK_ALLOCATED;
> > -    } else if (want_zero) {
> > -        if (bdrv_unallocated_blocks_are_zero(bs)) {
> > -            ret |=3D BDRV_BLOCK_ZERO;
> > -        } else if (bs->backing) {
> > -            BlockDriverState *bs2 =3D bs->backing->bs;
> > -            int64_t size2 =3D bdrv_getlength(bs2);
> > -
> > -            if (size2 >=3D 0 && offset >=3D size2) {
> > +    } else if (want_zero && bdrv_unallocated_blocks_are_zero(bs)) {
> > +        ret |=3D BDRV_BLOCK_ZERO;
> > +    } else if (bs->backing) {
> > +        BlockDriverState *bs2 =3D bs->backing->bs;
> > +        int64_t size2 =3D bdrv_getlength(bs2);
> > +
> > +        if (size2 >=3D 0 && offset >=3D size2) {
> > +            if (want_zero) {
> >                   ret |=3D BDRV_BLOCK_ZERO;
> >               }
> > +            ret |=3D BDRV_BLOCK_ALLOCATED;
>=20
> No, I think it's wrong, as it's not allocated at bs, but at
> bs->backing->bs.

This code implements the logic that I explained above. In my example,
the zeros are produced by overlay.qcow2 (because we're reading after its
EOF), not by base.qcow2.

If it were allocated at base.qcow2, you wouldn't read zeros, but the
data from (the longer) base.qcow2.

The code I posted isn't quite correct yet, but I think that the core of
the problem is already present in bdrv_co_block_status() and not only in
its callers.

Kevin



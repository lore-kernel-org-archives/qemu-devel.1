Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7674CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:23:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FB3206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 14:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JpkFWJSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FB3206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZbkB-00065E-BL
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 09:23:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48663)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZbhx-0004ki-At
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZbhw-0001cC-5S
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:20:49 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49728
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZbhw-0001bu-1L
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 09:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574778047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyUVgxomDK1RSNDqnJdK15zFsxxzTnnQmFqskzxkhcM=;
 b=JpkFWJSgaAe5izjhWGxpjSF4KkbyrWAwJ8hLAd6+VQ1Xz4wi4Y6y0JuTVMVlZoCTM5A3ag
 mQdT9SpvPCjupAgOQDW+jUpkM4AHDF2WCNseJThj4Llv0YHxM1DI9o9R/dc68CCcHUH/EG
 q+UmD+jYdXSndeAeeb1Vyz9JULuwAdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-mEvjoJXCOcaTjSbPswmN5w-1; Tue, 26 Nov 2019 09:20:46 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5C46100E36F;
 Tue, 26 Nov 2019 14:20:44 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-171.ams2.redhat.com [10.36.117.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 681D25C219;
 Tue, 26 Nov 2019 14:20:38 +0000 (UTC)
Date: Tue, 26 Nov 2019 15:20:36 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 1/4] block/io: fix bdrv_co_block_status_above
Message-ID: <20191126142036.GA5889@linux.fritz.box>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <20191116163410.12129-2-vsementsov@virtuozzo.com>
 <20191125160037.GD4638@linux.fritz.box>
 <91f61957-33ec-ea91-d0c4-f555199c4d69@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <91f61957-33ec-ea91-d0c4-f555199c4d69@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: mEvjoJXCOcaTjSbPswmN5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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

Am 26.11.2019 um 08:26 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 25.11.2019 19:00, Kevin Wolf wrote:
> > Am 16.11.2019 um 17:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> bdrv_co_block_status_above has several problems with handling short
> >> backing files:
> >>
> >> 1. With want_zeros=3Dtrue, it may return ret with BDRV_BLOCK_ZERO but
> >> without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
> >> which produces these after-EOF zeros is inside requested backing
> >> sequesnce.
> >=20
> > s/sequesnce/sequence/
> >=20
> >>
> >> 2. With want_zeros=3Dfalse, it will just stop inside requested region,=
 if
> >> we have unallocated region in top node when underlying backing is
> >> short.
> >=20
> > I honestly don't understand this one. Can you rephrase/explain in more
> > detail what you mean by "stop inside [the] requested region"?
>=20
> Hmm, yes, bad description. I mean, it may return pnum=3D0 prior to actual=
 EOF,
> because of EOF of short backing file.

Ah, yes, that's true. Definitely mention pnum=3D0 in the comment, this
explanation is much clearer.

> >> Fix these things, making logic about short backing files clearer.
> >>
> >> Note that 154 output changed, because now bdrv_block_status_above don'=
t
> >> merge unallocated zeros with zeros after EOF (which are actually
> >> "allocated" in POV of read from backing-chain top) and is_zero() just
> >> don't understand that the whole head or tail is zero. We may update
> >> is_zero to call bdrv_block_status_above several times, or add flag to
> >> bdrv_block_status_above that we are not interested in ALLOCATED flag,
> >> so ranges with different ALLOCATED status may be merged, but actually,
> >> it seems that we'd better don't care about this corner case.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>   block/io.c                 | 41 ++++++++++++++++++++++++++++--------=
--
> >>   tests/qemu-iotests/154.out |  4 ++--
> >>   2 files changed, 32 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/block/io.c b/block/io.c
> >> index f75777f5ea..4d7fa99bd2 100644
> >> --- a/block/io.c
> >> +++ b/block/io.c
> >> @@ -2434,25 +2434,44 @@ static int coroutine_fn bdrv_co_block_status_a=
bove(BlockDriverState *bs,
> >>           ret =3D bdrv_co_block_status(p, want_zero, offset, bytes, pn=
um, map,
> >>                                      file);
> >>           if (ret < 0) {
> >> -            break;
> >> +            return ret;
> >>           }
> >> -        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) =
{
> >> +        if (*pnum =3D=3D 0) {
> >> +            if (first) {
> >> +                return ret;
> >> +            }
> >> +
> >>               /*
> >> -             * Reading beyond the end of the file continues to read
> >> -             * zeroes, but we can only widen the result to the
> >> -             * unallocated length we learned from an earlier
> >> -             * iteration.
> >> +             * Reads from bs for selected region will return zeroes, =
produced
> >> +             * because current level is short. We should consider it =
as
> >> +             * allocated.
> >=20
> > "the selected region"
> > "the current level"
> >=20
> >> +             * TODO: Should we report p as file here?
> >=20
> > I think that would make sense.
> >=20
> >>                */
> >> +            assert(ret & BDRV_BLOCK_EOF);
> >=20
> > Can this assertion be moved above the if (first)?
>=20
> it may correspond to requested bytes=3D=3D0.. But we can check it separat=
ely
> before for loop and move this assertion.

Ah, right. Don't bother then, it's fine either way.

Kevin



Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A3EC35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE3C20674
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 18:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O/Kyf/C3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE3C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izPbw-0004vF-CG
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 13:41:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1izPat-0004F5-9a
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1izPam-000418-IJ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:40:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1izPam-0003xy-Cx
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 13:40:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580928003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PlBHQEQM6iGiZnUycHNjOEdSJWrrwMrfoWpo991HGQA=;
 b=O/Kyf/C3rMGeVxWE8yEp1Ejp2mi5Sd/DEifPVnBWmKh3oLiWg7/rtNY1pQfz3+QuQW5ley
 SCshrFgSK/iqGbcgVWzpwFxTQIa51Urk30Mjw3fmMz6PurBB6tuVHTdGCbHXNmohgTNh/9
 YZtf+nQQUOLRhBaAtZWq3RXyROjE90E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-GaujpXgNMwWgKa_P2gJxwg-1; Wed, 05 Feb 2020 13:39:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 241D71B2C980;
 Wed,  5 Feb 2020 18:39:58 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1BBDF5C1B5;
 Wed,  5 Feb 2020 18:39:49 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <a857dce1-ef71-d62b-016e-ff9486af361b@redhat.com>
 <ab03b053-5caa-7316-25ed-d6103889d06e@redhat.com>
 <6b081138-5ee5-f5d6-352d-ec2deff0de73@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <c42781eb-9215-e9c0-2769-5108951ad8ca@redhat.com>
Date: Wed, 5 Feb 2020 12:39:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6b081138-5ee5-f5d6-352d-ec2deff0de73@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: GaujpXgNMwWgKa_P2gJxwg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, david.edmondson@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 "Denis V. Lunev" <den@openvz.org>, Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 11:22 AM, Max Reitz wrote:

>=20
>>> And thus callers which just want the trivially obtainable
>>> BDRV_ZERO_TRUNCATE info have to wait for the BDRV_ZERO_OPEN inquiry,
>>> even though they don=E2=80=99t care about that flag.
>>
>> True, but only to a minor extent; and the documentation mentions that
>> the BDRV_ZERO_OPEN calculation MUST NOT be as expensive as a blind
>> block_status loop.
>=20
> So it must be less expensive than an arbitrarily complex loop.  I think
> a single SEEK_DATA/HOLE call was something like O(n) on tmpfs?

If I recall, the tmpfs bug was that it was O(n) where n was based on the=20
initial offset and the number of extents prior to that offset.  The=20
probe at offset 0 is O(1) (because there are no prior extents), whether=20
it reaches the end of the file (the entire image is a hole) or hits data=20
beforehand.  It is only probes at later offsets where the speed penalty=20
sets in, and where an O(n) loop over all extents turned into an O(n^2)=20
traversal time due to the O(n) nature of each later lookup.

>=20
> What I=E2=80=99m trying to say is that this is not a good limit and can m=
ean
> anything.
>=20
> I do think this limit definition makes sense for callers that want to
> know about ZERO_OPEN.  But I don=E2=80=99t know why we would have to let =
other
> callers wait, too.

Keeping separate functions may still be the right approach for v2,=20
although I'd still like to name things better ('has_zero_init' vs.=20
'has_zero_init_truncate' did not work well for me).  And if I'm renaming=20
things, then I'm touching just as much code whether I rename and keep=20
separate functions or rename and consolidate into one.

>=20
>> Meanwhile, callers tend to only care about
>> bdrv_known_zeroes() right after opening an image or right before
>> resizing (not repeatedly during runtime);
>=20
> Hm, yes.  I was thinking of parallels, but that only checks once in
> parallels_open(), so it=E2=80=99s OK.
>=20
>> and you also argued elsewhere
>> in this thread that it may be worth having the block layer cache
>> BDRV_ZERO_OPEN and update the cache on any write,
>=20
> I didn=E2=80=99t say the block layer, but it if makes sense.
>=20
>> at which point, the
>> expense in the driver callback really is a one-time call during
>> bdrv_co_open().
>=20
> It definitely doesn=E2=80=99t make sense to me to do that call unconditio=
nally
> in bdrv_co_open().

Okay, you have a point there - while 'qemu-img convert' cares, not all=20
clients of bdrv_co_open() are worried about whether the existing=20
contents are zero; so unconditionally priming a cache during=20
bdrv_co_open is not as wise as doing things when it will actually be=20
useful information.  On the other hand, if it is something that clients=20
only use when first opening an image, caching data doesn't make much=20
sense either.

So, we know that bdrv_has_zero_init() is only viable on a just-created=20
image, bdrv_has_zero_init_truncate() is only viable if you are about to=20
resize an image using bdrv_co_truncate(PREALLOC_MODE_OFF).

Hmm - thinking aloud: our ultimate goal is that we want to make it=20
easier for algorithms that can be sped up IF the image is currently=20
known to be all zero.  Maybe what this means is that we really want to=20
be tweaking bdrv_make_zeroes() to do all the work, something along the=20
lines of:
- if the image is known to already be all zeroes using an O(1) probe=20
(this includes if the image was freshly created and creation sees all=20
zeroes, or if a block_status at offset 0 shows a hole for the entire=20
image, or if an NBD extension advertises all zero at connection=20
time...), return success
- if the image has a FAST truncate, and resizing reads zeroes, we can=20
truncate to size 0 and back to the desired size, then return success;=20
determining if truncate is fast should be similar to how=20
BDRV_REQ_NO_FALLBACK determines whether write zeroes is fast
- if the image supports BDRV_REQ_NO_FALLBACK with write zeroes, we can=20
request a write zeroes over the whole image, which will either succeed=20
(the image is now quickly zero) or fail (writing zeroes as we go is the=20
best we can do)
- if the image could report that it is all zeroes, but only at the cost=20
of O(n) work such as a loop over block_status (or even O(n^2) with the=20
tmpfs lseek bug), it's easier to report failure than to worry about=20
making the image read all zeroes

qemu-img would then only ever need to consult --target-is-zero and=20
bdrv_make_zero(), and not worry about any other function calls; while=20
the block layer would take care of coordinating whatever other call=20
sequences make the most sense in reporting success or failure in getting=20
the image into an all-zero state if it was not already there.


>=20
>> And in that case, whether the one-time expense is done
>> via a single function call or via three driver callbacks, the amount of
>> work is the same; but the driver callback interface is easier if there
>> is only one callback (similar to how bdrv_unallocated_blocks_are_zero()
>> calls bdrv_get_info() only for bdi.unallocated_blocks_are_zero, even
>> though BlockDriverInfo tracks much more than that boolean).
>>
>> In fact, it may be worth consolidating known zeroes support into
>> BlockDriverInfo.
>=20
> I=E2=80=99m very skeptical of that.  BDI already has the problem that it =
doesn=E2=80=99t
> know which of the information the caller actually wants and that it is
> sometimes used in a quasi-hot path.
>=20
> Maybe that means it is indeed time to incorporate it into BDI, but the
> caller should have a way of specifying what parts of BDI it actually
> needs and then drivers can skip anything that isn=E2=80=99t trivially obt=
ainable
> that the caller doesn=E2=80=99t need.

I'm reminded of the recent kernel addition of xstat(); the traditional=20
stat/fstat interfaces really don't know which bits of information you=20
care about, so you get everything, but with xstat(), you can request=20
only what you plan to use, which may indeed result in speedups.


>> Those are still viable options, but before I repaint the bikeshed along
>> those lines, I'd at least like a review of whether the overall idea of
>> having a notion of 'reads-all-zeroes' is indeed useful enough,
>> regardless of how we implement it as one vs. three driver callbacks.
>=20
> I=E2=80=99m as hesitant as ever to give a review that this notion is usef=
ul,
> because I haven=E2=80=99t seen a practical example yet where the problem =
isn=E2=80=99t
> the fact that NBD doesn=E2=80=99t have 64-bit write_zeroes support.

Even if the NBD protocol gains 64-bit write_zeroes, not all NBD servers=20
will be compliant with that extension.  This will speed up operations=20
when talking to older servers which do not support 64-bit writes, even=20
if newer qemu is never such a server.

>=20
> So far, it looks to me like this notion is only really useful for cases
> where we expect a management layer on top of qemu anyway.  And then I=E2=
=80=99m
> not sure that this new feature works reliably enough for such a
> management layer.
>=20
> (I=E2=80=99m not saying it isn=E2=80=99t useful.  Again, intuitively it d=
oes seem
> useful.  Intuition can be enough to merge a sufficiently simple series
> that doesn=E2=80=99t increase code complexity too much.  But I=E2=80=99m =
still asking
> for actual practical examples, because that would make a better
> argument, of course.)

I'm hoping when I post my NBD patches that I can also provide some=20
benchmark timing numbers to make the case a bit more concrete.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org



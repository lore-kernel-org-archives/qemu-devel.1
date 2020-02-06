Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14350C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0072206CC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 09:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTIDmPPn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0072206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izdK4-00084W-Vc
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 04:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izdJJ-0007bw-Ra
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:18:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izdJH-0004JY-Uf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:18:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42732
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izdJH-0004Dd-Od
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 04:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580980734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mkHQ+hjsw5hsz+kbkdzs6HIqrTsqOqtlWEl0Cvdda4k=;
 b=PTIDmPPn0aU+WH3/YxFmTqboVzx6drlu1TTbtohFqaVu8jTPTfFTWSPwATPOGQlXJWxEck
 Rn6M/spp9OYnsB22gE7KAvgIOZOlhhRoAoA1Mr+dRDAt9xiX8eVlTtZbE7y1YDW5bLaPiT
 VCoq4/H7HJx01Sa9kHN/W041UfcUpN4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-mdF8F7O5OySJzZ3OHJ5DPw-1; Thu, 06 Feb 2020 04:18:50 -0500
X-MC-Unique: mdF8F7O5OySJzZ3OHJ5DPw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B587B8018B0;
 Thu,  6 Feb 2020 09:18:48 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B145C1B2;
 Thu,  6 Feb 2020 09:18:39 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <a857dce1-ef71-d62b-016e-ff9486af361b@redhat.com>
 <ab03b053-5caa-7316-25ed-d6103889d06e@redhat.com>
 <6b081138-5ee5-f5d6-352d-ec2deff0de73@redhat.com>
 <c42781eb-9215-e9c0-2769-5108951ad8ca@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <e2ee50cd-2e60-7b06-6dcc-adfa9dc15163@redhat.com>
Date: Thu, 6 Feb 2020 10:18:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c42781eb-9215-e9c0-2769-5108951ad8ca@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p81MTbjsNC1d4QkVXgrjyPbxoowkBUwiF"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p81MTbjsNC1d4QkVXgrjyPbxoowkBUwiF
Content-Type: multipart/mixed; boundary="HLCFyvALyCgmB1Hkq184X0jCr92iB3XXY"

--HLCFyvALyCgmB1Hkq184X0jCr92iB3XXY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 19:39, Eric Blake wrote:
> On 2/5/20 11:22 AM, Max Reitz wrote:
>=20
>>
>>>> And thus callers which just want the trivially obtainable
>>>> BDRV_ZERO_TRUNCATE info have to wait for the BDRV_ZERO_OPEN inquiry,
>>>> even though they don=E2=80=99t care about that flag.
>>>
>>> True, but only to a minor extent; and the documentation mentions that
>>> the BDRV_ZERO_OPEN calculation MUST NOT be as expensive as a blind
>>> block_status loop.
>>
>> So it must be less expensive than an arbitrarily complex loop.=C2=A0 I t=
hink
>> a single SEEK_DATA/HOLE call was something like O(n) on tmpfs?
>=20
> If I recall, the tmpfs bug was that it was O(n) where n was based on the
> initial offset and the number of extents prior to that offset.=C2=A0 The
> probe at offset 0 is O(1) (because there are no prior extents), whether
> it reaches the end of the file (the entire image is a hole) or hits data
> beforehand.=C2=A0 It is only probes at later offsets where the speed pena=
lty
> sets in, and where an O(n) loop over all extents turned into an O(n^2)
> traversal time due to the O(n) nature of each later lookup.

So it=E2=80=99s O(n/2) for each lookup on average, which is O(n). O:-)

>> What I=E2=80=99m trying to say is that this is not a good limit and can =
mean
>> anything.
>>
>> I do think this limit definition makes sense for callers that want to
>> know about ZERO_OPEN.=C2=A0 But I don=E2=80=99t know why we would have t=
o let other
>> callers wait, too.
>=20
> Keeping separate functions may still be the right approach for v2,
> although I'd still like to name things better ('has_zero_init' vs.
> 'has_zero_init_truncate' did not work well for me).=C2=A0 And if I'm rena=
ming
> things, then I'm touching just as much code whether I rename and keep
> separate functions or rename and consolidate into one.

I definitely don=E2=80=99t disagree about renaming, and if you think that
consolidating the functions is worth it, then it probably makes sense
(because you have the experience there, given this series).

But I=E2=80=99d still like to throw in that a rename is a more easily doabl=
e and
reviewable change than a consolidation, even if you get the same number
of hunks in the end.

>>> Meanwhile, callers tend to only care about
>>> bdrv_known_zeroes() right after opening an image or right before
>>> resizing (not repeatedly during runtime);
>>
>> Hm, yes.=C2=A0 I was thinking of parallels, but that only checks once in
>> parallels_open(), so it=E2=80=99s OK.
>>
>>> and you also argued elsewhere
>>> in this thread that it may be worth having the block layer cache
>>> BDRV_ZERO_OPEN and update the cache on any write,
>>
>> I didn=E2=80=99t say the block layer, but it if makes sense.
>>
>>> at which point, the
>>> expense in the driver callback really is a one-time call during
>>> bdrv_co_open().
>>
>> It definitely doesn=E2=80=99t make sense to me to do that call unconditi=
onally
>> in bdrv_co_open().
>=20
> Okay, you have a point there - while 'qemu-img convert' cares, not all
> clients of bdrv_co_open() are worried about whether the existing
> contents are zero; so unconditionally priming a cache during
> bdrv_co_open is not as wise as doing things when it will actually be
> useful information.=C2=A0 On the other hand, if it is something that clie=
nts
> only use when first opening an image, caching data doesn't make much
> sense either.
>=20
> So, we know that bdrv_has_zero_init() is only viable on a just-created
> image, bdrv_has_zero_init_truncate() is only viable if you are about to
> resize an image using bdrv_co_truncate(PREALLOC_MODE_OFF).
>=20
> Hmm - thinking aloud: our ultimate goal is that we want to make it
> easier for algorithms that can be sped up IF the image is currently
> known to be all zero.=C2=A0 Maybe what this means is that we really want =
to
> be tweaking bdrv_make_zeroes() to do all the work, something along the
> lines of:
> - if the image is known to already be all zeroes using an O(1) probe
> (this includes if the image was freshly created and creation sees all
> zeroes, or if a block_status at offset 0 shows a hole for the entire
> image, or if an NBD extension advertises all zero at connection
> time...), return success

[Insert case here: If the image has a custom make_zeroes implementation,
use it, and return success]

> - if the image has a FAST truncate, and resizing reads zeroes, we can
> truncate to size 0 and back to the desired size, then return success;
> determining if truncate is fast should be similar to how
> BDRV_REQ_NO_FALLBACK determines whether write zeroes is fast
> - if the image supports BDRV_REQ_NO_FALLBACK with write zeroes, we can
> request a write zeroes over the whole image, which will either succeed
> (the image is now quickly zero) or fail (writing zeroes as we go is the
> best we can do)
> - if the image could report that it is all zeroes, but only at the cost
> of O(n) work such as a loop over block_status (or even O(n^2) with the
> tmpfs lseek bug), it's easier to report failure than to worry about
> making the image read all zeroes
>=20
> qemu-img would then only ever need to consult --target-is-zero and
> bdrv_make_zero(), and not worry about any other function calls; while
> the block layer would take care of coordinating whatever other call
> sequences make the most sense in reporting success or failure in getting
> the image into an all-zero state if it was not already there.

(As I just wrote on the cover letter thread:) Sounds good to me.

>>> And in that case, whether the one-time expense is done
>>> via a single function call or via three driver callbacks, the amount of
>>> work is the same; but the driver callback interface is easier if there
>>> is only one callback (similar to how bdrv_unallocated_blocks_are_zero()
>>> calls bdrv_get_info() only for bdi.unallocated_blocks_are_zero, even
>>> though BlockDriverInfo tracks much more than that boolean).
>>>
>>> In fact, it may be worth consolidating known zeroes support into
>>> BlockDriverInfo.
>>
>> I=E2=80=99m very skeptical of that.=C2=A0 BDI already has the problem th=
at it doesn=E2=80=99t
>> know which of the information the caller actually wants and that it is
>> sometimes used in a quasi-hot path.
>>
>> Maybe that means it is indeed time to incorporate it into BDI, but the
>> caller should have a way of specifying what parts of BDI it actually
>> needs and then drivers can skip anything that isn=E2=80=99t trivially ob=
tainable
>> that the caller doesn=E2=80=99t need.
>=20
> I'm reminded of the recent kernel addition of xstat(); the traditional
> stat/fstat interfaces really don't know which bits of information you
> care about, so you get everything, but with xstat(), you can request
> only what you plan to use, which may indeed result in speedups.

I hope we can put off thinking about it if the known-zeroes check can
simply be put into make_zero(). O:-)

>>> Those are still viable options, but before I repaint the bikeshed along
>>> those lines, I'd at least like a review of whether the overall idea of
>>> having a notion of 'reads-all-zeroes' is indeed useful enough,
>>> regardless of how we implement it as one vs. three driver callbacks.
>>
>> I=E2=80=99m as hesitant as ever to give a review that this notion is use=
ful,
>> because I haven=E2=80=99t seen a practical example yet where the problem=
 isn=E2=80=99t
>> the fact that NBD doesn=E2=80=99t have 64-bit write_zeroes support.
>=20
> Even if the NBD protocol gains 64-bit write_zeroes, not all NBD servers
> will be compliant with that extension.=C2=A0 This will speed up operation=
s
> when talking to older servers which do not support 64-bit writes, even
> if newer qemu is never such a server.

The same applies to reads-all-zeroes, though.  Only if both server and
client provide/understand this flag will it do something.

Max


--HLCFyvALyCgmB1Hkq184X0jCr92iB3XXY--

--p81MTbjsNC1d4QkVXgrjyPbxoowkBUwiF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl472e4ACgkQ9AfbAGHV
z0Bjqwf5ATa8QMJOyKZhzciBc2den0Tm3RmaDJcL0JtM6+7WJqFM3YbXQkpdBinP
dB28qvPwZ+gdJ2Vn2yq0RAFXfddgFni30Opfa+o/PurYvrZfKbRFe4Sad9c5v1BP
Zo0BvEJCpehSEHSKXWfCCMUHDlRru1SIkWoDLDLIITwJ5Bp1B2ddJYyzJUmWLCxq
K+3dA3F7qUpDXBbhcoIaicgLIs3pJANHTyRVAmrcUaSDTrte773B5A378szX9U/X
5S4zQA+0PXSABPT9w/tF0UqdnAXtmpfKhMTtnuOcxLz4QyMG0rng4V2KK564jmpV
/FUhwVQNLoWNyAD1cbwRuy69fg/hlA==
=Iegw
-----END PGP SIGNATURE-----

--p81MTbjsNC1d4QkVXgrjyPbxoowkBUwiF--



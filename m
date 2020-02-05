Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBED0C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7C3120659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmZhY1A6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C3120659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izOSn-0007t3-RS
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izONx-00087o-1m
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izONv-0006uk-CE
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:22:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55611
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izONv-0006t3-8B
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580923362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=E2/KHHXLM65LNX8XTivLlZcJ88qx4yKZA9+WY5Qu8Rc=;
 b=dmZhY1A6fAO+p3oINkAG8eiCFg+bDO8toSdyC4Gj8eI1tQzwdNHEoLVAd+GuTU0I2iD9l/
 7sVQpebuXTACusXgpp+vhovbdoX/9WCCRJXWIEGf2Xd1m/W8mjYJdT0XsFvkkWKS3FYNDw
 qVg/zXrvrJSCmAVvIA6LlUWclSppDkc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-kn3jzlxBNWWCOGT7rr9MzA-1; Wed, 05 Feb 2020 12:22:37 -0500
X-MC-Unique: kn3jzlxBNWWCOGT7rr9MzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FC308010C4;
 Wed,  5 Feb 2020 17:22:35 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-184.ams2.redhat.com
 [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC76B1C94B;
 Wed,  5 Feb 2020 17:22:25 +0000 (UTC)
Subject: Re: [PATCH 09/17] block: Refactor bdrv_has_zero_init{,_truncate}
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-10-eblake@redhat.com>
 <a857dce1-ef71-d62b-016e-ff9486af361b@redhat.com>
 <ab03b053-5caa-7316-25ed-d6103889d06e@redhat.com>
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
Message-ID: <6b081138-5ee5-f5d6-352d-ec2deff0de73@redhat.com>
Date: Wed, 5 Feb 2020 18:22:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ab03b053-5caa-7316-25ed-d6103889d06e@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QmSuvCfqJGT30JUmf36qMLZS2ihWLGrHe"
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
--QmSuvCfqJGT30JUmf36qMLZS2ihWLGrHe
Content-Type: multipart/mixed; boundary="B11gEeyxXHx7HsOe7g4REGq2lCWI5hRoJ"

--B11gEeyxXHx7HsOe7g4REGq2lCWI5hRoJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.02.20 20:03, Eric Blake wrote:
> On 2/4/20 11:53 AM, Max Reitz wrote:
>> On 31.01.20 18:44, Eric Blake wrote:
>>> Having two slightly-different function names for related purposes is
>>> unwieldy, especially since I envision adding yet another notion of
>>> zero support in an upcoming patch.=C2=A0 It doesn't help that
>>> bdrv_has_zero_init() is a misleading name (I originally thought that a
>>> driver could only return 1 when opening an already-existing image
>>> known to be all zeroes; but in reality many drivers always return 1
>>> because it only applies to a just-created image).
>>
>> I don=E2=80=99t find it misleading, I just find it meaningless, which th=
en makes
>> it open to interpretation (or maybe rather s/interpretation/wishful
>> thinking/).
>>
>>> Refactor all uses
>>> to instead have a single function that returns multiple bits of
>>> information, with better naming and documentation.
>>
>> It doesn=E2=80=99t make sense to me.=C2=A0 How exactly is it unwieldy?=
=C2=A0 In the sense
>> that we have to deal with multiple rather small implementation functions
>> rather than a big one per driver?=C2=A0 Actually, multiple small functio=
ns
>> sounds better to me =E2=80=93 unless the three implementations share com=
mon code.
>=20
> Common code for dealing with encryption, backing files, and so on.=C2=A0 =
It
> felt like I had a lot of code repetition when keeping functions separate.

Well, I suppose =E2=80=9Cdealing with=E2=80=9D means =E2=80=9Cif (encrypted=
 || has_backing)=E2=80=9D, so
duplicating that doesn=E2=80=99t seem too bad.

>> As for the callers, they only want a single flag out of the three, don=
=E2=80=99t
>> they?=C2=A0 If so, it doesn=E2=80=99t really matter for them.
>=20
> The qemu-img.c caller in patch 10 checks ZERO_CREATE | ZERO_OPEN, so we
> DO have situations of checking more than one bit, vs. needing two
> function calls.

Hm, OK.  Not sure if that place would look worse with two function
calls, but, well.

>> In fact, I can imagine that drivers can trivially return
>> BDRV_ZERO_TRUNCATE information (because the preallocation mode is
>> fixed), whereas BDRV_ZERO_CREATE can be a bit more involved, and
>> BDRV_ZERO_OPEN could take even more time because some (constant-time)
>> inquiries have to be done.
>=20
> In looking at the rest of the series, drivers were either completely
> trivial (in which case, declaring:
>=20
> .bdrv_has_zero_init =3D bdrv_has_zero_init_1,
> .bdrv_has_zero_init_truncate =3D bdrv_has_zero_init_1,
>=20
> was a lot wordier than the new:
>=20
> .bdrv_known_zeroes =3D bdrv_known_zeroes_truncate,

Not sure if that=E2=80=99s bad, though.

> ), or completely spelled out but where both creation and truncation were
> determined in the same amount of effort.

Well, usually, the effort is minimal, but OK.

>> And thus callers which just want the trivially obtainable
>> BDRV_ZERO_TRUNCATE info have to wait for the BDRV_ZERO_OPEN inquiry,
>> even though they don=E2=80=99t care about that flag.
>=20
> True, but only to a minor extent; and the documentation mentions that
> the BDRV_ZERO_OPEN calculation MUST NOT be as expensive as a blind
> block_status loop.

So it must be less expensive than an arbitrarily complex loop.  I think
a single SEEK_DATA/HOLE call was something like O(n) on tmpfs?

What I=E2=80=99m trying to say is that this is not a good limit and can mea=
n
anything.

I do think this limit definition makes sense for callers that want to
know about ZERO_OPEN.  But I don=E2=80=99t know why we would have to let ot=
her
callers wait, too.

> Meanwhile, callers tend to only care about
> bdrv_known_zeroes() right after opening an image or right before
> resizing (not repeatedly during runtime);

Hm, yes.  I was thinking of parallels, but that only checks once in
parallels_open(), so it=E2=80=99s OK.

> and you also argued elsewhere
> in this thread that it may be worth having the block layer cache
> BDRV_ZERO_OPEN and update the cache on any write,

I didn=E2=80=99t say the block layer, but it if makes sense.

> at which point, the
> expense in the driver callback really is a one-time call during
> bdrv_co_open().

It definitely doesn=E2=80=99t make sense to me to do that call unconditiona=
lly
in bdrv_co_open().

> And in that case, whether the one-time expense is done
> via a single function call or via three driver callbacks, the amount of
> work is the same; but the driver callback interface is easier if there
> is only one callback (similar to how bdrv_unallocated_blocks_are_zero()
> calls bdrv_get_info() only for bdi.unallocated_blocks_are_zero, even
> though BlockDriverInfo tracks much more than that boolean).
>=20
> In fact, it may be worth consolidating known zeroes support into
> BlockDriverInfo.

I=E2=80=99m very skeptical of that.  BDI already has the problem that it do=
esn=E2=80=99t
know which of the information the caller actually wants and that it is
sometimes used in a quasi-hot path.

Maybe that means it is indeed time to incorporate it into BDI, but the
caller should have a way of specifying what parts of BDI it actually
needs and then drivers can skip anything that isn=E2=80=99t trivially obtai=
nable
that the caller doesn=E2=80=99t need.

>> So I=E2=80=99d leave it as separate functions so drivers can feel free t=
o have
>> implementations for BDRV_ZERO_OPEN that take more than mere microseconds
>> but that are more accurate.
>>
>> (Or maybe if you really want it to be a single functions, callers could
>> pass the mask of flags they care about.=C2=A0 If all flags are trivially
>> obtainable, the implementations would then simply create their result
>> mask and & it with the caller-given mask.=C2=A0 For implementations wher=
e
>> some branches could take a bit more time, those branches are only taken
>> when the caller cares about the given flag.=C2=A0 But again, I don=E2=80=
=99t
>> necessarily think having a single function is more easily handleable
>> than three smaller ones.)
>=20
> Those are still viable options, but before I repaint the bikeshed along
> those lines, I'd at least like a review of whether the overall idea of
> having a notion of 'reads-all-zeroes' is indeed useful enough,
> regardless of how we implement it as one vs. three driver callbacks.

I=E2=80=99m as hesitant as ever to give a review that this notion is useful=
,
because I haven=E2=80=99t seen a practical example yet where the problem is=
n=E2=80=99t
the fact that NBD doesn=E2=80=99t have 64-bit write_zeroes support.

So far, it looks to me like this notion is only really useful for cases
where we expect a management layer on top of qemu anyway.  And then I=E2=80=
=99m
not sure that this new feature works reliably enough for such a
management layer.

(I=E2=80=99m not saying it isn=E2=80=99t useful.  Again, intuitively it doe=
s seem
useful.  Intuition can be enough to merge a sufficiently simple series
that doesn=E2=80=99t increase code complexity too much.  But I=E2=80=99m st=
ill asking
for actual practical examples, because that would make a better
argument, of course.)

Max


--B11gEeyxXHx7HsOe7g4REGq2lCWI5hRoJ--

--QmSuvCfqJGT30JUmf36qMLZS2ihWLGrHe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl46+c8ACgkQ9AfbAGHV
z0DlKgf+NOTmXCs1gay/aSA5SWDGO2Xcutw0rfml9U9FxgGEbcM9DX+eMXdsFoKP
MNP+q44QiCIuUX7512g0X/DSp+MZlFmkzGYeoQKXP+mFT1/39GeEW+PSJBsmDYHZ
mze37F0N4WkcRgLRKiFxDYadOQsvqQItMhd/mwSc/dCpJ/FYPmmZYgiP0WQv2mxS
Ti5lXoXnM7K7M7MQrW41e0fWpCammObqilIUeqpEnPfBshBEuppmeSSCKRmFuc4z
Wd0UVGXqYlKXBVyOlqjwlX6KxQwRZ5yHG4/Nw4ebXUNAeycU3bHuciBAURlanHEC
I4QdYiCaDtnZNECaQ23PfGfs6hYopA==
=DZzR
-----END PGP SIGNATURE-----

--QmSuvCfqJGT30JUmf36qMLZS2ihWLGrHe--



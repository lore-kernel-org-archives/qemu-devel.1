Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1CDCA90AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404A9206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 08:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V75iK57H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404A9206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYn9K-0007gi-DQ
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 04:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYn8d-0006xp-6K
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:53:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYn8b-00078e-FA
 for qemu-devel@nongnu.org; Wed, 13 May 2020 04:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589359992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yQ+QFSU4ErQ1MejCTvrLvYs3xdb1Y/voUEO+20DR8jk=;
 b=V75iK57HTqBIHd1YX2OkwkepviASE/cW/9sSO+5kA39NbxLncVYCgXEbbt5eobA89C6LMd
 O1og1eHZ4eDzcSLp5jucCCDjK5D6ZPKwwQrOJmFOmazd5/f7VkU2lRB/B/UAOOvaIe4zzO
 bNYwgXWea8h5lkeNO41sapqdGvgR/a0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-GOslOVTBOHyNGNOjAYAoVg-1; Wed, 13 May 2020 04:53:09 -0400
X-MC-Unique: GOslOVTBOHyNGNOjAYAoVg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA3078014D7;
 Wed, 13 May 2020 08:53:08 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.193.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21E932E174;
 Wed, 13 May 2020 08:53:06 +0000 (UTC)
Subject: Re: [PATCH v3 7/9] qcow2: Expose bitmaps' size during measure
To: Eric Blake <eblake@redhat.com>, Nir Soffer <nsoffer@redhat.com>
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-8-eblake@redhat.com>
 <CAMRbyytP9LvMVJ1R1EEnjHJGKOXtOYg_=ywqn-yVDLBeqFff4g@mail.gmail.com>
 <d0c62eef-acf6-0996-4928-1836940e2901@redhat.com>
 <1a9f1d01-5b9a-ac35-334e-1fe090682621@redhat.com>
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
Message-ID: <2ad8515c-99d2-6552-9334-61c0b077a182@redhat.com>
Date: Wed, 13 May 2020 10:53:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1a9f1d01-5b9a-ac35-334e-1fe090682621@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qDUZGqF40RQAFQxVol9PtOKwuGNrQCvmc"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qDUZGqF40RQAFQxVol9PtOKwuGNrQCvmc
Content-Type: multipart/mixed; boundary="JmDiA9GZoQXBQTFlIR7jFY1yH0rm4cDX6"

--JmDiA9GZoQXBQTFlIR7jFY1yH0rm4cDX6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.05.20 21:39, Eric Blake wrote:
> On 5/12/20 6:10 AM, Max Reitz wrote:
>=20
>=20
>>> This does not break old code since previously we always reported only
>>> guest visible content
>>> here, but it changes the semantics, and now you cannot allocate
>>> "required" size, you need
>>> to allocate "required" size with "bitmaps" size.
>>
>> Only if you copy the bitmaps, though, which requires using the --bitmaps
>> switch for convert.
>=20
> First, a usage question: would you rather that 'qemu-img convert
> --bitmaps' silently succeeds even when the image being converted has no
> bitmaps, or would you rather that it fails loudly when there are no
> bitmaps to be copied over?=C2=A0 As implemented in this patch series, pat=
ch 8
> currently silently succeeds.=C2=A0 But in order to make patch 7 and 8
> consistent with one another, I need to know which behavior is easier to
> use: failing convert if the source lacks bitmaps (and thus measure would
> suppress the bitmaps:0 output), or treating lack of bitmaps as nothing
> additional to copy and thereby succeeding (and thus measure should
> output bitmaps:0 to show that no additional space is needed because
> nothing else will be copied, successfully).

=E2=80=9CEasier to use=E2=80=9D in my opinion would be if it never fails, b=
ut the
question is whether that=E2=80=99s also the most useful approach.

I think it should match what I thought when @bitmaps should be reported,
i.e. it should be accepted whenever the target format (and qemu-img
convert, obviously) supports bitmaps.  I don=E2=80=99t think there=E2=80=99=
s value in
aborting just because the source doesn=E2=80=99t have bitmaps.  What=E2=80=
=99s the user
going to do in response?  =E2=80=9COops, thanks, qemu-img, I accidentally t=
ried
to convert the wrong image=E2=80=9D?

(Whereas if we reject --bitmaps because the target format doesn=E2=80=99t
support it, there=E2=80=99s actually value, because the user is reminded th=
at
they should choose a different target format.)

>>> If we add a new
>>> extension all users will have to
>>> change the calculation again.
>>
>> It was my impression that existing users won=E2=80=99t have to do that, =
because
>> they don=E2=80=99t use --bitmaps yet.
>>
>> In contrast, if we included the bitmap size in @required or
>> @fully-allocated, then previous users that didn=E2=80=99t copy bitmaps t=
o the
>> destination (which they couldn=E2=80=99t) would allocate too much space.
>>
>> ...revisiting this after reading more of your mail: With a --bitmaps
>> switch, existing users wouldn=E2=80=99t suffer from such compatibility p=
roblems.
>> =C2=A0 However, then users (that now want to copy bitmaps) will have to =
pass
>> the new --bitmaps flag in the command line, and I don=E2=80=99t see how =
that=E2=80=99s
>> less complicated than just adding @bitmaps to @required.
>=20
> More concretely, suppose down the road that we add the ability to copy
> internal snapshots (not that you want to mix internal and external
> snapshots, but that such information already exists and therefore can be
> used as an example).=C2=A0 Which is easier:
>=20
> $ qemu-img measure -f qcow2 image.qcow2
> required size: 8716288
> fully allocated size: 8716288
> bitmaps size: 1024
> internal snapshot size: 2048
>=20
> where you now have to add three numbers prior to creating dest.qcow2and
> calling:
>=20
> $ qemu-img convert image.qcow2 -f dest.qcow2 --bitmaps --snapshots
>=20
> or using:
>=20
> $ qemu-img measure --bitmaps --snapshots -f qcow2 image.qcow2
> required size: 8719360
> fully allocated size: 8719360
>=20
> where you then call:
>=20
> $ qemu-img convert image.qcow2 -f dest.qcow2 --bitmaps --snapshots

=E2=80=9CWhich is easier=E2=80=9D is misleading, because both are actually =
trivial.
Adding three numbers is what a computer does best.

It=E2=80=99s a question of style, not of =E2=80=9Cwhich is easier=E2=80=9D.

> with a single size that matches the same arguments you pass to qemu-img
> convert?=C2=A0 What about failure cases?=C2=A0 What happens when qemu-img=
 doesn't
> understand --snapshots but does understand --bitmaps?=C2=A0 Do you have t=
o
> try a series of up to three calls to find how much information is
> supported:
>=20
> $ qemu-img measure -f qcow2 image.qcow2 --bitmaps --snapshots
> error: unknown argument
> $ qemu-img measure -f qcow2 image.qcow2 --bitmaps
> error: unknown argument
> $ qemu-img measure -f qcow2 image.qcow2
> data given, now you know that neither --bitmaps nor --snapshots will work
>=20
> or is it nicer to issue just one measure without options, getting
> separate output lines, and seeing which output lines exist to know which
> convert options are supported, at the minor expense of having to add
> values yourself?

Sounds good to me, but then again, calling a command to see whether it
fails isn=E2=80=99t exactly hard either.

So it remains a question of style to me.

From my perspective, measure is a query function similar to info.  It
should return all information that=E2=80=99s trivial to obtain.  Switches t=
o
select what information to return how only make sense when that optional
information is hard to obtain (think qemu-img info --backing-chain).

Switches make sense on data-modifying operations like convert.  Not so
much for querying operations, because why not just return all
information you have and let the caller sort it out?

[...]

>>> If we always report bitmaps even when they are zero, we don't need to
>>> run "qemu-img info".
>>>
>>> But=C2=A0 my preferred interface is:
>>>
>>> =C2=A0=C2=A0=C2=A0 qemu-img measure --bitmaps ...
>>>
>>> And report bitmaps only if the user asked to get the value. In this
>>> case the required and
>>> fully-allocated values will include bitmaps.
>>
>> Well, it would be consistent with the convert interface.=C2=A0 If you sp=
ecify
>> it for one, you specify it for the other.
>>
>> OTOH, this would mean having to pass around the @bitmaps bool in the
>> block layer, which is a bit more difficult than just adding a new field
>> in BlockMeasureInfo.=C2=A0 It would also mean to add a new bool every ti=
me we
>> add a new extension (which you hinted at above that it might happen).
>=20
> Or, that could be a CLI-only feature: the QMP interface _always_ reports
> bitmaps separately, but if 'qemu-img measure --bitmaps' is used, the CLI
> then adds that value in on your behalf after the QMP command but before
> printing to the end user.
>=20
>>
>> (We could also let img_measure() in qemu-img add @bitmaps to @required
>> if --bitmaps was given, so we wouldn=E2=80=99t have to pass the bool aro=
und; but
>> I think letting qemu-img fix up a QAPI object filled by the block driver
>> sounds wrong.=C2=A0 (Because that means the block driver didn=E2=80=99t =
fill it
>> correctly.))
>=20
> If we only touch it up in the CLI, then we would have two forms of CLI
> output:
>=20
> $ qemu-img measure -f qcow2 image.qcow2
> required size: 8716288
> fully allocated size: 8716288
> bitmaps size: 1024
> $ qemu-img measure -f qcow2 image.qcow2 --bitmaps
> required size: 8717312
> fully allocated size: 8717312
I would hope that programs consuming qemu-img measure=E2=80=99s output use
--output=3Djson, and then you definitely can=E2=80=99t just ignore the QAPI=
 object
definition.

Furthermore, I don=E2=80=99t like that 2-form at all, for two reasons.  Fir=
st,
again, I can=E2=80=99t see a reasonable QAPI definition to match it; and se=
cond,
I don=E2=80=99t like it as a consistent interface.  We should decide on one
thing and do that.  Either you need to pass --bitmaps to make them
included in required, or they aren=E2=80=99t in the output at all.

The way you propose it with this 2-form approach makes --bitmap make
qemu-img be a calculator.   But why?  It=E2=80=99s absolutely trivial for
consumers to:

irb(main):002:1` result =3D JSON.parse(`./qemu-img measure --output=3Djson =
\
irb(main):003:0>                                 -O qcow2 src.qcow2`)
irb(main):004:0* result['required'] +
irb(main):005:0>   (result['bitmaps'] ? result['bitmaps'] : 0)
=3D> 524288

(Example in Ruby, but I don=E2=80=99t think that matters much.)

There is no value in qemu-img optionally performing that operation for
the caller.  Adding two integers is the simplest thing there is.

Max


--JmDiA9GZoQXBQTFlIR7jFY1yH0rm4cDX6--

--qDUZGqF40RQAFQxVol9PtOKwuGNrQCvmc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl67tXEACgkQ9AfbAGHV
z0Af+QgAtU3xLF07rgtRB/3ev2JEoSXXCI/eEY1gWA8aJJP1RBFRuPyJ7Cd7/qk9
fggeiWhZD2BZp2SboWn1LUhuWq9OwdYHcjUYPhPtjzb+SlfDRni6x2pIkquOPbqy
qkTiCfFaizaC3vl8AAJNnnVom5zNDVRHUNW0pJr2Yu1A6PV6i8+wiH7DPv1PJTNk
dBbfJ49unY2wMwQbWIZwrROcQ1ibryfzBJ/VPKDYuHgZhvjwFpPjfNAoc9F8EnXx
NJqxKFUJJ9Ho7NSKEV1c92E5NqDGjGBlGC9F5dnEEjgDWStkQd1e5miBorWwnpn7
PA306ezS8ddKyskDHAgfpG4hMftpXg==
=MJ3K
-----END PGP SIGNATURE-----

--qDUZGqF40RQAFQxVol9PtOKwuGNrQCvmc--



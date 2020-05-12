Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509B0C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C58206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 11:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YLYDNXTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C58206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYStB-0008KO-5E
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 07:15:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYSnk-0005wX-Ft
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:10:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49536
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jYSni-0008JT-Sj
 for qemu-devel@nongnu.org; Tue, 12 May 2020 07:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589281817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sL0nwszVkNmrDhR2PFBLcWmhPQ1/jjxFPnGYCCt/w28=;
 b=YLYDNXToWFvGn/JwK1pv6FoaYz1vN04j1Q31vsx26+M2WqrIAvlJtyG0F+agSCjCxBcvT8
 5r8BRpuahfWLwoxPUxvx5OHO0vBl598k+G/QhHAEmzNbozsrXcCoQXscNFy9KYmgkc3OtP
 JXcGdsUpvaA4jwgKDiV6PunajFwZmvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Ac_W0-FlPMS9e9hK0okwSw-1; Tue, 12 May 2020 07:10:14 -0400
X-MC-Unique: Ac_W0-FlPMS9e9hK0okwSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89E37835BB7;
 Tue, 12 May 2020 11:10:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-248.ams2.redhat.com
 [10.36.112.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCC8F76E67;
 Tue, 12 May 2020 11:10:04 +0000 (UTC)
Subject: Re: [PATCH v3 7/9] qcow2: Expose bitmaps' size during measure
To: Nir Soffer <nsoffer@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20200508180340.675712-1-eblake@redhat.com>
 <20200508180340.675712-8-eblake@redhat.com>
 <CAMRbyytP9LvMVJ1R1EEnjHJGKOXtOYg_=ywqn-yVDLBeqFff4g@mail.gmail.com>
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
Message-ID: <d0c62eef-acf6-0996-4928-1836940e2901@redhat.com>
Date: Tue, 12 May 2020 13:10:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyytP9LvMVJ1R1EEnjHJGKOXtOYg_=ywqn-yVDLBeqFff4g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W0anmBld5Glw9mEE3jRBjgFcJAgsIHNnw"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 02:20:15
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
--W0anmBld5Glw9mEE3jRBjgFcJAgsIHNnw
Content-Type: multipart/mixed; boundary="B8tbHhJRAQBNNMFcKcGyl2HQ5PxOtg1BE"

--B8tbHhJRAQBNNMFcKcGyl2HQ5PxOtg1BE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.05.20 12:17, Nir Soffer wrote:
> On Fri, May 8, 2020 at 9:03 PM Eric Blake <eblake@redhat.com> wrote:
>>
>> It's useful to know how much space can be occupied by qcow2 persistent
>> bitmaps, even though such metadata is unrelated to the guest-visible
>> data.  Report this value as an additional field, present when
>> measuring an existing image and the output format supports bitmaps.
>> Update iotest 178 and 190 to updated output, as well as new coverage
>> in 190 demonstrating non-zero values made possible with the
>> recently-added qemu-img bitmap command.
>>
>> The addition of a new field demonstrates why we should always
>> zero-initialize qapi C structs; while the qcow2 driver still fully
>> populates all fields, the raw and crypto drivers had to be tweaked to
>> avoid uninitialized data.
>>
>> See also: https://bugzilla.redhat.com/1779904
>>
>> Reported-by: Nir Soffer <nsoffer@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  qapi/block-core.json             | 15 +++++++----
>>  block/crypto.c                   |  2 +-
>>  block/qcow2.c                    | 37 ++++++++++++++++++++++++---
>>  block/raw-format.c               |  2 +-
>>  qemu-img.c                       |  3 +++
>>  tests/qemu-iotests/178.out.qcow2 | 16 ++++++++++++
>>  tests/qemu-iotests/190           | 43 ++++++++++++++++++++++++++++++--
>>  tests/qemu-iotests/190.out       | 23 ++++++++++++++++-
>>  8 files changed, 128 insertions(+), 13 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 943df1926a91..9a7a388c7ad3 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -633,18 +633,23 @@
>>  # efficiently so file size may be smaller than virtual disk size.
>>  #
>>  # The values are upper bounds that are guaranteed to fit the new image =
file.
>> -# Subsequent modification, such as internal snapshot or bitmap creation=
, may
>> -# require additional space and is not covered here.
>> +# Subsequent modification, such as internal snapshot or further bitmap
>> +# creation, may require additional space and is not covered here.
>>  #
>> -# @required: Size required for a new image file, in bytes.
>> +# @required: Size required for a new image file, in bytes, when copying=
 just
>> +#            guest-visible contents.
>>  #
>>  # @fully-allocated: Image file size, in bytes, once data has been writt=
en
>> -#                   to all sectors.
>> +#                   to all sectors, when copying just guest-visible con=
tents.
>=20
> This does not break old code since previously we always reported only
> guest visible content
> here, but it changes the semantics, and now you cannot allocate
> "required" size, you need
> to allocate "required" size with "bitmaps" size.

Only if you copy the bitmaps, though, which requires using the --bitmaps
switch for convert.

> If we add a new
> extension all users will have to
> change the calculation again.

It was my impression that existing users won=E2=80=99t have to do that, bec=
ause
they don=E2=80=99t use --bitmaps yet.

In contrast, if we included the bitmap size in @required or
@fully-allocated, then previous users that didn=E2=80=99t copy bitmaps to t=
he
destination (which they couldn=E2=80=99t) would allocate too much space.

...revisiting this after reading more of your mail: With a --bitmaps
switch, existing users wouldn=E2=80=99t suffer from such compatibility prob=
lems.
 However, then users (that now want to copy bitmaps) will have to pass
the new --bitmaps flag in the command line, and I don=E2=80=99t see how tha=
t=E2=80=99s
less complicated than just adding @bitmaps to @required.

> I think keeping the semantics that "required" and "fully-allocated"
> are the size you need based
> on the parameters of the command is easier to use and more consistent.
> Current the measure
> command contract is that invoking it with similar parameters as used
> in convert will give
> the right measurement needed for the convert command.
>=20
>> +#
>> +# @bitmaps: Additional size required for bitmap metadata in a source im=
age,
>> +#           if that bitmap metadata can be copied in addition to guest
>> +#           contents. (since 5.1)
>=20
> Reporting bitmaps without specifying that bitmaps are needed is less cons=
istent
> with "qemu-img convert", but has the advantage that we don't need to
> check if measure
> supports bitmaps. But this will work only if new versions always
> report "bitmaps" even when
> the value is zero.
>=20
> With the current way, to measure an image we need to do:
>=20
> qemu-img info --output json ...
> check if image contains bitmaps
> qemu-img measure --output json ...
> check if bitmaps are reported.
>=20
> If image has bitmaps and bitmaps are not reported, we know that we have a=
n old
> version of qemu-img that does not know how to measure bitmaps.

Well, but you=E2=80=99ll also see that convert --bitmaps will fail.  But I =
can
see that you probably want to know about that before you create the
target image.

> If bitmaps are reported in both commands we will use the value when creat=
ing
> block devices.

And otherwise?  Do you error out, or do you just omit --bitmaps from
convert?

> If we always report bitmaps even when they are zero, we don't need to
> run "qemu-img info".
>=20
> But  my preferred interface is:
>=20
>    qemu-img measure --bitmaps ...
>=20
> And report bitmaps only if the user asked to get the value. In this
> case the required and
> fully-allocated values will include bitmaps.

Well, it would be consistent with the convert interface.  If you specify
it for one, you specify it for the other.

OTOH, this would mean having to pass around the @bitmaps bool in the
block layer, which is a bit more difficult than just adding a new field
in BlockMeasureInfo.  It would also mean to add a new bool every time we
add a new extension (which you hinted at above that it might happen).

(We could also let img_measure() in qemu-img add @bitmaps to @required
if --bitmaps was given, so we wouldn=E2=80=99t have to pass the bool around=
; but
I think letting qemu-img fix up a QAPI object filled by the block driver
sounds wrong.  (Because that means the block driver didn=E2=80=99t fill it
correctly.))

And I don=E2=80=99t see how the interface proposed here by Eric (or rather,=
 what
I think we had agreed on for the next version) poses any problems for
users.  If you want to copy bitmaps, you just use @required + @bitmaps.
 (If @bitmaps isn=E2=80=99t present, you can=E2=80=99t copy bitmaps, so tha=
t should be
an error.)  If you don=E2=80=99t want to copy bitmaps, you just use @requir=
ed.

(And if you want to copy bitmaps if present, you use @required +
@bitmaps, and treat @bitmaps as 0 if not present.)

> To learn if qemu-img measure understand bitmaps we can check --help
> output, like we did
> in the past until we can require the version on all platforms.
>=20
> An advantage is not having to change old tests.
I personally don=E2=80=99t really consider that a significant advantage... =
 (On
the contrary, seeing the field in all old tests means the code path is
exercised more often, even though it=E2=80=99s supposed to always just repo=
rt 0.)

So all in all the main benefit I see in your proposal, i.e. having
@bitmaps be included in @required with --bitmaps given, is that it would
give a symmetrical interface between measure and convert: For simple
cases, you can just replace the =E2=80=9Cconvert=E2=80=9D in your command l=
ine by
=E2=80=9Cmeasure=E2=80=9D, retrieve @required/@fully-allocated, create the =
target image
based on that, and then re-run the same command line, but with =E2=80=9Ccon=
vert=E2=80=9D
this time.

But I=E2=80=99m not sure whether that=E2=80=99s really an advantage in prac=
tice or more
of a gimmick.  With Eric=E2=80=99s proposal, if you want to convert with
bitmaps, just add @bitmaps to the target size.  If you don=E2=80=99t, don=
=E2=80=99t.  If
you=E2=80=99d prefer to but don=E2=80=99t really care, add =E2=80=9C@bitmap=
s ?: 0=E2=80=9D.

The benefit of Eric=E2=80=99s proposal (not including @bitmaps in @required=
 or
@fully-allocated) is that it doesn=E2=80=99t require passing an additional
parameter to the block driver.  It also makes the definition of
BlockMeasureInfo simpler.  With your proposal, it would need to be
parameterized.  (As in, @required sometimes includes the bitmaps,
sometimes it doesn=E2=80=99t, depending on the parameter used to retrieve
BlockMeasureInfo.)  I=E2=80=99m not sure whether that even makes sense in t=
he
QAPI definition.

Max


--B8tbHhJRAQBNNMFcKcGyl2HQ5PxOtg1BE--

--W0anmBld5Glw9mEE3jRBjgFcJAgsIHNnw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl66hAoACgkQ9AfbAGHV
z0A2Lgf/RrEWZmrAfBLyTRfBiVPYH4v9+8vrx9IqYNmhAAafAySXbDcrahIIqepI
bimO2RSNOJC2pB6QimQ8IlTqoGt62OWFSP02ZJwfjngsjZCxK+WffauWTgUISTGd
5/3iEORG/dHJMCTnYkqzpLuGMkkn8an4ezgRBOZ/K9ExhlBEUfymvnfGc6pXWxp3
36asbNcV4N5RugasiR/sCqvA+pG6d7LpBVJn45AirYcuHCyZdKuqQy/Lh10XgHIw
kAnKcF37F9MNJbXXNg+ehLM1LzWmxIs3SEZeO0JvWHknaxX340Kk0xJ7GD8Jg6VH
PRBBhm4YBHvHQOY/1zfhM223KAU78g==
=ENFr
-----END PGP SIGNATURE-----

--W0anmBld5Glw9mEE3jRBjgFcJAgsIHNnw--



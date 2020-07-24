Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EE3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3F1206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 08:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAV/8SW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3F1206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jytXm-0008OO-P7
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 04:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jytXA-0007py-I6
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:58:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58020
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jytX8-0002MA-0j
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 04:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595581105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mcMwk2dLmptidmGRM0taiES0Zy835SgTHCZPkcoKMB4=;
 b=KAV/8SW4xycCzq1olZX8MSHsD05aJkiA7sjPX8/4xnB7MAk3i1Kqmt7SLzFfxu0uFgEJgZ
 uR69Fzg+b41xOOM8etLJv5HxnalZOw0ZKIFq6nQdDZqBmcGJTso29T4ygqUDx9DhdrwKfI
 1dHahwfw3xQJOEiR7Shg5N/0WvrRfPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-YBUSxstyN6S-TH4mAavWdQ-1; Fri, 24 Jul 2020 04:58:22 -0400
X-MC-Unique: YBUSxstyN6S-TH4mAavWdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C8C51005504;
 Fri, 24 Jul 2020 08:58:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-32.ams2.redhat.com
 [10.36.113.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9128810013D9;
 Fri, 24 Jul 2020 08:58:19 +0000 (UTC)
Subject: Re: [PATCH v7 28/47] block/null: Implement
 bdrv_get_allocated_file_size
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-29-mreitz@redhat.com>
 <93f4b62e-78d9-af84-ab1c-95eea55bbc0f@virtuozzo.com>
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
Message-ID: <b0c02e56-538e-88e9-33d6-4bb276aa3ed1@redhat.com>
Date: Fri, 24 Jul 2020 10:58:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <93f4b62e-78d9-af84-ab1c-95eea55bbc0f@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XZTDLagOJhhB1W8FUhhK9whUnI8JofgZx"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 00:01:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XZTDLagOJhhB1W8FUhhK9whUnI8JofgZx
Content-Type: multipart/mixed; boundary="fCfK2nKasg5cilwkwblS5EiggBOE1fgkV"

--fCfK2nKasg5cilwkwblS5EiggBOE1fgkV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.07.20 17:10, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> It is trivial, so we might as well do it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 block/null.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7 +++++++
>> =C2=A0 tests/qemu-iotests/153.out | 2 +-
>> =C2=A0 tests/qemu-iotests/184.out | 6 ++++--
>> =C2=A0 3 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/null.c b/block/null.c
>> index 15e1d56746..cc9b1d4ea7 100644
>> --- a/block/null.c
>> +++ b/block/null.c
>> @@ -262,6 +262,11 @@ static void
>> null_refresh_filename(BlockDriverState *bs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 bs->drv->format_name);
>> =C2=A0 }
>> =C2=A0 +static int64_t null_allocated_file_size(BlockDriverState *bs)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 static const char *const null_strong_runtime_opts[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_OPT_SIZE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL_OPT_ZEROES,
>> @@ -277,6 +282,7 @@ static BlockDriver bdrv_null_co =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_file_open=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D null_file_open,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_parse_filename=C2=A0=C2=A0=C2=A0 =
=3D null_co_parse_filename,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_getlength=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D null_getlength,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_get_allocated_file_size =3D null_allocated_fil=
e_size,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_co_preadv=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D null_co_preadv,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_co_pwritev=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D null_co_pwritev,
>> @@ -297,6 +303,7 @@ static BlockDriver bdrv_null_aio =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_file_open=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D null_file_open,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_parse_filename=C2=A0=C2=A0=C2=A0 =
=3D null_aio_parse_filename,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_getlength=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D null_getlength,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_get_allocated_file_size =3D null_allocated_fil=
e_size,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_aio_preadv=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D null_aio_preadv,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_aio_pwritev=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D null_aio_pwritev,
>> diff --git a/tests/qemu-iotests/153.out b/tests/qemu-iotests/153.out
>> index b2a90caa6b..8659e6463b 100644
>> --- a/tests/qemu-iotests/153.out
>> +++ b/tests/qemu-iotests/153.out
>> @@ -461,7 +461,7 @@ No conflict:
>> =C2=A0 image: null-co://
>> =C2=A0 file format: null-co
>> =C2=A0 virtual size: 1 GiB (1073741824 bytes)
>> -disk size: unavailable
>> +disk size: 0 B
>> =C2=A0 =C2=A0 Conflict:
>> =C2=A0 qemu-img: --force-share/-U conflicts with image options
>> diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
>> index 3deb3cfb94..28b104da89 100644
>> --- a/tests/qemu-iotests/184.out
>> +++ b/tests/qemu-iotests/184.out
>> @@ -29,7 +29,8 @@ Testing:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "image": {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "virtual-size": 1073741824,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "filename": "json:{\"throttle-group\": \"gro=
up0\",
>> \"driver\": \"throttle\", \"file\": {\"driver\": \"null-co\"}}",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "format": "throttle"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "format": "throttle",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 "actual-size": SIZE
>=20
>=20
> If we remove the _filter_generated_node_ids() in the current
> implementation of the test #184, we will get '"actual-size": 0'. It
> might be more informative when analyzing the output in 184.out.

You mean _filter_actual_image_size?  Yeah, why not, it doesn=E2=80=99t seem
necessary here.

Max


--fCfK2nKasg5cilwkwblS5EiggBOE1fgkV--

--XZTDLagOJhhB1W8FUhhK9whUnI8JofgZx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8aoqkACgkQ9AfbAGHV
z0DlIAgAldqiWoNcvmDpVVMXdJyqFT2r4sz2x2AMZgdKXVJxmeASESFLAeQ0O6cu
aTThBf97I/5kxZ07f0e6VWUvYIuM7iGqbCzkanVVNRVPXP4JgA/+Kk+eXJYh/llC
Udkr/5Xh4zEl4qgIT0RhdOKM8ZLsl99A7f/iEWcjSsTgBAptD7eqPoR35C+GUqf2
GIbevNpCooX2ioBE/5HqrMynVI3Y1ltDaKSaEQemzJkeeafJYcJrQZwxmKHXzWEm
7oot4kJtSE/q133utXHMGhU8dAn8kZ9dkPHi4vjynHS7hARuP8Pvn1pC39GLq25u
zJcy4XCXW4MsOs1POtU0UgbsEOlOKg==
=AQ9a
-----END PGP SIGNATURE-----

--XZTDLagOJhhB1W8FUhhK9whUnI8JofgZx--



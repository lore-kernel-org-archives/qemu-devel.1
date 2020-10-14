Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7165EC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 09:37:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE5D72073A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 09:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIIj/Db1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE5D72073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSdDh-0002r4-Jn
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 05:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSdCa-0001ut-OU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 05:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54038)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kSdCY-0000Jb-Vm
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 05:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602668165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i1d+Y/NuWEo/+ougMrmF21qCkaAb+G4GJJxZ2VjSaDs=;
 b=AIIj/Db1tZHZlU6wgDisyHRxBpg11dvRqwpNkeB2VDK5EIpp+9IT4+Sm19uO21ELKtf2Sg
 V0Y12uS3Wr/0uqv4OdPI3cwPINGBLbhi2FhlvbS2sOGZ4U7A+L1YlK9i+I4hc0TyaGHAOj
 3GfcPouvkoAtx59wDoz/ICaEVlLQi1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-72N0T8XLPdyHTeuv--Yysg-1; Wed, 14 Oct 2020 05:36:01 -0400
X-MC-Unique: 72N0T8XLPdyHTeuv--Yysg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 367421823DD2;
 Wed, 14 Oct 2020 09:35:59 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.194.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 351EC1002391;
 Wed, 14 Oct 2020 09:35:55 +0000 (UTC)
Subject: Re: [PATCH v2] migration/block-dirty-bitmap: fix uninitialized
 variable warning
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20201013123340.1850548-1-kuhn.chenqun@huawei.com>
 <561a0092-3723-a95a-0208-d53cb475a532@redhat.com>
 <7412CDE03601674DA8197E2EBD8937E83B9B6538@dggemm531-mbx.china.huawei.com>
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
Message-ID: <5a6483ec-9cab-58d9-872c-48762e96f768@redhat.com>
Date: Wed, 14 Oct 2020 11:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B9B6538@dggemm531-mbx.china.huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9r5WyatiUIyroMZofYYsbgvBwERnwTNRj"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "fam@euphon.net" <fam@euphon.net>, ganqixin <ganqixin@huawei.com>,
 "vsementsov@virtuozzo.com" <vsementsov@virtuozzo.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9r5WyatiUIyroMZofYYsbgvBwERnwTNRj
Content-Type: multipart/mixed; boundary="syFb9lIOnh7aKeB6Cco0Ls51i7elfO6ay"

--syFb9lIOnh7aKeB6Cco0Ls51i7elfO6ay
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.20 03:03, Chenqun (kuhn) wrote:
>=20
>=20
>> -----Original Message-----
>> From: Max Reitz [mailto:mreitz@redhat.com]
>> Sent: Tuesday, October 13, 2020 10:47 PM
>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-devel@nongnu.org;
>> qemu-trivial@nongnu.org
>> Cc: vsementsov@virtuozzo.com; stefanha@redhat.com; fam@euphon.net;
>> eblake@redhat.com; jsnow@redhat.com; quintela@redhat.com;
>> dgilbert@redhat.com; Zhanghailiang <zhang.zhanghailiang@huawei.com>;
>> ganqixin <ganqixin@huawei.com>; qemu-block@nongnu.org; Euler Robot
>> <euler.robot@huawei.com>; Laurent Vivier <laurent@vivier.eu>; Li Qiang
>> <liq3ea@gmail.com>
>> Subject: Re: [PATCH v2] migration/block-dirty-bitmap: fix uninitialized =
variable
>> warning
>>
>> On 13.10.20 14:33, Chen Qun wrote:
>>> A default value is provided for the variable 'bitmap_name' to avoid com=
piler
>> warning.
>>>
>>> The compiler show warning:
>>> migration/block-dirty-bitmap.c:1090:13: warning: =E2=80=98bitmap_name=
=E2=80=99
>>> may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>        g_strlcpy(s->bitmap_name, bitmap_name,
>> sizeof(s->bitmap_name));
>>>
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Reported-by: Euler Robot <euler.robot@huawei.com>
>>> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
>>> ---
>>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Cc: Laurent Vivier <laurent@vivier.eu>
>>> Cc: Li Qiang <liq3ea@gmail.com>
>>> ---
>>>  migration/block-dirty-bitmap.c | 9 ++-------
>>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> No objections, semantically, but...
>>
>>> diff --git a/migration/block-dirty-bitmap.c
>>> b/migration/block-dirty-bitmap.c index 5bef793ac0..bcb79c04ce 100644
>>> --- a/migration/block-dirty-bitmap.c
>>> +++ b/migration/block-dirty-bitmap.c
>>> @@ -1064,15 +1064,13 @@ static int dirty_bitmap_load_header(QEMUFile
>> *f, DBMLoadState *s,
>>>      assert(nothing || s->cancelled || !!alias_map =3D=3D
>>> !!bitmap_alias_map);
>>>
>>>      if (s->flags & DIRTY_BITMAP_MIG_FLAG_BITMAP_NAME) {
>>> -        const char *bitmap_name;
>>> -
>>>          if (!qemu_get_counted_string(f, s->bitmap_alias)) {
>>>              error_report("Unable to read bitmap alias string");
>>>              return -EINVAL;
>>>          }
>>>
>>> -        if (!s->cancelled) {
>>> -            if (bitmap_alias_map) {
>>> +        const char *bitmap_name =3D s->bitmap_alias;
>>
>> qemu=E2=80=99s coding style mandates declarations to be placed at the be=
ginning of
>> their block, so the declaration has to stay where it is.  (Putting the a=
ssignment
>> here looks reasonable.)
>>
> Hi Max,
>   Declaration variables here to ensure that the above exceptions(Unable t=
o read bitmap alias string) are avoided.
> If the declaration has to stay where it is, is there a possibility that t=
he assignment fails?

I don=E2=80=99t understand what you mean.  A declaration without initializa=
tion
isn=E2=80=99t and doesn=E2=80=99t contain an expression, it isn=E2=80=99t e=
ven a statement, so
it has no side effects.[1]

Placing the declaration (without an initialization) at the top of the
block makes no semantic difference.

(As I said, I=E2=80=99d keep the assignment =E2=80=9Cbitmap_name =3D s->bit=
map_alias=E2=80=9D
where you put it.  I think it would technically actually be correct to
put it into the declaration at the start of the block as an initializer,
but that would look weird.)

Max

[1] I suppose exceptions apply for types with constructors, but those
don=E2=80=99t exist in plain C.


--syFb9lIOnh7aKeB6Cco0Ls51i7elfO6ay--

--9r5WyatiUIyroMZofYYsbgvBwERnwTNRj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl+GxnkACgkQ9AfbAGHV
z0BYbgf/Ys/ssEb9s1IzIpA3fJpzYsKYAVWZh7tP+Ufkth05t18zSMxUv18X8MHT
T8g8Uk0vu/FzMLrICac49KyemeO4APnksuw/tnOGNdZpBrjXcouoMBI9UhFdL2sl
zX8CqzUxMkwiZ83nzpUfJoI8SPGUuwh+E5L+77s67dT0gcVDPbkXT7Aa6d2/DnAH
WkwXK+RBPImoCcJu2130N2sGom2Ax5KxuH6s0vRkpy2+tZX+3Zqg20WJnTsauKkt
s9nNitaXynWDGRfmjShMK0zijG5/RA3Y+i6OxNqPziQxqrx2VqwUTeutilcvGevW
HdzerNCQcxPHGilY74mip6OIPApRdA==
=JtB3
-----END PGP SIGNATURE-----

--9r5WyatiUIyroMZofYYsbgvBwERnwTNRj--



Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF693C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:41:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98E02076A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 13:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heiwlz+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98E02076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHSlJ-0003q4-PU
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 09:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jHSkK-0002ZB-M9
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jHSkI-0001MD-Lq
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:40:31 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:32327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jHSkI-0001M5-Gd
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 09:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585230030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GLZ7PqgFvxS+irVlp+wgVpe9lcyYVzD57JdXVEPDbPc=;
 b=heiwlz+ko3WbmXzIDrkQ9C7KU7QCC69VkJpEEMkThzSNRPKx7N2I2bHdAy5/eU35hrn/++
 r8yBaMTtrWBa/CaSnbNc5DA9Je0/mrxdljDQ5QoP0o12B/tXkSl0ELCIgUkSpAx049ppGf
 Qf4K0L7aBJwqG3H2z2ylwsFo3WEHEsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-sLTU0pgQN5KkQDaUy6E12g-1; Thu, 26 Mar 2020 09:40:24 -0400
X-MC-Unique: sLTU0pgQN5KkQDaUy6E12g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80E00108592F;
 Thu, 26 Mar 2020 13:40:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-132.ams2.redhat.com
 [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 345BECFF6;
 Thu, 26 Mar 2020 13:40:00 +0000 (UTC)
Subject: Re: [PATCH 2/2] block: trickle down the fallback image creation
 function use to the block drivers
To: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200326011218.29230-1-mlevitsk@redhat.com>
 <20200326011218.29230-3-mlevitsk@redhat.com>
 <922a6eb5-cb33-d2e4-ba0b-15078d1a6c59@redhat.com>
 <20200326132828.GC7391@linux.fritz.box>
 <9004829c-45a4-584e-99b4-1dcf70950381@redhat.com>
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
Message-ID: <efa5cbae-8d92-13d3-f6f9-b4c043e5696f@redhat.com>
Date: Thu, 26 Mar 2020 14:39:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9004829c-45a4-584e-99b4-1dcf70950381@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QfUUScYBnxgIa2Cnm6HuZeWOBuGErPljM"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Fam Zheng <fam@euphon.net>, integration@gluster.org,
 sheepdog@lists.wpkg.org, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Liu Yuan <namei.unix@gmail.com>,
 Jason Dillaman <dillaman@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QfUUScYBnxgIa2Cnm6HuZeWOBuGErPljM
Content-Type: multipart/mixed; boundary="YcpvkZ1TJQWlUjG8b0X0i3S9pkJ7cdm0x"

--YcpvkZ1TJQWlUjG8b0X0i3S9pkJ7cdm0x
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.03.20 14:35, Eric Blake wrote:
> On 3/26/20 8:28 AM, Kevin Wolf wrote:
>> Am 26.03.2020 um 14:20 hat Eric Blake geschrieben:
>>>> +++ b/block/file-posix.c
>>>> @@ -3513,6 +3513,8 @@ static BlockDriver bdrv_host_device =3D {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_reopen_prepare =3D raw_reop=
en_prepare,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_reopen_commit=C2=A0 =3D raw=
_reopen_commit,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .bdrv_reopen_abort=C2=A0=C2=A0 =
=3D raw_reopen_abort,
>>>> +=C2=A0=C2=A0=C2=A0 .bdrv_co_create_opts =3D bdrv_co_create_opts_simpl=
e,
>>>> +=C2=A0=C2=A0=C2=A0 .create_opts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 =3D &bdrv_create_opts_simple,
>>>
>>> I'd drop the leading & for consistency with the rest of this struct
>>> initializer.
>>
>> This one isn't a function pointer, so I think the & is necessary.
>=20
> Ah, right. Visual pattern-matching failed me, since I didn't read the
> actual types in the .h file.
>=20
> Hmm - is it possible to write the patch in such a way that .create_opts
> can be left NULL when .bdrv_co_create_opts is bdrv_co_create_opts_simple?

Setting .create_opts is actually the main point of this series, so we
don=E2=80=99t have to look for and fix all places that decide whether a blo=
ck
driver is capable of image creation based on whether it=E2=80=99s set or no=
t.

Max


--YcpvkZ1TJQWlUjG8b0X0i3S9pkJ7cdm0x--

--QfUUScYBnxgIa2Cnm6HuZeWOBuGErPljM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl58sK8ACgkQ9AfbAGHV
z0Co0Af/XtamVYc+453Oh+hAZ6VXuohJYlGuYUbnAKIEesRmtUuNHqGwTAhmhxVH
HJ/JRvKYdcHm3jm0nPUSkoIdEJYIdwAN/e60khmrocqygPdloYCOEqVAmCgBLdxQ
6tF2bpVJw5182G+APpkXStll4w1wh1XmeLU1XqvqKDjUkVQQzfpUTiWydI3XY6Nv
W4JpVUxiE/d2C/t8+NNx89NQEp/T2ZC8olfwytvEqll4ieu8Iw+XY9LMN4kxb6vR
/I9wgifc1/cLY/ocW/MRVGI2kOi/ADWcjQYs8Hbne8RwOe9imvGyQeQ9qerdwx4P
bpAmYLpCGZ2ukc5w5PNUUeLwBNXNLw==
=xw2q
-----END PGP SIGNATURE-----

--QfUUScYBnxgIa2Cnm6HuZeWOBuGErPljM--



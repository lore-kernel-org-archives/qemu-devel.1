Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAE8C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E10217F4
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 17:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/NQPI73"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E10217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izObh-0006Wx-BI
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 12:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43013)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izORH-0005l6-SY
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:26:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izORG-0006rR-BT
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:26:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45792
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izORG-0006m0-5J
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 12:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580923569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TYIzQ9Aj6/qF/WGK60pQDS0noYeAphdljgBoVwnEAHw=;
 b=H/NQPI73qfrW8hAvYaekPnhlSTMy7v2LY9HCPylkZuPvRR3838MqSadHobUHhxBy0QCwEf
 4e0lD6ZPF9bm6z6tkS5Pkv+ZQoVWx3vaDCqhvcAzbCy8rN6P29msxB2e2DRgdvynBrl//q
 5C0kbHSGW7otWdCyQRbd0OyNQn3+L8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196--C2XXknhPYKAJK54Up_QDQ-1; Wed, 05 Feb 2020 12:26:05 -0500
X-MC-Unique: -C2XXknhPYKAJK54Up_QDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F69BA0CC0;
 Wed,  5 Feb 2020 17:26:04 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-184.ams2.redhat.com
 [10.36.117.184])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 80AC15C1B5;
 Wed,  5 Feb 2020 17:26:02 +0000 (UTC)
Subject: Re: [PATCH 10/17] block: Add new BDRV_ZERO_OPEN flag
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-11-eblake@redhat.com>
 <d4df9a48-6fb6-3432-3189-54bb7c7bb20c@redhat.com>
 <5c19c0fe-f8d0-5011-7cc6-4bb46a46cedf@redhat.com>
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
Message-ID: <d7fec044-95eb-03f5-1115-ac015cd0776c@redhat.com>
Date: Wed, 5 Feb 2020 18:26:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5c19c0fe-f8d0-5011-7cc6-4bb46a46cedf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="S3hRi2cz3HpiucKEEaNXqe1y2yHy1i0KZ"
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S3hRi2cz3HpiucKEEaNXqe1y2yHy1i0KZ
Content-Type: multipart/mixed; boundary="PjBg2Jdjo2Fd3gRvXxxpjulj5h7XmJ3rO"

--PjBg2Jdjo2Fd3gRvXxxpjulj5h7XmJ3rO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.02.20 18:50, Eric Blake wrote:
> On 2/4/20 11:34 AM, Max Reitz wrote:
>=20
>>> +++ b/include/block/block.h
>>> @@ -105,6 +105,16 @@ typedef enum {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for drivers that set .bdrv_co_tr=
uncate.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_ZERO_TRUNCATE=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 =3D 0x2,
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_known_zeroes() should include this bit=
 if an image is
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * known to read as all zeroes when first open=
ed; this bit should
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * not be relied on after any writes to the im=
age.
>>
>> Is there a good reason for this?=C2=A0 Because to me this screams like w=
e are
>> going to check this flag without ensuring that the image has actually
>> not been written to yet.=C2=A0 So if it=E2=80=99s generally easy for dri=
vers to stop
>> reporting this flag after a write, then maybe we should do so.
>=20
> In patch 15 (implementing things in qcow2), I actually wrote the driver
> to return live results, rather than just open-time results, in part
> because writing the bit to persistent storage in qcow2 means that the
> bit must be accurate, without relying on the block layer's help.
>=20
> But my pending NBD patch (not posted yet, but will be soon), the
> proposal I'm making for the NBD protocol itself is just open-time, not
> live, and so it would be more work than necessary to make the NBD driver
> report live results.
>=20
> But it seems like it should be easy enough to also patch the block layer
> itself to guarantee that callers of bdrv_known_zeroes() cannot see this
> bit set if the block layer has been used in any non-zero transaction, by
> repeating the same logic as used in qcow2 to kill the bit (any
> write/write_compressed/bdrv_copy clear the bit, any trim clears the bit
> if the driver does not guarantee trim reads as zero, any truncate clears
> the bit if the driver does not guarantee truncate reads as zero, etc).
> Basically, the block layer would cache the results of .bdrv_known_zeroes
> during .bdrv_co_open, bdrv_co_pwrite() and friends would update that
> cache, and and bdrv_known_zeroes() would report the cached value rather
> than a fresh call to .bdrv_known_zeroes.

Sounds reasonable to me in generaly, but I=E2=80=99d prefer it to be fetche=
d
on-demand rather than unconditionally in bdrv_open().

(I realize that this means a tri-state of =E2=80=9Cknown false=E2=80=9D, =
=E2=80=9Cknown true=E2=80=9D,
and =E2=80=9Cnot yet queried=E2=80=9D.)

> Are we worried enough about clients of this interface to make the block
> layer more robust?=C2=A0 (From the maintenance standpoint, the more the b=
lock
> layer guarantees, the easier it is to write code that uses the block
> layer; but there is the counter-argument that making the block layer
> track whether an image has been modified means a [slight] penalty to
> every write request to update the boolean.)

Just like Vladimir, I=E2=80=99m worried about repeating the same mistakes w=
e
have before: That is, most places that called bdrv_has_zero_init() just
did so out of wishful thinking, hoping that it would do what they need
it to.  It didn=E2=80=99t.

Max


--PjBg2Jdjo2Fd3gRvXxxpjulj5h7XmJ3rO--

--S3hRi2cz3HpiucKEEaNXqe1y2yHy1i0KZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl46+qgACgkQ9AfbAGHV
z0BAJgf8DWqwE9Ft51SdRC4ttZfHolMwqwLQ11CMIT2GaejyMWdf7yrdUdkWHLfs
yTGBLVXHjvWjUHDouu3XFhbBx4C56AzVOT122PkA+8WUWRBZmhwVhaN+2kE7Sgfn
nB2OIVsyDtpKk5GgberVxW3Jt8Fxw4jnr9RKXxZBeqqgKL+H3HxEzKk5nNBuyBz1
VTU868pqAbB4PS9SjElfYelKwkwyb8Z69eJRTan3MXkE0KJMOUyJiQkq4sEq/ifT
Witp+ZCSG6YZEMyGMemQiw1suTzVX9Oo9gnvnLBFSchL7Gl2y5XpfM4Wj1waqJgw
ADByaZKiDKX3q7sMPj+iA+/3dub1Rg==
=EOyf
-----END PGP SIGNATURE-----

--S3hRi2cz3HpiucKEEaNXqe1y2yHy1i0KZ--



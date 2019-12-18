Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2886C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB882176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NtyBFTP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB882176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihWOH-0003nX-M1
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihWNM-0003HW-Sw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihWNG-00045J-LK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:16:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35456
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihWNG-0003ug-5D
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576664168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/jwg6mRqXwWiAqRc47d/vi6JAnSL8VLE7nZ5j7K+fdk=;
 b=NtyBFTP96jlyvtfIqeENioE4UhNdQfeK+ovDhqV0OPgZctXtS90hef5ilaQCqGt54Dc94+
 /R669ScSQAkNjBtv5ZUyC19eJPlJEKKAzYYDbTHedfl+Kmy7QIl150WQ4s2hV7Km59pGoQ
 aKAPKS/CNL+UU/HL70p2fBbHsskGNNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-WRh56d9vMzmUOnVuurtY-Q-1; Wed, 18 Dec 2019 05:16:06 -0500
X-MC-Unique: WRh56d9vMzmUOnVuurtY-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6DC31800D42;
 Wed, 18 Dec 2019 10:16:05 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-177.brq.redhat.com
 [10.40.205.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F11368888;
 Wed, 18 Dec 2019 10:16:04 +0000 (UTC)
Subject: Re: [PATCH v2] blockjob: Fix error message for negative speed
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191217150458.10288-1-kwolf@redhat.com>
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
Message-ID: <1a9f9f82-f143-345c-2c52-89e4a212d20c@redhat.com>
Date: Wed, 18 Dec 2019 11:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191217150458.10288-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hl4sfTGi31qJGqaawFdYMieOJoH4CLH45"
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
Cc: berto@igalia.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hl4sfTGi31qJGqaawFdYMieOJoH4CLH45
Content-Type: multipart/mixed; boundary="T2iEY7z3lqAGa8qaRU0SzBafedO0bv1Bv"

--T2iEY7z3lqAGa8qaRU0SzBafedO0bv1Bv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.12.19 16:04, Kevin Wolf wrote:
> The error message for a negative speed uses QERR_INVALID_PARAMETER,
> which implies that the 'speed' option doesn't even exist:
>=20
>     {"error": {"class": "GenericError", "desc": "Invalid parameter 'speed=
'"}}
>=20
> Make it use QERR_INVALID_PARAMETER_VALUE instead:
>=20
>     {"error": {"class": "GenericError", "desc": "Parameter 'speed' expect=
s a non-negative value"}}
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>=20
> v2:
> - Update reference output for 030 [Max]
>=20
>  blockjob.c             | 3 ++-
>  tests/qemu-iotests/030 | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--T2iEY7z3lqAGa8qaRU0SzBafedO0bv1Bv--

--Hl4sfTGi31qJGqaawFdYMieOJoH4CLH45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl35/GIACgkQ9AfbAGHV
z0CRfwf/SPeLbpbmP5TI8qwi8qR2Ull/EXtGJg2eGo9aOj4aqi9KwkNsgx/OTdiW
TQsPKjHfnt+jyS6teqx3TRwwU8Zs3RnWeaS/0+Sf7EWTXGER4bBINkgg5X2AYEcO
StpmroZ/KRAqiZOCZUlCuDv6m3roRMXvsC5U+g3fjNgm8PzLzd2N8L14C+cRhnih
wG+8Lg0N7H3uHvTPYcfxzDcZqWD5FF+zzM4WriW/pqO7i5rGgzAfTcijuTUSjdVW
cl68Pb+/fi97pkIO+LKwHiyJdO803ShYQQVJgRkFpdiBbbo63HRFT2AX6uerlw0/
sUVDf+bd9g+liUWgKIV3Uj/Avv2luA==
=9mFO
-----END PGP SIGNATURE-----

--Hl4sfTGi31qJGqaawFdYMieOJoH4CLH45--



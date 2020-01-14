Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F420FC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:12:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C027724672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 12:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5I50pFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C027724672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irL41-0004oA-Qu
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 07:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1irL2x-0003i7-Kk
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:11:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1irL2s-0006LP-Nt
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:11:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1irL2s-0006L5-Is
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 07:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579003901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=C8naLsrXwYzeL1rwx6DdryF0QINzEfBpnF8gXzQUPho=;
 b=X5I50pFWccNhZW7TQJ5aPqzGkZCaY25YUXK4A6jgrDF0hLa0YhyfdMGSykaFiLhm22lWoI
 qLbB09NFVjJHQyI2bdo3jc4cZmpmz+ephuVAqICXJxXWTRK544dMuc7dNQIkuXVbrATVwM
 VjhXCpUezd5WGv4dg3gZttzPAWA9pUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-sTfQPPuwNv2uRh-bXzcsWQ-1; Tue, 14 Jan 2020 07:11:36 -0500
X-MC-Unique: sTfQPPuwNv2uRh-bXzcsWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39F08801E72;
 Tue, 14 Jan 2020 12:11:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C61882486;
 Tue, 14 Jan 2020 12:11:32 +0000 (UTC)
Subject: Re: [PATCH] block: Use a GString in bdrv_perm_names()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200110171518.22168-1-berto@igalia.com>
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
Message-ID: <b454fa42-7703-8ab4-8378-ec6e7c47fda6@redhat.com>
Date: Tue, 14 Jan 2020 13:11:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200110171518.22168-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C6inOvVK0Sqwmk2TrYPOrRfG9TTsBSw5G"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C6inOvVK0Sqwmk2TrYPOrRfG9TTsBSw5G
Content-Type: multipart/mixed; boundary="XVaayL0Jm7U0UY4NDHz2XK8xzUs8dZdQp"

--XVaayL0Jm7U0UY4NDHz2XK8xzUs8dZdQp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.01.20 18:15, Alberto Garcia wrote:
> This is a bit more efficient than having to allocate and free memory
> for each new permission.
>=20
> The default size (30) is enough for "consistent read, write, resize".
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--XVaayL0Jm7U0UY4NDHz2XK8xzUs8dZdQp--

--C6inOvVK0Sqwmk2TrYPOrRfG9TTsBSw5G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4dr/IACgkQ9AfbAGHV
z0DNtwgAt68DWUOUdiytobPi6s7I9eVfwsgfvLySGmeEwRurg0oMWA0RF4schp0l
84DOX17l+Dg6ZAYbE/MD8hzVP4D1+bK//o9KQ/M04rkV+C1zcMJRAyKqNS/qapEu
YQgOXOgvfy7CgDyXSHzYgtqlHBJNsJD3gbupvjNcKxAAEiakVtaHuF7O7Ybq0m3n
zGVlEm+XQVYM4eTAOeccjU2qjVdzZ/e9DkviWzgYvj/g0b76dXKNUiD7BRiMPyin
92+Gr1eb7u3PpBeZqOwU2rKrQmRqhAPZUc3dl1y7Jr7bnHi9qia401gUMpqkqrT2
/1MXmL0cVH8CYHDOs1qFepUjtshfHg==
=Jx86
-----END PGP SIGNATURE-----

--C6inOvVK0Sqwmk2TrYPOrRfG9TTsBSw5G--



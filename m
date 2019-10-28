Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC5FCA9EBE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39CA921479
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bK9QviXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39CA921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP2QV-0005mh-7T
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 06:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP2Nl-0001x6-L1
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP2Nh-0003Oi-J0
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:36:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP2Nd-0003NK-Nl
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572258969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G+vCLlx0fDHB7KbSrQjMe9VzeIgMb0X5byshvWFBOVU=;
 b=bK9QviXu18XBXBAc9yCZtSREVaq1rwLNS12kIUxbDJLkx9LAL+SpszV0+CC8Tr7b79gEF4
 2C+zlJjUZJx1rum63Bvfng1G/tEgstF2017ZKVo3pgdJJlt07QGB92021NsHj3/ZLS9xNf
 vM6eMFYP5dqfmbUKQhTtwP4lMSgX7kQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-8uqyUoiePcGWlYmm59wVKQ-1; Mon, 28 Oct 2019 06:36:06 -0400
X-MC-Unique: 8uqyUoiePcGWlYmm59wVKQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE8A9107AD28;
 Mon, 28 Oct 2019 10:36:05 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-83.ams2.redhat.com
 [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A2B060160;
 Mon, 28 Oct 2019 10:36:00 +0000 (UTC)
Subject: Re: [PATCH v2 0/2] block/nvme: add support for write zeros and discard
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190913133627.28450-1-mlevitsk@redhat.com>
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
Message-ID: <24390891-6aef-f457-7648-71846360a09c@redhat.com>
Date: Mon, 28 Oct 2019 11:35:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190913133627.28450-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rMZHpyiKVj3rLyrraWEHGG1l54I6Qbf4g"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rMZHpyiKVj3rLyrraWEHGG1l54I6Qbf4g
Content-Type: multipart/mixed; boundary="kDx9JBpfKsBAyobJ4PaWJKANKhMqvsO5r"

--kDx9JBpfKsBAyobJ4PaWJKANKhMqvsO5r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.09.19 15:36, Maxim Levitsky wrote:
> This is the second part of the patches I prepared
> for this driver back when I worked on mdev-nvme.
>=20
> V2: addressed review feedback, no major changes
>=20
> Best regards,
> =09Maxim Levitsky
>=20
> Maxim Levitsky (2):
>   block/nvme: add support for write zeros
>   block/nvme: add support for discard
>=20
>  block/nvme.c         | 155 ++++++++++++++++++++++++++++++++++++++++++-
>  block/trace-events   |   3 +
>  include/block/nvme.h |  19 +++++-
>  3 files changed, 175 insertions(+), 2 deletions(-)
Thanks, fixed the indentation in nvme.h in patch 1, and applied to my
block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

For the record, I don=E2=80=99t think !!x has benefits over x !=3D 0 and I
personally prefer bool y =3D x over any of it. O:-)

Max


--kDx9JBpfKsBAyobJ4PaWJKANKhMqvsO5r--

--rMZHpyiKVj3rLyrraWEHGG1l54I6Qbf4g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl22xI8ACgkQ9AfbAGHV
z0D5JwgAkrnRzWtT+O4tbiMH1Ko6pD6cYfZgGUR0otSjsX05EK5T5JT42QSc/7fX
NnmLAmBBbMy2hEUdENs41OiFkDbqUkrajMX+zp4y9tONe0VSqXZOxzyVBdf25iBz
Pvmf+gFZI7+xVAxCvOEbF+HFlOx+6ueh/22av2/vIZbZ8baMo0cCIhcQYuVpTap+
JoQkG+/cpGzO8PrTp29pdLonro2F+p43nbWw+B65/bZBfzRSGEbsY6KKLz8d3sZ1
L4/Ubkpah2jWlgzFNdeStCuuysVApaMCxpz0qTMgHO/NawDY1V+sHBz5xMH8Giwf
zIDamMF9G+CqKYgczWIbxGTxmcODFw==
=nXPV
-----END PGP SIGNATURE-----

--rMZHpyiKVj3rLyrraWEHGG1l54I6Qbf4g--



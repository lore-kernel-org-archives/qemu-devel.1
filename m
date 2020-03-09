Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01AC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14FE20873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYiRuI7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14FE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNNc-0005WD-4z
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 14:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBNLM-0001KL-Gm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBNLK-0005cj-7G
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:41:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27004
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBNLK-0005cG-1U
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583779293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=50jRe+T8gQDQbQHEFx3kwniF5R8BYW+MnbRPgmCZNA4=;
 b=cYiRuI7EP/YZ3kl0jjx1/e3Ght0zMWXQWcvqCQfOIbgzU9osVqmmOaXpzKy1n8wuU+gtQ0
 9kRYB5/8CXlZqmEya47WZAlz/WfNLjuX4cvNm+nYsBcXGtwRO12dcjk+v+1Mc2wIlXoC/V
 sRMVFWIj0uOmFwbtOUWRzUeVzDgMXY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-Mq8B4VlNPYa9fCol4wiI3A-1; Mon, 09 Mar 2020 14:41:28 -0400
X-MC-Unique: Mq8B4VlNPYa9fCol4wiI3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 85D38800D4E;
 Mon,  9 Mar 2020 18:41:27 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-119.ams2.redhat.com
 [10.36.116.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AADC73879;
 Mon,  9 Mar 2020 18:41:26 +0000 (UTC)
Subject: Re: [PATCH] block/qcow2-threads: fix qcow2_decompress
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200302150930.16218-1-vsementsov@virtuozzo.com>
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
Message-ID: <2e6ec8a6-6b37-a39f-c6e2-94cc180076fa@redhat.com>
Date: Mon, 9 Mar 2020 19:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302150930.16218-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OBG4HWbcAzf1Ksfzww7jBEs7TedeRDZjs"
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
Cc: kwolf@redhat.com, dplotnikov@virtuozzo.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OBG4HWbcAzf1Ksfzww7jBEs7TedeRDZjs
Content-Type: multipart/mixed; boundary="GdiA1qzbRIDJKFDr33a0GKu2692CtKMxj"

--GdiA1qzbRIDJKFDr33a0GKu2692CtKMxj
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.03.20 16:09, Vladimir Sementsov-Ogievskiy wrote:
> On success path we return what inflate() returns instead of 0. And it
> most probably works for Z_STREAM_END as it is positive, but is
> definitely broken for Z_BUF_ERROR.
>=20
> While being here, switch to errno return code, to be closer to
> qcow2_compress API (and usual expectations).
>=20
> Revert condition in if to be more positive. Drop dead initialization of
> ret.
>=20
> Cc: qemu-stable@nongnu.org # v4.0
> Fixes: 341926ab83e2b
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi!
>=20
> Reviewing Den's series about zstd in qcow2 support, I found an existing
> bug. Let's fix it. This is to be a new base of zstd series.
>=20
>  block/qcow2-threads.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--GdiA1qzbRIDJKFDr33a0GKu2692CtKMxj--

--OBG4HWbcAzf1Ksfzww7jBEs7TedeRDZjs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5mjdQACgkQ9AfbAGHV
z0BeiwgAo1QTtlXBxgQhM9Q+qmIITtbsYJr1Y7GBhPrLAdTjym/f1VEkKvdId98w
Z+VYRR7Rw/KIbH7W4rKqYY5e4D+cnUXm5JaHdg7S55vPB73UFH04MSBVwLW54aBQ
uAjHASprltd82SHuTcbnU26BBYHxOf0lYbkqmL0twAZ4RaEtlDLa+LiFuhpIKOfn
098UcBysCMyOLfT+kwSN0jugWapxhWJDNtHYqhtbi/jC+e0qejZhw3wqrcUNoZvW
kUHbZeAp8LtEfPQQS0KIeQK26zYODm9qeAAO0GlvcYgpnE/UAn/gBWmIUWYSTeMO
jd2KDHvZmyhKnRYNR/X3UM8GUbX5SA==
=K99e
-----END PGP SIGNATURE-----

--OBG4HWbcAzf1Ksfzww7jBEs7TedeRDZjs--



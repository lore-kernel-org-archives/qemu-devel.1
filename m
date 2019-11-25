Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD24C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:29:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A422082F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 12:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hA3A/v1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A422082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZDUS-0007tW-67
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 07:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZDQL-0003zr-Po
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:25:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZDQK-0001gq-Pd
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:25:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZDQK-0001fs-Jx
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 07:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574684699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rSDu+lQO6hqd6BI3z4HG0NCrKMgqEfLDf0Mywtin4+Y=;
 b=hA3A/v1Df1qtEtMVhwGiy+x1jsX4VQ0H+RrQLPtIccbSGoUXoeE12ZB21Pxmk8of3K6Yiz
 764qGKW2YG0Qjruplf/MvSESOr8/UlWQfhowkBgdwF46OJ9sZj31XEwvaco89J7N80dx3E
 95BxJ//cuLOsfnrNIyZULsaJO6uD79Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-R_Z6XmYKOHG8HndefJZklw-1; Mon, 25 Nov 2019 07:24:58 -0500
X-MC-Unique: R_Z6XmYKOHG8HndefJZklw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A9A3107ACE5;
 Mon, 25 Nov 2019 12:24:57 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 019C85D9CA;
 Mon, 25 Nov 2019 12:24:52 +0000 (UTC)
Subject: Re: [PATCH for-4.2? v3 0/8] block: Fix resize (extending) of short
 overlays
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20191122160511.8377-1-kwolf@redhat.com>
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
Message-ID: <67c2abd7-26a3-eef6-0fc7-d8901d031248@redhat.com>
Date: Mon, 25 Nov 2019 13:24:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191122160511.8377-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T5gWw7VS2Se6B77u3GjIK1CZAGn9lWXqa"
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
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T5gWw7VS2Se6B77u3GjIK1CZAGn9lWXqa
Content-Type: multipart/mixed; boundary="vwfnoqsKN8mw4BYxKQin039BEysxgZeu1"

--vwfnoqsKN8mw4BYxKQin039BEysxgZeu1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.11.19 17:05, Kevin Wolf wrote:
> See patch 4 for the description of the bug fixed.
>=20
> v3:
> - Don't allow blocking the monitor for a zero write in block_resize
>   (even though we can already blockfor other reasons there). This is
>   mainly responsible for the increased complexity compared to v2.
>   Personally, I think this is not an improvement over v2, but if this is
>   what it takes to fix a corruption issue in 4.2... [Max]

I don=E2=80=99t find it so bad because the added complexity is:

(1) A mainly mechanical change of code to add another parameter to
{blk,bdrv}(_co)?_truncate(),

(2) qcow2 providing BDRV_REQ_NO_FALLBACK, and

(3) passing BDRV_REQ_NO_FALLBACK in bdrv_co_truncate() if the new
parameter is true.

(1) sees the most LoC changed, but it isn=E2=80=99t a complex change.  (2) =
and
(3) are both basically one-line changes each.


OTOH, as I=E2=80=99ve said on IRC, I believe you have a sufficient number o=
f
R-bs on v2 to take it without mine, so the choice is yours.

Max


--vwfnoqsKN8mw4BYxKQin039BEysxgZeu1--

--T5gWw7VS2Se6B77u3GjIK1CZAGn9lWXqa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3byBMACgkQ9AfbAGHV
z0BVjwf/cuTSaNgrXEsqC8yeE49UE9zUaklXWfiXMLM2gg91FhfaeyIhwwV9uN6z
3Yoca/W6VCDexDdUOdC0L5dCoM8cuI4i6b1e5L0xtn7m5qak5p/EQ1sR2t+n8dwT
IulQdGg/yy8ZstAmTdv/rGqenLuZkpCIp6pv9+Nj8UlbLwLntINkL70r/6fZf/6O
OZO9SIlb+eLZOPThkjqt8cYx2N3xkjEFcAlZt0U49jHpNRaobaIDtsZR2eC47k6A
1u16lG4GK/sl41dk5nPiLIvDV+tTkmTmJEKVV4PIB6SfJvtipiqC7ruNy6I+dzq2
jvO2amNX7+pYMxsv1T6x8JMa4CtIbQ==
=h3mM
-----END PGP SIGNATURE-----

--T5gWw7VS2Se6B77u3GjIK1CZAGn9lWXqa--



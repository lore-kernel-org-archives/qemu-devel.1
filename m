Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15132C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDBB20678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 14:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GlVzAnSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDBB20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZyh8-0002Zg-S7
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 09:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZyg3-0001xh-UI
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZyg1-0001UD-JL
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:52:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33455
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZyg1-0001Tl-9T
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 09:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574866340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZN/zLexfrkLE2XioJylb0lkceoRoP34Y1nhxRqJDQqg=;
 b=GlVzAnSwA8rP7EFFWbkiG7WyNzC1G24oB5BxJuZMN0DJwpIEXDDhjwDob5PgAV70S9l5NC
 jJhQw5FNQ81H6QGSK2e+ghJ7QyOVl1Tzy8xL0+kXcSoYr2AfwZdEJQCqlm9dT+GQ4gNzH2
 6pAiHD5RY3nRcow7x3NDRYu3eG2VSXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-_y9fDFLoMzu1O5mWkwGC2w-1; Wed, 27 Nov 2019 09:52:18 -0500
X-MC-Unique: _y9fDFLoMzu1O5mWkwGC2w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41870DB60;
 Wed, 27 Nov 2019 14:52:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-186.brq.redhat.com
 [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 168445C219;
 Wed, 27 Nov 2019 14:52:14 +0000 (UTC)
Subject: Re: [PATCH v9 2/3] qcow2: Allow writing compressed data of multiple
 clusters
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1574779398-88772-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1574779398-88772-3-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <430c1050-9a21-cb56-f9d7-366d01741862@redhat.com>
Date: Wed, 27 Nov 2019 15:52:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1574779398-88772-3-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QqzCItrSQ7sChwo7piJqFMIOvMn7IEDYE"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QqzCItrSQ7sChwo7piJqFMIOvMn7IEDYE
Content-Type: multipart/mixed; boundary="baWpTxwoK9smEFmHMP1LHSoZOLuYbwQhZ"

--baWpTxwoK9smEFmHMP1LHSoZOLuYbwQhZ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.11.19 15:43, Andrey Shinkevich wrote:
> QEMU currently supports writing compressed data of the size equal to
> one cluster. This patch allows writing QCOW2 compressed data that
> exceed one cluster. Now, we split buffered data into separate clusters
> and write them compressed using the block/aio_task API.
>=20
> Suggested-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.c | 102 ++++++++++++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 75 insertions(+), 27 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--baWpTxwoK9smEFmHMP1LHSoZOLuYbwQhZ--

--QqzCItrSQ7sChwo7piJqFMIOvMn7IEDYE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3ejZ0ACgkQ9AfbAGHV
z0DILwgAi5su6SWUJwfqWbIRI7T1oIKxAICCzwAIs+tikMOcGfxZ7ds8xozHmDDl
TnsX1Br7eVCYJnMm2eekWBN9e7FojMn+4SZccKcxhgKp8wNLOyA+cUmL8joqMGU3
XkgS2KRvLx5UO4KMpqMJAeWiElqPwzXMRzeMdTVDQ9mysLMKwH8w//juUBN7B+t+
x/EApilIpVHT7ho0bsJRWGTL2moq7/1LvXiAOwTsCy+M9lqkTK41pbvNdn91i6rA
TVDCGiyGJtrzFS92hZX1me/R2hvv7aoTd3OHnAIFkBctNhFIKUFW1VuqxS2+xS3D
2FZ6T41+MWcaBm5UxiZICLJmm/ThOw==
=14Yu
-----END PGP SIGNATURE-----

--QqzCItrSQ7sChwo7piJqFMIOvMn7IEDYE--



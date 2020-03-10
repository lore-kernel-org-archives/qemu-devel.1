Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A92C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D943B20675
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 13:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jN1lLioe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D943B20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBf0Q-0005Ip-3G
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 09:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51785)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBezc-0004E6-VU
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:32:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBezb-0006oM-TQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:32:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36116
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBezb-0006mK-Nb
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 09:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583847139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pA86EmBBIHLKbsW+oK8S2/1sCRBNqoQwSZNEL2blloU=;
 b=jN1lLioeB8CEfkCwkhur4kmoJML/EVeGbzTbpwmDZ4ZwrK+0+Ztdm6XNLFunuyaIVfHjjB
 /mzg9FoK+FoE31sjK/V+oViq6vACNocLBfwvkn23jbZmDyCqBTx7A5j2IegZ++b2yVIqH0
 B7Wvv6g2K/T0++lSXMSHCYG3iR5OGSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-8t1RHRFFNuum6zscn4BuMg-1; Tue, 10 Mar 2020 09:32:15 -0400
X-MC-Unique: 8t1RHRFFNuum6zscn4BuMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CF4385EE6D;
 Tue, 10 Mar 2020 13:32:14 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACD669182B;
 Tue, 10 Mar 2020 13:32:11 +0000 (UTC)
Subject: Re: [PATCH v3 2/9] block/block-copy: fix progress calculation
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200306073831.7737-1-vsementsov@virtuozzo.com>
 <20200306073831.7737-3-vsementsov@virtuozzo.com>
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
Message-ID: <395858d9-43d4-89a0-d877-bb4ce29b473e@redhat.com>
Date: Tue, 10 Mar 2020 14:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306073831.7737-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wAQst935oY1td9s5MylSPi9YarJyltLwM"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kwolf@redhat.com, andrey.shinkevich@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wAQst935oY1td9s5MylSPi9YarJyltLwM
Content-Type: multipart/mixed; boundary="RcC7g4UuKX8cRc31ubobghVTnMPV4G0F2"

--RcC7g4UuKX8cRc31ubobghVTnMPV4G0F2
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.03.20 08:38, Vladimir Sementsov-Ogievskiy wrote:
> Assume we have two regions, A and B, and region B is in-flight now,
> region A is not yet touched, but it is unallocated and should be
> skipped.
>=20
> Correspondingly, as progress we have
>=20
>   total =3D A + B
>   current =3D 0
>=20
> If we reset unallocated region A and call progress_reset_callback,
> it will calculate 0 bytes dirty in the bitmap and call
> job_progress_set_remaining, which will set
>=20
>    total =3D current + 0 =3D 0 + 0 =3D 0
>=20
> So, B bytes are actually removed from total accounting. When job
> finishes we'll have
>=20
>    total =3D 0
>    current =3D B
>=20
> , which doesn't sound good.
>=20
> This is because we didn't considered in-flight bytes, actually when
> calculating remaining, we should have set (in_flight + dirty_bytes)
> as remaining, not only dirty_bytes.
>=20
> To fix it, let's refactor progress calculation, moving it to block-copy
> itself instead of fixing callback. And, of course, track in_flight
> bytes count.
>=20
> We still have to keep one callback, to maintain backup job bytes_read
> calculation, but it will go on soon, when we turn the whole backup
> process into one block_copy call.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>  include/block/block-copy.h | 14 +++++---------
>  block/backup.c             | 13 ++-----------
>  block/block-copy.c         | 16 ++++++++++++----
>  3 files changed, 19 insertions(+), 24 deletions(-)

Looks good, but I suppose we should also drop the
ProgressResetCallbackFunc type.

Max


--RcC7g4UuKX8cRc31ubobghVTnMPV4G0F2--

--wAQst935oY1td9s5MylSPi9YarJyltLwM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5nltkACgkQ9AfbAGHV
z0AD1gf9H7fLxiZdWTDS4pOk9LNFvgkTkA3hBwBXpHfw/KcLKV7VrXWt1HCynYfb
qHtdBaIvkkI3asO95JBYDkqluqSiNsQnXI5c8YW2K0VkxjiapfaxzoqJ357n3XV9
E7XW0xOnpeS3HZougKKbDP/YmAfB/8u6QJ2kzTCntlYiaDK9FUWNsJYi4CKhqU2a
h6N3lbSm60Ot4KujCW70NWlA7SEIivLt3iqh3M+J/rLAqwvHIA5iLN5Kknri5c4u
vJw030XboZawCe7WEz2V5lPvDe7X3tVaikMkbXfU3PUV2IvRM4I2WrT2j5QLLyZd
PDgJ+4j550IJqD8QYStES12nHdsfzQ==
=C2jb
-----END PGP SIGNATURE-----

--wAQst935oY1td9s5MylSPi9YarJyltLwM--



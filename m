Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EFFC2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:15:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EE8206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPdZI+ou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EE8206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkKo-0003xD-UR
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLjxW-0008Q1-KB
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLjxV-0005SO-K0
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:51:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLjxU-0005QL-PZ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 04:51:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586249507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0hKmzRVqh/4WqpasGKcRyF6tHYccbxoP48KfV2VqzDw=;
 b=PPdZI+ou/FAw+sxCrax19uYM9z3cRFUhGA07GBng7wtUuBdfHRrdBf9gTMPTdR31wrkadZ
 CH1NeSgvMjVtHXtuVh4F6Z9R/VmM+Zx++LUSSW1m715uOQoDWqvUpA0BpuJmnA9y0N9YRI
 Zgc7qIf1ZxzX2ibESKRBgmUANpLz4SE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-o4A41G8aPcmwWGj4r3WM1Q-1; Tue, 07 Apr 2020 04:51:39 -0400
X-MC-Unique: o4A41G8aPcmwWGj4r3WM1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31071107ACC4;
 Tue,  7 Apr 2020 08:51:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-84.ams2.redhat.com
 [10.36.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 067535DA7B;
 Tue,  7 Apr 2020 08:51:34 +0000 (UTC)
Subject: Re: [PATCH v2] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200406143401.26854-1-berto@igalia.com>
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
Message-ID: <e9415dbd-8c08-89b9-a29f-9c570010a4cc@redhat.com>
Date: Tue, 7 Apr 2020 10:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200406143401.26854-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SWGyy8NOMswpb2OHEosFFO0hlRCtNu3Kj"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Pavel Butsykin <pbutsykin@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SWGyy8NOMswpb2OHEosFFO0hlRCtNu3Kj
Content-Type: multipart/mixed; boundary="x0vgbSKwXG3rA0q4sfJBxfTcBeI9FeKVc"

--x0vgbSKwXG3rA0q4sfJBxfTcBeI9FeKVc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.04.20 16:34, Alberto Garcia wrote:
> When issuing a compressed write request the number of bytes must be a
> multiple of the cluster size or reach the end of the last cluster.
>=20
> With the current code such requests are allowed and we hit an
> assertion:
>=20
>    $ qemu-img create -f qcow2 img.qcow2 1M
>    $ qemu-io -c 'write -c 0 32k' img.qcow2
>=20
>    qemu-io: block/qcow2.c:4257: qcow2_co_pwritev_compressed_task:
>    Assertion `bytes =3D=3D s->cluster_size || (bytes < s->cluster_size &&
>               (offset + bytes =3D=3D bs->total_sectors << BDRV_SECTOR_BIT=
S))' failed.
>    Aborted
>=20
> This patch fixes a regression introduced in 0d483dce38
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--x0vgbSKwXG3rA0q4sfJBxfTcBeI9FeKVc--

--SWGyy8NOMswpb2OHEosFFO0hlRCtNu3Kj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6MPxQACgkQ9AfbAGHV
z0DqRQf7B5uCLJ991/Yulm0NS6ORq6AluSOnDXgQOyGlrPzlPN+uhAZVm+8/4v9x
EUQ9sOHW1xUg0y1tMRKmBvpKyiO5mh0iXet4SGdSaAy/jHJ8z8nrCXwZlGcYnA2s
bCPv11l/cIjN58Kuuoxb0I5RmdM9Vj81kMKYtwEL58xlBMJhPHOWTIYZped7DwcA
SCU16ukpVyKBcq+PPqoyX31e2clVOjt0fg7bwZ6ok0+EWP0JKoUE22prmFAkLUM4
JhM7idczyq2KJBqP8X7EIioWU1fzdadKH6bMxkRJJfwSlnGkpd2nWtYCshS3+A2c
bcm/a0OAVuJHcavX3GE1rq+scN9WAw==
=lzL5
-----END PGP SIGNATURE-----

--SWGyy8NOMswpb2OHEosFFO0hlRCtNu3Kj--



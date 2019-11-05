Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DAEC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0CAC2087E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 16:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+FpeCIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CAC2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS1el-0006BN-1j
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 11:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iS1dX-0005QY-O4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iS1dT-0004AW-Pp
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:24:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34445
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iS1dT-00049u-EC
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 11:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572971090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IxiHw2JCILLkQqEpKeEgb0kARpK4d4xZ7uvZoywTrgA=;
 b=L+FpeCIrJcmYtYRO6sMH9DskwFSpOIxOlJnicJ66+jhaP8rNjkfOB2ZwvwTnncmJ4POHBj
 /5c4zJdvyGOUkyCZx0oZECrSR60XvsOkbSyBWhRy46LJcWUVGpS+f5VFuaTRYCxkv3ekIv
 w2gIUJe+8jBULk3zdYc0frRzNdZzcFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-RFvyEzBNPROMOciTmcd1Nw-1; Tue, 05 Nov 2019 11:24:45 -0500
X-MC-Unique: RFvyEzBNPROMOciTmcd1Nw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6672A1800D53;
 Tue,  5 Nov 2019 16:24:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-89.ams2.redhat.com
 [10.36.117.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 00E485D713;
 Tue,  5 Nov 2019 16:24:39 +0000 (UTC)
Subject: Re: [PATCH v4] qcow2-bitmap: Fix uint64_t left-shift overflow
To: Tuguoyi <tu.guoyi@h3c.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <4ba40cd1e7ee4a708b40899952e49f22@h3c.com>
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
Message-ID: <47cf7ed6-e2ad-251a-8fcd-8049ced04108@redhat.com>
Date: Tue, 5 Nov 2019 17:24:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4ba40cd1e7ee4a708b40899952e49f22@h3c.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QbnIXk3fPryRpRpTcuCeb9ljKzxYHVnz8"
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
Cc: Chengchiwen <chengchiwen@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 Wangyongqing <w_yongqing@h3c.com>, Changlimin <changlimin@h3c.com>,
 Gaoliang <liang_gao@h3c.com>, Wangyong <wang.yongD@h3c.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QbnIXk3fPryRpRpTcuCeb9ljKzxYHVnz8
Content-Type: multipart/mixed; boundary="Duktvpx9ypwmxAFCH5hwLzUB6LowSk6jf"

--Duktvpx9ypwmxAFCH5hwLzUB6LowSk6jf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 08:37, Tuguoyi wrote:
> There are two issues in In check_constraints_on_bitmap(),
> 1) The sanity check on the granularity will cause uint64_t
> integer left-shift overflow when cluster_size is 2M and the
> granularity is BIGGER than 32K.
> 2) The way to calculate image size that the maximum bitmap
> supported can map to is a bit incorrect.
> This patch fix it by add a helper function to calculate the
> number of bytes needed by a normal bitmap in image and compare
> it to the maximum bitmap bytes supported by qemu.
>=20
> Fixes: 5f72826e7fc62167cf3a
> Signed-off-by: Guoyi Tu <tu.guoyi@h3c.com>
> ---
>  block/qcow2-bitmap.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--Duktvpx9ypwmxAFCH5hwLzUB6LowSk6jf--

--QbnIXk3fPryRpRpTcuCeb9ljKzxYHVnz8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3BokUACgkQ9AfbAGHV
z0BYcAgAgmGePfLGkQASWOUubh0Y2EnDplu6AdHAIw9239G9+ecow18LjMEhCCK2
l/6PmL2zmS0QM1SHUHdCOphYKsXQQc9zZVIpiGj2QbcwDERCBvRavwgXtf0ib40A
xSxpjuXFCkEKSqJnSW41M+eQ0JTUAdvX5bVMmoP/KYMMQlheJoc1qqAJSPiRuRgs
wRv7sNUNczWuqOIBmK0JwTtQWe6W2NKCBKHQKeeY2Xs7Eh3S8ZfMV4I+OwkCxuyf
9Jj2ZCFpresqIxpxkkzjC1AWNVX853Ejx5+TDnKoWKyaxkWHC/Icid2X99oqP9ZW
JI2i9evy0A92vpLcQXJWT8OXuvmHxg==
=b7Nw
-----END PGP SIGNATURE-----

--QbnIXk3fPryRpRpTcuCeb9ljKzxYHVnz8--



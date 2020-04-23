Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65934C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE1520724
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoLWxrsa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE1520724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRYk6-0003Va-84
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 06:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRYj7-0002P0-B5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jRYj6-0006uY-T2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:05:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29961
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jRYj6-0006rx-H4
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587636299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8RAxOQcGQl6I8ob4sceLl/V4ekpCoViaLxszbKdqe0c=;
 b=hoLWxrsaMgh9nbbycwjS6oE5FKC8nAdgIBTxz435h/1ITsGWmXUv6P9B6hMVS+Kiv72yQ2
 wlx8uTBR8ykfSo7F4TpMCK60LQWBJ9X9QZY3XTCy0QNntvtsK5INjsTAqNlaxupVLYY+XS
 LqEh3xXPVNzuDwLOm89lEXXouka/zqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-N_-og-7GMAeEC3NWxApuuQ-1; Thu, 23 Apr 2020 06:04:55 -0400
X-MC-Unique: N_-og-7GMAeEC3NWxApuuQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C717B80B713;
 Thu, 23 Apr 2020 10:04:53 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B29565C1BE;
 Thu, 23 Apr 2020 10:04:51 +0000 (UTC)
Subject: Re: [PATCH v5 2/9] block: Add flags to bdrv(_co)_truncate()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200422152129.167074-1-kwolf@redhat.com>
 <20200422152129.167074-3-kwolf@redhat.com>
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
Message-ID: <c2b0728d-f5cd-fc60-dbd5-08ce1674a5d9@redhat.com>
Date: Thu, 23 Apr 2020 12:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422152129.167074-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0HeOfQio9DyrQXBmCuQINFOqvqLn1cC7I"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: berto@igalia.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0HeOfQio9DyrQXBmCuQINFOqvqLn1cC7I
Content-Type: multipart/mixed; boundary="n8UTS9hkRnXmBC0l5z8O4B47c0Zkdgl8W"

--n8UTS9hkRnXmBC0l5z8O4B47c0Zkdgl8W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.04.20 17:21, Kevin Wolf wrote:
> Now that block drivers can support flags for .bdrv_co_truncate, expose
> the parameter in the node level interfaces bdrv_co_truncate() and
> bdrv_truncate().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  include/block/block.h       |  5 +++--
>  block/block-backend.c       |  2 +-
>  block/crypto.c              |  2 +-
>  block/io.c                  | 12 +++++++-----
>  block/parallels.c           |  6 +++---
>  block/qcow.c                |  4 ++--
>  block/qcow2-refcount.c      |  2 +-
>  block/qcow2.c               | 15 +++++++++------
>  block/raw-format.c          |  2 +-
>  block/vhdx-log.c            |  2 +-
>  block/vhdx.c                |  2 +-
>  block/vmdk.c                |  2 +-
>  tests/test-block-iothread.c |  6 +++---
>  13 files changed, 34 insertions(+), 28 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--n8UTS9hkRnXmBC0l5z8O4B47c0Zkdgl8W--

--0HeOfQio9DyrQXBmCuQINFOqvqLn1cC7I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6haEEACgkQ9AfbAGHV
z0CVmAf/bP70USjSEV9GAwHv/ktN6Ds40xZTTRrvUQxWHGtbrG0ebgLUHLvinl8M
oEcUVlWQXUfKTwbn1M9u4xXsxJMJGieZQClFBehHTpetcSZB0cvVUp6zJHwAswnn
hx1bjFDbs6dOU3Sof7CZR+73/WfqniFsfpyjhO14e2ahgwGUh5Zn+W9CU4c3dYzO
m0IUhSclxi1ZZr5ssk5uM4bmqhRF3j2+ZN/Bl4jj9eTwWoVRxO0kU60N+SMECYg/
vRbRo4tbcHF/Lr5ogs79eChW3z8oTHo7NIdqx4SACLGDNiHInDKMCveGAk7BzC7v
huDp98OPM9woqRLudWhfEJ9XFH4d/w==
=Hrhp
-----END PGP SIGNATURE-----

--0HeOfQio9DyrQXBmCuQINFOqvqLn1cC7I--



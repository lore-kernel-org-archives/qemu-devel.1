Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFA9C00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B56520692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP4gMcrM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B56520692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLyh-0006WY-Dl
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:33:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ieLxd-0005lG-9n
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:32:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ieLxc-00047R-7R
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:32:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21932
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ieLxc-00047J-2Y
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:32:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575909155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2ZylJ2lpIos/+unDmmnSXuFumwd0nhZ8to3fTUCz+38=;
 b=CP4gMcrM2KBDGBbfGfkBcEqUOBZKxLMHuUfn54zuPCxmRpzNoV0FrEXnMK1x9OFOSeOSR+
 EncIxABZca2DQI1VjYGgYIju75wzSh8uSdxGS4f7w/N+LJ3jZYPPO7P70UxDSOVX3zcppY
 Mcgvaj5jpJBcpCz4fvMwmhjUfl/emRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-aRU2bjnHO2qSf1gXQ35R_g-1; Mon, 09 Dec 2019 11:32:33 -0500
X-MC-Unique: aRU2bjnHO2qSf1gXQ35R_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C102E1097AE8;
 Mon,  9 Dec 2019 16:32:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F254C5DA60;
 Mon,  9 Dec 2019 16:32:26 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] qcow2-bitmaps: fix qcow2_can_store_new_dirty_bitmap
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191014115126.15360-1-vsementsov@virtuozzo.com>
 <20191014115126.15360-2-vsementsov@virtuozzo.com>
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
Message-ID: <8c47bc33-4300-ddff-c07e-0ffbc0fd0a4f@redhat.com>
Date: Mon, 9 Dec 2019 17:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191014115126.15360-2-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8wrSZTuqjEGHlALNf9xJJkf5p8twZCz9h"
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8wrSZTuqjEGHlALNf9xJJkf5p8twZCz9h
Content-Type: multipart/mixed; boundary="exqDO3O5Y00RoBAr931qdRgRZgVXtfZ4k"

--exqDO3O5Y00RoBAr931qdRgRZgVXtfZ4k
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.10.19 13:51, Vladimir Sementsov-Ogievskiy wrote:
> qcow2_can_store_new_dirty_bitmap works wrong, as it considers only
> bitmaps already stored in the qcow2 image and ignores persistent
> BdrvDirtyBitmap objects.
>=20
> So, let's instead count persistent BdrvDirtyBitmaps. We load all qcow2
> bitmaps on open, so there should not be any bitmap in the image for
> which we don't have BdrvDirtyBitmaps version. If it is - it's a kind of
> corruption, and no reason to check for corruptions here (open() and
> close() are better places for it).
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 41 ++++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 23 deletions(-)

Thanks, applied to my block-next branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

Max


--exqDO3O5Y00RoBAr931qdRgRZgVXtfZ4k--

--8wrSZTuqjEGHlALNf9xJJkf5p8twZCz9h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3udxgACgkQ9AfbAGHV
z0CjgQf9G4TFE6u4fdsICC+UZTO0LdpY8PJM+EHEuYZlRGuyZGNGGKwVh840U/3A
NBuI8trQlmo+ieyhcGscUlmiYsyag9XbTKTOyJ5UKXSlon9yjm7UMmGeXw5337To
mlS8ahg15XxOY2QP37n9wLGCIUXHDuTFOWl21SnUt99gBlWS74eDxWEAzCjyXBCd
3jyWR9/+FfUeSWKEXp06sSDTl3go9JCpUzCp0IdW7mQCyeKtg8nmqPw7ocyLqx0q
pmYOFakaPXw3+FryX80XPMTZx21fEJoJAjIUIjJ/FxISwi7UMbXjs5a5BroGV/qx
H5kspx+/RhCU4DTBWThOExQ2QAvPBA==
=/FPA
-----END PGP SIGNATURE-----

--8wrSZTuqjEGHlALNf9xJJkf5p8twZCz9h--



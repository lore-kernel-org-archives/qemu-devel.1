Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823ADCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:03:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 132F6222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 132F6222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLUio-0005um-F6
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iLUXd-0001XE-Cu
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iLUXb-0005XI-Qq
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 11:51:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iLUXY-0005UY-VF; Fri, 18 Oct 2019 11:51:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 337A7862E;
 Fri, 18 Oct 2019 15:51:44 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A8C75D9CA;
 Fri, 18 Oct 2019 15:51:38 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] block/mirror: support unaligned write in active
 mirror
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191011090711.19940-1-vsementsov@virtuozzo.com>
 <20191011090711.19940-5-vsementsov@virtuozzo.com>
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
Message-ID: <676ed62d-6aba-f655-2a56-13b0652e7229@redhat.com>
Date: Fri, 18 Oct 2019 17:51:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191011090711.19940-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="87o18NaFVW7pwLHFDd6TdY7dMnnP8wKMY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 18 Oct 2019 15:51:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: fam@euphon.net, kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--87o18NaFVW7pwLHFDd6TdY7dMnnP8wKMY
Content-Type: multipart/mixed; boundary="xBoHyglF77WJl69U2lJrKl6jkfNidJifP"

--xBoHyglF77WJl69U2lJrKl6jkfNidJifP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.10.19 11:07, Vladimir Sementsov-Ogievskiy wrote:
> Prior 9adc1cb49af8d do_sync_target_write had a bug: it reset aligned-up=

> region in the dirty bitmap, which means that we may not copy some bytes=

> and assume them copied, which actually leads to producing corrupted
> target.
>=20
> So 9adc1cb49af8d forced dirty bitmap granularity to be
> request_alignment for mirror-top filter, so we are not working with
> unaligned requests. However forcing large alignment obviously decreases=

> performance of unaligned requests.
>=20
> This commit provides another solution for the problem: if unaligned
> padding is already dirty, we can safely ignore it, as
> 1. It's dirty, it will be copied by mirror_iteration anyway
> 2. It's dirty, so skipping it now we don't increase dirtiness of the
>    bitmap and therefore don't damage "synchronicity" of the
>    write-blocking mirror.
>=20
> If unaligned padding is not dirty, we just write it, no reason to touch=

> dirty bitmap if we succeed (on failure we'll set the whole region
> ofcourse, but we loss "synchronicity" on failure anyway).
>=20
> Note: we need to disable dirty_bitmap, otherwise we will not be able to=

> see in do_sync_target_write bitmap state before current operation. We
> may of course check dirty bitmap before the operation in
> bdrv_mirror_top_do_write and remember it, but we don't need active
> dirty bitmap for write-blocking mirror anyway.
>=20
> New code-path is unused until the following commit reverts
> 9adc1cb49af8d.
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/mirror.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++---=

>  1 file changed, 68 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--xBoHyglF77WJl69U2lJrKl6jkfNidJifP--

--87o18NaFVW7pwLHFDd6TdY7dMnnP8wKMY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2p34kACgkQ9AfbAGHV
z0BZIAgAhjs/2R7lRvicJGfg/2SJcncQGljfDhfBiRsu+MZXW1fnmQNKsYpeb8fZ
gb+LTiv5HzvOBVBqca138qd3k28VcU8/lz0rNrKQD4AEYHEq2RcnoJLf3GOAqfa8
ATMaI2AUMkZh/zPl8iV8Zd4oIlSbn/3LEsfho5sptL8nKqnBeBgHVqY5cAKV9O3d
5SLjaKIO6O1/Z6+qV0hlodc2xjPrYgbwdCUku4jutexP7W3yfVujU8eUg8G+cC9H
3nf0RA4Pj3TcJJKPPx4HKp0RV7RlAC8QMx5Ru7sjk+DHPp41x4ScxOi1wsj/cMPI
qN6RKgyx1J9jkuh9+A1Ueh9Ov4SGvQ==
=K4nr
-----END PGP SIGNATURE-----

--87o18NaFVW7pwLHFDd6TdY7dMnnP8wKMY--


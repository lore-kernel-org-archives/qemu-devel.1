Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0865C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90784214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJwv1rvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90784214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izk5A-0002Qb-N8
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1izk3q-0001EL-Go
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1izk3p-0006zy-6V
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:31:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27343
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1izk3p-0006vk-1H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581006684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ULKPhXR2zpVy4/vWPYYf4H8ssQJMv+iygCjzXuEqBHc=;
 b=IJwv1rvY2VNBkveTivAEQDpmUIwnISRUgMyArbebCNrlwszHgbI+bv7KMnQb5J7PpOS56F
 MTAMdlua7GSuOrqO2Hj1HSBzL/QaBtZ1qWX/a/kdT8lvkp22OPIZhSrpuyyGY7sC2TiyRH
 Uq/rcIlPFcpIIQ/e5g5z+d9sJI+OM9c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-r6EWybwAMs6rlajw3qogxA-1; Thu, 06 Feb 2020 11:31:21 -0500
X-MC-Unique: r6EWybwAMs6rlajw3qogxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A4CB1109ACB;
 Thu,  6 Feb 2020 16:31:20 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA0581001B08;
 Thu,  6 Feb 2020 16:31:18 +0000 (UTC)
Subject: Re: [PATCH v2] block/backup-top: fix flags handling
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200203134213.2173-1-vsementsov@virtuozzo.com>
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
Message-ID: <05f70af6-83f9-c51f-74f3-bbbe4675e411@redhat.com>
Date: Thu, 6 Feb 2020 17:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203134213.2173-1-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sOXKmwybsgcPS3uMpVsRuTVv2iVR1ww4d"
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sOXKmwybsgcPS3uMpVsRuTVv2iVR1ww4d
Content-Type: multipart/mixed; boundary="9i52NQUgfLRlQo8wkzFngqDGUxBwPgYnK"

--9i52NQUgfLRlQo8wkzFngqDGUxBwPgYnK
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.02.20 14:42, Vladimir Sementsov-Ogievskiy wrote:
> backup-top "supports" write-unchanged, by skipping CBW operation in
> backup_top_co_pwritev. But it forgets to do the same in
> backup_top_co_pwrite_zeroes, as well as declare support for
> BDRV_REQ_WRITE_UNCHANGED.
>=20
> Fix this, and, while being here, declare also support for flags
> supported by source child.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> v2: restrict flags propagation like it is done in other filters [Eric]
>     move state variable initialization to the top
>=20
>  block/backup-top.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/backup-top.c b/block/backup-top.c
> index 9aed2eb4c0..a4cec60859 100644
> --- a/block/backup-top.c
> +++ b/block/backup-top.c


[...]

> @@ -186,17 +190,21 @@ BlockDriverState *bdrv_backup_top_append(BlockDrive=
rState *source,
>                                           Error **errp)
>  {
>      Error *local_err =3D NULL;
> -    BDRVBackupTopState *state;
>      BlockDriverState *top =3D bdrv_new_open_driver(&bdrv_backup_top_filt=
er,
>                                                   filter_node_name,
>                                                   BDRV_O_RDWR, errp);
> +    BDRVBackupTopState *state =3D top->opaque;
> =20
>      if (!top) {
>          return NULL;
>      }

If top can be NULL, then we shouldn=92t dereference it before (with
state =3D top->opaque).

(Pulling up the initialization of @state is also unrelated to this
patch, I don=92t exactly know why you=92re doing it here.)

Max


--9i52NQUgfLRlQo8wkzFngqDGUxBwPgYnK--

--sOXKmwybsgcPS3uMpVsRuTVv2iVR1ww4d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl48P1UACgkQ9AfbAGHV
z0Akdgf/fPEWGs2DCl4AZsi5v4wtDipdQNQaGlf4vhDkEkT7BXu+fLQ+ffV4JtJm
/WpPFWsXXlq5yAdSDxyaf6i8dUbILhvsD/JHZpiZAACp11qsI+Su+JBStccb3mJz
ZjS0FmC8CZDdDMiDGYhepYoYOqlzla5jO5foGkNepVWQUpZNcPEZ3ksCK+abTuQ/
U5Kx7A0e45Ev3HDux5S1fjeEwaV/VoPyY0X8rKV8D28VjDQC7KSECZlrIAD85EJu
FSVEkxyNVIwSn2yCYHgYP/WF1X9Q7WlsWtwFsa9m0CbHYFJ9MpzzZSqjPq/GSeUx
ZGguWoYc5d/y7bxkP8NnYv1EF8yXDQ==
=XwSy
-----END PGP SIGNATURE-----

--sOXKmwybsgcPS3uMpVsRuTVv2iVR1ww4d--



Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC345C5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:22:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4B420650
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 11:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6gKIeH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4B420650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSJO3-00069Q-Se
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 06:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33809)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSJLU-0003oo-H9
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSJLT-0002a6-8X
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:19:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37470
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSJLT-0002Zq-4U
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 06:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573039166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6i8DcCgQAYfnM+Fal9rqBDiLybMZJzTnRQ0O9DvtOV4=;
 b=U6gKIeH+88/jptdPsz+1M+rzwvA0SSxKP18IFs4x5bwu2tXfp7cyyonEQMJw9HZzy8zBOG
 d7SOYLfwwVD7sMdoycyxu/jQqYhdeN9k7D6q5+dOpj5hoPz/L5ukGRrfrJvqjOz7ONg5J+
 dAsoV2WoQpW6AN9Rmtl1z9vpS97cGRY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-KV_D30hKM5awPYT076auAw-1; Wed, 06 Nov 2019 06:19:22 -0500
X-MC-Unique: KV_D30hKM5awPYT076auAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95873800C72;
 Wed,  6 Nov 2019 11:19:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-212.ams2.redhat.com
 [10.36.117.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3303E1001B11;
 Wed,  6 Nov 2019 11:19:19 +0000 (UTC)
Subject: Re: [PATCH for-4.2 0/2] qcow2: Fix QCOW2_COMPRESSED_SECTOR_MASK
To: qemu-block@nongnu.org
References: <20191028161841.1198-1-mreitz@redhat.com>
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
Message-ID: <dc66ebe6-8e33-ce74-c408-7a57ee4f8331@redhat.com>
Date: Wed, 6 Nov 2019 12:19:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191028161841.1198-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bxPw3VamvcoNZg45dteOUcMzszIDWExZj"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bxPw3VamvcoNZg45dteOUcMzszIDWExZj
Content-Type: multipart/mixed; boundary="C7YEtU5woa5YU36Ww0XM5Xc0R7y57A1Fe"

--C7YEtU5woa5YU36Ww0XM5Xc0R7y57A1Fe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.10.19 17:18, Max Reitz wrote:
> This fixes a bug reported on
> https://bugs.launchpad.net/qemu/+bug/1850000.  The problem is that
> QCOW2_COMPRESSED_SECTOR_MASK is a 32-bit mask when it really needs to be
> a 64-bit mask.
>=20
> The launchpad report mentions only problems with qemu-img check on large
> compressed images, but I think it might extend further than that:
> - I suppose qcow2_free_any_clusters() would free every compressed offset
>   modulo 4G, which isn=E2=80=99t good
> - qcow2_update_snapshot_refcount() will probably update compressed
>   cluster=E2=80=99s refcounts (in snapshots) modulo 4G, which also isn=E2=
=80=99t good
> - And then we have check_refcount_l2() which updates the wrong clusters
>   for qemu-img check (as demonstrated in the bug report)
>=20
> - (qcow2_co_preadv_compressed() is safe because it uses the inverted
>   mask, which of course is again just 32 bit)
>=20
>=20
> But I haven=E2=80=99t tested those other cases.
>=20
>=20
> Max Reitz (2):
>   qcow2: Fix QCOW2_COMPRESSED_SECTOR_MASK
>   iotests: Add test for 4G+ compressed qcow2 write
>=20
>  block/qcow2.h              |  2 +-
>  tests/qemu-iotests/272     | 79 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/272.out | 10 +++++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 91 insertions(+), 1 deletion(-)
>  create mode 100755 tests/qemu-iotests/272
>  create mode 100644 tests/qemu-iotests/272.out

Thanks for the review, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--C7YEtU5woa5YU36Ww0XM5Xc0R7y57A1Fe--

--bxPw3VamvcoNZg45dteOUcMzszIDWExZj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3CrDUACgkQ9AfbAGHV
z0CI5ggAkFpusBNDyh3ZWTfWQNBNRtMNwhIigKP9JJzxpsQQgCa44NDRLiCqrMfH
EKQWXoJRUF0EnYSQpLXNCRAQfZgDiuEP+3Oc5r/zw43rVuS+t/ZgOyiRiQfK/5iS
WAkaOSGgQLQS20J3BD394WRIufSNMtgeqw9/wU0Bwpwz+UG7qhQkR+cW6r1dLhHs
YlBvbVcWq0dkv9/xuPmVIR+gVrg2Z6lTefRsRUrXFns/rLW5hCbvy/lVUZKIkIWb
+4vVOq+TIZCbc0KRXJALe5GiHobFwSQw+JGwG2TvUB4GVGxE8KCUGKYAsPl0+FQ4
PVh8wa/DEn6DL7SdP35lYFdVOFSYKQ==
=q/On
-----END PGP SIGNATURE-----

--bxPw3VamvcoNZg45dteOUcMzszIDWExZj--



Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744BACA9EBC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DBFA20650
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AS4Nv917"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBFA20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP2hY-0003A4-EH
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 06:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP2gE-0001w1-32
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP2gC-0003ij-SS
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:55:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38448
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP2gC-0003iW-Ob
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572260120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=gNOCa3nYpanzpqqlvfvQ+5bNSridXK2jUHs49eFfX1o=;
 b=AS4Nv917LiXQd4SKqfbQ3censOG4SpExq5m/GtLqeVvwg+LPyCjJEGiKbMTldKIV27hi+8
 m2TbY/0phzViRfnn3x4r5Lb6jDHPUL/XOQyHgbRH01yX1FI0I41neEt29mBmDdN+sZ+rVw
 vDKyvtbWI6CUOWL5eSXnsped+RMCAP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-b4vHBF3OMPGU-AMuX_L0yA-1; Mon, 28 Oct 2019 06:55:12 -0400
X-MC-Unique: b4vHBF3OMPGU-AMuX_L0yA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C58AF80183E;
 Mon, 28 Oct 2019 10:55:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-83.ams2.redhat.com
 [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BADD85D6A9;
 Mon, 28 Oct 2019 10:55:10 +0000 (UTC)
Subject: Re: [PATCH v3 00/16] qcow2: Let check -r all repair some snapshot bits
To: qemu-block@nongnu.org
References: <20191011152814.14791-1-mreitz@redhat.com>
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
Message-ID: <5ebf7590-0627-970a-5023-507f5b4569e6@redhat.com>
Date: Mon, 28 Oct 2019 11:55:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191011152814.14791-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SJwcF0Qlb6mPFzutH8XJvx883hDmQZ1fG"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SJwcF0Qlb6mPFzutH8XJvx883hDmQZ1fG
Content-Type: multipart/mixed; boundary="EBPpbx4c6GSQbepnCxGQgL8fphYu4jlWG"

--EBPpbx4c6GSQbepnCxGQgL8fphYu4jlWG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.10.19 17:27, Max Reitz wrote:
> Hi,
>=20
> The v1 cover letter explained this series=E2=80=99s purpose:
> https://lists.nongnu.org/archive/html/qemu-block/2019-07/msg01290.html
>=20
> The v2 cover letter explained the v2 changes:
> https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00921.html
>=20
>=20
> The only changes in v3 are:
> - Patches 12 and 13: Added notes to the commit messages why it=E2=80=99s =
OK to
>                      not let the user choose which snapshots to drop
>=20
> (I wanted to also address Eric=E2=80=99s idea of letting
> QCowSnapshot.extra_data_size be always >=3D sizeof(QCowSnapshotExtraData)
> and thus save the MAX(sizeof(extra), sn->extra_data_size) in
> qcow2_write_snapshots(), but that doesn=E2=80=99t really work, because th=
en we
> have no way of knowing later whether the image is compliant and thus
> needs fixing or not.  He gave me an R-b anyway, so I guess it=E2=80=99s f=
ine.
> O:-))
>=20
> This series now has R-bs from Eric on all patches.  I=E2=80=99m only post=
ing it
> because I felt a bit bad about just taking the series as-is and add the
> commit notes to 12 and 13 while applying it.
> (Also, maybe there is someone who saw me have a bit of discussion with
> Eric and thus assumed I would definitely send a v3 that they could then
> review.)
>=20
>=20
> Max Reitz (16):
>   include: Move endof() up from hw/virtio/virtio.h
>   qcow2: Use endof()
>   qcow2: Add Error ** to qcow2_read_snapshots()
>   qcow2: Keep unknown extra snapshot data
>   qcow2: Make qcow2_write_snapshots() public
>   qcow2: Put qcow2_upgrade() into its own function
>   qcow2: Write v3-compliant snapshot list on upgrade
>   qcow2: Separate qcow2_check_read_snapshot_table()
>   qcow2: Add qcow2_check_fix_snapshot_table()
>   qcow2: Fix broken snapshot table entries
>   qcow2: Keep track of the snapshot table length
>   qcow2: Fix overly long snapshot tables
>   qcow2: Repair snapshot table with too many entries
>   qcow2: Fix v3 snapshot table entry compliancy
>   iotests: Add peek_file* functions
>   iotests: Test qcow2's snapshot table handling
>=20
>  block/qcow2.h                |  15 +-
>  include/hw/virtio/virtio.h   |   7 -
>  include/qemu/compiler.h      |   7 +
>  block/qcow2-snapshot.c       | 323 +++++++++++++++++++--
>  block/qcow2.c                | 155 +++++++++--
>  hw/block/virtio-blk.c        |   4 +-
>  hw/net/virtio-net.c          |  10 +-
>  tests/qemu-iotests/261       | 523 +++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/261.out   | 346 +++++++++++++++++++++++
>  tests/qemu-iotests/common.rc |  20 ++
>  tests/qemu-iotests/group     |   1 +
>  11 files changed, 1354 insertions(+), 57 deletions(-)
>  create mode 100755 tests/qemu-iotests/261
>  create mode 100644 tests/qemu-iotests/261.out

Thanks for the review, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--EBPpbx4c6GSQbepnCxGQgL8fphYu4jlWG--

--SJwcF0Qlb6mPFzutH8XJvx883hDmQZ1fG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl22yQ0ACgkQ9AfbAGHV
z0CKaQgApYYsynsE17r4T7wDPb4b7ZSjVCgeQB9Spt/74iuknldbw3jLYouyUjsX
UYEAJVOuoMfTG+wvXvxX1mXwMlB+TFp36IytrXTPcAMmtvuysM00L62hzjRbskTE
Mh/6rh0qdOYUCHI+Esp6DSJWJCEbs/m5rbiql2j09PRQ8BHhy0tV49cf3/yeBUZK
qILyPXdvNSyQTnqfNCYMLWHjC6px3D+tmyAwyR8AO5l6Vrg5eQlKMhJ4HVaukrZY
Zttdn+yLQ5fffps2iyNZBnd6lcxTJ9c7Tthz6VpA1Eia8r/V+HU+8IJzBGS4lELA
zWGGCVqLtaJteZDMZ6Q0X/Rl1yPqqQ==
=JT2Y
-----END PGP SIGNATURE-----

--SJwcF0Qlb6mPFzutH8XJvx883hDmQZ1fG--



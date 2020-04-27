Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29335C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BE820575
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 12:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXUkgUaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BE820575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT32Q-0000H0-0z
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 08:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jT2zU-0003ff-HJ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jT2zQ-00038m-1c
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:36:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jT2zP-00038W-Il
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 08:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587990958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bKLPsyL72nwR9C5WlYsnavHxoDTDMdFLWy1AVIQ8Z4A=;
 b=ZXUkgUaLcUIL/JTB3oQLwkgxrRIzoXX433p/vtsmW3nFRkOhhWJucD1CN3lur8QrPH6Rt4
 aoGTaNGm45Fy+7nhgkePPiKaE418K6Z3AlKYDFV3mgGh9SfJbxxOqvHz0jt1dOzjFHej3/
 lBI/DqlyZd3cTWKp6txHq8gmXhFPYSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-YRtQIH9cMui_fujsL62tCw-1; Mon, 27 Apr 2020 08:35:54 -0400
X-MC-Unique: YRtQIH9cMui_fujsL62tCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D4D71009440;
 Mon, 27 Apr 2020 12:35:52 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-29.ams2.redhat.com
 [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E561860300;
 Mon, 27 Apr 2020 12:35:49 +0000 (UTC)
Subject: Re: [PATCH v20 1/4] qcow2: introduce compression type feature
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200421081117.7595-1-dplotnikov@virtuozzo.com>
 <20200421081117.7595-2-dplotnikov@virtuozzo.com>
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
Message-ID: <23b98997-c506-9e35-8208-3373e2da49bb@redhat.com>
Date: Mon, 27 Apr 2020 14:35:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421081117.7595-2-dplotnikov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NJfx1v4S4IaZ1OuSklEQnzqrOS5Ib4OoO"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 02:05:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NJfx1v4S4IaZ1OuSklEQnzqrOS5Ib4OoO
Content-Type: multipart/mixed; boundary="g3MhVOXyvprDBx2ioTeb7VPn2MIIf2hGs"

--g3MhVOXyvprDBx2ioTeb7VPn2MIIf2hGs
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.04.20 10:11, Denis Plotnikov wrote:
> The patch adds some preparation parts for incompatible compression type
> feature to qcow2 allowing the use different compression methods for
> image clusters (de)compressing.
>=20
> It is implied that the compression type is set on the image creation and
> can be changed only later by image conversion, thus compression type
> defines the only compression algorithm used for the image, and thus,
> for all image clusters.
>=20
> The goal of the feature is to add support of other compression methods
> to qcow2. For example, ZSTD which is more effective on compression than Z=
LIB.
>=20
> The default compression is ZLIB. Images created with ZLIB compression typ=
e
> are backward compatible with older qemu versions.
>=20
> Adding of the compression type breaks a number of tests because now the
> compression type is reported on image creation and there are some changes
> in the qcow2 header in size and offsets.
>=20
> The tests are fixed in the following ways:
>     * filter out compression_type for many tests
>     * fix header size, feature table size and backing file offset
>       affected tests: 031, 036, 061, 080
>       header_size +=3D8: 1 byte compression type
>                        7 bytes padding
>       feature_table +=3D 48: incompatible feature compression type
>       backing_file_offset +=3D 56 (8 + 48 -> header_change + feature_tabl=
e_change)
>     * add "compression type" for test output matching when it isn't filte=
red
>       affected tests: 049, 060, 061, 065, 144, 182, 242, 255
>=20
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/block-core.json             |  22 +++++-
>  block/qcow2.h                    |  20 +++++-
>  include/block/block_int.h        |   1 +
>  block/qcow2.c                    | 113 +++++++++++++++++++++++++++++++
>  tests/qemu-iotests/031.out       |  14 ++--
>  tests/qemu-iotests/036.out       |   4 +-
>  tests/qemu-iotests/049.out       | 102 ++++++++++++++--------------
>  tests/qemu-iotests/060.out       |   1 +
>  tests/qemu-iotests/061.out       |  34 ++++++----
>  tests/qemu-iotests/065           |  28 +++++---
>  tests/qemu-iotests/080           |   2 +-
>  tests/qemu-iotests/144.out       |   4 +-
>  tests/qemu-iotests/182.out       |   2 +-
>  tests/qemu-iotests/242.out       |   5 ++
>  tests/qemu-iotests/255.out       |   8 +--
>  tests/qemu-iotests/common.filter |   3 +-
>  16 files changed, 267 insertions(+), 96 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--g3MhVOXyvprDBx2ioTeb7VPn2MIIf2hGs--

--NJfx1v4S4IaZ1OuSklEQnzqrOS5Ib4OoO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6m0aMACgkQ9AfbAGHV
z0DzmggAjBuybFsQAb8cJjtOzRxO0eLwrHrGL2JZZYEBS5QTAgbhmqznhFuLrura
o6LrNtwa2P2Ls69NaFXBWoYQQmfkorxE/ZR/fmyB2jyFbIWIxASBxg66QgGu2dbQ
GwL6do6L/Tes9hvtOE9sf/WFQFVZIeZ9mskdfOKzMyBc1ZrmzRBq8W2EXU1Ceahj
qeFmBvo1WY5BNcz0bm4V0uMsXs/yOp5peUlzfVlxpdqAGeoMkeMJ+Rwb0QIRI0nG
O5QsSFm15DBak1DVkwoIQ2zwNd5dvcg2vxykjbgT1iVzyBLV6yGTby2OyyoUNb79
dxvh6Ccohf46uYLiI9krQsmA09KEMQ==
=loQr
-----END PGP SIGNATURE-----

--NJfx1v4S4IaZ1OuSklEQnzqrOS5Ib4OoO--



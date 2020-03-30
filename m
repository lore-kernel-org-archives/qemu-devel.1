Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179F2C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DC6206E6
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 10:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZR2gvZS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DC6206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIrIz-0001BW-0k
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 06:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jIrIG-0000gQ-ED
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jIrIF-0005Qm-2n
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:05:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:28361)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jIrIE-0005QQ-VM
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 06:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585562718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=r+jHRfKtJw2/TFzdXkdLiqhhr52K/eH/Zxia8Ily9b0=;
 b=ZR2gvZS3wnAlwVCzHOZPefk6o2V/YtBzpRT8Jl90yMnLrCJmZWSh3Wc+dvW+zq3WG3hhFx
 w9lopAylWmb9YY4n8BKzM5VUrj5byMSIyUOHdsAwkVn57py55rddQk1acEV0gWmqC+6kmO
 1oO76MvhSBOYCFoqe/7OTLPAPHIs4U8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-DH7SwklqPO6kWLsL18Lceg-1; Mon, 30 Mar 2020 06:05:10 -0400
X-MC-Unique: DH7SwklqPO6kWLsL18Lceg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8585ADB20;
 Mon, 30 Mar 2020 10:05:09 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-93.ams2.redhat.com
 [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1E6219925;
 Mon, 30 Mar 2020 10:05:05 +0000 (UTC)
Subject: Re: [PATCH v4] qcow2: Forbid discard in qcow2 v2 images with backing
 files
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200327185930.19493-1-berto@igalia.com>
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
Message-ID: <81e31d93-8bd6-476b-ff92-080da8a2cd67@redhat.com>
Date: Mon, 30 Mar 2020 12:05:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327185930.19493-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rQFnKquS4irUhbkqjPWBkbVcaB8Dj5guh"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rQFnKquS4irUhbkqjPWBkbVcaB8Dj5guh
Content-Type: multipart/mixed; boundary="7rWjHRDAWQiQh5cy4mYVBO3Q2lYs00eoe"

--7rWjHRDAWQiQh5cy4mYVBO3Q2lYs00eoe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.03.20 19:59, Alberto Garcia wrote:
> A discard request deallocates the selected clusters so they read back
> as zeroes. This is done by clearing the cluster offset field and
> setting QCOW_OFLAG_ZERO in the L2 entry.
>=20
> This flag is however only supported when qcow_version >=3D 3. In older
> images the cluster is simply deallocated, exposing any possible stale
> data from the backing file.
>=20
> Since discard is an advisory operation it's safer to simply forbid it
> in this scenario.
>=20
> Note that we are adding this check to qcow2_co_pdiscard() and not to
> qcow2_cluster_discard() or discard_in_l2_slice() because the last
> two are also used by qcow2_snapshot_create() to discard the clusters
> used by the VM state. In this case there's no risk of exposing stale
> data to the guest and we really want that the clusters are always
> discarded.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
> v4:
> - Show output of qemu-img map when there's no backing file [Eric]
>=20
> v3:
> - Rebase and change iotest number
> - Show output of qemu-img map in iotest 290 [Kevin]
> - Use the l2_offset and rb_offset variables in iotest 060
>=20
> v2:
>=20
> - Don't create the image with compat=3D0.10 in iotest 060 [Max]
> - Use $TEST_IMG.base for the backing image name in iotest 289 [Max]
> - Add list of unsupported options to iotest 289 [Max]
>=20
>  block/qcow2.c              |  6 +++
>  tests/qemu-iotests/060     | 12 ++---
>  tests/qemu-iotests/060.out |  2 -
>  tests/qemu-iotests/290     | 97 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/290.out | 61 ++++++++++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  6 files changed, 170 insertions(+), 9 deletions(-)
>  create mode 100755 tests/qemu-iotests/290
>  create mode 100644 tests/qemu-iotests/290.out

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--7rWjHRDAWQiQh5cy4mYVBO3Q2lYs00eoe--

--rQFnKquS4irUhbkqjPWBkbVcaB8Dj5guh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6BxE8ACgkQ9AfbAGHV
z0Ag2Af9HiCaluxDv8xE/lrjm0FgAJDJcM3UMcw0wcVaI4Kugt7NICYsWKaC6nJ6
OH5h6A7OSguz5wcZU2Xeup+5VcDpoTJabYnmUVrvHwNwMQgC6cvv6coMazm0pHz6
XDSu2OaKg5qbir6McLYlmOePkgIVMSVVeysTuqXWGBOgGKsDfrKjLR0bmDVG+SUE
EtGdTLj3cn+a3MuHZtZlug75T8Op3aTRR4wztL3PXXKH5vMbqwEPsO4SVcI6sCVb
m/NjgnXwr53NltmuhNTEtQAn1PbEz+xFiWA4ZGaONLzEUjxnfrQ9QfOOs10r9UJu
8qeczkkHCLkSIC3jkcHldQsNkq0FeA==
=TI+h
-----END PGP SIGNATURE-----

--rQFnKquS4irUhbkqjPWBkbVcaB8Dj5guh--



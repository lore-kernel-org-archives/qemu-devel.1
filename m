Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1CCC17461
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4812521928
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTbzAzo2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4812521928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRyd6-0004eG-Cn
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 08:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRycN-0003zh-QM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRycL-0001hk-Fl
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:11:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRycL-0001hF-BN
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:11:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572959489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JZvfDUzm5g8DYX00NBKbrUkJQj9rhc7XeTvgKfIIMiI=;
 b=BTbzAzo25mH8TZV6G/fRe1/hP6c0886ffw+IIrpZTGDURwfhDGhRIjWL2ksGV2eIW44qHW
 UPP6F7Dxtcr1knj+11xl5FXUcMZLosX6Qf3FjY1S1R5Ei/MQPTFda5wbCpvC7c5+WmIYxB
 syXuZLApzG+PqQ7ELeY+kZtNPZAAkOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-zwr5c94OP0meoj_xL3hUYA-1; Tue, 05 Nov 2019 08:11:25 -0500
X-MC-Unique: zwr5c94OP0meoj_xL3hUYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00405107ACC3;
 Tue,  5 Nov 2019 13:11:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-89.ams2.redhat.com
 [10.36.117.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3258F60E1C;
 Tue,  5 Nov 2019 13:11:20 +0000 (UTC)
Subject: Re: [RFC PATCH v2 25/26] qcow2: Allow preallocation and backing files
 if extended_l2 is set
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <3b868557f35fbdbc9cc8d962c23be4d2daa9c2b2.1572125022.git.berto@igalia.com>
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
Message-ID: <45b56a21-fd23-93eb-710e-3cc2d5e434f3@redhat.com>
Date: Tue, 5 Nov 2019 14:11:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3b868557f35fbdbc9cc8d962c23be4d2daa9c2b2.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wganPhNsDhct39YRJXmLrDJjs9j0O2IZj"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wganPhNsDhct39YRJXmLrDJjs9j0O2IZj
Content-Type: multipart/mixed; boundary="YTDdy9eHYWoP6GPOmYmuQKPFIFMM36Lgr"

--YTDdy9eHYWoP6GPOmYmuQKPFIFMM36Lgr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> Traditional qcow2 images don't allow preallocation if a backing file
> is set. This is because once a cluster is allocated there is no way to
> tell that its data should be read from the backing file.
>=20
> Extended L2 entries have individual allocation bits for each
> subcluster, and therefore it is perfectly possible to have an
> allocated cluster with all its subclusters unallocated.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c              | 7 ++++---
>  tests/qemu-iotests/206.out | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)

But it doesn=E2=80=99t work, because qcow2_alloc_cluster_offset() always
allocates the whole cluster, so the backing file content isn=E2=80=99t visi=
ble:

$ ./qemu-img create -f qcow2 base.qcow2 64M
Formatting 'base.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65536
lazy_refcounts=3Doff extended_l2=3Doff refcount_bits=3D16

$ ./qemu-io -c 'write -P 42 0 64M' base.qcow2
wrote 67108864/67108864 bytes at offset 0
64 MiB, 1 ops; 00.21 sec (307.344 MiB/sec and 4.8022 ops/sec)

$ ./qemu-img create -f qcow2 -o preallocation=3Dmetadata,extended_l2=3Don \
    top.qcow2
Formatting 'top.qcow2', fmt=3Dqcow2 size=3D67108864 backing_file=3Dbase.qco=
w2
cluster_size=3D65536 preallocation=3Dmetadata lazy_refcounts=3Doff
extended_l2=3Don refcount_bits=3D16

$ ./qemu-io -c 'read -P 42 0 64M' top.qcow2
Pattern verification failed at offset 0, 67108864 bytes
read 67108864/67108864 bytes at offset 0
64 MiB, 1 ops; 00.03 sec (2.498 GiB/sec and 39.9725 ops/sec)

Max


--YTDdy9eHYWoP6GPOmYmuQKPFIFMM36Lgr--

--wganPhNsDhct39YRJXmLrDJjs9j0O2IZj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3BdPYACgkQ9AfbAGHV
z0BWGQgAvg1Z+3W6rf1VUY7cGFgAL6f+bHfVD7kEi5iT0sWHr2hEz/rbgn4QfVQG
1SSAX0M3QAZ2qpRR0PT5IyLGhBSU0Wcrg9K7PK1MIYbkJqL8q/ypUpRbo7L+jcy4
+iT+h1Qg3LQopysgzOfw796l0tpLPjA8NUztGwlknhqkOh7GOqNVpzVCD7kC5bi7
brn1ctlwLudewwcpG39MuJdXHY8l07biNasoRRIHklf6npRkoQM0gKLeAlbbSayu
IwUA1J72Y3fxoEKaXn3kXTmoWpXZSBo7nZfB/l4qYpn1vnAlNRimz9opzhzueFQm
RBwmxKdqL1eDr1skcU6R8h7R8Fp85g==
=jauX
-----END PGP SIGNATURE-----

--wganPhNsDhct39YRJXmLrDJjs9j0O2IZj--



Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDD8C04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BE3622314
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HUOHE3Mi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BE3622314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05Wh-00026Y-HT
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j05VI-0000JY-2g
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:25:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j05VG-0007cy-Ao
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:25:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j05VG-0007cR-5i
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 10:25:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581089109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sq6RHk94YvTpDMctH+V6sLPOFC6jfsuFCUXhzrfro+E=;
 b=HUOHE3Mi2GYnYsh3QPePYoY3AP8WpsqLxQ0GLLpOUJoru154nL35pxj2IMatQQSqYX/Tl5
 d/ikL1tdLNR/HOtjGCnEQ6fMX94LHB+f2FXSQwID9hbjJkaz/DBtwT/6O3Q5CML5RISsoH
 8R28WNJjoo+JdUJPgN4la6fzXHJC1mY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-cAitCftbNXWiC7j8ZODw-w-1; Fri, 07 Feb 2020 10:25:01 -0500
X-MC-Unique: cAitCftbNXWiC7j8ZODw-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 537D4DB62;
 Fri,  7 Feb 2020 15:25:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-14.ams2.redhat.com
 [10.36.117.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 484E660BF7;
 Fri,  7 Feb 2020 15:24:59 +0000 (UTC)
Subject: Re: [PATCH v2] block: always fill entire LUKS header space with zeros
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20200207135520.2669430-1-berrange@redhat.com>
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
Message-ID: <ca6394d6-7a65-a028-d80b-b965d8684c29@redhat.com>
Date: Fri, 7 Feb 2020 16:24:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207135520.2669430-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ayiwQuFMXYOhgkoo6v2xgCxvIR4TJ6Opf"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ayiwQuFMXYOhgkoo6v2xgCxvIR4TJ6Opf
Content-Type: multipart/mixed; boundary="AJugW4n8cv4afv9cQNfxPU6Bn2Le52LQh"

--AJugW4n8cv4afv9cQNfxPU6Bn2Le52LQh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.02.20 14:55, Daniel P. Berrang=C3=A9 wrote:
> When initializing the LUKS header the size with default encryption
> parameters will currently be 2068480 bytes. This is rounded up to
> a multiple of the cluster size, 2081792, with 64k sectors. If the
> end of the header is not the same as the end of the cluster we fill
> the extra space with zeros. This was forgetting that not even the
> space allocated for the header will be fully initialized, as we
> only write key material for the first key slot. The space left
> for the other 7 slots is never written to.
>=20
> An optimization to the ref count checking code:
>=20
>   commit a5fff8d4b4d928311a5005efa12d0991fe3b66f9 (refs/bisect/bad)
>   Author: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>   Date:   Wed Feb 27 16:14:30 2019 +0300
>=20
>     qcow2-refcount: avoid eating RAM
>=20
> made the assumption that every cluster which was allocated would
> have at least some data written to it. This was violated by way
> the LUKS header is only partially written, with much space simply
> reserved for future use.
>=20
> Depending on the cluster size this problem was masked by the
> logic which wrote zeros between the end of the LUKS header and
> the end of the cluster.
>=20
> $ qemu-img create --object secret,id=3Dcluster_encrypt0,data=3D123456 \
>    -f qcow2 -o cluster_size=3D2k,encrypt.iter-time=3D1,\
>                encrypt.format=3Dluks,encrypt.key-secret=3Dcluster_encrypt=
0 \
>                cluster_size_check.qcow2 100M
>   Formatting 'cluster_size_check.qcow2', fmt=3Dqcow2 size=3D104857600
>     encrypt.format=3Dluks encrypt.key-secret=3Dcluster_encrypt0
>     encrypt.iter-time=3D1 cluster_size=3D2048 lazy_refcounts=3Doff refcou=
nt_bits=3D16
>=20
> $ qemu-img check --object secret,id=3Dcluster_encrypt0,data=3Dredhat \
>     'json:{"driver": "qcow2", "encrypt.format": "luks", \
>            "encrypt.key-secret": "cluster_encrypt0", \
>            "file.driver": "file", "file.filename": "cluster_size_check.qc=
ow2"}'
> ERROR: counting reference for region exceeding the end of the file by one=
 cluster or more: offset 0x2000 size 0x1f9000
> Leaked cluster 4 refcount=3D1 reference=3D0
> ...snip...
> Leaked cluster 130 refcount=3D1 reference=3D0
>=20
> 1 errors were found on the image.
> Data may be corrupted, or further writes to the image may corrupt it.
>=20
> 127 leaked clusters were found on the image.
> This means waste of disk space, but no harm to data.
> Image end offset: 268288
>=20
> The problem only exists when the disk image is entirely empty. Writing
> data to the disk image payload will solve the problem by causing the
> end of the file to be extended further.
>=20
> The change fixes it by ensuring that the entire allocated LUKS header
> region is fully initialized with zeros. The qemu-img check will still
> fail for any pre-existing disk images created prior to this change,
> unless at least 1 byte of the payload is written to.
>=20
> Fully writing zeros to the entire LUKS header is a good idea regardless
> as it ensures that space has been allocated on the host filesystem (or
> whatever block storage backend is used).
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20
> In v2:
>=20
>  - Cut down test scenarios to speed up
>  - Use _check_test_img helper
>  - Fix outdated comments
>  - Use space not tabs

Using eight spaces for indentation is...  Interesting, but at least
consistent. :-)

>  block/qcow2.c              | 11 +++--
>  tests/qemu-iotests/284     | 97 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/284.out | 62 ++++++++++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  4 files changed, 167 insertions(+), 4 deletions(-)
>  create mode 100755 tests/qemu-iotests/284
>  create mode 100644 tests/qemu-iotests/284.out
Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--AJugW4n8cv4afv9cQNfxPU6Bn2Le52LQh--

--ayiwQuFMXYOhgkoo6v2xgCxvIR4TJ6Opf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl49gUkACgkQ9AfbAGHV
z0C7qggAsxrawnu6NdNhAFOywHiDocI/8v1eia5U/AAFzpU+k/B5JRWZF7E0b2Ep
3OTe43oRlzHlUMQB0AXke5uiZVfmQcJP8whsBjTJVxCjy+nDzgOOkCoOF8Ljz+iP
A38iMu+/n14zwALaPhpBEJLervv+96XA6KCAghv2vOl2xbgUhUIhOuvHDoY6j3vT
GCBANDOx6iIZ3o48nBqAPRLqPphS605YpqdtRqkQgrBGeinkqLqxU06YZ4KrAXBT
ub6OqQ6ssIXtjGTfCa2l3aG2rR+sSIMcont8BgB7V18FvymtV7Pt01o+u8sjXnqf
oa3YscqJSqT9l7CuenL4JBRr7447Pg==
=Tyh5
-----END PGP SIGNATURE-----

--ayiwQuFMXYOhgkoo6v2xgCxvIR4TJ6Opf--



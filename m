Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA253C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82D8320714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P88uKn8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D8320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGiFw-00035z-Nw
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38092)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jGiEo-0002Fu-3R
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jGiEm-00080i-Q6
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:00:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:52843)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jGiEm-00080b-MS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585051252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lI9O/4R3mqJWT5qednEV8W7skMDu6tvSEdZCfS39b9o=;
 b=P88uKn8vlp3wVPStclPhyA1tEv4GvuPsTmUEI/Gtx8/ylu6pAvs9tS9z0lUG0Td4QWG0Ue
 NpwO2QZKwzj8pi82uyXulhkEJcZfy9VRdQ/lDiDOU6viy5GdOeNm8TOrrY/C7qfgpmHdkx
 l/CkmkaRiut0s2zwoDrguCg4tuVXEE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-6tyKUqp3OM2TMBeZa6TmVg-1; Tue, 24 Mar 2020 08:00:48 -0400
X-MC-Unique: 6tyKUqp3OM2TMBeZa6TmVg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D02B189D6C0;
 Tue, 24 Mar 2020 12:00:47 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-213.ams2.redhat.com
 [10.36.114.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B51D95DA8B;
 Tue, 24 Mar 2020 12:00:38 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Forbid discard in qcow2 v2 images with backing
 files
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200323194429.1717-1-berto@igalia.com>
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
Message-ID: <e0dd4005-de22-fa5e-857b-cf7ef0a6b743@redhat.com>
Date: Tue, 24 Mar 2020 13:00:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323194429.1717-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t2eeNdYnr5c1tCgXIkwlZ8Veg10wdTdEr"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
--t2eeNdYnr5c1tCgXIkwlZ8Veg10wdTdEr
Content-Type: multipart/mixed; boundary="ao8LWRpZ89FDxQFc5O6kssyQEGVilBs7Q"

--ao8LWRpZ89FDxQFc5O6kssyQEGVilBs7Q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.03.20 20:44, Alberto Garcia wrote:
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

Sounds good to me.

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c              |  6 +++
>  tests/qemu-iotests/060     |  5 ++-
>  tests/qemu-iotests/060.out |  2 -
>  tests/qemu-iotests/289     | 90 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/289.out | 52 ++++++++++++++++++++++
>  tests/qemu-iotests/group   |  1 +
>  6 files changed, 152 insertions(+), 4 deletions(-)
>  create mode 100755 tests/qemu-iotests/289
>  create mode 100644 tests/qemu-iotests/289.out
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index d44b45633d..7bb7e392e1 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3763,6 +3763,12 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDri=
verState *bs,
>      int ret;
>      BDRVQcow2State *s =3D bs->opaque;
> =20
> +    /* If the image does not support QCOW_OFLAG_ZERO then discarding
> +     * clusters could expose stale data from the backing file. */
> +    if (s->qcow_version < 3 && bs->backing) {
> +        return -ENOTSUP;
> +    }
> +
>      if (!QEMU_IS_ALIGNED(offset | bytes, s->cluster_size)) {
>          assert(bytes < s->cluster_size);
>          /* Ignore partial clusters, except for the special case of the
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index 043f12904a..4a4fdfb1e1 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -167,9 +167,10 @@ _make_test_img -o 'compat=3D0.10' -b "$BACKING_IMG" =
1G

More context: This image is created with -o 'compat=3D0.10', just because
a discard on such an image would result in the cluster being freed.  We
can drop that compat=3D0.10 bit now.

>  # Write two clusters, the second one enforces creation of an L2 table af=
ter
>  # the first data cluster.
>  $QEMU_IO -c 'write 0k 64k' -c 'write 512M 64k' "$TEST_IMG" | _filter_qem=
u_io
> -# Discard the first cluster. This cluster will soon enough be reallocate=
d and
> +# Free the first cluster. This cluster will soon enough be reallocated a=
nd
>  # used for COW.
> -$QEMU_IO -c 'discard 0k 64k' "$TEST_IMG" | _filter_qemu_io
> +poke_file "$TEST_IMG" '262144' "\x00\x00\x00\x00\x00\x00\x00\x00" # 0x40=
000 - L2 entry
> +poke_file "$TEST_IMG" '131082' "\x00\x00" # 0x2000a - Refcount entry
>  # Now, corrupt the image by marking the second L2 table cluster as free.
>  poke_file "$TEST_IMG" '131084' "\x00\x00" # 0x2000c
>  # Start a write operation requiring COW on the image stopping it right b=
efore

[...]

> diff --git a/tests/qemu-iotests/289 b/tests/qemu-iotests/289
> new file mode 100755
> index 0000000000..13b4984721
> --- /dev/null
> +++ b/tests/qemu-iotests/289

[...]

> +_cleanup()
> +{
> +    _cleanup_test_img
> +    rm -f "$TEST_IMG.backing"

I=E2=80=99d call the image $TEST_IMG.base so _cleanup_test_img picks up on =
it.
(rm-ing test images is also wrong, because with external data files,
there will be more than one file.  It doesn=E2=80=99t matter here anyway be=
cause
this test doesn=E2=80=99t support external data files, but, well.)

> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks
> +. ./common.rc
> +. ./common.filter
> +
> +_supported_fmt qcow2
> +_supported_proto file
> +_supported_os Linux

I=E2=80=99d mark the compat option unsupported because this test will ignor=
e it.
 Furthermore, the refcount_bits and data_file options are really
unsupported, because they won=E2=80=99t work with compat=3D0.10.

The test itself looks good.

Max


--ao8LWRpZ89FDxQFc5O6kssyQEGVilBs7Q--

--t2eeNdYnr5c1tCgXIkwlZ8Veg10wdTdEr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl559l8ACgkQ9AfbAGHV
z0CUvQgAucto8/zflvhxdzFLK9Ap39I1g/7f7xww8/7J9nM9TQbsGGrqtUY1DZFo
5P2EJ0CwLTbhFk8NzdzUb0h2CIKZFmAEYVh5Thuv7upNS+dAFLz4UHXfGkrsWFB+
fTv7v9XD49RWpRAqr6ge6/wALJkP9XKT/sc1+V35TlWBXK9d/Z15UPn0aE3qVd7O
lgj9GY5T98DYLRKdB5Qndi1FlL/IEFlQ/4uMYm9/NhOo4LWTFIqIpJ2SKry94oku
XVtyEbKQbPSk8cKMEJ/58Z0XREx4YtvvHe9ZKzssb+joKumCSzbHM+iR8F9qnEll
z9vhxgU4PP72S6wJ3ur2VjBNJiG/xQ==
=LEJQ
-----END PGP SIGNATURE-----

--t2eeNdYnr5c1tCgXIkwlZ8Veg10wdTdEr--



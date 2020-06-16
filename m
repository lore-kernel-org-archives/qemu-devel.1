Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6784C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78212207C3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNE/7vUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78212207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDFo-0008EF-N3
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlDBU-0000x6-Gx
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:07:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55779
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jlDBS-0007yM-Jy
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592320049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=N10yde5q+AwU/P0JWv9z4Jhz3uwgnQeKoiS9nhqTQMk=;
 b=DNE/7vUvb9Nm5u0L6cIi4fICPGi2i3xuSrEMXJn7by19Igy1X/fFj8wQTToF2xdo0jpb0Y
 sUde9YxLYMVH77yqdPFB6/YbzrSJuXOacorBVPO+afl+yWQFTN5MUWYU/gO17xI6RSw0X5
 XV+/HJncY9ot4XiIegkBDC9QEAqah8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-2m7fjNiPNCm85fwIEgwMKw-1; Tue, 16 Jun 2020 11:07:27 -0400
X-MC-Unique: 2m7fjNiPNCm85fwIEgwMKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCC4218585CA;
 Tue, 16 Jun 2020 15:07:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-244.ams2.redhat.com
 [10.36.112.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 909DB79302;
 Tue, 16 Jun 2020 15:07:24 +0000 (UTC)
Subject: Re: [PATCH] qcow2: Fix preallocation on images with unaligned sizes
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200610094600.4029-1-berto@igalia.com>
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
Message-ID: <8155ec22-5bbc-62e2-ae5d-b8e3bf816321@redhat.com>
Date: Tue, 16 Jun 2020 17:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610094600.4029-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fLTceEpNaX7cvxFni9TwZvVPtGfGrqF51"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:01:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
--fLTceEpNaX7cvxFni9TwZvVPtGfGrqF51
Content-Type: multipart/mixed; boundary="KIcMFWRRKMYAHW0OiS3YGxD5O9paSzZKB"

--KIcMFWRRKMYAHW0OiS3YGxD5O9paSzZKB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.06.20 11:46, Alberto Garcia wrote:
> When resizing an image with qcow2_co_truncate() using the falloc or
> full preallocation modes the code assumes that both the old and new
> sizes are cluster-aligned.
>=20
> There are two problems with this:
>=20
>   1) The calculation of how many clusters are involved does not always
>      get the right result.
>=20
>      Example: creating a 60KB image and resizing it (with
>      preallocation=3Dfull) to 80KB won't allocate the second cluster.
>=20
>   2) No copy-on-write is performed, so in the previous example if
>      there is a backing file then the first 60KB of the first cluster
>      won't be filled with data from the backing file.
>=20
> This patch fixes both issues.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c              | 17 ++++++++++++++---
>  tests/qemu-iotests/125     | 21 +++++++++++++++++++++
>  tests/qemu-iotests/125.out |  9 +++++++++
>  3 files changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 0cd2e6757e..e20590c3b7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -4317,10 +4317,21 @@ static int coroutine_fn qcow2_co_truncate(BlockDr=
iverState *bs, int64_t offset,
>              int64_t nb_clusters =3D MIN(
>                  nb_new_data_clusters,
>                  s->l2_slice_size - offset_to_l2_slice_index(s, guest_off=
set));
> -            QCowL2Meta allocation =3D {
> +            unsigned cow_start_length =3D offset_into_cluster(s, guest_o=
ffset);
> +            QCowL2Meta allocation;
> +            guest_offset =3D start_of_cluster(s, guest_offset);
> +            allocation =3D (QCowL2Meta) {
>                  .offset       =3D guest_offset,
>                  .alloc_offset =3D host_offset,
>                  .nb_clusters  =3D nb_clusters,
> +                .cow_start    =3D {
> +                    .offset       =3D 0,
> +                    .nb_bytes     =3D cow_start_length,
> +                },
> +                .cow_end      =3D {
> +                    .offset       =3D nb_clusters << s->cluster_bits,
> +                    .nb_bytes     =3D 0,
> +                },

(I don=E2=80=99t think we need to set .cow_end, but well, it doesn=E2=80=99=
t hurt either.)

Anyway, overall, the code change looks good to me, thanks!

>              };
>              qemu_co_queue_init(&allocation.dependent_requests);
> =20
> diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
> index d510984045..5c249b4b23 100755
> --- a/tests/qemu-iotests/125
> +++ b/tests/qemu-iotests/125
> @@ -164,6 +164,27 @@ for GROWTH_SIZE in 16 48 80; do
>  done
>  done
> =20
> +# Test image resizing using preallocation and unaligned offsets
> +$QEMU_IMG create -f raw "$TEST_IMG.base" 128k | _filter_img_create
> +$QEMU_IO -c 'write -q -P 1 0 128k' -f raw "$TEST_IMG.base"
> +for orig_size in 31k 33k; do
> +    echo "--- Resizing image from $orig_size to 96k ---"
> +    _make_test_img -F raw -b "$TEST_IMG.base" -o cluster_size=3D64k "$or=
ig_size"
> +    $QEMU_IMG resize -f "$IMGFMT" --preallocation=3Dfull "$TEST_IMG" 96k
> +    # The first part of the image should contain data from the backing f=
ile
> +    $QEMU_IO -c "read -q -P 1 0 ${orig_size}" "$TEST_IMG"
> +    # The resized part of the image should contain zeroes
> +    $QEMU_IO -c "read -q -P 0 ${orig_size} 63k" "$TEST_IMG"
> +    # The resized image should have 7 clusters:
> +    # header, L1 table, L2 table, refcount table, refcount block, 2 data=
 clusters
> +    expected_file_length=3D$((65536 * 7))
> +    file_length=3D$(stat -c '%s' "$TEST_IMG_FILE")
> +    if [ "$file_length" !=3D "$expected_file_length" ]; then
> +        echo "ERROR: file length $file_length (expected $expected_file_l=
ength)"
> +    fi

Just one thing: Can we skip this check if $IMGOPTS has a data_file?
(i.e. if _get_data_file "$TEST_IMG" returns true)

Because if it has, the data clusters will be in that file and this is
bound to fail.

Max


--KIcMFWRRKMYAHW0OiS3YGxD5O9paSzZKB--

--fLTceEpNaX7cvxFni9TwZvVPtGfGrqF51
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7o4CoACgkQ9AfbAGHV
z0AXvQf/WR5b+SVKh+TcbPb4guzgKF79CDsO4RGvpzsIc3/5ZRRY1o02a/RtH821
JqvDvxL54USOfpkNOwBxtmNiTLGq2TFFwOHpiZftaQutnDbfwZu8x5bMPxIzNOGe
fsdf8M7kkarzHX3bgdpWqUed0nciLFQ84vWv1cl+ECnhTOBQ3cl+y1A0JStnADhw
8zwKC2RJbgy1MTf3DcCU5soPjamj0eSLOfuW5xWI8oGrPICT+RYQipWHAuq9s6np
p7mxM0RTXYnFj5f/oo/yf4NUJyPRvqIU/klFN7v1yPppx7r/q1NhknmF1fV40K/g
Enjl0MzXitnmThnMqWLgMclvilzDww==
=ZzgN
-----END PGP SIGNATURE-----

--fLTceEpNaX7cvxFni9TwZvVPtGfGrqF51--



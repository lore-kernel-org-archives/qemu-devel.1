Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204CBC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26A6206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 13:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjIHyLFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26A6206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZxFU-0005it-SJ
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 08:20:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZxAX-0003Rg-2u
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZxAT-0004os-4Y
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:15:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49171
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZxAP-0004aU-3e
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 08:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574860530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vjkydUOpz0rc/0To33SiyE+MV9hBziAcygddkw0zfdI=;
 b=HjIHyLFHAYQhjeNMFrMegcPUfFdjOq1JYs1z8IQHCVa70N7YyGE34hwJSxWH+NEZdn5E74
 fAsv0jf1zpnqpFGluHUEQaULDJrHp2KDhvJSIKRiyMU+/paF7ARcUs3yNIRG1FitVb+KWg
 cySwEpeRWRljKEdWnvBxtpH8kRyyd9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-JlRKm4OFPqSjvVVwYr7MwQ-1; Wed, 27 Nov 2019 08:15:29 -0500
X-MC-Unique: JlRKm4OFPqSjvVVwYr7MwQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139301086055;
 Wed, 27 Nov 2019 13:15:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-186.brq.redhat.com
 [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D69D03C1D;
 Wed, 27 Nov 2019 13:15:26 +0000 (UTC)
Subject: Re: [PATCH] block: always fill entire LUKS header space with zeros
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20191125174336.555120-1-berrange@redhat.com>
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
Message-ID: <4bd3095d-7263-1855-c74d-20c82af8067f@redhat.com>
Date: Wed, 27 Nov 2019 14:15:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125174336.555120-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hKx5IM3kbhvIoAZ4ZmoLL7DtTDtj47IFg"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
--hKx5IM3kbhvIoAZ4ZmoLL7DtTDtj47IFg
Content-Type: multipart/mixed; boundary="YL2wEddcvPiVhfTPYExRBPFsjORWsuett"

--YL2wEddcvPiVhfTPYExRBPFsjORWsuett
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.11.19 18:43, Daniel P. Berrang=C3=A9 wrote:
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
> =09       cluster_size_check.qcow2 100M
>   Formatting 'cluster_size_check.qcow2', fmt=3Dqcow2 size=3D104857600
>     encrypt.format=3Dluks encrypt.key-secret=3Dcluster_encrypt0
>     encrypt.iter-time=3D1 cluster_size=3D2048 lazy_refcounts=3Doff refcou=
nt_bits=3D16
>=20
> $ qemu-img check --object secret,id=3Dcluster_encrypt0,data=3Dredhat \
>     'json:{"driver": "qcow2", "encrypt.format": "luks", \
>            "encrypt.key-secret": "cluster_encrypt0", \
> =09   "file.driver": "file", "file.filename": "cluster_size_check.qcow2"}=
'
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
>  block/qcow2.c              |   4 +-
>  tests/qemu-iotests/278     |  88 +++++++++++++++++
>  tests/qemu-iotests/278.out | 197 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group   |   1 +
>  4 files changed, 288 insertions(+), 2 deletions(-)
>  create mode 100755 tests/qemu-iotests/278
>  create mode 100644 tests/qemu-iotests/278.out
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 7c18721741..dcfdd200fc 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -140,8 +140,8 @@ static ssize_t qcow2_crypto_hdr_init_func(QCryptoBloc=
k *block, size_t headerlen,

There=E2=80=99s a comment right here that reads:

>     /* Zero fill remaining space in cluster so it has predictable
>      * content in case of future spec changes */

I think that should be adjusted to reflect the change.

>      clusterlen =3D size_to_clusters(s, headerlen) * s->cluster_size;
>      assert(qcow2_pre_write_overlap_check(bs, 0, ret, clusterlen, false) =
=3D=3D 0);
>      ret =3D bdrv_pwrite_zeroes(bs->file,
> -                             ret + headerlen,
> -                             clusterlen - headerlen, 0);
> +                             ret,
> +                             clusterlen, 0);
>      if (ret < 0) {
>          error_setg_errno(errp, -ret, "Could not zero fill encryption hea=
der");
>          return -1;
> diff --git a/tests/qemu-iotests/278 b/tests/qemu-iotests/278
> new file mode 100755
> index 0000000000..c52f03dd52
> --- /dev/null
> +++ b/tests/qemu-iotests/278
> @@ -0,0 +1,88 @@

[...]

> +IMGSPEC=3D"driver=3D$IMGFMT,file.filename=3D$TEST_IMG,encrypt.key-secret=
=3Dsec0"
> +QEMU_IO_OPTIONS=3D$QEMU_IO_OPTIONS_NO_FMT
> +
> +_run_test()
> +{
> +        echo

The indentation is off here.

> +=09echo "=3D=3D cluster size $csize"

Or maybe it really is off here, because starting from here everything is
indented with tabs.

> +=09echo "=3D=3D checking image refcounts =3D=3D"
> +=09$QEMU_IMG check --object $SECRET --image-opts $IMGSPEC | _filter_test=
dir

I think we should use _check_test_img instead in order to filter out the
allocation information.

> +
> +=09echo
> +=09echo "=3D=3D writing some data =3D=3D"
> +=09$QEMU_IO --object $SECRET -c "write -P 0x9 0 1" --image-opts $IMGSPEC=
 | _filter_qemu_io | _filter_testdir
> +=09echo
> +=09echo "=3D=3D rechecking image refcounts =3D=3D"
> +=09$QEMU_IMG check --object $SECRET --image-opts $IMGSPEC | _filter_test=
dir
> +
> +=09echo
> +=09echo "=3D=3D writing some more data =3D=3D"
> +=09$QEMU_IO --object $SECRET -c "write -P 0x9 $csize 1" --image-opts $IM=
GSPEC | _filter_qemu_io | _filter_testdir
> +=09echo
> +=09echo "=3D=3D rechecking image refcounts =3D=3D"
> +=09$QEMU_IMG check --object $SECRET --image-opts $IMGSPEC | _filter_test=
dir
> +}
> +
> +
> +echo
> +echo "testing LUKS qcow2 encryption"
> +echo
> +
> +for csize in 512 1024 2048 4096 8192 16384 32768 65536

Is it necessary to actually test all of these cluster sizes?  Wouldn=E2=80=
=99t
it make more sense to test e.g. just 512, 4096, 64k, 2M?

I=E2=80=99m asking because as-is this test takes more than 20 s for me.

> +do
> +  _make_test_img --object $SECRET -o "encrypt.format=3Dluks,encrypt.key-=
secret=3Dsec0,encrypt.iter-time=3D10,cluster_size=3D$csize" $size
> +  _run_test "driver=3D$IMGFMT,encrypt.key-secret=3Dsec0,file.filename=3D=
$TEST_IMG"

I don=E2=80=99t think this parameter is used (because $IMGSPEC exists).

Max


--YL2wEddcvPiVhfTPYExRBPFsjORWsuett--

--hKx5IM3kbhvIoAZ4ZmoLL7DtTDtj47IFg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3edu0ACgkQ9AfbAGHV
z0DTJAgAn4vVPiXnB3M5XYt71gXpow2GbPBWxhU5ga+4VFl9Bet1+n+OTvvG65aG
OdWGgZB3i93orN7DhOMfbZRLJA2YNQxAJoPqqvDMNic96Y1WnRUOZZvVdKpuJKLw
4wsti75NKqWkMeAVRW1nlVrqvtz8Tn8+fcSMA4bLsCZeW38fx/2QR4Otz99zAoWR
iG6zqZyzk4NJm2B3xGpLLxWF+ZazGCqt88wThJrRtaX0vVi13T4vYhHRh3TvniDM
xgFI/b10e6DpG0LhGicWKRGsfmdWpy9I5npuXa0eoCYYbS2QgMlV93IoIDSH7tR9
0H88VWd6WnxtrrlMooHXEcqR7lNhLQ==
=Lx0P
-----END PGP SIGNATURE-----

--hKx5IM3kbhvIoAZ4ZmoLL7DtTDtj47IFg--



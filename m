Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE204C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:00:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818852074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 09:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="En/tBW1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818852074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzyzI-00077T-OJ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 05:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jzyyU-0006ZJ-4l
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:59:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44928
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jzyyS-0000AR-5A
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595840347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QR/8mbsLZQC5u6SQTJ8+5ELD6O451m5CkMCn5bseeI0=;
 b=En/tBW1Hhrg02cG7elkWL8GWvvYYERFewE8WUxPxI6SFF5bXak0pkOJ3hI0jGfB9NibNFp
 Rt1QcAftWHJNB0ox+spggezMkqggWJfSv55bxmWnnYMt8riAFSclEHPZ0rXYf2LeyQljmO
 SUmnQ1atRS2YBexOQMkXab/NN0PjGgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-cWxzp2mxMIqNax7IoW8FGw-1; Mon, 27 Jul 2020 04:59:04 -0400
X-MC-Unique: cWxzp2mxMIqNax7IoW8FGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D65E80572E;
 Mon, 27 Jul 2020 08:59:03 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-45.ams2.redhat.com
 [10.36.113.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 878D910013C0;
 Mon, 27 Jul 2020 08:59:01 +0000 (UTC)
Subject: Re: [PATCH 1/2] block: nbd: Fix convert qcow2 compressed to nbd
To: Nir Soffer <nirsof@gmail.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20200726152532.256261-1-nsoffer@redhat.com>
 <20200726152532.256261-2-nsoffer@redhat.com>
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
Message-ID: <38ca7428-b823-e7bd-bac1-fc50f58ae947@redhat.com>
Date: Mon, 27 Jul 2020 10:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726152532.256261-2-nsoffer@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2ssDjXdY2CzRPezwDTeSH5gE2bxYgLOwT"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ssDjXdY2CzRPezwDTeSH5gE2bxYgLOwT
Content-Type: multipart/mixed; boundary="Iu945y9Pv4b1Z3gXtaE8l9X0yYBpiD7Qb"

--Iu945y9Pv4b1Z3gXtaE8l9X0yYBpiD7Qb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.07.20 17:25, Nir Soffer wrote:
> When converting to qcow2 compressed format, the last step is a special
> zero length compressed write, ending in call to bdrv_co_truncate(). This
> call always fail for the nbd driver since it does not implement
> bdrv_co_truncate().
>=20
> For block devices, which have the same limits, the call succeeds since
> file driver implements bdrv_co_truncate(). If the caller asked to
> truncate to the same or smaller size with exact=3Dfalse, the truncate
> succeeds. Implement the same logic for nbd.
>=20
> Example failing without this change:
>=20
> In one shell starts qemu-nbd:
>=20
> $ truncate -s 1g test.tar
> $ qemu-nbd --socket=3D/tmp/nbd.sock --persistent --format=3Draw --offset =
1536 test.tar
>=20
> In another shell convert an image to qcow2 compressed via NBD:
>=20
> $ echo "disk data" > disk.raw
> $ truncate -s 1g disk.raw
> $ qemu-img convert -f raw -O qcow2 -c disk1.raw nbd+unix:///?socket=3D/tm=
p/nbd.sock; echo $?
> 1
>=20
> qemu-img failed, but the conversion was successful:
>=20
> $ qemu-img info nbd+unix:///?socket=3D/tmp/nbd.sock
> image: nbd+unix://?socket=3D/tmp/nbd.sock
> file format: qcow2
> virtual size: 1 GiB (1073741824 bytes)
> ...
>=20
> $ qemu-img check nbd+unix:///?socket=3D/tmp/nbd.sock
> No errors were found on the image.
> 1/16384 =3D 0.01% allocated, 100.00% fragmented, 100.00% compressed clust=
ers
> Image end offset: 393216
>=20
> $ qemu-img compare disk.raw nbd+unix:///?socket=3D/tmp/nbd.sock
> Images are identical.
>=20
> Fixes: https://bugzilla.redhat.com/1860627
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/nbd.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index 65a4f56924..2154113af3 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1966,6 +1966,30 @@ static void nbd_close(BlockDriverState *bs)
>      nbd_clear_bdrvstate(s);
>  }
> =20
> +/*
> + * NBD cannot truncate, but if the caller ask to truncate to the same si=
ze, or
> + * to a smaller size with extact=3Dfalse, there is not reason to fail th=
e
> + * operation.
> + */
> +static int coroutine_fn nbd_co_truncate(BlockDriverState *bs, int64_t of=
fset,
> +                                        bool exact, PreallocMode preallo=
c,
> +                                        BdrvRequestFlags flags, Error **=
errp)
> +{
> +    BDRVNBDState *s =3D bs->opaque;
> +
> +    if (offset !=3D s->info.size && exact) {
> +        error_setg(errp, "Cannot resize NBD nodes");
> +        return -ENOTSUP;
> +    }
> +
> +    if (offset > s->info.size) {
> +        error_setg(errp, "Cannot grow NBD nodes");
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}

Can we also check @prealloc, like iscsi.c does it?

(Yes, preallocation only makes sense for growing, but you can for
example truncate a 2 GB NBD node to 1 GB, and then grow it to 1.5 GB,
and for the latter operation it might make sense to give a preallocation
parameter.  (Except block_resize doesn=E2=80=99t allow that, but, well.))

Max


--Iu945y9Pv4b1Z3gXtaE8l9X0yYBpiD7Qb--

--2ssDjXdY2CzRPezwDTeSH5gE2bxYgLOwT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8el1MACgkQ9AfbAGHV
z0Djtgf/VB5EqT8AQS2BgJvgSgaUUF5NJnl/zAQlI9Iuoj3SCDIsg2PzXXS2pkzM
vzrA/eFHeuXOhF0miB1Wh+ETZvzWhU2C/yWPTmPGlSvOahsKsXPRHD7XJaHjTgKz
1WcQcrKtZc/Poy90dstk4QVq86h1KIeKyQ3uPL1vc+g8P/ju6EYx0tC6WEmX89Uw
hvSYq1bblTB2eYXMJsQIpPTA2SCJIFt+DKE5EGlpIDqkw+zWdUNYR6/fegD+2ol1
lGTokRuuC6VOqeJ0kXxzJ3+zvTlBMAIsrCYcsBIowv5quyJRQ1IURMitqlGjmeRa
k1jkA+vBbdZHp9Tthd3zYpkMWG/EHA==
=eSza
-----END PGP SIGNATURE-----

--2ssDjXdY2CzRPezwDTeSH5gE2bxYgLOwT--



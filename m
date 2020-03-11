Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82478C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D683208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 11:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNQ2/OV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D683208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBzCW-0007hW-Ad
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 07:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBzBp-0007Gg-Be
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBzBn-0006jL-OF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:06:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58073
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBzBn-0006hc-Ic
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 07:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583924774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PAdd6FgMFHaG6bT4C0k9Bai/lubrsdOIQ0ByGZmPj3A=;
 b=LNQ2/OV+JX6liZNDVGnszDOlvCVvZHXosS+8VQPISt/brBxaf76QYUSXB8/pyZ3gP48oBo
 RYYVGYUrbKnjgLRgs3h4blYb4bz+ZGTFNg1gjfi/IgLmkfOxHVs+3P9nKf0kx5jhGzn4jR
 YiDdSVwM416UTOy+oVAEyDGh1W/aCuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-xiCQKsNUPhmD8mWa72iUfw-1; Wed, 11 Mar 2020 07:06:12 -0400
X-MC-Unique: xiCQKsNUPhmD8mWa72iUfw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AF5B13F7;
 Wed, 11 Mar 2020 11:06:11 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-216.ams2.redhat.com
 [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6FCA73874;
 Wed, 11 Mar 2020 11:06:08 +0000 (UTC)
Subject: Re: [PATCH 3/3] block: fail on open when file size is unaligned to
 request_alignment
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200130152218.7600-1-vsementsov@virtuozzo.com>
 <20200130152218.7600-4-vsementsov@virtuozzo.com>
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
Message-ID: <4fb7d692-4009-c6a7-c765-292ac8073ae3@redhat.com>
Date: Wed, 11 Mar 2020 12:06:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200130152218.7600-4-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tGhqMGp2WInpHVI6afdnORpVNcU4tA8Hu"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tGhqMGp2WInpHVI6afdnORpVNcU4tA8Hu
Content-Type: multipart/mixed; boundary="jX0JJ4A08HQ4WKYRqjhHbNI96JiAzFIcY"

--jX0JJ4A08HQ4WKYRqjhHbNI96JiAzFIcY
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.01.20 16:22, Vladimir Sementsov-Ogievskiy wrote:
> Prior to the commit the following command lead to crash:
>=20
>   ./qemu-io --image-opts -c 'write 0 512' \
>   driver=3Dblkdebug,align=3D4096,image.driver=3Dnull-co,image.size=3D512
>=20
> It failes on assertion in bdrv_aligned_pwritev:
>   "end_sector <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE"
>=20
> The problem is obvious: 512 is aligned to 4096 and becomes larger than
> file size. And the core bad thing is that file size is unaligned to
> request_alignment.
>=20
> Let's catch such case on bdrv_open_driver and fail.

I think we had a discussion on this before, but I can=92t find it right
now.  (Although I think that had more to do with something in the
file-posix driver, because it wasn=92t limited to alignments above 512.)

In any case, the file itself is totally valid.  Most importantly, qcow2
will regularly create files with unaligned file lengths.

So let me create a qcow2 image on a 4k-aligned device:

$ truncate 512M fs.img
$ sudo losetup -f --show -b 4096 fs.img
/dev/loop0
$ sudo mkfs.ext4 /dev/loop0
[...]
$ sudo mount /dev/loop0 /mnt/tmp

$ sudo ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 64M
Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 size=3D67108864
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ sudo ./qemu-io -t none -c quit /mnt/tmp/foo.qcow2
qemu-io: can't open device /mnt/tmp/foo.qcow2: File size is unaligned to
request alignment

Which is too bad.

So the real solution would probably...  Be to align the file size up to
the alignment?

Max

> Note, that file size and request_alignment may become out of sync
> later, so this commit is not full fix of the problem, but it's better
> than nothing.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index ecd09dbbfd..4cfc6c33a2 100644
> --- a/block.c
> +++ b/block.c
> @@ -1324,6 +1324,13 @@ static int bdrv_open_driver(BlockDriverState *bs, =
BlockDriver *drv,
>      assert(bdrv_min_mem_align(bs) !=3D 0);
>      assert(is_power_of_2(bs->bl.request_alignment));
> =20
> +    if (bs->bl.request_alignment > 512 &&
> +        !QEMU_IS_ALIGNED(bs->total_sectors, bs->bl.request_alignment / 5=
12))
> +    {
> +        error_setg(errp, "File size is unaligned to request alignment");
> +        return -EINVAL;
> +    }
> +
>      for (i =3D 0; i < bs->quiesce_counter; i++) {
>          if (drv->bdrv_co_drain_begin) {
>              drv->bdrv_co_drain_begin(bs);
>=20



--jX0JJ4A08HQ4WKYRqjhHbNI96JiAzFIcY--

--tGhqMGp2WInpHVI6afdnORpVNcU4tA8Hu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5oxh4ACgkQ9AfbAGHV
z0AO8Qf+IaszaaxNUbSh9LDuGVkCaFU7wVU9cBWysIRlV8+V2dLCIb8UmuLdmNIg
D5NZ4izqCSKENgVu/4GjnRwgbCwrEC2CFvxjTyU75hKiluenH6Fulc4b0o6Izhct
hh6C0VCVT8PrwvLaSe2vVnNlLHvGas/rrHAfr8QepefrrU+lK/A5xRv9W1S+kJ3t
ikaCFY+f2JloWXL8B2qeVafivk067jeVySH+FIbSAFp7eeUOZ8iessbpUIA2b+Ig
a4C31oWqBcvgvngEuVjZaRJ4vbUcVbPuVYfswBbph78zNTraYcL9BtTDJoN4p8If
FqAq8+s0NHsvXYDngI9f/dHmLGkK3w==
=/QV4
-----END PGP SIGNATURE-----

--tGhqMGp2WInpHVI6afdnORpVNcU4tA8Hu--



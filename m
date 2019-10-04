Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55902C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250B7222BE
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250B7222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGQW0-0006Cg-At
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 12:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGQUt-0005dg-7L
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGQUs-0008PA-1h
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 12:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGQUo-0008Ny-4x; Fri, 04 Oct 2019 12:31:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C59B0881366;
 Fri,  4 Oct 2019 16:31:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB6BB6012C;
 Fri,  4 Oct 2019 16:31:52 +0000 (UTC)
Subject: Re: [PATCH 3/4] block/mirror: support unaligned write in active mirror
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20190912151338.21225-1-vsementsov@virtuozzo.com>
 <20190912151338.21225-4-vsementsov@virtuozzo.com>
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
Message-ID: <6fd6a449-0443-ecfa-0eec-23e3b515b303@redhat.com>
Date: Fri, 4 Oct 2019 18:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190912151338.21225-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NnRTkHir4cCIKYDsS0FEEjxOGi1iPk5C0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Fri, 04 Oct 2019 16:31:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NnRTkHir4cCIKYDsS0FEEjxOGi1iPk5C0
Content-Type: multipart/mixed; boundary="y6cCdsqYswb8L3Wjn3vovrA32MRNgMHpp"

--y6cCdsqYswb8L3Wjn3vovrA32MRNgMHpp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.09.19 17:13, Vladimir Sementsov-Ogievskiy wrote:
> Prior 9adc1cb49af8d do_sync_target_write had a bug: it reset aligned-up=

> region in the dirty bitmap, which means that we may not copy some bytes=

> and assume them copied, which actually leads to producing corrupted
> target.
>=20
> So 9adc1cb49af8d forced dirty bitmap granularity to be
> request_alignment for mirror-top filter, so we are not working with
> unaligned requests. However forcing large alignment obviously decreases=

> performance of unaligned requests.
>=20
> This commit provides another solution for the problem: if unaligned
> padding is already dirty, we can safely ignore it, as
> 1. It's dirty, it will be copied by mirror_iteration anyway
> 2. It's dirty, so skipping it now we don't increase dirtiness of the
>    bitmap and therefore don't damage "synchronicity" of the
>    write-blocking mirror.
>=20
> If unaligned padding is not dirty, we just write it, no reason to touch=

> dirty bitmap if we succeed (on failure we'll set the whole region
> ofcourse, but we loss "synchronicity" on failure anyway).
>=20
> Note: we need to disable dirty_bitmap, otherwise we will not be able to=

> see in do_sync_target_write bitmap state before current operation. We
> may of course check dirty bitmap before the operation in
> bdrv_mirror_top_do_write and remember it, but we don't need active
> dirty bitmap for write-blocking mirror anyway.
>=20
> New code-path is unused until the following commit reverts
> 9adc1cb49af8d.
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/mirror.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/mirror.c b/block/mirror.c
> index d176bf5920..d192f6a96b 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1204,6 +1204,39 @@ do_sync_target_write(MirrorBlockJob *job, Mirror=
Method method,
>                       QEMUIOVector *qiov, int flags)
>  {
>      int ret;
> +    size_t qiov_offset =3D 0;
> +
> +    if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
> +        bdrv_dirty_bitmap_get(job->dirty_bitmap, offset)) {
> +            /*
> +             * Dirty unaligned padding
> +             * 1. It's already dirty, no damage to "actively_synced" i=
f we just
> +             *    skip unaligned part.
> +             * 2. If we copy it, we can't reset corresponding bit in
> +             *    dirty_bitmap as there may be some "dirty" bytes stil=
l not
> +             *    copied.
> +             * So, just ignore it.
> +             */
> +            qiov_offset =3D QEMU_ALIGN_UP(offset, job->granularity) - =
offset;
> +            if (bytes <=3D qiov_offset) {
> +                /* nothing to do after shrink */
> +                return;
> +            }
> +            offset +=3D qiov_offset;
> +            bytes -=3D qiov_offset;
> +    }
> +
> +    if (!QEMU_IS_ALIGNED(offset + bytes, job->granularity) &&
> +        bdrv_dirty_bitmap_get(job->dirty_bitmap, offset + bytes - 1))
> +    {
> +        uint64_t tail =3D (offset + bytes) % job->granularity;
> +
> +        if (bytes <=3D tail) {
> +            /* nothing to do after shrink */
> +            return;
> +        }
> +        bytes -=3D tail;
> +    }
> =20
>      bdrv_reset_dirty_bitmap(job->dirty_bitmap, offset, bytes);
> =20

The bdrv_set_dirty_bitmap() in the error case below needs to use the
original offset/bytes, I suppose.

Apart from that, looks good to me.

Max


--y6cCdsqYswb8L3Wjn3vovrA32MRNgMHpp--

--NnRTkHir4cCIKYDsS0FEEjxOGi1iPk5C0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2Xc/cACgkQ9AfbAGHV
z0BHKQf/YTvtx4f7SKBt+T9Nhb9ORb76cjz4TGrajZd/Ox+XsHnRSK5nyotK+nc+
VljtG2Q/qnr7mBFTCu6E+fbKclsWCkHXDRDXP/RVau8814L35cfPf2qROwYx2mnM
m5loesf58K+PKoyulkzDWpmEsc7kduNkdO3ZfWCmb/z+IO5X4p7S3AM/QzggJsE+
JOmkCDkgCdfErBscropthejhvUcRM+cEsmuUtRbUxznv1fhbB6kZn+YwctmT6E1q
dPakREbHbdgtEyS8cMbpYr52Auwv90Ks5V/Mg/Yd8c1MVuU3/Cb++sw9LUnRUJni
Xqh780TKSpojbCzUWOUugsZRdhPtUg==
=5MmK
-----END PGP SIGNATURE-----

--NnRTkHir4cCIKYDsS0FEEjxOGi1iPk5C0--


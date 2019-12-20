Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C61C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CDD21655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSIzu4Ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CDD21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57593 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJfB-000646-Ay
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iiJeF-0005IB-00
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iiJeD-00089c-CG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:52:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24557
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iiJeD-00086Y-3l
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576853576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V/nikh6S1tsGaKECnrKBntifJxN0srXWwYZHDAmZLf0=;
 b=CSIzu4EzIdtsLoSrOfbeBKhvWRQ3j2ATlMhCDoXeQj7sach2i/g+K4YJ6bVX38z8NNR7nm
 XCTKlwYF7VJBDjsbwCnUAwqkTOD1IXiaC/aR6CgSxBBXPjM+uVoZftrknyYHIWgnPTQbF6
 +wiRbesBXM+f4fKAmYX5/qtNu4Nr5lM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-Hgxa0HSDMwOD3_yAF3tQLw-1; Fri, 20 Dec 2019 09:52:53 -0500
X-MC-Unique: Hgxa0HSDMwOD3_yAF3tQLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4F4C593A1;
 Fri, 20 Dec 2019 14:52:51 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-117.brq.redhat.com
 [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EC9C6E41E;
 Fri, 20 Dec 2019 14:52:49 +0000 (UTC)
Subject: Re: [PATCH v12 1/3] block: introduce compress filter driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <1575288906-551879-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1575288906-551879-2-git-send-email-andrey.shinkevich@virtuozzo.com>
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
Message-ID: <4c0f2379-7baf-7aa3-ab5f-a7046793d730@redhat.com>
Date: Fri, 20 Dec 2019 15:52:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575288906-551879-2-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WZGRX3jMkmx4R6E8npbzGoWhGMzTfKhKw"
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WZGRX3jMkmx4R6E8npbzGoWhGMzTfKhKw
Content-Type: multipart/mixed; boundary="c3V1eeX7Kl6PDYGFyHXfkwbOmrAwUObDr"

--c3V1eeX7Kl6PDYGFyHXfkwbOmrAwUObDr
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.12.19 13:15, Andrey Shinkevich wrote:
> Allow writing all the data compressed through the filter driver.
> The written data will be aligned by the cluster size.
> Based on the QEMU current implementation, that data can be written to
> unallocated clusters only. May be used for a backup job.
>=20
> Suggested-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/Makefile.objs     |   1 +
>  block/filter-compress.c | 168 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  qapi/block-core.json    |  10 +--
>  3 files changed, 175 insertions(+), 4 deletions(-)
>  create mode 100644 block/filter-compress.c

[...]

> diff --git a/block/filter-compress.c b/block/filter-compress.c
> new file mode 100644
> index 0000000..4d756ea
> --- /dev/null
> +++ b/block/filter-compress.c
> @@ -0,0 +1,168 @@

[...]

> +static int compress_open(BlockDriverState *bs, QDict *options, int flags=
,
> +                         Error **errp)
> +{
> +    bs->file =3D bdrv_open_child(NULL, options, "file", bs, &child_file,=
 false,
> +                               errp);
> +    if (!bs->file) {
> +        return -EINVAL;
> +    }
> +
> +    if (!bs->file->bs->drv || !block_driver_can_compress(bs->file->bs->d=
rv)) {
> +        error_setg(errp,
> +                   "Compression is not supported for underlying format: =
%s",
> +                   bdrv_get_format_name(bs->file->bs));

bdrv_get_format_name() returns NULL if bs->file->bs->drv is NULL.  I=92m
sure g_strdup_vprintf() handles %s with a NULL string gracefully in
practice, but I can=92t find that specified anywhere.  So even though I=92m
well aware I=92m being a bit stupid about a minor edge case, I=92m hesitant
to accept this patch as-is.

Obviously the solution can be as simple as bdrv_get_format_name(...) ?:
"(no format)".

Well, actually, I can be a bit less stupid about it and just propose
merging that change in myself.  Would that be OK for you?

(The rest looks good to me.)

Max


--c3V1eeX7Kl6PDYGFyHXfkwbOmrAwUObDr--

--WZGRX3jMkmx4R6E8npbzGoWhGMzTfKhKw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl384EAACgkQ9AfbAGHV
z0C11AgAsuFfbKTgAm75htnorN6ziTjTvAViSkjzNl9lW4f+NJ9WCAzEUF5wrYus
pmewtktGKFnCGjOeF+MF2Gl5VtPgENbOjnc6irnq/w6lKQfcQHUtAnDT4Q8h++pe
P289M+6drjrmSi7IsCKj+c3D+v2dsJtcSrFLcDoLMKGa3TgZS80WbLhY64jIfJUP
uKZoJ3s3E9r+JMnvBPavt2aQz3qFXUlDhICxD5KvRO47TNBzpokLDjpCwpuM3eST
hs4LPC/FEfub6nEFg2SjwpSpvFtN+nJIvTgNDZ3VrosNgQDy8LDTL+IQTKm6Ghjz
+styqP1agbDWP0cMW/ByG+dHSGBT0A==
=c+58
-----END PGP SIGNATURE-----

--WZGRX3jMkmx4R6E8npbzGoWhGMzTfKhKw--



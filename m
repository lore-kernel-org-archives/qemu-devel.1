Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63517C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25B412074A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IyLvc2pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25B412074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTl6t-0008IR-3X
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTl5O-0007Bm-3S
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTl35-0003uY-2q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:41:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27742
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTl33-0003sW-0p
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588160318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8gN67HaAeZO+Xr6Oq2UqVCD5LT1uDebf84nW88tTe9s=;
 b=IyLvc2pFXVNVisE2c/9Y6hHdkAKChjkD2pbkTvdOUrZCtUiL0zHEAvKA7uT5b3RtxSsn2E
 f9y7/7O/BED+31KcW3X4JWfjjdSZ4BA1HNKCNzEDBhDbjm62HTmy1QRbGPLEb2XsxGly5q
 Z2i75VJck5V3x2MYPmvvNjEdJdxkzck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-Oz4PVwc2NM2dnwMYs22I4Q-1; Wed, 29 Apr 2020 07:38:35 -0400
X-MC-Unique: Oz4PVwc2NM2dnwMYs22I4Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB0BA1899521;
 Wed, 29 Apr 2020 11:38:34 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42FAB60BF4;
 Wed, 29 Apr 2020 11:38:33 +0000 (UTC)
Subject: Re: [PATCH v3 4/5] block/block-copy: refactor task creation
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200429061039.12687-1-vsementsov@virtuozzo.com>
 <20200429061039.12687-5-vsementsov@virtuozzo.com>
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
Message-ID: <affc8770-2b70-c3e4-af1b-ca620119c2d5@redhat.com>
Date: Wed, 29 Apr 2020 13:38:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429061039.12687-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K51YJQfLwbe3hZyrJpRZl3nCJcQHcFtjI"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
--K51YJQfLwbe3hZyrJpRZl3nCJcQHcFtjI
Content-Type: multipart/mixed; boundary="dZWPgixseNDziEBXa29n0Ib2SZ5hov2Oj"

--dZWPgixseNDziEBXa29n0Ib2SZ5hov2Oj
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.04.20 08:10, Vladimir Sementsov-Ogievskiy wrote:
> Instead of just relying on the comment "Called only on full-dirty
> region" in block_copy_task_create() let's move initial dirty area
> search directly to block_copy_task_create(). Let's also use effective
> bdrv_dirty_bitmap_next_dirty_area instead of looping through all
> non-dirty clusters.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 78 ++++++++++++++++++++++++++--------------------
>  1 file changed, 44 insertions(+), 34 deletions(-)
>=20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 35ff9cc3ef..5cf032c4d8 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c

[...]

> @@ -106,17 +111,27 @@ static bool coroutine_fn block_copy_wait_one(BlockC=
opyState *s, int64_t offset,
>      return true;
>  }
> =20
> -/* Called only on full-dirty region */
> +/*
> + * Search for the first dirty area in offset/bytes range and create task=
 at
> + * the beginning of it.

Oh, that=92s even better.

> + */
>  static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
>                                               int64_t offset, int64_t byt=
es)
>  {
> -    BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
> +    if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
> +                                           offset, offset + bytes,
> +                                           s->copy_size, &offset, &bytes=
))
> +    {
> +        return NULL;
> +    }
> =20
> +    /* region is dirty, so no existent tasks possible in it */
>      assert(!find_conflicting_task(s, offset, bytes));
> =20
>      bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
>      s->in_flight_bytes +=3D bytes;
> =20
> +    BlockCopyTask *task =3D g_new(BlockCopyTask, 1);

This should be declared at the top of the function.

With that fixed:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>      *task =3D (BlockCopyTask) {
>          .s =3D s,
>          .offset =3D offset,


--dZWPgixseNDziEBXa29n0Ib2SZ5hov2Oj--

--K51YJQfLwbe3hZyrJpRZl3nCJcQHcFtjI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pZzcACgkQ9AfbAGHV
z0CllwgAnPTeIPo0Ntuup4v+ts3DP3jwinMGEu7djz4IE3Nwt1+pNrSpFjzXOE94
H8UEk2GsIqyD1nlZFIn97mDu8QhAuEJ8lBJVU/5e7siJv67kO3ArLHeF3ER+P/Bo
HZRZLdvktqrohyEVaQU/3moC17D3MwECbyW3fJ9ubU9ZMIVlLloHRwVVNPaoxjOf
Ap3WrqF38jVp01xMqIcqoBJdQsLvqyjZHbcOHy39suvf7LPgSQ5HiIzFaonZioZF
mSANQtGI8nj55J2nY2jIovgZI3tAVErfQnFdgcz4C9f/WmTF/l657U+mT7ReWpeh
6FHysbYHGWiNB7uxlWCWUfxd42Dn1g==
=zY1l
-----END PGP SIGNATURE-----

--K51YJQfLwbe3hZyrJpRZl3nCJcQHcFtjI--



Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE33C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC2A214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 18:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hk+pdu9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC2A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07xr-0005Ft-Jh
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 13:02:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48520)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j07xC-0004c6-4d
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:02:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j07xA-0001wT-K3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:02:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21710
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j07xA-0001uO-GD
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 13:02:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581098527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L7oJicjRjGXqoaIATWD7pzJpaX+XLptdeOXLyR/bxNk=;
 b=Hk+pdu9VND69HAqGThRba3oq31SKnCGMlylWRIZc7nFoKHhX5HYSjNq225Iyy1MSYm0OV0
 aVQF9TL9gXa0w+n/9mVAJSsw5CspMd8+l6RhDXCUfmhFzEazb70n1kZorVQbT8JqyeQMHo
 Q7/2RBPVMZgjiOwnNv9Ac4VCwq8460w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-HSDytHQrOgO_mOFVflUbQQ-1; Fri, 07 Feb 2020 13:02:03 -0500
X-MC-Unique: HSDytHQrOgO_mOFVflUbQQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10A3B802565;
 Fri,  7 Feb 2020 18:02:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-14.ams2.redhat.com
 [10.36.117.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D33E287B11;
 Fri,  7 Feb 2020 18:01:57 +0000 (UTC)
Subject: Re: [PATCH v2 4/7] block/block-copy: refactor interfaces to use bytes
 instead of end
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-5-vsementsov@virtuozzo.com>
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
Message-ID: <b41bd0ca-07f6-27e5-b6c7-eefa2a4826ba@redhat.com>
Date: Fri, 7 Feb 2020 19:01:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191127180840.11937-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9JGGW5b3LekC2KZRDaHFIFeLeBGgLArx6"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9JGGW5b3LekC2KZRDaHFIFeLeBGgLArx6
Content-Type: multipart/mixed; boundary="ZCtYxxQRpcx9p6JtMgjj8H42rHYv91sAm"

--ZCtYxxQRpcx9p6JtMgjj8H42rHYv91sAm
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
> We have a lot of "chunk_end - start" invocations, let's switch to
> bytes/cur_bytes scheme instead.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block-copy.h |  4 +--
>  block/block-copy.c         | 68 ++++++++++++++++++++------------------
>  2 files changed, 37 insertions(+), 35 deletions(-)

[...]

> diff --git a/block/block-copy.c b/block/block-copy.c
> index 94e7e855ef..cc273b6cb8 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c

[...]

> @@ -150,24 +150,26 @@ void block_copy_set_callbacks(

[...]

>  static int coroutine_fn block_copy_do_copy(BlockCopyState *s,
> -                                           int64_t start, int64_t end,
> +                                           int64_t start, int64_t bytes,

I wonder whether it would make more sense to make some of these @bytes
parameters plain ints, because...

>                                             bool zeroes, bool *error_is_r=
ead)
>  {
>      int ret;
> -    int nbytes =3D MIN(end, s->len) - start;
> +    int nbytes =3D MIN(start + bytes, s->len) - start;

...things like this look a bit dangerous now.  So if the interface
already clearly shows that we=92re always expecting something less than
INT_MAX, it might all be a bit clearer.

I=92ll leave it up to you:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ZCtYxxQRpcx9p6JtMgjj8H42rHYv91sAm--

--9JGGW5b3LekC2KZRDaHFIFeLeBGgLArx6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl49phQACgkQ9AfbAGHV
z0Bsygf/Y4pGhERL/iYygYpm7SyF5beGWjLhLoT6jNKOuWr3p2DfrwojGbS8LCoq
bEezn3AJqYDocpAsoBPExAFmG6jhaCewmtGzn5IWxo/+Go9EsRjxUojttTs92dh7
xeo8njrK09VPmRV7pAgUE9lwdUjU805FDsOzmydXeuDkRbougIZB30m+WwDw+8IW
Al34IG+JN/Q3k14Y/Bop6jN1wE1r7a79oUqK1Rh5kDAtPMWeIWji8nbJTbPX4js6
Adny5eyjVI9e/xYNjaU3zjNxm529TFeNSuLI6icjEtBvoCC0jmL78dACKg/RHkeQ
efmhWk/tmg+FF8n2qw77KlkDcNV0yg==
=rlbB
-----END PGP SIGNATURE-----

--9JGGW5b3LekC2KZRDaHFIFeLeBGgLArx6--



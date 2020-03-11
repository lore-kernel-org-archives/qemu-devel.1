Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B709C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBA7F20848
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 10:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tfgtx57J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBA7F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBytL-0000Wk-42
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 06:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBysk-0008U3-5M
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBysi-0003GV-L4
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:46:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBysi-0003Fu-Da
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 06:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583923591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LAyzrN3aeTMVNnXZmXRdlrX4iGkmLYWyAgpIEqxgmoI=;
 b=Tfgtx57Jk30WBmAqnStYnbzSe0R10cXsGVg2BgKDAHsK6NWVjzPtsSi2ki8D5iyAX75OWI
 CsoR8xXBIp+uQhpCGc4xkLDTYq1oZsFIybiKCTM1XAq8qax2EfMsNPONR3joAx/xuXPLz4
 mC+J4tDD4mRxXNGDpBU7vHTAjWSEra0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-T7Qp4QooNauBO9Y7IsnlPw-1; Wed, 11 Mar 2020 06:46:29 -0400
X-MC-Unique: T7Qp4QooNauBO9Y7IsnlPw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39564800D54;
 Wed, 11 Mar 2020 10:46:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-216.ams2.redhat.com
 [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD9D25D9C9;
 Wed, 11 Mar 2020 10:46:25 +0000 (UTC)
Subject: Re: [PATCH 2/3] block/file-posix: consider file size when fallback to
 max_align
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200130152218.7600-1-vsementsov@virtuozzo.com>
 <20200130152218.7600-3-vsementsov@virtuozzo.com>
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
Message-ID: <1924575b-22d6-8ab7-c38b-4bb8dd10181f@redhat.com>
Date: Wed, 11 Mar 2020 11:46:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200130152218.7600-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L1Z9oEXCecp5fwZzFiSePy6lBakbZShvK"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
--L1Z9oEXCecp5fwZzFiSePy6lBakbZShvK
Content-Type: multipart/mixed; boundary="Q3rqbGIM0BxwsuRAaEfW1zOiXlIQNAqzN"

--Q3rqbGIM0BxwsuRAaEfW1zOiXlIQNAqzN
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.01.20 16:22, Vladimir Sementsov-Ogievskiy wrote:
> If we failed to probe request_align, we fallback to max_align. But
> this is wrong, if file size is not aligned to our max_align. Let's
> instead chose alignment so that file size is a multiple of it.

It=92s entirely possible that the file size is not aligned to the request
alignment, though.  If so, this patch will make the whole file inaccessible=
.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/file-posix.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 7f366046c2..e9c4e509f6 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -385,11 +385,25 @@ static void raw_probe_alignment(BlockDriverState *b=
s, int fd, Error **errp)
>              align =3D alignments[i];
>              if (raw_is_io_aligned(fd, buf, align)) {
>                  /* Fallback to safe value. */
> -                bs->bl.request_alignment =3D (align !=3D 1) ? align : ma=
x_align;
> +                bs->bl.request_alignment =3D align;

The comment above is now outdated.

Max

>                  break;
>              }
>          }
>          qemu_vfree(buf);
> +
> +        if (bs->bl.request_alignment =3D=3D 1) {
> +            /*
> +             * Succeed to read with alignment =3D 1. But it may be unall=
ocated
> +             * area on XFS, and we'll fail later if keep request_alignme=
nt =3D 1.
> +             *
> +             * Chose safer alignment, keeping in mind file size if possi=
ble.
> +             */
> +
> +            int64_t len =3D raw_getlength_fd(bs, fd);
> +
> +            bs->bl.request_alignment =3D
> +                    len <=3D 0 ? max_align : MIN(max_align, len & ~(len =
- 1));
> +        }
>      }
> =20
>      if (!s->buf_align) {
>=20



--Q3rqbGIM0BxwsuRAaEfW1zOiXlIQNAqzN--

--L1Z9oEXCecp5fwZzFiSePy6lBakbZShvK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5owYAACgkQ9AfbAGHV
z0AdMgf8CGsKhOZZED+o4THxV58+sXZpXYY7imMvpjkQPKcSgE6qRQiinQHXQnpw
bUhioR6v/Ivm3Q0+VJJM3lJYSp9wPZgjndJw0U3S1pYVQ3xLxGkaT9fmm3PAYACb
K1uDTPJ57hnjcCubPUK/RQz0odoogx1nEvAC6CDLmbsQJNl2zBRbD9pbty+MHYiO
XLkTzsWWpczDU10ddqK2HvLT6Oz+a9uzONkm51jER/cRSswClbLJud20Ov1KASI3
EHPv1NhQgGaifTmgTUQz9jl4Np4fi/FhKMk3SW414kup7Qe+qvWuGyv/0eowxmDr
CvuhIoFT4bZdARlIeUCd/39/GfVUyw==
=Xhsj
-----END PGP SIGNATURE-----

--L1Z9oEXCecp5fwZzFiSePy6lBakbZShvK--



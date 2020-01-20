Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1FAC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:02:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3BF221D7E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+1u/2fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3BF221D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXcv-0004ei-Hf
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37185)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itXZz-00027F-B0
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itXZx-0006Zd-Sm
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:58:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52866
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itXZx-0006ZI-O4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 08:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579528737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=qGFJmhzf8T0N9yMw1CDSILmjFjkLXVFk2CH2Wtu4g3Y=;
 b=J+1u/2fANzNQGwOKb++B/IpEoZiZZPTg4+EIOuckfOIGdk1kpA0GStjLun7NmxWdvrTcIE
 X/2ciPq5MnIlSPN9I9aFR8Ema8FCdQql2+0HxPJWuns5f7KWmxvNEWFoAwqVeYY2YrFwr2
 zl9b7m/PhPzJSvcy3CjgdxM1H1sjk4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-DAUhkaRrP3eD6gtLho3trg-1; Mon, 20 Jan 2020 08:58:56 -0500
X-MC-Unique: DAUhkaRrP3eD6gtLho3trg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A93411005512;
 Mon, 20 Jan 2020 13:58:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04DA980892;
 Mon, 20 Jan 2020 13:58:49 +0000 (UTC)
Subject: Re: [PATCH v3 07/10] block/dirty-bitmap: improve _next_dirty_area API
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-8-vsementsov@virtuozzo.com>
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
Message-ID: <19eb1ec8-4532-5287-0c20-6b7749491da1@redhat.com>
Date: Mon, 20 Jan 2020 14:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191219100348.24827-8-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EWNG4zvxJrBbKEnwWv3a2vLdYq8yQFiml"
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EWNG4zvxJrBbKEnwWv3a2vLdYq8yQFiml
Content-Type: multipart/mixed; boundary="tAzqNWfozKuhAz2UFjaBRrMdy8C8RJ0PO"

--tAzqNWfozKuhAz2UFjaBRrMdy8C8RJ0PO
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
> Firstly, _next_dirty_area is for scenarios when we may contiguously
> search for next dirty area inside some limited region, so it is more
> comfortable to specify "end" which should not be recalculated on each
> iteration.
>=20
> Secondly, let's add a possibility to limit resulting area size, not
> limiting searching area. This will be used in NBD code in further
> commit. (Note that now bdrv_dirty_bitmap_next_dirty_area is unused)
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/dirty-bitmap.h |  3 ++-
>  include/qemu/hbitmap.h       | 25 ++++++++++++---------
>  block/dirty-bitmap.c         |  6 +++--
>  tests/test-hbitmap.c         | 43 +++++++++++++++++++++++-------------
>  util/hbitmap.c               | 41 +++++++++++++++++++++-------------
>  5 files changed, 74 insertions(+), 44 deletions(-)

[...]

>  /**
> diff --git a/tests/test-hbitmap.c b/tests/test-hbitmap.c
> index e3f1b3f361..d75e84a76a 100644
> --- a/tests/test-hbitmap.c
> +++ b/tests/test-hbitmap.c
> @@ -920,18 +920,19 @@ static void test_hbitmap_next_x_after_truncate(Test=
HBitmapData *data,
>      test_hbitmap_next_x_check(data, 0);
>  }
> =20
> -static void test_hbitmap_next_dirty_area_check(TestHBitmapData *data,
> -                                               int64_t offset,
> -                                               int64_t count)
> +static void test_hbitmap_next_dirty_area_check_limited(TestHBitmapData *=
data,
> +                                                       int64_t offset,
> +                                                       int64_t count,
> +                                                       int64_t max_dirty=
)
>  {
>      int64_t off1, off2;
>      int64_t len1 =3D 0, len2;
>      bool ret1, ret2;
>      int64_t end;
> =20
> -    off1 =3D offset;
> -    len1 =3D count;
> -    ret1 =3D hbitmap_next_dirty_area(data->hb, &off1, &len1);
> +    ret1 =3D hbitmap_next_dirty_area(data->hb,
> +            offset, count =3D=3D INT64_MAX ? INT64_MAX : offset + count,=
 max_dirty,
> +            &off1, &len1);
> =20
>      end =3D offset > data->size || data->size - offset < count ? data->s=
ize :
>                                                                 offset + =
count;
> @@ -940,21 +941,25 @@ static void test_hbitmap_next_dirty_area_check(Test=
HBitmapData *data,
>          ;

These empty statements look a bit weird to me.  But they=92re
pre-existing, obviously.

>      }
> =20
> -    for (len2 =3D 1; off2 + len2 < end && hbitmap_get(data->hb, off2 + l=
en2);
> -         len2++) {
> +    for (len2 =3D 1; (off2 + len2 < end && len2 < max_dirty &&
> +                    hbitmap_get(data->hb, off2 + len2)); len2++)
> +    {
>          ;
>      }

[...]

> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index d23f4b9678..2a1661ec1d 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -270,22 +270,34 @@ int64_t hbitmap_next_zero(const HBitmap *hb, int64_=
t start, int64_t count)
>      return res;
>  }
> =20
> -bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t *start, int64_t =
*count)
> +bool hbitmap_next_dirty_area(const HBitmap *hb, int64_t start, int64_t e=
nd,
> +                             int64_t max_dirty_count,
> +                             int64_t *dirty_start, int64_t *dirty_count)
>  {
> -    int64_t area_start, area_end;
> +    int64_t next_zero;
> =20
> -    area_start =3D hbitmap_next_dirty(hb, *start, *count);
> -    if (area_start < 0) {
> +    assert(start >=3D 0 && end >=3D 0 && max_dirty_count > 0);
> +
> +    if (start >=3D hb->orig_size || end <=3D start) {
> +        return false;
> +    }
> +
> +    end =3D MIN(end, hb->orig_size);

You could put this assignment before the if () and then drop the =93start=
=94
check from the condition.  (But that=92s mostly me itching to do
optimizations.  I don=92t think it=92d make the code easier to read.)

[...]

> @@ -844,13 +856,12 @@ static void hbitmap_sparse_merge(HBitmap *dst, cons=
t HBitmap *src)
>      int64_t offset =3D 0;
>      int64_t count =3D src->orig_size;

These initializations are now unnecessary.  I=92d drop them because I find
at least the one for @count a tiny bit confusing now.  (Because as a
reader, I=92d wonder where this value is used.)

With that done (or maybe not because you disagree):

Reviewed-by: Max Reitz <mreitz@redhat.com>

> =20
> -    while (hbitmap_next_dirty_area(src, &offset, &count)) {
> +    for (offset =3D 0;
> +         hbitmap_next_dirty_area(src, offset, src->orig_size, INT64_MAX,
> +                                 &offset, &count);
> +         offset +=3D count)
> +    {
>          hbitmap_set(dst, offset, count);
> -        offset +=3D count;
> -        if (offset >=3D src->orig_size) {
> -            break;
> -        }
> -        count =3D src->orig_size - offset;
>      }
>  }
> =20
>=20


--tAzqNWfozKuhAz2UFjaBRrMdy8C8RJ0PO--

--EWNG4zvxJrBbKEnwWv3a2vLdYq8yQFiml
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4lshcACgkQ9AfbAGHV
z0CNVgf/SeH51c6WLJphxL5FANMaCRoiXJuD3kbQEaUC7ABTQF2NoiFMq5sWGR3s
CiFcZLkRdx62eQ/9BQ0SpaJxpAe+Zu9rhqvHdwvb/Lxk0KKMs70IO2gX36d+fgnc
aSabueIUvveqC3F5AfvGPjXEkQNuWRvy/UyD9vKo7y0OmDgL8ljgIRCPXshF0ijQ
RawDzM+Mp3yAhO8gLaBdZrIi01aixWQU8iTMzRaEjyVgHQnTtjemUzI8FBVnJmgB
FU7IaYiJkKEQtIPdCJTG/ddwskRkoUXhs9818lJNGCi2avRTAlvJ85RDcsNLpvT3
fig+LF8V+1G9EeIAwWNMmyqp5SkxuA==
=+N0N
-----END PGP SIGNATURE-----

--EWNG4zvxJrBbKEnwWv3a2vLdYq8yQFiml--



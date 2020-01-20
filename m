Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1747C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:01:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662D2208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjuTdJhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662D2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itVk5-0004Dj-GC
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:01:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itViu-0003aq-5c
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:00:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itViq-0001aX-7f
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:00:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46951
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itViq-0001a0-3J
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579521599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wmuPfVtIy4EaXy11c3TQdws0BYdgh1SzcGXR+OuHDeE=;
 b=DjuTdJhEL0O50XfVLmZDD+R33nn+Ika1Il4tDQCFk455U3/i9vAUIaMx39fqQ+JMdCQ/ag
 2vEQKLy4UD/cwofREpC13bjw54QreCUymJFqanL/gzKCeBnAR+L0uHlXa7NEYpHO8HAZ4r
 jHe3LLyRUvir+Lka5kG/SAR9hyxt11M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-xIzMGBGGNC6SvMmmbVnC8w-1; Mon, 20 Jan 2020 06:59:55 -0500
X-MC-Unique: xIzMGBGGNC6SvMmmbVnC8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B11A7107ACCD;
 Mon, 20 Jan 2020 11:59:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B435E10013A7;
 Mon, 20 Jan 2020 11:59:49 +0000 (UTC)
Subject: Re: [PATCH v3 05/10] block/dirty-bitmap: switch _next_dirty_area and
 _next_zero to int64_t
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-6-vsementsov@virtuozzo.com>
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
Message-ID: <ee73d55c-7f4f-fda1-b651-ced940027b62@redhat.com>
Date: Mon, 20 Jan 2020 12:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191219100348.24827-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EcHiIStijgkUS9omHCVHKU9XM63BfMMQi"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
--EcHiIStijgkUS9omHCVHKU9XM63BfMMQi
Content-Type: multipart/mixed; boundary="OTMIcfc3IkyvxMb9v9Fwz1i96CzcTY9VO"

--OTMIcfc3IkyvxMb9v9Fwz1i96CzcTY9VO
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
> We are going to introduce bdrv_dirty_bitmap_next_dirty so that same
> variable may be used to store its return value and to be its parameter,
> so it would int64_t.
>=20
> Similarly, we are going to refactor hbitmap_next_dirty_area to use
> hbitmap_next_dirty together with hbitmap_next_zero, therefore we want
> hbitmap_next_zero parameter type to be int64_t too.
>=20
> So, for convenience update all parameters of *_next_zero and
> *_next_dirty_area to be int64_t.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/dirty-bitmap.h |  6 +++---
>  include/qemu/hbitmap.h       |  7 +++----
>  block/dirty-bitmap.c         |  6 +++---
>  nbd/server.c                 |  2 +-
>  tests/test-hbitmap.c         | 32 ++++++++++++++++----------------
>  util/hbitmap.c               | 13 ++++++++-----
>  6 files changed, 34 insertions(+), 32 deletions(-)

[...]

> diff --git a/util/hbitmap.c b/util/hbitmap.c
> index b6d4b99a06..df22f06be6 100644
> --- a/util/hbitmap.c
> +++ b/util/hbitmap.c
> @@ -193,7 +193,7 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBitma=
p *hb, uint64_t first)
>      }
>  }
> =20
> -int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t co=
unt)
> +int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t coun=
t)
>  {
>      size_t pos =3D (start >> hb->granularity) >> BITS_PER_LEVEL;
>      unsigned long *last_lev =3D hb->levels[HBITMAP_LEVELS - 1];
> @@ -202,6 +202,8 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t=
 start, uint64_t count)
>      uint64_t end_bit, sz;
>      int64_t res;
> =20
> +    assert(start >=3D 0 && count >=3D 0);
> +
>      if (start >=3D hb->orig_size || count =3D=3D 0) {
>          return -1;
>      }
As far as I can see, NBD just passes NBDRequest.from (which is a
uint64_t) to this function (on NBD_CMD_BLOCK_STATUS).  Would this allow
a malicious client to send a value > INT64_MAX, thus provoking an
overflow and killing the server with this new assertion?

On second thought, we have this problem already everywhere in
nbd_handle_request().  I don=92t see it or its caller ever checking
whether the received values are in bounds, it just passes them to all
kind of block layer functions that sometimes even just accept plain
ints.  Well, I suppose all other functions just error out, so it
probably isn=92t an actual problem in practice so far...

Max


--OTMIcfc3IkyvxMb9v9Fwz1i96CzcTY9VO--

--EcHiIStijgkUS9omHCVHKU9XM63BfMMQi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4lljMACgkQ9AfbAGHV
z0CPrgf/UVubr505h70KTUvMr84HddLJN8C+rn8eb+rpKxYjGXfU79GDXiQMOxdm
6uG2Gko5xvLJq2pki1TVNFU1oIFCaOEHRWuRDOAqhROGnGyKlejVVQqSZsuqsU69
yNSyt+DN1i2/CGjMGHOouDLdeXp7uqEfWRqBK1weCqUb28IGeGsSi4hcFNdIOICm
cYZriJ0XZbDGAo7WN1U77HMF7xONGlE9CsUrX9vh4daDp1Wc1grWmbY+2BDnXOHn
/J1B7SCoXV0SJHsgpzMP1EA8Wa78/zqhv28dvFySlpHMYdYcZGyNcOpP5u8v+z+L
BQpL15az+NTJ+uwKfMB97iq3QSrdKg==
=7A4P
-----END PGP SIGNATURE-----

--EcHiIStijgkUS9omHCVHKU9XM63BfMMQi--



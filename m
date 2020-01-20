Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5106C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:54:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A446C22314
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoDFZT1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A446C22314
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itWZn-0000gf-Dz
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:54:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1itWYf-0007fv-BX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1itWYa-0005w9-LX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:53:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56788)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1itWYa-0005uW-GV
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579524807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OfFNGzgmcp5jCpEGImUfOqtEce1SOY7GN9W+mo5fLzI=;
 b=HoDFZT1bEvJoUwnWKGQ+5IyqIct58DnHHJM9oraHKyChKlNhvnlR7gYVQMEemBCoYsa730
 6piFhF4jBjJWIHWNRJQOGpaZrMkSl70QUdhb0wI+tnglF46f/EsRG4n43bAUqgXT83VGVg
 nUVDj8LuLQugfv2M6IUBxY5EdPYYLno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-U710Gpk-NTKQMzyOfGzGxg-1; Mon, 20 Jan 2020 07:53:22 -0500
X-MC-Unique: U710Gpk-NTKQMzyOfGzGxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0AEA801E77;
 Mon, 20 Jan 2020 12:53:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-225.ams2.redhat.com
 [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F676860E0;
 Mon, 20 Jan 2020 12:53:15 +0000 (UTC)
Subject: Re: [PATCH v3 05/10] block/dirty-bitmap: switch _next_dirty_area and
 _next_zero to int64_t
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20191219100348.24827-1-vsementsov@virtuozzo.com>
 <20191219100348.24827-6-vsementsov@virtuozzo.com>
 <ee73d55c-7f4f-fda1-b651-ced940027b62@redhat.com>
 <c2f78255-c001-01a3-487a-f7cf224f86f8@virtuozzo.com>
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
Message-ID: <4b3d64c2-2294-4025-dc97-e4747b72baec@redhat.com>
Date: Mon, 20 Jan 2020 13:53:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <c2f78255-c001-01a3-487a-f7cf224f86f8@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IuPkyYz2srU1c6lrno7vRSCNmmjjieImb"
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IuPkyYz2srU1c6lrno7vRSCNmmjjieImb
Content-Type: multipart/mixed; boundary="ayP0GMUOMrBJJC6d6oHFJrm6XQQgqI1z5"

--ayP0GMUOMrBJJC6d6oHFJrm6XQQgqI1z5
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.01.20 13:28, Vladimir Sementsov-Ogievskiy wrote:
> 20.01.2020 14:59, Max Reitz wrote:
>> On 19.12.19 11:03, Vladimir Sementsov-Ogievskiy wrote:
>>> We are going to introduce bdrv_dirty_bitmap_next_dirty so that same
>>> variable may be used to store its return value and to be its parameter,
>>> so it would int64_t.
>>>
>>> Similarly, we are going to refactor hbitmap_next_dirty_area to use
>>> hbitmap_next_dirty together with hbitmap_next_zero, therefore we want
>>> hbitmap_next_zero parameter type to be int64_t too.
>>>
>>> So, for convenience update all parameters of *_next_zero and
>>> *_next_dirty_area to be int64_t.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>   include/block/dirty-bitmap.h |  6 +++---
>>>   include/qemu/hbitmap.h       |  7 +++----
>>>   block/dirty-bitmap.c         |  6 +++---
>>>   nbd/server.c                 |  2 +-
>>>   tests/test-hbitmap.c         | 32 ++++++++++++++++----------------
>>>   util/hbitmap.c               | 13 ++++++++-----
>>>   6 files changed, 34 insertions(+), 32 deletions(-)
>>
>> [...]
>>
>>> diff --git a/util/hbitmap.c b/util/hbitmap.c
>>> index b6d4b99a06..df22f06be6 100644
>>> --- a/util/hbitmap.c
>>> +++ b/util/hbitmap.c
>>> @@ -193,7 +193,7 @@ void hbitmap_iter_init(HBitmapIter *hbi, const HBit=
map *hb, uint64_t first)
>>>       }
>>>   }
>>>  =20
>>> -int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, uint64_t =
count)
>>> +int64_t hbitmap_next_zero(const HBitmap *hb, int64_t start, int64_t co=
unt)
>>>   {
>>>       size_t pos =3D (start >> hb->granularity) >> BITS_PER_LEVEL;
>>>       unsigned long *last_lev =3D hb->levels[HBITMAP_LEVELS - 1];
>>> @@ -202,6 +202,8 @@ int64_t hbitmap_next_zero(const HBitmap *hb, uint64=
_t start, uint64_t count)
>>>       uint64_t end_bit, sz;
>>>       int64_t res;
>>>  =20
>>> +    assert(start >=3D 0 && count >=3D 0);
>>> +
>>>       if (start >=3D hb->orig_size || count =3D=3D 0) {
>>>           return -1;
>>>       }
>> As far as I can see, NBD just passes NBDRequest.from (which is a
>> uint64_t) to this function (on NBD_CMD_BLOCK_STATUS).  Would this allow
>> a malicious client to send a value > INT64_MAX, thus provoking an
>> overflow and killing the server with this new assertion?
>=20
>=20
> in nbd_co_receive_request() we have
>=20
>=20
>      if (request->from > client->exp->size ||
>          request->len > client->exp->size - request->from) {
>=20
>=20
> So, we check that from is <=3D exp->size. and exp->size cant be greater t=
han INT64_MAX,
> as it derived from bdrv_getlength, which returns int64_t.

Ah, OK, so I just overlooked that.

> Interesting, should we be more strict in server:?
>=20
> --- a/nbd/server.c
> +++ b/nbd/server.c
> @@ -2178,7 +2178,7 @@ static int nbd_co_receive_request(NBDRequestData *r=
eq, NBDRequest *request,
>           error_setg(errp, "Export is read-only");
>           return -EROFS;
>       }
> -    if (request->from > client->exp->size ||
> +    if (request->from >=3D client->exp->size ||
>           request->len > client->exp->size - request->from) {
>           error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %=
" PRIu32
>                      ", Size: %" PRIu64, request->from, request->len,
>=20
> Or is it intentional? Looking through NBD spec I found only
>=20
>     client MUST NOT use a length ... or which, when added to offset, woul=
d exceed the export size.
>=20
> So, formally pair offset=3D<export size>, len=3D0 is valid...

Sounds valid, yes.

In any case:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--ayP0GMUOMrBJJC6d6oHFJrm6XQQgqI1z5--

--IuPkyYz2srU1c6lrno7vRSCNmmjjieImb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4lorkACgkQ9AfbAGHV
z0B81QgApdWpz+xmFff2IApqyl/0JbCyS0auBfcVpKJW1Bo68VaVauqUYf5Zk42C
yTCO9cXssNX0+L8tY/HSaevWnZMWq2mhLe8JyXLxcfZ30sgMKB0YYbMMJ+jYorSH
HyCO10uu1+MuChYHdGX33t7tK8NmPyfNFB8APyVMruGRY1AiYMwo5/6HW8EOJTOC
rZH8v+84wX+BuLZwEzp/lu+R47NixLFQiqZneDQwLXYgtrnAhnc8/tQDvYWkhmPC
KS8lTNlLHF1/7vIfjawVGNnTAfuc9W9JJAADANHXBkmWUZ57jm9BEXQ8POHcPVr0
2Vij9GCJhtUOcamhj3wTZS02o75gEQ==
=dNFM
-----END PGP SIGNATURE-----

--IuPkyYz2srU1c6lrno7vRSCNmmjjieImb--



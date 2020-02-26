Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80624C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B08421927
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuwbKClc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B08421927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6w0G-0001pg-G7
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:41:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6vyJ-00082y-Fa
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6vyH-0002kn-C9
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:39:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28365
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6vyH-0002ZS-43
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582720763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kdVpJT9tXw+8/qEIHJD1Qfkzt2AgB486ZioBgQNakBo=;
 b=MuwbKClc3DzXdup1afymXMMBvAKVTHmmoFauuMUp8+0lL6Jpnd6VZSbiWO2myNhrIU3eAM
 tg7vFS6J23WNnuFH9dRHWRLJrtYi71GuLf4YVCRjtlTATte3qvFZPcW5eji4BUxGlUcIgS
 3jD9HMnfWdbNY/WcI9Pjrxr9bk8lFpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-aUYJ_tbsP0mJGwrtsD0mxA-1; Wed, 26 Feb 2020 07:39:16 -0500
X-MC-Unique: aUYJ_tbsP0mJGwrtsD0mxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6F9B107ACC5;
 Wed, 26 Feb 2020 12:39:15 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A31EA60BE1;
 Wed, 26 Feb 2020 12:39:13 +0000 (UTC)
Subject: Re: [PATCH v4 05/10] block/dirty-bitmap: switch _next_dirty_area and
 _next_zero to int64_t
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
 <20200205112041.6003-6-vsementsov@virtuozzo.com>
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
Message-ID: <5682334c-de49-405c-81f8-774e6e9baf60@redhat.com>
Date: Wed, 26 Feb 2020 13:39:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205112041.6003-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WxSvJNmeTz0p7JwpTaarPFQY4YPzWXAqD"
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WxSvJNmeTz0p7JwpTaarPFQY4YPzWXAqD
Content-Type: multipart/mixed; boundary="Kqb31gyB7d3V3mnqlSw4tH1MQuEEAlp85"

--Kqb31gyB7d3V3mnqlSw4tH1MQuEEAlp85
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.02.20 12:20, Vladimir Sementsov-Ogievskiy wrote:
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
>  tests/test-hbitmap.c         | 36 ++++++++++++++++++------------------
>  util/hbitmap.c               | 13 ++++++++-----
>  6 files changed, 36 insertions(+), 34 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Kqb31gyB7d3V3mnqlSw4tH1MQuEEAlp85--

--WxSvJNmeTz0p7JwpTaarPFQY4YPzWXAqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5WZu8ACgkQ9AfbAGHV
z0Avbwf9EwHid4n8zH+scCwT9rKX/Bg/CbLHxlnVw1NZVBplnOEZLBWDIB9wxqbV
vNrjTzjQfeXHsYHGKeZgwcBYZQLKx2DFDN9DOdNIcbiWfXxMrJ4BqMvw/opJt9ei
TTzvaS2BIR8jvDh1PYh5Wf46S0qMItYf5Cs7W3qTX6JSVworhKRgXWkqreAl5FMi
eW92TJpgx+IMQEd+sS69X7NYcwtKgR3L2FZ/gzb3WqCwxGS3Vz+yCUrJNX85QUlm
ZPax4j7g1saV2bcRZh9JfsaKUCclkVi60MpmzNpM22tH7SdQRmQa2S0BvoAmAHG3
EBPrQvrWARudGbmqTOVWMS/WrczjaA==
=6a3q
-----END PGP SIGNATURE-----

--WxSvJNmeTz0p7JwpTaarPFQY4YPzWXAqD--



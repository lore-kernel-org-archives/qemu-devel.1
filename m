Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A49C010CF
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56CA21929
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIQg9ho/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56CA21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRxb6-0007Ug-Uy
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 07:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRxaS-0006tr-73
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRxaP-0008LI-HO
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:05:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21926
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRxaP-0008Kr-Cf
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572955524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OSq4wVaWgbKSQqmXCpzJTxWsHZE0tPV4Uom0iHXpKDw=;
 b=LIQg9ho/fNpD39sYBKguLN6FZD4W16IWlQmtFstZrEdmU45vrB9UfeT0p+dGKFatrbNa2O
 jzyptTRPY4FBspKUA1xMrDbEsaZtZnhC1y7SNjacyUImzB8DXx0KImldx4nJtrWRhv8SM6
 dBmc+inhjhHy40Ur1YrVFu6gqzdyGOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-aZKdPTkkPQqEaByg56s92A-1; Tue, 05 Nov 2019 07:05:22 -0500
X-MC-Unique: aZKdPTkkPQqEaByg56s92A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AA44801E54;
 Tue,  5 Nov 2019 12:05:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-89.ams2.redhat.com
 [10.36.117.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DFEF5D72B;
 Tue,  5 Nov 2019 12:05:14 +0000 (UTC)
Subject: Re: [RFC PATCH v2 22/26] qcow2: Add subcluster support to
 handle_alloc_space()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <fbda07b0459d62445ec3e32c80e1baa7708a1cd7.1572125022.git.berto@igalia.com>
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
Message-ID: <205ff5db-cbaf-03a4-8df4-f505bc63ecaa@redhat.com>
Date: Tue, 5 Nov 2019 13:05:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <fbda07b0459d62445ec3e32c80e1baa7708a1cd7.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hz8yIfvBPjkkR1rZwe9vlyLJg8F7tgvtR"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hz8yIfvBPjkkR1rZwe9vlyLJg8F7tgvtR
Content-Type: multipart/mixed; boundary="H0EtTGy2Et5lhXmLNgyuFxiHRR8yODb6J"

--H0EtTGy2Et5lhXmLNgyuFxiHRR8yODb6J
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> The bdrv_co_pwrite_zeroes() call here fills complete clusters with
> zeroes, but it can happen that some subclusters are not part of the
> write request or the copy-on-write. This patch makes sure that only
> the affected subclusters are overwritten.
>=20
> A potential improvement would be to also fill with zeroes the other
> subclusters if we can guarantee that we are not overwriting existing
> data. However this would waste more disk space, so we should first
> evaluate if it's really worth doing.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 0261e87709..01322ca449 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2304,6 +2304,9 @@ static int handle_alloc_space(BlockDriverState *bs,=
 QCowL2Meta *l2meta)
> =20
>      for (m =3D l2meta; m !=3D NULL; m =3D m->next) {
>          int ret;
> +        uint64_t start_offset =3D m->alloc_offset + m->cow_start.offset;
> +        uint64_t nb_bytes =3D m->cow_end.offset + m->cow_end.nb_bytes -
> +            m->cow_start.offset;

It might be more honest to make nb_bytes an unsigned.  (There shouldn=E2=80=
=99t
be any overflows here, because the total size is limited to INT64_MAX by
handle_alloc().)

Max

>          if (!m->cow_start.nb_bytes && !m->cow_end.nb_bytes) {
>              continue;


--H0EtTGy2Et5lhXmLNgyuFxiHRR8yODb6J--

--Hz8yIfvBPjkkR1rZwe9vlyLJg8F7tgvtR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3BZXgACgkQ9AfbAGHV
z0ArvQgAqO4r+OiEITYVz0hXv50UmB4OqSVScs8xaMjavUQeiKof+5xCQ21PdpSH
8oaJTUZtk25Tjg7G9m/XXwa4YKmm4KKQHK0kXXUiXuYSZoe+DYHOxuiWFzAjp+pt
cm4AdzyDkFwNlMl3YMpmgOIOrqPBXdXK1kkSckm6AhYF8kxdo31ri4xGY3dzYydg
XxZJIWiF6PyZCmRvkt86GlJFINBoH2k+lq24j2sgGPnQaDDLcmobMuVK3FYTxmcc
V4AiKcfpkYo/ymAGTgXpikLO69g6EFv5NL9BNPFf5JGt+Sq+chCAkWlGMVTmr13w
2q05L8Zwjaev9PuXnahGR7EfNvubjQ==
=uxpq
-----END PGP SIGNATURE-----

--Hz8yIfvBPjkkR1rZwe9vlyLJg8F7tgvtR--



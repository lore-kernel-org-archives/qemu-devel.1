Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6774CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:51:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826A620640
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 12:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmN3RYd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826A620640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNG6n-0002CW-Mh
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 08:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iNG59-0000mC-Gf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iNG55-0000h2-US
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:49:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iNG55-0000gC-QN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 08:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571834978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2drKH3bfIEIwUV6v9S9YcIio7RUi/utcT+omv/V3AP0=;
 b=ZmN3RYd5D+jbFGUf4uB2/DvgrW0HW8/WGvQIJYFrlIqKyKF0PHsB5CzEK0H1pPS3BiqDMn
 yW5D3rZqOqs9SZYc8JeI4sRnHH3ur74PeVtkoTQ8vw62rKT1ej+UBus7iKBCkaBTop983U
 FWhYOPEtxJGtsVeWu/RDAqSJThft2bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-lLJWO7hoMwGabhK9WDBRQA-1; Wed, 23 Oct 2019 08:49:35 -0400
X-MC-Unique: lLJWO7hoMwGabhK9WDBRQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6385A800D58;
 Wed, 23 Oct 2019 12:49:33 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-164.ams2.redhat.com
 [10.36.117.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 35EF160624;
 Wed, 23 Oct 2019 12:49:30 +0000 (UTC)
Subject: Re: [PATCH v6 1/4] block/replication.c: Ignore requests after failover
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
References: <cover.1570280098.git.lukasstraub2@web.de>
 <596a6f07850002a09461f317afa75f3e0c9bb784.1570280098.git.lukasstraub2@web.de>
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
Message-ID: <26551274-6bb9-734f-0131-a146742d22f3@redhat.com>
Date: Wed, 23 Oct 2019 14:49:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <596a6f07850002a09461f317afa75f3e0c9bb784.1570280098.git.lukasstraub2@web.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gQDb66vAi78CHfw7SiyZUN6elSqWzYdhL"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>, Jason Wang <jasowang@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>, Xie Changlong <xiechanglong.d@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gQDb66vAi78CHfw7SiyZUN6elSqWzYdhL
Content-Type: multipart/mixed; boundary="1PZRqyJZ2HD4X2ptnOokpBHPMaO46ONEL"

--1PZRqyJZ2HD4X2ptnOokpBHPMaO46ONEL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.10.19 15:05, Lukas Straub wrote:
> After failover the Secondary side of replication shouldn't change state, =
because
> it now functions as our primary disk.
>=20
> In replication_start, replication_do_checkpoint, replication_stop, ignore
> the request if current state is BLOCK_REPLICATION_DONE (sucessful failove=
r) or
> BLOCK_REPLICATION_FAILOVER (failover in progres i.e. currently merging ac=
tive
> and hidden images into the base image).
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Reviewed-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  block/replication.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)

Disclaimer: I don=E2=80=99t know anything about the replication block drive=
r.

> diff --git a/block/replication.c b/block/replication.c
> index 3d4dedddfc..97cc65c0cf 100644
> --- a/block/replication.c
> +++ b/block/replication.c

[...]

> @@ -529,8 +540,7 @@ static void replication_start(ReplicationState *rs, R=
eplicationMode mode,
>                     "Block device is in use by internal backup job");
>=20
>          top_bs =3D bdrv_lookup_bs(s->top_id, s->top_id, NULL);
> -        if (!top_bs || !bdrv_is_root_node(top_bs) ||
> -            !check_top_bs(top_bs, bs)) {
> +        if (!top_bs || !check_top_bs(top_bs, bs)) {

It appears to me that top_bs is only used to install op blockers.  It
seems reasonable to require a root node to be able to do so (because op
blockers are really only checked on a root node).
(And the commit message doesn=E2=80=99t tell why we=E2=80=99d want to drop =
the
is_root_node check here.)

Now OTOH I don=E2=80=99t know whether the replication driver needs an op bl=
ocker
at all or whether the permission system suffices...

I suppose the rest of this patch is not really about the block layer, so
I can=E2=80=99t really comment on it.  (It looks OK to me from a generic an=
d
na=C3=AFve standpoint, though.)

>              error_setg(errp, "No top_bs or it is invalid");
>              reopen_backing_file(bs, false, NULL);
>              aio_context_release(aio_context);

[...]

> @@ -593,7 +614,7 @@ static void replication_get_error(ReplicationState *r=
s, Error **errp)
>      aio_context_acquire(aio_context);
>      s =3D bs->opaque;
>=20
> -    if (s->stage !=3D BLOCK_REPLICATION_RUNNING) {
> +    if (s->stage =3D=3D BLOCK_REPLICATION_NONE) {

Just one question out of curiosity, though: Is this a bug fix?

Max

>          error_setg(errp, "Block replication is not running");
>          aio_context_release(aio_context);
>          return;


--1PZRqyJZ2HD4X2ptnOokpBHPMaO46ONEL--

--gQDb66vAi78CHfw7SiyZUN6elSqWzYdhL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2wTFkACgkQ9AfbAGHV
z0Co2ggAnsi0qIv6uPEUEadTYWw3jeYSSQbJmidvDE+TOBJyK38wftbxdzD8eM6O
iGC/uIlp9kv5bYt8eCY2QJu5aw202sqf0PPZO/AuMwviiNsZDazEU9bs2UJXao90
ym/b8jw2Xi+e46br05mmMj2aA7ZBDU23mlqUaWwt2t4IStov+VbGqdCvOBlrgLZW
a3ZXUvlBhSb61yHtL+uajLupUtOTxdN0G3og+PdwbrBN4ThaoDJk6sQJLAUCgfZr
+Dy/ykVlwDH2ta8XFQvVHKn9ntNMV2kyR5hURz5FKcjAh7RkiDC7jqols4XQlgUr
+W1P74xJZOx3m4Knqx7JYofPfSX3Iw==
=JGtc
-----END PGP SIGNATURE-----

--gQDb66vAi78CHfw7SiyZUN6elSqWzYdhL--



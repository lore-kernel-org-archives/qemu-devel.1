Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C66C35658
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:45:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9218206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 15:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCQ54gd8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9218206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AU8-0004cZ-1d
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 10:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39535)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j5AT1-0003dk-Uz
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j5AT0-0002bd-BD
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:43:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24541
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j5AT0-0002bI-5Q
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 10:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582299829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BtVtr806scyry8gkoFv+uPfSnaZ9wkJ4bZzQEWoo2sM=;
 b=NCQ54gd8C7gLOsbkplgIvkEkXee43JdTQeXTHHQYxoTnstb3KvtdUyexou3kxwdZIs8HBv
 4Run25xodPlDqTKjGVMpBxca6dli+bo4g6jvOO1ATd2R76vL5rIKTWjpMVGfhuj5qCxXf0
 kuP7ZXD2XfSyOBslMKe9s+f+4zwI2Eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-BNFQnimENzW15Tyx68y6Cw-1; Fri, 21 Feb 2020 10:43:47 -0500
X-MC-Unique: BNFQnimENzW15Tyx68y6Cw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D884D1083E85;
 Fri, 21 Feb 2020 15:43:44 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6AE690F69;
 Fri, 21 Feb 2020 15:43:41 +0000 (UTC)
Subject: Re: [RFC PATCH v3 21/27] qcow2: Update L2 bitmap in
 qcow2_alloc_cluster_link_l2()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <4e1c4c2994470119889e8f602b9c98f4d3457e8b.1577014346.git.berto@igalia.com>
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
Message-ID: <f0cd0326-5aba-0df5-6d27-ff42ce7aedbf@redhat.com>
Date: Fri, 21 Feb 2020 16:43:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <4e1c4c2994470119889e8f602b9c98f4d3457e8b.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kuGE3hHYN1vawHYxVNZdWm1GtxFeayvEz"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kuGE3hHYN1vawHYxVNZdWm1GtxFeayvEz
Content-Type: multipart/mixed; boundary="mG4xJW4MAlX1jb645pwIS84bGbZvaGgUD"

--mG4xJW4MAlX1jb645pwIS84bGbZvaGgUD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.19 12:37, Alberto Garcia wrote:
> The L2 bitmap needs to be updated after each write to indicate what
> new subclusters are now allocated.
>=20
> This needs to happen even if the cluster was already allocated and the
> L2 entry was otherwise valid.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 0a40944667..ed291a4042 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -986,6 +986,23 @@ int qcow2_alloc_cluster_link_l2(BlockDriverState *bs=
, QCowL2Meta *m)
> =20
>          set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_COPIED |
>                       (cluster_offset + (i << s->cluster_bits)));
> +
> +        /* Update bitmap with the subclusters that were just written */
> +        if (has_subclusters(s)) {
> +            unsigned written_from =3D m->cow_start.offset;
> +            unsigned written_to =3D m->cow_end.offset + m->cow_end.nb_by=
tes ?:
> +                m->nb_clusters << s->cluster_bits;

I suppose we could also calculate both at the beginning of the function
(I=E2=80=99m not sure whether the compiler can optimize these calculations =
to
happen only once if we don=E2=80=99t).

> +            uint64_t l2_bitmap =3D get_l2_bitmap(s, l2_slice, l2_index +=
 i);
> +            int sc;
> +            for (sc =3D 0; sc < s->subclusters_per_cluster; sc++) {
> +                int sc_off =3D i * s->cluster_size + sc * s->subcluster_=
size;
> +                if (sc_off >=3D written_from && sc_off < written_to) {
> +                    l2_bitmap |=3D QCOW_OFLAG_SUB_ALLOC(sc);
> +                    l2_bitmap &=3D ~QCOW_OFLAG_SUB_ZERO(sc);

Works, but maybe a QCOW_OFLAG_SUB_MASK(sc) would be better for:

l2_bitmap &=3D ~QCOW_OFLAG_SUB_MASK(sc);
l2_bitmap |=3D QCOW_OFLAG_SUB_ALLOC(sc);

Nothing wrong though, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +                }
> +            }
> +            set_l2_bitmap(s, l2_slice, l2_index + i, l2_bitmap);
> +        }
>       }
> =20
> =20
>=20



--mG4xJW4MAlX1jb645pwIS84bGbZvaGgUD--

--kuGE3hHYN1vawHYxVNZdWm1GtxFeayvEz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5P+qsACgkQ9AfbAGHV
z0BfpQgAjEs6O9LXKMAfDFP+7lB/uD8nmMvhmyApKtYSASHIrVX2TfFoolgF10wq
0h5wofKGBFa6/KKb0FTISW9zeT7nrW30SehweNWuUs+IblJVS3Fgum0sy5YMfazT
HpaQWJ6L/GbZ+d02MS3PjJTY3bwrPfYOyOOebPTomdgf7bEuCDdyKVzNa6uarpaK
deNUR2rnXSwmf1J/bXcWG/ZKYAXlPYobIU1Bww4x1b9wvlB3HGSZKHPOWt5PVPQr
9yfp4plPTMLwfUBMR/RoqBXH+Sy8HdK+m6u7lHNf247DX5yfu8y4HjYN64Lknfd4
cqVmaPJpcLIp/SCOOd7guSMzHB+d4A==
=X0vl
-----END PGP SIGNATURE-----

--kuGE3hHYN1vawHYxVNZdWm1GtxFeayvEz--



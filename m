Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51985CA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:05:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C21021850
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 15:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Omw97iTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C21021850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRdvE-0006iE-7Q
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 10:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39027)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRduW-00069x-Ap
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRduU-0008T4-UM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:04:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23217
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRduU-0008Ss-PB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 10:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572879890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MECKPpZ6kY7KSUF1VaDTkGkWb9+rWkOJBkPUubwlZrk=;
 b=Omw97iTtS5gHyFtRUQJW3htzHplG06fcrmAfT+uGrMDjLbZ2Kc8FXEy2RRNTrE4QnOxh2L
 VFn9t39e9FDRbZsQiT6Vy27JCNL0lHEWN2TggBPSyX+4unCg+YT16m4PAi2MRTljWrHYhM
 iUZsHjBwBT/1Ua8CbFsjVVQ2VAWvscc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-nrP_9RjxMYig1hYLNtRrQg-1; Mon, 04 Nov 2019 10:04:46 -0500
X-MC-Unique: nrP_9RjxMYig1hYLNtRrQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7556E107ACC2;
 Mon,  4 Nov 2019 15:04:45 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 912DA60863;
 Mon,  4 Nov 2019 15:04:42 +0000 (UTC)
Subject: Re: [RFC PATCH v2 15/26] qcow2: Add subcluster support to
 zero_in_l2_slice()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1572125022.git.berto@igalia.com>
 <8f366482d2b273c26ff67cba1de898289f613fc7.1572125022.git.berto@igalia.com>
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
Message-ID: <94b1434e-3e0f-bbce-0ba0-67309565bfec@redhat.com>
Date: Mon, 4 Nov 2019 16:04:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8f366482d2b273c26ff67cba1de898289f613fc7.1572125022.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e0EZJ9eMNv1KVO55FhJjQ30RVD9jT4Mk5"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e0EZJ9eMNv1KVO55FhJjQ30RVD9jT4Mk5
Content-Type: multipart/mixed; boundary="dvo5KCnT30buJNSH2inun7OojiMU8bZoV"

--dvo5KCnT30buJNSH2inun7OojiMU8bZoV
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.10.19 23:25, Alberto Garcia wrote:
> Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
> image has subclusters. Instead, the individual 'all zeroes' bits must
> be used.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index e67559152f..3e4ba8d448 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1852,7 +1852,7 @@ static int zero_in_l2_slice(BlockDriverState *bs, u=
int64_t offset,
>      assert(nb_clusters <=3D INT_MAX);
> =20
>      for (i =3D 0; i < nb_clusters; i++) {
> -        uint64_t old_offset;
> +        uint64_t old_offset, l2_entry =3D 0;
>          QCow2ClusterType cluster_type;
> =20
>          old_offset =3D get_l2_entry(s, l2_slice, l2_index + i);
> @@ -1869,12 +1869,18 @@ static int zero_in_l2_slice(BlockDriverState *bs,=
 uint64_t offset,
> =20
>          qcow2_cache_entry_mark_dirty(s->l2_table_cache, l2_slice);
>          if (cluster_type =3D=3D QCOW2_CLUSTER_COMPRESSED || unmap) {
> -            set_l2_entry(s, l2_slice, l2_index + i, QCOW_OFLAG_ZERO);
>              qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_REQ=
UEST);

It feels wrong to me to free the cluster before updating the L2 entry.

Max

>          } else {
> -            uint64_t entry =3D get_l2_entry(s, l2_slice, l2_index + i);
> -            set_l2_entry(s, l2_slice, l2_index + i, entry | QCOW_OFLAG_Z=
ERO);
> +            l2_entry =3D get_l2_entry(s, l2_slice, l2_index + i);
>          }
> +
> +        if (has_subclusters(s)) {
> +            set_l2_bitmap(s, l2_slice, l2_index + i, QCOW_L2_BITMAP_ALL_=
ZEROES);
> +        } else {
> +            l2_entry |=3D QCOW_OFLAG_ZERO;
> +        }
> +
> +        set_l2_entry(s, l2_slice, l2_index + i, l2_entry);
>      }
> =20
>      qcow2_cache_put(s->l2_table_cache, (void **) &l2_slice);
>=20



--dvo5KCnT30buJNSH2inun7OojiMU8bZoV--

--e0EZJ9eMNv1KVO55FhJjQ30RVD9jT4Mk5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3APgkACgkQ9AfbAGHV
z0Bw/Qf+MgMLvu5K6YmlI/zcYpSce0RMbjp15vDLSB/x4uAREOpfN0OzvztI1vpO
jcVipsV+OSrJdVKWmS/JVL1a7dBLDn7Ogsps5uD2dLjEy+a14Ay5CZw7yXuAuniT
unLZHf+beVyUQ0EMhlEpMGBigr1+tItpNQ4hXi5Ay1huzplFnkhOlvuBFOr0fys3
CiTsHpOywcXiqVf+klkJnKIvTJ4Td3JL7QUgj0loCt3jxYT/TlFhI4p0c4pj9548
NLcu4L5VzCDFZdgqrg3delDdt1RPooYvQQwMzSj01GrtOyqDPUAT3Hmdkd8CmUtO
ZEMukpx72lNFviQVX7ZyE/4V66pF1w==
=6H/s
-----END PGP SIGNATURE-----

--e0EZJ9eMNv1KVO55FhJjQ30RVD9jT4Mk5--



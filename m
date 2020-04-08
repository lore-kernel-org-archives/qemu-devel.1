Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A4C2BA1A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC7A20747
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 10:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cU4YZpzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC7A20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM8N4-0001UQ-4J
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 06:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jM8Iz-0007uh-93
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jM8Ix-0007ma-4n
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:51:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52416
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jM8Iw-0007lZ-Ku
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 06:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586343093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lRytgOHJOgv9ripJ1AY679IPCrnV2qxP26pa2ayqPW0=;
 b=cU4YZpzS3+ItwlSfsCww77+Rn4uHTWXCb4bHVAFJFxZKkREhT0gMNPYXForGw7SFMMbAZ1
 X9YJ0tloJ9AzJA6xjsEaMlNhpS3FWYn8OBTcFUGECS1Nz1YpOC+pSuEvnNHhmAd88MSyQl
 C9uOoEs2XdoAYVvH2bSU9Jzazl5CTpU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-emKV8rytM0eZslvAmk4rIg-1; Wed, 08 Apr 2020 06:51:31 -0400
X-MC-Unique: emKV8rytM0eZslvAmk4rIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C578800D4E;
 Wed,  8 Apr 2020 10:51:30 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-144.ams2.redhat.com
 [10.36.113.144])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD1AA60BFB;
 Wed,  8 Apr 2020 10:51:26 +0000 (UTC)
Subject: Re: [PATCH v4 02/30] qcow2: Convert qcow2_get_cluster_offset() into
 qcow2_get_host_offset()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <65243debd4a41e1ebd13877c2e6c665759c37b38.1584468723.git.berto@igalia.com>
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
Message-ID: <2f8f3cba-d4e4-49f2-722f-fc6cc96bdd65@redhat.com>
Date: Wed, 8 Apr 2020 12:51:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <65243debd4a41e1ebd13877c2e6c665759c37b38.1584468723.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rd5E7el4MBrBsAwFyRMiLjmsLBNDxAUpt"
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
--rd5E7el4MBrBsAwFyRMiLjmsLBNDxAUpt
Content-Type: multipart/mixed; boundary="u25NeqV9rLaBgW3m2eHS285V8ecoI6oBz"

--u25NeqV9rLaBgW3m2eHS285V8ecoI6oBz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.03.20 19:15, Alberto Garcia wrote:
> qcow2_get_cluster_offset() takes an (unaligned) guest offset and
> returns the (aligned) offset of the corresponding cluster in the qcow2
> image.
>=20
> In practice none of the callers need to know where the cluster starts
> so this patch makes the function calculate and return the final host
> offset directly. The function is also renamed accordingly.
>=20
> There is a pre-existing exception with compressed clusters: in this
> case the function returns the complete cluster descriptor (containing
> the offset and size of the compressed data). This does not change with
> this patch but it is now documented.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2.h         |  4 ++--
>  block/qcow2-cluster.c | 38 ++++++++++++++++++++++----------------
>  block/qcow2.c         | 24 +++++++-----------------
>  3 files changed, 31 insertions(+), 35 deletions(-)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 0942126232..f47ef6ca4e 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h

[...]

>      case QCOW2_CLUSTER_ZERO_ALLOC:
>      case QCOW2_CLUSTER_NORMAL:
>          /* how many allocated clusters ? */
>          c =3D count_contiguous_clusters(bs, nb_clusters, s->cluster_size=
,
>                                        &l2_slice[l2_index], QCOW_OFLAG_ZE=
RO);
> -        *cluster_offset &=3D L2E_OFFSET_MASK;
> -        if (offset_into_cluster(s, *cluster_offset)) {
> +        *host_offset =3D l2_entry & L2E_OFFSET_MASK;
> +        if (offset_into_cluster(s, *host_offset)) {
>              qcow2_signal_corruption(bs, true, -1, -1,
>                                      "Cluster allocation offset %#"
>                                      PRIx64 " unaligned (L2 offset: %#" P=
RIx64
> -                                    ", L2 index: %#x)", *cluster_offset,
> +                                    ", L2 index: %#x)", *host_offset,
>                                      l2_offset, l2_index);
>              ret =3D -EIO;
>              goto fail;
>          }
> -        if (has_data_file(bs) && *cluster_offset !=3D offset - offset_in=
_cluster)
> +        if (has_data_file(bs) && *host_offset !=3D offset - offset_in_cl=
uster)
>          {

(1) The { should be moved to the preceding line;

(2) I think it makes more sense to move the
=E2=80=9C*host_offset +=3D offset_in_cluster=E2=80=9D before this condition=
, so it becomes
=E2=80=9C... && *host_offset !=3D offset=E2=80=9D.

>              qcow2_signal_corruption(bs, true, -1, -1,
>                                      "External data file host cluster off=
set %#"

(Maybe we then need to drop the =E2=80=9Ccluster=E2=80=9D from this line, b=
ut other than
that, it would fit with this error message.)

Max

>                                      PRIx64 " does not match guest cluste=
r "
>                                      "offset: %#" PRIx64
> -                                    ", L2 index: %#x)", *cluster_offset,
> +                                    ", L2 index: %#x)", *host_offset,
>                                      offset - offset_in_cluster, l2_index=
);
>              ret =3D -EIO;
>              goto fail;
>          }
> +        *host_offset +=3D offset_in_cluster;
>          break;
>      default:
>          abort();


--u25NeqV9rLaBgW3m2eHS285V8ecoI6oBz--

--rd5E7el4MBrBsAwFyRMiLjmsLBNDxAUpt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6NrKwACgkQ9AfbAGHV
z0DQUgf/W+XIlwRuI7w+5fbSuB1y7yfUdqsWiU+VTiX42JKdKx6IMGB5wi9fpwNZ
CzfezDm3gEuOh80RmLxoiuvRncKbqVm2rd/aCLyU69dJim6ge46WNxRjf1xXcqYY
Lg4nwRmYK6S8edyX9boseOCz1hLQ27XF2RAHazu8+E8c0mpvFcMfW+inI3YYDKEr
GftfGdHqQciC4eeh5faNmPMtiMAr0WH6k3CQx4JD5sMohMmRA3lpvl/rgkNpH2ar
wj1IxmCjd6ygAJ3kUdkFGXUD5bEtqVd/ciP5hoJQRYasyO8St6cBFIXWFViqnZU2
7o0jfV2ZZMZ5BVfhBajLh+z909JMZw==
=mlNL
-----END PGP SIGNATURE-----

--rd5E7el4MBrBsAwFyRMiLjmsLBNDxAUpt--



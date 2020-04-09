Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5F1C38A30
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 10:14:19 +0000 (UTC)
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38B12145D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 10:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSsJ3NGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38B12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMU4l-0005IT-1n
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 06:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jMU3o-0004Yy-VG
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 06:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jMU3m-0007Kj-H1
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 06:05:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43405
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jMU3m-0007Js-7B
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 06:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586426721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jn60Za3/XpDDD8+cNEv53D7ebaM3vr0CnRKiFBLie2w=;
 b=YSsJ3NGMfwd/XcAWbmA5WipychrgWT9Ic3FhxgXbzuafbzXKEs6kez7UEf+9yke+WqdtMq
 YDCWCtwJCZ6/VGGN4c8PPxAfD8ZIPdf2VjDPs7FTyHhI/obsHJMzddY4VUXGwsgdJ7fn0u
 a6oOWwuM1agRzZEIEQiaUTcsFEP6EyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-3hobxj7bNUmpPPO0GPceOA-1; Thu, 09 Apr 2020 06:05:19 -0400
X-MC-Unique: 3hobxj7bNUmpPPO0GPceOA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 951CD107ACC4;
 Thu,  9 Apr 2020 10:05:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-98.ams2.redhat.com
 [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC6CC5C28F;
 Thu,  9 Apr 2020 10:05:14 +0000 (UTC)
Subject: Re: [PATCH v4 20/30] qcow2: Add subcluster support to
 discard_in_l2_slice()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
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
Message-ID: <4b3b1ef4-2f8b-b16f-3c48-2ba6137763e4@redhat.com>
Date: Thu, 9 Apr 2020 12:05:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <99b45e3beb4a38b17eb50fcde1e09cdefdb99724.1584468723.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="18MRABuRMVEtO1epiS9mjotXxubvEjGDC"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--18MRABuRMVEtO1epiS9mjotXxubvEjGDC
Content-Type: multipart/mixed; boundary="lhhq8TBTbE2ofq49tAPgLpaGbvGqohq1F"

--lhhq8TBTbE2ofq49tAPgLpaGbvGqohq1F
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.03.20 19:16, Alberto Garcia wrote:
> Two changes are needed in this function:
>=20
> 1) A full discard deallocates a cluster so we can skip the operation if
>    it is already unallocated. With extended L2 entries however if any
>    of the subclusters has the 'all zeroes' bit set then we have to
>    clear it.
>=20
> 2) Setting the QCOW_OFLAG_ZERO bit of the L2 entry is forbidden if an
>    image has extended L2 entries. Instead, the individual 'all zeroes'
>    bits must be used.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 746006a117..824c710760 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1790,12 +1790,20 @@ static int discard_in_l2_slice(BlockDriverState *=
bs, uint64_t offset,
>           * TODO We might want to use bdrv_block_status(bs) here, but we'=
re
>           * holding s->lock, so that doesn't work today.
>           *
> -         * If full_discard is true, the sector should not read back as z=
eroes,
> +         * If full_discard is true, the cluster should not read back as =
zeroes,
>           * but rather fall through to the backing file.
>           */
>          switch (qcow2_get_cluster_type(bs, old_l2_entry)) {
>          case QCOW2_CLUSTER_UNALLOCATED:
> -            if (full_discard || !bs->backing) {
> +            if (full_discard) {
> +                /* If the image has extended L2 entries we can only
> +                 * skip this operation if the L2 bitmap is zero. */
> +                uint64_t bitmap =3D has_subclusters(s) ?
> +                    get_l2_bitmap(s, l2_slice, l2_index + i) : 0;

Isn=E2=80=99t this bitmap only valid for standard clusters?  In this case, =
the
whole cluster is unallocated, so the bitmap shouldn=E2=80=99t be relevant, =
AFAIU.

Max

> +                if (bitmap =3D=3D 0) {
> +                    continue;
> +                }
> +            } else if (!bs->backing) {
>                  continue;
>              }
>              break;


--lhhq8TBTbE2ofq49tAPgLpaGbvGqohq1F--

--18MRABuRMVEtO1epiS9mjotXxubvEjGDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6O81gACgkQ9AfbAGHV
z0BuzggArTrhkf4lesEcyHiN8y+j7HS0FEDQyYNtFm3DCf197kT2hDaJZ9N2cpvl
0OVtHwkb02UVPLL2lMx0O0IuVsn99knIeg++oxVVA/NMvXfwdbocLYBZTz27+tva
9oSPaGAtPw9g0MSSrw2bRW2KC+Wp/rMO/T5JqOvDKeUMjAqfi+jevhfvyE3hNdQq
vujWLAIUtMFgl0/3JFpcOxYiFAxxxSFDU2UqhM7Llvh7SJ14iII2UeNDjoc5ftaW
KUZRWTsL5opTzjILWHRHQEIPyb6a4VwtrKa38rVJpBDI3zOU/934axEjIOseeTV9
V5uiMCBAPnc3XcPk+KpjoLET7XtZpw==
=CWSt
-----END PGP SIGNATURE-----

--18MRABuRMVEtO1epiS9mjotXxubvEjGDC--



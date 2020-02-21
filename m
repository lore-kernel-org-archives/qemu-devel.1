Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967C2C35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:45:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6212B208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHKsYmuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6212B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58149 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58cg-0000PW-Ju
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j58SM-00075G-6w
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j58SJ-0006sw-LL
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:35:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60047
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j58SJ-0006rr-Hf
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582292098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1d07UTcIDyALElk9DjVOihtamuRYXUTaExri6ZjmW6o=;
 b=eHKsYmuATAexXV3I+2DOG+3WEy9z+ZoLwphBou/tFPLTLm/Cv1Y1K5SyBrYYO1eDZY5WEk
 GXqs19YHOAXGxXutGRdO4BYOmifqPkGicHz+1QgUIrfrZeXw3aITnV1fNzRSLdujkriypN
 5nCk2nf1Z4vVmi5jFw6U2TjwiavZhg4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-MH2IE9ytNgODFF6kxYbgcw-1; Fri, 21 Feb 2020 08:34:53 -0500
X-MC-Unique: MH2IE9ytNgODFF6kxYbgcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4629213E5;
 Fri, 21 Feb 2020 13:34:52 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A455060C63;
 Fri, 21 Feb 2020 13:34:49 +0000 (UTC)
Subject: Re: [RFC PATCH v3 14/27] qcow2: Add subcluster support to
 calculate_l2_meta()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <c8a083950e07b219c2d3aa5bfec0fe13529ddb28.1577014346.git.berto@igalia.com>
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
Message-ID: <aecf3eb8-8999-cbea-85e0-e5f9469db8d4@redhat.com>
Date: Fri, 21 Feb 2020 14:34:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c8a083950e07b219c2d3aa5bfec0fe13529ddb28.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6bdGH6f2ihQdDpEoXBJ9fDzWrr2gcI5WA"
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
--6bdGH6f2ihQdDpEoXBJ9fDzWrr2gcI5WA
Content-Type: multipart/mixed; boundary="SxIbJnYOKz9Ji9X7tAPkZ56tMpcnibbBv"

--SxIbJnYOKz9Ji9X7tAPkZ56tMpcnibbBv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.19 12:36, Alberto Garcia wrote:
> If an image has subclusters then there are more copy-on-write
> scenarios that we need to consider. Let's say we have a write request
> from the middle of subcluster #3 until the end of the cluster:
>=20
>    - If the cluster is new, then subclusters #0 to #3 from the old
>      cluster must be copied into the new one.
>=20
>    - If the cluster is new but the old cluster was unallocated, then
>      only subcluster #3 needs copy-on-write. #0 to #2 are marked as
>      unallocated in the bitmap of the new L2 entry.
>=20
>    - If we are overwriting an old cluster and subcluster #3 is
>      unallocated or has the all-zeroes bit set then we need
>      copy-on-write on subcluster #3.
>=20
>    - If we are overwriting an old cluster and subcluster #3 was
>      allocated then there is no need to copy-on-write.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 140 +++++++++++++++++++++++++++++++++---------
>  1 file changed, 110 insertions(+), 30 deletions(-)

It=E2=80=99s all a bit tough to wrap my head around.  One thing I got
particularly hung up is how we ensure that for new clusters the
head/tail subcluster bits that do not need COW are initialized to the
correct value.  Then I realized that we just have to keep them as they
are (unallocated or zero, respectively), because this path is only for
when we already have L2 entries, it=E2=80=99s just that they point to norma=
l
non-COPIED clusters.  (So only the L2 offset entry has to be changed,
not the bitmap.  At least not for the subclusters that aren=E2=80=99t touch=
ed by
the write.)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--SxIbJnYOKz9Ji9X7tAPkZ56tMpcnibbBv--

--6bdGH6f2ihQdDpEoXBJ9fDzWrr2gcI5WA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5P3HcACgkQ9AfbAGHV
z0DGIwgAtMuswPBw/+mI47nEprEa0PSy5RA2bE4ha1q8G/iU6vDrO2A8LG/hCOnZ
fhKzwr1CrPwhbRaBfafFZgApUen39eJ444LdcFmQ9OYf0377YzKN1L48PVX7vehw
b+/TQOEkohS24+CfbDXOdMOmotdqoN63ihUgpNCrPBBZ+oCHUOuA2WFevlgr+N6F
wZnUQYh8Dz8IysEXzkQoHPA/0mJBJxBAZbiWkk3WyShooU8eYG/4JWTSp0pR3GW+
3kOD8jQ/FC+79bssW14mJguD55x1qC/Mlipe58GmVfVxma7m1bjFJp/bafc412xm
FFOqkvdqR3UgrLKCZ1dMIK7NcS+/Aw==
=+JMB
-----END PGP SIGNATURE-----

--6bdGH6f2ihQdDpEoXBJ9fDzWrr2gcI5WA--



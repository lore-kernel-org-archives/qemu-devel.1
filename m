Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3FAC11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA00D206F4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9723BbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA00D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nKc-0004Wa-UG
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4nJW-0003re-4V
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4nJT-0008Pu-Ju
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:00:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36387
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4nJR-0008Kq-SW
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:00:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582210823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4o2+tOAm2Tr9TrNp7G2ruyT/M2wa2/yDC+p10BLTemU=;
 b=f9723BbHhtdCifW+gX2KxtvO+3hpi4ijVRLeClprKAQ9wwkpNEZCRKTs9ghnMZE7IMzAHr
 8WA4oAJOe5XD2SYU/IymFTUrwefJ6nFATd92ctvKVXP0EYcR4+/XazzMTIJ40ZzjhXdM2d
 YWEWeSAlsx/6c8naB1CqmKB0OflF1VA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-6L2yY14qPuSK9IEHIgDrEA-1; Thu, 20 Feb 2020 10:00:20 -0500
X-MC-Unique: 6L2yY14qPuSK9IEHIgDrEA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A44C1107ACC9;
 Thu, 20 Feb 2020 15:00:18 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 458DA8ED09;
 Thu, 20 Feb 2020 15:00:12 +0000 (UTC)
Subject: Re: [RFC PATCH v3 03/27] qcow2: Process QCOW2_CLUSTER_ZERO_ALLOC
 clusters in handle_copied()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
 <e327f4c1ed2f9626ce018c1fd2b9db437721b30c.1577014346.git.berto@igalia.com>
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
Message-ID: <3b7cdb8f-dd3e-879e-e4fc-0ecddc431a22@redhat.com>
Date: Thu, 20 Feb 2020 16:00:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e327f4c1ed2f9626ce018c1fd2b9db437721b30c.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3SbqjGOuzD4xppHbQgH1GLL7Uk6WYmPiL"
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
--3SbqjGOuzD4xppHbQgH1GLL7Uk6WYmPiL
Content-Type: multipart/mixed; boundary="LMzoXjQSQEVA1yC7xnlBeQIO5PG81W6KZ"

--LMzoXjQSQEVA1yC7xnlBeQIO5PG81W6KZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.19 12:36, Alberto Garcia wrote:
> When writing to a qcow2 file there are two functions that take a
> virtual offset and return a host offset, possibly allocating new
> clusters if necessary:
>=20
>    - handle_copied() looks for normal data clusters that are already
>      allocated and have a reference count of 1. In those clusters we
>      can simply write the data and there is no need to perform any
>      copy-on-write.
>=20
>    - handle_alloc() looks for clusters that do need copy-on-write,
>      either because they haven't been allocated yet, because their
>      reference count is !=3D 1 or because they are ZERO_ALLOC clusters.
>=20
> The ZERO_ALLOC case is a bit special because those are clusters that
> are already allocated and they could perfectly be dealt with in
> handle_copied() (as long as copy-on-write is performed when required).
>=20
> In fact, there is extra code specifically for them in handle_alloc()
> that tries to reuse the existing allocation if possible and frees them
> otherwise.
>=20
> This patch changes the handling of ZERO_ALLOC clusters so the
> semantics of these two functions are now like this:
>=20
>    - handle_copied() looks for clusters that are already allocated and
>      which we can overwrite (NORMAL and ZERO_ALLOC clusters with a
>      reference count of 1).
>=20
>    - handle_alloc() looks for clusters for which we need a new
>      allocation (all other cases).
>=20
> One importante difference after this change is that clusters found in
> handle_copied() may now require copy-on-write, but this will be anyway
> necessary once we add support for subclusters.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 226 +++++++++++++++++++++++-------------------
>  1 file changed, 126 insertions(+), 100 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--LMzoXjQSQEVA1yC7xnlBeQIO5PG81W6KZ--

--3SbqjGOuzD4xppHbQgH1GLL7Uk6WYmPiL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5OnvIACgkQ9AfbAGHV
z0CVRQf/ZxX01zRk4Tf16rSCJ0YOWlWP7M/l1G4w4LpkuI7/iVon72qfLTo0GaUA
3joWdmLTvI2FDTVzdJYlu9YxplsZzzSk+CtydTRfqkVF29uLmUTQHzsu6Pd0a4yG
7TJAK3poY6I9GdmQmiqfPdnTVJjPnvOu3Cysjsuntv6x5efS7RjCsrWfDjoc/vp/
z8hmWfkNzQgaGPrlOX5nWzjYquYVxKT7wnxtvfKTLWTaLvLg9zsnEkuYkkDzlWEn
MtWqja44k2WnpjboWSRjEWYp/lMecN+v3oSTBb4Qabp8qkGlMc8FtZkV5IUsRfVV
yCSSTV0COuimq+GL0Yu9gHsJnKFUEA==
=foSk
-----END PGP SIGNATURE-----

--3SbqjGOuzD4xppHbQgH1GLL7Uk6WYmPiL--



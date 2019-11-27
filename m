Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD08C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975FB2075C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 16:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/LxE0p3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 975FB2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ia0X8-0000sr-4l
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 11:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ia0KI-0001tb-S3
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ia0KG-00067N-Qg
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:38:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ia0KE-00064K-Sp
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 11:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574872677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dNOh0XdR3ewgd7nCjkSsh47nzs2maD4Vvtmd1D1fTv8=;
 b=h/LxE0p3p9gr9hZZ4jHy/KqIfbH0ZcVdT4PY2XKzzBUVrwc2rRG0j334CL2rw1KpFRH1jS
 9QC3Al9MCeRACzCY0SByaKK05+3dS8IZ4z9OwAFbX6hb/jK6NC/AGAe3/t5zLZbAuhFFVV
 XfGWeNA28V4iSXJ1PDSdS7rnY9knk/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-xe5b8f3IMsaN7Iob8CN6Qg-1; Wed, 27 Nov 2019 11:37:55 -0500
X-MC-Unique: xe5b8f3IMsaN7Iob8CN6Qg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8446E100A15B;
 Wed, 27 Nov 2019 16:37:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-186.brq.redhat.com
 [10.40.205.186])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B6F8600C8;
 Wed, 27 Nov 2019 16:37:50 +0000 (UTC)
Subject: Re: [PATCH v4 2/5] blockdev: unify qmp_drive_backup and drive-backup
 transaction paths
To: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
References: <20191121135759.101655-1-slp@redhat.com>
 <20191121135759.101655-3-slp@redhat.com>
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
Message-ID: <5af781bf-9295-4314-c5c1-df1b56f4a1ea@redhat.com>
Date: Wed, 27 Nov 2019 17:37:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191121135759.101655-3-slp@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ow8Vu26KO76cqkpb2w3ZmLcbcH6CbmHrh"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ow8Vu26KO76cqkpb2w3ZmLcbcH6CbmHrh
Content-Type: multipart/mixed; boundary="OAA5qE1RYyi3pUKjwYzkdvln63oBoVsu0"

--OAA5qE1RYyi3pUKjwYzkdvln63oBoVsu0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.11.19 14:57, Sergio Lopez wrote:
> Issuing a drive-backup from qmp_drive_backup takes a slightly
> different path than when it's issued from a transaction. In the code,
> this is manifested as some redundancy between do_drive_backup() and
> drive_backup_prepare().
>=20
> This change unifies both paths, merging do_drive_backup() and
> drive_backup_prepare(), and changing qmp_drive_backup() to create a
> transaction instead of calling do_backup_common() direcly.
>=20
> As a side-effect, now qmp_drive_backup() is executed inside a drained
> section, as it happens when creating a drive-backup transaction. This
> change is visible from the user's perspective, as the job gets paused
> and immediately resumed before starting the actual work.
>=20
> Signed-off-by: Sergio Lopez <slp@redhat.com>
> ---
>  blockdev.c | 224 ++++++++++++++++++++++++-----------------------------
>  1 file changed, 100 insertions(+), 124 deletions(-)

Looks good to me, although it needs to keep the tests passing that now
break.

Max


--OAA5qE1RYyi3pUKjwYzkdvln63oBoVsu0--

--ow8Vu26KO76cqkpb2w3ZmLcbcH6CbmHrh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl3eplwACgkQ9AfbAGHV
z0DEWQf/SLDxVbGXwX88/97+fRkwmCDmASo5YWwGlnj8q9ua08T75dyKxVlXNKN/
ad9DZMv+X2uQl8xuhasObchMG/j/YjRf7zpvnZ2X2aJ99QZcgbCqYbqCfjjzPCWg
496sCr6Uhai25bHk1F7uXeJN2dbLI4u0RKEzhx/ltTfr7QWl2+bmzvTQ6wM0/l8F
wOBpSinDG/MJeZHnZcrUhw2jyZF3WdljYZDNIgqxf6X8U6nFyb3H7/qfwAwi6jYY
3xMhZAI+pyc3TtSXqQ2EOZsq3trnu9+36gYMFFONO6sUKNYjTsv5tPpEB6ocmu6V
1tRdqF5JQNWFEvvG58ifQRDh+0NFLA==
=FZwU
-----END PGP SIGNATURE-----

--ow8Vu26KO76cqkpb2w3ZmLcbcH6CbmHrh--



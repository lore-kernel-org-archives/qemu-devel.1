Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B3C35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:11:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111E620722
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOYbI2pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111E620722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BqE-0000qH-A8
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j5BpT-0000Ja-T2
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j5BpS-0008Po-T0
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:11:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j5BpS-0008PR-Na
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582305066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OMlOm/dKhUxxQCuT1sSrF1cp/Z4dqkAGmJu1onNzLQc=;
 b=IOYbI2pjQTH3ogWrCdAsC7jRWj03VdKhMOhPgDdAZg4/t8bOSN2GFa3OcSW1IbHl+NdHVl
 39azfpSzoNVowq5LzG6yPikpfH0PN7Bh+wppQoRKCcGBwmVaDYESWVTt0hStPnr6FkTjzF
 Q/dgx8XrelTDPvNyk0gT3dhwqFxSONs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-lL9TXh68M8mZmLD3YrQUtA-1; Fri, 21 Feb 2020 12:10:58 -0500
X-MC-Unique: lL9TXh68M8mZmLD3YrQUtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06F6A107ACC5;
 Fri, 21 Feb 2020 17:10:57 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0EC760499;
 Fri, 21 Feb 2020 17:10:54 +0000 (UTC)
Subject: Re: [RFC PATCH v3 00/27] Add subcluster allocation to qcow2
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1577014346.git.berto@igalia.com>
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
Message-ID: <a425b6e6-be14-0cbc-4498-26c632faa6fd@redhat.com>
Date: Fri, 21 Feb 2020 18:10:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1577014346.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="b9DMiPvuUt3Dn2BXKI57b2hsMwDWZKpUQ"
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
--b9DMiPvuUt3Dn2BXKI57b2hsMwDWZKpUQ
Content-Type: multipart/mixed; boundary="3XMDgS86Z6ABjR8OS79XgBDg0hxmn7Bau"

--3XMDgS86Z6ABjR8OS79XgBDg0hxmn7Bau
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.12.19 12:36, Alberto Garcia wrote:
> Hi,
>=20
> here's the new version of the patches to add subcluster allocation
> support to qcow2.
>=20
> Please refer to the cover letter of the first version for a full
> description of the patches:
>=20
>    https://lists.gnu.org/archive/html/qemu-block/2019-10/msg00983.html
>=20
> This version fixes many of the problems highlighted by Max. I decided
> not to replace completely the cluster logic with subcluster logic in
> all cases because I felt that sometimes it only complicated the code.
> Let's see what you think :-)

Looks good overall. :)

So now I wonder on what your plans are after this series.  Here are some
things that come to my mind, and I wonder whether you plan to address
them or whether there are more things to do still:

- In v2, you had a patch for preallocation support with backing files.
It didn=E2=80=99t quite work, which is why I think you dropped it for now (=
why
not, it isn=E2=80=99t crucial).

- There is a TODO on subcluster zeroing.

- I think adding support to amend for switching extended_l2 on or off
would make sense.  But maybe it=E2=80=99s too complicated to be worth the e=
ffort.

- As I noted in v2, I think it=E2=80=99d be great if it were possible to ru=
n the
iotests with -o extended_l2=3Don.  But I suppose this kind of depends on
me adding data_file support to the Python tests first...

Max


--3XMDgS86Z6ABjR8OS79XgBDg0hxmn7Bau--

--b9DMiPvuUt3Dn2BXKI57b2hsMwDWZKpUQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5QDxwACgkQ9AfbAGHV
z0Aokgf4i+8ZdDyeR60OscmoX9/BUs6m+dqERvO1CJwJZl8KGZH94NFEk680MWbh
TcgNFG3gCYsM1GcJzuZJRLeX7zutws0AWLfReHZJwx/UWcA5jkGWi3oA7bS84QVO
qtEqzImQ6sEA87+wWu1Ub+T7UCwTTl4NCqZ+fPS9mvQ0SX41NjuqZFyKK+YR6YuB
jRZg1XGQFp2/TYt4qu1hQpRetGrV+PN8QtY2nPL00WgDFYMJaEu40v1lwNrP96bm
Ob7aJip+8jpCsWUfJFV2i1J6b7bO9NpxsTT/qpd3igPllxDnxd1lp9oq4302Xq6R
ftCeB6E/PGtAVYTd4oRcp1BJK1/K
=+tJO
-----END PGP SIGNATURE-----

--b9DMiPvuUt3Dn2BXKI57b2hsMwDWZKpUQ--



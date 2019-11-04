Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C906CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199092245C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMuNpvv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199092245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYNB-0006ZP-9R
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRYMS-0005tY-TW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRYMR-0006GX-Kl
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:09:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27570
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRYMR-0006GF-Gx
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572858559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uFXNUZgx76zrtwoQGKUDHKbY/+9PFLCiaIJVwDkpIyk=;
 b=GMuNpvv5kD/z1A04Ni2y2Lga46E+zIMYqfiDKImCMtbpIyOEgEyEy54PmrAtnKgm+/5uxa
 We0vBzwiedI/CYhX/HYkPguM0AZXX4sGrqw0jysbs/dcxAWfV7DmcJ5BEpulefKeTfL5Oo
 sVkOifW+nSdwoqKOLPx6bwzw+vETKA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-DT-E0JOmMyiClLe2GuYm6w-1; Mon, 04 Nov 2019 04:09:15 -0500
X-MC-Unique: DT-E0JOmMyiClLe2GuYm6w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 486D61005500;
 Mon,  4 Nov 2019 09:09:14 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-85.ams2.redhat.com
 [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 648BB5C296;
 Mon,  4 Nov 2019 09:09:07 +0000 (UTC)
Subject: Re: [PATCH for-4.2 v2 0/3] qcow2: Fix data corruption on XFS
To: qemu-block@nongnu.org
References: <20191101152510.11719-1-mreitz@redhat.com>
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
Message-ID: <cd491ffc-17a8-c521-a8ca-ab9cd1b04775@redhat.com>
Date: Mon, 4 Nov 2019 10:09:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101152510.11719-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YTcSN4VVG30rl2VXJpuutGrGGuFqWtyhQ"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YTcSN4VVG30rl2VXJpuutGrGGuFqWtyhQ
Content-Type: multipart/mixed; boundary="wcfZqfW5dDgLFfykypUsGQz14BxFk8clX"

--wcfZqfW5dDgLFfykypUsGQz14BxFk8clX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.11.19 16:25, Max Reitz wrote:
> Hi,
>=20
> As I reasoned here:
> https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00027.html
> I=E2=80=99m no longer convinced of reverting c8bb23cbdbe.  I could see a
> significant performance improvement from it on ext4 with aio=3Dnative in =
a
> guest that does random 4k writes, and as such I feel it would be a
> regression to revert it for 4.2.
>=20
> To work around the XFS corruption, we still need the other three patches
> from the series, of course.  We cannot restrict the workaround to just
> XFS, because maybe the file is on a remote filesystem and then we don=E2=
=80=99t
> know anything about the host configuration.
>=20
> The performance impact should still be minimal because this just
> serializes post-EOF write-zeroes and data writes, and that just doesn=E2=
=80=99t
> happen very often, even with handle_alloc_space() in qcow2.
>=20
>=20
> I would love to have more time to make a decision, but there simply
> isn=E2=80=99t any.  Patches for 4.1.1 are to be collected on Monday, AFAI=
U.

I would have liked some reviews on this series (so I waited over the
weekend, even though I didn=E2=80=99t expect any), but now I=E2=80=99ve app=
lied it
anyway (and sent a pull request).  I understand it was difficult last
week because of KVM Forum.

AFAIU we need it today for stable, and there didn=E2=80=99t seem to be any
opposition on these patches here, just on the revert of c8bb23cbdbe.

I welcome you to still review the series and then shout =E2=80=9CSTOP=E2=80=
=9D at the
pull request if you find it necessary.

Max


--wcfZqfW5dDgLFfykypUsGQz14BxFk8clX--

--YTcSN4VVG30rl2VXJpuutGrGGuFqWtyhQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2/6rIACgkQ9AfbAGHV
z0CPFQgAuNx51oJEDXkLp2ffseW4u+NRXaqbL8ZOetnZRLPDIB3vUjMzzRoPW8FK
KQxtRkvRnTsn2LJIsXRiyNdHP1DL7lNueIy4ncVpD6yD8mPfmG4op/Jdg+AFJ4Zd
XI3UEeH1XQVEqaK4dx3QpeZNSWo0fKn3j9Mo8Ki3fAaOJV19kpvbRxqxXzWrYkud
N/7wL8V80mxaXBvLrskh6iQOCmRuqcpWXPWL3WYC9xs8EmsV6BrkrlRCLZ7mIVsi
jPwMJ1I9ounmg33cApUeH7lJNgzE1Uf709K7L+8qMuANi8v+0NAagb+hEdpL4hQ1
N/9CXvrfnNCcZkbsC8bBlwH5KMtl4g==
=HFj1
-----END PGP SIGNATURE-----

--YTcSN4VVG30rl2VXJpuutGrGGuFqWtyhQ--



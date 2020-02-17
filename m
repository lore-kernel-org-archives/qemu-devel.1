Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E47FC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0936B208C4
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6PVPuw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0936B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3i7D-0000Ns-7Y
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j3i68-0007mi-5n
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j3i66-0005SW-VO
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:14:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39414
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j3i66-0005SE-Rc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581952450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vMdNbbtXE3oVzLFRsOYRGu+L4uNGscr82lhc4L9ZbtU=;
 b=I6PVPuw3+QqHDfzO2fezgnPcVoa750T5/doivJamBvi0j9K68SgGunb3FoXY7oYc9q1xD4
 SfPvN+Vib27XzgfvRIuRz7ylSQldwEgwXrrurekWlxOKacBjG7EoYAJMPQpip+TT74nTX8
 e6tSHJX3BYJwdltkxtUWDNSPKNER5fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-1kPoWHK0MmiTHtVo3WVgGQ-1; Mon, 17 Feb 2020 10:14:04 -0500
X-MC-Unique: 1kPoWHK0MmiTHtVo3WVgGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22B6780574F;
 Mon, 17 Feb 2020 15:14:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-191.ams2.redhat.com
 [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53CD791820;
 Mon, 17 Feb 2020 15:13:56 +0000 (UTC)
Subject: Re: Cross-project NBD extension proposal: NBD_INFO_INIT_STATE
To: Eric Blake <eblake@redhat.com>,
 "nbd@other.debian.org" <nbd@other.debian.org>, QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libguestfs@redhat.com" <libguestfs@redhat.com>
References: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
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
Message-ID: <1b3741aa-7841-9062-ecca-73c38e599e05@redhat.com>
Date: Mon, 17 Feb 2020 16:13:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a4394fde-f459-dcb5-1698-013e1e24c388@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Nw6AAH3yTxeyeEPSZPCY4IYS8smMdco6V"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, "Richard W.M. Jones" <rjones@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nw6AAH3yTxeyeEPSZPCY4IYS8smMdco6V
Content-Type: multipart/mixed; boundary="CYE5T6HtN6kyKlRLeKj6C2PmyxrytuVwE"

--CYE5T6HtN6kyKlRLeKj6C2PmyxrytuVwE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

It=E2=80=99s my understanding that without some is_zero infrastructure for =
QEMU,
it=E2=80=99s impossible to implement this flag in qemu=E2=80=99s NBD server=
.

At the same time, I still haven=E2=80=99t understood what we need the flag =
for.

As far as I understood in our discussion on your qemu series, there is
no case where anyone would need to know whether an image is zero.  All
practical cases involve someone having to ensure that some image is
zero.  Knowing whether an image is zero can help with that, but that can
be an implementation detail.

For qcow2, the idea would be that there is some flag that remains true
as long as the image is guaranteed to be zero.  Then we=E2=80=99d have some
bdrv_make_zero function, and qcow2=E2=80=99s implementation would use this
information to gauge whether there=E2=80=99s something to do as all.

For NBD, we cannot use this idea directly because to implement such a
flag (as you=E2=80=99re describing in this mail), we=E2=80=99d need separat=
e is_zero
infrastructure, and that kind of makes the point of =E2=80=9Cdrivers=E2=80=
=99
bdrv_make_zero() implementations do the right thing by themselves=E2=80=9D =
moot.

OTOH, we wouldn=E2=80=99t need such a flag for the implementation, because =
we
could just send a 64-bit discard/make_zero over the whole block device
length to the NBD server, and then the server internally does the right
thing(TM).  AFAIU discard and write_zeroes currently have only 32 bit
length fields, but there were plans for adding support for 64 bit
versions anyway.  From my na=C3=AFve outsider perspective, doing that doesn=
=E2=80=99t
seem a more complicated protocol addition than adding some way to tell
whether an NBD export is zero.

So I=E2=80=99m still wondering whether there are actually cases where we ne=
ed to
tell whether some image or NBD export is zero that do not involve making
it zero if it isn=E2=80=99t.

(I keep asking because it seems to me that if all we ever really want to
do is to ensure that some images/exports are zero, we should implement
that.)

Max


--CYE5T6HtN6kyKlRLeKj6C2PmyxrytuVwE--

--Nw6AAH3yTxeyeEPSZPCY4IYS8smMdco6V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5KrbMACgkQ9AfbAGHV
z0BcbQgAnIPE1qdmhJ4KWwVx9x37GAooI293fHxyD79NgfNJlRQ5aUNmHdJlhJPM
BFJ2+S76Ecp6UDBwvPxnd6wt3sARuB3TrVbrfIU2A44uswTLTVm/+GvSeomAVDNL
RU7dJAelk4B9CRZ19dAB+Wm6jtfmb6eHLLuqdgQkxbuzVQDpIKIFLWUh1C1EEAUF
I0ir0DxDP0spyMUZ5AArysYt0vVUSzC2zNaw4/8GxcfQsq/41HaZp9+NR+BvRzC3
wos4av6y4BqS8eD45Z7ZqqCNLPvOPfBSv2BP00zrx4RZgIaZC1yaQFRmDvFz5zqq
rLNZxDhCdEtBzjZaEcamlQMKnMJToQ==
=9eXi
-----END PGP SIGNATURE-----

--Nw6AAH3yTxeyeEPSZPCY4IYS8smMdco6V--



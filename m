Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ECDCA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 09:32:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D908920B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 09:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrEKHZHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D908920B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP1Ny-0002aT-QQ
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 05:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP1Me-00073h-Q4
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 05:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP1Md-0004Vz-Jy
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 05:31:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47818
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP1Md-0004Vi-GV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 05:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572255063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4jG/2c1jlccKQTMuzMfN9iJslOc3EUFe7C0Omj/Xeg0=;
 b=KrEKHZHTy3ccmICvLR2LM0YnYJWOtN2wLNfrZ9SaRLJxaUbrFStj+p/eKgmQtA7Mu+ow5C
 pD+7E6lliej/kGudcY3vo/BJoq6Yh0UC9eETmHf9BDDiTutPOhlJ6sZobkE+rhYM/2ARgT
 wZ38OVw2SUgWiZ13K3d6kebC2rXirq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-OdoUbPt0PRiYuHAQRbJk4Q-1; Mon, 28 Oct 2019 05:30:59 -0400
X-MC-Unique: OdoUbPt0PRiYuHAQRbJk4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD75B1800E00;
 Mon, 28 Oct 2019 09:30:58 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-83.ams2.redhat.com
 [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B68095D6A9;
 Mon, 28 Oct 2019 09:30:52 +0000 (UTC)
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191027123555.GN4472@stefanha-x1.localdomain>
 <81bb0f91-2671-c9e5-f791-c7470dfd75ce@redhat.com>
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
Message-ID: <c38e000b-a120-2726-65a2-61c63fcc101f@redhat.com>
Date: Mon, 28 Oct 2019 10:30:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <81bb0f91-2671-c9e5-f791-c7470dfd75ce@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vpPAXEG04JRerTaByqfrsI9cfpIb7zamn"
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
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vpPAXEG04JRerTaByqfrsI9cfpIb7zamn
Content-Type: multipart/mixed; boundary="RUUjU2Oop6N4CgbcrthL0iaghQDN1dKpS"

--RUUjU2Oop6N4CgbcrthL0iaghQDN1dKpS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.10.19 10:24, Max Reitz wrote:
> On 27.10.19 13:35, Stefan Hajnoczi wrote:
>> On Fri, Oct 25, 2019 at 11:58:46AM +0200, Max Reitz wrote:
>>> As for how we can address the issue, I see three ways:
>>> (1) The one presented in this series: On XFS with aio=3Dnative, we exte=
nd
>>>     tracked requests for post-EOF fallocate() calls (i.e., write-zero
>>>     operations) to reach until infinity (INT64_MAX in practice), mark
>>>     them serializing and wait for other conflicting requests.
>>>
>>>     Advantages:
>>>     + Limits the impact to very specific cases
>>>       (And that means it wouldn=E2=80=99t hurt too much to keep this wo=
rkaround
>>>       even when the XFS driver has been fixed)
>>>     + Works around the bug where it happens, namely in file-posix
>>>
>>>     Disadvantages:
>>>     - A bit complex
>>>     - A bit of a layering violation (should file-posix have access to
>>>       tracked requests?)
>>
>> Your patch series is reasonable.  I don't think it's too bad.
>>
>> The main question is how to detect the XFS fix once it ships.  XFS
>> already has a ton of ioctls, so maybe they don't mind adding a
>> feature/quirk bit map ioctl for publishing information about bug fixes
>> to userspace.  I didn't see another obvious way of doing it, maybe a
>> mount option that the kernel automatically sets and that gets reported
>> to userspace?
>=20
> I=E2=80=99ll add a note to the RH BZ.
>=20
>> If we imagine that XFS will not provide a mechanism to detect the
>> presence of the fix, then could we ask QEMU package maintainers to
>> ./configure --disable-xfs-fallocate-beyond-eof-workaround at some point
>> in the future when their distro has been shipping a fixed kernel for a
>> while?  It's ugly because it doesn't work if the user installs an older
>> custom-built kernel on the host.  But at least it will cover 98% of
>> users...
>=20
> :-/
>=20
> I don=E2=80=99t like it, but I suppose it would work.  We could also
> automatically enable this disabling option in configure when we detect
> uname to report a kernel version that must include the fix.  (This
> wouldn=E2=80=99t work for kernel with backported fixes, but those disappe=
ar over
> time...)
I just realized that none of this is going to work for the gluster case
brought up by Nir.  The affected kernel is the remote one and we have no
insight into that.  I don=E2=80=99t think we can do ioctls to XFS over glus=
ter,
can we?

I also realized that uname is a stupid idea because the user may be
running a different kernel version than what runs on the build machine... :=
(

Max


--RUUjU2Oop6N4CgbcrthL0iaghQDN1dKpS--

--vpPAXEG04JRerTaByqfrsI9cfpIb7zamn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl22tUsACgkQ9AfbAGHV
z0Ajpwf/dgTO9ozoto90Q99LDLFjmYpT1orYVuAd135oRNpCH7kQv6OPW/o/As8Y
TeJ9PclEcF/lR4TUG6ZN+Vps2etnwDTjrdlGniG6qehCwDQxUOvNDu64BkunrVxr
fZ+xRoqb3wDN4nzck3L8wbsKegqtnrSMmhrMYRZ9WQ4nKbMbL5/UKQ0j5MQUr5bn
vLeEnNTMTvXqfmpyR8h1+3RudciiID8gKHBomh0vdQwsbrxQ2wgAIWVQWRgGhtWh
S9MlJkoTQ+ofrd8lqWuDX3oq1Yblc/LSbNRezcs7O1Ta1LG00CMNWK85z7UGfpEc
XGi+504O9KO0QQ74/2vyTPdiTZps2g==
=B8hk
-----END PGP SIGNATURE-----

--vpPAXEG04JRerTaByqfrsI9cfpIb7zamn--



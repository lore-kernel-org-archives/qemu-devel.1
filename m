Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E2FC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:06:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7A224670
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 14:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkYJGwFp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7A224670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMq4-0000CV-Rn
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 09:06:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1irMnH-0005cO-QZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1irMnD-0002SU-UX
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:03:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1irMnD-0002SJ-P4
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 09:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579010619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NKAx4DTK10JSWhpLcHr++k0FynNGH5Xf7F8sGvPz0GY=;
 b=PkYJGwFpkxTU2Rrcj+itXsfOQlHEeDJgcI/UBo0SnfmS+8QB9cYJxACCSjavPM6IHe6fYH
 bT4znfbVkID78uafMA2UX+vCd5TDj6qfWUsTnxBFaCxNkLd7n1D8fbkgU9YL1gNqH069Lr
 cMXCjmbu0nWzDEA9iSEDS8/SetF7g44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-lb1Kj1sROv-0SQfzKwrarQ-1; Tue, 14 Jan 2020 09:03:36 -0500
X-MC-Unique: lb1Kj1sROv-0SQfzKwrarQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B469718FE896;
 Tue, 14 Jan 2020 14:03:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32F7582478;
 Tue, 14 Jan 2020 14:03:32 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] qcow2: Require that the virtual size is a multiple
 of the sector size
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1578596897.git.berto@igalia.com>
 <6a1cfcbb533b487bac96e1d2282ebf210954d27a.1578596897.git.berto@igalia.com>
 <bd6ca991-c2f7-0e27-5bee-07a7c53f8a8e@redhat.com>
 <w51v9peb2dz.fsf@maestria.local.igalia.com>
 <9f7ab60c-c9d4-527b-55dd-40f487a36895@redhat.com>
 <w51sgkib0n3.fsf@maestria.local.igalia.com>
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
Message-ID: <70f3996c-e62d-c560-b7a3-e0653f38493d@redhat.com>
Date: Tue, 14 Jan 2020 15:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <w51sgkib0n3.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZkoeXFlmXThxGNuu9iDJfXXG4RIwCOgwI"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZkoeXFlmXThxGNuu9iDJfXXG4RIwCOgwI
Content-Type: multipart/mixed; boundary="t264nmYKRQyn42ELXjHldthGIVUwINPIA"

--t264nmYKRQyn42ELXjHldthGIVUwINPIA
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.01.20 14:58, Alberto Garcia wrote:
> On Tue 14 Jan 2020 02:47:53 PM CET, Max Reitz wrote:
>=20
>>> Yes, but does it make sense to try to support images with unaligned
>>> sizes if no one is going to create them ever and QEMU cannot even
>>> generate them?
>>
>> If nobody uses such images ever, isn=E2=80=99t the current code fine as-=
is?
>=20
> I'll rephrase:
>=20
> 1. It is possible to have a qcow2 image with a size of 1 GB + 13 bytes
>    (the size field in the qcow2 header allows it).
>=20
> 2. qemu-img cannot currently produce such images.
>=20
> 3. QEMU can open them but it gets the size wrong.

Yes, but in a safe way.  The user simply doesn=E2=80=99t get access to thos=
e 13
bytes.

With your proposed change, it would just reject the image altogether.
As a user, I=E2=80=99d prefer not being able to access 13 bytes to not bein=
g
able to access 1 GB + 13 bytes.

Furthermore, the user couldn=E2=80=99t even fix the image then because they
couldn=E2=80=99t resize it with qemu-img resize.

> 4. Fixing this in QEMU involves non-trivial changes (at least at the
>    moment).
>=20
> 5. I don't think there's any use case for such images so instead of
>    fixing QEMU I propose that we simply refuse to open them.

If there=E2=80=99s no use case, I don=E2=80=99t see how the current behavio=
r is problematic.

The arguments I could immediately agree to are (1) simplicity, and (2)
the image is probably corrupted.

As for (1), this patch adds more lines than it removes, so from a pure
quantitative standpoint, it doesn=E2=80=99t make the code simpler.

As for (2), I=E2=80=99m always of the opinion we shouldn=E2=80=99t refuse t=
o read
corrupted images just because they are corrupted.  We should open them
and let the user read as much as is reasonably possible.

Max


--t264nmYKRQyn42ELXjHldthGIVUwINPIA--

--ZkoeXFlmXThxGNuu9iDJfXXG4RIwCOgwI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4dyjMACgkQ9AfbAGHV
z0DuJgf/XoQ+pjIrEkZ3LPpuNnbTbOprhgF2Pqa7VNYItNeFDJuNnfc1QVjTZxkg
dK9yvs4ObqyKn9SwfIFM09ZozX6YVy8Gl8EIqXKED4JqzlI50GI7KxJCeZDbD9gL
w6GTuT/J8eqgjwcC/ILL1xPyFxU2dmwjkBNZNX9xLfHfWCRJs9NGmfIYhgeaD3y8
C3AfQ8sVem+nB0yKSxqdFJd1aYtFn+4zDLNWYW+a0pEsx0K9vQNrx9RqLjq3pNQO
bVHReWQjLJMgVlL6Ve1Dprubr+GzJdHZh3FRrjwo26KqAnRL9p71zMOnBhi6EZ2b
QCweiqqDF4N5dXmohf0QP/WbQBTuQQ==
=Org8
-----END PGP SIGNATURE-----

--ZkoeXFlmXThxGNuu9iDJfXXG4RIwCOgwI--



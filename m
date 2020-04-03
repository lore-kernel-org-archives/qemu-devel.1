Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41CFC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD44120737
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iq+kklER"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD44120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKL4U-0008Kk-St
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jKL3Q-0007gx-VH
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jKL3O-0002TQ-RT
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:04:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jKL3O-0002T9-OL
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585915446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q4BvltkTFwfuOFDPT0aAXsbHWgZ7f84yKt2g/VSI9oo=;
 b=Iq+kklERFywdykIydIbOuFI8Oyc3VZO1HVD5XQd9XoGRZ4G5jHIFSN+zjwCniyqhM33Hl0
 VRtUfU/Lcc0brrKxqZBXPLL7p7vh7WnT/SN+eTtNDI1VZZTgacmMfOIFz21dufMql9VzXl
 xzmQ3zIQ2esNJnnzZ14uCZ1e1X3DB3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-VMT-Q6niPxqSJLJsNjjoow-1; Fri, 03 Apr 2020 08:04:03 -0400
X-MC-Unique: VMT-Q6niPxqSJLJsNjjoow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93EA9DBA3;
 Fri,  3 Apr 2020 12:04:02 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-132.ams2.redhat.com [10.36.113.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B5F9F10016E8;
 Fri,  3 Apr 2020 12:04:01 +0000 (UTC)
Date: Fri, 3 Apr 2020 14:04:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.0] vpc: Don't round up already aligned BAT sizes
Message-ID: <20200403120400.GC5336@linux.fritz.box>
References: <20200402093603.2369-1-kwolf@redhat.com>
 <e379efcd-58ef-c9bb-0ae8-b3435f30d141@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e379efcd-58ef-c9bb-0ae8-b3435f30d141@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.04.2020 um 10:55 hat Max Reitz geschrieben:
> On 02.04.20 11:36, Kevin Wolf wrote:
> > As reported on Launchpad, Azure apparently doesn't accept images for
> > upload that are not both aligned to 1 MB blocks and have a BAT size tha=
t
> > matches the image size exactly.
> >=20
> > As far as I can tell, there is no real reason why we create a BAT that
> > is one entry longer than necessary for aligned image sizes, so change
> > that.
> >=20
> > (Even though the condition is only mentioned as "should" in the spec an=
d
> > previous products accepted larger BATs - but we'll try to maintain
> > compatibility with as many of Microsoft's ever-changing interpretations
> > of the VHD spec as possible.)
>=20
> So as far as I can tell we still don=E2=80=99t ensure that the image is a=
ligned
> to 1 MB blocks?
>=20
> Well, as long as it=E2=80=99s at least possible for the user to create va=
lid
> images, that=E2=80=99s better.

Yes, we still allow other image sizes because Azure is not the only
product using VHD images, but it is the only one (to my knowledge) that
makes this requirement.

We're trying to stay compatible with at least three different Microsoft
products (VirtualPC, HyperV, Azure) that all have their own
interpretation of the spec and are inconsistent with each other.

Kevin

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJehyYwAAoJEH8JsnLIjy/WlpAP+wZ6ogH7VGxNHituLRQOg3n6
bHQprrzZaqq/hkrQ2wn/D8WwBMg/PR1WSVT+f8Go+Tzp48UlEf8EK/2+WSnc8AYm
8J8AA91F0k/j/C+znHvtjVTSK05XEyTyUzFZztlCDcrXmL1J7jb/djc8tu2ql8p6
BiyoRa2asu1RcVw/YU3FyjCC5Yq/2U5VbR98PAlOQRoIPWsNvC2wtQAaFrjAH+0x
m3F1Jhr1hP7QI0MKvDPRz3qWXMrG7bK2dmw6XcinvkFKwUrL+RMZXMhsd1Oq6/CV
PcmsjymlIwcEpDjqVZPeUxXC4fi3tN3uykTy/OM7nx9nySUeZKaSSpUcysm/fAXf
xW3Wi6qsnmLhOfA/7tfTcKYbTeZSbIYuxFNeCAtjFXCnNzRoKpRwpEAm8EnQ05yA
OwnStHUeQqkY4zZKuqMNJ7dc1nXPJYKiHk5DqlHEMdpTxXksxWesKkC9U3XSwuGC
ls28FoeCuZSYQZXyBKDxn4InLhzB8kK6VrgAlwRR9RlJB2MQ/zKVb9SLVK+jcokd
uQvy+OmlXjKZQn+sNaIlfLXJXenO+qM+3J//pET+fbO0NDSXBxpzvUa0/17ra0R9
F+ecL9Uhu0QsJaqW8bl+nMh5QDG4ZYXOhb7fggoRepSUFkE2Ih0/NMoxpgjOwzAj
xnlJQk9YDoxcLJ/h5h4J
=Pj9b
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--



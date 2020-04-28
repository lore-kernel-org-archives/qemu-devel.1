Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA45C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A3C206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 11:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7i1PE9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A3C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTORA-0001Lv-FL
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 07:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTOQL-0000Pp-AA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTOQ9-0005l1-Uu
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:29:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jTOQ9-0005kg-Gm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 07:29:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588073340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3BW2HeDWHVVqD+6sTVJUIop3V9Qk0XY9O9HmKP3PJ0E=;
 b=Y7i1PE9gERkAVTxWKD04wTIDVg6FUA8btb2PPqU2JiB1gpHb9UJ1SJtR/uNETOwzrQUMWG
 0SGYpCQNSVborAZnSu0UlKrLs3Jpc07UTcvAyxfBO7AENlfpemnI0iZgNISXxUXhrvFRB4
 v7YetJqE976T3eWdfYqYzhlKz7/rS8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-2yBLbR_7Ppm2DyHaTp-3mg-1; Tue, 28 Apr 2020 07:28:57 -0400
X-MC-Unique: 2yBLbR_7Ppm2DyHaTp-3mg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12BC419057A2;
 Tue, 28 Apr 2020 11:28:56 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1A6B272A5;
 Tue, 28 Apr 2020 11:28:54 +0000 (UTC)
Date: Tue, 28 Apr 2020 13:28:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: backing chain & block status & filters
Message-ID: <20200428112853.GC5789@linux.fritz.box>
References: <a1c1b734-34dc-f8d3-b6a0-43b136e237e2@virtuozzo.com>
 <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20e6c43f-c1a7-57db-58b9-3cb70f0e637f@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.04.2020 um 13:08 hat Max Reitz geschrieben:
> On 28.04.20 10:55, Vladimir Sementsov-Ogievskiy wrote:
> > Hi!
> >=20
> > I wanted to resend my "[PATCH 0/4] fix & merge block_status_above and
> > is_allocated_above", and returned to all the inconsistencies about
> > block-status. I keep in mind Max's series about child-access functions,
> > and Andrey's work about using COR filter in block-stream, which depends
> > on Max's series (because, without them COR fitler with file child break=
s
> > backing chains).. And, it seems that it's better to discuss some
> > questions before resending.
> >=20
> > First, problems about block-status:
> >=20
> > 1. We consider ALLOCATED =3D ZERO | DATA, and documented as follows:
> >=20
> > =C2=A0=C2=A0 * BDRV_BLOCK_DATA: allocation for data at offset is tied t=
o this layer
> > =C2=A0=C2=A0 * BDRV_BLOCK_ZERO: offset reads as zero
> > =C2=A0=C2=A0 * BDRV_BLOCK_OFFSET_VALID: an associated offset exists for=
 accessing
> > raw data
> > =C2=A0=C2=A0 * BDRV_BLOCK_ALLOCATED: the content of the block is determ=
ined by this
> > =C2=A0=C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 layer rather than any backing, set by block
> > layer
> >=20
> > This actually means, that we should always have BDRV_BLOCK_ALLOCATED fo=
r
> > formats which doesn't support backing. So, all such format drivers must
> > return ZERO or DATA (or both?), yes?. Seems file-posix does so, but, fo=
r
> > example, iscsi - doesn't.
>=20
> Hm.  I could imagine that there are formats that have non-zero holes
> (e.g. 0xff or just garbage).  It would be a bit wrong for them to return
> ZERO or DATA then.
>=20
> But OTOH we don=E2=80=99t care about such cases, do we?  We need to know =
whether
> ranges are zero, data, or unallocated.  If they aren=E2=80=99t zero, we o=
nly
> care about whether reading from it will return data from this layer or no=
t.
>=20
> So I suppose that anything that doesn=E2=80=99t support backing files (or
> filtered children) should always return ZERO and/or DATA.

I'm not sure I agree with the notion that everything should be
BDRV_BLOCK_ALLOCATED at the lowest layer. It's not what it means today
at least. If we want to change this, we will have to check all callers
of bdrv_is_allocated() and friends who might use this to find holes in
the file.

Basically, the way bdrv_is_allocated() works today is that we assume an
implicit zeroed backing layer even for block drivers that don't support
backing files.

Kevin

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6oE3UACgkQfwmycsiP
L9b/Lg//XM1uYctoxR8ncrsh1bsCtVAScmIsNSyd3eqqELaglOhcOPQtUn/Cb0c5
ZfXG1Hsa2BfCaiNEjh3eBGyuUtphTICi/2ghzPPnmMOSfTByizlQG2tu6y3zXoDP
C1VJSbGfp9RWZ5LgJkCKWrAL+vYuS05rVkBfr6qekzPuqm4R5PTRLEEjpIrbcYNC
dD9Kv/lUw5I1fVMTSmB/pgnlweHOeowLIZFgHZ0q25Wd4VS4WKDWIqcl53ylhgTw
VT3Ua8xiBzTpm6kNuIfRLY0Qvd1MZQyGajepvvLKU19nl228wj3YN9yzBYoMqZ0U
3t3g3NbjQC1aNPhDD/oywVOvDXN7iSHxP4WLccwGqywSHtFKnpqTCEAuwP+c6I7o
9++o5phW/W1kAi893/h0XUGbXw3VndV0JN6M6VndLiwMu2LdWZ0FJSrWVKsxWm/R
yLSoj8+KeDYYgx43ZCXNhez5b1t68OQAXWQKOrYhCcHbEtyLQID6NXOgZTKW4B0A
jCa6k7NQ4sgApmKKwXJHO+/bpk/bHR1jEP5T+ulN9EyQcwG3pfC88P3EFXE/nce2
6DOxqLoY3O+TSPRIcQqkpJVMaIPYgiLzC0ShzxbRfanw/6abgLKEGpAbDhxFZleF
GaLssst3W1E/NtZydB5qIG4Hw9nG9/zsY4BMjkgvX8Z7SsQYcAE=
=x6AR
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--



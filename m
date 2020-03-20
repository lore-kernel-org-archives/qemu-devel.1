Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F7C4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97DC20739
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 16:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHkdRp4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97DC20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFKDn-0006xE-Rr
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 12:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40775)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jFKCR-0005hV-HG
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jFKCQ-00039z-8p
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:08:43 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:31509)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jFKCQ-00038z-1z
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584720521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZdURKU/zUbU4yRkyqQRiKjYwzuZ75HdLRDN9cao+rQ=;
 b=GHkdRp4K6o1rnBk/Xg4WE0Olz34VHpY3JTKJDLnS7AM8w19kMDomsI+QTFzOGZmv4zLAvM
 6YrmetqCjj/u92AP3r+ESW+5nihIqKWgJqmladssNb+tnGu7tfOsFFe3P878S3ZRosnH5V
 4n3U1mgr4FGGSlaxWVIPSoEMdKua8XM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-AHhzauJoMla1S6jUJ1fvpQ-1; Fri, 20 Mar 2020 12:08:24 -0400
X-MC-Unique: AHhzauJoMla1S6jUJ1fvpQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E0808024D9;
 Fri, 20 Mar 2020 16:08:22 +0000 (UTC)
Received: from localhost (ovpn-114-252.ams2.redhat.com [10.36.114.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2ECF05DAB0;
 Fri, 20 Mar 2020 16:08:20 +0000 (UTC)
Date: Fri, 20 Mar 2020 16:08:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC (fix for 5.0?)] block/io: do not do pointer arithmetic on
 void *
Message-ID: <20200320160814.GF138042@stefanha-x1.localdomain>
References: <20200318142253.2809-1-vsementsov@virtuozzo.com>
 <20200318142654.GH2173309@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200318142654.GH2173309@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: kwolf@redhat.com, fam@euphon.net,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--65ImJOski3p8EhYV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2020 at 02:26:54PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Mar 18, 2020 at 05:22:53PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
> > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> > ---
> >=20
> > Hi all!
> >=20
> > C standard doesn't allow pointer arithmetic on void *.
> > Still, gcc allows it as an extension:
> >  https://gcc.gnu.org/onlinedocs/gcc-4.8.0/gcc/Pointer-Arith.html
> >=20
> > I can create a series of patches like this. Do we need it?
>=20
> I don't think so, we only care about gcc & clang.

I agree with Dan.

Stefan

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl506m4ACgkQnKSrs4Gr
c8gWYwf/WTtPwhU7pVKE54/hO5TbUpMI0kI8QZ96u9RPq8NVbAaII6gb4YOT4jDy
hW+1LBNCSbpmP0h8qydLXNbtZY8azgK7J6Kjm9AEdPpud4805OGOb7X8YMptlFB9
GAMODyaUMQDgRW7TQ8GNAtdXqSe756IKVXzkPL8jj+n2qJr3c6kJU+3lTLyK3U6k
+QSafkyH5qFwiwbL03YoX/qD7wkBiKmFGKHeJ/YS8WTyM0DYbBSiDZNhu3sJ07Wq
YpwXIjTcEYSghW6kuCa7Naq+8zT0Pxjf0kCHWdf8TxJQx5MUcad3tinxpfHfNwm7
N0YWaekdHUvTGMLrSG9LTakopMx6sQ==
=fL6J
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--



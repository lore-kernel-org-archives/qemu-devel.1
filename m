Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1403C33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3812075B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YIghEjTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3812075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir3FM-0005Ko-Px
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 12:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ir3EK-0003dR-S8
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:10:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ir3EI-0002SK-GJ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:10:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56103
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ir3EI-0002R6-D4
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 12:10:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578935417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C/ni6dCfjSn31sYgnStARHuOnOCsB/uTL6pO7qpmluQ=;
 b=YIghEjTsv/fKDEMTDSWU4nhFoVlyqjoHNpXGbEIW0UrnVuBnbT8eW1FUwImSwK7AbCI+L/
 6BHje1V8QZkQ0vX1sidVsnIJFgFYtUsm6M7AwF9FV/e2GYqX2b/aSXbR0YlrcJYzA1okH9
 OXIt4lgsSx5t4qWwyzCBpcUMUghy20g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-mLbzeYNkPouqFEodvQ2O8Q-1; Mon, 13 Jan 2020 12:10:13 -0500
X-MC-Unique: mLbzeYNkPouqFEodvQ2O8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 383DF1800D78;
 Mon, 13 Jan 2020 17:10:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-192.ams2.redhat.com [10.36.117.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12A0A5D9CA;
 Mon, 13 Jan 2020 17:10:10 +0000 (UTC)
Date: Mon, 13 Jan 2020 18:10:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 2/4] block: Mark 'block_resize' as coroutine
Message-ID: <20200113171009.GH5549@linux.fritz.box>
References: <20200109183545.27452-1-kwolf@redhat.com>
 <20200109183545.27452-3-kwolf@redhat.com>
 <20200113165648.GD103384@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200113165648.GD103384@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
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
Cc: marcandre.lureau@gmail.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.01.2020 um 17:56 hat Stefan Hajnoczi geschrieben:
> On Thu, Jan 09, 2020 at 07:35:43PM +0100, Kevin Wolf wrote:
> > block_resize is safe to run in a coroutine, so use it as an example for
> > the new 'coroutine': true annotation in the QAPI schema.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-core.json | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 7ff5e5edaf..1dbb2a9901 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -1341,7 +1341,8 @@
> >  { 'command': 'block_resize',
> >    'data': { '*device': 'str',
> >              '*node-name': 'str',
> > -            'size': 'int' } }
> > +            'size': 'int' },
> > +  'coroutine': true }
> > =20
> >  ##
> >  # @NewImageMode:
>=20
> coroutine_fn is missing on
> blockdev.c:void qmp_block_resize(bool has_device, const char *device,

It wouldn't even be true until after patch 4. Should I reorder the
patches so I can add coroutine_fn?

Kevin

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJeHKRxAAoJEH8JsnLIjy/WHOAP/iywQ9vkk4ndP6TtjB4hHZCh
lPZ3TAsBlaXWyFI8NbkVLMhvnskjrg3bsWOmNn2Ee1C5b6vV50lE3+TyXXr7/7f9
s1r2pyoQU+iLTQa99slgPQQQT5P1nG4xfrvuRVGZEUAbpe3/GNW7718250hJG51f
1x7cPGQYIe2dnvwkyKhbZuvjX7pKnlEoft3f/PZivADqslvbe0mJSkhNCFZcEYCa
XnImXwvY/40RGOchdWGnNHK91oSgDahVnH/xcEpW91eqoEwPCSQTJnmJ8JZXQ0/w
m0H/X5YOS34dZQAnv2c4Lxg9AzH5z7tsF0jUGl+j52RqR2d9+mauzueidDhVW9eZ
pTdpCZMyzkPr4WcbHmsXPd5Ld+mEIczuxYB1r+fT2tbwKQKa2y39/jGo4gT/Rm1S
Rgab/smREV36las5wO/6BNFC+BDL355uRDrcxieshm3NALyH+9jr6Qj2p7aZl+9q
Oh5IxdQt6OlKFR2TcErlq9mv5KHzLlsb+/Bvbu+hWVPAuwJZaHiqlk1TXAm69ztg
fdyS+VbfKu+CBSrKmzBJIh8h/+iuW+YrmNQ06jO0/e8uUtghc1zi4iHc1+N1K9iG
eOTAwUIgmmpcnLFzZsPiMeVccf7IaMZiREhJDUz7KEFU5VRz81ckQqfW8RBF05B9
9isEfCNlR0KT4Xvi1Fqd
=vk3k
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--



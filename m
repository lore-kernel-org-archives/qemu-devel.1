Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0997FC33CB3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB207207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWpkUwfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB207207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriv0-0004eW-VC
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:41:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iriu4-00043j-QU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:40:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iritz-0007eW-2F
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:40:10 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52834
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1irity-0007dY-L9
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579095605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+JciJme9YXAcj0FnL98D6Lh2fGtoQTssWlCN+ci33ag=;
 b=FWpkUwfC6DXzgvA8F4WpxIbUiYR4F1ELOfGzQO5dsrrS/VM3cLM+/gj9VNjHeZQ+heBOk0
 RdRcYEWpNV7sCr1TXQQ9vvPKpH2WX0MAUPt02ZC+EjkHhgmB03ryoTfPFKlCoE42dg97os
 gt/cAIDATl2W2QvA71GUPG2g2D/GQHE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-h9L6ti5SMLucxiBU83Q-4Q-1; Wed, 15 Jan 2020 08:40:04 -0500
X-MC-Unique: h9L6ti5SMLucxiBU83Q-4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A251DB61;
 Wed, 15 Jan 2020 13:40:02 +0000 (UTC)
Received: from localhost (ovpn-117-209.ams2.redhat.com [10.36.117.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 731DB1CB;
 Wed, 15 Jan 2020 13:40:01 +0000 (UTC)
Date: Wed, 15 Jan 2020 13:40:00 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 1/4] luks: extract
 block_crypto_calculate_payload_offset()
Message-ID: <20200115134000.GG163546@stefanha-x1.localdomain>
References: <20200109111012.559052-1-stefanha@redhat.com>
 <20200109111012.559052-2-stefanha@redhat.com>
 <7ea9cf7e-2622-c17a-6936-3109e4cd228a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7ea9cf7e-2622-c17a-6936-3109e4cd228a@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oXNgvKVxGWJ0RPMJ"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--oXNgvKVxGWJ0RPMJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 04:25:44PM +0100, Max Reitz wrote:
> On 09.01.20 12:10, Stefan Hajnoczi wrote:
> > The qcow2 .bdrv_measure() code calculates the crypto payload offset.
> > This logic really belongs in block/crypto.c where it can be reused by
> > other image formats.
> >=20
> > The "luks" block driver will need this same logic in order to implement
> > .bdrv_measure(), so extract the block_crypto_calculate_payload_offset()
> > function now.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/crypto.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  block/crypto.h |  5 ++++
> >  block/qcow2.c  | 59 ++++------------------------------------------
> >  3 files changed, 73 insertions(+), 55 deletions(-)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 24823835c1..ed32202fa2 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -185,6 +185,70 @@ block_crypto_create_opts_init(QDict *opts, Error *=
*errp)
>=20
> [...]
>=20
> > +/* Determine the number of bytes for the crypto header */
> > +bool block_crypto_calculate_payload_offset(QemuOpts *opts,
> > +                                           const char *optprefix,
> > +                                           size_t *len,
> > +                                           Error **errp)
> > +{
> > +    QDict *cryptoopts_qdict;
> > +    QCryptoBlockCreateOptions *cryptoopts;
> > +    QCryptoBlock *crypto;
> > +
> > +    /* Extract options into a qdict */
> > +    if (optprefix) {
> > +        QDict *opts_qdict =3D qemu_opts_to_qdict(opts, NULL);
> > +
> > +        qdict_extract_subqdict(opts_qdict, &cryptoopts_qdict, optprefi=
x);
> > +        qobject_unref(opts_qdict);
> > +    } else {
> > +        cryptoopts_qdict =3D qemu_opts_to_qdict(opts, NULL);
> > +    }
> > +
> > +    /* Build QCryptoBlockCreateOptions object from qdict */
> > +    qdict_put_str(cryptoopts_qdict, "format", "luks");
>=20
> Should this be a parameter?

Maybe one day, but there are no users who need it yet.

Stefan

--oXNgvKVxGWJ0RPMJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4fFjAACgkQnKSrs4Gr
c8jTPQgAlbTwNwxDjZLIoLsfp4h05tyDGLF6FWhxDew7VkeP4fLwANbPNON1Csfq
wueSuB2HyQz9i+vGgctn9VIvQbSA1Cwy5iQJABE4uX6NOUHqX2pFhQ53y3Hj0nTI
dfX6t8QP3GEoquNQByi7tkvwVm4ou1Qhbm33bdav9Eah4ChxvjBK0mCkQII11LJs
HjcpFe2+uzqTW/WEsdfuSIkGZH3L2gbhuFw/N2e4Hm7H0kXC5dG4BddQ2i2zyzVx
P5Z71W67bcr7T7/7w2xJ4h9QImutSekFG9n/mK7jO86g/0HtPxBpBhFGeZP0LHFl
+A5aRVQvl0Yd8kjy+urp6WppKnryvA==
=Olxq
-----END PGP SIGNATURE-----

--oXNgvKVxGWJ0RPMJ--



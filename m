Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF53C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2EB222C3
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 13:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+Q2lq1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2EB222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iriwN-00064f-KC
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 08:42:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1irivc-00057w-3w
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:41:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1irivb-0000He-2h
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:41:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29156
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iriva-0000HA-VU
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 08:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579095706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cYL673UkTlK8H5gujSEH2bKDA7Iho2GaUB+lV9tOJ3Q=;
 b=G+Q2lq1Q3iXIX+P5fd+KiuzlmH1p9WzZb8cHBz0+KyYGLD75YfKSm0k5D9i+E32l6n0/2I
 /VjQBuviWLvuwoCSoo4gDVbl/EV9l31JMfClMai9rYXhrvqnB+dnIngXBUC/m12cD4C1tk
 vYRmbfQwoZn+4ktnWOT3JAs98cftT7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-mo1FoXbQNkG8m0jNZ2U-cw-1; Wed, 15 Jan 2020 08:41:42 -0500
X-MC-Unique: mo1FoXbQNkG8m0jNZ2U-cw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 112F018CA240;
 Wed, 15 Jan 2020 13:41:42 +0000 (UTC)
Received: from localhost (ovpn-117-209.ams2.redhat.com [10.36.117.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 96F1719C5B;
 Wed, 15 Jan 2020 13:41:41 +0000 (UTC)
Date: Wed, 15 Jan 2020 13:41:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v2 2/4] luks: implement .bdrv_measure()
Message-ID: <20200115134140.GH163546@stefanha-x1.localdomain>
References: <20200109111012.559052-1-stefanha@redhat.com>
 <20200109111012.559052-3-stefanha@redhat.com>
 <1e812068-4009-9203-c252-5922000dbbb3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1e812068-4009-9203-c252-5922000dbbb3@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2020 at 04:43:36PM +0100, Max Reitz wrote:
> On 09.01.20 12:10, Stefan Hajnoczi wrote:
> > Add qemu-img measure support in the "luks" block driver.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/crypto.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index ed32202fa2..51f37bb1f6 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -548,6 +548,87 @@ static int64_t block_crypto_getlength(BlockDriverS=
tate *bs)
>=20
> [...]
>=20
> > +            if (ret & BDRV_BLOCK_ZERO) {
> > +                /* Skip zero regions */
> > +            } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)=
) =3D=3D
> > +                       (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
> > +                /* Count clusters we've seen */
> > +                required +=3D pnum;
> > +            }
>=20
> Don=E2=80=99t LUKS-encrypted files allocate effectively everything becaus=
e zero
> data has to be encrypted, too?
>=20
> (=E2=80=9CEffectively=E2=80=9D, because you could zero out regions that a=
re zero when
> encrypted, but...)
>=20
> > +        }
> > +    }
> > +
> > +    /* Take into account preallocation.  Nothing special is needed for
> > +     * PREALLOC_MODE_METADATA since metadata is always counted.
> > +     */
> > +    if (prealloc =3D=3D PREALLOC_MODE_FULL || prealloc =3D=3D PREALLOC=
_MODE_FALLOC) {
> > +        required =3D virtual_size;
>=20
> Same here.  I think required should always be set to virtual_size.

Good points.  I may have inherited this from the qcow2 code, where the
L2 tables can still have unallocated/zero clusters.

I'll check if this logic makes sense outside of qcow2.

Stefan

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4fFpQACgkQnKSrs4Gr
c8iiWQf/caySAQtjvnDqQatxF2qk9whQNRxR0Ag7uHQIYiJjqRuJC0M2Ijs65ava
wYMso1wMZmvf9JC7AmqoLB6JRfky2huZymPi2VM5scCk/4/izmqd3pLJJ9xEzUJb
tts/fj0yEeNXZI22mwIi6KhjtUwT4QgIvkO2Vkzh+nsWWCjiAnOBkSQzdLugbEw/
K/ErJxN+qnQR1KWE/raIXVy5yqFEjOWh8bpjBboUJzkGEFujUaN9C+zIKTTXxaRo
LTOqlKEyF5IvTE9bkJfxjPGZv5iwSkoJVGfmMzRUMsiQInr5jdrzP5Zdm0nqsSlh
ov65vYtFhZtdXTyAatQrdb0ipoZWUw==
=PCHN
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--



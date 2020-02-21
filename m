Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA9BC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:19:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C20F207FD
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 11:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nysyK/yV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C20F207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j56Kh-0001uy-QU
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 06:18:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j56Jr-0000eZ-9g
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:18:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j56Jq-0005l8-Ag
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 06:18:07 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j56Jq-0005km-40; Fri, 21 Feb 2020 06:18:06 -0500
Received: by mail-wr1-x444.google.com with SMTP id c9so1582895wrw.8;
 Fri, 21 Feb 2020 03:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7PutZxexlNapWDA8hZ+U0o774pVrySnXaNVLvj7honU=;
 b=nysyK/yVQ2YWIFVQ/srZ750EtdWOrvf6bH44kzSQcNcvb1zmuk+/YpjFwZ8PUnL2Ns
 yP5sgWjUVTT8h/UUavxNineeFMlLh2ZUXL/pHNUqhNUBnZKCvC4NgB9UGgJk8cpRO4ck
 eGxI23xOB59dsbn+hvjcdZD28TAh32lcT6uZlYEBaeHXrHdHqGcETNqTOu0NIBr7u/Wi
 aNF13kzDafM4i1rY+mPbCLMea7nZMKW3QsoQs1TIAWTiZvgBFrZn7dQ5Guf9UgqMM7f3
 71E6EuHyZSWzlQfiuT9IxqiDX73mBsdOaZ9YnhAlF2oz5coMQOz6ypidybhIN+QZhJhn
 kb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7PutZxexlNapWDA8hZ+U0o774pVrySnXaNVLvj7honU=;
 b=C40bM9JZPztLtVE8Jicc7+0RzvOZIf+mfX8nocQJwPOMEmvWYgQd5sMPRa9EDGoUpH
 hlt2K6HnTdOENEDt6v1frFx97MAXQN+CfN5MmjwvM8UfbqWJWEEhaf8oAv/DCX7bDYQi
 6tYMyaN38gT2DRm4L7F2M8fFGx6d9u32Hx4ApDvkx+Jag0DeEEYVIiqttfxucIOqITLY
 9v38Ppgrbb3Sbt2gjuUlR+Loby4XJu7B/vrlB5PkQo5aevMsB/n7Xar9BEjaOo7OSpQb
 rJ/7GnEa9qVQonXSc+qz2CMp/9aJMS3iY7d+9RG2omQv7AlJTkbeqgCZpLSbTPZw0tRb
 +8GQ==
X-Gm-Message-State: APjAAAVo0yEh32dn7lcflfdNABJ3q8V7o+vX9KY3Kd8izDamp2onaomD
 slJWzDp3pL2eHJZELENN/do=
X-Google-Smtp-Source: APXvYqxQEg/uHVgoQxQn3MC5gn3GBaIw2RDOFbTc4peKHoXW/woMopfjoTvvtWHWjV5slXp1eK0Vvg==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr47221873wrq.125.1582283884865; 
 Fri, 21 Feb 2020 03:18:04 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id d22sm3050668wmd.39.2020.02.21.03.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 03:18:03 -0800 (PST)
Date: Fri, 21 Feb 2020 11:18:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 2/4] luks: implement .bdrv_measure()
Message-ID: <20200221111802.GF1484511@stefanha-x1.localdomain>
References: <20200211160318.453650-1-stefanha@redhat.com>
 <20200211160318.453650-3-stefanha@redhat.com>
 <f93c484a-39e6-2745-e493-a9c2ed0a83c2@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4f28nU6agdXSinmL"
Content-Disposition: inline
In-Reply-To: <f93c484a-39e6-2745-e493-a9c2ed0a83c2@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--4f28nU6agdXSinmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 04:46:34PM +0100, Max Reitz wrote:
> On 11.02.20 17:03, Stefan Hajnoczi wrote:
> > Add qemu-img measure support in the "luks" block driver.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/crypto.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >=20
> > diff --git a/block/crypto.c b/block/crypto.c
> > index 24823835c1..453119875e 100644
> > --- a/block/crypto.c
> > +++ b/block/crypto.c
> > @@ -484,6 +484,67 @@ static int64_t block_crypto_getlength(BlockDriverS=
tate *bs)
>=20
> [...]
>=20
> > +    cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
> > +            &block_crypto_create_opts_luks, true);
> > +    qdict_put_str(cryptoopts, "format", "luks");
> > +    create_opts =3D block_crypto_create_opts_init(cryptoopts, errp);
>=20
> It looks a bit weird to me to use errp here...
>=20
> > +    qobject_unref(cryptoopts);
> > +    if (!create_opts) {
> > +        goto err;
> > +    }
> > +
> > +    if (!qcrypto_block_calculate_payload_offset(create_opts, NULL,
> > +                                                &luks_payload_size,
> > +                                                &local_err)) {
>=20
> ...and local_err here.  Either works, but consistent style would be a
> bit nicer.
>=20
> But not more correct, so:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>

Thanks, will fix!

Stefan

--4f28nU6agdXSinmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5PvGoACgkQnKSrs4Gr
c8hHQgf/Tt2mnGTWob7rdTC1xloAiKRtWT9NF0TiYcpQN6kGRT91cPV222ilOBlz
Uko0VGrdF1kQhXPZYeVEKFP6LK7+uedhYOWMURkBO0eQIrFCY8nsGkKt6deVdo6r
xZ8aoHr2bZ62ThIPDDtVE+nGfXmBjEpm8+Vgq4jbEC73gOk1MYXciapilO30QefN
pDvfC8LE+bRFChi2o72MmQvYCEpE3eX1an9wB806XYT1b8frqZc39LSMAts+Nr9b
RfBMwXmbelRLYyrkGkYlk2rBn+xGPbxOs1I7nZys3GxAqWFMcLBGrNCrLAQ4Njp5
1QIHTtnI089jt6POJrJ7NNy5ydIC5w==
=Hkh1
-----END PGP SIGNATURE-----

--4f28nU6agdXSinmL--


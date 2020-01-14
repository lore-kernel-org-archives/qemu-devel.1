Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A198C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B9124656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9DXvFuY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B9124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irP6l-0005XH-AU
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 11:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1irP4w-0003jS-0C
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:30:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1irP4u-0006Z3-Vv
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 11:30:05 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36212)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1irP4u-0006Xi-OH; Tue, 14 Jan 2020 11:30:04 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so14483124wma.1;
 Tue, 14 Jan 2020 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=VAWUf470votaGlO3dpWxsjkTNozhmpJDGFqMebMYQ+0=;
 b=W9DXvFuYrSiE+qtSeSsdcpLJRkNJIoJPyXa8Azj87Mir2u9lF4EJXuRvyK0xyEypJ0
 dcS2nvr5ni5UrIb5ya8Utr7uist6/8P58jOvq9bsyz0ktOiucD5mQkWpuWFk0DO3m4zv
 3NbWpSHDxx65kciql+WUIuJkrCwsqiSQPE5lNsoe1q+uVe35fETAlJbKmlwQYPnr9K5E
 WtDy+lgCL7vtXea62fA5niQJNqZ0dbCq6mDwlguPQlCin4hNbEEB2/8k5O3/7TI2dfWV
 1gCQhZNKftcj296MpWF+dNOC/lcMvz5WpM5POjr2Pgm09/076Ax3inyW+wXGYKFFMSdD
 xF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VAWUf470votaGlO3dpWxsjkTNozhmpJDGFqMebMYQ+0=;
 b=PixRNPe1o8Ywba/wOzh1+nvq4Gb5U21ZbNNursoin4L70il+Tb7oKE/TvsHfZmMS4P
 AR5Ck1JsDgwNLx5Q/4rHQQ/DbLMzh/waM13fsnOWZAsLFt7k8oH9pffVTYQjJCtQEZca
 teZIMWRShuK/5HntHHdH/N0jR3JyP+f6uXLhI/KGZMP0LvypsDmZ03lR+jxT0jUO8F7M
 zIrgrWK1uqtxnlSKcm4dVgEVZCogCzSepNmu5DBl98XVYnM996eLbn0nGlWEJBc3PBw5
 8OQQytTRpaiEkJAWYI8R0KZcNICpp7CWap8DunndpVDQTaKPlne71L2bsur2qu9hwoQT
 weJQ==
X-Gm-Message-State: APjAAAXx3tUR4Gdgw+k2h/S+txz9vRqyvcKTQh0kYxRT2YbOgi+xUOtM
 q8XUTMUw8VG+WbNlCuVufWY=
X-Google-Smtp-Source: APXvYqzOl3OY3LrH59MuAN5EM+iRiSzrT01WtxWdm789Zqr01da2ITBLSYVd/0geSCkJjUP1CyAk1Q==
X-Received: by 2002:a1c:6a12:: with SMTP id f18mr2277844wmc.29.1579019403584; 
 Tue, 14 Jan 2020 08:30:03 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id y20sm18785599wmi.25.2020.01.14.08.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2020 08:30:02 -0800 (PST)
Date: Tue, 14 Jan 2020 16:30:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 2/4] block: Mark 'block_resize' as coroutine
Message-ID: <20200114163000.GE132666@stefanha-x1.localdomain>
References: <20200109183545.27452-1-kwolf@redhat.com>
 <20200109183545.27452-3-kwolf@redhat.com>
 <20200113165648.GD103384@stefanha-x1.localdomain>
 <20200113171009.GH5549@linux.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Content-Disposition: inline
In-Reply-To: <20200113171009.GH5549@linux.fritz.box>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 06:10:09PM +0100, Kevin Wolf wrote:
> Am 13.01.2020 um 17:56 hat Stefan Hajnoczi geschrieben:
> > On Thu, Jan 09, 2020 at 07:35:43PM +0100, Kevin Wolf wrote:
> > > block_resize is safe to run in a coroutine, so use it as an example f=
or
> > > the new 'coroutine': true annotation in the QAPI schema.
> > >=20
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  qapi/block-core.json | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > index 7ff5e5edaf..1dbb2a9901 100644
> > > --- a/qapi/block-core.json
> > > +++ b/qapi/block-core.json
> > > @@ -1341,7 +1341,8 @@
> > >  { 'command': 'block_resize',
> > >    'data': { '*device': 'str',
> > >              '*node-name': 'str',
> > > -            'size': 'int' } }
> > > +            'size': 'int' },
> > > +  'coroutine': true }
> > > =20
> > >  ##
> > >  # @NewImageMode:
> >=20
> > coroutine_fn is missing on
> > blockdev.c:void qmp_block_resize(bool has_device, const char *device,
>=20
> It wouldn't even be true until after patch 4. Should I reorder the
> patches so I can add coroutine_fn?

Yes, please.

Stefan

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4d7IgACgkQnKSrs4Gr
c8iHAAgAw/lZ5s8tb8P/cbOQ+WtDUxip00NpCShEyUgS29+oSh4Z1N3BmkUEvg45
Oj3+vUqr9AKo4fPZtyU78NLOKwLLO+T7kU3WF7G75q2PxZVqN8Bmi5AYWRWdVaBT
RBd1Gmi2QAlCWqTiEv4HN/Zg9jQEH4Ze9XD9wyr86CvxksGZ6vaY06PgfwWqUNmM
HLAfTrKwwEx828Omnki+d5YqHO5OZMZVPujNirMdCtO3AIOmz0RBzN3G+cpK4PNe
EqQANlzr+VRSVp+sqeqJyEV3aNksJkAyA3d2w2EiVn6DSBAV5iPLYFMm24QCrakU
G1xwhj8Nl4J5UWKbC/59l1al7PbLnQ==
=V4UJ
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--


Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01A1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7999B2072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPCb7MBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7999B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7eXU-0004q8-Hc
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7eWQ-0004Hb-1l
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:45:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31739
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7eWN-0000On-ED
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597668350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RE5ynoTs7B5FNLJow0TpHVRqJb/EOjeUO1h8DCMDH2E=;
 b=KPCb7MBvBO59UvO/O0hpI8ucHc9fZ0m1hvJxfRrr0PJ/4kWr2mecrk9LU8LtsYvlpk4lQt
 G1XL/u8bgSrB48Ux//XRkI3psfGZ9aXphaT84YCsk/x4X7f34W6XS2C4Gp1WseeY4zBlj6
 ww6yhJXXxFPtOW+3uvD96tpSOM2a8WE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-wC2BlPbiMR6k5PaDuh0g-A-1; Mon, 17 Aug 2020 08:45:48 -0400
X-MC-Unique: wC2BlPbiMR6k5PaDuh0g-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12FA4801AC9;
 Mon, 17 Aug 2020 12:45:47 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F0C0D795AE;
 Mon, 17 Aug 2020 12:45:45 +0000 (UTC)
Date: Mon, 17 Aug 2020 14:45:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 04/22] block/export: Add BlockExport infrastructure
 and block-export-add
Message-ID: <20200817124544.GI11402@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-5-kwolf@redhat.com>
 <7ed669db-7a75-fb25-4ce6-52369ea01b4b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7ed669db-7a75-fb25-4ce6-52369ea01b4b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 05:03:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.08.2020 um 12:03 hat Max Reitz geschrieben:
> On 13.08.20 18:29, Kevin Wolf wrote:
> > We want to have a common set of commands for all types of block exports=
.
> > Currently, this is only NBD, but we're going to add more types.
> >=20
> > This patch adds the basic BlockExport and BlockExportDriver structs and
> > a QMP command block-export-add that creates a new export based on the
> > given BlockExportOptions.
> >=20
> > qmp_nbd_server_add() becomes a wrapper around qmp_block_export_add().
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-export.json     |  9 ++++++
> >  include/block/export.h     | 32 +++++++++++++++++++++
> >  include/block/nbd.h        |  3 +-
> >  block/export/export.c      | 57 ++++++++++++++++++++++++++++++++++++++
> >  blockdev-nbd.c             | 19 ++++++++-----
> >  nbd/server.c               | 15 +++++++++-
> >  Makefile.objs              |  6 ++--
> >  block/Makefile.objs        |  2 ++
> >  block/export/Makefile.objs |  1 +
> >  9 files changed, 132 insertions(+), 12 deletions(-)
> >  create mode 100644 include/block/export.h
> >  create mode 100644 block/export/export.c
> >  create mode 100644 block/export/Makefile.objs
>=20
> Nothing of too great importance below.  But it=E2=80=99s an RFC, so comme=
nts I
> will give.
>=20
> > diff --git a/block/export/export.c b/block/export/export.c
> > new file mode 100644
> > index 0000000000..3d0dacb3f2
> > --- /dev/null
> > +++ b/block/export/export.c
> > @@ -0,0 +1,57 @@
> > +/*
> > + * Common block export infrastructure
> > + *
> > + * Copyright (c) 2012, 2020 Red Hat, Inc.
> > + *
> > + * Authors:
> > + * Paolo Bonzini <pbonzini@redhat.com>
> > + * Kevin Wolf <kwolf@redhat.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * later.  See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "block/export.h"
> > +#include "block/nbd.h"
> > +#include "qapi/error.h"
> > +#include "qapi/qapi-commands-block-export.h"
> > +
> > +static const BlockExportDriver* blk_exp_drivers[] =3D {
>                                  ^^
> Sternenplatzierung *hust*
>=20
> > +    &blk_exp_nbd,
> > +};
>=20
> Not sure whether I like this better than the block driver way of
> registering block drivers with a constructor.  It requires writing less
> code, at the expense of making the variable global.  So I think there=E2=
=80=99s
> no good reason to prefer the block driver approach.

I guess I can see one reason why we may want to switch to the
registration style eventually: If we we want to make export drivers
optional modules which may or may not be present.

> Maybe my hesitance comes from the variable being declared (as extern) in
> a header file (block/export.h).  I think I would prefer it if we put
> that external reference only here in this file.  Would that work, or do
> you have other plans that require blk_exp_nbd to be visible outside of
> nbd/server.c and this file here?

Hm, do we have precedence for "public, but not really" variables?
Normally I expect public symbols to be declared in a header file.

> > +static const BlockExportDriver *blk_exp_find_driver(BlockExportType ty=
pe)
> > +{
> > +    int i;
> > +
> > +    for (i =3D 0; i < ARRAY_SIZE(blk_exp_drivers); i++) {
> > +        if (blk_exp_drivers[i]->type =3D=3D type) {
> > +            return blk_exp_drivers[i];
> > +        }
> > +    }
>=20
> How bad would it be to define blk_exp_drivers as
> blk_exp_drivers[BLOCK_EXPORT_TYPE__MAX] and use the BlockExportType as
> the driver index so we don=E2=80=99t have to loop here?
>=20
> Not that it matters performance-wise.  Just something I wondered.

Might be nicer indeed. It would be incompatible with a registration
model, though, so if we're not sure yet what we want to have in the long
term, maybe the more neutral way is to leave it as it is.

> > +    return NULL;
>=20
> Why not e.g. g_assert_not_reached()?
>=20
> (If the BlockExportType were used as the index, I=E2=80=99d assert that
> type < ARRAY_SIZE(blk_exp_drivers) && blk_exp_drivers[type] !=3D NULL.  I
> don=E2=80=99t think there=E2=80=99s a reason for graceful handling.)

Same thing actually. This works as long as all drivers are always
present.

Now I understand that the current state is somewhat inconsistent in that
it uses a simple array of things that are always present, but has
functions that work as if it were dynamic. I don't mind this
inconsistency very much, but if you do, I guess I could implement a
registration type thing right away.

Kevin

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl86e/gACgkQfwmycsiP
L9aShQ//cwyzyJbs4aLqdNNmosg52dFp+OLd7M5+xNHRhN+bcH7H5ZaKxudAhpqy
kqb7UR6XTklnH5gTBpJmQm+PHwKoe4vrplDZROxd95dPLt4U3gg3MRKaoH9HdDOK
iN7xc393NilJhEgPpBQJMFPtoRXy6F5GVyZ2Y1766zYL3OC6BsMiBSv+r7BE9lfn
h4CIoPrY8kqHMXWHbsz+BeTDwqQRSLAXfi0EfE6i5upKmltFYnKPW+yht5QPLZSM
7ern6ThL0OZpd4wXhvViWcLE6Qi0Of0eqSWrfevgL2WChiyeTBXUFY4oXG/OaFVE
6EkA39aENTL5mL+xpoikTxC0pZXsepn16YkMjPfF5NUWcrAmDvMx+5tb2PrjAxP0
XOVS58WNlFS7tQ9Wm/9e3bnFSRbmk8eRjzhm5lzgAIdzEaV2Oy2Kyc/P2syORMSI
EH+3bY4KTNew1lc0Aieyvg/P3+4LgtINQwA8y22d6gC866iWnwy+Z6xsS+tRO+sm
3IkxZrXmIzCD58a/EMYlZJKDl4YM6SGVz/okixEXc9xOGZ2ww7Tb3fNCxLB9B72A
pN9OlKaeWDNhVLNkDBau0DA2xDW8gum/wxiQFR8lKW4Xqol5Dl33tJi4jd3q4yxx
OINUuHeYb4p1vA5f/eSTYTsXkNqArMEVfa3o6AeeNjVxwgdLeVg=
=J/aP
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--



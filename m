Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2502DC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE4F520578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ci9JZJoV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4F520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7fDl-0008K4-4o
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7fCv-0007oA-Te
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7fCs-00068E-08
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597670984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KSk2wd/WVOkO7Mngb8oiIEDAX2aBxNHABrw7qjuRAbI=;
 b=ci9JZJoV7QDZHogDAOoHRCNXIUUZMMODrJ9RqAES5JQZP/uR/iOwZJxaxyGPZ84gJXifT9
 8/oJLlrXzhjuoMtMOEUkp2cRQemZA7neqspJdn2/mpckEqFpOJN9GwzivV3k6fpJpi7wDl
 4EVgPGVfFLYssidfUFH+R473hH4Kv3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-8t4Kvkx-N3SMH8l54e8J0w-1; Mon, 17 Aug 2020 09:29:42 -0400
X-MC-Unique: 8t4Kvkx-N3SMH8l54e8J0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA941185E525;
 Mon, 17 Aug 2020 13:29:41 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55E9210021AA;
 Mon, 17 Aug 2020 13:29:40 +0000 (UTC)
Date: Mon, 17 Aug 2020 15:29:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 04/22] block/export: Add BlockExport infrastructure
 and block-export-add
Message-ID: <20200817132938.GM11402@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-5-kwolf@redhat.com>
 <7ed669db-7a75-fb25-4ce6-52369ea01b4b@redhat.com>
 <20200817124544.GI11402@linux.fritz.box>
 <0a8939b5-4441-e76e-44c5-b27e69eba3b8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0a8939b5-4441-e76e-44c5-b27e69eba3b8@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 02:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.08.2020 um 15:19 hat Max Reitz geschrieben:
> On 17.08.20 14:45, Kevin Wolf wrote:
> > Am 17.08.2020 um 12:03 hat Max Reitz geschrieben:
> >> On 13.08.20 18:29, Kevin Wolf wrote:
> >>> We want to have a common set of commands for all types of block expor=
ts.
> >>> Currently, this is only NBD, but we're going to add more types.
> >>>
> >>> This patch adds the basic BlockExport and BlockExportDriver structs a=
nd
> >>> a QMP command block-export-add that creates a new export based on the
> >>> given BlockExportOptions.
> >>>
> >>> qmp_nbd_server_add() becomes a wrapper around qmp_block_export_add().
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  qapi/block-export.json     |  9 ++++++
> >>>  include/block/export.h     | 32 +++++++++++++++++++++
> >>>  include/block/nbd.h        |  3 +-
> >>>  block/export/export.c      | 57 ++++++++++++++++++++++++++++++++++++=
++
> >>>  blockdev-nbd.c             | 19 ++++++++-----
> >>>  nbd/server.c               | 15 +++++++++-
> >>>  Makefile.objs              |  6 ++--
> >>>  block/Makefile.objs        |  2 ++
> >>>  block/export/Makefile.objs |  1 +
> >>>  9 files changed, 132 insertions(+), 12 deletions(-)
> >>>  create mode 100644 include/block/export.h
> >>>  create mode 100644 block/export/export.c
> >>>  create mode 100644 block/export/Makefile.objs
> >>
> >> Nothing of too great importance below.  But it=E2=80=99s an RFC, so co=
mments I
> >> will give.
> >>
> >>> diff --git a/block/export/export.c b/block/export/export.c
> >>> new file mode 100644
> >>> index 0000000000..3d0dacb3f2
> >>> --- /dev/null
> >>> +++ b/block/export/export.c
> >>> @@ -0,0 +1,57 @@
> >>> +/*
> >>> + * Common block export infrastructure
> >>> + *
> >>> + * Copyright (c) 2012, 2020 Red Hat, Inc.
> >>> + *
> >>> + * Authors:
> >>> + * Paolo Bonzini <pbonzini@redhat.com>
> >>> + * Kevin Wolf <kwolf@redhat.com>
> >>> + *
> >>> + * This work is licensed under the terms of the GNU GPL, version 2 o=
r
> >>> + * later.  See the COPYING file in the top-level directory.
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +
> >>> +#include "block/export.h"
> >>> +#include "block/nbd.h"
> >>> +#include "qapi/error.h"
> >>> +#include "qapi/qapi-commands-block-export.h"
> >>> +
> >>> +static const BlockExportDriver* blk_exp_drivers[] =3D {
> >>                                  ^^
> >> Sternenplatzierung *hust*
> >>
> >>> +    &blk_exp_nbd,
> >>> +};
> >>
> >> Not sure whether I like this better than the block driver way of
> >> registering block drivers with a constructor.  It requires writing les=
s
> >> code, at the expense of making the variable global.  So I think there=
=E2=80=99s
> >> no good reason to prefer the block driver approach.
> >=20
> > I guess I can see one reason why we may want to switch to the
> > registration style eventually: If we we want to make export drivers
> > optional modules which may or may not be present.
>=20
> Good point.
>=20
> >> Maybe my hesitance comes from the variable being declared (as extern) =
in
> >> a header file (block/export.h).  I think I would prefer it if we put
> >> that external reference only here in this file.  Would that work, or d=
o
> >> you have other plans that require blk_exp_nbd to be visible outside of
> >> nbd/server.c and this file here?
> >=20
> > Hm, do we have precedence for "public, but not really" variables?
> > Normally I expect public symbols to be declared in a header file.
>=20
> Hm, yes.
>=20
> tl;dr: I was wrong about a local external reference being nicer.  But I
> believe there is a difference between externally-facing header files
> (e.g. block.h) and internal header files (e.g. block_int.h).  I don=E2=80=
=99t
> know which of those block/export.h is supposed to be.
>=20
> (And of course it doesn=E2=80=99t even matter at all, really.)
>=20
>=20
> non-tl;dr:
>=20
> We have a similar case for bdrv_{file,raw,qcow2}, but those are at least
> in a *_int.h.  I can=E2=80=99t say I like that style.
>=20
> OK, let me try to figure out what my problem with this is.
>=20
> I think if a module (in this case the NBD export code) exports
> something, it should be available in the respective header (i.e., some
> NBD header), not in some other header.  A module=E2=80=99s header should =
present
> what it exports to the rest of the code.  The export code probably
> doesn=E2=80=99t want to export the NBD driver object, it wants to import =
it,
> actually.  So if it should be in a header file, it should be in an NBD
> header.
>=20
> Now none of our block drivers has a header file for exporting symbols to
> the rest of the block code, which is why their symbols have been put
> into block_int.h.  I think that=E2=80=99s cutting corners, but can be def=
ended
> by saying that block_int.h is not for exporting anything, but just
> collects stuff internal to the block layer, so it kind of fits there.
>=20
> (Still, technically, I believe bdrv_{file,raw,qcow2} should be exported
> by each respective block driver in a driver-specific header file.  If
> that isn=E2=80=99t the case, it doesn=E2=80=99t really matter to me wheth=
er it=E2=80=99s put
> into a dedicated header file to collect internal stuff (block_int.h) or
> just imported locally (with an external declaration) where it=E2=80=99s u=
sed.
> Probably the dedicated header file is cleaner after all, right.)
>=20
> Maybe block/export.h is the same in that it=E2=80=99s just supposed to co=
llect
> symbols used internally by the export code, then it isn=E2=80=99t wrong t=
o put
> it there.  But if it=E2=80=99s a header file that may be used by non-expo=
rt code
> to use export functionality, then it would be wrong.
>=20
> But whatever.
>=20
> Now I have sorted out my feelings, and they don=E2=80=99t give any result=
 at
> all, but it was kind of therapeutic for me.

Actually, there could be a conclusion: The declaration shouldn't be in
include/block/export.h, but in include/block/nbd.h. We already include
both headers in block/export/export.c because of qmp_nbd_*().

Of course, you already requests that I leave the other NBD-related stuff
in blockdev-nbd.c rather than moving it there, so the use of blk_exp_nbd
would be the only reason that remains for export.c to include nbd.h.

But it might still be better than having it in export.h.

Kevin

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl86hkIACgkQfwmycsiP
L9aCWQ/9GxO6OuszJXNNzszYFqaFesCIM0MyHQ03EacTU18sUsmxejV9zAm8xjWO
PVEOZF7qKuJnWvYA7QUsGnUcRYdKMKTVfT7/GhRGpAN1Cmj9bSbfYVYw1NaOYnq+
qmQrYj2G5CcebW0DfpLEorQCPVN9iWle1+P6XbI2oF/qHFI4kY3iV/AGqjNl3orD
lX2P0mXhdxj7QhWkSvCeV4vQpbh7+Tk7k58thUPPLY/bVfX7hocixYNyDuAJ6Gbi
LVuz4vErDXvxjWUyKInLBPlEvntbu9cx/3n4cbHwdlX4wXeackTe8/slbpxLkgjO
XZ8kxq44X31XY7p+ldFJymPYqEHv0ShDN7w9lEsY3RvX+Jm50J8zFxsd2aoQL9Cj
IRzVk54sZHBe23jH07Z3uZgsD9BqFewSGN86yCXx2M9ShKjGtiWjCA+MTvYRqNGj
M9ZScV8cQxeFNnP3Hd7hu+8p0VoGX/BffOjJG+nGU2SslCjL7MaUr5PDlFG1rplr
IdX0lcaFuNgwsO6UbKCyo4bdub2trL7MbH0+fu2iQoAJl/8KsgN9n3+qt69OWtMj
xCsl5BCQ3S9tGiQh8yo3ETnyrpwpK+B+qJA1u5XYODT80eTl1h3qqC0JvpgaZsHy
42NqRJ8RY+c20MUd2svnwh+/tgNdhMxUoi92qDjeW2cgT5Ixjns=
=Ihrv
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--



Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6882C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8750C21744
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 15:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMoOVh+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8750C21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7hVz-0007dd-O2
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 11:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7h30-0003iJ-Ql
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:27:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43957
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7h2y-00053y-WC
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 11:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597678059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEpOpEHcWwZagtUH+FXPP7qxnaO7svlFUrJ1/mJH3Jo=;
 b=EMoOVh+6QCCThfAGreTEEhQpEynds+t16Os+TzNUVenU4EJdyrEAOTl+6ydmMjdOra8G4K
 ZwJnDcbq6kToNGFceHIQoD56DIZYGx/WClHEvFV6Ugi1O0b3Vc4Jy8uvaFCIA/nLmyIROR
 HaGdV4FG5/q2H9U61FYYfS2tnu37hHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-eH8WF0H4P9m_IVEegBjk9A-1; Mon, 17 Aug 2020 11:27:36 -0400
X-MC-Unique: eH8WF0H4P9m_IVEegBjk9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEB8881CB00;
 Mon, 17 Aug 2020 15:27:35 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3D157A3B4;
 Mon, 17 Aug 2020 15:27:34 +0000 (UTC)
Date: Mon, 17 Aug 2020 17:27:33 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 15/22] block/export: Move device to BlockExportOptions
Message-ID: <20200817152733.GQ11402@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-16-kwolf@redhat.com>
 <a163c834-bfc8-897a-c91f-8458b50dfdb6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a163c834-bfc8-897a-c91f-8458b50dfdb6@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WHz+neNWvhIGAO8A"
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--WHz+neNWvhIGAO8A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.08.2020 um 17:13 hat Max Reitz geschrieben:
> On 13.08.20 18:29, Kevin Wolf wrote:
> > Every block export needs a block node to export, so move the 'device'
> > option from BlockExportOptionsNbd to BlockExportOptions.
> >=20
> > To maintain compatibility in nbd-server-add, BlockExportOptionsNbd need=
s
> > to be wrapped by a new type NbdServerAddOptions that adds 'device' back
> > because nbd-server-add doesn't use the BlockExportOptions base type.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-export.json         | 27 +++++++++++++++++++++------
> >  block/export/export.c          | 26 ++++++++++++++++++++------
> >  block/monitor/block-hmp-cmds.c |  6 +++---
> >  blockdev-nbd.c                 |  4 ++--
> >  qemu-nbd.c                     |  2 +-
> >  5 files changed, 47 insertions(+), 18 deletions(-)
>=20
> (Code diff looks good, just a question on the interface:)
>=20
> > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > index 4ce163411f..d68f3bf87e 100644
> > --- a/qapi/block-export.json
> > +++ b/qapi/block-export.json
>=20
> [...]
>=20
> > @@ -167,6 +179,8 @@
> >  # Describes a block export, i.e. how single node should be exported on=
 an
> >  # external interface.
> >  #
> > +# @device: The device name or node name of the node to be exported
> > +#
>=20
> Wouldn=E2=80=99t it be better to restrict ourselves to a node name here?
> (Bluntly ignoring the fact that doing so would make this patch an
> incompatible change, which would require some reordering in this series,
> unless we decide to just ignore that intra-series incompatibility.)

We already have intra-series incompatibility, so I wouldn't mind that.

> OTOH...  What does =E2=80=9Cbetter=E2=80=9D mean.  It won=E2=80=99t hurt =
anyone to keep this as
> @device.  It=E2=80=99s just that I feel like if we had no legacy burden a=
nd did
> this all from scratch, we would just make it @node-name.
>=20
> Did you deliberately decide against @node-name?

At first I thought I could still share code between nbd-server-add and
block-export-add, but that's not the case. Then I guess the only other
reason I have is consistency with other QMP commands. I won't pretend
it's a strong one.

Kevin

--WHz+neNWvhIGAO8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl86oeUACgkQfwmycsiP
L9Z2VQ//cIkPDc/Y7d+b+rzue4huN6e7Lzy8zbqViOoX+bFYvTdhpjbUNJEigBAB
exOOHYlC5uM1g9CZrWzd4C+jPlulJ2Ko7Tn9lBSRgg4e8G7fLxejlhnBfN8qItca
E7IKP3DG9L9oU8z0qvHG37uo/CNUbNVSECGMWnTJbTACB31Vg+DsLnJ+yo+KvPnq
TIpq/Tvnh8kWrt1gHinQmHbpSDcOxiQOsQ6K9bnwPYNb7QvIap1yUSTIMdKu9+1e
FDdi6khNITFNx9EJAwYGRZgklcsvjfkbHkPGO0C2EnlrwS0H1P4rlej35EE2bbee
VGOv2EFmAYTCjYvKSGbGITeIX07iW9q9LgwMucMG/NYJ950xosINaOwPt7tQ6qHL
6HteVb/otN17FSC0oR7KqGK14xIW3HmluHEBnZQ2qz3Fe37c/sFA1f8ORNcGV1E4
Kw0Qq3nzK+VudEmxbRYdpL5F5EoGycGm7bSA5+QW1WGVhKnRKFgTEvYcJ8Fb8OpS
174d7wYBMbTTc7svtmy5OVTrRLIEwkpoGhmv4dwSUSfdkxbfrG/vxJVBJ8bS0aKi
zq6tOb+KCCU97wpM4mTqKinf6qmub1iX26s5DHQGEkZ3hr8eT9nF7SbYpxxZn0Yy
PlJlDAA1xZSRrqzV+kH6KLdRd2H7jsb7zbdItRyNq6tm1gxFPvs=
=DLYA
-----END PGP SIGNATURE-----

--WHz+neNWvhIGAO8A--



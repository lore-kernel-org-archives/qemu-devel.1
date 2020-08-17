Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B1C02072E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 13:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YD20jagH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1C02072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7eyU-0001La-A3
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 09:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7exj-0000Uh-P2
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:14:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7exi-0004Dq-6L
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 09:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597670045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FHNImhvhH5ttP3Pw7AlYL+ZUPclk8CD0JSY6rPj1IR0=;
 b=YD20jagH1vU0Udqm8we/bGcqtVjtDVVEBOQOpHXjta8dI2vXcGI8W1ja/gJTuP+lAmjNXS
 lP/zm0DIZZ8bD7PMBRReWC17glcOgeUik3DPP6k+pdRlSewqVMUBGr8SMeA8Azkof+Dx1a
 Qw/VkZR+2nnvnZ31Q5s7evds0yQ5mPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-oeXeoLxnNMKM3KrWntHfBQ-1; Mon, 17 Aug 2020 09:14:02 -0400
X-MC-Unique: oeXeoLxnNMKM3KrWntHfBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9887801AAE;
 Mon, 17 Aug 2020 13:14:01 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0C2910013C4;
 Mon, 17 Aug 2020 13:14:00 +0000 (UTC)
Date: Mon, 17 Aug 2020 15:13:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 09/22] nbd: Add writethrough to block-export-add
Message-ID: <20200817131359.GL11402@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-10-kwolf@redhat.com>
 <faa916e7-3c39-84f4-183f-808153abe12d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <faa916e7-3c39-84f4-183f-808153abe12d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Xm/fll+QQv+hsKip"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 00:24:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

--Xm/fll+QQv+hsKip
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.08.2020 um 14:56 hat Max Reitz geschrieben:
> On 13.08.20 18:29, Kevin Wolf wrote:
> > qemu-nbd allows use of writethrough cache modes, which mean that write
> > requests made through NBD will cause a flush before they complete.
> > Expose the same functionality in block-export-add.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  qapi/block-export.json | 7 ++++++-
> >  blockdev-nbd.c         | 2 +-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/qapi/block-export.json b/qapi/block-export.json
> > index 1fdc55c53a..4ce163411f 100644
> > --- a/qapi/block-export.json
> > +++ b/qapi/block-export.json
> > @@ -167,10 +167,15 @@
> >  # Describes a block export, i.e. how single node should be exported on=
 an
> >  # external interface.
> >  #
> > +# @writethrough: If true, caches are flushed after every write request=
 to the
> > +#                export before completion is signalled. (since: 5.2;
> > +#                default: false)
> > +#
> >  # Since: 4.2
> >  ##
> >  { 'union': 'BlockExportOptions',
> > -  'base': { 'type': 'BlockExportType' },
> > +  'base': { 'type': 'BlockExportType',
> > +            '*writethrough': 'bool' },
> >    'discriminator': 'type',
> >    'data': {
> >        'nbd': 'BlockExportOptionsNbd'
>=20
> Hm.  I find it weird to have @writethrough in the base but @device in
> the specialized class.
>
> I think everything that will be common to all block exports should be in
> the base, and that probably includes a node-name.  I=E2=80=99m aware that=
 will
> make things more tedious in the code, but perhaps it would be a nicer
> interface in the end.  Or is the real problem that that would create
> problems in the storage daemon=E2=80=99s command line interface, because =
then
> the specialized (legacy) NBD interface would no longer be compatible
> with the new generalized block export interface?

Indeed. I think patch 15 has what you're looking for.

> Anyway, @writable might be a similar story.  A @read-only may make sense
> in general, I think.

Pulling @writable up is easier than a @read-only, but that's a naming
detail.

In general I agree, but this part isn't addressed in this series yet.
Part of the reason why this is an RFC was to find out if I should
include things like this or if we'll do it when we add another export
type or common functionality that needs the same option.

> Basically, I think that the export code should be separate from the code
> setting up the BlockBackend that should be exported, so all options
> regarding that BB should be common; and those options are @node-name,
> @writethrough, and @read-only.  (And perhaps other things like
> @resizable, too, even though that isn=E2=80=99t something to consider for=
 NBD.)

Do you mean that the BlockBackend should already be created by the
generic block export layer?

Kevin

--Xm/fll+QQv+hsKip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl86gpcACgkQfwmycsiP
L9aZdA//Y38G7mjsfLNBh5naqFqVMutaIzWdPiXjWSR3enI5IoTAZRfiicNmRTRi
V8KKg/nLHQNe59nqbQyc0iJptzfkRlL2ODley3BdR5Lk2LWP65Vas13sGEzMFbkE
beKjFdM23r/DY//6HsGNzt1gdWLVNJ8T7zaY05uGQt4swx7rccMA4GV7bTZwM8bo
6cKa7SNzktaJxlotoeGbzuwVLU3EzQDXlZyc8tFepsuc9V2ggGCXKxvzF+udIt2T
opuqAvNWWjXP6LOF2mun2hoO0IPw80pxanyXi0vJptfNi6WoHm9bQTQ6SIJ1s0uR
uk/uaEpy3cW0ozMkDG2+P7yyT8IoIN5f47dQmUjpeJCD8TONMpi6W8Olp2+KeKaY
TgHAotzBQ8ugtRvIrGc0y5Z7uPSShdKNLyTVFSQ/TyHjU72RJDnxrjvosP7kdkeM
rz21bKsSTAmr7lRSfVdjzo9NdgLMFSl5LIHuDEEHfJZfSvskd/buCgJ6N09BQPx7
rb2/Sy09HCPev1+zI3nu0KzwM0dijPxybi/A/3ls2iwVn7u1bx2fcL/IlhxAxUTh
G/4nj28r5/W1O/q2gIVYresjtdhDg+bs6TCTYr3M9yf2cizC8Z8R5OKt8t6LjDJN
5GigMwrLKJpt7IUB4kXw+wmlMpwlfg3ICsVmPZtezz6Trczzpw4=
=KXoX
-----END PGP SIGNATURE-----

--Xm/fll+QQv+hsKip--



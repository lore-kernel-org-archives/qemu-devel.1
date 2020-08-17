Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8F7C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B98C20729
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuAjqYT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B98C20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gCt-0000ar-Te
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7gBZ-0007qI-AJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k7gBX-0005Qd-5N
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597674746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eeEA4oiggDSL8d8B/se01SAYf1Kk1c6RZN4xJ7d+0mU=;
 b=DuAjqYT7TxNzz2t3iPmql/d1wYsfB2gOHIerQMQEDTinxAf0FQ2XhEyktR/wKADihzMeyl
 zDYUOFt9tIXA6hSRElQiwMqO3zU1lu2vFFhkKbuy0xQ4QySqx3WzJW4MHvCA1TArzUBNKQ
 P0tBeVwj1OW3Q0RLJAo+UjUqyH452EY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-KKgn4VW2O8mLOBdpAMYWCw-1; Mon, 17 Aug 2020 10:32:23 -0400
X-MC-Unique: KKgn4VW2O8mLOBdpAMYWCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9013C425CC;
 Mon, 17 Aug 2020 14:32:22 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F7C010013C4;
 Mon, 17 Aug 2020 14:32:21 +0000 (UTC)
Date: Mon, 17 Aug 2020 16:32:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 09/22] nbd: Add writethrough to block-export-add
Message-ID: <20200817143219.GN11402@linux.fritz.box>
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-10-kwolf@redhat.com>
 <faa916e7-3c39-84f4-183f-808153abe12d@redhat.com>
 <20200817131359.GL11402@linux.fritz.box>
 <6c07d929-d7f0-50d8-88b1-b9fa89209c7d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6c07d929-d7f0-50d8-88b1-b9fa89209c7d@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 17.08.2020 um 15:51 hat Max Reitz geschrieben:
> On 17.08.20 15:13, Kevin Wolf wrote:
> > Am 17.08.2020 um 14:56 hat Max Reitz geschrieben:
> >> On 13.08.20 18:29, Kevin Wolf wrote:
> >>> qemu-nbd allows use of writethrough cache modes, which mean that writ=
e
> >>> requests made through NBD will cause a flush before they complete.
> >>> Expose the same functionality in block-export-add.
> >>>
> >>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >>> ---
> >>>  qapi/block-export.json | 7 ++++++-
> >>>  blockdev-nbd.c         | 2 +-
> >>>  2 files changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/qapi/block-export.json b/qapi/block-export.json
> >>> index 1fdc55c53a..4ce163411f 100644
> >>> --- a/qapi/block-export.json
> >>> +++ b/qapi/block-export.json
> >>> @@ -167,10 +167,15 @@
> >>>  # Describes a block export, i.e. how single node should be exported =
on an
> >>>  # external interface.
> >>>  #
> >>> +# @writethrough: If true, caches are flushed after every write reque=
st to the
> >>> +#                export before completion is signalled. (since: 5.2;
> >>> +#                default: false)
> >>> +#
> >>>  # Since: 4.2
> >>>  ##
> >>>  { 'union': 'BlockExportOptions',
> >>> -  'base': { 'type': 'BlockExportType' },
> >>> +  'base': { 'type': 'BlockExportType',
> >>> +            '*writethrough': 'bool' },
> >>>    'discriminator': 'type',
> >>>    'data': {
> >>>        'nbd': 'BlockExportOptionsNbd'
> >>
> >> Hm.  I find it weird to have @writethrough in the base but @device in
> >> the specialized class.
> >>
> >> I think everything that will be common to all block exports should be =
in
> >> the base, and that probably includes a node-name.  I=E2=80=99m aware t=
hat will
> >> make things more tedious in the code, but perhaps it would be a nicer
> >> interface in the end.  Or is the real problem that that would create
> >> problems in the storage daemon=E2=80=99s command line interface, becau=
se then
> >> the specialized (legacy) NBD interface would no longer be compatible
> >> with the new generalized block export interface?
> >=20
> > Indeed. I think patch 15 has what you're looking for.
>=20
> Great. :)
>=20
> Discussions where both participants have the same opinion from the
> start are the best ones.

Makes things a lot easier.

Maybe I should try to move patch 15 earlier. The series is mostly just
in the order that I wrote things, but there were also a few nasty
dependencies in the part the generalises things from NBD to BlockExport.
So I'm not sure if this is a patch that can be moved.

> >> Anyway, @writable might be a similar story.  A @read-only may make sen=
se
> >> in general, I think.
> >=20
> > Pulling @writable up is easier than a @read-only, but that's a naming
> > detail.
>=20
> Sure.
>=20
> > In general I agree, but this part isn't addressed in this series yet.
> > Part of the reason why this is an RFC was to find out if I should
> > include things like this or if we'll do it when we add another export
> > type or common functionality that needs the same option.
>=20
> Sure, sure.

So should I or not? :-)

> Meta: I personally don=E2=80=99t like RFC patches very much.  RFC to me m=
eans
> everything is fair game, and reviewers should be free to let their
> thoughts wander and come up with perhaps wild ideas, just trying to
> gauge what everyone thinks.
>=20
> When I=E2=80=99m the submitter, I tend to get defensive then, because I=
=E2=80=99ve
> invested time in writing the code already, so I tend to be biased
> against fundamental changes.  (Horrible personal trait.  I=E2=80=99m work=
ing
> on it.)

This makes sense. Nobody likes having to rewrite their RFC series.

But there is one thing I dread even more: Polishing the RFC series for
another week until I can send it out as non-RFC and _then_ having to
rewrite it.

> As a reviewer, the code and thus some fleshed out design is there
> already, so it=E2=80=99s difficult to break free from that and find compl=
etely
> different solutions to the original problem.
> (I kind of ventured in that direction for this patch, and it seems like
> you immediately noticed that my response was different from usual and
> pointed out the RFC status, perhaps to make me feel more comfortable in
> questioning the fundamental design more.  Which I noticed, hence this
> wall of text.)

Basically just telling you that I was already interested in your input
for this point specifically when I sent the series.

> Perhaps I=E2=80=99m wrong.  Perhaps it=E2=80=99s just myself (the points =
I=E2=80=99ve just
> listed are definitely my own personal weaknesses), but I can=E2=80=99t he=
lp but
> project and assume that others may feel similar, at least in part.
> So I feel like RFCs that consist of patches tend to at least lock me in
> to the solution that=E2=80=99s present.  I find them difficult to handle,=
 both
> as a submitter and as a reviewer.
>=20
> All in all, that means on either side I tend to handle patch RFCs as
> =E2=80=9CStandard series, just tests missing=E2=80=9D.  Not sure if that=
=E2=80=99s ideal.  Or
> maybe that=E2=80=99s exactly what patch RFCs are?
>=20
> (Of course, it can and should be argued that even for standard series, I
> shouldn=E2=80=99t be afraid of questioning the fundamental design still. =
 But
> that=E2=80=99s hard...)

I usually send RFC patches when I know that I wouldn't consider them
mergable yet, but I don't want to invest the time to polish them before
I know that other people agree with the approach and the time won't be
wasted.

> But, well.  The alternative is writing pure design RFCs, and then you
> tend to get weeks of slow discussion, drawing everything out.  Which
> isn=E2=80=99t ideal either.  Or is that just a baseless prejudice I have?

In many cases (and I think this is one of them in large parts), I only
really learn what the series will look like when I write it.

I could have sent a design RFC for the QAPI part, but I didn't expect
this to be contentious because it's just the normal add/del/query thing
that exists for pretty much everything else, too.

> >> Basically, I think that the export code should be separate from the co=
de
> >> setting up the BlockBackend that should be exported, so all options
> >> regarding that BB should be common; and those options are @node-name,
> >> @writethrough, and @read-only.  (And perhaps other things like
> >> @resizable, too, even though that isn=E2=80=99t something to consider =
for NBD.)
> >=20
> > Do you mean that the BlockBackend should already be created by the
> > generic block export layer?
>=20
> It would certainly be nice, if it were feasible, don=E2=80=99t you think?
>=20
> We don=E2=80=99t have to bend backwards for it, but maybe it would force =
us to
> bring the natural separation of block device and export parameters to
> the interface.

I can try. I seem to remember that you had a reason not to do this the
last time we discussed generalised exports, but I'm not sure what it
was.

The obvious one could be that the block export layer doesn't know which
permissions are needed. But it can always start with minimal permissions
and let the driver do a blk_set_perm() if it needs more.

Kevin

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl86lPMACgkQfwmycsiP
L9Yltg/8Da67/mbn3GARxPTdXkKBjFW6hkvDAYz3fkcWrR8EQCb7MRdFjsMTIxrT
LafcIju+iBE2txyyTi4uepbA8Qe8E94M5jw+1eiQu8uF7ggyChM2BAyBBXnCjEiP
Cg85nBL435lyJD2xfckT3Zjiy0MdxMbmBt9avCSuPNAVDL/TRUBR2maL6rOctbgP
rITqsKT/KYMIq6dLbWf0LFJziDst0czGFQphJOpKUFnVw9bd5ZBT/6N2rh0GjiX3
7hS05ift1db1mMD5qbv7LLPSr1IM5f2Ded6EywqYgHRIGHkLN4sXRl/1VCVPqhJS
auqf5GwpiiIdzVzzSNEwA+la9ObAkULrd2RPd7N9rvOqVVYpFT7i6khw368WMODJ
T4Oc0x7zWnOHzMiT/ObigoKwyJzMx8XKZGC+IcqFdMMqjs0eXo8+FLO+AecIp9Vg
gVTPgLBHqYTBotWVk2wpSVBk0+jxKzbwMOAEDYUjMAcGijvnl952rHGtjfo50LBX
nDAAbNiJIot19ZxySnuGi38A77/Y3/6FEayFjeIcL07e6nCBgiBQ8bF7cQ00vNPi
1AuOVTggkbJjKFdTPi/wbTJAl5wTYoxiq10RRpvQ6aYUn8wHOsx9gUewGutTvJaa
acaPwOn9I9z7Al86W16JmJjKqKMIU1nNIdoTBlRkiX7zKGN31Cs=
=WSHW
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--



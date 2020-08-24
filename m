Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B40C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14853206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrDi0/Fs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14853206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAE3y-0003PE-CA
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kAE3G-0002sk-LS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:06:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42398
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kAE3C-0000sR-1Q
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598281580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JZscWOX42XWmYs/HCKoyfN51BVb+d58pkACQ/FKiF7A=;
 b=UrDi0/FsjjMMWstugEGvTyAGYyWfeQ1QXZHyi0bh1vKwYAYs9poBYHD8J4zF/nZP889Dv8
 qUX/wejbNRWoXrYXLAQxi3CpeRBBLpMEUJYTNeBHYPHO1wuTFk0g1FJdrl7kkm+0xEywqN
 mz9B25plTUOorGB6GbvbgannyX46/K0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-ObA01XLCMYi0_6-DwQfh2A-1; Mon, 24 Aug 2020 11:06:18 -0400
X-MC-Unique: ObA01XLCMYi0_6-DwQfh2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F82C81CBF1;
 Mon, 24 Aug 2020 15:06:17 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-60.ams2.redhat.com [10.36.114.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24AE060BF1;
 Mon, 24 Aug 2020 15:06:15 +0000 (UTC)
Date: Mon, 24 Aug 2020 17:06:14 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v7 39/47] blockdev: Fix active commit choice
Message-ID: <20200824150614.GC10708@linux.fritz.box>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-40-mreitz@redhat.com>
 <20200821155011.GA26691@linux.fritz.box>
 <74e6ed51-d610-0982-d265-c8168b5f958c@redhat.com>
 <20200824140739.GB10708@linux.fritz.box>
 <7a02c449-2bef-08d4-bd3f-41eac0276424@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7a02c449-2bef-08d4-bd3f-41eac0276424@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 05:21:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.08.2020 um 16:41 hat Max Reitz geschrieben:
> On 24.08.20 16:07, Kevin Wolf wrote:
> > Am 24.08.2020 um 15:18 hat Max Reitz geschrieben:
> >> On 21.08.20 17:50, Kevin Wolf wrote:
> >>> Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
> >>>> We have to perform an active commit whenever the top node has a pare=
nt
> >>>> that has taken the WRITE permission on it.
> >>>>
> >>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >>>> ---
> >>>>  blockdev.c | 24 +++++++++++++++++++++---
> >>>>  1 file changed, 21 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/blockdev.c b/blockdev.c
> >>>> index 402f1d1df1..237fffbe53 100644
> >>>> --- a/blockdev.c
> >>>> +++ b/blockdev.c
> >>>> @@ -2589,6 +2589,7 @@ void qmp_block_commit(bool has_job_id, const c=
har *job_id, const char *device,
> >>>>      AioContext *aio_context;
> >>>>      Error *local_err =3D NULL;
> >>>>      int job_flags =3D JOB_DEFAULT;
> >>>> +    uint64_t top_perm, top_shared;
> >>>> =20
> >>>>      if (!has_speed) {
> >>>>          speed =3D 0;
> >>>> @@ -2704,14 +2705,31 @@ void qmp_block_commit(bool has_job_id, const=
 char *job_id, const char *device,
> >>>>          goto out;
> >>>>      }
> >>>> =20
> >>>> -    if (top_bs =3D=3D bs) {
> >>>> +    /*
> >>>> +     * Active commit is required if and only if someone has taken a
> >>>> +     * WRITE permission on the top node.
> >>>
> >>> ...or if someone wants to take a WRITE permission while the job is
> >>> running.
> >>>
> >>> Future intentions of the user is something that we can't know, so may=
be
> >>> this should become an option in the future (not in this series, of
> >>> course).
> >>>
> >>>>                                            Historically, we have alw=
ays
> >>>> +     * used active commit for top nodes, so continue that practice.
> >>>> +     * (Active commit is never really wrong.)
> >>>> +     */
> >>>
> >>> Changing the practice would break compatibility with clients that sta=
rt
> >>> an active commit job and then attach it to a read-write device, so we
> >>> must continue the practice. I think the comment should be clearer abo=
ut
> >>> this, it sounds more like "no reason, but why not".
> >>
> >> I think that=E2=80=99s what I meant by =E2=80=9Chistorically=E2=80=9D.=
  Is =E2=80=9Clegacily=E2=80=9D a word?
> >>
> >> But sure, I can make it more explicit.
> >>
> >>> This is even more problematic because the commit job doesn't unshare
> >>> BLK_PERM_WRITE yet, so it would lead to silent corruption rather than=
 an
> >>> error.
> >>>
> >>>> +    bdrv_get_cumulative_perm(top_bs, &top_perm, &top_shared);
> >>>> +    if (top_perm & BLK_PERM_WRITE ||
> >>>> +        bdrv_skip_filters(top_bs) =3D=3D bdrv_skip_filters(bs))
> >>>> +    {
> >>>>          if (has_backing_file) {
> >>>>              error_setg(errp, "'backing-file' specified,"
> >>>>                               " but 'top' is the active layer");
> >>>
> >>> Hm, this error message isn't accurate any more.
> >>>
> >>> In fact, the implementation isn't consistent with the QAPI documentat=
ion
> >>> any more, because backing-file is only an error for the top level.
> >>
> >> Hm.  I wanted to agree, and then I wanted to come up with a QAPI
> >> documentation that fits the new behavior (because I think it makes mor=
e
> >> sense to change the QAPI documentation along with the behavior change,
> >> rather than to force us to allow backing-file for anything that isn=E2=
=80=99t on
> >> the top layer).
> >>
> >> But in the process of coming up with a better description, I noticed
> >> that this doesn=E2=80=99t say =E2=80=9Cis a root node=E2=80=9D, it say=
s =E2=80=9Cis the active layer=E2=80=9D.
> >> I would say a node in the active layer is a node that has some parent
> >> that has taken a WRITE permission on it.  So actually I think that the
> >> documentation is right, and this code only now fits.
> >=20
> > Then you may have not only "the" active layer, but multiple active
> > layers. I find this a bit counterintuitive.
>=20
> Depends on what you count as a layer.  I don=E2=80=99t think that=E2=80=
=99s a clearly
> defined term, is it?  I only know of =E2=80=9Cactive layer=E2=80=9D, =E2=
=80=9Cformat layer=E2=80=9D,
> =E2=80=9Cprotocol layer=E2=80=9D, and you can at least have multiple form=
at layers above
> each other.  So I don=E2=80=99t find it counterintuitive.
>=20
> But perhaps it=E2=80=99d be best to just get away from the term =E2=80=9C=
active layer=E2=80=9D,
> as you propose below.

Hm, if I needed to describe what a layer is for me intuitively, I guess
it would be something like each non-filter node on a node chain with all
of the filters directly on top of it?

Depending on which link you follow, you get different sets of layers:
For bs->file, you get the format/protocol layer distinction. For
bs->backing, you get essentially what bdrv_backing_chain_next()
iterates.

In this context (which is talking about COW overlays), I expected the
bs->backing link to apply.

The active layer is then the COW layer that is directly referenced by a
guest device, block job or block export.

> > There is a simple reason why backing-file is an error for a root node:
> > It doesn't have overlays, so a value to write to the header of overlay
> > images just doesn't make sense.
>=20
> Ah, yeah...
>=20
> > The same reasoning doesn't apply for writable images that do have
> > overlays. Forbidding backing-file is a more arbitrary restriction there=
.
> > I'm not saying that we can't make arbitrary restrictions where allowing
> > an option is not worth the effort, but I feel they should be spelt out
> > more explicitly instead of twisting words like "active layer" until the=
y
> > fit the code.
>=20
> I=E2=80=99m all for spelling it out more explicitly.  I just noticed that=
 I
> couldn=E2=80=99t clearly distinguish =E2=80=9Cactive layer=E2=80=9D from =
=E2=80=9Cother=E2=80=9D cases of nodes
> with writers on them, which is why I noted that =E2=80=9Cactive=E2=80=9D =
to me means the
> post-patch behavior already.
>=20
> You=E2=80=99re right that there is no semantic reason for making it an er=
ror.
> So I just want it to be an error to be lazy.  I hope you let me do that.
>  (I don=E2=80=99t think there=E2=80=99s much of a problem with it, consid=
ering that
> commits on nodes that have the WRITE permission taken are basically just
> completely broken right now.)

That I'm happy to allow you to be lazy in this case is what I wanted to
express with "I'm not saying that we can't make arbitrary restrictions".
:-)

> >> Though I do think this wants for some clarification.  Perhaps =E2=80=
=9CIf 'top'
> >> is the active layer (i.e., is a node that may be written to), specifyi=
ng
> >> a backing [...]=E2=80=9D?
> >=20
> > "If 'top' doesn't have an overlay image or is in use by a writer..."?
>=20
> I.e., avoiding the term =E2=80=9Cactive layer=E2=80=9D altogether?  Sound=
s good.  Only,
> I don=E2=80=99t know about =E2=80=9Cwriter=E2=80=9D...  But it=E2=80=99s =
already used in
> BlockdevOptionsFile.dynamic-auto-read-only=E2=80=99s description, so I su=
ppose
> we can use it here, too.  (I just don=E2=80=99t know if as a
> non-block-layer-developer I=E2=80=99d know what it means.)

I was thinking of something like "is used read-write" at first, but then
realised that write-only is possible, too, so it wouldn't be entirely
accurate...

> (Also, yes, you=E2=80=99re right, the current behavior of giving all root=
 nodes
> an active commit of course remains, even when there are no writers.)
>=20
> >> There=E2=80=99s more wrong with the specification, namely the whole pa=
rt under
> >> @backing-file past the =E2=80=9C(Since 2.1)=E2=80=9D, starting with =
=E2=80=9CIf top =3D=3D base=E2=80=9D.  I
> >> think all of that should go to the top level.  (And =E2=80=9CIf top =
=3D=3D active=E2=80=9D
> >> should be changed to =E2=80=9CIf top is active (i.e., may be written t=
o)=E2=80=9D.)
> >=20
> > At least the latter only becomes wrong with this patch, so I think it
> > needs to be changed by this patch.
>=20
> Sure.  So I understand you agree with moving the whole chunk, right?

I don't mind either way.

Kevin

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl9D12YACgkQfwmycsiP
L9bZmQ//avKebQnpRCRI39HsjFJysCsQxbPp/s7enHWwke+RNevcsCnFv02vKrhj
xrb8TWMRgbuReOPp0ezv7hCTFOgnV1ogyx+IuiUpXyQYbtV4xnmust+yrw1yXZ4M
NSm7v0o1446GBp3SDHeRJQYkP0SIM46Fn7zC8uDqs9sYBRSTQCzYemrKmvyHg8/g
oh6SNKe0r6oLHQalrfi0SKP4XpDbqDuIVWd1ggAMpjQ5FAJKM5Aatf0XJG2nsSLO
1pCSxHRX7dneYErAlh6GVekaDSpM/m02y2pbNBH2D2jB+pyq1XOGSUaMJB0zi0n9
mKTY3/Hb2fseMwpwHlfkaO8Qgpug9WFUOTYekmzDrPk3aDXEHmf2JA30VIvaJdPI
oGqm3TQPuQj725kTWJHivRys5yNy6VSSCRuzfwdLbu60KCJbRsnS/allfXVvRBZW
0V6JqoJRutwlyVaaLlUYM5UJTRYaygAjZ/Ieg+m2x49KmZNi6CmbUonNaUIEbHnB
mS53FgW+0ZT8A3heDU8ocw+aGwe8s1ttHgk5H/OaFi8o0LEhYGWfNG3KUB7tLjur
dEQJw2JE6xcBcSOn5G70w5UvtMbswQhR2xi9O/LuqtYKconnNdqrleNsW0eUz1G1
kY9OssXu/aGGNtyjZTh9/tg5KTRt2vE6dph9Qp91v+L+HR+MEEY=
=qCSy
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--



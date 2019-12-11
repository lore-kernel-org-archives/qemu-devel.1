Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1784DC00454
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C64D5206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nr52GUgt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64D5206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4yF-0000M2-L7
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1if4xT-0008Et-IF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:35:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1if4xR-00088C-Gm
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:35:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34239
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1if4xR-00085Q-1m
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:35:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576082124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ne2vgVO5BOA8f5J2/n+4tl/uxvAFgSUHQ9c99l91QKc=;
 b=Nr52GUgtq05R0rqkwBiljzAD6x3qq8w+o2um3E4tuuDXJkCibkaIH9XpAt32rSwVyTIHUQ
 3jkvC56+bId7CODfqTZFshdKIDhkHpiqxvuSEcsyeodjSk8eUw2aS2LdKj+aRYyv5kr5uo
 tPTTkJrf5ccX1HCmd5dDv7Tc+vOhVt0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-yau7ahB_Msunx31_LawqtQ-1; Wed, 11 Dec 2019 11:35:21 -0500
X-MC-Unique: yau7ahB_Msunx31_LawqtQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECBAC19239FC;
 Wed, 11 Dec 2019 16:35:19 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9773D76FE3;
 Wed, 11 Dec 2019 16:35:18 +0000 (UTC)
Date: Wed, 11 Dec 2019 17:35:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v6 28/42] stream: Deal with filters
Message-ID: <20191211163517.GD6505@linux.fritz.box>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-29-mreitz@redhat.com>
 <20190913141653.GH8312@dhcp-200-226.str.redhat.com>
 <0da03f2f-e7ca-1aad-f156-bbd8a0e9dbc7@redhat.com>
 <1b849809-ac7e-091b-4987-b3ee9383cb15@redhat.com>
 <20191211155224.GC6505@linux.fritz.box>
 <38b4e4bf-9553-e231-98f5-91dcb6994462@redhat.com>
MIME-Version: 1.0
In-Reply-To: <38b4e4bf-9553-e231-98f5-91dcb6994462@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.12.2019 um 17:12 hat Max Reitz geschrieben:
> On 11.12.19 16:52, Kevin Wolf wrote:
> > Am 11.12.2019 um 13:52 hat Max Reitz geschrieben:
> >> On 16.09.19 11:52, Max Reitz wrote:
> >>> On 13.09.19 16:16, Kevin Wolf wrote:
> >>>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> >>>>> Because of the recent changes that make the stream job independent =
of
> >>>>> the base node and instead track the node above it, we have to split=
 that
> >>>>> "bottom" node into two cases: The bottom COW node, and the node dir=
ectly
> >>>>> above the base node (which may be an R/W filter or the bottom COW n=
ode).
> >>>>>
> >>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>>> ---
> >>>>>  qapi/block-core.json |  4 ++++
> >>>>>  block/stream.c       | 52 ++++++++++++++++++++++++++++------------=
----
> >>>>>  blockdev.c           |  2 +-
> >>>>>  3 files changed, 38 insertions(+), 20 deletions(-)
> >>
> >>
> >> [...]
> >>
> >>>>> +    if (bdrv_freeze_chain(bs, above_base, errp) < 0) {
> >>>>>          return;
> >>>>>      }
> >>>>
> >>>> Hm... This feels odd. There are two places where stopping to freeze =
the
> >>>> chain would make obvious sense: At base, like we originally did; or =
at
> >>>> base_overlay, like we (intend to) do since commit c624b015, because =
we
> >>>> say that we don't actually mind if the user replaces the base image.=
 I
> >>>> don't see how stopping at the first filter above base makes sense.
> >>>>
> >>>> So should this use bottom_cow_node/base_overlay instead of above_bas=
e?
> >>>
> >>> I suppose I thought =E2=80=9CBetter be safe than sorry=E2=80=9D.
> >>>
> >>>> You couldn't use StreamBlockJob.above_base any more then because it
> >>>> could change, but you also don't really need it anywhere. It's only =
used
> >>>> for unfreezing (which would change) and for finding the base (you ca=
n
> >>>> still find bdrv_backing_chain_next(s->base_overlay)). I guess this w=
ould
> >>>> even be a code simplification.
> >>>
> >>> Great, I=E2=80=99ll see to it.
> >>
> >> On second thought (yes, I know, it=E2=80=99s been a couple of months..=
.) I=E2=80=99m not
> >> so sure.
> >>
> >> If @base is a filter, then bdrv_backing_chain_next(s->base_overlay) wi=
ll
> >> not return it.  So then the filter will be dropped, but that probably
> >> isn=E2=80=99t what the user intended.
> >>
> >> (In fact, the block-stream doc says =E2=80=9CWhen streaming completes =
the image
> >> file will have the base file as its backing file.=E2=80=9D)
> >=20
> > Hm... Okay, let's try an example:
> >=20
> >     ... <- backing <- filter1 <- filter2 <- filter3 <- top
> >                          |         |                    |
> >                       @base    above_base            @device
> >                                                    base_overlay
> >=20
> >=20
> > The expected result after the job has completed is:
> >=20
> >     ... <- backing <- filter1 <- top
> >=20
> > This means that filter1 must not go away until the job has completed. I=
n
> > other words, we would need to freeze the link between @base and
> > above_base.
> >=20
> > If we use backing_bs(above_base) as we currently do, we wouldn't
> > necessarily get filter1 as the new backing child of top (as the
> > documentation promises), but whatever is the backing child of filter2
> > when the job completes. In other words, documentation and code don't
> > match currently.
>=20
> Correct.
>=20
> > Let's look at a few more examples to see which of the options makes mor=
e
> > sense:
> >=20
> > 1. Assume we drop filter1 while the stream job is running, i.e. backing
> >    is now the backing child of filter 2. I think it's obvious that when
> >    the stream job completes, you want backing to be the new backing
> >    child of top and not add filter1 back to the chain.
> >=20
> > 2. If we add filter1b between filter1 and filter2, do we want to drop i=
t
> >    when the job completes? It's not entirely clear, but there are
> >    probably cases where keeping it makes sense. The user can always dro=
p
> >    it manually again, but if we delete a node, some requests will go
> >    through unfiltered.
>=20
> Depends.  If the base-node was given to be literally "backing", then I=E2=
=80=99d
> say the user wants us to use "backing" as the new base still.
>=20
> > 3. Imagine we replace filter1 wholesale, for example because a
> >    concurrently running mirror job performs a storage migration for
> >    everything up to filter1. Do we then want to reinstate the whole old
> >    subtree when the stream job completes? Certainly not.
>=20
> I=E2=80=99m not sure.  Again, if I as the user specified the "backing" no=
de-name
> as the base, I=E2=80=99d expect that to be the new backing file in all ca=
ses.
>=20
> > So from this I would probably conclude that the bug is the
> > documentation, not necessarily in the code.
>=20
> It certainly is true that it does not address what happens when you
> meddle with base.

Which is because it wasn't relevant then: You were not allowed to meddle
with base when block-stream documentation was written. It's only a
possible case since commit c624b015.

If we really want to guarantee that it's exactly base that will be used
at the end, then we need to freeze all links down to base, essentially
reverting commit c624b015 and disallowing some operations that would be
possible if we didn't make that promise. I don't think that's the right
thing to do, but at least it would be self-consistent.

Promising base, but not freezing the links, leads to weird results in
some of the cases mentioned above.

> (Except it can be argued (and I suppose I did argue that) that as it is
> it does say the base file should be the backing file after stream, so if
> the base file is still there, I do interpret that to mean that the
> stream job always uses that as the backing node.  Of course even if it
> says that, that doesn=E2=80=99t mean that it makes sense.  And if it does=
n=E2=80=99t
> make sense, then that=E2=80=99s the definition of a bug in the documentat=
ion, yes.)
>=20
> >> So now this gets hairy.  We do want exactly @base as the backing file
> >> unless the user changed the graph.  But how can we detect that and if =
it
> >> hasn=E2=80=99t changed find @base again?
> >>
> >> What this patch did in this version worked because the graph was froze=
n
> >> until @above_base.
> >=20
> > No, it didn't provide the promised semantics, because "unless the user
> > changed the graph" isn't part of the documentation.But the promised
> > semantics are probably not what we want, so it's okay.
>=20
> I would have said that no semantics are promised for when the node is no
> longer a valid base, so we can basically do what we think makes sense.

Like undefined behaviour in C?

Sounds great, let's reboot the guest into some 512-byte demo then.

> >> Alternatively, we could store a pointer to @base directly (or its node
> >> nmae) and then see whether there is some node between s->base_overlay
> >> and bdrv_backing_chain_next(s->base_overlay) that matches that at the
> >> end of streaming.
> >>
> >> Well, actually, a pointer won=E2=80=99t work because of course maybe t=
hat node
> >> was deleted and the area is now used for an unrelated node that the us=
er
> >> doesn=E2=80=99t want as the new backing file.
> >>
> >> The node name could actually work, though.  I mean, if there is some
> >> node in the immediate backing filter chain of base_overlay with that
> >> node name after streaming, it does make sense to assume that the user
> >> wants this to be the backing file; regardless of whether that=E2=80=99=
s exactly
> >> the same node as it was at the start of streaming.
> >>
> >> But we now also have to think about what to do when there is no node
> >> with such a node name.  Should we keep all filters below base_overlay?
> >> Or should we drop all of them?  I actually think keeping them is the
> >> safer choice...
> >=20
> > Using node names feels completely wrong to me. If we can't keep a
> > pointer (with a reference) because we want the user to be able to
> > delete the node, then we certainly can't keep the node name either
> > because that could refer to an entirely different node when the job
> > completes.
>=20
> I was thinking that if the user does graph manipulation, we can expect
> them to have given base-node.  So they actually did refer to a node name
> and it makes sense to me to keep looking it up.
>=20
> (As a side note: I originally intended to say =E2=80=9Cstoring a pointer =
or the
> node-name are the only things that come to mind, but obviously both are
> stupid=E2=80=9D =E2=80=93 but then I changed my mind and realized that th=
e node name
> maybe actually isn=E2=80=99t that stupid.)

I think it is. A node name refers to the node with that name at the
time of the QMP command. What node was referenced in that command
doesn't change later because of graph manipulations.

> > I don't think it's useful to waste too much thought on how to implement
> > the behaviour required by the documentation. The requirement seems to b=
e
> > just wrong.
> >=20
> > So in the end, maybe your current code is fine, and the way to address
> > the "doesn't make obvious sense" part is having a comment that explains
> > why above_base is where we stop freezing.
>=20
> Let=E2=80=99s maybe talk about it tomorrow. :-)

Okay, added to my preliminary agenda.

Kevin

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd8RrFAAoJEH8JsnLIjy/WLbsQAIGUmLGk0t2k3Hyf6IA+FYG9
WkQElLCtpc8STr5nKUWGLKk7OAsj5jK84XMvoyHPT1pI8FhFi7GLnt4zTqzaZiyT
trnkWoXrDPUbs3jWEA127x539CjbNdb8C0hg9GrtvszT3fvRUI+nk3tJWoDhMvZH
F80arqCn2R+OuiLbJ7Sk+aOn9glG9mqg4J/G7WCOhaAZvXOQXpB6gA0x6ApuZnZ5
te6agbtxyF5ygRLx27Adk37pCUeIEQh3nxqhZ8HUrHGYq6HSScwETJM293FmTY82
aMV/CuAonBWxBobTMZ4G7uouG1yvbBox2r6VejmmXyPU6JqlHb9D6cUT6ovlRGBe
GkyhfkN8IBkDE4It7+EMGTQYAxVnjZzKmLLG+dgfn0T9j6jZp8w9xxfHQkvItyHS
TcjHlAyvg++pmmZjK6EJpzLBuytTWjvRI4X85t/0A2PDJZ6SCVFEfUAwqFeEYQAQ
HF5aqoaB8TiQo+avB4a3QaTg3m3VyKtVsK9N/iRfAzPPmh8kQ443WUdklyDHSxPK
fDEy0fjC95Ke1xOP8BKpi3AK7TfRoHmN8Spzg9s1e9YbULNnKjBACUgKv+8PkCKn
hnZhKuybV1Jji1n4HDIAC0G3OnB1m5Zrd/Yhc2IFhRllPs6P6DX9sPWHW92sQE7+
NsZvoJQye4CvfRJlLAtP
=lPOU
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--



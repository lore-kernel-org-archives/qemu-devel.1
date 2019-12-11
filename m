Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B895C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:53:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7162077B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="edr+zcU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7162077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4JA-0003YC-EU
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1if4I0-00031F-4S
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1if4Hw-0004Iw-MS
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:52:34 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28748
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1if4Hw-0004HL-Hu
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576079551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8MtVBgifigm7ZJZzdf1jF6cj5bmcTW1VXTYRRVaEATU=;
 b=edr+zcU3JAk1qMt5R51LxS+vxKO4cf0ApPoi0dvbbNrZ23s4pJkXLvtZw5KVL52iiPADG1
 E0bpq8mcgsU2D+dKkqT9AqXfm8nC6gQc+q3g8L6wqkOrw/3jZM3Hr0pYJNM0jNq6z5muqz
 Qdgw8Js+nJP3JHnfY0Se+UyqmSwaH+s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-79FrrwnlOIS9xNcjjac5yw-1; Wed, 11 Dec 2019 10:52:28 -0500
X-MC-Unique: 79FrrwnlOIS9xNcjjac5yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AC511800D45;
 Wed, 11 Dec 2019 15:52:27 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92EDD4647F;
 Wed, 11 Dec 2019 15:52:25 +0000 (UTC)
Date: Wed, 11 Dec 2019 16:52:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v6 28/42] stream: Deal with filters
Message-ID: <20191211155224.GC6505@linux.fritz.box>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-29-mreitz@redhat.com>
 <20190913141653.GH8312@dhcp-200-226.str.redhat.com>
 <0da03f2f-e7ca-1aad-f156-bbd8a0e9dbc7@redhat.com>
 <1b849809-ac7e-091b-4987-b3ee9383cb15@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1b849809-ac7e-091b-4987-b3ee9383cb15@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 11.12.2019 um 13:52 hat Max Reitz geschrieben:
> On 16.09.19 11:52, Max Reitz wrote:
> > On 13.09.19 16:16, Kevin Wolf wrote:
> >> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
> >>> Because of the recent changes that make the stream job independent of
> >>> the base node and instead track the node above it, we have to split t=
hat
> >>> "bottom" node into two cases: The bottom COW node, and the node direc=
tly
> >>> above the base node (which may be an R/W filter or the bottom COW nod=
e).
> >>>
> >>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>> ---
> >>>  qapi/block-core.json |  4 ++++
> >>>  block/stream.c       | 52 ++++++++++++++++++++++++++++--------------=
--
> >>>  blockdev.c           |  2 +-
> >>>  3 files changed, 38 insertions(+), 20 deletions(-)
>=20
>=20
> [...]
>=20
> >>> +    if (bdrv_freeze_chain(bs, above_base, errp) < 0) {
> >>>          return;
> >>>      }
> >>
> >> Hm... This feels odd. There are two places where stopping to freeze th=
e
> >> chain would make obvious sense: At base, like we originally did; or at
> >> base_overlay, like we (intend to) do since commit c624b015, because we
> >> say that we don't actually mind if the user replaces the base image. I
> >> don't see how stopping at the first filter above base makes sense.
> >>
> >> So should this use bottom_cow_node/base_overlay instead of above_base?
> >=20
> > I suppose I thought =E2=80=9CBetter be safe than sorry=E2=80=9D.
> >=20
> >> You couldn't use StreamBlockJob.above_base any more then because it
> >> could change, but you also don't really need it anywhere. It's only us=
ed
> >> for unfreezing (which would change) and for finding the base (you can
> >> still find bdrv_backing_chain_next(s->base_overlay)). I guess this wou=
ld
> >> even be a code simplification.
> >=20
> > Great, I=E2=80=99ll see to it.
>=20
> On second thought (yes, I know, it=E2=80=99s been a couple of months...) =
I=E2=80=99m not
> so sure.
>=20
> If @base is a filter, then bdrv_backing_chain_next(s->base_overlay) will
> not return it.  So then the filter will be dropped, but that probably
> isn=E2=80=99t what the user intended.
>=20
> (In fact, the block-stream doc says =E2=80=9CWhen streaming completes the=
 image
> file will have the base file as its backing file.=E2=80=9D)

Hm... Okay, let's try an example:

    ... <- backing <- filter1 <- filter2 <- filter3 <- top
                         |         |                    |
                      @base    above_base            @device
                                                   base_overlay


The expected result after the job has completed is:

    ... <- backing <- filter1 <- top

This means that filter1 must not go away until the job has completed. In
other words, we would need to freeze the link between @base and
above_base.

If we use backing_bs(above_base) as we currently do, we wouldn't
necessarily get filter1 as the new backing child of top (as the
documentation promises), but whatever is the backing child of filter2
when the job completes. In other words, documentation and code don't
match currently.

Let's look at a few more examples to see which of the options makes more
sense:

1. Assume we drop filter1 while the stream job is running, i.e. backing
   is now the backing child of filter 2. I think it's obvious that when
   the stream job completes, you want backing to be the new backing
   child of top and not add filter1 back to the chain.

2. If we add filter1b between filter1 and filter2, do we want to drop it
   when the job completes? It's not entirely clear, but there are
   probably cases where keeping it makes sense. The user can always drop
   it manually again, but if we delete a node, some requests will go
   through unfiltered.

3. Imagine we replace filter1 wholesale, for example because a
   concurrently running mirror job performs a storage migration for
   everything up to filter1. Do we then want to reinstate the whole old
   subtree when the stream job completes? Certainly not.

So from this I would probably conclude that the bug is the
documentation, not necessarily in the code.

> So now this gets hairy.  We do want exactly @base as the backing file
> unless the user changed the graph.  But how can we detect that and if it
> hasn=E2=80=99t changed find @base again?
>=20
> What this patch did in this version worked because the graph was frozen
> until @above_base.

No, it didn't provide the promised semantics, because "unless the user
changed the graph" isn't part of the documentation. But the promised
semantics are probably not what we want, so it's okay.

> Alternatively, we could store a pointer to @base directly (or its node
> nmae) and then see whether there is some node between s->base_overlay
> and bdrv_backing_chain_next(s->base_overlay) that matches that at the
> end of streaming.
>=20
> Well, actually, a pointer won=E2=80=99t work because of course maybe that=
 node
> was deleted and the area is now used for an unrelated node that the user
> doesn=E2=80=99t want as the new backing file.
>=20
> The node name could actually work, though.  I mean, if there is some
> node in the immediate backing filter chain of base_overlay with that
> node name after streaming, it does make sense to assume that the user
> wants this to be the backing file; regardless of whether that=E2=80=99s e=
xactly
> the same node as it was at the start of streaming.
>=20
> But we now also have to think about what to do when there is no node
> with such a node name.  Should we keep all filters below base_overlay?
> Or should we drop all of them?  I actually think keeping them is the
> safer choice...

Using node names feels completely wrong to me. If we can't keep a
pointer (with a reference) because we want the user to be able to
delete the node, then we certainly can't keep the node name either
because that could refer to an entirely different node when the job
completes.

I don't think it's useful to waste too much thought on how to implement
the behaviour required by the documentation. The requirement seems to be
just wrong.

So in the end, maybe your current code is fine, and the way to address
the "doesn't make obvious sense" part is having a comment that explains
why above_base is where we stop freezing.

Kevin

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJd8RC4AAoJEH8JsnLIjy/WM9MQAIsxeHk6UOS7+xLlRAd9ezXS
aTtrrsdRAMg8/fWLN3kxr+6exPR94RX7Tyq5y/u/hS0c+LqzW03Ar1hI0SAgiVez
aIT6Pmgr/fy8QRams47KXId00eTzq/BEoiOIrYA3GlI6ZgC4IpCIEU3EREyYt10/
n7fhSNqD7sswTnBhvcsDUzaMbghSwBW5TrYSy3qI00PP7IRNkLXMnKEYinDTr3cG
RXVLSawyHUaiVi23eIQLA5WvMHbl810SQUx5r2LflrMm1T76CsHVDSRksSl7EGiZ
14BTzUURujvF8imCk37qDvX1l1iMei8Qbh9uhSH8HAWOeM4xH781ZH+6C3gIh7Do
Vl78uzFxLA762shqPSMK2xMas+TJf389KTExEdzzHRAt4dC8+YeC1HajTShHEX0M
I1KkBh2SPNAODcbjE2UJh41gGjU25Y+uppqSXBrIxIh4NdEK6nAeM+1w4bjnOmOK
cEzsRNH9PT+Ubr32gzB5BcICvcrrDPwGxHSZQWm/sCjvYio054TAc+RVRl3Jp1kw
ojwb604bur3Tvpm6C/dZ7vmqyOndMXOUwMmtmLogldOZyjM5gQPGo8FyH6/Hci1t
OZUlThoSEDlJAU/Dcl3hdxk8OWPAMKIMJOcqIudWrglOtZg80ecApZrrwrIPgTL8
6dReYx6BDiJrj0TrxXHl
=POwy
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--



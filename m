Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6AFC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AFBB20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9v9x4p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFBB20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkTe-0006ON-9W
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izkSi-0005c9-FV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izkSg-0005sb-V7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:57:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48134
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izkSg-0005qJ-Ps
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:57:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581008226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ENAZep4jiyNr9zjd92cszHbGNmUm/LXVRvmS16vYaw=;
 b=f9v9x4p24KeTvvm/ksRIxhHb3I8/NCr/+zOnipLLdITEelPfISikZC9e0khN3X5h+8/FM+
 Bs+TOgPZATsnRJO8LsoRqwdEwSrtmHQxTBbBeclZLc3PLs5HW3vhwqfXoAMCEjDkzXpOMb
 Qr+cPxEFdTyYYy2QNNc0NKcdOcM2Ob8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-h2t021sVPTSIB5Abl1bMPA-1; Thu, 06 Feb 2020 11:57:04 -0500
X-MC-Unique: h2t021sVPTSIB5Abl1bMPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71824800D54;
 Thu,  6 Feb 2020 16:57:03 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-204.ams2.redhat.com [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EE2960BEC;
 Thu,  6 Feb 2020 16:57:02 +0000 (UTC)
Date: Thu, 6 Feb 2020 17:57:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
Message-ID: <20200206165700.GH4926@linux.fritz.box>
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
 <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
 <92b951da-5e12-e08f-f8f7-a862790b51ac@redhat.com>
 <20200206145825.GD4926@linux.fritz.box>
 <9d767091-4590-9fce-c596-bda5865aa190@redhat.com>
 <20200206155110.GG4926@linux.fritz.box>
 <78bd2830-9b10-9d66-afe1-783226b8edc5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <78bd2830-9b10-9d66-afe1-783226b8edc5@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
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

--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.02.2020 um 17:43 hat Max Reitz geschrieben:
> On 06.02.20 16:51, Kevin Wolf wrote:
> > Am 06.02.2020 um 16:21 hat Max Reitz geschrieben:
> >> On 06.02.20 15:58, Kevin Wolf wrote:
> >>> Am 06.02.2020 um 11:11 hat Max Reitz geschrieben:
> >>>> On 05.02.20 16:38, Kevin Wolf wrote:
> >>>>> Am 30.01.2020 um 22:44 hat Max Reitz geschrieben:
> >>>>>> We will need this to verify that Quorum can let one of its childre=
n be
> >>>>>> replaced without breaking anything else.
> >>>>>>
> >>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>>>> ---
> >>>>>>  block/quorum.c | 25 +++++++++++++++++++++++++
> >>>>>>  1 file changed, 25 insertions(+)
> >>>>>>
> >>>>>> diff --git a/block/quorum.c b/block/quorum.c
> >>>>>> index 59cd524502..6a7224c9e4 100644
> >>>>>> --- a/block/quorum.c
> >>>>>> +++ b/block/quorum.c
> >>>>>> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
> >>>>>> =20
> >>>>>>  typedef struct QuorumChild {
> >>>>>>      BdrvChild *child;
> >>>>>> +
> >>>>>> +    /*
> >>>>>> +     * If set, check whether this node can be replaced without an=
y
> >>>>>> +     * other parent noticing: Unshare CONSISTENT_READ, and take t=
he
> >>>>>> +     * WRITE permission.
> >>>>>> +     */
> >>>>>> +    bool to_be_replaced;
> >>>>>
> >>>>> I don't understand these permission changes. How does (preparing fo=
r)
> >>>>> detaching a node from quorum make its content invalid?
> >>>>
> >>>> It doesn=E2=80=99t, of course.  What we are preparing for is to repl=
ace it by
> >>>> some other node with some other content.
> >>>>
> >>>>> And why do we
> >>>>> suddenly need WRITE permissions even if the quorum node is only use=
d
> >>>>> read-only?
> >>>>>
> >>>>> The comment is a bit unclear, too. "check whether" implies that bot=
h
> >>>>> outcomes could be true, but it doesn't say what happens in either c=
ase.
> >>>>> Is this really "make sure that"?
> >>>>
> >>>> I think the comment is not only unclear, it is the problem.  (Well,
> >>>> maybe the code is also.)
> >>>>
> >>>> This series is about fixing at least some things about replacing nod=
es
> >>>> by mirroring.  The original use cases this was introduced for was to=
 fix
> >>>> broken quorum children: The other children are still intact, so you =
read
> >>>> from the quorum node and replace the broken child (which maybe shows
> >>>> invalid data, or maybe just EIO) by the fixed mirror result.
> >>>>
> >>>> Replacing that broken node by the fixed one changes the data that=E2=
=80=99s
> >>>> visible on that node.
> >>>
> >>> Hm, yes, that's true. But I wonder if this is really something that t=
he
> >>> permission system must catch. Like other graph manipulations, it's
> >>> essentially the user saying "trust me, I know what I'm doing, this no=
de
> >>> makes sense in this place".
> >>>
> >>> Because if you assume that the user could add a node with unsuitable
> >>> content and you want to prevent this, where do we stop?
> >>> blockdev-snapshot can insert a non-empty overlay, which would result =
in
> >>> visible data change. Should we therefore only allow snapshots when
> >>> shared writes are allowed? This doesn't work obviously.
> >>>
> >>> So I'm inclined to say that this is the user's responsibility and we
> >>> don't have to jump through hoops to prevent every possible way that t=
he
> >>> user could mess up. (Which often also result in preventing legitimate
> >>> cases like here a quorum of read-only nodes.)
> >>
> >> Well, if you ask the question =E2=80=9Cwhere do we stop=E2=80=9D, we a=
lso have to ask
> >> the question =E2=80=9Cwhere do we start=E2=80=9D.  If we say the user =
knows what they=E2=80=99re
> >> doing, we might as well drop the whole can_replace infrastructure
> >> altogether and just assume that you can replace any node by anything.
> >=20
> > Well, I don't actually know if that would be completely unreasonable.
> > The idea was obviously to keep graph changes restricted to very specifi=
c
> > cases to avoid nasty surprises like triggering latent bugs. Meanwhile w=
e
> > have quite a few more operations that allow changing the graph.
> >=20
> > So if preventing some cases gives us headaches and is probably more wor=
k
> > than dealing with any bugs they might reveal, maybe preventing them is
> > wrong.
> >=20
> > I'm just afraid that we might be overengineering this and waste time on
> > things that we don't actually get much use from.
>=20
> That=E2=80=99s why I=E2=80=99m asking.

Did I answer your question sufficiently then?

> >> If the WRITE permission is the problem, then I suppose we can drop tha=
t.
> >>  Unsharing CONSISTENT_READ is bad enough that it effectively deters al=
l
> >> other parents anyway.
> >=20
> > WRITE is probably the more practical problem, though it's technically
> > the correct one to take.
> >=20
> > CONSISTENT_READ is already a problem in theory because replacing a chil=
d
> > node with different content doesn't even match its definition:
> >=20
> >     /**
> >      * A user that has the "permission" of consistent reads is guarante=
ed that
> >      * their view of the contents of the block device is complete and
> >      * self-consistent, representing the contents of a disk at a specif=
ic
> >      * point.
> >      *
> >      * For most block devices (including their backing files) this is t=
rue, but
> >      * the property cannot be maintained in a few situations like for
> >      * intermediate nodes of a commit block job.
> >      */
> >     BLK_PERM_CONSISTENT_READ    =3D 0x01,
> >=20
> > Replacing an image with a different image means that the node represent=
s
> > the content of a different disk now, but it's probably still complete
> > and self-consistent.
>=20
> At any point in time yes, but not over the time span of the change.  The
> definition doesn=E2=80=99t say that the node represents the contents of a=
 disk
> at a specific point, but the view from the parent.
>=20
> I argue that that view is always over some period of time, so if you
> suddenly switch out the whole disk, then it isn=E2=80=99t a self-consiste=
nt view.

I think your theory that it's over some period of time conflicts with
the documentation that says "at a specific point".

> Alternatively, we could of course also just forego the permission system
> here altogether and just check that there are no other parents at all.
> (Which is effectively the same as unsharing CONSISTENT_READ.)

This would sidestep all of the artificial permission twiddling, which
sounds good.

It would probably also needlessly restrict the allowed use cases, but
then, who cares about nodes with multiple parents, one of which is a
quorum node?

So I guess I would be fine with either checking that there are no
parents or maybe even just dropping the check completely.

Kevin

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJePEVcAAoJEH8JsnLIjy/W0x0P/A3z68nPwcNCMwvdSshCXNZB
gsIhSha3uBMo+F4g9nfugQnK9vFXC1ipGZQfxvOPRbsq5YnCoy6d2LEy1WFYGriD
j+VK5bbnUAe2rBxeDRajWbBj6pPri7v085s15lhkwYpbOiR0+PE3dxb+LkV9R40C
LHkJvcWsLuADxckHvXwXrbDyH+msNw/gsFkiNalOp4p/NUnSEdx1uAGPUdLuVCxj
ioTvkjZUy0FqqlFfsWpDZRstBtT37w1Q0so6c88+H7gWAvwO2VU+uNxnM/b6lrG0
18Ewxsl6txodYrkstwNsSp2gm70eAr9om27l5SXZhTHqkuNUy1fdfEhLEmUpWx9N
oedvENCFTgSabbW3rCSm9Yj9IYy+v7/f5po8Wv+oDi53lT5bHupRtHzI4Bc37aoc
Vbm4gv/2N+ZsDwATlLsRHwzRLPwJgIpyyhMgPsPZ8vDnoYJDVYay2ukgCjAXEMGU
IWswx9jNCBOxrlfSwVf/xqHDZ9+dAiJSOG2jJXo96vTc8NoER9WaIo0qPiS+Az7u
F6JD4FFY2Hy/8FWsXsoCgCQ8B13Q3fVW2e6OW9/KXcqoAgzYSyGOdb7vnQjSH/eA
fqi9sbG9d63G98VALFipFbWQrnXp27tSkrhp2gqT5sWt1UcqGPhmzrMVkWmom8nm
KQ+8O0BP2MwRrzadIkw9
=/9/E
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--



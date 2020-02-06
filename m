Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310A6C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A07214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkhaEGC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A07214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43869 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlKL-0000MV-2h
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:52:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izlA7-0006xQ-P3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izlA5-0001e2-Qg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:41:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24165
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izlA5-0001cd-KN
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581010917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EcRE/LnNTtJLbDoncnG3qm/c/yh2/FHQQM8V4LkDCIQ=;
 b=KkhaEGC9FAqRoEfeSLYEdfJ+zLQj7tXhovmi1i/sEQDrsiF4ChzOfVNmJKIs1H/IXTE56/
 kdPBYe0yrt4K/tpabbIi9C5S2czhQxb+J+H6z7QOBj90hUUcc6kEz85Ykd9pqMGQgtHFQv
 DX+FQ4Pcc7RRRQP2BKoeDDsgYtdFU7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-5Do9Hu52M-W_2accyyVhCg-1; Thu, 06 Feb 2020 12:41:53 -0500
X-MC-Unique: 5Do9Hu52M-W_2accyyVhCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA1328010F0;
 Thu,  6 Feb 2020 17:41:51 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-204.ams2.redhat.com [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C68E419C7F;
 Thu,  6 Feb 2020 17:41:50 +0000 (UTC)
Date: Thu, 6 Feb 2020 18:41:49 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
Message-ID: <20200206174149.GJ4926@linux.fritz.box>
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
 <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
 <92b951da-5e12-e08f-f8f7-a862790b51ac@redhat.com>
 <20200206145825.GD4926@linux.fritz.box>
 <9d767091-4590-9fce-c596-bda5865aa190@redhat.com>
 <20200206155110.GG4926@linux.fritz.box>
 <78bd2830-9b10-9d66-afe1-783226b8edc5@redhat.com>
 <20200206165700.GH4926@linux.fritz.box>
 <a3dfe3d1-542c-d12f-bcb5-05ab1cf26f6b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a3dfe3d1-542c-d12f-bcb5-05ab1cf26f6b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
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

--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.02.2020 um 18:06 hat Max Reitz geschrieben:
> On 06.02.20 17:57, Kevin Wolf wrote:
> > Am 06.02.2020 um 17:43 hat Max Reitz geschrieben:
> >> On 06.02.20 16:51, Kevin Wolf wrote:
> >>> Am 06.02.2020 um 16:21 hat Max Reitz geschrieben:
> >>>> On 06.02.20 15:58, Kevin Wolf wrote:
> >>>>> Am 06.02.2020 um 11:11 hat Max Reitz geschrieben:
> >>>>>> On 05.02.20 16:38, Kevin Wolf wrote:
> >>>>>>> Am 30.01.2020 um 22:44 hat Max Reitz geschrieben:
> >>>>>>>> We will need this to verify that Quorum can let one of its child=
ren be
> >>>>>>>> replaced without breaking anything else.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >>>>>>>> ---
> >>>>>>>>  block/quorum.c | 25 +++++++++++++++++++++++++
> >>>>>>>>  1 file changed, 25 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/block/quorum.c b/block/quorum.c
> >>>>>>>> index 59cd524502..6a7224c9e4 100644
> >>>>>>>> --- a/block/quorum.c
> >>>>>>>> +++ b/block/quorum.c
> >>>>>>>> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
> >>>>>>>> =20
> >>>>>>>>  typedef struct QuorumChild {
> >>>>>>>>      BdrvChild *child;
> >>>>>>>> +
> >>>>>>>> +    /*
> >>>>>>>> +     * If set, check whether this node can be replaced without =
any
> >>>>>>>> +     * other parent noticing: Unshare CONSISTENT_READ, and take=
 the
> >>>>>>>> +     * WRITE permission.
> >>>>>>>> +     */
> >>>>>>>> +    bool to_be_replaced;
> >>>>>>>
> >>>>>>> I don't understand these permission changes. How does (preparing =
for)
> >>>>>>> detaching a node from quorum make its content invalid?
> >>>>>>
> >>>>>> It doesn=E2=80=99t, of course.  What we are preparing for is to re=
place it by
> >>>>>> some other node with some other content.
> >>>>>>
> >>>>>>> And why do we
> >>>>>>> suddenly need WRITE permissions even if the quorum node is only u=
sed
> >>>>>>> read-only?
> >>>>>>>
> >>>>>>> The comment is a bit unclear, too. "check whether" implies that b=
oth
> >>>>>>> outcomes could be true, but it doesn't say what happens in either=
 case.
> >>>>>>> Is this really "make sure that"?
> >>>>>>
> >>>>>> I think the comment is not only unclear, it is the problem.  (Well=
,
> >>>>>> maybe the code is also.)
> >>>>>>
> >>>>>> This series is about fixing at least some things about replacing n=
odes
> >>>>>> by mirroring.  The original use cases this was introduced for was =
to fix
> >>>>>> broken quorum children: The other children are still intact, so yo=
u read
> >>>>>> from the quorum node and replace the broken child (which maybe sho=
ws
> >>>>>> invalid data, or maybe just EIO) by the fixed mirror result.
> >>>>>>
> >>>>>> Replacing that broken node by the fixed one changes the data that=
=E2=80=99s
> >>>>>> visible on that node.
> >>>>>
> >>>>> Hm, yes, that's true. But I wonder if this is really something that=
 the
> >>>>> permission system must catch. Like other graph manipulations, it's
> >>>>> essentially the user saying "trust me, I know what I'm doing, this =
node
> >>>>> makes sense in this place".
> >>>>>
> >>>>> Because if you assume that the user could add a node with unsuitabl=
e
> >>>>> content and you want to prevent this, where do we stop?
> >>>>> blockdev-snapshot can insert a non-empty overlay, which would resul=
t in
> >>>>> visible data change. Should we therefore only allow snapshots when
> >>>>> shared writes are allowed? This doesn't work obviously.
> >>>>>
> >>>>> So I'm inclined to say that this is the user's responsibility and w=
e
> >>>>> don't have to jump through hoops to prevent every possible way that=
 the
> >>>>> user could mess up. (Which often also result in preventing legitima=
te
> >>>>> cases like here a quorum of read-only nodes.)
> >>>>
> >>>> Well, if you ask the question =E2=80=9Cwhere do we stop=E2=80=9D, we=
 also have to ask
> >>>> the question =E2=80=9Cwhere do we start=E2=80=9D.  If we say the use=
r knows what they=E2=80=99re
> >>>> doing, we might as well drop the whole can_replace infrastructure
> >>>> altogether and just assume that you can replace any node by anything=
.
> >>>
> >>> Well, I don't actually know if that would be completely unreasonable.
> >>> The idea was obviously to keep graph changes restricted to very speci=
fic
> >>> cases to avoid nasty surprises like triggering latent bugs. Meanwhile=
 we
> >>> have quite a few more operations that allow changing the graph.
> >>>
> >>> So if preventing some cases gives us headaches and is probably more w=
ork
> >>> than dealing with any bugs they might reveal, maybe preventing them i=
s
> >>> wrong.
> >>>
> >>> I'm just afraid that we might be overengineering this and waste time =
on
> >>> things that we don't actually get much use from.
> >>
> >> That=E2=80=99s why I=E2=80=99m asking.
> >=20
> > Did I answer your question sufficiently then?
>=20
> No, because =E2=80=9CI=E2=80=99m afraid=E2=80=9D is a sentiment I fully s=
hare, but it doesn=E2=80=99t
> answer the question whether we are indeed overengineering this or not. :-=
)

Well, I guess I can only answer this after seeing the bug reports we
would get after removing the check. :-)

> I suppose my stance now is =E2=80=9CThis is probably overengineered, but =
now we
> might as well roll with it=E2=80=9D.

Your choice. I'm not opposed to anything that feels like it makes sense.

> >>>> If the WRITE permission is the problem, then I suppose we can drop t=
hat.
> >>>>  Unsharing CONSISTENT_READ is bad enough that it effectively deters =
all
> >>>> other parents anyway.
> >>>
> >>> WRITE is probably the more practical problem, though it's technically
> >>> the correct one to take.
> >>>
> >>> CONSISTENT_READ is already a problem in theory because replacing a ch=
ild
> >>> node with different content doesn't even match its definition:
> >>>
> >>>     /**
> >>>      * A user that has the "permission" of consistent reads is guaran=
teed that
> >>>      * their view of the contents of the block device is complete and
> >>>      * self-consistent, representing the contents of a disk at a spec=
ific
> >>>      * point.
> >>>      *
> >>>      * For most block devices (including their backing files) this is=
 true, but
> >>>      * the property cannot be maintained in a few situations like for
> >>>      * intermediate nodes of a commit block job.
> >>>      */
> >>>     BLK_PERM_CONSISTENT_READ    =3D 0x01,
> >>>
> >>> Replacing an image with a different image means that the node represe=
nts
> >>> the content of a different disk now, but it's probably still complete
> >>> and self-consistent.
> >>
> >> At any point in time yes, but not over the time span of the change.  T=
he
> >> definition doesn=E2=80=99t say that the node represents the contents o=
f a disk
> >> at a specific point, but the view from the parent.
> >>
> >> I argue that that view is always over some period of time, so if you
> >> suddenly switch out the whole disk, then it isn=E2=80=99t a self-consi=
stent view.
> >=20
> > I think your theory that it's over some period of time conflicts with
> > the documentation that says "at a specific point".
>=20
> I=E2=80=99d rather not get into a deeper discussion on what CONSISTENT_RE=
AD
> means again... :-/
>=20
> I always feel like if you really take only a single point in time, then
> anything could be some hypothetical disk.
>=20
> So to me, unsharing CONSISTENT_READ effectively just means =E2=80=9CDon=
=E2=80=99t touch
> this, you don=E2=80=99t want to=E2=80=9D.

The difference is that with the replace operation we aren't talking
about hypothetical corrupted disks (like we would get when accessing
intermediate nodes of the commit job), but about two actual disk images
that are both valid, though different.

But yes, maybe we should avoid this discussion...

(I mean, what it *really* means is "this is not an intermediate node
of commit". ;-))

> >> Alternatively, we could of course also just forego the permission syst=
em
> >> here altogether and just check that there are no other parents at all.
> >> (Which is effectively the same as unsharing CONSISTENT_READ.)
> >=20
> > This would sidestep all of the artificial permission twiddling, which
> > sounds good.
> >=20
> > It would probably also needlessly restrict the allowed use cases,
>=20
> Only in theory, though, because in practice basically everything useful
> takes CONSISTENT_READ anyway.

Oh, compared to taking WRITE and unsharing CONSISTENT_READ it's probably
not more restrictice. I was comparing with the case that drops the
checks altogether.

> > but
> > then, who cares about nodes with multiple parents, one of which is a
> > quorum node?
> >=20
> > So I guess I would be fine with either checking that there are no
> > parents or maybe even just dropping the check completely.
>=20
> OK, I=E2=80=99ll check the parent list then.  (Except it must be exactly =
one
> parent, namely Quorum.)

Fine with me.

Kevin

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJePE/dAAoJEH8JsnLIjy/W6owP/R3SL+wzC5gHlgAanC1NTkEe
AlfaOVKLMF3DtfwE7qKXXLgEaoirNxzW2AEpezEsrSC1fQIDDLP7fIuHerF7+yxV
p4lL7RSucX5kauW2zV3OeMp6HSUrx3IIa3Y5gIrZKa2uRtb3Ed01+Uhb8aPZZEiW
mFCx+7Pv4VqDNh83e/KguWgkv5RRCy1Uyos2+MqTynyqw/8xyY8POwDKKhy36gEZ
NuIva5K02fR+RAYuJXnzE2WqR6SSIG3u5uh6CODzdNrWcqi4NXGPZ6Xv5MGAWEtw
rP4Yd+GyoQR6qcDzEC9PRk0yPyxCKwpJDlQGbP7wDURWnM2gl5OGs0vXVcinWrPt
uYwTETn+AUE8QST7j9pXYRWdcretnZq16PvAI0+SmTbetV741Lz9NWmvmm+1/8tw
j1P0lqwQ/7zRPsLLxzftHFKucW3B1y3ASURlRAUMVA7E0bgYrCaRXgWWM/3ApVC9
96CwpNboDu7WPkhd2AxQ4crO+iywG7x4CB0di2+bIObNlxGK5Tllhkme6fqKLjHG
9DzV/HnAmEXIjBxpVdbNOSu3vZeqP5Jyp34vQt6cXJdUYZXf3XzIr4b6OlX3a+/C
wouXpKIgV8cWBrjXnuINuAznri2FO/L0zOXh0p1xMdAvLGR7t2+uH0dfak9e8jFu
S3/FeCFLDa07cGx+M5MP
=Y5rU
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--



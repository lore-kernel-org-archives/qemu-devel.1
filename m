Received: from eggs.gnu.org ([2001:4830:134:3::10]:35472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fazib-0006IY-77
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faziZ-0008Oy-Us
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 04:34:25 -0400
Date: Thu, 5 Jul 2018 10:34:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180705083416.GB3309@localhost.localdomain>
References: <20180703180751.243496-1-vsementsov@virtuozzo.com>
	<20180703180751.243496-2-vsementsov@virtuozzo.com>
	<0e6e9f14-ad45-51c5-0d14-3e2e3dcaf5cb@virtuozzo.com>
	<20180704150833.GG4334@localhost.localdomain>
	<f50dc336-cb33-de03-d8ab-a0c01cadd850@virtuozzo.com>
	<20180704162031.GH4334@localhost.localdomain>
	<b9e20c0c-c21e-0257-4e93-cc6d31680d8c@virtuozzo.com>
	<741f1831-2c65-17cc-1886-4f922ffe14cb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <741f1831-2c65-17cc-1886-4f922ffe14cb@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] block: add BDRV_REQ_SERIALISING flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org

Am 04.07.2018 um 19:06 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 04.07.2018 19:36, Vladimir Sementsov-Ogievskiy wrote:
> > 04.07.2018 19:20, Kevin Wolf wrote:
> > > Am 04.07.2018 um 18:11 hat Vladimir Sementsov-Ogievskiy geschrieben=
:
> > > > 04.07.2018 18:08, Kevin Wolf wrote:
> > > > > Am 04.07.2018 um 16:44 hat Vladimir Sementsov-Ogievskiy geschri=
eben:
> > > > > > 03.07.2018 21:07, Vladimir Sementsov-Ogievskiy wrote:
> > > > > > > Serialized writes should be used in copy-on-write of
> > > > > > > backup(sync=3Dnone)
> > > > > > > for image fleecing scheme.
> > > > > > >=20
> > > > > > > Signed-off-by: Vladimir Sementsov-Ogievskiy
> > > > > > > <vsementsov@virtuozzo.com>
> > > > > > > ---
> > > > > > > =A0=A0=A0 include/block/block.h | 5 ++++-
> > > > > > > =A0=A0=A0 block/io.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 4 +=
+++
> > > > > > > =A0=A0=A0 2 files changed, 8 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/include/block/block.h b/include/block/block.h
> > > > > > > index e5c7759a0c..107113aad5 100644
> > > > > > > --- a/include/block/block.h
> > > > > > > +++ b/include/block/block.h
> > > > > > > @@ -58,8 +58,11 @@ typedef enum {
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0 * content. */
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 BDRV_REQ_WRITE_UNCHANGED=A0=A0=A0 =3D=
 0x40,
> > > > > > > +=A0=A0=A0 /* Force request serializing. Only for writes. *=
/
> > > > > > > +=A0=A0=A0 BDRV_REQ_SERIALISING=A0=A0=A0=A0=A0=A0=A0 =3D 0x=
80,
> > > > > > > +
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 /* Mask of valid flags */
> > > > > > > -=A0=A0=A0 BDRV_REQ_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 0x7f,
> > > > > > > +=A0=A0=A0 BDRV_REQ_MASK=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 =3D 0xff,
> > > > > > > =A0=A0=A0 } BdrvRequestFlags;
> > > > > > > =A0=A0=A0 typedef struct BlockSizes {
> > > > > > > diff --git a/block/io.c b/block/io.c
> > > > > > > index 1a2272fad3..d5ba078514 100644
> > > > > > > --- a/block/io.c
> > > > > > > +++ b/block/io.c
> > > > > > > @@ -1572,6 +1572,10 @@ static int coroutine_fn
> > > > > > > bdrv_aligned_pwritev(BdrvChild *child,
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 max_transfer =3D
> > > > > > > QEMU_ALIGN_DOWN(MIN_NON_ZERO(bs->bl.max_transfer,
> > > > > > > INT_MAX),
> > > > > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 align);
> > > > > > > +=A0=A0=A0 if (flags & BDRV_REQ_SERIALISING) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 mark_request_serialising(req, bdrv_g=
et_cluster_size(bs));
> > > > > > > +=A0=A0=A0 }
> > > > > > > +
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 waited =3D wait_serialising_requests(=
req);
> > > > > > > =A0=A0=A0=A0=A0=A0=A0 assert(!waited || !req->serialising);
> > > > > > Kevin, about this assertion, introduced in 28de2dcd88de
> > > > > > "block: Assert
> > > > > > serialisation assumptions in pwritev"? Will not it fail with =
fleecing
> > > > > > scheme? I'm afraid it will, when we will wait for client
> > > > > > read with our
> > > > > > request, marked serializing a moment ago...
> > > > > Hm, looks like it yes.
> > > > >=20
> > > > > > Can we just switch it to assert(!waited || !req->partial);, s=
etting
> > > > > > req->partial in bdrv_co_pwritev for parts of unaligned
> > > > > > requests? And allow
> > > > > > new flag only for aligned requests?
> > > > > >=20
> > > > > > Other ideas?
> > > > > The commit message of 28de2dcd88de tells you what we need to do=
 (and
> > > > > that just changing the assertion is wrong):
> > > > >=20
> > > > > =A0=A0=A0=A0=A0 If a request calls wait_serialising_requests() =
and
> > > > > actually has to wait
> > > > > =A0=A0=A0=A0=A0 in this function (i.e. a coroutine yield), othe=
r
> > > > > requests can run and
> > > > > =A0=A0=A0=A0=A0 previously read data (like the head or tail buf=
fer) could become
> > > > > =A0=A0=A0=A0=A0 outdated. In this case, we would have to restar=
t from
> > > > > the beginning to
> > > > > =A0=A0=A0=A0=A0 read in the updated data.
> > > > >=20
> > > > > =A0=A0=A0=A0=A0 However, we're lucky and don't actually need to=
 do
> > > > > that: A request can
> > > > > =A0=A0=A0=A0=A0 only wait in the first call of
> > > > > wait_serialising_requests() because we
> > > > > =A0=A0=A0=A0=A0 mark it as serialising before that call, so any=
 later
> > > > > requests would
> > > > > =A0=A0=A0=A0=A0 wait. So as we don't wait in practice, we don't=
 have
> > > > > to reload the data.
> > > > >=20
> > > > > =A0=A0=A0=A0=A0 This is an important assumption that may not be=
 broken or data
> > > > > =A0=A0=A0=A0=A0 corruption will happen. Document it with some a=
ssertions.
> > > > >=20
> > > > > So we may need to return -EAGAIN here, check that in the caller=
 and
> > > > > repeat the write request from the very start.
> > > > But in case of aligned request, there no previously read data,
> > > > and we can
> > > > safely continue. And actually it's our case (backup writes are
> > > > aligned).
> > > Hm, right. I don't particularly like req->partial because it's easy=
 to
> > > forget to set it to false when you do something that would need to =
be
> > > repeated, but I don't have a better idea.
> > >=20
> > > Kevin
> >=20
> > I said partial, because I imagined unaligned request split to parts f=
or
> > separate writing, but this is wrong, req->unaligned sound better for =
me
> > now.
> >=20
> > So, for aligned requests all is ok.
> >=20
> > But for unaligned all is ok too, because they are marked serializing =
and
> > waited on first call to wait_for_serializing, before reading tails an=
d
> > before considered place in bdrv_aligned_pwritev.
> >=20
>=20
> Is it correct "serialiSing" ? Google and Thunderbird both correcting me=
 to
> serialiZing

Both are correct, it's just British vs. American spelling. In the
context of request serialisation, we seem to use the spelling with S, so
it would be more consistent to stay with it.

Kevin

Received: from eggs.gnu.org ([2001:4830:134:3::10]:51586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1evLcL-0008Hy-DU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1evLcH-0000fn-Ek
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:27:49 -0400
Date: Mon, 12 Mar 2018 11:27:41 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180312112741.GC5681@stefanha-x1.localdomain>
References: <20180306204819.11266-1-stefanha@redhat.com>
	<20180306204819.11266-2-stefanha@redhat.com>
	<f3e7a178-0002-fd12-caf2-585171de1b04@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
In-Reply-To: <f3e7a178-0002-fd12-caf2-585171de1b04@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: let
 blk_add/remove_aio_context_notifier() tolerate BDS changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefano Panella <spanella@gmail.com>


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 09, 2018 at 09:56:44AM -0600, Eric Blake wrote:
> On 03/06/2018 02:48 PM, Stefan Hajnoczi wrote:
> > Commit 2019ba0a0197 ("block: Add AioContextNotifier functions to BB")
> > added blk_add/remove_aio_context_notifier() and implemented them by
> > passing through the bdrv_*() equivalent.
> >=20
> > This doesn't work across bdrv_append(), which detaches child->bs and
> > re-attaches it to a new BlockDriverState.  When
> > blk_remove_aio_context_notifier() is called we will access the new BDS
> > instead of the one where the notifier was added!
> >=20
> > > From the point of view of the blk_*() API user, changes to the root B=
DS
> > should be transparent.
> >=20
> > This patch maintains a list of AioContext notifiers in BlockBackend and
> > adds/removes them from the BlockDriverState as needed.
> >=20
> > Reported-by: Stefano Panella <spanella@gmail.com>
> > Cc: Max Reitz <mreitz@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >   block/block-backend.c | 63 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   block/trace-events    |  2 ++
> >   2 files changed, 65 insertions(+)
> >=20
> > diff --git a/block/block-backend.c b/block/block-backend.c
> > index 94ffbb6a60..aa27698820 100644
> > --- a/block/block-backend.c
> > +++ b/block/block-backend.c
> > @@ -31,6 +31,13 @@
> >   static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb);
> > +typedef struct BlockBackendAioNotifier {
> > +    void (*attached_aio_context)(AioContext *new_context, void *opaque=
);
> > +    void (*detach_aio_context)(void *opaque);
>=20
> Why the difference in tense (past 'attached' vs. present 'detach')?

The naming comes from the bdrv_add_aio_context_notifier() API:

  void bdrv_add_aio_context_notifier(BlockDriverState *bs,
        void (*attached_aio_context)(AioContext *new_context, void *opaque),
        void (*detach_aio_context)(void *opaque), void *opaque)

It's "attached" because bs->aio_context has already been assigned before
the callback is invoked.

It's "detach" because the callback is invoked before bs->aio_context is
cleared.

Not great naming and I found it weird when I looked at the code too, but
at least this patch keeps the BlockBackend naming consistent with the
BlockDriverState naming.

> > @@ -1827,12 +1877,25 @@ void blk_remove_aio_context_notifier(BlockBacke=
nd *blk,
> >                                        void (*detach_aio_context)(void =
*),
> >                                        void *opaque)
> >   {
> > +    BlockBackendAioNotifier *notifier;
> >       BlockDriverState *bs =3D blk_bs(blk);
> >       if (bs) {
> >           bdrv_remove_aio_context_notifier(bs, attached_aio_context,
> >                                            detach_aio_context, opaque);
> >       }
> > +
> > +    QLIST_FOREACH(notifier, &blk->aio_notifiers, list) {
> > +        if (notifier->attached_aio_context =3D=3D attached_aio_context=
 &&
> > +            notifier->detach_aio_context =3D=3D detach_aio_context &&
> > +            notifier->opaque =3D=3D opaque) {
> > +            QLIST_REMOVE(notifier, list);
>=20
> Don't you need to use QLIST_FOREACH_SAFE if you are going to modify the l=
ist
> during traversal?

It doesn't matter since we return right away:

  g_free(notifier);
  return;

Stefan

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJapmQtAAoJEJykq7OBq3PIDNgH/RY0ePiNppdXmGr/DSwgo6TA
8en0sUtLeI0ImQ9bX5pBJcBqwrhuqLaJkI6S7BBnJC/inQj6sSNc/u7T5m2VlsC7
D89Ivqz5xQusVQJZ/SiqiSypPjLnvcqDLqWQNV1siW0lcY+btpcUC77oLxG4SNxN
P8NyaoVbwYoVFZ/vQ3EJJzqLB2FcNbCAFkA16I3ZBeQW9eg4GgEiSZEUpWYyko+6
XJ/RmN75y1A0YYzdyRoqp9M10x9I6RhkGS4RNAqPy59R3yQFZ0wchDz/qiPKHoB8
HzyclCt6oaY9sJgw0hll1XKF8HubFbifJT+i8JcNgHOA8vroPRez8Mybe8pTIxQ=
=hHqY
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehJA2-0005MQ-DO
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehJA0-0003Ki-Q6
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:00:34 -0500
Date: Thu, 1 Feb 2018 18:00:25 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180201180025.GI5578@stefanha-x1.localdomain>
References: <1516633309-20803-1-git-send-email-mark.kanda@oracle.com>
	<20180124113123.GB17193@stefanha-x1.localdomain>
	<20180129154107.GI6141@localhost.localdomain>
	<20180130123823.GE15551@stefanha-x1.localdomain>
	<20180130155612.GA4503@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="STPqjqpCrtky8aYs"
Content-Disposition: inline
In-Reply-To: <20180130155612.GA4503@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] virtio-blk: check for NULL
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Mark Kanda <mark.kanda@oracle.com>, ameya.more@oracle.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--STPqjqpCrtky8aYs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 04:56:12PM +0100, Kevin Wolf wrote:
> Am 30.01.2018 um 13:38 hat Stefan Hajnoczi geschrieben:
> > On Mon, Jan 29, 2018 at 04:41:07PM +0100, Kevin Wolf wrote:
> > > Am 24.01.2018 um 12:31 hat Stefan Hajnoczi geschrieben:
> > > > On Mon, Jan 22, 2018 at 09:01:49AM -0600, Mark Kanda wrote:
> > > > > Add a BlockDriverState NULL check to virtio_blk_handle_request()
> > > > > to prevent a segfault if the drive is forcibly removed using HMP
> > > > > 'drive_del' (without performing a hotplug 'device_del' first).
> > > > >=20
> > > > > Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> > > > > Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> > > > > Reviewed-by: Ameya More <ameya.more@oracle.com>
> > > > > ---
> > > > >  hw/block/virtio-blk.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > > > index b1532e4..76ddbbf 100644
> > > > > --- a/hw/block/virtio-blk.c
> > > > > +++ b/hw/block/virtio-blk.c
> > > > > @@ -507,6 +507,13 @@ static int virtio_blk_handle_request(VirtIOB=
lockReq *req, MultiReqBuffer *mrb)
> > > > >          return -1;
> > > > >      }
> > > > > =20
> > > > > +    /* If the drive was forcibly removed (e.g. HMP 'drive_del'),=
 the block
> > > > > +     * driver state may be NULL and there is nothing left to do.=
 */
> > > > > +    if (!blk_bs(req->dev->blk)) {
> > > >=20
> > > > Adding Markus Armbruster to check my understanding of drive_del:
> > > >=20
> > > > 1. If id is a node name (e.g. created via blockdev-add) then attemp=
ting
> > > >    to remove the root node produces the "Node %s is in use" error. =
 In
> > > >    that case this patch isn't needed.
> > > >=20
> > > > 2. If id is a BlockBackend (e.g. created via -drive) then removing =
the
> > > >    root node is allowed.  The BlockBackend stays in place but blk->=
root
> > > >    becomes NULL, hence this patch is needed.
> > > >=20
> > > > Markus: What are the valid use cases for #2?  If blk->bs becomes NU=
LL I
> > > > would think a lot more code beyond virtio-blk can segfault.
> > >=20
> > > blk->root =3D NULL is completely normal, it is what happens with remo=
vable
> > > media when the drive is empty.
> > >=20
> > > The problem, which was first reported during the 2.10 RC phase and was
> > > worked around in IDE code then, is that Paolo's commit 99723548561 ad=
ded
> > > unconditional bdrv_inc/dec_in_flight() calls. I am pretty sure that a=
ny
> > > segfaults that Mark is seeing have the same cause.
> > >=20
> > > We do need an in-flight counter even for those requests so that
> > > blk_drain() works correctly, so just making the calls condition would=
n't
> > > be right. However, this needs to become a separate counter in
> > > BlockBackend, and the drain functions must be changed to make use of =
it.
> > >=20
> > > I did post rough patches back then, but they weren't quite ready, and
> > > since then they have fallen through the cracks.
> >=20
> > Will you send a new version of that patch series?
>=20
> I would like to continue my work on the drain functions (which this
> would be a part of) sooner or later, but the work to enable libvirt to
> use blockdev-add is at a higher priority at the moment.
>=20
> So if you can wait, I'll get to it eventually. If not, feel free to pick
> up the patches.

Okay, I'll let you know early next week whether I am able to work on it.

Stefan

--STPqjqpCrtky8aYs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJac1W5AAoJEJykq7OBq3PIvN8IALZnlQplOOqtwLt0WpqKixJ/
C6b9PcZtKV2AF0LIJV1n0xeqddRhf4Ks1kqCwKb5b0YuxCOVxKrQWaBKcSd8Ex2W
hgpDICGnDsj/PBJ0FgADmDPFg40OeSQhcrGdCyKm8Pr4P6aUQcst+08flAwAaviX
6+G3mcyQ1nv/SpodVkEzFcsboWg4OY/OqqBhsOfJ3CKrWuywzZdRR8PamJRcdZ96
7o+BDNKeewl5cXpYdiBMDeNk7iPftc0gRb4ByRJ7dOSw9g+XS6VxAogaWPF3XEwq
rPTco7KRx00p0wAZm933uBeD/9oNDY30K58T8tnC5fNgd/C5qPdrKUj4aAaGrYQ=
=5djt
-----END PGP SIGNATURE-----

--STPqjqpCrtky8aYs--

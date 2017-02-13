Received: from eggs.gnu.org ([2001:4830:134:3::10]:60357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHc3-00084D-UH
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHc1-00057l-AJ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:28:19 -0500
Date: Mon, 13 Feb 2017 14:28:14 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213142814.GK10361@stefanha-x1.localdomain>
References: <20170207132723.13934-1-famz@redhat.com>
	<20170207132723.13934-3-famz@redhat.com>
	<25ac6a9f-c393-1a9a-e7f1-f8e3374135ee@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDymnuGqqhW10CwH"
Content-Disposition: inline
In-Reply-To: <25ac6a9f-c393-1a9a-e7f1-f8e3374135ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio-blk: Inline request init,
 complete and free functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--qDymnuGqqhW10CwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 02:52:38PM +0100, Laszlo Ersek wrote:
> On 02/07/17 14:27, Fam Zheng wrote:
> > These are used in each request handling, inline them.
> >=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  hw/block/virtio-blk.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 2858c31..1da9570 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -29,8 +29,8 @@
> >  #include "hw/virtio/virtio-bus.h"
> >  #include "hw/virtio/virtio-access.h"
> > =20
> > -static void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *vq,
> > -                                    VirtIOBlockReq *req)
> > +static inline void virtio_blk_init_request(VirtIOBlock *s, VirtQueue *=
vq,
> > +                                           VirtIOBlockReq *req)
> >  {
> >      req->dev =3D s;
> >      req->vq =3D vq;
> > @@ -40,12 +40,13 @@ static void virtio_blk_init_request(VirtIOBlock *s,=
 VirtQueue *vq,
> >      req->mr_next =3D NULL;
> >  }
> > =20
> > -static void virtio_blk_free_request(VirtIOBlockReq *req)
> > +static inline void virtio_blk_free_request(VirtIOBlockReq *req)
> >  {
> >      g_free(req);
> >  }
> > =20
> > -static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char=
 status)
> > +static inline void virtio_blk_req_complete(VirtIOBlockReq *req,
> > +                                           unsigned char status)
> >  {
> >      VirtIOBlock *s =3D req->dev;
> >      VirtIODevice *vdev =3D VIRTIO_DEVICE(s);
> >=20
>=20
> Hm, virtio_blk_req_complete() looks a bit too "meaty" and seems to be
> called from a little too many places for me to feel convenient about
> inlining it. I guess I'd leave it to the compiler to optimize the
> function call. Does the explicit hint offer a noticeable perf improvement?
>=20
> Inlining virtio_blk_free_request() looks reasonable.
>=20
> virtio_blk_init_request() looks okay too.
>=20
> Other reviewers should feel free to override my concerns :) My view on
> this is distant.

I'm not a big fan of manually inlining functions.  Let the compiler
decide whether these static functions should be inlined.

Stefan

--qDymnuGqqhW10CwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYocJ+AAoJEJykq7OBq3PIIWEIAI3TkPacwUN1cYd8/MLHXJF2
lHxjUOuaIpNTHbuIf56D42SS8R7XKLOqRe+EmuWJkwS0JdLWnS6Z8u5p1BLHGGsB
f0z9GD8217SN8UIf9feTyS0FCwrMU7CgAP6bnbqejyOEZmDkTd+hXRKAU1bITKXJ
+BUrNuu3zlb6DI6Y38QFU4867yW6PCAJuI+xeHRB/+HGFKvKbGRD+Sz2y8NV942X
ytn+lzmaPz6iIBIDcBizt8r4N6S9YOs9NgCJCYgKYe0LdS71Oo7q24BSKCyWucFY
aNyhlRaIAiiNhnBXXq+nBmwup/dzdVgtvXO/KAITyE4hn4r1JCXjfcsMn2foIPw=
=NeVr
-----END PGP SIGNATURE-----

--qDymnuGqqhW10CwH--

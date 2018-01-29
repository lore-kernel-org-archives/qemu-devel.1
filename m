Received: from eggs.gnu.org ([2001:4830:134:3::10]:34915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egBYi-00035V-QO
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:41:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egBYh-0004Wj-Sx
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 10:41:24 -0500
Date: Mon, 29 Jan 2018 16:41:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180129154107.GI6141@localhost.localdomain>
References: <1516633309-20803-1-git-send-email-mark.kanda@oracle.com>
	<20180124113123.GB17193@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline
In-Reply-To: <20180124113123.GB17193@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Mark Kanda <mark.kanda@oracle.com>, ameya.more@oracle.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 24.01.2018 um 12:31 hat Stefan Hajnoczi geschrieben:
> On Mon, Jan 22, 2018 at 09:01:49AM -0600, Mark Kanda wrote:
> > Add a BlockDriverState NULL check to virtio_blk_handle_request()
> > to prevent a segfault if the drive is forcibly removed using HMP
> > 'drive_del' (without performing a hotplug 'device_del' first).
> >=20
> > Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> > Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> > Reviewed-by: Ameya More <ameya.more@oracle.com>
> > ---
> >  hw/block/virtio-blk.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index b1532e4..76ddbbf 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -507,6 +507,13 @@ static int virtio_blk_handle_request(VirtIOBlockRe=
q *req, MultiReqBuffer *mrb)
> >          return -1;
> >      }
> > =20
> > +    /* If the drive was forcibly removed (e.g. HMP 'drive_del'), the b=
lock
> > +     * driver state may be NULL and there is nothing left to do. */
> > +    if (!blk_bs(req->dev->blk)) {
>=20
> Adding Markus Armbruster to check my understanding of drive_del:
>=20
> 1. If id is a node name (e.g. created via blockdev-add) then attempting
>    to remove the root node produces the "Node %s is in use" error.  In
>    that case this patch isn't needed.
>=20
> 2. If id is a BlockBackend (e.g. created via -drive) then removing the
>    root node is allowed.  The BlockBackend stays in place but blk->root
>    becomes NULL, hence this patch is needed.
>=20
> Markus: What are the valid use cases for #2?  If blk->bs becomes NULL I
> would think a lot more code beyond virtio-blk can segfault.

blk->root =3D NULL is completely normal, it is what happens with removable
media when the drive is empty.

The problem, which was first reported during the 2.10 RC phase and was
worked around in IDE code then, is that Paolo's commit 99723548561 added
unconditional bdrv_inc/dec_in_flight() calls. I am pretty sure that any
segfaults that Mark is seeing have the same cause.

We do need an in-flight counter even for those requests so that
blk_drain() works correctly, so just making the calls condition wouldn't
be right. However, this needs to become a separate counter in
BlockBackend, and the drain functions must be changed to make use of it.

I did post rough patches back then, but they weren't quite ready, and
since then they have fallen through the cracks.

Kevin

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJab0CTAAoJEH8JsnLIjy/W0rUP/AnUQ3KGIqXIznRYks63lG4g
62iHGNYp3H6kLkAK5jBI87WTmsHPGodLyXqDfR+t/pGJiOTgxxd95x8dVqkT2vq3
jT77SQoB13168K1lYHTvZ+ecSuA2hDiEZYDDe3LjinKrgG05QxWIqnXItgArPqXH
U4d4y8lBla4BZ4YBcmJHA+urcsF0gPOVJyBC7rGwzoU1Dex4aIYMkmmIV0Xko8nA
52qBQtRVE8riG6xiCN5hagWW/CjZ3HdgRld6kcBH3ZVFME/ivPKsXzMIIhv4z3Nx
1HnVcY3QtGlaBeW4gXmnePJacrr1Xw5jTT0n/TyS6aGV0owgUvn753o0BURFKIVv
1F654Rh+aXMdwS5hgFMO04yYFHVXnx+HD0BfIFBAIgqybXMh/bho1mnIcIUkEmpn
cr7RJKmrHdWa2dQ+FCEp/61xZ1PncQVOV0ij59wNZu4eOFLicZ5lz2PlwyEdjyqc
ed+wiOkc9Xp5T7mmc3WddeceUI34QLrU+8Ns/6kPQhhOinYjmTkXMbkm/QtnyVtg
124dt7qlq/IvUXFYFRCEUtuiq/4gQtyu4L53FOsXBpUHwSvMcs+lO1TVDukCVA7F
z6TePH/mNU01bIIzwscsKzNUlVz1qmNX+zqBwsV1ml929GcxAJ6sPpB3AQ+O78Dk
JAUnzSbrSmj7+UaaCbFD
=VB8g
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--

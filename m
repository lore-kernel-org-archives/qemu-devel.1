Received: from eggs.gnu.org ([2001:4830:134:3::10]:58722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egXzv-0002U0-HD
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:39:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1egXzu-0007nM-D9
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 10:38:59 -0500
Date: Tue, 30 Jan 2018 12:38:23 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180130123823.GE15551@stefanha-x1.localdomain>
References: <1516633309-20803-1-git-send-email-mark.kanda@oracle.com>
	<20180124113123.GB17193@stefanha-x1.localdomain>
	<20180129154107.GI6141@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline
In-Reply-To: <20180129154107.GI6141@localhost.localdomain>
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


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 04:41:07PM +0100, Kevin Wolf wrote:
> Am 24.01.2018 um 12:31 hat Stefan Hajnoczi geschrieben:
> > On Mon, Jan 22, 2018 at 09:01:49AM -0600, Mark Kanda wrote:
> > > Add a BlockDriverState NULL check to virtio_blk_handle_request()
> > > to prevent a segfault if the drive is forcibly removed using HMP
> > > 'drive_del' (without performing a hotplug 'device_del' first).
> > >=20
> > > Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> > > Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> > > Reviewed-by: Ameya More <ameya.more@oracle.com>
> > > ---
> > >  hw/block/virtio-blk.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > index b1532e4..76ddbbf 100644
> > > --- a/hw/block/virtio-blk.c
> > > +++ b/hw/block/virtio-blk.c
> > > @@ -507,6 +507,13 @@ static int virtio_blk_handle_request(VirtIOBlock=
Req *req, MultiReqBuffer *mrb)
> > >          return -1;
> > >      }
> > > =20
> > > +    /* If the drive was forcibly removed (e.g. HMP 'drive_del'), the=
 block
> > > +     * driver state may be NULL and there is nothing left to do. */
> > > +    if (!blk_bs(req->dev->blk)) {
> >=20
> > Adding Markus Armbruster to check my understanding of drive_del:
> >=20
> > 1. If id is a node name (e.g. created via blockdev-add) then attempting
> >    to remove the root node produces the "Node %s is in use" error.  In
> >    that case this patch isn't needed.
> >=20
> > 2. If id is a BlockBackend (e.g. created via -drive) then removing the
> >    root node is allowed.  The BlockBackend stays in place but blk->root
> >    becomes NULL, hence this patch is needed.
> >=20
> > Markus: What are the valid use cases for #2?  If blk->bs becomes NULL I
> > would think a lot more code beyond virtio-blk can segfault.
>=20
> blk->root =3D NULL is completely normal, it is what happens with removable
> media when the drive is empty.
>=20
> The problem, which was first reported during the 2.10 RC phase and was
> worked around in IDE code then, is that Paolo's commit 99723548561 added
> unconditional bdrv_inc/dec_in_flight() calls. I am pretty sure that any
> segfaults that Mark is seeing have the same cause.
>=20
> We do need an in-flight counter even for those requests so that
> blk_drain() works correctly, so just making the calls condition wouldn't
> be right. However, this needs to become a separate counter in
> BlockBackend, and the drain functions must be changed to make use of it.
>=20
> I did post rough patches back then, but they weren't quite ready, and
> since then they have fallen through the cracks.

Will you send a new version of that patch series?

Stefan

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJacGc/AAoJEJykq7OBq3PI+JIH/Rijc4Vz/DnpFwwT5TDRQLWY
0zQnmN5T9GE4917Mtd4CMa1RrtSoWfhOJ0QQwruktPb58yel6cHjwPy9Dow+Kg9c
+soa7k03aChDuIYdofBLYVMD5WPmNi+/N9CoJY4Urywk2Ue7aM3tWqXji0ebBWti
onCbcJtqhcHQiyXhaPfFna5sIubVDUh7Sn/USA1RFLbBMQYDo3ws9DH7O9eEZ7u9
AWJ3/qZCTHqcPTW+sfx/63nevRUDmP5kJ5sYKX8fTF6TDfWVooOp3tZNyRXEcJKp
wu/W+t8VD2xBeNzOePzelHdlLzMcogJDVomj1Px1IZO2zETCLVqu0mSNw/4Fjxo=
=Quu/
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--

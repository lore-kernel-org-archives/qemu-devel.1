Received: from eggs.gnu.org ([2001:4830:134:3::10]:48561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehJ8S-0003xz-Tq
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ehJ8R-0001gQ-Ug
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 12:58:57 -0500
Date: Thu, 1 Feb 2018 17:58:48 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180201175848.GH5578@stefanha-x1.localdomain>
References: <1516633309-20803-1-git-send-email-mark.kanda@oracle.com>
	<20180124113123.GB17193@stefanha-x1.localdomain>
	<20180129154107.GI6141@localhost.localdomain>
	<302cdbe4-e363-b9ee-f40a-cafb080a7a2a@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IbVRjBtIbJdbeK1C"
Content-Disposition: inline
In-Reply-To: <302cdbe4-e363-b9ee-f40a-cafb080a7a2a@oracle.com>
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
To: Mark Kanda <mark.kanda@oracle.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, ameya.more@oracle.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org


--IbVRjBtIbJdbeK1C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 10:13:02AM -0600, Mark Kanda wrote:
>=20
>=20
> On 1/29/2018 9:41 AM, Kevin Wolf wrote:
> > Am 24.01.2018 um 12:31 hat Stefan Hajnoczi geschrieben:
> > > On Mon, Jan 22, 2018 at 09:01:49AM -0600, Mark Kanda wrote:
> > > > Add a BlockDriverState NULL check to virtio_blk_handle_request()
> > > > to prevent a segfault if the drive is forcibly removed using HMP
> > > > 'drive_del' (without performing a hotplug 'device_del' first).
> > > >=20
> > > > Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> > > > Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
> > > > Reviewed-by: Ameya More <ameya.more@oracle.com>
> > > > ---
> > > >   hw/block/virtio-blk.c | 7 +++++++
> > > >   1 file changed, 7 insertions(+)
> > > >=20
> > > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > > index b1532e4..76ddbbf 100644
> > > > --- a/hw/block/virtio-blk.c
> > > > +++ b/hw/block/virtio-blk.c
> > > > @@ -507,6 +507,13 @@ static int virtio_blk_handle_request(VirtIOBlo=
ckReq *req, MultiReqBuffer *mrb)
> > > >           return -1;
> > > >       }
> > > > +    /* If the drive was forcibly removed (e.g. HMP 'drive_del'), t=
he block
> > > > +     * driver state may be NULL and there is nothing left to do. */
> > > > +    if (!blk_bs(req->dev->blk)) {
> > >=20
> > > Adding Markus Armbruster to check my understanding of drive_del:
> > >=20
> > > 1. If id is a node name (e.g. created via blockdev-add) then attempti=
ng
> > >     to remove the root node produces the "Node %s is in use" error.  =
In
> > >     that case this patch isn't needed.
> > >=20
> > > 2. If id is a BlockBackend (e.g. created via -drive) then removing the
> > >     root node is allowed.  The BlockBackend stays in place but blk->r=
oot
> > >     becomes NULL, hence this patch is needed.
> > >=20
> > > Markus: What are the valid use cases for #2?  If blk->bs becomes NULL=
 I
> > > would think a lot more code beyond virtio-blk can segfault.
> >=20
> > blk->root =3D NULL is completely normal, it is what happens with remova=
ble
> > media when the drive is empty.
> >=20
> > The problem, which was first reported during the 2.10 RC phase and was
> > worked around in IDE code then, is that Paolo's commit 99723548561 added
> > unconditional bdrv_inc/dec_in_flight() calls. I am pretty sure that any
> > segfaults that Mark is seeing have the same cause.
>=20
> That's correct. The segfault I encountered was the bdrv_inc_in_flight() c=
all
> in blk_aio_prwv().

I think we should aim to fix the root cause for QEMU 2.12.  blk_*() APIs
are supposed to return an error when blk->root is NULL but the
blk_aio_*() ones currently crash.

If that's not possible then this patch can be merged as a workaround for
2.12 close to the release date.

Stefan

--IbVRjBtIbJdbeK1C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJac1VYAAoJEJykq7OBq3PI4WQH/jXhUtICh4GPyw9eyJnfd83q
TXiRyW1BZTZo9m9i32OLNG9xrlMlSFnO/lZgqpSMjs2Kay13qhAhGtVW9Jjh1ZaU
dXIuliqB4raslhbtFTAHDGGKP5oheijMRUTDHDPjRMZTbsfCWBFjvGTYhnNP7O7x
hZKuUnrMJWdqiovAMaRpIc2/2W+q3j/b+q4i6G2IhVhLU0TOaQbwGj0W3+BFypDV
bDfkszqVBLqQqF3Il36zPx/aZpSKL5ceF7jGaVoQs72XXT2+6Vb3ujAaDmToui1J
Gj83MUPcuAYv8LOY5oaeLTV/WUHXXFVkr0y1w+eyt7BBv/Sspmm/WQ6Df0VDDBY=
=/6GX
-----END PGP SIGNATURE-----

--IbVRjBtIbJdbeK1C--

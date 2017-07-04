Received: from eggs.gnu.org ([2001:4830:134:3::10]:60168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSLXa-00079I-Ba
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSLXY-0001Xy-SD
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 06:58:46 -0400
Date: Tue, 4 Jul 2017 20:57:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170704105755.GE2180@umbus.fritz.box>
References: <149909367669.21100.17690903693542179077.stgit@bahia.lan>
	<69bd5d32-3f59-b28a-38e8-25952fecee10@linux.vnet.ibm.com>
	<20170704094252.7dc1cac5@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline
In-Reply-To: <20170704094252.7dc1cac5@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: fix memory hotplug
 error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 09:42:52AM +0200, Greg Kurz wrote:
> On Mon, 3 Jul 2017 14:03:07 -0300
> Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> wrote:
>=20
> > On 07/03/2017 11:54 AM, Greg Kurz wrote:
> > > QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
> > > Let's propagate the error instead, like it is done everywhere else
> > > where spapr_drc_attach() is called.
> > >
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > > Changes in v2: - added rollback code
> > > ---
> > >   hw/ppc/spapr.c |   26 ++++++++++++++++++++++----
> > >   1 file changed, 22 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 70b3fd374e2b..ba8f57a5a054 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, ui=
nt64_t addr_start, uint64_t size,
> > >       int i, fdt_offset, fdt_size;
> > >       void *fdt;
> > >       uint64_t addr =3D addr_start;
> > > +    Error *local_err =3D NULL;
> > >
> > >       for (i =3D 0; i < nr_lmbs; i++) {
> > >           drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> > > @@ -2611,7 +2612,18 @@ static void spapr_add_lmbs(DeviceState *dev, u=
int64_t addr_start, uint64_t size,
> > >           fdt_offset =3D spapr_populate_memory_node(fdt, node, addr,
> > >                                                   SPAPR_MEMORY_BLOCK_=
SIZE);
> > >
> > > -        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
> > > +        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
> > > +        if (local_err) {
> > > +            while (addr > addr_start) {
> > > +                addr -=3D SPAPR_MEMORY_BLOCK_SIZE;
> > > +                drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
> > > +                                      addr / SPAPR_MEMORY_BLOCK_SIZE=
);
> > > +                spapr_drc_detach(drc, dev, NULL); =20
> >=20
> > Question: why pass NULL instead of '&local_err' in detach() ?
>=20
> local_err already contains the error returned by spapr_drc_attach(), it
> cannot be used anymore.
>=20
> > Can we ignore any
> > any error that happens in detach() because you're propagating the=20
> > local_err set
> > in spapr_drc_attach() already?
>=20
> This is a rollback path: the best we can do is to try to undo the
> already attached DRCs...

Yeah, this is basically the classic exception-during-destructor
problem.  Dealing with an error condition while in the middle of
rolling back another error can get really messy.

> > ps: I am aware that ATM detach() does not propagate anything to the err=
p=20
> > being
> > passed. I don't think it's wise to write new code based on this=20
> > assumption though.
> >=20
>=20
> ... and indeed detach() cannot fail with the current code base. :)

> David was even planning to drop the errp argument in the "spapr:
> Refactor spapr_drc_detach()" patch.

Yeah, but as you pointed out in comments on that patch, that's
probably not a good idea.  Except.. then I looked deeper still and the
story gets more complex again.  I'll revisit that when I respin those
DRC patches.

> Otherwise, maybe pass &error_abort since failing to rollback is
> likely to be a bug ?

Yeah, I think the only sane options here are either to ignore (second
order) errors, or abort.

My usual inclination would be to abort, but I'm a bit concerned that
provides a means by which the guest can crash qemu.  I'm going to
apply the patch as is for now, since I'm pretty confident that it
makes things better than they weren.  I hope we can continue to
improve the detach error handling as a follow up.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZW3SxAAoJEGw4ysog2bOSQw4P+wfICIXTt9+18dS3RirYoSSG
nQUQWpgbHZL75qN2KjadtU81/igg+W6JpWqu/4RVhU31ZQcoHtrRrEk2zF5gv81/
PmQIH858Z6o3BSbyeEIVK+URT56rxrWAg4egnCKvz0leZoIkvkWrd7+DAkfVUA2H
I6CuFCAKFnKibXuuo+Wy70IX3Ce7mF4sRNp2cMqWppRJakCeP7NUCUn1YmuU4H26
hmESWaZJPmM3W00xo1+VEGg/NgYa/nUY6qBICkh59vYvUacHHEybIVCRWb4/O2yr
qubJ/TCcakwqnaKado/8IZD8yzdFuOOWkaj4W/Ww7CaeBXav8u4AXey+YdRC4crC
Sd92t/DtZp9Vod5OoyKXDrEn9AUEDia/oVMzBhAKb7hCiylcv8rKd70dfT7mjQE1
pfJXALIPS50tUOhaQFZIYjMTCYerDRuiQzbSYXs3sbyX0Kfzu6uhXOasff9vKkIU
Ooygljv912eia7SM1iMvhGX4Hx0GM0DJTxGhIuSXgKzvqOf6E9ta+nOVKaDxDnJt
PhKzfjuRJ4uJtAi88W6LlIgZmYeIOvbDEpmolP0atTpI854v3KvcdqEa9CgWrCb/
CNWHJOYOMz5NlVxn5irwFisGYNGpQeZRtYCdX/bzDDnStET3z+Zj9AGNkEUStpqc
3BsR1+yzWxKYnoq2dQLI
=krET
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--

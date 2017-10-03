Received: from eggs.gnu.org ([2001:4830:134:3::10]:46373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzGPD-0007vd-Bj
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:10:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzGPC-0003rO-0C
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:10:11 -0400
Date: Tue, 3 Oct 2017 17:07:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171003060757.GF3260@umbus.fritz.box>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
	<150659505839.25889.2018054058894535368.stgit@aravinda>
	<20170929061735.GD7712@umbus.fritz.box>
	<87y3oxen7t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<95142cc0-518a-b7b7-4e56-cfc2adca36ba@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Content-Disposition: inline
In-Reply-To: <95142cc0-518a-b7b7-4e56-cfc2adca36ba@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 1/6] ppc: spapr: Register and
 handle HCALL to receive updated RTAS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, benh@au1.ibm.com, mahesh@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, paulus@samba.org, sam.bobroff@au1.ibm.com


--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2017 at 02:02:19PM +1100, Alexey Kardashevskiy wrote:
> On 29/09/17 21:52, Nikunj A Dadhania wrote:
> > David Gibson <david@gibson.dropbear.id.au> writes:
> >=20
> >> On Thu, Sep 28, 2017 at 04:07:38PM +0530, Aravinda Prasad wrote:
> >>> Receive updates from SLOF about the updated rtas-base.
> >>> A separate patch for SLOF [1] (commit f9a60de3) adds
> >>> functionality to invoke a private HCALL whenever OS
> >>> issues instantiate-rtas with a new rtas-base.
> >>>
> >>> This is required as QEMU needs to know the updated rtas-base
> >>> as it allocates error reporting structure in RTAS space upon
> >>> a machine check exception.
> >>>
> >>> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/12038=
6.html
> >>>
> >>> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> >>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >>
> >> Ao I acked this earlier, but I've now realized there might be some
> >> connection between this and discussions taking place elsewhere about
> >> qemu not knowing what SLOF does with the device tree.
> >>
> >> At what point will SLOF call the UPDATE_RTAS hcall?  I'm guessing at
> >> the time of instantiate-rtas, is that right?
> >=20
> > The call happens from
> > arch/powerpc/kernel/prom_init.c:prom_instantiate_rtas() and after that
> > linux kernel makes two entries in the DT
> >=20
> > ....
> >        if (call_prom_ret("call-method", 3, 2, &entry,
> >                           ADDR("instantiate-rtas"),
> >                           rtas_inst, base) !=3D 0
> >             || entry =3D=3D 0) {
> >                 prom_printf(" failed\n");
> >                 return;
> >         }
> >         prom_printf(" done\n");
> >=20
> >         reserve_mem(base, size);
> >=20
> >         val =3D cpu_to_be32(base);
> >         prom_setprop(rtas_node, "/rtas", "linux,rtas-base",
> >                      &val, sizeof(val));
> >         val =3D cpu_to_be32(entry);
> >         prom_setprop(rtas_node, "/rtas", "linux,rtas-entry",
> >                      &val, sizeof(val));
> > ....
> >=20
> > Quiesce is called after this.=20
> >=20
> >> Does SLOF put the RTAS blob address in its internal device tree, or
> >> does it only pass it to the guest via the return parameters from
> >> instantiate-rtas?
> >=20
> > Entry was made to the DT by linux kernel prom_init code, will this be
> > visible to QEMU?
>=20
> With my recent SLOF FDT patch - yes:
>=20
> aik@fstn1-p1:~$ grep rtas dbg.dts
> 	rtas {
> 		linux,rtas-entry =3D <0x2fff0000>;
> 		linux,rtas-base =3D <0x2fff0000>;
> [...]

Ah.. except.. isn't that relying on the kernel putting the RTAS
address into the device tree before it calls quiesce and kills SLOF?

The SLOF image is bundled in with qemu, so it's ok for us to rely on
its behaviour up to a point.  It's not really ok for us to rely on the
kernel's behaviour here, unless that behaviour is mandated by PAPR,
which this isn't.

So, I think we either need to have *SLOF* update the device tree with
that address at instantiate-rtas time, or we'll need to resurrect
Aravinda's original UPDATE_RTAS hcall.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnTKTsACgkQbDjKyiDZ
s5Kgvg//ePlHAHuIJe943fIksEmXg27C2jW4k/KnaIeMWJlKxjWu5LMyi7O1Q1mq
wgLy7pQJrKXvnJi1edEW+86y+6t2zlzsdYkcFXfFhB873E926rMU7VTDxO2yMlrl
QquJ7JV0JOb3zPatM0s18TohUpcSVLf0ob74HYOP7PUdq6a429qYWeiTD+N07sdU
c4F2m+clYM4bbpU50JxNVjOXAePXoVfKLrjRkHU1HkzRp4tHxAffx48F8pAVdtxf
FPb6FABhQeiSTbEzK+GdgmekgD7dN8hD4/BIdG6Y9V3N3nibm6CYz4gCBhe4MKoq
hZAmUJBa12Pxb1ZnTslE1GiRpFrloucquiGy2/Jl+jBGrcJX8GnOr8MfbIvxBhXg
WwDTy16Lj7HbvV3NTqjEav6nCyvj6hMKfsahGOScUBMiYzBsEsG9ifVPEegp7qEd
NjYxNC1DKqywp6p1CwO3lSewdTBYTf97Zw/vEzvcYA6jZaNk3vhGCWj2l96LGxcV
kmYywN64sIhdNgzTObOnUmeJAzi7gm4OpC8qPma7fAsSVDbjo1zaRhqGMbQ0Azr1
Py9dalMdLbRSGhUDmT/FAACqyuwI+GAkn9/7f0Ozf8dRju/Wd2P4bAG2ftjM5/rr
rQwqYJeAx/6OXZpI22L54FmgBh5HU7hoLckz+LLqW3YedEjKJ/w=
=SpIj
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--

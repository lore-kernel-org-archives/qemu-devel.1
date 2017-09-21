Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duqR9-0003Gk-2r
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duqR7-0006YJ-O3
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:37:55 -0400
Date: Thu, 21 Sep 2017 11:25:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170921012508.GA4998@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170919082020.GT27153@umbus> <20170919084618.GY27153@umbus>
	<98b6f737-a554-1c83-79f9-2c8021e1cf69@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <98b6f737-a554-1c83-79f9-2c8021e1cf69@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/21] Guest exploitation of the
 XIVE interrupt controller (POWER9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2017 at 02:33:37PM +0200, C=E9dric Le Goater wrote:
> On 09/19/2017 10:46 AM, David Gibson wrote:
> > On Tue, Sep 19, 2017 at 06:20:20PM +1000, David Gibson wrote:
> >> On Mon, Sep 11, 2017 at 07:12:14PM +0200, C=E9dric Le Goater wrote:
> >>> On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
> >>> negotiation process determines whether the guest operates with an
> >>> interrupt controller using the XICS legacy model, as found on POWER8,
> >>> or in XIVE exploitation mode, the newer POWER9 interrupt model. This
> >>> patchset is a proposal to add XIVE support in POWER9 sPAPR machine.
> >>>
> >>> Follows a model for the XIVE interrupt controller and support for the
> >>> Hypervisor's calls which are used to configure the interrupt sources
> >>> and the event/notification queues of the guest. The last patch
> >>> integrates XIVE in the sPAPR machine.
> >>>
> >>> Code is here:
> >>
> >>
> >> An overall comment:
> >>
> >> I note in several replies here that I think the way XICS objects are
> >> re-used for XIVE is really ugly, and I think it will make future
> >> maintenance pretty painful.
>=20
> I agree. That was one way to identify what we need for migration=20
> compatibility and CAS reset.  =20
>=20
> >> I'm thinking maybe trying to support the CAS negotiation of interrupt
> >> controller from day 1 is warping the design.  A better approach might
> >> be first to implement XIVE only when given a specific machine option -
> >> guest gets one or the other and can't negotiate.
>=20
> ok.=20
>=20
> CAS is not the most complex problem, we mostly need to share=20
> the ICSIRQState array and the source offset. migration from older
> machine is a problem.

Uh.. what?  Migration from an older machine isn't a thing.  We can
migrate from an older qemu, but the machine type (and version) has to
be identical at each end.  That's *why* we keep around the older
machine types on newer qemus.

> We are doomed to keep the existing XICS
> framework available.
>=20
> >> That should allow a more natural XIVE design to emerge, *then* we can
> >> look at what's necessary to make boot-time negotiation possible.
> >=20
> > Actually, it just occurred to me that we might be making life hard for
> > ourselves by trying to actually switch between full XICS and XIVE
> > models.  Coudln't we have new machine types always construct the XIVE
> > infrastructure,=20
>=20
> yes.
>=20
> > but then implement the XICS RTAS and hcalls in terms of the XIVE virtua=
l=20
> > hardware.
>=20
> ok but migration will not be supported.

Right, this would only be for newer machine types, and you can never
migrate between different machine types.

> > Since something more or less equivalent
> > has already been done in both OPAL and the host kernel, I'm guessing
> > this shouldn't be too hard at this point.
>=20
> Indeed that is how it is working currently on P9 kvm guests. hcalls are
> implemented on top of XIVE native.
>=20
> Thanks,
>=20
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnDFPIACgkQbDjKyiDZ
s5KFXw/+IvKiV1BEbQy0D/FqEGiWE7HYIYznugc7PjarLSk/RoFs83gmsKxX1LoA
6ZMHH4czAgtNP6rWZ6K445Wz7Vk5tXWV1EMLT4AlvIQKV3S5UKGjHsjQYSBUe7d7
bC1AR4v1qlOJIBd56cLw3xIToT7t656blVtEHh0SMOfqzSQ8COuWqaLXiYoP0F9d
9iPo2RdUEfa6R4VG0FoOSAO4Gg7MLF9AetwU48t3dmiPV+rs1nIhKScgaaPpO9AU
aOVQrxyZiMlDjtAwTBbnQFsrRAC+pcJQ0bQC2fbc+CkZFVrR9LmgSfX0wnpnELY7
zCvZ564ECXLqTM9pbfRU5pG80niH4LktQkYcvnQYu9E/p2TKjJraGG0M9lzLWjvZ
mISdD9EvFdrO//vLQu0M+fQcUkQCa2Xsd4MTwbEsiq3YGqOGJcRJeG9ETOTH4xMy
dvXj+XAXVawnSfaZ1shA73CBhMPr3/GJl/BqfgoDk4RGiSXjJFUfw8ory4Ib3vrd
M8+kML6jNsXZE085+Wz/+HJEWdZd4bhmext6Qsz+5wsNEFm2Hjq5ic8Nrm13Cox4
f9GFLB8WHK9SrcGR1120Y6M8ROzPLNA79dISQ62I3l7c6/S0pVUgCoouJrUobMPh
CXddZ3Wg9Yg83AbSQLJl48L2/3X9KgEe3GzcSMpBOIOXZ+7q9Bo=
=Ugz8
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

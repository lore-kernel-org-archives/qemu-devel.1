Received: from eggs.gnu.org ([2001:4830:134:3::10]:35044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV9qi-0001AT-Cy
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV9qg-0002di-UM
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 02:10:40 -0400
Date: Tue, 19 Jun 2018 16:10:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619061025.GE11674@umbus.fritz.box>
References: <152932479544.500483.1342368406182952616.stgit@bahia.lan>
	<20180619000905.GE25461@umbus.fritz.box>
	<20180619074124.5a9968a0@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <20180619074124.5a9968a0@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/2] spapr_cpu_core: migrate per-CPU data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 07:41:24AM +0200, Greg Kurz wrote:
> On Tue, 19 Jun 2018 10:09:05 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Jun 18, 2018 at 02:26:35PM +0200, Greg Kurz wrote:
> > > A per-CPU machine data pointer was recently added to PowerPCCPU. The
> > > motivation is to to hide platform specific details from the core CPU
> > > code. This per-CPU data can hold state which is revelant to the guest
> > > though, eg, Virtual Processor Areas, and we whould migrate this state.
> > >=20
> > > This patch adds the plumbing so that we can migrate the per-CPU data
> > > for PAPR guests. We only do this for newer machine types for the sake
> > > of backword compatibility. No state is migrated for the moment: the
> > > vmstate_spapr_cpu_state structure will be populated by subsequent
> > > patches.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > Applied, though I fixed some spelling and spacing errors along the way.
> >=20
>=20
> Thanks but I now realize I have a nit...
>=20
> > > ---
> > >  hw/ppc/spapr.c                  |    5 +++++
> > >  hw/ppc/spapr_cpu_core.c         |   27 +++++++++++++++++++++++----
> > >  include/hw/ppc/spapr_cpu_core.h |    1 +
> > >  3 files changed, 29 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index db0fb385d4e0..37db3e8bc6ca 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -4116,6 +4116,11 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
> > >      {                                                               =
   \
> > >          .driver =3D TYPE_POWERPC_CPU,                               =
     \
> > >          .property =3D "pre-3.0-migration",                          =
    \
> > > +        .value    =3D "on",                                         =
     \
> > > +            },                                                      =
   \
> > > +    {                                                               =
   \
> > > +        .driver =3D TYPE_SPAPR_CPU_CORE,                            =
     \
> > > +        .property =3D "pre-3.0-migration",                          =
     \
> > >          .value    =3D "on",                                         =
     \
> > >      },
> > > =20
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index aef3be33a3bb..96d1dfad00e1 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -129,6 +129,15 @@ static void spapr_cpu_core_unrealize(DeviceState=
 *dev, Error **errp)
> > >      g_free(sc->threads);
> > >  }
> > > =20
> > > +static const VMStateDescription vmstate_spapr_cpu_state =3D {
> > > +    .name =3D "spapr_cpu",
> > > +    .version_id =3D 1,
> > > +    .minimum_version_id =3D 1,
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_END_OF_LIST()
> > > +    },
> > > +};
> > > +
> > >  static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
> > >                                 Error **errp)
> > >  {
> > > @@ -164,7 +173,8 @@ error:
> > >      error_propagate(errp, local_err);
> > >  }
> > > =20
> > > -static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i, Error =
**errp)
> > > +static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore *sc, int i,
> > > +                                     sPAPRMachineState *spapr, Error=
 **errp)
>=20
> ... here. This spapr argument comes from a previous version. I didn't nee=
d it
> in the end, but I forgot to remove it :(
>=20
> Do you want me to resend or can you fix that in your tree ?

I've fixed it up in my tree.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsonk8ACgkQbDjKyiDZ
s5IaHhAAoaKWlxTPa8uIr0sxmn6DYZHLsQ274W2O3fcWoGuExWVNiZnFtKTSJUqs
YwkBTbB1L8vslsabKONuciD5CK/OXNbgl6e+QhoU+b4zqJZMVVc/dpcMS8kRCaYt
UDrz4f9mzgFvNSU+CUHR9FlfDgceJaz88j5E+lHVRGhI4OLoga+rQRPDW/BYQCzM
ET67uh9W0a+Ww6fDjjNSXcTuMtLoXe0f1HQTcW1BXV0x2RjIMHURR6PKr+DyuRaY
yKuQsxwK6r8ym97TmaFQ429+9Wj550smMIzx1CjUCsyiE7KWKGmrv1Dsf05xN8iq
ehpU5Ye08Xll1+K8bwuhJrCqxjOBjEU2nxtvQW3ubVWdRk8wU43CJv/XwNkZUE6K
8x95SzavsGVW2SBR03Fagt3UF2umolHL2jeIkc+hmV1J3kbTQVRBcgwc2dFj80Wk
6kVDbN/FeXI8RaKnBxG2EViZc4jl5DDdXX+c9TcYTTkq79C16qkW/rh/khi6zqTU
M++9A34brrY/LDZkj9YUOtgiqdstPYqKX0CIVFwP3lTxGSsKEx1OVN4qxO+DTphg
Y5NEe/bwELwAM0Ha/o0EAZMrIt8pOcdlZ7RunRaKtKqlGIGwB1kTomotLWMCRPrs
eMEIwNM1sFFGwd73zhh6A4CdHJb67BCV4c8RbZfn/cMXk14/atk=
=sdE6
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--

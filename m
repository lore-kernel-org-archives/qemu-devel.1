Received: from eggs.gnu.org ([2001:4830:134:3::10]:48167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCcq9-0002jJ-1T
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCcq7-0004Wp-Se
	for qemu-devel@nongnu.org; Sun, 21 May 2017 22:12:57 -0400
Date: Mon, 22 May 2017 11:26:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522012641.GE30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518993198.24289.7946457258780782948.stgit@bahia.lan>
	<20170520064509.GD30246@umbus.fritz.box>
	<20170521190333.49404422@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
Content-Disposition: inline
In-Reply-To: <20170521190333.49404422@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] spapr: fix error reporting in
 xics_system_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2017 at 07:03:33PM +0200, Greg Kurz wrote:
> On Sat, 20 May 2017 16:45:09 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, May 19, 2017 at 12:32:12PM +0200, Greg Kurz wrote:
> > > If the user explicitely asked for kernel-irqchip support and "xics-kv=
m"
> > > initialization fails, we shouldn't fallback to emulated "xics" as we
> > > do now. It is also awkward to print an error message when we have an
> > > errp pointer argument.
> > >=20
> > > Let's use the errp argument to report the error and let the caller de=
cide.
> > > This simplifies the code as we don't need a local Error * here.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > Concept looks good, but..
> >=20
> > > ---
> > > v2: - total rewrite
> > > ---
> > >  hw/ppc/spapr.c |   13 ++++++-------
> > >  1 file changed, 6 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 91f7434861a8..75e298b4c6be 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -128,18 +128,14 @@ static void xics_system_init(MachineState *mach=
ine, int nr_irqs, Error **errp)
> > >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> > > =20
> > >      if (kvm_enabled()) {
> > > -        Error *err =3D NULL;
> > > -
> > >          if (machine_kernel_irqchip_allowed(machine) &&
> > >              !xics_kvm_init(spapr, errp)) {
> > >              spapr->icp_type =3D TYPE_KVM_ICP;
> > > -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_=
irqs, &err);
> > > +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_=
irqs, errp); =20
> >=20
> > I believe there are reasons you're not supposed to just pass an errp
> > through to a subordinate function.  Instead you're supposed to have a
> > local Error * and use error_propagate().
> >=20
>=20
> You only need to have a local Error * if it is used to check the return s=
tatus
> of the function (ie, you cannot check *errp because errp could be NULL) as
> described in error.h. This isn't the case here but...

Fair point; patch applied to ppc-for-2.10.

>=20
> > >          }
> > >          if (machine_kernel_irqchip_required(machine) && !spapr->ics)=
 {
> > > -            error_reportf_err(err,
> > > -                              "kernel_irqchip requested but unavaila=
ble: ");
> > > -        } else {
> > > -            error_free(err);
> > > +            error_prepend(errp, "kernel_irqchip requested but unavai=
lable: ");
> > > +            return;
> > >          }
> > >      }
> > > =20
> > > @@ -147,6 +143,9 @@ static void xics_system_init(MachineState *machin=
e, int nr_irqs, Error **errp)
> > >          xics_spapr_init(spapr);
> > >          spapr->icp_type =3D TYPE_ICP;
> > >          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_i=
rqs, errp);
> > > +        if (!spapr->ics) { =20
> >=20
> > It would also be more standard to check the returned error, rather
> > than the other result.
> >=20
>=20
> ... if you prefer to use a local Error *, I'll gladly do that. :)
>=20
> > > +            return;
> > > +        }
> > >      }
> > >  }
> > > =20
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIj5OAAoJEGw4ysog2bOS89YP/07Fl5TqOCbm+lJGrty9RHZc
bj9Yqm2+pRou/j7vvMGO9tdn4l17/ZgBGaAfdbyN0yXDz8HnTexveKTJqEHMX3Aw
64uwF21cllDVymbrwDFb9zLURsp90a6GIDrJZh8WZQ8JaQ6S3AmgMuitQZeGwISh
zoznqOA2oZV2lByZr5N1TO7tqUs7wQLJpvOukqxMgsOIistweyBs4isgNFv6objY
b16DqWKOIDd/R+THlrr5uc+okOVR36YAKSy8H7snvA3MvAXtfjZ7fDaGTfMQB1e9
HC7WpU5y4GCCKpeIuk8mgX3P7dkoXxh/SV3ZCNFWTqQN4WPZiSN4RMl6C5zQ1FVb
12P5miczQqYVt0TQmKqc1vthO9k+93pflNZ4k2nq9Hd3uWp+vbmHzf/tSrM2agNu
bVV2yaj0XsDjEUvogHurYxb1Li8yugLhUWjG+xKX7pTLRRg6QVt9+1XApJl8vqUq
nk382kGuFMzAPyUsX7pZDmiAxXvxj7idIeSVmt0TJQo4hWph0z0Fv/VX96Zr2R0g
z4MmgUx/RCgzv60Am7PX83MoYP8kJC/wW2Z0q0+EPqspuz5tu+xuKDc+d2LE+2BO
nGXxbDOdPtK3TKQTh/EkqAjlncvfKrZ9flRhZQzA42eO1InEZUx7cPW8XxviT4xb
+k22jQ8SPrBUd3naLuvj
=QSVL
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSB3x-0002Lo-DJ
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 20:24:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSB3v-0001NU-FT
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 20:24:16 -0500
Date: Thu, 29 Nov 2018 12:02:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129010248.GN2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-13-clg@kaod.org>
	<20181128025714.GW2251@umbus.fritz.box>
	<20181128103551.42397998@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AO7xfgsPaN7qs9GL"
Content-Disposition: inline
In-Reply-To: <20181128103551.42397998@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 12/36] spapr: initialize VSMT
 before initializing the IRQ backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--AO7xfgsPaN7qs9GL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 10:35:51AM +0100, Greg Kurz wrote:
> On Wed, 28 Nov 2018 13:57:14 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Nov 16, 2018 at 11:57:05AM +0100, C=E9dric Le Goater wrote:
> > > We will need to use xics_max_server_number() to create the sPAPRXive
> > > object modeling the interrupt controller of the machine which is
> > > created before the CPUs.
> > >=20
> > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org> =20
> >=20
> > My only concern here is that this moves the spapr_set_vsmt_mode()
> > before some of the sanity checks in spapr_init_cpus().  Are we certain
> > there are no edge cases that could cause badness?
> >=20
>=20
> The early checks in spapr_init_cpus() filter out topologies that would
> result in partially filled cores. They're only related to the rest of
> the code that creates the boot CPUs. Before commit 1a5008fc17,
> spapr_set_vsmt_mode() was even being called before spapr_init_cpus().
> The rationale to move it there was to ensure it is called before the
> first user of spapr->vsmt, which happens to be a call to
> xics_max_server_number().

Ok.

> Now that xics_max_server_number() needs to be called even earlier, I thin=
k a
> better change is to have xics_max_server_number() to call spapr_set_vsmt_=
mode()
> if spapr->vsmt isn't set.

I'd rather not do that, but instead move it statically to where it
needs to be.  That sort of lazy/on-demand initialization can result in
really confusing behaviours depending on when a seemingly innocuous
data-returning function is called, so I consider it a code smell.

>=20
> > > ---
> > >  hw/ppc/spapr.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 7afd1a175bf2..50cb9f9f4a02 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2466,11 +2466,6 @@ static void spapr_init_cpus(sPAPRMachineState =
*spapr)
> > >          boot_cores_nr =3D possible_cpus->len;
> > >      }
> > > =20
> > > -    /* VSMT must be set in order to be able to compute VCPU ids, ie =
to
> > > -     * call xics_max_server_number() or spapr_vcpu_id().
> > > -     */
> > > -    spapr_set_vsmt_mode(spapr, &error_fatal);
> > > -
> > >      if (smc->pre_2_10_has_unused_icps) {
> > >          int i;
> > > =20
> > > @@ -2593,6 +2588,11 @@ static void spapr_machine_init(MachineState *m=
achine)
> > >      /* Setup a load limit for the ramdisk leaving room for SLOF and =
FDT */
> > >      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> > > =20
> > > +    /* VSMT must be set in order to be able to compute VCPU ids, ie =
to
> > > +     * call xics_max_server_number() or spapr_vcpu_id().
> > > +     */
> > > +    spapr_set_vsmt_mode(spapr, &error_fatal);
> > > +
> > >      /* Set up Interrupt Controller before we create the VCPUs */
> > >      smc->irq->init(spapr, &error_fatal);
> > >   =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AO7xfgsPaN7qs9GL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv/OrgACgkQbDjKyiDZ
s5KBiBAA2UBuEfgUwy2BytS580YiXUEML25R8V3pJ5xobyC8k9OSjRtI1JCYlHKC
6fJKspUwI+6gOws6niHrosTu/j5axYfzm+xuQqwlZROxR+TiqpRPIbiuxuVZOD1w
I9rQE30wzJqPpVY3UV6JY8hrJpDqbAHY3I0TMHAhwwRfwg0mH4Re4w5lkYPOJRO7
oC6RYdUM5eAQIpCKi2DAOY7ztGkibKVfnJcV9A1kZsQh/SC3qSwa559NJeaUpA+D
jNsgUg6fGQk6yM+2M5KfMRFy5dp5vvAMBbxUtps9ATbj3xCkOODXrEKhyL59EE+b
fgb9Oa+TTsfvibxE9gwW8ohu/WhAMG01twTJL1cKtJf3kg+wimlZejJQclGG20Ue
kYPoUac5XSDS11ADC7Ps5iciDlCQ96fkXIVQZln0wGaJ3zcOO0SYslB42+LowXmO
Ecjth7ZFG5Ck+clUfIPEV/FbmqRBquVHja3MkpipGZ93U5n2EoZUhJFiQsGpuOZz
dJCyg/XKQskHbzhkTF4bGZwTRKaqCDHVtz3KsUJzX4OLmaI9d2o4enPZ2a/9xy5L
cVsihimDOJPEOGbA1MVoazVbYxVNkIG5Kz6593VPxVGeAYYuUE+22DpZmMMkDmTM
7ox1Ywd+N61d1nqqHU/hRgAg/FjPFLhf3aJbr1A6vgGS9mWppsU=
=MHF4
-----END PGP SIGNATURE-----

--AO7xfgsPaN7qs9GL--

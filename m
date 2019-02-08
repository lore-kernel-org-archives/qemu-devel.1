Received: from eggs.gnu.org ([209.51.188.92]:40322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gs4dA-00064c-Li
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gs4cx-0006tB-9v
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:47:31 -0500
Date: Fri, 8 Feb 2019 22:33:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190208113336.GA7230@umbus.fritz.box>
References: <154956051753.218871.1505640778712413716.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190207230647.GC518@umbus.fritz.box>
	<20190208121503.38e8c9ae@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20190208121503.38e8c9ae@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr_pci: Fix interrupt leak
 in rtas_ibm_change_msi() error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-stable@nongnu.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2019 at 12:15:03PM +0100, Greg Kurz wrote:
> On Fri, 8 Feb 2019 10:06:47 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Feb 07, 2019 at 06:28:37PM +0100, Greg Kurz wrote:
> > > Now that IRQ allocation has been split in two (first allocate IRQ num=
bers,
> > > then claim them), if the claiming fails, we must release the IRQs.
> > >=20
> > > Fixes: 4fe75a8ccd80 "spapr: split the IRQ allocation sequence"
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > Applied to ppc-for-4.0, thanks.
> >=20
>=20
> Oops I've just realized there's an off-by-one error...
>=20
> > > ---
> > >  hw/ppc/spapr_pci.c |    6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index 41d81f4a8500..6fe3c10c8d4c 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -393,6 +393,12 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu,=
 sPAPRMachineState *spapr,
> > >      for (i =3D 0; i < req_num; i++) {
> > >          spapr_irq_claim(spapr, irq + i, false, &err);
> > >          if (err) {
> > > +            if (i) {
> > > +                spapr_irq_free(spapr, irq, i + 1);
>=20
> ... here. It should actually be:
>=20
> +                spapr_irq_free(spapr, irq, i);
>=20
> Can you fix this in your tree or should I post a v2 ?

Fixed up inline.

>=20
> > > +            }
> > > +            if (!smc->legacy_irq_allocation) {
> > > +                spapr_irq_msi_free(spapr, irq, req_num);
> > > +            }
> > >              error_reportf_err(err, "Can't allocate MSIs for device %=
x: ",
> > >                                config_addr);
> > >              rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > >  =20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxdaQ4ACgkQbDjKyiDZ
s5JDlA//XAZ6s4JE5c/nN99N+BGL/zRn+iS/tOSPY9c70Y/CaoNrks/FIldlB3QO
ABshnkRRvnd7PLIpIOUXIKexBcQUspjIK339c080U/W05F8FLW8czc7ZRuygZgNC
BAN5qgd2jD+Zc9gScTMcrJDG7ZKcQjHBQUCE/pq+aJRa7r2j+sRac1zVpRTp0+Yg
5ZWmpg2s30vNo/IwG0ZDtNwpBWLhiyViktrbHhNqjWr2RAgyN8ZO392fA05UFRVC
HLHJfvsO4h51j/h4Cnbw+Ta5YLgBiBLx126f8/sO6/TVHJT+tN6yZPbyL1dryxFy
zg7/FXusZrZBVvN9txz0hfndMdN1U0RHMSB6KvcoiF3jv6LdDAAqFqe+IYPJknNF
mV1XBOZpwZROUHJEhfsU8myNym/CHV/Z6CtbWJwsifyXXQzMICZkvbxwjQdsoS+I
Xc5+aO2PagOYnofdGQ3aPlu5wZPhKk2Y31HIQfHrkVePkRoPfe0QctKQ1PkBzcd8
EoZgy88Ksads0j2lXxUJrTec4ZrsiAJFgVy4yL8UtdHAvYIBSPiIWxnjiRu1+ZO8
tD92jOeFCGNu1nE3pN4uY4vSnk9oLx5C1oMEBBdK8OLR0aTUnnt/MER6V9zQhWio
ARb+lBXHmCFqZwPrVmHZM7VBOLTc8lJUOvY9fuZ8gkfBZ1u7fcU=
=fYKw
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHpS5-0005Ai-Rb
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHpS4-0005QN-NJ
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:13:53 -0500
Date: Thu, 23 Nov 2017 22:13:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171123111309.GE22454@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-6-clg@kaod.org>
	<20171114104224.63ed5e87@bahia.lan>
	<20171117045053.GB26448@umbus.fritz.box>
	<20171120130742.7410a80b@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline
In-Reply-To: <20171120130742.7410a80b@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 05/11] spapr: introduce an IRQ
 allocator using a bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 01:07:42PM +0100, Greg Kurz wrote:
> On Fri, 17 Nov 2017 15:50:53 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Nov 14, 2017 at 10:42:24AM +0100, Greg Kurz wrote:
> > > On Fri, 10 Nov 2017 15:20:11 +0000
> > > C=E9dric Le Goater <clg@kaod.org> wrote:
> > >  =20
> > > > Let's define a new set of XICSFabric IRQ operations for the latest
> > > > pseries machine. These simply use a a bitmap 'irq_map' as a IRQ num=
ber
> > > > allocator.
> > > >=20
> > > > The previous pseries machines keep the old set of IRQ operations us=
ing
> > > > the ICSIRQState array.
> > > >=20
> > > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > > ---
> > > >=20
> > > >  Changes since v2 :
> > > >=20
> > > >  - introduced a second set of XICSFabric IRQ operations for older
> > > >    pseries machines
> > > >=20
> > > >  hw/ppc/spapr.c         | 76 ++++++++++++++++++++++++++++++++++++++=
++++++++----
> > > >  include/hw/ppc/spapr.h |  3 ++
> > > >  2 files changed, 74 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index 4bdceb45a14f..4ef0b73559ca 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -1681,6 +1681,22 @@ static const VMStateDescription vmstate_spap=
r_patb_entry =3D {
> > > >      },
> > > >  };
> > > > =20
> > > > +static bool spapr_irq_map_needed(void *opaque)
> > > > +{
> > > > +    return true; =20
> > >=20
> > > I see that the next patch adds some code to avoid sending the
> > > bitmap if it doesn't contain state, but I guess you should also
> > > explicitly have this function to return false for older machine
> > > types (see remark below). =20
> >=20
> > I don't see that you should need to migrate this at all.  The machine
> > needs to reliably allocate the same interrupts each time, and that
> > means source and dest should have the same allocations without
> > migrating data.
> >=20
>=20
> Is this true for MSIs ? With the current code, the guest can change
> the allocation of such interrupts with the ibm,rtas-change-msi RTAS
> call. How can the dest know about that ?

Yeah, true.  The MSIs really are dynamically allocated by the guest
and so will need to have information migrated.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloWrUQACgkQbDjKyiDZ
s5Lulg//eta/uv9BZpYqkCrU7s3m5r7dDpTyrjTKZBN857ASBYElqdcx4x8XT/OQ
xvv0Q7JpCuSMqsND2hSS9OG1IrId2/SQVqhBDCtP7axd1VywPCOcBGoLp9kQ4MTM
3eAzZH7EAr+G6QsmdSSudHbiUHmuh9eZdv4kGN084zyGQ/xYjRtNejheyqKtMPfJ
UL65R15cji8axe4LrJBBTvoia7AfgyQQ19+dLD5KQuSoa7P6Doq/hP7gGMfEdUBq
cO5lmBxUKeTZ3bRX/X0N7fRXK44dxtH5/YIeAsBEyRXSSF6O/i4TIow5Q6KmZcXA
Q7lLY2TWMzEFvEjYP0Es8hAFRp3/FJFg9AcrX8TmMyiFx66q2KN8Bfkp3X1WC9Y3
TJRPvDJmKmbQ4FO3SlVL75+MPuNzxZ3V4JAFoL4i1bC+7NmtIj8kjL1213nPTbHI
pnSRxMyVOfIj71kO7ZehcTfA5sjVvr44VY9qO5ryGbbEF2COlgbUBSWsjOeCSf1m
Qme9mOR12dUYb8BAQdOH1aNbF1CNwR4JleJJRZwk6/CI5Y624yTnoKcv283vR6FO
aEJBRFaKzQjhno3bwF6fi3eWxUSoC8l4I2WfWj7upgi6KEY8XRYSPfWsFWVlz9S9
ag/KeSy0IpuxYtC5bqpZ7hOJfzqgRsMoxd5obrzA2V4E4kETw7k=
=U+LI
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--

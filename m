Received: from eggs.gnu.org ([2001:4830:134:3::10]:50075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE3mC-0003E3-Tv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE3m9-0000Rt-O3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 22:15:20 -0400
Date: Thu, 3 May 2018 11:34:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503013432.GA3267@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<20180419062917.31486-2-david@gibson.dropbear.id.au>
	<20180502210637.GA27693@kermit-br-ibm-com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20180502210637.GA27693@kermit-br-ibm-com>
Subject: Re: [Qemu-devel] [RFC for-2.13 1/7] spapr: Maximum (HPT) pagesize
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: groug@kaod.org, abologna@redhat.com, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 06:06:38PM -0300, Murilo Opsfelder Araujo wrote:
> On Thu, Apr 19, 2018 at 04:29:11PM +1000, David Gibson wrote:
> > The way the POWER Hash Page Table (HPT) MMU is virtualized by KVM HV me=
ans
> > that every page that the guest puts in the pagetables must be truly
> > physically contiguous, not just GPA-contiguous.  In effect this means t=
hat
> > an HPT guest can't use any pagesizes greater than the host page size us=
ed
> > to back its memory.
> >=20
> > At present we handle this by changing what we advertise to the guest ba=
sed
> > on the backing pagesizes.  This is pretty bad, because it means the gue=
st
> > sees a different environment depending on what should be host configura=
tion
> > details.
> >=20
> > As a start on fixing this, we add a new capability parameter to the pse=
ries
> > machine type which gives the maximum allowed pagesizes for an HPT guest=
 (as
> > a shift).  For now we just create and validate the parameter without ma=
king
> > it do anything.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr.c         |  1 +
> >  hw/ppc/spapr_caps.c    | 53 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  include/hw/ppc/spapr.h |  4 +++-
> >  3 files changed, 57 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index bdf72e1e89..36e41aff71 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3876,6 +3876,7 @@ static void spapr_machine_class_init(ObjectClass =
*oc, void *data)
> >      smc->default_caps.caps[SPAPR_CAP_CFPC] =3D SPAPR_CAP_BROKEN;
> >      smc->default_caps.caps[SPAPR_CAP_SBBC] =3D SPAPR_CAP_BROKEN;
> >      smc->default_caps.caps[SPAPR_CAP_IBS] =3D SPAPR_CAP_BROKEN;
> > +    smc->default_caps.caps[SPAPR_CAP_HPT_MPS] =3D 16; /* Allow 64kiB p=
ages */
> >      spapr_caps_add_properties(smc, &error_abort);
> >  }
> > =20
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index 531e145114..cbc41f5b20 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> > @@ -27,6 +27,7 @@
> >  #include "qapi/visitor.h"
> >  #include "sysemu/hw_accel.h"
> >  #include "target/ppc/cpu.h"
> > +#include "target/ppc/mmu-hash64.h"
> >  #include "cpu-models.h"
> >  #include "kvm_ppc.h"
> > =20
> > @@ -142,6 +143,39 @@ out:
> >      g_free(val);
> >  }
> > =20
> > +static void spapr_cap_get_int(Object *obj, Visitor *v, const char *nam=
e,
> > +                               void *opaque, Error **errp)
> > +{
> > +    sPAPRCapabilityInfo *cap =3D opaque;
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +    int64_t value =3D spapr_get_cap(spapr, cap->index);
> > +
> > +    visit_type_int(v, name, &value, errp);
> > +}
> > +
> > +static void spapr_cap_set_int(Object *obj, Visitor *v, const char *nam=
e,
> > +                               void *opaque, Error **errp)
> > +{
> > +    sPAPRCapabilityInfo *cap =3D opaque;
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +    int64_t value;
> > +    Error *local_err =3D NULL;
> > +
> > +    visit_type_int(v, name, &value, &local_err);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    if ((value < 0) || (value > 255)) {
> > +        error_setg(errp, "Value for %s out of range (0..255)", name);
> > +        return;
> > +    }
> > +
> > +    spapr->cmd_line_caps[cap->index] =3D true;
> > +    spapr->eff.caps[cap->index] =3D value;
> > +}
> > +
>=20
> Hi, David.
>=20
> Do you think uint8_t would fit better for spapr_[gs]et_int() functions?
>=20
> Perhaps renaming them to spapr_[gs]set_int8() and calling
> visit_type_int8() instead.

Yeah, that's a good idea.  Using visit_type_uint8 means we don't need
to implement our own clamping.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqZyYACgkQbDjKyiDZ
s5JVEQ//TPSfthi1d4K66B2lWH8myUYHISxp9wtFVKkn4IJ+7wr2zXnBoQJahQ4O
j70+LySZGi+OokGMZlXIYV7kMmKnDcCxFiXC61sIErkuFG4M9oOAmF2DE5Orp9j0
mpcX67YvFntqLlzC2BlcpoSZ9bdiNO0G69PuzqPadsvh9bothJs+8uJ1MlVrtFZw
JEz6e1ge/GTiPwKLqgLLQh8ymXVOYUC11vqVov3uB+I564sXm2wesLWSyCFyJBgz
QsD1baKD/3tCXfwiXS3lWPopmeN+whew7T/Ev8VkKwsqi02hk5s68ch9jKFoqvuS
YCXl9KwCbgQqAATQtshQl48VVg84oMNLbuZ5MJZPqSLlyVVHspWNe8iRVU3pFcvU
F70+suKUZWKzZiUk3bw5jIXdy4O0wZ6ERf3oH9Ra1IuC/RO9HC8ObsWWFVW68CfR
wFpW9q+nVoDaQkUmcMMriGa/75A+jihz4zoR4JVxaq+HgB6iIgbUH+f/RKZT31cX
r+XiL4DYlPAsEBKnS44UQKa0AzNfBWj09dQywryRc7FXhA3DGC1u1vYH4MKnPMId
6IA8ORsXRx9vsWzPftiNe8fLLKbIvs8dI/535KC8g0zGhoSeilcY8IiFosU1Oa1f
hwlVQaytm4bQYVytVpLJJohE3UU1ES7L/DE7eyTFsR0US443Etg=
=pGzN
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--

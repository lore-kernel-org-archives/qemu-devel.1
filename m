Received: from eggs.gnu.org ([2001:4830:134:3::10]:48410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGOiM-0004jI-BR
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:56:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGOiI-0006rO-FT
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:56:30 -0400
Date: Thu, 1 Jun 2017 17:13:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170601071304.GE13397@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170526052319.28096-4-david@gibson.dropbear.id.au>
	<1496295880.4414.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
Content-Disposition: inline
In-Reply-To: <1496295880.4414.1.camel@gmail.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv4 3/5] pseries: Move CPU
 compatibility property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: groug@kaod.org, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, quintela@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, qemu-ppc@nongnu.org, abologna@redhat.com, sbobroff@redhat.com, dgilbert@redhat.com


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 03:44:40PM +1000, Suraj Jitindar Singh wrote:
> On Fri, 2017-05-26 at 15:23 +1000, David Gibson wrote:
> > Server class POWER CPUs have a "compat" property, which is used to
> > set the
> > backwards compatibility mode for the processor.=A0=A0However, this only
> > makes
> > sense for machine types which don't give the guest access to
> > hypervisor
> > privilege - otherwise the compatibility level is under the guest's
> > control.
> >=20
> > To reflect this, this removes the CPU 'compat' property and instead
> > creates a 'max-cpu-compat' property on the pseries machine.=A0=A0Strict=
ly
> > speaking this breaks compatibility, but AFAIK the 'compat' option was
> > never (directly) used with -device or device_add.
> >=20
> > The option was used with -cpu.=A0=A0So, to maintain compatibility, this
> > patch adds a hack to the cpu option parsing to strip out any compat
> > options supplied with -cpu and set them on the machine property
> > instead of the now deprecated cpu property.
>=20
> Generally looks good, a couple of comments below.
>=20
> Suraj
>=20
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > =A0hw/ppc/spapr.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A06 =
++-
> > =A0hw/ppc/spapr_cpu_core.c=A0=A0=A0=A0=A0|=A0=A056 ++++++++++++++++++++=
+++-
> > =A0hw/ppc/spapr_hcall.c=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A08 ++--
> > =A0include/hw/ppc/spapr.h=A0=A0=A0=A0=A0=A0|=A0=A012 ++++--
> > =A0target/ppc/compat.c=A0=A0=A0=A0=A0=A0=A0=A0=A0| 102
> > ++++++++++++++++++++++++++++++++++++++++++++
> > =A0target/ppc/cpu.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A05 ++-
> > =A0target/ppc/translate_init.c |=A0=A086 +++++++++++-------------------=
----
> > ---
> > =A07 files changed, 202 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index ab3aab1..3c4e88f 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2134,7 +2134,7 @@ static void ppc_spapr_init(MachineState
> > *machine)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0machine->cpu_model =3D kvm_enabled() ? "host=
" : smc-
> > >tcg_default_cpu;
> > =A0=A0=A0=A0=A0}
> > =A0
> > -=A0=A0=A0=A0ppc_cpu_parse_features(machine->cpu_model);
> > +=A0=A0=A0=A0spapr_cpu_parse_features(spapr);
> > =A0
> > =A0=A0=A0=A0=A0spapr_init_cpus(spapr);
> > =A0
> > @@ -2497,6 +2497,10 @@ static void spapr_machine_initfn(Object *obj)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" place of standard EPOW events
> > when possible"
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" (required for memory hot-
> > unplug support)",
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0NULL);
> > +
> > +=A0=A0=A0=A0ppc_compat_add_property(obj, "max-cpu-compat", &spapr-
> > >max_compat_pvr,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0"Maximum permitted CPU compatibility
> > mode",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0&error_fatal);
> > =A0}
> > =A0
> > =A0static void spapr_machine_finalizefn(Object *obj)
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index ff7058e..ab4102b 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -20,6 +20,58 @@
> > =A0#include "sysemu/numa.h"
> > =A0#include "qemu/error-report.h"
> > =A0
> > +void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> > +{
> > +=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0* Backwards compatibility hack:
> > +=A0=A0=A0=A0=A0*
> > +=A0=A0=A0=A0=A0*=A0=A0=A0CPUs had a "compat=3D" property which didn't =
make sense for
> > +=A0=A0=A0=A0=A0*=A0=A0=A0anything except pseries.=A0=A0It was replaced=
 by "max-cpu-
> > compat"
> > +=A0=A0=A0=A0=A0*=A0=A0=A0machine option.=A0=A0This supports old comman=
d lines like
> > +=A0=A0=A0=A0=A0*=A0=A0=A0=A0=A0=A0=A0-cpu POWER8,compat=3Dpower7
> > +=A0=A0=A0=A0=A0*=A0=A0=A0By stripping the compat option and applying i=
t to the
> > machine
> > +=A0=A0=A0=A0=A0*=A0=A0=A0before passing it on to the cpu level parser.
> > +=A0=A0=A0=A0=A0*/
> > +=A0=A0=A0=A0gchar **inpieces;
> > +=A0=A0=A0=A0int i, j;
> > +=A0=A0=A0=A0gchar *compat_str =3D NULL;
> > +
> > +=A0=A0=A0=A0inpieces =3D g_strsplit(MACHINE(spapr)->cpu_model, ",", 0);
> > +
> > +=A0=A0=A0=A0/* inpieces[0] is the actual model string */
> > +=A0=A0=A0=A0i =3D 1;
> > +=A0=A0=A0=A0j =3D 1;
> > +=A0=A0=A0=A0while (inpieces[i]) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0if (g_str_has_prefix(inpieces[i], "compat=3D")=
) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* in case of multiple compat=3D o=
ptipons */
>=20
> s/optipons/options?

Oops, fixed.

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g_free(compat_str);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0compat_str =3D inpieces[i];
> > +=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0j++;
> > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > +
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* Excise compat options from list */
> > +=A0=A0=A0=A0=A0=A0=A0=A0inpieces[j] =3D inpieces[i];
>=20
> it's worth noting that where previously when specifying an invalid
> option you got:
>=20
> qemu-system-ppc64: Expected key=3Dvalue format, found=A0*blah*
>=20
> You now get a segfault here.

Sod.  The joy of doing string manipulation in C.  Ok, I think I've
found and fixed that too.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZL759AAoJEGw4ysog2bOSqjEQAJfEyH+q5ym+pkajy0GDeYj+
ZF+3LvIm9tCkpa60vlBnJWfWGxH/WC0DFqmDB7PimAr/1XLZ+Q4eIQ43rCL3Q3nh
NnQoMdiEFJUZa5HYz/Xc5HCWsiOaMezRImj8CpwCJrHZ8Pj0aT/w4w93XMT6NE1M
tse2q0zAwnxtcNzNUH5A92rzmpKGGKwObFUn79Okg5l5wbtVJvrtaEBVcSN12sTG
IsoNLZFnaw+SMIKD9J+68EiCdD7kv/zD3EPvROZilbbkVEu7il8ZzWfBDLsCP8PB
qToIfCIAeRMCP5lTYlN/jMoJcp59Q+3XwRfEAG7P+NDYCHyiNeBUMw565OQpeSJz
mIvo0LlW0c1Q8AMjX3uqzMM04xJDZiMeGSgEB3W2/7sqGCqtoIXPZNNCki57THJY
LmwbeeXiX1/PKs8JRWRcQOEWnpDjXOFMUXnGqjgOl4kP3m6x60+267qHRHPGUCOf
DNuQ9npM/14UdTcQjHoTCrmn1uF5yJOkLgvb/SZicJLu9e5/293toFxBBSHRIdiM
lRYQKro5nnME61nQsEW42Karqa6z5H2KLKi4cHt8smsmCFz0Khd0y9VYNYUieP+6
s0XATXV9vhi8/ApadbmA7vv+mPGmLynROlXOqfFmre5PgmNGWhcQRkvBGrhGfTRX
/af1r8FP9qgyfmCYv8sU
=4v5U
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--

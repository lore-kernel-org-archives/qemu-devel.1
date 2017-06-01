Received: from eggs.gnu.org ([2001:4830:134:3::10]:36526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGR0Q-0002ls-Ro
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:23:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dGR0P-00082y-8b
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:23:18 -0400
Date: Thu, 1 Jun 2017 22:24:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170601122447.GF13397@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170526052319.28096-4-david@gibson.dropbear.id.au>
	<1496295880.4414.1.camel@gmail.com>
	<20170601092908.5a17eeec@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cpvLTH7QU4gwfq3S"
Content-Disposition: inline
In-Reply-To: <20170601092908.5a17eeec@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, quintela@redhat.com, sursingh@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, qemu-ppc@nongnu.org, abologna@redhat.com, sbobroff@redhat.com, dgilbert@redhat.com


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 09:29:08AM +0200, Greg Kurz wrote:
> On Thu, 01 Jun 2017 15:44:40 +1000
> Suraj Jitindar Singh <sjitindarsingh@gmail.com> wrote:
>=20
> > On Fri, 2017-05-26 at 15:23 +1000, David Gibson wrote:
> > > Server class POWER CPUs have a "compat" property, which is used to
> > > set the
> > > backwards compatibility mode for the processor.=A0=A0However, this on=
ly
> > > makes
> > > sense for machine types which don't give the guest access to
> > > hypervisor
> > > privilege - otherwise the compatibility level is under the guest's
> > > control.
> > >=20
> > > To reflect this, this removes the CPU 'compat' property and instead
> > > creates a 'max-cpu-compat' property on the pseries machine.=A0=A0Stri=
ctly
> > > speaking this breaks compatibility, but AFAIK the 'compat' option was
> > > never (directly) used with -device or device_add.
> > >=20
> > > The option was used with -cpu.=A0=A0So, to maintain compatibility, th=
is
> > > patch adds a hack to the cpu option parsing to strip out any compat
> > > options supplied with -cpu and set them on the machine property
> > > instead of the now deprecated cpu property. =20
> >=20
> > Generally looks good, a couple of comments below.
> >=20
> > Suraj
> >=20
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > > =A0hw/ppc/spapr.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A0=
6 ++-
> > > =A0hw/ppc/spapr_cpu_core.c=A0=A0=A0=A0=A0|=A0=A056 ++++++++++++++++++=
+++++-
> > > =A0hw/ppc/spapr_hcall.c=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A08 ++--
> > > =A0include/hw/ppc/spapr.h=A0=A0=A0=A0=A0=A0|=A0=A012 ++++--
> > > =A0target/ppc/compat.c=A0=A0=A0=A0=A0=A0=A0=A0=A0| 102
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > > =A0target/ppc/cpu.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0|=A0=A0=A05 ++-
> > > =A0target/ppc/translate_init.c |=A0=A086 +++++++++++-----------------=
------
> > > ---
> > > =A07 files changed, 202 insertions(+), 73 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index ab3aab1..3c4e88f 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2134,7 +2134,7 @@ static void ppc_spapr_init(MachineState
> > > *machine)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0machine->cpu_model =3D kvm_enabled() ? "ho=
st" : smc- =20
> > > >tcg_default_cpu; =20
> > > =A0=A0=A0=A0=A0}
> > > =A0
> > > -=A0=A0=A0=A0ppc_cpu_parse_features(machine->cpu_model);
> > > +=A0=A0=A0=A0spapr_cpu_parse_features(spapr);
> > > =A0
> > > =A0=A0=A0=A0=A0spapr_init_cpus(spapr);
> > > =A0
> > > @@ -2497,6 +2497,10 @@ static void spapr_machine_initfn(Object *obj)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" place of standard EPOW events
> > > when possible"
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0" (required for memory hot-
> > > unplug support)",
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0NULL);
> > > +
> > > +=A0=A0=A0=A0ppc_compat_add_property(obj, "max-cpu-compat", &spapr- =
=20
> > > >max_compat_pvr, =20
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0"Maximum permitted CPU compatibility
> > > mode",
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0&error_fatal);
> > > =A0}
> > > =A0
> > > =A0static void spapr_machine_finalizefn(Object *obj)
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index ff7058e..ab4102b 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -20,6 +20,58 @@
> > > =A0#include "sysemu/numa.h"
> > > =A0#include "qemu/error-report.h"
> > > =A0
> > > +void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> > > +{
> > > +=A0=A0=A0=A0/*
> > > +=A0=A0=A0=A0=A0* Backwards compatibility hack:
> > > +=A0=A0=A0=A0=A0*
> > > +=A0=A0=A0=A0=A0*=A0=A0=A0CPUs had a "compat=3D" property which didn'=
t make sense for
> > > +=A0=A0=A0=A0=A0*=A0=A0=A0anything except pseries.=A0=A0It was replac=
ed by "max-cpu-
> > > compat"
> > > +=A0=A0=A0=A0=A0*=A0=A0=A0machine option.=A0=A0This supports old comm=
and lines like
> > > +=A0=A0=A0=A0=A0*=A0=A0=A0=A0=A0=A0=A0-cpu POWER8,compat=3Dpower7
> > > +=A0=A0=A0=A0=A0*=A0=A0=A0By stripping the compat option and applying=
 it to the
> > > machine
> > > +=A0=A0=A0=A0=A0*=A0=A0=A0before passing it on to the cpu level parse=
r.
> > > +=A0=A0=A0=A0=A0*/
> > > +=A0=A0=A0=A0gchar **inpieces;
> > > +=A0=A0=A0=A0int i, j;
> > > +=A0=A0=A0=A0gchar *compat_str =3D NULL;
> > > +
> > > +=A0=A0=A0=A0inpieces =3D g_strsplit(MACHINE(spapr)->cpu_model, ",", =
0);
> > > +
> > > +=A0=A0=A0=A0/* inpieces[0] is the actual model string */
> > > +=A0=A0=A0=A0i =3D 1;
> > > +=A0=A0=A0=A0j =3D 1;
> > > +=A0=A0=A0=A0while (inpieces[i]) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0if (g_str_has_prefix(inpieces[i], "compat=3D=
")) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* in case of multiple compat=3D=
 optipons */ =20
> >=20
> > s/optipons/options?
> >=20
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0g_free(compat_str);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0compat_str =3D inpieces[i];
> > > +=A0=A0=A0=A0=A0=A0=A0=A0} else {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0j++;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0}
> > > +
> > > +=A0=A0=A0=A0=A0=A0=A0=A0/* Excise compat options from list */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0inpieces[j] =3D inpieces[i]; =20
> >=20
> > it's worth noting that where previously when specifying an invalid
> > option you got:
> >=20
> > qemu-system-ppc64: Expected key=3Dvalue format, found=A0*blah*
> >=20
> > You now get a segfault here.
> >=20
>=20
> Yeah. This basically does:
>=20
>     inpieces[i + 1] =3D inpieces[i];
>=20
> and we end up overwriting the terminal NULL pointer with a non-NULL
> pointer.
>=20
> What about simplifying the loop to:
>=20
>     /* inpieces[0] is the actual model string */
>     i =3D 1;
>     while (inpieces[i]) {
>         if (g_str_has_prefix(inpieces[i], "compat=3D")) {
>             /* in case of multiple compat=3D optipons */
>             g_free(compat_str);
>             compat_str =3D inpieces[i];
>             /* Excise compat options from list */
>             inpieces[i] =3D inpieces[i + 1];
>         }
>         i++;
>     }

No.. that would duplicate the entry after the compat=3D, instead of
properly excising it.  I've already fixed this for my next draft.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cpvLTH7QU4gwfq3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZMAeNAAoJEGw4ysog2bOSXhMQAOEkswI68I16S1TwfJGx87jS
J1CHCr6kUsio9m7KQQgQtD9NxsbC5hy9ruPgrXWn4hN/trNSMPdYvbRB+9/ho9bV
z6xDc2INJJST9aOqPFp9alYn2O/JlDciKXJ31QoTdvsO3Lq+mcGfnKvMJVQWba7T
SF0CAlIYFttPhXr3QyMB+WinA4dMRpquAxKMhRJraKoPbFuMBdhKl5nXda3n2lZD
M8S8+AFifIwjoM7skD17+kBxmNznGWt/R4w5s4GVxJE8jqPD4KnA0wj5zThLzx9g
LXPwzHpYjlpC6jpdo3DMaCwBfOm4fRJKBcvYHHVquCdlEGHCP+sxdHwD9HUUIuIp
JwN6N99Y9eR1zHz/MxILUDiZuzFGX06a+KOLI58l+pzcxfkiz6UXvXu0QvsTjQWd
zDPATX/wVk/AWghMKvotU5EZ9kKfETP54tGgRfzS7b36iedJ5ZQmfem61HjJFocb
0m8aHJZCqCXE1EA0ZrfQkrgokqINCC6uyjnqpj68XeO1k2mIma1q7BF7NxPHbp+m
C3SpaI6M7QpJPDbly9OSW+SZ4xzEHfway8pHmyzFQ8Y5k70hZxwNMwrNy6ZCjz23
lkAKTp5OwkF0C6CM5oPZNi9MDvARBgiPutRYwW8xK+f3e2UZ6xAkHVxkbSnJ41Be
Rq1kiXkX+EmilP405TXY
=Q7xv
-----END PGP SIGNATURE-----

--cpvLTH7QU4gwfq3S--

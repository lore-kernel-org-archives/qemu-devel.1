Received: from eggs.gnu.org ([2001:4830:134:3::10]:35063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1KyH-0005ze-Fm
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 19:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1KyD-0006J8-H4
	for qemu-devel@nongnu.org; Sun, 08 Oct 2017 19:26:57 -0400
Date: Mon, 9 Oct 2017 10:26:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171008232638.GN10050@umbus.fritz.box>
References: <150748304313.11627.11685667181516412731.stgit@bahia.lan>
	<CAFEAcA-HYzVowLcomUJRNfb+_DFKqOKuW+X5kZBg1S4o_9pbyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lLR1BQqf7txDtYcF"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-HYzVowLcomUJRNfb+_DFKqOKuW+X5kZBg1S4o_9pbyg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr: introduce
 SPAPR_MACHINE_NOASSERT()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>


--lLR1BQqf7txDtYcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 08, 2017 at 09:05:37PM +0100, Peter Maydell wrote:
> On 8 October 2017 at 18:17, Greg Kurz <groug@kaod.org> wrote:
> > A spapr-cpu-core device can only be plugged into a pseries machine. This
> > is checked in spapr_cpu_core_realize() with object_dynamic_cast() inste=
ad
> > of the usual SPAPR_MACHINE() macro because we don't want QEMU to abort.
> >
> > This patch moves the gory details to a SPAPR_MACHINE_NOASSERT() macro
> > that acts like the SPAPR_MACHINE() one, except it returns NULL instead
> > of aborting if its argument doesn't point to a pseries machine type.
> >
> > This is done for two reasons:
> > - it makes the code nicer
> > - it may be used by other pseries-specific devices like PHBs for example
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_cpu_core.c |    7 +++----
> >  include/hw/ppc/spapr.h  |    3 +++
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 37beb56e8b18..5fde07614218 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -199,7 +199,7 @@ error:
> >
> >  static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
> >  {
> > -    sPAPRMachineState *spapr;
> > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE_NOASSERT(qdev_get_machi=
ne());
> >      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> >      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> > @@ -209,9 +209,8 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> >      void *obj;
> >      int i, j;
> >
> > -    spapr =3D (sPAPRMachineState *) qdev_get_machine();
> > -    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
> > -        error_setg(errp, "spapr-cpu-core needs a pseries machine");
> > +    if (!spapr) {
> > +        error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machine=
");
> >          return;
> >      }
> >
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index c1b365f56431..4933da8083df 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -43,6 +43,9 @@ typedef struct sPAPRMachineClass sPAPRMachineClass;
> >  #define SPAPR_MACHINE_CLASS(klass) \
> >      OBJECT_CLASS_CHECK(sPAPRMachineClass, klass, TYPE_SPAPR_MACHINE)
> >
> > +#define SPAPR_MACHINE_NOASSERT(obj) \
> > +    ((sPAPRMachineState *) object_dynamic_cast(obj, TYPE_SPAPR_MACHINE=
))
> > +
>=20
> I don't think this is a great idea. Doing things with pointers
> that might not be of the right type should be obvious, not hidden
> under macros. An opencoded call to object_dynamic_cast is how the
> rest of the codebase does this; it's a bit of a weird way
> to write "isinstance()" but there you go. If we want to
> improve the way we write this sort of thing we should do
> so as a general improvement to the QOM APIs and conventions,
> not just a single thing in SPAPR code.

Yeah, I tend to agree.  Sorry, the original advice I gave on not using
object_dynamic_cast() directly was bogus - I didn't think it through
clearly.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lLR1BQqf7txDtYcF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnatC4ACgkQbDjKyiDZ
s5IFIxAAgnR0FOpJ2UAZvPdfuqOyLAYe+mjWdSS01LO/uzVXI1+YcZLmQZd2E4ag
7yV7oUBT2lpb07hBNCtEOUrNGPzvs9frFWbQLm8TEnH0xVNgmbRGTP0FMFYIT+C5
zBkRoiEKkyNFgRz/xDm49onS1DsYRjozPlEegP1t1MGVY9eTyPH+3UDqIODLI870
ONebINoYh2e/gXM6aGVnCWGjUqXMSBYiWxhCZnVzgIWlFSGZc3LHeg7aoBJEjK7I
nH6PWH2VO68MmBYWBYTyvzH5sqe3Qs5yTUVICW5JAxqdqv2TswG1UBBriHrs+9op
YyblHpgCAWe76bsYN9WXL8LkqUFCAhwuTgQymrMud9cEflYo2ufwJYz8yLiXreFh
eZc1J3rFboiZiBu3OqT4ZYSA+CZ9zSn5kgOB0jIAMtkYAPEPrJqBarH0T85XhHNq
Z6zWinA4vo4snZ9ANFWj0bGmVyAr1omTLcVdrm5pOQA+G4dP7n/k39LCdf7VNKH3
9coV10t+AXfwWYEH+1YgGvHF7BHsgdf46D9IyMRMlVh1fLc5pQHJBmp5UzLCZ7EH
BI8dtruMqAHzE4LbgkWXeq116344oLNLYj7VffXg60+xfLfST18Y/3S3C0d/mHQ4
rkVpSg7Te0VjoxgEHyd+z/U7mRT1yaJElzW+SJJRVlyPH3HaC4k=
=X1jM
-----END PGP SIGNATURE-----

--lLR1BQqf7txDtYcF--

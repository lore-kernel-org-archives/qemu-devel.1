Received: from eggs.gnu.org ([2001:4830:134:3::10]:40857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1Qxg-00055m-4B
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e1Qxd-0003AD-19
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:50:44 -0400
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:34934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e1Qxc-00039r-R5
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 01:50:40 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 6203FD947D
	for <qemu-devel@nongnu.org>; Mon,  9 Oct 2017 07:50:39 +0200 (CEST)
Date: Mon, 9 Oct 2017 07:50:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171009075033.75c152aa@bahia.lan>
In-Reply-To: <20171008232638.GN10050@umbus.fritz.box>
References: <150748304313.11627.11685667181516412731.stgit@bahia.lan>
	<CAFEAcA-HYzVowLcomUJRNfb+_DFKqOKuW+X5kZBg1S4o_9pbyg@mail.gmail.com>
	<20171008232638.GN10050@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/+fTR/e9kXZ6.1CHa.jslDts";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

--Sig_/+fTR/e9kXZ6.1CHa.jslDts
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Oct 2017 10:26:38 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Sun, Oct 08, 2017 at 09:05:37PM +0100, Peter Maydell wrote:
> > On 8 October 2017 at 18:17, Greg Kurz <groug@kaod.org> wrote: =20
> > > A spapr-cpu-core device can only be plugged into a pseries machine. T=
his
> > > is checked in spapr_cpu_core_realize() with object_dynamic_cast() ins=
tead
> > > of the usual SPAPR_MACHINE() macro because we don't want QEMU to abor=
t.
> > >
> > > This patch moves the gory details to a SPAPR_MACHINE_NOASSERT() macro
> > > that acts like the SPAPR_MACHINE() one, except it returns NULL instead
> > > of aborting if its argument doesn't point to a pseries machine type.
> > >
> > > This is done for two reasons:
> > > - it makes the code nicer
> > > - it may be used by other pseries-specific devices like PHBs for exam=
ple
> > >
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > ---
> > >  hw/ppc/spapr_cpu_core.c |    7 +++----
> > >  include/hw/ppc/spapr.h  |    3 +++
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index 37beb56e8b18..5fde07614218 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -199,7 +199,7 @@ error:
> > >
> > >  static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
> > >  {
> > > -    sPAPRMachineState *spapr;
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE_NOASSERT(qdev_get_mac=
hine());
> > >      sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> > >      sPAPRCPUCoreClass *scc =3D SPAPR_CPU_CORE_GET_CLASS(OBJECT(dev));
> > >      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
> > > @@ -209,9 +209,8 @@ static void spapr_cpu_core_realize(DeviceState *d=
ev, Error **errp)
> > >      void *obj;
> > >      int i, j;
> > >
> > > -    spapr =3D (sPAPRMachineState *) qdev_get_machine();
> > > -    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
> > > -        error_setg(errp, "spapr-cpu-core needs a pseries machine");
> > > +    if (!spapr) {
> > > +        error_setg(errp, TYPE_SPAPR_CPU_CORE " needs a pseries machi=
ne");
> > >          return;
> > >      }
> > >
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index c1b365f56431..4933da8083df 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -43,6 +43,9 @@ typedef struct sPAPRMachineClass sPAPRMachineClass;
> > >  #define SPAPR_MACHINE_CLASS(klass) \
> > >      OBJECT_CLASS_CHECK(sPAPRMachineClass, klass, TYPE_SPAPR_MACHINE)
> > >
> > > +#define SPAPR_MACHINE_NOASSERT(obj) \
> > > +    ((sPAPRMachineState *) object_dynamic_cast(obj, TYPE_SPAPR_MACHI=
NE))
> > > + =20
> >=20
> > I don't think this is a great idea. Doing things with pointers
> > that might not be of the right type should be obvious, not hidden
> > under macros. An opencoded call to object_dynamic_cast is how the
> > rest of the codebase does this; it's a bit of a weird way
> > to write "isinstance()" but there you go. If we want to
> > improve the way we write this sort of thing we should do
> > so as a general improvement to the QOM APIs and conventions,
> > not just a single thing in SPAPR code. =20
>=20

Ok, I agree.

> Yeah, I tend to agree.  Sorry, the original advice I gave on not using
> object_dynamic_cast() directly was bogus - I didn't think it through
> clearly.
>=20

Then maybe you can apply the previous version or do you have another
suggestion ?

--Sig_/+fTR/e9kXZ6.1CHa.jslDts
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWdsOKgAKCRAC/DrrAQHb
wkomAKCQLQx6/FI++U2TMl5VU7K5ibwhxwCdEPxR+vld0un/7tymqIXCROnK1Wk=
=bmpw
-----END PGP SIGNATURE-----

--Sig_/+fTR/e9kXZ6.1CHa.jslDts--

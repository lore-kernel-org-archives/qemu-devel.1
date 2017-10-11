Received: from eggs.gnu.org ([2001:4830:134:3::10]:37463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2EEG-0002lW-0H
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e2EEE-0004p1-NB
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 06:27:08 -0400
Date: Wed, 11 Oct 2017 21:26:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171011102653.GA28032@umbus.fritz.box>
References: <150730254473.16260.6484345241358746630.stgit@bahia>
	<20171007051925.GJ10050@umbus.fritz.box>
	<20171011092908.291c6cd6@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20171011092908.291c6cd6@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: fail gracefully with
 non-pseries machine types
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


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 11, 2017 at 09:29:08AM +0200, Greg Kurz wrote:
> On Sat, 7 Oct 2017 16:19:25 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Oct 06, 2017 at 05:09:04PM +0200, Greg Kurz wrote:
> > > QEMU currently crashes when the user tries to add a spapr-pci-host-br=
idge
> > > on a non-pseries machine:
> > >=20
> > > $ qemu-system-ppc64 -M ppce500 -device spapr-pci-host-bridge,index=3D1
> > > hw/ppc/spapr_pci.c:1535:spapr_phb_realize:
> > > Object 0x1003dacae60 is not an instance of type spapr-machine
> > > Aborted (core dumped)
> > >=20
> > > The same thing happens with the deprecated but still available child =
type
> > > spapr-pci-vfio-host-bridge.
> > >=20
> > > Fix both by checking the machine type with object_dynamic_cast().
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> >=20
> >=20
> > > ---
> > >  hw/ppc/spapr_pci.c |    8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > index 5049ced4e8b4..9e85106f51f8 100644
> > > --- a/hw/ppc/spapr_pci.c
> > > +++ b/hw/ppc/spapr_pci.c
> > > @@ -1507,7 +1507,7 @@ static void spapr_pci_unplug_request(HotplugHan=
dler *plug_handler,
> > > =20
> > >  static void spapr_phb_realize(DeviceState *dev, Error **errp)
> > >  {
> > > -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > > +    sPAPRMachineState *spapr;
> > >      SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
> > >      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
> > >      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
> > > @@ -1519,6 +1519,12 @@ static void spapr_phb_realize(DeviceState *dev=
, Error **errp)
> > >      const unsigned windows_supported =3D
> > >          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> > > =20
> > > +    spapr =3D (sPAPRMachineState *) qdev_get_machine();
> > > +    if (!object_dynamic_cast((Object *) spapr, TYPE_SPAPR_MACHINE)) {
> > > +        error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pserie=
s machine");
> > > +        return;
> > > +    } =20
> >=20
> > This is slightly clunky.  You could instead use OBJECT_CHECK in the
> > initializer, then just if (!spapr) here.
> >=20
>=20
> The negative review on v2 seem to indicate we have an agreement on using
> object_dynamic_cast() explicitly. So we have two possibilities, either
> the "clunky" v1, or possibly:
>=20
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> +    /* We don't use SPAPR_MACHINE() in order to exit gracefully if the u=
ser
> +     * tries to add a PHB to a non-pseries machine.
> +     */
> +    sPAPRMachineState *spapr =3D
> +        (sPAPRMachineState *) object_dynamic_cast(qdev_get_machine(),
> +                                                  TYPE_SPAPR_MACHINE);
>      SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
>      sPAPRPHBState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
>      char *namebuf;
>      int i;
>      PCIBus *bus;
>      uint64_t msi_window_size =3D 4096;
>      sPAPRTCETable *tcet;
>      const unsigned windows_supported =3D
>          sphb->ddw_enabled ? SPAPR_PCI_DMA_MAX_WINDOWS : 1;
> =20
> +    if (!spapr) {
> +        error_setg(errp, TYPE_SPAPR_PCI_HOST_BRIDGE " needs a pseries ma=
chine");
> +        return;
> +    }
> +
>=20
> Which one do you prefer ? I'll also change spapr_cpu_core_realize()
> if needed.

Second one looks good to me.

>=20
> > > +
> > >      if (sphb->index !=3D (uint32_t)-1) {
> > >          sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> > >          Error *local_err =3D NULL;
> > >  =20
> >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnd8eoACgkQbDjKyiDZ
s5Io+A//bkyOPWeQda0wLZKcHs7zw2Mj+WnmxJcf8+pw/4MuUzZ0NNCbSJl/tn8Z
r84+hdByCwu634cVq8BDNYQ9cj5kSS8ZHBy8SF5Cq2jhGnCOqx3PN7qLhmT88lqi
O+LHT7elCIDcIBBpgDlY/2BWiRMZ/VKHbNBER3eKqoV16kG6TYZpE9+wXpxTOeSe
hWgkJiPXsKpXOrETlW/WwA7PusA48T/L+XWuK0PYum1Jj8AH42hpp913Cu0+LSV/
7SELExWNoS2saTrK6iny2tgjzALdn+C366cyBFJXtVNvKMg676KvoUqnTvYjXUsC
UakxWTAmjdERyXShN0JOpfiMyGq3dbus0OzkjCtoaKglU/ukSmdnI13AG4cjvXL3
4f84TZtSDrlmHsYd79wfBFfGeBLRIWCRK6nJWfWqAg+QV6msXEfCtqPQQP+5OTIe
D/VWl6QOnTJbNxm2lKZVFK0QwkIKtOj8GOFPGvWVm8Qtq7i56GmV6O022Yu5d4yn
64aovJKh27SgwKedSsPSfYfrRxy6+BuG05JO5yccYV1d5bxdQiez4QxFs3iBcSwI
BSRcAmedokx3CMVsL81AhrChfCNEfVhseg6RAhuVh1FPd9f5g+bfqc+Ov+or76Au
HK1LFiTwPMmWSCpbHa+nB4cJkL77XDNqm2GuF6UhMjRes2Cw/I4=
=PU5O
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

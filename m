Received: from eggs.gnu.org ([2001:4830:134:3::10]:37233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhX-0007C3-IF
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybq-0006vM-Ad
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:45 -0400
Date: Tue, 23 Oct 2018 16:12:39 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023151239.GH12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-10-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Uu2n37VG4rOBDVuR"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-10-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 09/45] hw/sh4/sh_pci: Use
 DeviceState::realize rather than SysBusDevice::init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:46PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Move from the legacy SysBusDevice::init method to using DeviceState::real=
ize.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Message-Id: <20181002212522.23303-6-f4bug@amsat.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/sh4/sh_pci.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
> index 4ec2e35500..379d0685ed 100644
> --- a/hw/sh4/sh_pci.c
> +++ b/hw/sh4/sh_pci.c
> @@ -120,16 +120,15 @@ static void sh_pci_set_irq(void *opaque, int irq_nu=
m, int level)
>      qemu_set_irq(pic[irq_num], level);
>  }
> =20
> -static int sh_pci_device_init(SysBusDevice *dev)
> +static void sh_pci_device_realize(DeviceState *dev, Error **errp)
>  {
> -    PCIHostState *phb;
> -    SHPCIState *s;
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    SHPCIState *s =3D SH_PCI_HOST_BRIDGE(dev);
> +    PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
>      int i;
> =20
> -    s =3D SH_PCI_HOST_BRIDGE(dev);
> -    phb =3D PCI_HOST_BRIDGE(s);
>      for (i =3D 0; i < 4; i++) {
> -        sysbus_init_irq(dev, &s->irq[i]);
> +        sysbus_init_irq(sbd, &s->irq[i]);
>      }
>      phb->bus =3D pci_register_root_bus(DEVICE(dev), "pci",
>                                       sh_pci_set_irq, sh_pci_map_irq,
> @@ -143,13 +142,12 @@ static int sh_pci_device_init(SysBusDevice *dev)
>                               &s->memconfig_p4, 0, 0x224);
>      memory_region_init_alias(&s->isa, OBJECT(s), "sh_pci.isa",
>                               get_system_io(), 0, 0x40000);
> -    sysbus_init_mmio(dev, &s->memconfig_p4);
> -    sysbus_init_mmio(dev, &s->memconfig_a7);
> +    sysbus_init_mmio(sbd, &s->memconfig_p4);
> +    sysbus_init_mmio(sbd, &s->memconfig_a7);
>      s->iobr =3D 0xfe240000;
>      memory_region_add_subregion(get_system_memory(), s->iobr, &s->isa);
> =20
>      s->dev =3D pci_create_simple(phb->bus, PCI_DEVFN(0, 0), "sh_pci_host=
");
> -    return 0;
>  }
> =20
>  static void sh_pci_host_realize(PCIDevice *d, Error **errp)
> @@ -187,9 +185,9 @@ static const TypeInfo sh_pci_host_info =3D {
> =20
>  static void sh_pci_device_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sdc =3D SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    sdc->init =3D sh_pci_device_init;
> +    dc->realize =3D sh_pci_device_realize;
>  }
> =20
>  static const TypeInfo sh_pci_device_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPOmcACgkQbDjKyiDZ
s5IPYw/+LYwW3ZMFNBHxSmIvDCo15gePud3dz9g+UXS/guOglAFDITBVdwmDaf5I
A1TM3WAkwSfbuLlJ+Rzo7htWdK8B+21Kcg57kSXJ36iGve5maOHrMCT0BUCBRqhk
bBxuZi7tN3d4axoA2SdL7OEUukkRYkUY1kEJf4U04BkgMDbbh4AGjN7xmZAqcFaQ
muRtUe19+Nh7gbaQU4s/W7Gbuqlio3osUki87NHcdkmsYyyR0ILQ4XpFLcDVjmg1
i4p5uTypmT5T7T65yL8FdaLv7CuvBUkn7+6ZdWwGwRTCH7zrU1QmgRxtjBT6O3Sa
dALD075BAPH9ZNtDAi8Xdcj/yakW+hiEKe9Zyg9JE/asXLpSssN8yvhFH1dB3UW4
Qr3YvY3yQoR+wzCuQLTYvYpcEDYasFBYJzvG2Xg0xH7GGKMcvLijUTguLNP9SILC
rCTzB9332+aaQf+6HX0ULOvbzRhF0AmP14dh0xV6O+CxzlQI11K3oCvSs9dW834a
ssSztAx57MjUzYIVJiPkWE6FBv8xRJA+3bi+A5UXIZKT3+dTCOgeKhERP4EKKiqK
6ypeHNbEONCIwwh5WDROLehegCl3Dc+1tFjXEoPbmAXL8jYOgLwC9WnAna0eJoF/
UySy6h29CtuKrg8Ky3w9xeCyFJIsXlOMGsjo9HxuOOb2VbhzL4o=
=U/0v
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhd-0006ks-Hz
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybR-0006gI-Qe
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:20 -0400
Date: Tue, 23 Oct 2018 16:14:08 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023151408.GI12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-11-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/GPgYEyhnw15BExa"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-11-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 10/45] hw/pci-host/bonito: Use
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


--/GPgYEyhnw15BExa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:47PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Move from the legacy SysBusDevice::init method to using DeviceState::real=
ize.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Message-Id: <20181002212522.23303-7-f4bug@amsat.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-host/bonito.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index 9868e2eccc..9f33582706 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -595,7 +595,7 @@ static const VMStateDescription vmstate_bonito =3D {
>      }
>  };
> =20
> -static int bonito_pcihost_initfn(SysBusDevice *dev)
> +static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
>  {
>      PCIHostState *phb =3D PCI_HOST_BRIDGE(dev);
> =20
> @@ -603,8 +603,6 @@ static int bonito_pcihost_initfn(SysBusDevice *dev)
>                                       pci_bonito_set_irq, pci_bonito_map_=
irq,
>                                       dev, get_system_memory(), get_syste=
m_io(),
>                                       0x28, 32, TYPE_PCI_BUS);
> -
> -    return 0;
>  }
> =20
>  static void bonito_realize(PCIDevice *dev, Error **errp)
> @@ -684,7 +682,6 @@ PCIBus *bonito_init(qemu_irq *pic)
>      pcihost->pic =3D pic;
>      qdev_init_nofail(dev);
> =20
> -    /* set the pcihost pointer before bonito_initfn is called */
>      d =3D pci_create(phb->bus, PCI_DEVFN(0, 0), TYPE_PCI_BONITO);
>      s =3D PCI_BONITO(d);
>      s->pcihost =3D pcihost;
> @@ -726,9 +723,9 @@ static const TypeInfo bonito_info =3D {
> =20
>  static void bonito_pcihost_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    k->init =3D bonito_pcihost_initfn;
> +    dc->realize =3D bonito_pcihost_realize;
>  }
> =20
>  static const TypeInfo bonito_pcihost_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/GPgYEyhnw15BExa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPOsAACgkQbDjKyiDZ
s5I3ZBAAsEOTikPIJ/qw5PGMfw2LDIqfMfTPvxnrOoilFLfKD4TM9KuVY5+q+chg
t3sGsI09D/e9WxQNy8w8r2a6zac00eUA6cvPqxCpahWNN2+ELQ4K96vfWytrYFxL
ZL8Q/nUi0GIjBDLf3zcPfPfN19tmPlwjWJrmNb+WQREz5ZFQ/47eNEsNF4R2Cxw2
Yp7oKwjRFVIhczozs/8GXcOEdPW5ssrUshHyEMXKl3k0eKKraCg6puEzl3XNd9aV
g4g/FoHMLT0U1TQbbKOZTn685KVj3xUzGaKeJB+OwI0ywZNY+NWo/U58dnjRbXuK
Ej0ywtDNCfu6QtdCsSEIdCtDcENhJwGMTHY6sAfytVFR1dQQq0xOrPs7eN0G8ALR
rPBqi2bQMV2/Cq2n0KghzZ0Sdpn31ojdjoB0GLnbWM2bN65mmcuVmNcPt1enwODO
g0D5xmdwB83GWk5WXT4YQMwHKssQze/HjxT+Yrmvlzgv161y7BsonOWyYg5N8Mmt
y1of1kyPLeaxLhNw9BEIcGwsBMeA/Zd5O5dsPfmxiUl6q5lU9+ER4Qf4Vii3HL6b
CVMMSSpR3E2Kif39Lx+E4goKS//On8Mfz8ZozmoFUd7VIONqGEJLz2INyPN4UN70
7PGoa7IaZEgGkXm/06C9DcPd1MjSpCf3D8h0M35Csyas3RCcfm0=
=8sO1
-----END PGP SIGNATURE-----

--/GPgYEyhnw15BExa--

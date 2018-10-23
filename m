Received: from eggs.gnu.org ([2001:4830:134:3::10]:36857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhT-0006fy-M8
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybu-000710-Gj
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:47 -0400
Date: Tue, 23 Oct 2018 16:11:45 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023151145.GG12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-9-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Sw7tCqrGA+HQ0/zt"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-9-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 08/45] hw/ssi/xilinx_spi: Use
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


--Sw7tCqrGA+HQ0/zt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:03:45PM -0300, Eduardo Habkost wrote:
> From: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20
> Move from the legacy SysBusDevice::init method to using DeviceState::real=
ize.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> Message-Id: <20181002212522.23303-5-f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ssi/xilinx_spi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
> index 83585bc8b2..3dae303d5b 100644
> --- a/hw/ssi/xilinx_spi.c
> +++ b/hw/ssi/xilinx_spi.c
> @@ -319,9 +319,9 @@ static const MemoryRegionOps spi_ops =3D {
>      }
>  };
> =20
> -static int xilinx_spi_init(SysBusDevice *sbd)
> +static void xilinx_spi_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      XilinxSPI *s =3D XILINX_SPI(dev);
>      int i;
> =20
> @@ -344,8 +344,6 @@ static int xilinx_spi_init(SysBusDevice *sbd)
> =20
>      fifo8_create(&s->tx_fifo, FIFO_CAPACITY);
>      fifo8_create(&s->rx_fifo, FIFO_CAPACITY);
> -
> -    return 0;
>  }
> =20
>  static const VMStateDescription vmstate_xilinx_spi =3D {
> @@ -368,9 +366,8 @@ static Property xilinx_spi_properties[] =3D {
>  static void xilinx_spi_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D xilinx_spi_init;
> +    dc->realize =3D xilinx_spi_realize;
>      dc->reset =3D xlx_spi_reset;
>      dc->props =3D xilinx_spi_properties;
>      dc->vmsd =3D &vmstate_xilinx_spi;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Sw7tCqrGA+HQ0/zt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPOjEACgkQbDjKyiDZ
s5JIkQ//VlZrUiBAVwN8PfcgAQxa4Os/I9ANKs7wfABNd1VJLVXyIk0oF2fhMIKI
oHFTulaGiPJrtd9FXFOYGW4zaxAVNchmeLX+ffUGAeBoNNhlIQRtajDPo61p24X6
qnzAtGOSE1hXQqfkhnn6L5C7LehBFrUS9Ij7eIg76QYuJuH23bHP/uB8PosyYJTo
PvU08szzLDZ+oo8DDIxezPlpu9Gm1kZ1p9+s+F3mdQDNN16KS9B9e55/wR2vyI7Y
5KqbePoKGjQrbBtICee6TfVaOMGFhcqOT4MpYv/64kOCkQbSUNKU/tf6ncq8ICKD
S629Ep6sFWwq3o4buc6JnR/lTBqiNdZR7HR81OV5sASofmhMoLVdxzbgRhuyFjpq
P1LFlBEtZTw5qEPWeEC2ENLUOJ6DDPFTf2OfyAm11sfZqW41U/RccCGa7BJ7r8IO
eR8WG71oY6rjvhge3ZT78MFnke2jbP9v+6I3PCTF3/S+McB8hEEX9ARshz+WMRIn
ydryM14AFeSt7ImPafvnB7vO1IzxFCrQRuRc8YweTBZhT2TNJ5+m+f7xkbosqQ3p
kkRnv9C3Ljex9GTzSB7Je8HhJGfwLWnfGRDuP+tfz+qhiq/sGGttRVdjWRrV9bXx
d9RIEBFxUZPbOljwd5Vvoo6F9z+4OH5QFTFi4svmvVKtgsLATCM=
=SMI4
-----END PGP SIGNATURE-----

--Sw7tCqrGA+HQ0/zt--

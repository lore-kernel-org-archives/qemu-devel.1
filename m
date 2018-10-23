Received: from eggs.gnu.org ([2001:4830:134:3::10]:36803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhG-0006fR-MA
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybx-00075v-N4
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:51 -0400
Date: Tue, 23 Oct 2018 16:22:44 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152244.GP12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-35-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DBUa/BSa4z6QPQv1"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-35-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 34/45] net: etraxfs_eth: convert SysBus init
 method to a realize method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--DBUa/BSa4z6QPQv1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:11PM -0300, Eduardo Habkost wrote:
> From: C=E9dric Le Goater <clg@kaod.org>
>=20
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Message-Id: <20181001063803.22330-2-clg@kaod.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/etraxfs_eth.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
> index a6932432b1..64ab3df1ae 100644
> --- a/hw/net/etraxfs_eth.c
> +++ b/hw/net/etraxfs_eth.c
> @@ -23,6 +23,7 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "net/net.h"
>  #include "hw/cris/etraxfs.h"
> @@ -584,14 +585,14 @@ static NetClientInfo net_etraxfs_info =3D {
>      .link_status_changed =3D eth_set_link,
>  };
> =20
> -static int fs_eth_init(SysBusDevice *sbd)
> +static void etraxfs_eth_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      ETRAXFSEthState *s =3D ETRAX_FS_ETH(dev);
> =20
>      if (!s->dma_out || !s->dma_in) {
> -        error_report("Unconnected ETRAX-FS Ethernet MAC");
> -        return -1;
> +        error_setg(errp, "Unconnected ETRAX-FS Ethernet MAC");
> +        return;
>      }
> =20
>      s->dma_out->client.push =3D eth_tx_push;
> @@ -611,7 +612,6 @@ static int fs_eth_init(SysBusDevice *sbd)
> =20
>      tdk_init(&s->phy);
>      mdio_attach(&s->mdio_bus, &s->phy, s->phyaddr);
> -    return 0;
>  }
> =20
>  static Property etraxfs_eth_properties[] =3D {
> @@ -625,9 +625,8 @@ static Property etraxfs_eth_properties[] =3D {
>  static void etraxfs_eth_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D fs_eth_init;
> +    dc->realize =3D etraxfs_eth_realize;
>      dc->props =3D etraxfs_eth_properties;
>      /* Reason: pointer properties "dma_out", "dma_in" */
>      dc->user_creatable =3D false;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DBUa/BSa4z6QPQv1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPMQACgkQbDjKyiDZ
s5JEhxAAgGIp136dXE/QjzjNnmw1LArEfo6oYZ/0gGzjo1YOs5CvFYPQGRDvmnnX
kjt9ggxoMPDCE19NjoisyccS62foguB9n4iFRfIbOxb5WQjSvy+zUcQ+ZOePZGTj
H/PMmf+aKLIRBqgTkCb+4fd4z1FPUc5YtQvoAPxlpVhWZ1uLVfF50nnPZWIr3KN1
1pn04RuOnOXAothQJ27XO0jfhKgRMDBA0MQPYus07eEk6cocZpTsHDK0pl5UPG33
3CEy+IJd6KeL2/vRTD9v2+Cw1/JxDyOeiJVCw5uQ8y7K8isBxhhLTbfJHcAFWL/Y
qSGlNjRdOy9Y6I56sCInLhXqTt1dQgDEeepvmDeHQ+l1gf/GG3/A6xsxUGGfYZUl
fbuZYhC78qQF1TDMiAp0iqxiSt11fpvJPDuU+OnNL3WTOMxs+r9tna2TPjkDXhG7
YdiquIXc0wp50bHvmtrVeGAZzlzOh8guuOkvbSrZe6YktPI5EfUIUoswlp4KhQdE
jXkNbGdF51KTqFtw4fZ7AGiW59WgelDFr7qaC3xEo8eDiegKEPusTT/AwB3HaNVM
mH1PxTgxcxOcKVTntPHBzJH0+3H9UuP7pCapjKm19bS0oZ5tZm3x7iDOlq+dELw4
3O/gpytRrRum8dT4kszGvM1QGZt6ExZL6Pe0dYfPUdfjjSPVRqY=
=cmF0
-----END PGP SIGNATURE-----

--DBUa/BSa4z6QPQv1--

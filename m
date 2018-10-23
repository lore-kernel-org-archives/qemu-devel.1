Received: from eggs.gnu.org ([2001:4830:134:3::10]:36803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhT-0006fR-P9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybu-00070g-5z
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:47 -0400
Date: Tue, 23 Oct 2018 16:25:35 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152535.GU12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-41-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ma2pZxZcUUd0eybH"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-41-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 40/45] net: opencores_eth: convert SysBus
 init method to a realize method
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


--Ma2pZxZcUUd0eybH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:17PM -0300, Eduardo Habkost wrote:
> From: C=E9dric Le Goater <clg@kaod.org>
>=20
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Message-Id: <20181001063803.22330-8-clg@kaod.org>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/opencores_eth.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
> index d42b79c08c..d6f54f8d82 100644
> --- a/hw/net/opencores_eth.c
> +++ b/hw/net/opencores_eth.c
> @@ -715,9 +715,9 @@ static const MemoryRegionOps open_eth_desc_ops =3D {
>      .write =3D open_eth_desc_write,
>  };
> =20
> -static int sysbus_open_eth_init(SysBusDevice *sbd)
> +static void sysbus_open_eth_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      OpenEthState *s =3D OPEN_ETH(dev);
> =20
>      memory_region_init_io(&s->reg_io, OBJECT(dev), &open_eth_reg_ops, s,
> @@ -732,7 +732,6 @@ static int sysbus_open_eth_init(SysBusDevice *sbd)
> =20
>      s->nic =3D qemu_new_nic(&net_open_eth_info, &s->conf,
>                            object_get_typename(OBJECT(s)), dev->id, s);
> -    return 0;
>  }
> =20
>  static void qdev_open_eth_reset(DeviceState *dev)
> @@ -750,9 +749,8 @@ static Property open_eth_properties[] =3D {
>  static void open_eth_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D sysbus_open_eth_init;
> +    dc->realize =3D sysbus_open_eth_realize;
>      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>      dc->desc =3D "Opencores 10/100 Mbit Ethernet";
>      dc->reset =3D qdev_open_eth_reset;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ma2pZxZcUUd0eybH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPW4ACgkQbDjKyiDZ
s5LwTBAA5fVtx/enmmdjhKRA6WlTWQXj7RpnG262bhZWbHjmVAfGcdRd/4pcyc0M
28P4QxfKshSHEP3c/GXUYbhLsF/noODqqvdgICEfLenrmGaHi+7iZHYd1tB6RlsB
Bx5NLvssrCq+9L3ay8q0zkT9t/H9qAuALBvyVTXMVPwgpxKOkaDBbi2P0L9SXgz1
AMy9VVah1BjXJedtUZPr4WB72OefoCaxP0nDIi5A/GgDHxp6imEO6j/rDb87XG7q
Vqh+KsJKXDcdPIf367Iuf3FABCsjRc2f9BQYq2g1bxQOObHTjIr7NjgAYiLU/LUb
OqjK8DIeqWcxpSzbZJdQNR8wBt57mpptRI8EEPKy20TuprsOcF5fnWunshNRb+gD
H5+t522p/iTOsnHqw15eAgCHJZIgT1EEiZedOp4wv6cyrb2Fp5V5BdwmgpWbvC6x
VtA5YtaIfZUrQv7niIdEEeFkGMFaVM9q03nm7zERgmhw7/N7cifE+VGaD5T2XceY
w52Pw0lnAmkjS6MnQajYcjZ15oRh/FQRhL9ezhe2CT7mY4vTJ+Ec8caytQKkH8lE
MUnKhA7x7YULhlCYEq1l8ZNW+DGgGwkqe+cOWcC+L3s8HB2Lf6hRXBWWK68mY2M+
2zbPWWUlOTa3c31Ous5GdzKpcnamLx3rwJ69sHIC3yqmd3l8vNI=
=VznO
-----END PGP SIGNATURE-----

--Ma2pZxZcUUd0eybH--

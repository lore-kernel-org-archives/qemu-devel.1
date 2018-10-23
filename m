Received: from eggs.gnu.org ([2001:4830:134:3::10]:36803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEygk-0006fR-S2
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEycc-0007iO-Q5
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:29:32 -0400
Date: Tue, 23 Oct 2018 16:26:40 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152640.GX12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-45-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kUoBhQsr7LsiFken"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-45-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 44/45] net: xgmac: convert SysBus init
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


--kUoBhQsr7LsiFken
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:21PM -0300, Eduardo Habkost wrote:
> From: C=E9dric Le Goater <clg@kaod.org>
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Message-Id: <20181001063803.22330-12-clg@kaod.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/xgmac.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
> index fa001563d3..63f5a62ebf 100644
> --- a/hw/net/xgmac.c
> +++ b/hw/net/xgmac.c
> @@ -374,9 +374,9 @@ static NetClientInfo net_xgmac_enet_info =3D {
>      .receive =3D eth_rx,
>  };
> =20
> -static int xgmac_enet_init(SysBusDevice *sbd)
> +static void xgmac_enet_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      XgmacState *s =3D XGMAC(dev);
> =20
>      memory_region_init_io(&s->iomem, OBJECT(s), &enet_mem_ops, s,
> @@ -397,8 +397,6 @@ static int xgmac_enet_init(SysBusDevice *sbd)
>                                   (s->conf.macaddr.a[2] << 16) |
>                                   (s->conf.macaddr.a[1] << 8) |
>                                    s->conf.macaddr.a[0];
> -
> -    return 0;
>  }
> =20
>  static Property xgmac_properties[] =3D {
> @@ -408,10 +406,9 @@ static Property xgmac_properties[] =3D {
> =20
>  static void xgmac_enet_class_init(ObjectClass *klass, void *data)
>  {
> -    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> -    sbc->init =3D xgmac_enet_init;
> +    dc->realize =3D xgmac_enet_realize;
>      dc->vmsd =3D &vmstate_xgmac;
>      dc->props =3D xgmac_properties;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kUoBhQsr7LsiFken
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPbAACgkQbDjKyiDZ
s5K4Ng/9HErHZir8eXr+KMfzyfuhFyEvRfieUPjrFRe/hoCNwB9raGHLEWIo3/Ne
5kGjylHNGPejs/dRdixNZhIgVMnzkJTlSlJty4p6OOwXdNymAoZr4I1f7prP6bld
3s+i2KnqWr2m1X7f9e/s1xqxHzc13uuy7i8eMLjAMSNRhqPpameKeEsBBvqXZXOm
5XCyejJFp+QhTPvp/PDUABEPh2UjE4JDWopcJ9GQZie+pbSDCiHfMzoswZoBfZf9
xuoDmhRkBFecJTMNKHr/R8mdUNeHiDuxgG3IVjXRkrwkGm8glA9JvQ5M++QBDanz
PLrZoZbm+hxTe9cP8Gy7ykhYSDXqCDOPkyzDIRdtbWe+x3dWq8HJ89ab7slhxnD4
w7VyDp0dI+BsUNsOHx877NI2AqKWw/9f/r3lvJh4aD2zc30yt10qsTTWz3h535PM
NQqgDOqUV5uM41v815UUTroC7+PFnhuChp662L6xRajdaE06SiS1Hu4Pcc0zdezc
ILTo2eKKCwDVNFJIQFdY5j9M4SXhunBRLApIFSVqGzppfoeKE1UlbyZaajIrwbir
OlaBYzSOWeEhz5idFsTZbjEpx6zWl6yAZwHcEpPDhaaWSJCuS4pzoGBNn+zPNn08
qb21ero6FElwx/JuoJmeqhBWQFQLq6SUccLUzxN8+boVXGv3evo=
=9okA
-----END PGP SIGNATURE-----

--kUoBhQsr7LsiFken--

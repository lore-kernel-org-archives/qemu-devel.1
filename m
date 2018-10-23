Received: from eggs.gnu.org ([2001:4830:134:3::10]:37006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhS-0006ks-To
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybv-000720-Ck
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:48 -0400
Date: Tue, 23 Oct 2018 16:26:19 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152619.GW12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-43-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JaUdphvQ2+4F/M7k"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-43-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 42/45] net: stellaris_enet: convert SysBus
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


--JaUdphvQ2+4F/M7k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:19PM -0300, Eduardo Habkost wrote:
> From: C=E9dric Le Goater <clg@kaod.org>
>=20
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Message-Id: <20181001063803.22330-10-clg@kaod.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/stellaris_enet.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
> index 165562d788..3ee1e0f8a4 100644
> --- a/hw/net/stellaris_enet.c
> +++ b/hw/net/stellaris_enet.c
> @@ -473,9 +473,9 @@ static NetClientInfo net_stellaris_enet_info =3D {
>      .receive =3D stellaris_enet_receive,
>  };
> =20
> -static int stellaris_enet_init(SysBusDevice *sbd)
> +static void stellaris_enet_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      stellaris_enet_state *s =3D STELLARIS_ENET(dev);
> =20
>      memory_region_init_io(&s->mmio, OBJECT(s), &stellaris_enet_ops, s,
> @@ -489,7 +489,6 @@ static int stellaris_enet_init(SysBusDevice *sbd)
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> =20
>      stellaris_enet_reset(s);
> -    return 0;
>  }
> =20
>  static Property stellaris_enet_properties[] =3D {
> @@ -500,9 +499,8 @@ static Property stellaris_enet_properties[] =3D {
>  static void stellaris_enet_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D stellaris_enet_init;
> +    dc->realize =3D stellaris_enet_realize;
>      dc->props =3D stellaris_enet_properties;
>      dc->vmsd =3D &vmstate_stellaris_enet;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JaUdphvQ2+4F/M7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPZsACgkQbDjKyiDZ
s5InPhAAjofTEnoZcH4eM733YnaRa6hiPq2Q1G2qjRLIY8UzfSgff+Ewu1Qg2fWT
RGy75W9W1vCacsU79NwPwpnstD+cI/drmVXLzkr4SzoQ358CJg5p+4hfD/jRyOuB
dD/SGjIPkJuc2PTdHspvp+q3xkVkHN9d9RHIf/mpojFm+XeOU65ije0gYSBWnK/7
scfJwt13gNyGpn7//b4suh4YsUAnMeH+fSgt/znaGLguLeZRm4AC3bTeCXKpC1pg
74kzMW+zLlgzgscstA/qHnaeNIAP/DzKPvQkjo/hR9H2n/ARJDMieEN9ny7YaTt/
hUMhlqCE+pSjUicFjOxA+59SvKOwX2KEYDwKC3+XLPXpmxisrciRgNapaPfdR6N1
XOrbInQQtJk0WOOOgCWzjEZr02BQ7EL8xsSTLU0UNFqAQFtmrMU2pY0HtQiNYUrX
IptBN7Ajbtd7WBN/zL2fMQWm5w4OPhRS/bKZtv6qAo0C1q6A66FB+67MlkcjeAjU
Ci63dlt4cUPir8ZIycK+p1L+e1ynsspBh8JqzGwHaof/UmWv23sip71Pl0K+tjGY
mtLa6M/IxWZiJCm62e5FSuJK6j6lZowhBY/uOsSlRlwrkc4dyopkNGAMHXpoR0Em
niWEI+ADeuoVf2VMYr0zw5R33o9REzb2GmMYkggxX9RMFlyCU1o=
=iHIh
-----END PGP SIGNATURE-----

--JaUdphvQ2+4F/M7k--

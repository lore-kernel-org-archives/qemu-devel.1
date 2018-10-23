Received: from eggs.gnu.org ([2001:4830:134:3::10]:36803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEyhM-0006fR-SI
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gEybx-00075e-Jx
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 11:28:50 -0400
Date: Tue, 23 Oct 2018 16:25:14 +0100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181023152514.GT12127@umbus.hotspot.internet-for-guests.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
	<20181018200422.4358-40-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9r3HF47jptiQlX4s"
Content-Disposition: inline
In-Reply-To: <20181018200422.4358-40-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PULL 39/45] net: mipsnet: convert SysBus init
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


--9r3HF47jptiQlX4s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 18, 2018 at 05:04:16PM -0300, Eduardo Habkost wrote:
> From: C=E9dric Le Goater <clg@kaod.org>
>=20
> Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Message-Id: <20181001063803.22330-7-clg@kaod.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/net/mipsnet.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
> index 5a63df7ccb..03b3104278 100644
> --- a/hw/net/mipsnet.c
> +++ b/hw/net/mipsnet.c
> @@ -236,9 +236,9 @@ static const MemoryRegionOps mipsnet_ioport_ops =3D {
>      .impl.max_access_size =3D 4,
>  };
> =20
> -static int mipsnet_sysbus_init(SysBusDevice *sbd)
> +static void mipsnet_realize(DeviceState *dev, Error **errp)
>  {
> -    DeviceState *dev =3D DEVICE(sbd);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      MIPSnetState *s =3D MIPS_NET(dev);
> =20
>      memory_region_init_io(&s->io, OBJECT(dev), &mipsnet_ioport_ops, s,
> @@ -249,8 +249,6 @@ static int mipsnet_sysbus_init(SysBusDevice *sbd)
>      s->nic =3D qemu_new_nic(&net_mipsnet_info, &s->conf,
>                            object_get_typename(OBJECT(dev)), dev->id, s);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> -
> -    return 0;
>  }
> =20
>  static void mipsnet_sysbus_reset(DeviceState *dev)
> @@ -267,9 +265,8 @@ static Property mipsnet_properties[] =3D {
>  static void mipsnet_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> -    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
> =20
> -    k->init =3D mipsnet_sysbus_init;
> +    dc->realize =3D mipsnet_realize;
>      set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
>      dc->desc =3D "MIPS Simulator network device";
>      dc->reset =3D mipsnet_sysbus_reset;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9r3HF47jptiQlX4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvPPVoACgkQbDjKyiDZ
s5Jetw/+LizyhaV6sECK7hs0ZFnFzOYGo78xwYx4W6ZZn7tbKkgG0o2OgJP6VuJn
sIZQd7TwOa57Ca0HepehcyJK7WjuwdbCD+oOUayrhZJIM4PMENTu2GzZbo+hoXi7
nbjtqIU4HYEjOUtB+wCI19iuxFc8rfwYdm8/881x3s0OD/HfDgVRJHTYVjf/9zRc
fBJCFkbF7QiFYwyvWTzKDPAoCJHOeXfCPxQhE3EpWPiA2HYOn5ubsIEifNHtEQLG
lSshwCp7icutHMD8JYH2LSFZ3zI2YUfT4hJqcnxm4I1WLUDDk+dQPjA05a9/Zd8c
cIbNmK6x0o+EP79rL+uvGFtq6UzEu8w4PwJk2qSgN/L8iqdHNUJatXs/x7cSa2gf
k5MyCKJ6mMUArEEGo6p8TyPHniL8idsbRq4n18Lbp6vDOO2ZTW+jiMOnKbEb++2B
pDtpd8N70zmq/1xBA50S8rmFV61/ny1rzN6MFRy94BDHz7+HuihZm+cWe/64DqwK
uEdt/w4tNWR0Vdc6hfWknUXLxv1VFTySGcYhYhe0ES5whQythrN1roGD7HuKGoMO
1Tqxpe0qLLJ0UhezWnIRxFrgy8SUnKh7Atw36YWCH6bIfYrMZ6gANGiX3UMz8mUK
GouVdErwdX4bPmtYxEaozCW2K812u9sMANiZoyHYacCAnr45u7o=
=AqMn
-----END PGP SIGNATURE-----

--9r3HF47jptiQlX4s--

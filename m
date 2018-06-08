Received: from eggs.gnu.org ([2001:4830:134:3::10]:52854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u2-0007aI-1Y
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u0-0007dQ-Vc
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:30 -0400
Date: Fri, 8 Jun 2018 13:28:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608032842.GI3344@umbus.fritz.box>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline
In-Reply-To: <20180607165218.9558-4-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/8] spapr: move all DIMM checks into
 spapr_memory_plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Greg Kurz <groug@kaod.org>


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:52:13PM +0200, David Hildenbrand wrote:
> Let's clean the hotplug handler up by moving everything into
> spapr_memory_plug().
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d038f3243e..a12be24ca9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3136,14 +3136,22 @@ static void spapr_add_lmbs(DeviceState *dev, uint=
64_t addr_start, uint64_t size,
>  }
> =20
>  static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *=
dev,
> -                              uint32_t node, Error **errp)
> +                              Error **errp)
>  {
>      Error *local_err =3D NULL;
>      sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *mr;
>      uint64_t align, size, addr;
> +    uint32_t node;
> +
> +    if (!smc->dr_lmb_enabled) {
> +        error_setg(&local_err, "Memory hotplug not supported for this ma=
chine");
> +        goto out;
> +    }
> +    node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP, NU=
LL);
> =20
>      mr =3D ddc->get_memory_region(dimm, &local_err);
>      if (local_err) {
> @@ -3568,19 +3576,8 @@ out:
>  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
> -    MachineState *ms =3D MACHINE(hotplug_dev);
> -    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
> -
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        int node;
> -
> -        if (!smc->dr_lmb_enabled) {
> -            error_setg(errp, "Memory hotplug not supported for this mach=
ine");
> -            return;
> -        }
> -        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP=
, NULL);
> -
> -        spapr_memory_plug(hotplug_dev, dev, node, errp);
> +        spapr_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          spapr_core_plug(hotplug_dev, dev, errp);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ9+oACgkQbDjKyiDZ
s5JWLQ//WTI4ymLleGtK8G6HAkKTODaOpEN2yQ10trBd4zgsS/oBoO3jlP08GYfw
JliPRJ2KjY5CGNDu2JuIJv8v+adqfz7eKUXcLWSZhI9Lw4qj2acEg2WKQI0Q/+Fy
uEKcap16061UB7tf/HwvvL51IWjmxes6U4pKYSAMNrq2Dy5rHOhsX56ggGb1ILyt
hx9VH/XI0clbUMH3rWTfNfIOz5E9+iu9a1Yf+iKrFw7aba/eamxbAfIH1nuUwVu0
Z44zu/5fPHP4BDn7P4IcFIEsKH/Z2Ka5LjzixUPllVwWk7LE9Pkes5+AGoHGL03J
GX5760zYLkyQkm4CGHhLO8KNLkwMkcrUuV6TgqDPoJEYIo4T/ty9gbUaK61qguuD
AqRx/V754yaJleIn1wiHV8IhiClOCMFPVzdsq0p68W24NOIMy7DhAuFpi2JqlGPg
YoWL3ltPZoVxOkeuzD8/aii3EZpYllzZDs7ZAE39QYzfB6V9SknknAg2/ORlPY/P
JB4fIWF//Rl4hkI7UUeZ4xxDXIDKVnCiEqiaIv7Y5kyl7pGy0nyqIbYNKc+lhYoP
+vvR6xLZShPWqB4I4IUBf6RDBF61VpxWPTQfYhuBPKx6WLuL0dtaqo71H15P2aLK
lSDJZhiiXzivi8CnyqdGK0vxpF9rdOEleffmK6Df+KOfcqlNb8w=
=siAG
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--

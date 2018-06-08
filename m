Received: from eggs.gnu.org ([2001:4830:134:3::10]:52859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u2-0007aL-9p
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u1-0007dW-8A
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:30 -0400
Date: Fri, 8 Jun 2018 13:30:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608033032.GL3344@umbus.fritz.box>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PpocKf6TCvdC9BKE"
Content-Disposition: inline
In-Reply-To: <20180607165218.9558-7-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 6/8] spapr: handle pc-dimm unplug via
 hotplug handler chain
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


--PpocKf6TCvdC9BKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:52:16PM +0200, David Hildenbrand wrote:
> Let's handle it via hotplug_handler_unplug(). E.g. necessary to hotplug/
> unplug memory devices (which a pc-dimm is) later.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bcb72d9fa7..0a8a3455d6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3298,7 +3298,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_s=
tate(sPAPRMachineState *ms,
>  /* Callback to be called during DRC release. */
>  void spapr_lmb_release(DeviceState *dev)
>  {
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_hotplug_handler(=
dev));
> +    HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_ctrl);
>      sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC_DIM=
M(dev));
> =20
>      /* This information will get lost if a migration occurs
> @@ -3316,9 +3317,17 @@ void spapr_lmb_release(DeviceState *dev)
> =20
>      /*
>       * Now that all the LMBs have been removed by the guest, call the
> -     * pc-dimm unplug handler to cleanup up the pc-dimm device.
> +     * unplug handler chain. This can never fail.
>       */
> -    pc_dimm_memory_unplug(dev, MACHINE(spapr));
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +}
> +
> +static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState=
 *dev)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
> +    sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC_DIM=
M(dev));
> +
> +    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
>      object_unparent(OBJECT(dev));
>      spapr_pending_dimm_unplugs_remove(spapr, ds);
>  }
> @@ -3589,6 +3598,9 @@ static void spapr_machine_device_plug(HotplugHandle=
r *hotplug_dev,
>  static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        spapr_memory_unplug(hotplug_dev, dev);
> +    }
>  }
> =20
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_=
dev,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PpocKf6TCvdC9BKE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ+FgACgkQbDjKyiDZ
s5JUnBAAtIDJYX0pgrf/SDri871NXT8JmJb0qH7kIOHjRS71am630A/nZlfNRcft
a1qWLyOJ5EoQhEd+3buUk1agyuESjyQKA8lGAhxvQ9joOHzIxqJJS0q49/MCOO4i
RLKD780kBoMHWA0S0iVGnnZWiXRleV0hQerFhWoSNxmOFs490OFY6oubF6jqqndx
Yi9WoyQ3a0dVf9SmV1OvzWsN/H2698iiAHImfeHxtZ0zOCJ0V+KaRIDSAvT7rHLM
o5cdzlQXPb1iAEtBDObvVmhw5UUa6PX8oHkahLBY2mMaBk0PCfqoDbHrZIk/t2Jg
rAn7KXbHav6dHHKQDtQWzHP35To41tMCYMEnWnvXCpKrwQXXdzIluv9nwwKAJGIz
2n6WMsVBhoZb3Nzdm8udFbHP79Q3wn93r7x1loSSdtQXyqcQeLiBoSE1Ca3Uv4dL
sXRgPBXYk3D74yKNUhoG/WpdqVI+zgEsMtJgOByJJOgwt3hxu7icJktvJ+IL930a
iCq/e9iS+VhLrUevDpHpdPXPCtMM99SY4AxJLzb1NLTnw0/nj2MG2370NEQV2ozO
ElJ88O8wDwSCFLQ2FKZkGY1HZVJHJzZOQUmWshGWQSXcB1zDjQMoA71XiQfA1ohj
ZVacXuB+0UgNbwo6MT4NTl6Qa2eMZVoNevEzuWOF3HxyiHkiHUA=
=FU+m
-----END PGP SIGNATURE-----

--PpocKf6TCvdC9BKE--

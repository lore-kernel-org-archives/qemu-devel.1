Received: from eggs.gnu.org ([2001:4830:134:3::10]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u5-0007bp-LI
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u4-0007fL-Jy
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:33 -0400
Date: Fri, 8 Jun 2018 13:31:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608033107.GM3344@umbus.fritz.box>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eWmFpGZayiNrn4FL"
Content-Disposition: inline
In-Reply-To: <20180607165218.9558-8-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 7/8] spapr: handle cpu core unplug via
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


--eWmFpGZayiNrn4FL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:52:17PM +0200, David Hildenbrand wrote:
> Let's handle it via hotplug_handler_unplug() to make plug/unplug code
> look symmetrical.
>=20
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 0a8a3455d6..994deea8cf 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3415,7 +3415,15 @@ static void *spapr_populate_hotplug_cpu_dt(CPUStat=
e *cs, int *fdt_offset,
>  /* Callback to be called during DRC release. */
>  void spapr_core_release(DeviceState *dev)
>  {
> -    MachineState *ms =3D MACHINE(qdev_get_hotplug_handler(dev));
> +    HotplugHandler *hotplug_ctrl =3D qdev_get_hotplug_handler(dev);
> +
> +    /* Call the unplug handler chain. This can never fail. */
> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +}
> +
> +static void spapr_core_unplug(HotplugHandler *hotplug_dev, DeviceState *=
dev)
> +{
> +    MachineState *ms =3D MACHINE(hotplug_dev);
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
>      CPUCore *cc =3D CPU_CORE(dev);
>      CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL);
> @@ -3600,6 +3608,8 @@ static void spapr_machine_device_unplug(HotplugHand=
ler *hotplug_dev,
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          spapr_memory_unplug(hotplug_dev, dev);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> +        spapr_core_unplug(hotplug_dev, dev);
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eWmFpGZayiNrn4FL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ+HsACgkQbDjKyiDZ
s5ID4BAAktkEdi1f4EY+wLq3sg4udjQLgeKdklMhlyV9Jy1KU6Gco7OHjpEyFu3z
l1/oboGW5/1bC1iss1fbD+YOBX0vynZihKAf9QPLUdisSA5UOTMmFnXaBtzrOwP7
VtGJ9zyzouAntev8S0CxGy2pMqVLy4BHVLZoezIdo3KHMHoovpg6GRbYPCBLmSNE
jMNnJyN5/uGOYd4qXPxlFR7JAMXEfza+Zaa1sfkH29y5ZsJHT/BsTjljfIsbazWk
zDULMlB2JQtwHPz3y4tcsrzU4SJVaKvRLnPxzqwE/bAWIT4CfS5zD7JqJXj3p4gh
SehwoJ59lbzCzFAVRBHt3AXoRDDQ/3Q8h7d2Gkzcmosy8WacSk9pDC6+C5LnG9+c
g/y4r+bj0Sb40bmgk9kV+Ea4qTAonJ/qgo2+IfKrNWf5SPu93PR9Bnc9+2MB1YLG
v3aEXUucmtSy7LM330FLD4DVK4obdxwJO3jKiTHCWmAsQ0a4RU92tk2s8LYk8lRx
Ql6L3NM9v+nqUHfUpitcdOkvP4X3IBqK5I0Lb8bgRSQ35e4uAAtqITI/XbmWLJGC
UhvMVejKSEUkKgy0aNIDGVGrNaNIsWNZTdoNxKBpaRyWduKhXVTj7zE266qRUzG7
plDGe8tCHX0juj7RcOdEWnt2jIXJiRtM/mCpJHdlTrDDcxHEpKM=
=GB4d
-----END PGP SIGNATURE-----

--eWmFpGZayiNrn4FL--

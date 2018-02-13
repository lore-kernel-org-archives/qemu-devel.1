Received: from eggs.gnu.org ([2001:4830:134:3::10]:40899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTNH-00076Z-VO
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:43:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTNG-00038B-PL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:43:28 -0500
Date: Tue, 13 Feb 2018 16:43:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180213054315.GO11634@umbus.fritz.box>
References: <20180209075503.16996-1-aik@ozlabs.ru>
	<20180209075503.16996-5-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q4RbCnAmn9VrkE5p"
Content-Disposition: inline
In-Reply-To: <20180209075503.16996-5-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v7 4/4] ppc/spapr,
 vfio: Turn off MSIX emulation for VFIO devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>


--Q4RbCnAmn9VrkE5p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 06:55:03PM +1100, Alexey Kardashevskiy wrote:
> This adds a possibility for the platform to tell VFIO not to emulate MSIX
> so MMIO memory regions do not get split into chunks in flatview and
> the entire page can be registered as a KVM memory slot and make direct
> MMIO access possible for the guest.
>=20
> This enables the entire MSIX BAR mapping to the guest for the pseries
> platform in order to achieve the maximum MMIO preformance for certain
> devices.
>=20
> Tested on:
> LSI Logic / Symbios Logic SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I still think having the property on the machine is an uglier option
than having it on the device, but Alex didn't like that, so I'll roll
with it.

Reivewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> Need to split this in two?
> ---
>  hw/ppc/spapr.c |  7 +++++++
>  hw/vfio/pci.c  | 13 +++++++++++++
>  2 files changed, 20 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index eb3e1a7..14d8ecb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2855,6 +2855,11 @@ static void spapr_set_modern_hotplug_events(Object=
 *obj, bool value,
>      spapr->use_hotplug_event_source =3D value;
>  }
> =20
> +static bool spapr_get_msix_emulation(Object *obj, Error **errp)
> +{
> +    return true;
> +}
> +
>  static char *spapr_get_resize_hpt(Object *obj, Error **errp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -2936,6 +2941,8 @@ static void spapr_instance_init(Object *obj)
>      object_property_set_description(obj, "vsmt",
>                                      "Virtual SMT: KVM behaves as if this=
 were"
>                                      " the host's SMT mode", &error_abort=
);
> +    object_property_add_bool(obj, "vfio-no-msix-emulation",
> +                             spapr_get_msix_emulation, NULL, NULL);
>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ae9098d..4a03085 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1580,6 +1580,19 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, in=
t pos, Error **errp)
>       */
>      memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
> =20
> +    /*
> +     * The emulated machine may provide a paravirt interface for MSIX se=
tup
> +     * so it is not strictly necessary to emulate MSIX here. This becomes
> +     * helpful when frequently accessed MMIO registers are located in
> +     * subpages adjacent to the MSIX table but the MSIX data containing =
page
> +     * cannot be mapped because of a host page size bigger than the MSIX=
 table
> +     * alignment.
> +     */
> +    if (object_property_get_bool(OBJECT(qdev_get_machine()),
> +                                 "vfio-no-msix-emulation", NULL)) {
> +        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
> +    }
> +
>      return 0;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Q4RbCnAmn9VrkE5p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqCevIACgkQbDjKyiDZ
s5JK9hAAtao8NyvORd168yUPqBiTQKPQOYRVBef1nrhW4dv1m5fsOAkxhkmp+rzo
FswSmpB27kHNwU0EDayV1srnxvOsEad0isiVkY/P5u4ICE+heptBfYNS9wY84zWR
rLh/CB1r5csRozAvj2ToAnzR5iEvqm13BBJGVE9KIL0v/qx0+DuWr3hNQeSSi0jw
axCxDjqE5WloBDUA45BUv0rIysGeenAthbfTzBYdYnEv1WoyTxnx/B14SUJUaAM9
fY+ylvXodH+iLak814367KeVB11PahmjaXLJKTD/EZ+iLjnHJO82wx79e6vI8mPS
Y/qf1wT9gww6ohbuj41+lV+JQoC2wDRYgIwJg3S5FYYocsqxp52MU160Yt/Zdt/c
eN9l+1ffRvrr4d7EEMR8L68kJYRTjIc8jUhUU0SusIpPlTsjEe21YK2ph/YkYBIj
lu6aj9h1ubwqL73t5YZH9pFkAXLmxpHbREk1McbEmztpVfGuj1pxhnh7yfiefK4B
tgA6BMzAx40xYzlKYv52zfRpHlMinFtCIsiPoFGQbmH4cKe9hl09e1u09El7imqP
QnbcS8WuVTT96JPp+e/WDcwTzPvLXqGRAk8ckB6zM/p8Yn+nqpPykkVpl5chCHls
Xu+3XVuzDdOj6uzmzdgjbyyUvMkPBCMtjDPXs0F5smndWaJdGsM=
=whes
-----END PGP SIGNATURE-----

--Q4RbCnAmn9VrkE5p--

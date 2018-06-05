Received: from eggs.gnu.org ([2001:4830:134:3::10]:52251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0eZ-0007Gz-5x
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0eY-0006Me-4w
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:20:51 -0400
Date: Tue, 5 Jun 2018 11:12:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180605011255.GH5140@umbus.fritz.box>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-9-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
In-Reply-To: <20180517081527.14410-9-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 08/14] spapr: handle pc-dimm unplug via
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
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 10:15:21AM +0200, David Hildenbrand wrote:
> Let's handle it via hotplug_handler_unplug(). E.g. necessary to hotplug/
> unplug memory devices (which a pc-dimm is) later.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/ppc/spapr.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2f315f963b..286c38c842 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3291,7 +3291,8 @@ static sPAPRDIMMState *spapr_recover_pending_dimm_s=
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
> @@ -3309,9 +3310,21 @@ void spapr_lmb_release(DeviceState *dev)
> =20
>      /*
>       * Now that all the LMBs have been removed by the guest, call the
> -     * pc-dimm unplug handler to cleanup up the pc-dimm device.
> +     * unplug handler chain. This can never fail.
>       */
> -    pc_dimm_memory_unplug(dev, MACHINE(spapr));
> +    hotplug_ctrl =3D qdev_get_hotplug_handler(dev);

You're double initializing hotplug_ctrl to the same thing here, AFAICT.

> +    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
> +}
> +
> +static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState=
 *dev,
> +                                Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(hotplug_dev);
> +    sPAPRDIMMState *ds =3D spapr_pending_dimm_unplugs_find(spapr, PC_DIM=
M(dev));
> +
> +    g_assert(ds);
> +    g_assert(!ds->nr_lmbs);
> +    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
>      object_unparent(OBJECT(dev));
>      spapr_pending_dimm_unplugs_remove(spapr, ds);
>  }
> @@ -3608,7 +3621,9 @@ static void spapr_machine_device_unplug(HotplugHand=
ler *hotplug_dev,
>      Error *local_err =3D NULL;
> =20
>      /* final stage hotplug handler */
> -    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> +        spapr_memory_unplug(hotplug_dev, dev, &local_err);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>          hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
>                                 &local_err);
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsV45cACgkQbDjKyiDZ
s5LITRAA30C/tIC8qr1SqRPiUeJYhSYMe2xumUbXtVHOfmOZbn3YnbP5MTB2+drQ
ew5bEBbAK9stIIfhv2jylBJZ1MEuAzzWWs6DozFMKJ5y6Ywo/4L+hWCFMfHrOk73
F6yAMlf38tuKSaPv6v+XB/WDSfv/BOZDChrJ2FUQnLO0lolo8yU1qKIYPqD0Jgqh
sd90UbTknJysXuJbit5FZJIaHjXj//bCiDUqtx++U/47EQn8gx6iybjBYSYVpJhR
81vlLc+ayGGLG1uJDkCL7AnAe26XJVRnEETAXGMt3KMRO81ySx5BJFflOXDm79nc
c53qHqtTNlzmPIjlH2HludDp8wfP8kmYhWejsSSmaz8LGTza/WeiWitH39D6/nig
rXMUvE+w4pbO11eKIa5in4gbwWbj00m2JYIprMyyAIJk4BQz7/sgh2a+o/UN0Nhe
As73Mam44wXBHVe2JbQ+RGVy28dmu2Ib6xM5LLqRsk58x2Y2Bro8yGIaFpsJsaa/
9uHq7aerVygu1C6rpvONgo562X9X8eIf9mF5DucSS8I0nfRZM/b9zemdGaSmE65O
NomqQ/pQ1lCPpq321Ot40a48H8k1nijDSgXpZr1LLxOmZeZYJ8gxljRQ8bRHij6s
hztr4baCLLd7eBejzpD+m2xPDXSIn8SkkWP0GaXXvZa8umLC2Z8=
=y+UB
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--

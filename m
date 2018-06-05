Received: from eggs.gnu.org ([2001:4830:134:3::10]:52249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0eZ-0007Gy-1d
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:20:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0eY-0006Mj-5b
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:20:51 -0400
Date: Tue, 5 Jun 2018 11:13:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180605011354.GI5140@umbus.fritz.box>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dCSxeJc5W8HZXZrD"
Content-Disposition: inline
In-Reply-To: <20180517081527.14410-10-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 09/14] spapr: handle cpu core unplug via
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


--dCSxeJc5W8HZXZrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 10:15:22AM +0200, David Hildenbrand wrote:
> Let's handle it via hotplug_handler_unplug().
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 286c38c842..13d153b5a6 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3412,7 +3412,16 @@ static void *spapr_populate_hotplug_cpu_dt(CPUStat=
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
dev,
> +                              Error **errp)
> +{
> +    MachineState *ms =3D MACHINE(hotplug_dev);
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
>      CPUCore *cc =3D CPU_CORE(dev);
>      CPUArchId *core_slot =3D spapr_find_cpu_slot(ms, cc->core_id, NULL);
> @@ -3623,6 +3632,8 @@ static void spapr_machine_device_unplug(HotplugHand=
ler *hotplug_dev,
>      /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          spapr_memory_unplug(hotplug_dev, dev, &local_err);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> +        spapr_core_unplug(hotplug_dev, dev, &local_err);
>      } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
>          hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
>                                 &local_err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dCSxeJc5W8HZXZrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsV49IACgkQbDjKyiDZ
s5LMiQ//SYwSLoH0b+S9y6xP+OR8ri9c4LJ4zNuPMmMw5bUJO+Bd2hFbHdfSw/Rv
ufUCMWUJEujhe2ltJsfWY1u6buZfZxMpRexDYVNAArXiVwFCxnELoVq1T4BQZiVA
TykWbTSO7LE4Pw3nauqnJrq/cWcFBBRegh2MJ2dznmObeDFKzCELEPItndq/c8//
1a5bEZWrffuOD8wULj0y/bGf1R7YeMSwq6VFCAz6u3lJSe8hub/BaAlgs3nDqcPc
hJBbvH9oSvan06KWr0pCJ9gBsdbt121+oae0JWzjFaGPteLA6KYXBMs8rYFcpah4
s4swKh3I7pr+2FHNxL4XNdM4r24SGphcysCQyscX4ksNyFyLoH0I+ZfVM75/En09
xZEi19ZER3hQnTrhFSE7ZEa+FtE4rlVCmsdbHh/KVT+l5/nFQ1nvVUX60im/g7l6
d+QNoIDBauhRKLDn3OVYglazntOK8zw6wr1TUo7+uGJWoLaX/QWmr2hqKnqmH9AN
z162QQ3h2Eu4jpwcNhTwte1VCJaUlci1FApEcpilpn64OVBgfnA9pAI0Xtk3oEic
wNvCXBSzVTxXWWXjL9GAOd6G1BjMNcV4Kr7CcYSdXUeQRiOSgJWNnTsI8xlqTKb7
2fb7pHRwIwr+a3I6ZFOkz7f+AXsiOlvoxpNVV1PpfJUBGm/ngGQ=
=+skJ
-----END PGP SIGNATURE-----

--dCSxeJc5W8HZXZrD--

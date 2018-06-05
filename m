Received: from eggs.gnu.org ([2001:4830:134:3::10]:50509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0TY-0002n4-Fe
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQ0TX-0001wS-6j
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:09:28 -0400
Date: Tue, 5 Jun 2018 11:08:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180605010840.GF5140@umbus.fritz.box>
References: <20180517081527.14410-1-david@redhat.com>
	<20180517081527.14410-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <20180517081527.14410-7-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 06/14] spapr: prepare for multi stage
 hotplug handlers
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


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 10:15:19AM +0200, David Hildenbrand wrote:
> For multi stage hotplug handlers, we'll have to do some error handling
> in some hotplug functions, so let's use a local error variable (except
> for unplug requests).
>=20
> Also, add code to pass control to the final stage hotplug handler at the
> parent bus.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/ppc/spapr.c | 54 +++++++++++++++++++++++++++++++++++++++++++---------=
--
>  1 file changed, 43 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ebf30dd60b..b7c5c95f7a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3571,27 +3571,48 @@ static void spapr_machine_device_plug(HotplugHand=
ler *hotplug_dev,
>  {
>      MachineState *ms =3D MACHINE(hotplug_dev);
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(ms);
> +    Error *local_err =3D NULL;
> =20
> +    /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          int node;
> =20
>          if (!smc->dr_lmb_enabled) {
> -            error_setg(errp, "Memory hotplug not supported for this mach=
ine");
> -            return;
> +            error_setg(&local_err,
> +                       "Memory hotplug not supported for this machine");
> +            goto out;
>          }
> -        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP=
, errp);
> -        if (*errp) {
> -            return;
> +        node =3D object_property_get_uint(OBJECT(dev), PC_DIMM_NODE_PROP,
> +                                        &local_err);
> +        if (local_err) {
> +            goto out;
>          }
>          if (node < 0 || node >=3D MAX_NODES) {
> -            error_setg(errp, "Invaild node %d", node);
> -            return;
> +            error_setg(&local_err, "Invaild node %d", node);
> +            goto out;
>          }
> =20
> -        spapr_memory_plug(hotplug_dev, dev, node, errp);
> +        spapr_memory_plug(hotplug_dev, dev, node, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> -        spapr_core_plug(hotplug_dev, dev, errp);
> +        spapr_core_plug(hotplug_dev, dev, &local_err);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_plug(dev->parent_bus->hotplug_handler, dev, &loc=
al_err);
> +    }
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
> +static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +
> +    /* final stage hotplug handler */
> +    if (dev->parent_bus && dev->parent_bus->hotplug_handler) {

As I think Igor said on the equivalent PC patch, I don't quite get
this.  Isn't this already handled by the generic hotplug code picking
up the bus's hotplug handler if the machine doesn't supply one?

> +        hotplug_handler_unplug(dev->parent_bus->hotplug_handler, dev,
> +                               &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
> =20
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_=
dev,
> @@ -3618,17 +3639,27 @@ static void spapr_machine_device_unplug_request(H=
otplugHandler *hotplug_dev,
>              return;
>          }
>          spapr_core_unplug_request(hotplug_dev, dev, errp);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_unplug_request(dev->parent_bus->hotplug_handler,=
 dev,
> +                                       errp);
>      }
>  }
> =20
>  static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> +    Error *local_err =3D NULL;
> +
> +    /* final stage hotplug handler */
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        spapr_memory_pre_plug(hotplug_dev, dev, errp);
> +        spapr_memory_pre_plug(hotplug_dev, dev, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> -        spapr_core_pre_plug(hotplug_dev, dev, errp);
> +        spapr_core_pre_plug(hotplug_dev, dev, &local_err);
> +    } else if (dev->parent_bus && dev->parent_bus->hotplug_handler) {
> +        hotplug_handler_pre_plug(dev->parent_bus->hotplug_handler, dev,
> +                                 &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
> =20
>  static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,
> @@ -3988,6 +4019,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      mc->get_default_cpu_node_id =3D spapr_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids =3D spapr_possible_cpu_arch_ids;
>      hc->unplug_request =3D spapr_machine_device_unplug_request;
> +    hc->unplug =3D spapr_machine_device_unplug;
> =20
>      smc->dr_lmb_enabled =3D true;
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsV4pgACgkQbDjKyiDZ
s5IIBhAArP0TEDcAf+Bampbh8JTP1aeYSZIez77bNmWVAPApCcBYT1pnmt/C8iUs
Bosi6pV5V8lBpTtwEMkie7U37VKmqKUte/vgrYWZNY5yyVa9XVeWd/Q1Owt6BCNE
Oqjn9LqfzpF1FwFsu6x2JBfKreobApf9UOPjVhsvuTCiEycjFppV8lCtJqDyYW/e
rG0F/W4Pq3FPvs0fBBDTL5b7vDI4TVZtHVEBDR5Ot0LZa4hiBBAxFLJ42XaluEiD
TBcTIYmOVvVa4/oBG3gFkgf9NKfSHeG4sQ0sI6WEZyS/jvnzBEdgJDdQ9koP1MDe
yHREZRzwxefOc2YNomBS9JYrhbVBvWi9VYIyG6hCGrUisAl8oKiIlZZ4Y2zW5Y+U
pTEohFxwcxh9UHmtO69dcTup/iubPPkWiZsMwhhrQkEcuovLQJv+SsrmQRYIHMwt
iG0Acs7jZwgrPQj4+Fmchx+J/a4PiTieS53TlmZhPeSGo7kEhbFNZqrHG4rG0jeg
xK8cmaRjFx1LF2anrnSKf9LCvd5o/U4PXEmGzesYhgk50uhkt5Fxieu6guVnlCTa
LUeHQQfY9EdIxP/Y7f27CaGMaObU4HGjcQD/Dz2p0V/EdeCI6JY9Jnua79gSXQRk
juHVy8OCVFKdHGk5RfeE1ebv2Ao1zqxAtJFi88FqdLtGvzZv4uA=
=aBPS
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--

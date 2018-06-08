Received: from eggs.gnu.org ([2001:4830:134:3::10]:52856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u2-0007aJ-3I
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fR8u0-0007dE-P0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 00:21:30 -0400
Date: Fri, 8 Jun 2018 13:29:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608032928.GJ3344@umbus.fritz.box>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Tu8ztk+XgTAiG9Id"
Content-Disposition: inline
In-Reply-To: <20180607165218.9558-5-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 4/8] spapr: local error handling in
 hotplug handler functions
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


--Tu8ztk+XgTAiG9Id
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 07, 2018 at 06:52:14PM +0200, David Hildenbrand wrote:
> Let's introduce and use local error variables in the hotplug handler
> functions.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a12be24ca9..4447cb197f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3576,11 +3576,14 @@ out:
>  static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
> +    Error *local_err =3D NULL;
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        spapr_memory_plug(hotplug_dev, dev, errp);
> +        spapr_memory_plug(hotplug_dev, dev, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> -        spapr_core_plug(hotplug_dev, dev, errp);
> +        spapr_core_plug(hotplug_dev, dev, &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
> =20
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_=
dev,
> @@ -3588,10 +3591,11 @@ static void spapr_machine_device_unplug_request(H=
otplugHandler *hotplug_dev,
>  {
>      sPAPRMachineState *sms =3D SPAPR_MACHINE(OBJECT(hotplug_dev));
>      MachineClass *mc =3D MACHINE_GET_CLASS(sms);
> +    Error *local_err =3D NULL;
> =20
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
> -            spapr_memory_unplug_request(hotplug_dev, dev, errp);
> +            spapr_memory_unplug_request(hotplug_dev, dev, &local_err);
>          } else {
>              /* NOTE: this means there is a window after guest reset, pri=
or to
>               * CAS negotiation, where unplug requests will fail due to t=
he
> @@ -3599,25 +3603,32 @@ static void spapr_machine_device_unplug_request(H=
otplugHandler *hotplug_dev,
>               * the case with PCI unplug, where the events will be queued=
 and
>               * eventually handled by the guest after boot
>               */
> -            error_setg(errp, "Memory hot unplug not supported for this g=
uest");
> +            error_setg(&local_err,
> +                       "Memory hot unplug not supported for this guest");
>          }
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
>          if (!mc->has_hotpluggable_cpus) {
> -            error_setg(errp, "CPU hot unplug not supported on this machi=
ne");
> -            return;
> +            error_setg(&local_err,
> +                       "CPU hot unplug not supported on this machine");
> +            goto out;
>          }
> -        spapr_core_unplug_request(hotplug_dev, dev, errp);
> +        spapr_core_unplug_request(hotplug_dev, dev, &local_err);
>      }
> +out:
> +    error_propagate(errp, local_err);
>  }
> =20
>  static void spapr_machine_device_pre_plug(HotplugHandler *hotplug_dev,
>                                            DeviceState *dev, Error **errp)
>  {
> +    Error *local_err =3D NULL;
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        spapr_memory_pre_plug(hotplug_dev, dev, errp);
> +        spapr_memory_pre_plug(hotplug_dev, dev, &local_err);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPAPR_CPU_CORE)) {
> -        spapr_core_pre_plug(hotplug_dev, dev, errp);
> +        spapr_core_pre_plug(hotplug_dev, dev, &local_err);
>      }
> +    error_propagate(errp, local_err);
>  }
> =20
>  static HotplugHandler *spapr_get_hotplug_handler(MachineState *machine,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Tu8ztk+XgTAiG9Id
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsZ+BgACgkQbDjKyiDZ
s5KryhAA4+0bmAwY57vUjy6peZwZMYgRc76cdSJQTbpXCs6U0YJLWsJl4m+Y75qo
OopEMQE1r+3MTNtkIiA/ukmZqwpLhj4wIWKDsQ9Ikxv8cwLw3xgiFUv9++m68nzG
uUzTgBC9S8+0kXJo/gjRaSoZsT6xaQ/BRjotDSou+FxjALMUAYv9TmizPXDvWuLU
fcjFul7SOCVzbFgoAgkz4sWtvr+mkVQ4zzuOoqmBcO8VbwN1TpYuFRt4BGHheAGn
XNbuxqpsmG+1ZNkUCsh9GL7NbbAdjWO/jf8G5OBG4X0o2WWwXIqlBgQoTQv4EGbx
+YL9/feVaFW5t8FLRFGnLvfcEGKANXutJc2nC90YPYUfLQ0r9igMlzJWV0zYzxcX
UHJmnWyb9DE+B3K5qSLPyKH+CAham/gyA+kWdC2tR2wdP4XgVxe3iWujB2ni9i/K
jHys0nfTTAzPrAPWDUA0LSzmIqkIGwJLNnrk5bLbZnolZAYGiqQjsHgRjeBSnEQF
C/KamNGU2V9vLPcTVfiCOvNlhKjNyxYTLfXuE8xkQbnOkfFL76l33sNU8WaJnoBn
4/ILwjSJ0YYsEbO2WdWAQccYqNatu2fKFNhH65jpfWvmQimLMsjmXPpSu37o+Z7N
HRraDXZz2a9SQ1rwRA3nEY8tEnfCY6Br73yBasIqRazI6mqdG4Y=
=J3FT
-----END PGP SIGNATURE-----

--Tu8ztk+XgTAiG9Id--

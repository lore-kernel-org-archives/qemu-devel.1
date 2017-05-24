Received: from eggs.gnu.org ([2001:4830:134:3::10]:38540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDPgC-00080D-PW
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dDPgB-0000iP-Hk
	for qemu-devel@nongnu.org; Wed, 24 May 2017 02:21:56 -0400
Date: Wed, 24 May 2017 15:07:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170524050754.GW30246@umbus.fritz.box>
References: <20170523111812.13469-1-lvivier@redhat.com>
	<20170523111812.13469-4-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O7hm+SMpb/lu0d4d"
Content-Disposition: inline
In-Reply-To: <20170523111812.13469-4-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] spapr: disable hotplugging without OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>


--O7hm+SMpb/lu0d4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 01:18:11PM +0200, Laurent Vivier wrote:
> If the OS is not started, QEMU sends an event to the OS
> that is lost and cannot be recovered. An unplug is not
> able to restore QEMU in a coherent state.
> So, while the OS is not started, disable CPU and memory hotplug.
> We use option vector 6 to know if the OS is started
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Urgh.. I'm not terribly confident that this is really correct.  As
discussed on the previous patch, you're essentially using OV6 as a
flag that CAS is complete.

But while it undoubtedly makes the race window much smaller, I don't
see that there's any guarantee the guest OS will really be able to
handle hotplug events immediately after CAS.

In particular if the CAS process completes partially but then needs to
trigger a reboot, I think that would end up setting the ov6 variable,
but the OS would definitely not be in a state to accept events.

Mike, I really think we need some input from someone familiar with how
these hotplug events are supposed to work.  What do we need to do to
handle lost or stale events, such as those delivered when an OS is not
booted.

> ---
>  hw/ppc/spapr.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index eceb4cc..2e9320d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2625,6 +2625,7 @@ out:
>  static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
>                                  Error **errp)
>  {
> +    sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> @@ -2645,6 +2646,13 @@ static void spapr_memory_pre_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
>          goto out;
>      }
> =20
> +    if (dev->hotplugged) {
> +        if (!ms->os_name) {
> +            error_setg(&local_err, "Memory hotplug not supported without=
 OS");
> +            goto out;
> +        }
> +    }
> +
>  out:
>      error_propagate(errp, local_err);
>  }
> @@ -2874,6 +2882,7 @@ static void spapr_core_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>                                  Error **errp)
>  {
>      MachineState *machine =3D MACHINE(OBJECT(hotplug_dev));
> +    sPAPRMachineState *ms =3D SPAPR_MACHINE(machine);
>      MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
>      Error *local_err =3D NULL;
>      CPUCore *cc =3D CPU_CORE(dev);
> @@ -2884,9 +2893,16 @@ static void spapr_core_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>      int node_id;
>      int index;
> =20
> -    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> -        error_setg(&local_err, "CPU hotplug not supported for this machi=
ne");
> -        goto out;
> +    if (dev->hotplugged) {
> +        if (!mc->has_hotpluggable_cpus) {
> +            error_setg(&local_err,
> +                       "CPU hotplug not supported for this machine");
> +            goto out;
> +        }
> +        if (!ms->os_name) {
> +            error_setg(&local_err, "CPU hotplug not supported without OS=
");
> +            goto out;
> +        }
>      }
> =20
>      if (strcmp(base_core_type, type)) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--O7hm+SMpb/lu0d4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZJRUqAAoJEGw4ysog2bOSeS4P/0ECR04wsvcnVoXwzk3ZpPbI
IEwlPB4TxpV7B0xUYcLlngEfPqnuGs1Zg86hMFkBgkFPK6+720YMAEEyAez43QsW
6ffrFTzR9LejAuex1WR4stZxMoixycpjXRsQoXR9p3jW0nbLTGwQE0vXBYBIqiUi
r5yEGONSFGQvlJ8Q6826b30zYvxf7KF0eXgziF/RE6iTZZs2lHvMrboisH4Y/mIh
i1aUPZ1ASnjQhw6fPTJlqkqeeGdeP5n4UrnHWWeUYhXY4KoMAvBtegAoUAhZyQy9
xxSyUJJvtN4k4uwb5rOJUkXGf+neAmG6VU/6dM/kJ1DBPjgmlwM9YwgPtYnKITCL
CFpgEFkhQqsQ/zJpg8eSt+pBcurNvQtQlot1wYf9kvMhSrE3qpkVP7pEGVBi7Fz1
XTSv+ExwhIsepnvo+NjVian+phtob2PjAPwwBFSz8dWhHfpWJOuG0N6C31CfS72J
9HxnJXatb/MruOT9WetZTLrz1Qn0OGaDN10j+euyS2rLDLwU9kVzclpfvUW3qxKn
GBl034QjcQptnq0IIrUtlc63o5+Rqw/C80AvehW6HzHGsyJVW8/ymU2JRISsjwB0
fkDkMEyHTlht5twF/wft9xNuS0cx9OgB/31y1pByg/ZN+F/i1GOGenKSXMnrqqKY
CprfRJnECjG9/1zN8JPw
=oTlP
-----END PGP SIGNATURE-----

--O7hm+SMpb/lu0d4d--

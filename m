Received: from eggs.gnu.org ([2001:4830:134:3::10]:54156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKQTx-0003h7-Ds
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:38:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKQTt-00041C-5M
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 10:38:17 -0400
Date: Mon, 12 Jun 2017 22:37:11 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170612143711.GK18542@umbus>
References: <20170608172743.10132-1-lvivier@redhat.com>
	<20170608172743.10132-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vk/v8fjDPiDepTtA"
Content-Disposition: inline
In-Reply-To: <20170608172743.10132-2-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] spapr: disable hotplugging without
 OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--vk/v8fjDPiDepTtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 07:27:42PM +0200, Laurent Vivier wrote:
> If the OS is not started, QEMU sends an event to the OS
> that is lost and cannot be recovered. An unplug is not
> able to restore QEMU in a coherent state.
> So, while the OS is not started, disable CPU and memory hotplug.
> We guess the OS is started if the CAS has been negotiated.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

It seems a pain to introduce a whole new (migrated) variable just to
check this.  Could we instead tweak the allocation of spapr->ov5_cas,
so it is NULL until CAS is completed?

> ---
>  hw/ppc/spapr.c         | 51 ++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  hw/ppc/spapr_hcall.c   |  1 +
>  include/hw/ppc/spapr.h |  2 ++
>  3 files changed, 51 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 91b4057..4c979d5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1308,6 +1308,7 @@ static void ppc_spapr_reset(void)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(machine);
>      PowerPCCPU *first_ppc_cpu;
>      uint32_t rtas_limit;
>      hwaddr rtas_addr, fdt_addr;
> @@ -1373,6 +1374,7 @@ static void ppc_spapr_reset(void)
>      first_ppc_cpu->env.nip =3D SPAPR_ENTRY_POINT;
> =20
>      spapr->cas_reboot =3D false;
> +    spapr->cas_completed =3D smc->cas_completed_default;

I also dislike the cas_completed_default thing.  If
cas_completed_default !=3D false, it means that we will have
cas_completed =3D=3D true when we have not, in fact, completed CAS.  I see
why you're doing this for migration compat, but that seems like a
recipe for confusion in the future.

>  }
> =20
>  static void spapr_create_nvram(sPAPRMachineState *spapr)
> @@ -1528,6 +1530,27 @@ static const VMStateDescription vmstate_spapr_patb=
_entry =3D {
>      },
>  };
> =20
> +static bool spapr_cas_completed_needed(void *opaque)
> +{
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(opaque);
> +
> +    /* we need to migrate cas_completed only if it is
> +     * not set by default
> +     */
> +    return !smc->cas_completed_default;
> +}
> +
> +static const VMStateDescription vmstate_spapr_cas_completed =3D {
> +    .name =3D "spapr_cas_completed",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cas_completed_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_BOOL(cas_completed, sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -1546,6 +1569,7 @@ static const VMStateDescription vmstate_spapr =3D {
>      .subsections =3D (const VMStateDescription*[]) {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
> +        &vmstate_spapr_cas_completed,
>          NULL
>      }
>  };
> @@ -2599,6 +2623,7 @@ out:
>  static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceSta=
te *dev,
>                                    Error **errp)
>  {
> +    sPAPRMachineState *ms =3D SPAPR_MACHINE(hotplug_dev);
>      PCDIMMDevice *dimm =3D PC_DIMM(dev);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
>      MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> @@ -2617,6 +2642,14 @@ static void spapr_memory_pre_plug(HotplugHandler *=
hotplug_dev, DeviceState *dev,
>                     "Use 'memory-backend-file' with correct mem-path.");
>          return;
>      }
> +    if (dev->hotplugged) {
> +        if (!runstate_check(RUN_STATE_PRELAUNCH) &&
> +            !runstate_check(RUN_STATE_INMIGRATE) &&
> +            !ms->cas_completed) {
> +            error_setg(errp, "Memory hotplug not supported without OS");
> +            return;
> +        }
> +    }
>  }
> =20
>  struct sPAPRDIMMState {
> @@ -2915,6 +2948,7 @@ static void spapr_core_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>                                  Error **errp)
>  {
>      MachineState *machine =3D MACHINE(OBJECT(hotplug_dev));
> +    sPAPRMachineState *ms =3D SPAPR_MACHINE(machine);
>      MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
>      Error *local_err =3D NULL;
>      CPUCore *cc =3D CPU_CORE(dev);
> @@ -2923,9 +2957,18 @@ static void spapr_core_pre_plug(HotplugHandler *ho=
tplug_dev, DeviceState *dev,
>      CPUArchId *core_slot;
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
> +        if (!runstate_check(RUN_STATE_PRELAUNCH) &&
> +            !runstate_check(RUN_STATE_INMIGRATE) &&
> +            !ms->cas_completed) {
> +            error_setg(&local_err, "CPU hotplug not supported without OS=
");
> +            goto out;
> +        }
>      }
> =20
>      if (strcmp(base_core_type, type)) {
> @@ -3358,9 +3401,11 @@ static void spapr_machine_2_9_instance_options(Mac=
hineState *machine)
> =20
>  static void spapr_machine_2_9_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
>      spapr_machine_2_10_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_9);
>      mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
> +    smc->cas_completed_default =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index aa1ffea..d561a00 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1185,6 +1185,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>          }
>      }
> =20
> +    spapr->cas_completed =3D true;
>      return H_SUCCESS;
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f973b02..f5835db 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -57,6 +57,7 @@ struct sPAPRMachineClass {
>                            uint64_t *buid, hwaddr *pio,=20
>                            hwaddr *mmio32, hwaddr *mmio64,
>                            unsigned n_dma, uint32_t *liobns, Error **errp=
);
> +    bool cas_completed_default;
>  };
> =20
>  /**
> @@ -90,6 +91,7 @@ struct sPAPRMachineState {
>      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
>      bool cas_reboot;
>      bool cas_legacy_guest_workaround;
> +    bool cas_completed;
> =20
>      Notifier epow_notifier;
>      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vk/v8fjDPiDepTtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPqcUAAoJEGw4ysog2bOSY6EP/RUG3RAfDR3Kiee0fMeaKeV6
/zZa+3eI0BFy3fSmtxWPOKXRcFMHfUrlF8aRd1JNPvV4/lOmit4zigWuAeD3SwD7
vGwYYFTdTZjZkIHjXNH4+VKUHveVNu/NcokiUQ+eCnLwjShn2skp6m9r7hGsguOJ
MGi5SBLUIVjFQZ7XTUUis3SUOILTAsSz8WfjuxTbJytO3eWAkN+zQGMIsq5nn9VY
VfHbFARHqWlq52suxVU8hZT9c7YXOfP86+j3mkR1/UlCgVNYC1byTaTyOSuZaF99
YOhuY3iWlWw728Gv4xsOafHGEdKLc++tDj1BXGUx19tsMKeAXde8QrMVmkqrq3L5
Ul80Mgmm0A2t2C+VzDaX0kXzSv1tKcROtpzo3zIpfNpKRhJrycuot2zCRHZIXvnl
V+eR97FF+FArK6cLXn0sQu6+XWsRP2Me1vks3qvidiq5WIY8LGx/ZQIAq7mDl9t4
9h7RTZbcd+7SU+tv4KZQrcOCbBNfNZC5YtrlDDyB5vVwrPFbMyg/4DpUlOif2Gah
HVSSSCLVPvg4F2hXf+2aFWf3dxik22Y9VB5roMwBsu1k0Xf1RIHErUlPV0Am6hIA
rQUioJ4XQHJ0HGPCaru+49vZGHNSdAoQNKHsya43SPVw3MEkKmwjlThR1P8WK0/G
vAOm0J4g50nkMHLcS57d
=rA2P
-----END PGP SIGNATURE-----

--vk/v8fjDPiDepTtA--

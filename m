Received: from eggs.gnu.org ([2001:4830:134:3::10]:53184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fASxr-0001sd-78
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 00:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fASxp-0002CX-OI
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 00:20:31 -0400
Date: Mon, 23 Apr 2018 13:28:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180423032825.GD19804@umbus.fritz.box>
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <20180420123456.22196-3-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] machine: make MemoryHotplugState
 accessible via the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 02:34:55PM +0200, David Hildenbrand wrote:
> Let's allow to query the MemoryHotplugState from the machine.
>=20
> This allows us to generically detect if a certain machine has support
> for memory devices, and to generically manage it (find free address
> range, plug/unplug a memory region).
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

So, we're creating a hook where it seems very likely that the only
implementationss will be simply to retrieve the right field from the
machine specific structure.

So.. should we instead just move the hotplug_memory structure to the
based MachineState type?

> ---
>  hw/i386/pc.c             | 12 ++++++++++++
>  hw/ppc/spapr.c           | 12 ++++++++++++
>  include/hw/boards.h      | 16 ++++++++++++++++
>  include/hw/mem/pc-dimm.h | 12 +-----------
>  4 files changed, 41 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index d36bac8c89..fa8862af33 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2337,6 +2337,17 @@ static void x86_nmi(NMIState *n, int cpu_index, Er=
ror **errp)
>      }
>  }
> =20
> +static MemoryHotplugState *pc_machine_get_memory_hotplug_state(MachineSt=
ate *ms)
> +{
> +    PCMachineState *pcms =3D PC_MACHINE(ms);
> +
> +    if (!pcms->hotplug_memory.base) {
> +        /* hotplug not supported */
> +        return NULL;
> +    }
> +    return &pcms->hotplug_memory;
> +}
> +
>  static void pc_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -2376,6 +2387,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      hc->unplug =3D pc_machine_device_unplug_cb;
>      nc->nmi_monitor_handler =3D x86_nmi;
>      mc->default_cpu_type =3D TARGET_DEFAULT_CPU_TYPE;
> +    mc->get_memory_hotplug_state =3D pc_machine_get_memory_hotplug_state;
> =20
>      object_class_property_add(oc, PC_MACHINE_MEMHP_REGION_SIZE, "int",
>          pc_machine_get_hotplug_memory_region_size, NULL,
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a7428f7da7..7ccdb705b3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3868,6 +3868,17 @@ PowerPCCPU *spapr_find_cpu(int vcpu_id)
>      return NULL;
>  }
> =20
> +static MemoryHotplugState *spapr_get_memory_hotplug_state(MachineState *=
ms)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(ms);
> +
> +    if (!spapr->hotplug_memory.base) {
> +        /* hotplug not supported */
> +        return NULL;
> +    }
> +    return &spapr->hotplug_memory;
> +}
> +
>  static void spapr_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -3927,6 +3938,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>       * in which LMBs are represented and hot-added
>       */
>      mc->numa_mem_align_shift =3D 28;
> +    mc->get_memory_hotplug_state =3D spapr_get_memory_hotplug_state;
> =20
>      smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index a609239112..447bdc7219 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -105,6 +105,17 @@ typedef struct {
>      CPUArchId cpus[0];
>  } CPUArchIdList;
> =20
> +/**
> + * MemoryHotplugState:
> + * @base: address in guest physical address space where hotplug memory
> + * address space begins.
> + * @mr: hotplug memory address space container
> + */
> +typedef struct MemoryHotplugState {
> +    hwaddr base;
> +    MemoryRegion mr;
> +} MemoryHotplugState;
> +
>  /**
>   * MachineClass:
>   * @max_cpus: maximum number of CPUs supported. Default: 1
> @@ -156,6 +167,10 @@ typedef struct {
>   *    should instead use "unimplemented-device" for all memory ranges wh=
ere
>   *    the guest will attempt to probe for a device that QEMU doesn't
>   *    implement and a stub device is required.
> + * @get_memory_hotplug_state:
> + *    If a machine support memory hotplug, the returned data ontains
> + *    information about the portion of guest physical address space
> + *    where memory devices can be mapped to (e.g. to hotplug a pc-dimm).
>   */
>  struct MachineClass {
>      /*< private >*/
> @@ -212,6 +227,7 @@ struct MachineClass {
>                                                           unsigned cpu_in=
dex);
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
>      int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
> +    MemoryHotplugState *(*get_memory_hotplug_state)(MachineState *ms);
>  };
> =20
>  /**
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index e88073321f..8bda37adab 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -19,6 +19,7 @@
>  #include "exec/memory.h"
>  #include "sysemu/hostmem.h"
>  #include "hw/qdev.h"
> +#include "hw/boards.h"
> =20
>  #define TYPE_PC_DIMM "pc-dimm"
>  #define PC_DIMM(obj) \
> @@ -75,17 +76,6 @@ typedef struct PCDIMMDeviceClass {
>      MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
>  } PCDIMMDeviceClass;
> =20
> -/**
> - * MemoryHotplugState:
> - * @base: address in guest physical address space where hotplug memory
> - * address space begins.
> - * @mr: hotplug memory address space container
> - */
> -typedef struct MemoryHotplugState {
> -    hwaddr base;
> -    MemoryRegion mr;
> -} MemoryHotplugState;
> -
>  uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
>                                 uint64_t address_space_size,
>                                 uint64_t *hint, uint64_t align, uint64_t =
size,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrdUtkACgkQbDjKyiDZ
s5I0ew//fmO+4+uvGXI9Jrrt2oEUk2Fe819QGDpLr7z8uXh3Hq+BEsxQk7DnARJM
sF17B2acchIwmKrRCEmdMc+0Sg9l7XP4O+Z+DKYKBE33LxJX+Bz7dYeOF+s6Oo3Y
QXWBsLGbodOnLCtjlbrSQs41Wzn4YbRUb3oNvVHWQvFl10qHxGrs5JwO8tKXU89c
Ca5U4Fxy2RYHyIVPr3BymwI8htNnOGHje0dr75Gx6G5BeEdzYdASvpEiJaPOvn98
AXpTWKl+MjQBAHkmFJIMm7dL+IcRskgM0UQh+XLDFbZ0VV2INPZ2b0GaHbE+V9G0
obEbqOFoV8P+3WVqRukHCrQSgfGzLfeK8QO4IHnnDOYzpL00Fogb2X2WHFkvuqQu
jggJ+XLp3tb2Ej1/coH2oJCQIc2F5scR6wkHyyVi85T8AabjPZF3CXF6S7XXYWCg
F6ofLXJwqvyDfTYuoGF2tNhh12OdLtxLaK/CFJ7WFIOT1Rz2BPuy1qSuMO/qqgxX
3NlGp700RnHz35ibJ5ExH2ujAqRJozNEZY8lXS1F+j6dsQg3wcP4PbGM7XwS/W71
+2KStbwLi3NRDGXMsDePMY4MBe9pOjHxvl2RXZ9e/c18lCp39k0OVgup4A27TbF8
vTOovz98d41N2hm7AGXJeEyjte6xv80G6T70hN7RqYriI/MG7eM=
=l/At
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--

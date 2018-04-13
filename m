Received: from eggs.gnu.org ([2001:4830:134:3::10]:41776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6pXo-0003Kb-3u
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 23:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6pXl-0001bD-CS
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 23:38:36 -0400
Date: Fri, 13 Apr 2018 13:25:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180413032512.GR9425@umbus.fritz.box>
References: <20180412143635.19949-1-david@redhat.com>
	<20180412143635.19949-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aH/0uqREc1VzwMkO"
Content-Disposition: inline
In-Reply-To: <20180412143635.19949-2-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] pc-dimm: factor out MemoryDevice
 interface
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


--aH/0uqREc1VzwMkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 04:36:33PM +0200, David Hildenbrand wrote:
> On the qmp level, we already have the concept of memory devices:
>     "query-memory-devices"
> Right now, we only support NVDIMM and PCDIMM.
>=20
> We want to map other devices later into the address space of the guest.
> Such device could e.g. be virtio devices. These devices will have a
> guest memory range assigned but won't be exposed via e.g. ACPI. We want
> to make them look like memory device, but not glued to pc-dimm.
>=20
> Especially, it will not always be possible to have TYPE_PC_DIMM as a pare=
nt
> class (e.g. virtio devices). Let's use an interface instead. As a first
> part, convert handling of
> - qmp_pc_dimm_device_list
> - get_plugged_memory_size
> to our new model. plug/unplug stuff etc. will follow later.
>=20
> A memory device will have to provide the following functions:
> - get_addr(): Necessary, as the property "addr" can e.g. not be used for
>               virtio devices (already defined).

Is the assumption here that a memory device has a fixed RAM address
(GPA) from when it is realized?  It seems to me plausible that you
could have a memory device that has a specific size, but has a BAR of
some sort that's programmed by the guest as part of the "plug"
process.

> - get_plugged_size(): The amount this device offers to the guest as of
>                       now.
> - get_region_size(): Because this can later on be bigger than the
>                      plugged size.
> - fill_device_info(): Fill MemoryDeviceInfo, e.g. for qmp.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/i386/acpi-build.c                         |   3 +-
>  hw/mem/Makefile.objs                         |   1 +
>  hw/mem/memory-device.c                       | 119 +++++++++++++++++++++=
++++++
>  hw/mem/pc-dimm.c                             | 119 ++++++++++++++-------=
------
>  hw/ppc/spapr.c                               |   3 +-
>  hw/ppc/spapr_hcall.c                         |   1 +
>  include/hw/mem/memory-device.h               |  44 ++++++++++
>  include/hw/mem/pc-dimm.h                     |   2 -
>  numa.c                                       |   3 +-
>  qmp.c                                        |   4 +-
>  stubs/Makefile.objs                          |   2 +-
>  stubs/{qmp_pc_dimm.c =3D> qmp_memory_device.c} |   4 +-
>  12 files changed, 239 insertions(+), 66 deletions(-)
>  create mode 100644 hw/mem/memory-device.c
>  create mode 100644 include/hw/mem/memory-device.h
>  rename stubs/{qmp_pc_dimm.c =3D> qmp_memory_device.c} (61%)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3cf2a1679c..ca3645d57b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -46,6 +46,7 @@
>  #include "hw/acpi/vmgenid.h"
>  #include "sysemu/tpm_backend.h"
>  #include "hw/timer/mc146818rtc_regs.h"
> +#include "hw/mem/memory-device.h"
>  #include "sysemu/numa.h"
> =20
>  /* Supported chipsets: */
> @@ -2253,7 +2254,7 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, =
GArray *tcpalog)
>  static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t =
base,
>                                             uint64_t len, int default_nod=
e)
>  {
> -    MemoryDeviceInfoList *info_list =3D qmp_pc_dimm_device_list();
> +    MemoryDeviceInfoList *info_list =3D qmp_memory_device_list();
>      MemoryDeviceInfoList *info;
>      MemoryDeviceInfo *mi;
>      PCDIMMDeviceInfo *di;
> diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
> index f12f8b97a2..10be4df2a2 100644
> --- a/hw/mem/Makefile.objs
> +++ b/hw/mem/Makefile.objs
> @@ -1,2 +1,3 @@
>  common-obj-$(CONFIG_MEM_HOTPLUG) +=3D pc-dimm.o
> +common-obj-$(CONFIG_MEM_HOTPLUG) +=3D memory-device.o
>  common-obj-$(CONFIG_NVDIMM) +=3D nvdimm.o
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> new file mode 100644
> index 0000000000..0e0d6b539a
> --- /dev/null
> +++ b/hw/mem/memory-device.c
> @@ -0,0 +1,119 @@
> +/*
> + * Memory Device Interface
> + *
> + * Copyright ProfitBricks GmbH 2012
> + * Copyright (C) 2014 Red Hat Inc
> + * Copyright (c) 2018 Red Hat Inc
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/mem/memory-device.h"
> +#include "hw/qdev.h"
> +#include "qapi/error.h"
> +#include "hw/boards.h"
> +#include "qemu/range.h"
> +
> +static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
> +{
> +    MemoryDeviceState *md_a =3D MEMORY_DEVICE(a);
> +    MemoryDeviceState *md_b =3D MEMORY_DEVICE(b);
> +    MemoryDeviceClass *mdc =3D MEMORY_DEVICE_GET_CLASS(a);

AFAICT from the code below, the two devices don't necessarily have to
have the same class, so I think you need to get the class pointers for
each of them separately.  (Or if they do have to be the same by
design, I think there should at least be an assert).

> +    const uint64_t addr_a =3D mdc->get_addr(md_a);
> +    const uint64_t addr_b =3D mdc->get_addr(md_b);
> +
> +    if (addr_a > addr_b) {
> +        return 1;
> +    } else if (addr_a < addr_b) {
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int memory_device_built_list(Object *obj, void *opaque)
> +{
> +    GSList **list =3D opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
> +        DeviceState *dev =3D DEVICE(obj);
> +        if (dev->realized) { /* only realized memory devices matter */
> +            *list =3D g_slist_insert_sorted(*list, dev, memory_device_ad=
dr_sort);
> +        }
> +    }
> +
> +    object_child_foreach(obj, memory_device_built_list, opaque);
> +    return 0;
> +}
> +
> +MemoryDeviceInfoList *qmp_memory_device_list(void)
> +{
> +    GSList *devices =3D NULL, *item;
> +    MemoryDeviceInfoList *list =3D NULL, *prev =3D NULL;
> +
> +    object_child_foreach(qdev_get_machine(), memory_device_built_list,
> +                         &devices);
> +
> +    for (item =3D devices; item; item =3D g_slist_next(item)) {
> +        MemoryDeviceState *md =3D MEMORY_DEVICE(item->data);
> +        MemoryDeviceClass *mdc =3D MEMORY_DEVICE_GET_CLASS(item->data);
> +        MemoryDeviceInfoList *elem =3D g_new0(MemoryDeviceInfoList, 1);
> +        MemoryDeviceInfo *info =3D g_new0(MemoryDeviceInfo, 1);
> +
> +        mdc->fill_device_info(md, info);
> +
> +        elem->value =3D info;
> +        elem->next =3D NULL;
> +        if (prev) {
> +            prev->next =3D elem;
> +        } else {
> +            list =3D elem;
> +        }
> +        prev =3D elem;
> +    }
> +
> +    g_slist_free(devices);
> +
> +    return list;
> +}
> +
> +static int memory_device_plugged_size(Object *obj, void *opaque)
> +{
> +    uint64_t *size =3D opaque;
> +
> +    if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
> +        DeviceState *dev =3D DEVICE(obj);
> +        MemoryDeviceState *md =3D MEMORY_DEVICE(obj);
> +        MemoryDeviceClass *mdc =3D MEMORY_DEVICE_GET_CLASS(obj);
> +
> +        if (dev->realized) {
> +            *size +=3D mdc->get_plugged_size(md, &error_abort);
> +        }
> +    }
> +
> +    object_child_foreach(obj, memory_device_plugged_size, opaque);
> +    return 0;
> +}
> +
> +uint64_t get_plugged_memory_size(void)
> +{
> +    uint64_t size =3D 0;
> +
> +    memory_device_plugged_size(qdev_get_machine(), &size);
> +
> +    return size;
> +}
> +
> +static const TypeInfo memory_device_info =3D {
> +    .name          =3D TYPE_MEMORY_DEVICE,
> +    .parent        =3D TYPE_INTERFACE,
> +    .class_size =3D sizeof(MemoryDeviceClass),
> +};
> +
> +static void memory_device_register_types(void)
> +{
> +    type_register_static(&memory_device_info);
> +}
> +
> +type_init(memory_device_register_types)
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 51350d9c2d..1dbf699e02 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "hw/mem/pc-dimm.h"
>  #include "hw/mem/nvdimm.h"
> +#include "hw/mem/memory-device.h"
>  #include "qapi/error.h"
>  #include "qemu/config-file.h"
>  #include "qapi/visitor.h"
> @@ -158,11 +159,6 @@ uint64_t pc_existing_dimms_capacity(Error **errp)
>      return cap.size;
>  }
> =20
> -uint64_t get_plugged_memory_size(void)
> -{
> -    return pc_existing_dimms_capacity(&error_abort);
> -}
> -
>  static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
>  {
>      unsigned long *bitmap =3D opaque;
> @@ -238,57 +234,6 @@ static int pc_dimm_built_list(Object *obj, void *opa=
que)
>      return 0;
>  }
> =20
> -MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
> -{
> -    GSList *dimms =3D NULL, *item;
> -    MemoryDeviceInfoList *list =3D NULL, *prev =3D NULL;
> -
> -    object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &dimms);
> -
> -    for (item =3D dimms; item; item =3D g_slist_next(item)) {
> -        PCDIMMDevice *dimm =3D PC_DIMM(item->data);
> -        Object *obj =3D OBJECT(dimm);
> -        MemoryDeviceInfoList *elem =3D g_new0(MemoryDeviceInfoList, 1);
> -        MemoryDeviceInfo *info =3D g_new0(MemoryDeviceInfo, 1);
> -        PCDIMMDeviceInfo *di =3D g_new0(PCDIMMDeviceInfo, 1);
> -        bool is_nvdimm =3D object_dynamic_cast(obj, TYPE_NVDIMM);
> -        DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
> -        DeviceState *dev =3D DEVICE(obj);
> -
> -        if (dev->id) {
> -            di->has_id =3D true;
> -            di->id =3D g_strdup(dev->id);
> -        }
> -        di->hotplugged =3D dev->hotplugged;
> -        di->hotpluggable =3D dc->hotpluggable;
> -        di->addr =3D dimm->addr;
> -        di->slot =3D dimm->slot;
> -        di->node =3D dimm->node;
> -        di->size =3D object_property_get_uint(obj, PC_DIMM_SIZE_PROP, NU=
LL);
> -        di->memdev =3D object_get_canonical_path(OBJECT(dimm->hostmem));
> -
> -        if (!is_nvdimm) {
> -            info->u.dimm.data =3D di;
> -            info->type =3D MEMORY_DEVICE_INFO_KIND_DIMM;
> -        } else {
> -            info->u.nvdimm.data =3D di;
> -            info->type =3D MEMORY_DEVICE_INFO_KIND_NVDIMM;
> -        }
> -        elem->value =3D info;
> -        elem->next =3D NULL;
> -        if (prev) {
> -            prev->next =3D elem;
> -        } else {
> -            list =3D elem;
> -        }
> -        prev =3D elem;
> -    }
> -
> -    g_slist_free(dimms);
> -
> -    return list;
> -}
> -
>  uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
>                                 uint64_t address_space_size,
>                                 uint64_t *hint, uint64_t align, uint64_t =
size,
> @@ -445,10 +390,62 @@ static MemoryRegion *pc_dimm_get_vmstate_memory_reg=
ion(PCDIMMDevice *dimm)
>      return host_memory_backend_get_memory(dimm->hostmem, &error_abort);
>  }
> =20
> +static uint64_t pc_dimm_md_get_addr(MemoryDeviceState *md)
> +{
> +    PCDIMMDevice *dimm =3D PC_DIMM(md);
> +
> +    return dimm->addr;
> +}
> +
> +static uint64_t pc_dimm_md_get_region_size(MemoryDeviceState *md, Error =
**errp)
> +{
> +    PCDIMMDevice *dimm =3D PC_DIMM(md);
> +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(md);
> +    MemoryRegion *mr;
> +
> +    mr =3D ddc->get_memory_region(dimm, errp);
> +    if (!mr) {
> +        return 0;
> +    }
> +
> +    return memory_region_size(mr);
> +}
> +
> +static void pc_dimm_md_fill_device_info(MemoryDeviceState *md,
> +                                        MemoryDeviceInfo *info)
> +{
> +    PCDIMMDeviceInfo *di =3D g_new0(PCDIMMDeviceInfo, 1);
> +    DeviceClass *dc =3D DEVICE_GET_CLASS(md);
> +    PCDIMMDevice *dimm =3D PC_DIMM(md);
> +    DeviceState *dev =3D DEVICE(md);
> +
> +    if (dev->id) {
> +        di->has_id =3D true;
> +        di->id =3D g_strdup(dev->id);
> +    }
> +    di->hotplugged =3D dev->hotplugged;
> +    di->hotpluggable =3D dc->hotpluggable;
> +    di->addr =3D dimm->addr;
> +    di->slot =3D dimm->slot;
> +    di->node =3D dimm->node;
> +    di->size =3D object_property_get_uint(OBJECT(dimm), PC_DIMM_SIZE_PRO=
P,
> +                                        NULL);
> +    di->memdev =3D object_get_canonical_path(OBJECT(dimm->hostmem));
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_NVDIMM)) {
> +        info->u.nvdimm.data =3D di;
> +        info->type =3D MEMORY_DEVICE_INFO_KIND_NVDIMM;
> +    } else {
> +        info->u.dimm.data =3D di;
> +        info->type =3D MEMORY_DEVICE_INFO_KIND_DIMM;
> +    }
> +}
> +
>  static void pc_dimm_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
>      PCDIMMDeviceClass *ddc =3D PC_DIMM_CLASS(oc);
> +    MemoryDeviceClass *mdc =3D MEMORY_DEVICE_CLASS(oc);
> =20
>      dc->realize =3D pc_dimm_realize;
>      dc->unrealize =3D pc_dimm_unrealize;
> @@ -457,6 +454,12 @@ static void pc_dimm_class_init(ObjectClass *oc, void=
 *data)
> =20
>      ddc->get_memory_region =3D pc_dimm_get_memory_region;
>      ddc->get_vmstate_memory_region =3D pc_dimm_get_vmstate_memory_region;
> +
> +    mdc->get_addr =3D pc_dimm_md_get_addr;
> +    /* for a dimm plugged_size =3D=3D region_size */
> +    mdc->get_plugged_size =3D pc_dimm_md_get_region_size;
> +    mdc->get_region_size =3D pc_dimm_md_get_region_size;
> +    mdc->fill_device_info =3D pc_dimm_md_fill_device_info;
>  }
> =20
>  static TypeInfo pc_dimm_info =3D {
> @@ -466,6 +469,10 @@ static TypeInfo pc_dimm_info =3D {
>      .instance_init =3D pc_dimm_init,
>      .class_init    =3D pc_dimm_class_init,
>      .class_size    =3D sizeof(PCDIMMDeviceClass),
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_MEMORY_DEVICE },
> +        { }
> +    },
>  };
> =20
>  static void pc_dimm_register_types(void)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a81570e7c8..a7428f7da7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -74,6 +74,7 @@
>  #include "hw/compat.h"
>  #include "qemu/cutils.h"
>  #include "hw/ppc/spapr_cpu_core.h"
> +#include "hw/mem/memory-device.h"
> =20
>  #include <libfdt.h>
> =20
> @@ -722,7 +723,7 @@ static int spapr_populate_drconf_memory(sPAPRMachineS=
tate *spapr, void *fdt)
>      }
> =20
>      if (hotplug_lmb_start) {
> -        dimms =3D qmp_pc_dimm_device_list();
> +        dimms =3D qmp_memory_device_list();
>      }
> =20
>      /* ibm,dynamic-memory */
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 16bccdd5c0..4cdae3ca3a 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -14,6 +14,7 @@
>  #include "kvm_ppc.h"
>  #include "hw/ppc/spapr_ovec.h"
>  #include "mmu-book3s-v3.h"
> +#include "hw/mem/memory-device.h"
> =20
>  struct SPRSyncState {
>      int spr;
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-devic=
e.h
> new file mode 100644
> index 0000000000..3e498b2e61
> --- /dev/null
> +++ b/include/hw/mem/memory-device.h
> @@ -0,0 +1,44 @@
> +/*
> + * Memory Device Interface
> + *
> + * Copyright (c) 2018 Red Hat, Inc.
> + *
> + * Authors:
> + *  David Hildenbrand <david@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef MEMORY_DEVICE_H
> +#define MEMORY_DEVICE_H
> +
> +#include "qom/object.h"
> +#include "hw/qdev.h"
> +
> +#define TYPE_MEMORY_DEVICE "memory-device"
> +
> +#define MEMORY_DEVICE_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(MemoryDeviceClass, (klass), TYPE_MEMORY_DEVICE)
> +#define MEMORY_DEVICE_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(MemoryDeviceClass, (obj), TYPE_MEMORY_DEVICE)
> +#define MEMORY_DEVICE(obj) \
> +     INTERFACE_CHECK(MemoryDeviceState, (obj), TYPE_MEMORY_DEVICE)
> +
> +typedef struct MemoryDeviceState {
> +    Object parent_obj;
> +} MemoryDeviceState;
> +
> +typedef struct MemoryDeviceClass {
> +    InterfaceClass parent_class;
> +
> +    uint64_t (*get_addr)(MemoryDeviceState *md);
> +    uint64_t (*get_plugged_size)(MemoryDeviceState *md, Error **errp);
> +    uint64_t (*get_region_size)(MemoryDeviceState *md, Error **errp);
> +    void (*fill_device_info)(MemoryDeviceState *md, MemoryDeviceInfo *in=
fo);
> +} MemoryDeviceClass;
> +
> +MemoryDeviceInfoList *qmp_memory_device_list(void);
> +uint64_t get_plugged_memory_size(void);
> +
> +#endif
> diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> index 1fc479281c..e88073321f 100644
> --- a/include/hw/mem/pc-dimm.h
> +++ b/include/hw/mem/pc-dimm.h
> @@ -93,9 +93,7 @@ uint64_t pc_dimm_get_free_addr(uint64_t address_space_s=
tart,
> =20
>  int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
> =20
> -MemoryDeviceInfoList *qmp_pc_dimm_device_list(void);
>  uint64_t pc_existing_dimms_capacity(Error **errp);
> -uint64_t get_plugged_memory_size(void);
>  void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>                           MemoryRegion *mr, uint64_t align, Error **errp);
>  void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
> diff --git a/numa.c b/numa.c
> index 1116c90af9..6a0eaebc01 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -36,6 +36,7 @@
>  #include "hw/boards.h"
>  #include "sysemu/hostmem.h"
>  #include "hw/mem/pc-dimm.h"
> +#include "hw/mem/memory-device.h"
>  #include "qemu/option.h"
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
> @@ -520,7 +521,7 @@ void memory_region_allocate_system_memory(MemoryRegio=
n *mr, Object *owner,
> =20
>  static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>  {
> -    MemoryDeviceInfoList *info_list =3D qmp_pc_dimm_device_list();
> +    MemoryDeviceInfoList *info_list =3D qmp_memory_device_list();
>      MemoryDeviceInfoList *info;
>      PCDIMMDeviceInfo     *pcdimm_info;
> =20
> diff --git a/qmp.c b/qmp.c
> index f72261667f..3de029946a 100644
> --- a/qmp.c
> +++ b/qmp.c
> @@ -39,7 +39,7 @@
>  #include "qapi/qobject-input-visitor.h"
>  #include "hw/boards.h"
>  #include "qom/object_interfaces.h"
> -#include "hw/mem/pc-dimm.h"
> +#include "hw/mem/memory-device.h"
>  #include "hw/acpi/acpi_dev_interface.h"
> =20
>  NameInfo *qmp_query_name(Error **errp)
> @@ -731,7 +731,7 @@ void qmp_object_del(const char *id, Error **errp)
> =20
>  MemoryDeviceInfoList *qmp_query_memory_devices(Error **errp)
>  {
> -    return qmp_pc_dimm_device_list();
> +    return qmp_memory_device_list();
>  }
> =20
>  ACPIOSTInfoList *qmp_query_acpi_ospm_status(Error **errp)
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 2d59d84091..53d3f32cb2 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -34,7 +34,7 @@ stub-obj-y +=3D uuid.o
>  stub-obj-y +=3D vm-stop.o
>  stub-obj-y +=3D vmstate.o
>  stub-obj-$(CONFIG_WIN32) +=3D fd-register.o
> -stub-obj-y +=3D qmp_pc_dimm.o
> +stub-obj-y +=3D qmp_memory_device.o
>  stub-obj-y +=3D target-monitor-defs.o
>  stub-obj-y +=3D target-get-monitor-def.o
>  stub-obj-y +=3D pc_madt_cpu_entry.o
> diff --git a/stubs/qmp_pc_dimm.c b/stubs/qmp_memory_device.c
> similarity index 61%
> rename from stubs/qmp_pc_dimm.c
> rename to stubs/qmp_memory_device.c
> index b6b2cca89e..85ff8f2d7e 100644
> --- a/stubs/qmp_pc_dimm.c
> +++ b/stubs/qmp_memory_device.c
> @@ -1,8 +1,8 @@
>  #include "qemu/osdep.h"
>  #include "qom/object.h"
> -#include "hw/mem/pc-dimm.h"
> +#include "hw/mem/memory-device.h"
> =20
> -MemoryDeviceInfoList *qmp_pc_dimm_device_list(void)
> +MemoryDeviceInfoList *qmp_memory_device_list(void)
>  {
>     return NULL;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aH/0uqREc1VzwMkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrQIxUACgkQbDjKyiDZ
s5JWKQ//Zg2eDg8YJ3c7NZOU1I5NM9klVt3AeuzdgjeJRpSSdxjskxG3D0DUs+m6
MpvV+yDvmfk/z2nklHuGenjxZA7bixUqlkKE5osJNNq/dxcG8U06TjnczSHC2sVi
qndxTS3tZLgutZWCmavm0HC93r8nIgf7l+10MywihGBzZwpSD9xR6UOqhv0k495e
2qdbkCHY6QU7ACGj1BC9+ToAFHFiSP90rJQ9Ay+eyLFJfBrcB7FYFLScQylUpZGg
3/IYACVdag+e7TYj6wLCxtN+hSRxMd5gD9u9zq58FMPgcMGuqwi+rpdkFed3nbxf
ylzV7NGsoD6nA+uxeGF09Kb8t9Ceu44N6HAJipLKfZmBSX44WA5eBOQpKEBomoLs
k5nzf/Rx7r8V0obmACmaP7kkB27OOERdQPmgX+Q2oYnvUPd85Nt2l9wT6ms4IorT
tS/ulkg9Bbq54qPuYciHoIrl86zgUycK5hScyeSWlWEhGQPOFgbDcnkfyltgVWfP
lkkN0bXq7ZXVeBJ3qmZvLj+P+5N2zgjwL1QWxNCPnA2ufJQ8TXmyAiKc7pw36Pxr
+TfqnO0gMDNbGv4CFLjxCHIrDjENsudmFoXA3Tr+6g5PXJ1Cl2el3GfkRehAKzAg
FbcaUP4nGf7JIXSLUG0w0qHl1pW0GTLBfV3az9/ieVCn+cjv49Y=
=1o18
-----END PGP SIGNATURE-----

--aH/0uqREc1VzwMkO--

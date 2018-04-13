Received: from eggs.gnu.org ([2001:4830:134:3::10]:40107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f6sKD-0006QS-NY
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f6sKA-0003i9-KB
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:36:45 -0400
References: <20180412143635.19949-1-david@redhat.com>
	<20180412143635.19949-2-david@redhat.com>
	<20180413032512.GR9425@umbus.fritz.box>
From: David Hildenbrand <david@redhat.com>
Message-ID: <cd0f02fd-1bf3-711a-198c-7b6c00aed586@redhat.com>
Date: Fri, 13 Apr 2018 08:36:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180413032512.GR9425@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

On 13.04.2018 05:25, David Gibson wrote:
> On Thu, Apr 12, 2018 at 04:36:33PM +0200, David Hildenbrand wrote:
>> On the qmp level, we already have the concept of memory devices:
>>     "query-memory-devices"
>> Right now, we only support NVDIMM and PCDIMM.
>>
>> We want to map other devices later into the address space of the guest=
.
>> Such device could e.g. be virtio devices. These devices will have a
>> guest memory range assigned but won't be exposed via e.g. ACPI. We wan=
t
>> to make them look like memory device, but not glued to pc-dimm.
>>
>> Especially, it will not always be possible to have TYPE_PC_DIMM as a p=
arent
>> class (e.g. virtio devices). Let's use an interface instead. As a firs=
t
>> part, convert handling of
>> - qmp_pc_dimm_device_list
>> - get_plugged_memory_size
>> to our new model. plug/unplug stuff etc. will follow later.
>>
>> A memory device will have to provide the following functions:
>> - get_addr(): Necessary, as the property "addr" can e.g. not be used f=
or
>>               virtio devices (already defined).
>=20
> Is the assumption here that a memory device has a fixed RAM address
> (GPA) from when it is realized?  It seems to me plausible that you
> could have a memory device that has a specific size, but has a BAR of
> some sort that's programmed by the guest as part of the "plug"
> process.

Yes, the assumption is that the
a) address in physical memory
b) region size

Are defined at realize time. Which holds true for DIMM/NVDIMM and will
hold true for the two virtio device types we have in mind
(virtio-mem/virtio-pmem).

Both basically allow to find free address ranges.

>=20
>> - get_plugged_size(): The amount this device offers to the guest as of
>>                       now.
>> - get_region_size(): Because this can later on be bigger than the
>>                      plugged size.
>> - fill_device_info(): Fill MemoryDeviceInfo, e.g. for qmp.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/i386/acpi-build.c                         |   3 +-
>>  hw/mem/Makefile.objs                         |   1 +
>>  hw/mem/memory-device.c                       | 119 ++++++++++++++++++=
+++++++++
>>  hw/mem/pc-dimm.c                             | 119 ++++++++++++++----=
---------
>>  hw/ppc/spapr.c                               |   3 +-
>>  hw/ppc/spapr_hcall.c                         |   1 +
>>  include/hw/mem/memory-device.h               |  44 ++++++++++
>>  include/hw/mem/pc-dimm.h                     |   2 -
>>  numa.c                                       |   3 +-
>>  qmp.c                                        |   4 +-
>>  stubs/Makefile.objs                          |   2 +-
>>  stubs/{qmp_pc_dimm.c =3D> qmp_memory_device.c} |   4 +-
>>  12 files changed, 239 insertions(+), 66 deletions(-)
>>  create mode 100644 hw/mem/memory-device.c
>>  create mode 100644 include/hw/mem/memory-device.h
>>  rename stubs/{qmp_pc_dimm.c =3D> qmp_memory_device.c} (61%)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 3cf2a1679c..ca3645d57b 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -46,6 +46,7 @@
>>  #include "hw/acpi/vmgenid.h"
>>  #include "sysemu/tpm_backend.h"
>>  #include "hw/timer/mc146818rtc_regs.h"
>> +#include "hw/mem/memory-device.h"
>>  #include "sysemu/numa.h"
>> =20
>>  /* Supported chipsets: */
>> @@ -2253,7 +2254,7 @@ build_tpm2(GArray *table_data, BIOSLinker *linke=
r, GArray *tcpalog)
>>  static void build_srat_hotpluggable_memory(GArray *table_data, uint64=
_t base,
>>                                             uint64_t len, int default_=
node)
>>  {
>> -    MemoryDeviceInfoList *info_list =3D qmp_pc_dimm_device_list();
>> +    MemoryDeviceInfoList *info_list =3D qmp_memory_device_list();
>>      MemoryDeviceInfoList *info;
>>      MemoryDeviceInfo *mi;
>>      PCDIMMDeviceInfo *di;
>> diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
>> index f12f8b97a2..10be4df2a2 100644
>> --- a/hw/mem/Makefile.objs
>> +++ b/hw/mem/Makefile.objs
>> @@ -1,2 +1,3 @@
>>  common-obj-$(CONFIG_MEM_HOTPLUG) +=3D pc-dimm.o
>> +common-obj-$(CONFIG_MEM_HOTPLUG) +=3D memory-device.o
>>  common-obj-$(CONFIG_NVDIMM) +=3D nvdimm.o
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> new file mode 100644
>> index 0000000000..0e0d6b539a
>> --- /dev/null
>> +++ b/hw/mem/memory-device.c
>> @@ -0,0 +1,119 @@
>> +/*
>> + * Memory Device Interface
>> + *
>> + * Copyright ProfitBricks GmbH 2012
>> + * Copyright (C) 2014 Red Hat Inc
>> + * Copyright (c) 2018 Red Hat Inc
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/mem/memory-device.h"
>> +#include "hw/qdev.h"
>> +#include "qapi/error.h"
>> +#include "hw/boards.h"
>> +#include "qemu/range.h"
>> +
>> +static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
>> +{
>> +    MemoryDeviceState *md_a =3D MEMORY_DEVICE(a);
>> +    MemoryDeviceState *md_b =3D MEMORY_DEVICE(b);
>> +    MemoryDeviceClass *mdc =3D MEMORY_DEVICE_GET_CLASS(a);
>=20
> AFAICT from the code below, the two devices don't necessarily have to
> have the same class, so I think you need to get the class pointers for
> each of them separately.  (Or if they do have to be the same by
> design, I think there should at least be an assert).

Haven't considered that, my assumption was that any memory device class
would be sufficient to find/use the pointer (as that layout should not
change). But I might be wrong, so I'll lookup both pointers, thanks!

>=20
>> +    const uint64_t addr_a =3D mdc->get_addr(md_a);
>> +    const uint64_t addr_b =3D mdc->get_addr(md_b);
>> +
>> +    if (addr_a > addr_b) {
>> +        return 1;
>> +    } else if (addr_a < addr_b) {
>> +        return -1;
>> +    }
>> +    return 0;
>> +}


--=20

Thanks,

David / dhildenb

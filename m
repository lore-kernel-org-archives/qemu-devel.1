Received: from eggs.gnu.org ([209.51.188.92]:53537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1glY0V-0007eD-OV
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:44:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1glY0U-00023x-DB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:44:47 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Mon, 21 Jan 2019 11:44:13 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8392925E9@lhreml524-mbb.china.huawei.com>
References: <20181018143042.29588-1-eric.auger@redhat.com>
	<20181018143042.29588-12-eric.auger@redhat.com>
In-Reply-To: <20181018143042.29588-12-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v4 11/16] acpi: move
 build_srat_hotpluggable_memory to generic ACPI source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "kwangwoo.lee@sk.com" <kwangwoo.lee@sk.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "david@redhat.com" <david@redhat.com>
Cc: "drjones@redhat.com" <drjones@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "Suzuki.Poulose@arm.com" <Suzuki.Poulose@arm.com>, Linuxarm <linuxarm@huawei.com>

Hi Eric,

As I informed you earlier, I am working on adding the hot-add support for p=
c-dimm
and nvdimm on top of this series using the pl061 GPIO pins as a way to inje=
ct
memory hot add events to the Guest. I came across a problem while testing
my patches which looks like is related to the way SRAT entries are populate=
d
in this patch.

If I boot the Guest without NUMA and hot add dimms, all seems to be=20
working fine. But when I enable NUMA (-numa node,nodeid=3D0), and hot add
dimms and perform a reboot, it fails.

Something like this,

./qemu-system-aarch64 \
-machine virt,kernel_irqchip=3Don,gic-version=3D3,nvdimm \
-m 1G,maxmem=3D4G,slots=3D5 \
-cpu host \
-kernel Image \
-bios QEMU_EFI.fd \
-initrd rootfs-iperf.cpio \
-numa node,nodeid=3D0 \
-net none \
-nographic -enable-kvm \
-append "console=3DttyAMA0 root=3D/dev/vda rw acpi=3Dforce"

Qemu Monitor:
(qemu) object_add memory-backend-ram,id=3Dmem1,size=3D1G
(qemu) device_add pc-dimm,id=3Ddimm1,memdev=3Dmem1

Exit QM and reboot the Guest.

EFI stub: Booting Linux Kernel...
EFI stub: Generating empty DTB
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x480fd010]
[    0.000000] Linux version 4.20.0-rc3-dirty (shameer@shameer-ubuntu) (gcc=
 version 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90=
065c0eeb7f91977701] (Linaro GCC 7.3-2018.05)) #21 SMP PREEMPT Wed Jan 16 14=
:45:58 GMT 2019
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  SMBIOS 3.0=3D0x7f810000  MEMATTR=3D0x7c63ca98  MEMRESE=
RVE=3D0x7bfeb018=20
[    0.000000] cma: Reserved 32 MiB at 0x000000007d000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: System description tables not found
[    0.000000] ACPI: Failed to init ACPI tables
[    0.000000] ACPI: NUMA: Failed to initialise from firmware

[...]

Debug shows that edk2 had a check[1] to verify the table size and it fails =
on reboot when
NUMA is enabled(ie, SRAT is present),

ProcessCmdAddPointer: invalid pointer location or size in "etc/acpi/tables"

This seems to be related to the below code where SRAT is built,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: 18 October 2018 15:31
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com;
> qemu-devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org;
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> kwangwoo.lee@sk.com; imammedo@redhat.com; david@redhat.com
> Cc: drjones@redhat.com; dgilbert@redhat.com; Suzuki.Poulose@arm.com
> Subject: [RFC v4 11/16] acpi: move build_srat_hotpluggable_memory to gene=
ric
> ACPI source
>=20
> We plan to reuse build_srat_hotpluggable_memory() for ARM so
> let's move the function to aml-build.
>=20
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/acpi/aml-build.c         | 51
> +++++++++++++++++++++++++++++++++++++
>  include/hw/acpi/aml-build.h |  3 +++
>  2 files changed, 54 insertions(+)
>=20
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 1e43cd736d..167fb6bf3e 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -22,6 +22,7 @@
>  #include "qemu/osdep.h"
>  #include <glib/gprintf.h>
>  #include "hw/acpi/aml-build.h"
> +#include "hw/mem/memory-device.h"
>  #include "qemu/bswap.h"
>  #include "qemu/bitops.h"
>  #include "sysemu/numa.h"
> @@ -1802,3 +1803,53 @@ build_hdr:
>      build_header(linker, tbl, (void *)(tbl->data + fadt_start),
>                   "FACP", tbl->len - fadt_start, f->rev, oem_id,
> oem_table_id);
>  }
> +
> +void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
> +                                    uint64_t len, int default_node)
> +{
> +    MemoryDeviceInfoList *info_list =3D qmp_memory_device_list();
> +    MemoryDeviceInfoList *info;
> +    MemoryDeviceInfo *mi;
> +    PCDIMMDeviceInfo *di;
> +    uint64_t end =3D base + len, cur, size;
> +    bool is_nvdimm;
> +    AcpiSratMemoryAffinity *numamem;
> +    MemoryAffinityFlags flags;
> +
> +    for (cur =3D base, info =3D info_list;
> +         cur < end;
> +         cur +=3D size, info =3D info->next) {
> +        numamem =3D acpi_data_push(table_data, sizeof *numamem);
> +
> +        if (!info) {
> +            build_srat_memory(numamem, cur, end - cur, default_node,
> +                              MEM_AFFINITY_HOTPLUGGABLE |
> MEM_AFFINITY_ENABLED);
> +            break;
> +        }
> +
> +        mi =3D info->value;
> +        is_nvdimm =3D (mi->type =3D=3D
> MEMORY_DEVICE_INFO_KIND_NVDIMM);
> +        di =3D !is_nvdimm ? mi->u.dimm.data : mi->u.nvdimm.data;
> +
> +        if (cur < di->addr) {
> +            build_srat_memory(numamem, cur, di->addr - cur,
> default_node,
> +                              MEM_AFFINITY_HOTPLUGGABLE |
> MEM_AFFINITY_ENABLED);
> +            numamem =3D acpi_data_push(table_data, sizeof *numamem);
> +        }
> +
> +        size =3D di->size;
> +
> +        flags =3D MEM_AFFINITY_ENABLED;
> +        if (di->hotpluggable) {
> +            flags |=3D MEM_AFFINITY_HOTPLUGGABLE;
> +        }
> +        if (is_nvdimm) {
> +            flags |=3D MEM_AFFINITY_NON_VOLATILE;
> +        }
> +
> +        build_srat_memory(numamem, di->addr, size, di->node, flags);
> +    }
> +
> +    qapi_free_MemoryDeviceInfoList(info_list);
> +}

The above logic changes the SRAT entries if dimm is hot-added and a reboot =
is
performed and as mentioned above, EDK2 seems to be not happy with this.

I had a look at the pc code and it looks like it only has one SRAT entry fo=
r the=20
whole hot-pluggable address space[2] which probable means SRAT remains same
across reboot even after mem is hot added. Not sure why we are doing this d=
ifferently
for ARM.

Please take a look and let me know your thoughts.

Thanks,
Shameer

[1] https://github.com/tianocore/edk2/blob/master/OvmfPkg/AcpiPlatformDxe/Q=
emuFwCfgAcpi.c#L459
[2] https://github.com/eauger/qemu/blob/v3.0.0-dimm-2tb-v4/hw/i386/acpi-bui=
ld.c#L2367


> +
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 6c36903c0a..4c2ca134ee 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -416,4 +416,7 @@ void build_slit(GArray *table_data, BIOSLinker *linke=
r);
>=20
>  void build_fadt(GArray *tbl, BIOSLinker *linker, const AcpiFadtData *f,
>                  const char *oem_id, const char *oem_table_id);
> +
> +void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
> +                                    uint64_t len, int default_node);
>  #endif
> --
> 2.17.1

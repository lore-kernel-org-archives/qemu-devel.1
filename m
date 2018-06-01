Received: from eggs.gnu.org ([2001:4830:134:3::10]:47662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fOhw7-00007H-RU
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fOhw5-0008Oc-RS
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:09:35 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Fri, 1 Jun 2018 11:09:13 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8386F539C@FRAEML521-MBX.china.huawei.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-6-shameerali.kolothum.thodi@huawei.com>
	<20180528170226.3ynif3r34yejf7tp@kamzik.brq.redhat.com>
	<27825c1d-07a2-f03e-477a-03e3d778ac35@redhat.com>
In-Reply-To: <27825c1d-07a2-f03e-477a-03e3d778ac35@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 5/6] hw/arm: ACPI SRAT changes to
 accommodate non-contiguous mem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Zhaoshenglong <zhaoshenglong@huawei.com>, Linuxarm <linuxarm@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>

Hi Eric,

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: Thursday, May 31, 2018 9:16 PM
> To: Andrew Jones <drjones@redhat.com>; Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com>
> Cc: peter.maydell@linaro.org; Zhaoshenglong <zhaoshenglong@huawei.com>;
> Linuxarm <linuxarm@huawei.com>; qemu-devel@nongnu.org;
> alex.williamson@redhat.com; qemu-arm@nongnu.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>; imammedo@redhat.com
> Subject: Re: [Qemu-devel] [RFC v2 5/6] hw/arm: ACPI SRAT changes to
> accommodate non-contiguous mem
>=20
> Hi Shameer,
>=20
> On 05/28/2018 07:02 PM, Andrew Jones wrote:
> > On Wed, May 16, 2018 at 04:20:25PM +0100, Shameer Kolothum wrote:
> >> This is in preparation for the next patch where initial ram is split
> >> into a non-pluggable chunk and a pc-dimm modeled mem if  the vaild
> >> iova regions are non-contiguous.
> >>
> >> Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi@huawei.com>
> >> ---
> >>  hw/arm/virt-acpi-build.c | 24 ++++++++++++++++++++----
> >>  1 file changed, 20 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> >> index c7c6a57..8d17b40 100644
> >> --- a/hw/arm/virt-acpi-build.c
> >> +++ b/hw/arm/virt-acpi-build.c
> >> @@ -488,7 +488,7 @@ build_srat(GArray *table_data, BIOSLinker *linker,
> VirtMachineState *vms)
> >>      AcpiSratProcessorGiccAffinity *core;
> >>      AcpiSratMemoryAffinity *numamem;
> >>      int i, srat_start;
> >> -    uint64_t mem_base;
> >> +    uint64_t mem_base, mem_sz, mem_len;
> >>      MachineClass *mc =3D MACHINE_GET_CLASS(vms);
> >>      const CPUArchIdList *cpu_list =3D mc-
> >possible_cpu_arch_ids(MACHINE(vms));
> >>
> >> @@ -505,12 +505,28 @@ build_srat(GArray *table_data, BIOSLinker
> *linker, VirtMachineState *vms)
> >>          core->flags =3D cpu_to_le32(1);
> >>      }
> >>
> >> -    mem_base =3D vms->memmap[VIRT_MEM].base;
> >> +    mem_base =3D vms->bootinfo.loader_start;
> >> +    mem_sz =3D vms->bootinfo.loader_start;
> >
> > mem_sz =3D vms->bootinfo.ram_size;
> >
> > Assuming the DT generator was correct, meaning bootinfo.ram_size will
> > be the size of the non-pluggable dimm.
> >
> >
> >>      for (i =3D 0; i < nb_numa_nodes; ++i) {
> >>          numamem =3D acpi_data_push(table_data, sizeof(*numamem));
> >> -        build_srat_memory(numamem, mem_base, numa_info[i].node_mem,
> i,
> >> +        mem_len =3D MIN(numa_info[i].node_mem, mem_sz);
> >> +        build_srat_memory(numamem, mem_base, mem_len, i,
> >>                            MEM_AFFINITY_ENABLED);
> >> -        mem_base +=3D numa_info[i].node_mem;
> >> +        mem_base +=3D mem_len;
> >> +        mem_sz -=3D mem_len;
> >> +        if (!mem_sz) {
> >> +            break;
> >> +        }
> >> +    }
> >> +
> >> +    /* Create table for initial pc-dimm ram, if any */
> >> +    if (vms->bootinfo.dimm_mem) {
> >> +        numamem =3D acpi_data_push(table_data, sizeof(*numamem));
> >> +        build_srat_memory(numamem, vms->bootinfo.dimm_mem->base,
> >> +                          vms->bootinfo.dimm_mem->size,
> >> +                          vms->bootinfo.dimm_mem->node,
> >> +                          MEM_AFFINITY_ENABLED);
> If my understanding is correct the SRAT table is built only if
> nb_numa_nodes > 0. I don't get how the PC-DIMM region is exposed if NUMA
> nodes are not set?

Yes, SRAT is only build when nb_numa_nodes > 0. I had the same doubt as how=
 the Guest
will see the pc-dimm node on ACPI boot without numa nodes. But during my te=
sts, it did.

This is my qemu command options and please find below logs  with or without=
 the "numa node,nodeid=3D0"

./qemu-system-aarch64 -machine virt,kernel_irqchip=3Don,gic-version=3D3 -cp=
u host \
-kernel Image \
-initrd rootfs-iperf.cpio \
-device vfio-pci,host=3D000a:11:10.0 \
-net none \
-m 12G \
-numa node,nodeid=3D0 \
-nographic -D -d -enable-kvm \
-smp 4 \
-bios QEMU_EFI.fd \
-append "console=3DttyAMA0 root=3D/dev/vda -m 4096 rw earlycon=3Dpl011,0x90=
00000 acpi=3Dforce"
 =20

1. Guest Boot log (without -numa node,nodeid=3D0 )
---------------------------------------------------------------

[    0.000000] Boot CPU: AArch64 Processor [410fd082]
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS 3.0=3D0x78710000  ACPI 2.0=3D0x789b0000  MEMATT=
R=3D0x7ba44018=20
[    0.000000] cma: Reserved 16 MiB at 0x000000007f000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000789B0000 000024 (v02 BOCHS )
[    0.000000] ACPI: XSDT 0x00000000789A0000 000054 (v01 BOCHS  BXPCFACP 00=
000001      01000013)
[    0.000000] ACPI: FACP 0x0000000078610000 00010C (v05 BOCHS  BXPCFACP 00=
000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x0000000078620000 0011F7 (v02 BOCHS  BXPCDSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: APIC 0x0000000078600000 000198 (v03 BOCHS  BXPCAPIC 00=
000001 BXPC 00000001)
[    0.000000] ACPI: GTDT 0x00000000785F0000 000060 (v02 BOCHS  BXPCGTDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: MCFG 0x00000000785E0000 00003C (v01 BOCHS  BXPCMCFG 00=
000001 BXPC 00000001)
[    0.000000] ACPI: SPCR 0x00000000785D0000 000050 (v02 BOCHS  BXPCSPCR 00=
000001 BXPC 00000001)
[    0.000000] ACPI: IORT 0x00000000785C0000 00007C (v00 BOCHS  BXPCIORT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
[    0.000000] ACPI: NUMA: Failed to initialise from firmware
[    0.000000] NUMA: Faking a node at [mem 0x0000000000000000-0x00000003bff=
fffff]
[    0.000000] NUMA: Adding memblock [0x40000000 - 0x785bffff] on node 0
[    0.000000] NUMA: Adding memblock [0x785c0000 - 0x7862ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x78630000 - 0x786fffff] on node 0
[    0.000000] NUMA: Adding memblock [0x78700000 - 0x78b63fff] on node 0
[    0.000000] NUMA: Adding memblock [0x78b64000 - 0x7be3ffff] on node 0
[    0.000000] NUMA: Adding memblock [0x7be40000 - 0x7becffff] on node 0
[    0.000000] NUMA: Adding memblock [0x7bed0000 - 0x7bedffff] on node 0
[    0.000000] NUMA: Adding memblock [0x7bee0000 - 0x7bffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x7c000000 - 0x7fffffff] on node 0
[    0.000000] NUMA: Adding memblock [0x100000000 - 0x3bfffffff] on node 0
[    0.000000] NUMA: Initmem setup node 0 [mem 0x40000000-0x3bfffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x3bffef500-0x3bfff0fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000003bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000785bffff]
[    0.000000]   node   0: [mem 0x00000000785c0000-0x000000007862ffff]
[    0.000000]   node   0: [mem 0x0000000078630000-0x00000000786fffff]
[    0.000000]   node   0: [mem 0x0000000078700000-0x0000000078b63fff]
[    0.000000]   node   0: [mem 0x0000000078b64000-0x000000007be3ffff]
[    0.000000]   node   0: [mem 0x000000007be40000-0x000000007becffff]
[    0.000000]   node   0: [mem 0x000000007bed0000-0x000000007bedffff]
[    0.000000]   node   0: [mem 0x000000007bee0000-0x000000007bffffff]
[    0.000000]   node   0: [mem 0x000000007c000000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000003bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000003bffff=
fff]
[    0.000000] psci: probing for conduit method from ACPI.


2. Guest Boot log (with -numa node,nodeid=3D0 )

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.11.0-rc1-g7426f0c (shameer@shameer-ubuntu) (=
gcc version 4.9.2 20140904 (prerelease) (crosstool-NG linaro-1.13.1-4.9-201=
4.09 - Linaro GCC 4.9-2014.09) ) #228 SMP PREEMPT Mon Apr 24 14:51:06 BST 2=
017
[    0.000000] Boot CPU: AArch64 Processor [410fd082]
[    0.000000] earlycon: pl11 at MMIO 0x0000000009000000 (options '')
[    0.000000] bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II
[    0.000000] efi:  SMBIOS 3.0=3D0x78710000  ACPI 2.0=3D0x789b0000  MEMATT=
R=3D0x7ba44018=20
[    0.000000] cma: Reserved 16 MiB at 0x000000007f000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000789B0000 000024 (v02 BOCHS )
[    0.000000] ACPI: XSDT 0x00000000789A0000 00005C (v01 BOCHS  BXPCFACP 00=
000001      01000013)
[    0.000000] ACPI: FACP 0x0000000078610000 00010C (v05 BOCHS  BXPCFACP 00=
000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x0000000078620000 0011F7 (v02 BOCHS  BXPCDSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: APIC 0x0000000078600000 000198 (v03 BOCHS  BXPCAPIC 00=
000001 BXPC 00000001)
[    0.000000] ACPI: GTDT 0x00000000785F0000 000060 (v02 BOCHS  BXPCGTDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: MCFG 0x00000000785E0000 00003C (v01 BOCHS  BXPCMCFG 00=
000001 BXPC 00000001)
[    0.000000] ACPI: SPCR 0x00000000785D0000 000050 (v02 BOCHS  BXPCSPCR 00=
000001 BXPC 00000001)
[    0.000000] ACPI: SRAT 0x00000000785C0000 0000C8 (v03 BOCHS  BXPCSRAT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: IORT 0x00000000785B0000 00007C (v00 BOCHS  BXPCIORT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: SPCR: console: pl011,mmio,0x9000000,9600
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x0 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x1 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x2 -> Node 0
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x3 -> Node 0
[    0.000000] NUMA: Adding memblock [0x40000000 - 0x7fffffff] on node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000-0x7fffffff]
[    0.000000] NUMA: Adding memblock [0x100000000 - 0x3bfffffff] on node 0
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x3bfffffff]
[    0.000000] NUMA: Initmem setup node 0 [mem 0x40000000-0x3bfffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x3bffef500-0x3bfff0fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000003bfffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x00000000785affff]
[    0.000000]   node   0: [mem 0x00000000785b0000-0x000000007862ffff]
[    0.000000]   node   0: [mem 0x0000000078630000-0x00000000786fffff]
[    0.000000]   node   0: [mem 0x0000000078700000-0x0000000078b63fff]
[    0.000000]   node   0: [mem 0x0000000078b64000-0x000000007be3ffff]
[    0.000000]   node   0: [mem 0x000000007be40000-0x000000007becffff]
[    0.000000]   node   0: [mem 0x000000007bed0000-0x000000007bedffff]
[    0.000000]   node   0: [mem 0x000000007bee0000-0x000000007bffffff]
[    0.000000]   node   0: [mem 0x000000007c000000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x00000003bfffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x00000003bffff=
fff]
[    0.000000] psci: probing for conduit method from ACPI.


In both cases the memblock [0x100000000 - 0x3bfffffff] is present which cor=
responds to the=20
pc-dimm slot. My guess is, this is because the guest kernel retrieves the U=
EFI params from
FDT when EFI boot is detected.

[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by EDK II

May be I am missing something here or there are other boot scenarios where =
this is not the case.

Please let me know your thoughts.

Thanks,
Shameer

> Thanks
>=20
> Eric
> >> +
> >>      }
> >>
> >>      build_header(linker, table_data, (void *)(table_data->data + srat=
_start),
> >> --
> >> 2.7.4
> >>
> >>
> >>
> >

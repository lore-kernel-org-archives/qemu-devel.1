Received: from eggs.gnu.org ([2001:4830:134:3::10]:41189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fO2S7-0001m8-RN
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fO2S6-0003x0-RO
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:51:51 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 30 May 2018 14:51:32 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8386F1839@FRAEML521-MBX.china.huawei.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-6-shameerali.kolothum.thodi@huawei.com>
	<20180528170226.3ynif3r34yejf7tp@kamzik.brq.redhat.com>
In-Reply-To: <20180528170226.3ynif3r34yejf7tp@kamzik.brq.redhat.com>
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
To: Andrew Jones <drjones@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, "imammedo@redhat.com" <imammedo@redhat.com>



> -----Original Message-----
> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Monday, May 28, 2018 6:02 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> peter.maydell@linaro.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Linuxarm <linuxarm@huawei.com>;
> eric.auger@redhat.com; alex.williamson@redhat.com; Zhaoshenglong
> <zhaoshenglong@huawei.com>; imammedo@redhat.com
> Subject: Re: [Qemu-devel] [RFC v2 5/6] hw/arm: ACPI SRAT changes to
> accommodate non-contiguous mem
>=20
> On Wed, May 16, 2018 at 04:20:25PM +0100, Shameer Kolothum wrote:
> > This is in preparation for the next patch where initial ram is split
> > into a non-pluggable chunk and a pc-dimm modeled mem if  the vaild
> > iova regions are non-contiguous.
> >
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  hw/arm/virt-acpi-build.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > index c7c6a57..8d17b40 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -488,7 +488,7 @@ build_srat(GArray *table_data, BIOSLinker *linker,
> VirtMachineState *vms)
> >      AcpiSratProcessorGiccAffinity *core;
> >      AcpiSratMemoryAffinity *numamem;
> >      int i, srat_start;
> > -    uint64_t mem_base;
> > +    uint64_t mem_base, mem_sz, mem_len;
> >      MachineClass *mc =3D MACHINE_GET_CLASS(vms);
> >      const CPUArchIdList *cpu_list =3D mc-
> >possible_cpu_arch_ids(MACHINE(vms));
> >
> > @@ -505,12 +505,28 @@ build_srat(GArray *table_data, BIOSLinker *linker=
,
> VirtMachineState *vms)
> >          core->flags =3D cpu_to_le32(1);
> >      }
> >
> > -    mem_base =3D vms->memmap[VIRT_MEM].base;
> > +    mem_base =3D vms->bootinfo.loader_start;
> > +    mem_sz =3D vms->bootinfo.loader_start;
>=20
> mem_sz =3D vms->bootinfo.ram_size;
>=20
> Assuming the DT generator was correct, meaning bootinfo.ram_size will
> be the size of the non-pluggable dimm.

Oops!. I will correct that.

Thanks,
Shameer


> >      for (i =3D 0; i < nb_numa_nodes; ++i) {
> >          numamem =3D acpi_data_push(table_data, sizeof(*numamem));
> > -        build_srat_memory(numamem, mem_base, numa_info[i].node_mem, i,
> > +        mem_len =3D MIN(numa_info[i].node_mem, mem_sz);
> > +        build_srat_memory(numamem, mem_base, mem_len, i,
> >                            MEM_AFFINITY_ENABLED);
> > -        mem_base +=3D numa_info[i].node_mem;
> > +        mem_base +=3D mem_len;
> > +        mem_sz -=3D mem_len;
> > +        if (!mem_sz) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    /* Create table for initial pc-dimm ram, if any */
> > +    if (vms->bootinfo.dimm_mem) {
> > +        numamem =3D acpi_data_push(table_data, sizeof(*numamem));
> > +        build_srat_memory(numamem, vms->bootinfo.dimm_mem->base,
> > +                          vms->bootinfo.dimm_mem->size,
> > +                          vms->bootinfo.dimm_mem->node,
> > +                          MEM_AFFINITY_ENABLED);
> > +
> >      }
> >
> >      build_header(linker, table_data, (void *)(table_data->data + srat_=
start),
> > --
> > 2.7.4
> >
> >
> >

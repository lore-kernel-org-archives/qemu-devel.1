Received: from eggs.gnu.org ([2001:4830:134:3::10]:57092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1f95XN-0002G6-0J
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1f95XF-0002KM-6q
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 05:07:29 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Thu, 19 Apr 2018 09:06:30 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83868CA39@FRAEML521-MBX.china.huawei.com>
References: <1510622154-17224-1-git-send-email-zhuyijun@huawei.com>
	<1510622154-17224-4-git-send-email-zhuyijun@huawei.com>
	<20171114145002.jbrw7k4n2m2rfwes@kamzik.brq.redhat.com>
In-Reply-To: <20171114145002.jbrw7k4n2m2rfwes@kamzik.brq.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 3/5] hw/arm: add scattered RAM memory region
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Zhaoshenglong <zhaoshenglong@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>, Linuxarm <linuxarm@huawei.com>

Hi Andrew,

> -----Original Message-----
> From: Andrew Jones [mailto:drjones@redhat.com]
> Sent: Tuesday, November 14, 2017 2:50 PM
> To: Zhuyijun <zhuyijun@huawei.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Shameerali Kolothum
> Thodi <shameerali.kolothum.thodi@huawei.com>; Zhaoshenglong
> <zhaoshenglong@huawei.com>
> Subject: Re: [Qemu-devel] [RFC 3/5] hw/arm: add scattered RAM memory
> region support
>=20
> On Tue, Nov 14, 2017 at 09:15:52AM +0800, zhuyijun@huawei.com wrote:
> > From: Zhu Yijun <zhuyijun@huawei.com>
> >
> > Dig out reserved memory holes and collect scattered RAM memory
> > regions by adding mem_list member in arm_boot_info struct.
> >
> > Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
> > ---
> >  hw/arm/boot.c        |   8 ++++
> >  hw/arm/virt.c        | 101
> ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/hw/arm/arm.h |   1 +
> >  3 files changed, 108 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> > index c2720c8..30438f4 100644
> > --- a/hw/arm/boot.c
> > +++ b/hw/arm/boot.c
> > @@ -836,6 +836,14 @@ static void arm_load_kernel_notify(Notifier
> *notifier, void *data)
> >       */
> >      assert(!(info->secure_board_setup && kvm_enabled()));
> >
> > +    /* If machine is not virt, the mem_list will empty. */
> > +    if (QLIST_EMPTY(&vms->bootinfo.mem_list)) {
> > +        RAMRegion *new =3D g_new(RAMRegion, 1);
> > +        new->base =3D info->loader_start;
> > +        new->size =3D info->ram_size;
> > +        QLIST_INSERT_HEAD(&vms->bootinfo.mem_list, new, next);
> > +    }
> > +
> >      info->dtb_filename =3D qemu_opt_get(qemu_get_machine_opts(), "dtb"=
);
> >
> >      /* Load the kernel.  */
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index ddde5e1..ff334c1 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -56,6 +56,7 @@
> >  #include "hw/smbios/smbios.h"
> >  #include "qapi/visitor.h"
> >  #include "standard-headers/linux/input.h"
> > +#include "hw/vfio/vfio-common.h"
> >
> >  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> >      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> > @@ -1225,6 +1226,98 @@ void virt_machine_done(Notifier *notifier, void
> *data)
> >      virt_build_smbios(vms);
> >  }
> >
> > +static void handle_reserved_ram_region_overlap(void)
> > +{
> > +    hwaddr cur_end, next_end;
> > +    RAMRegion *reg, *next_reg, *tmp_reg;
> > +
> > +    QLIST_FOREACH(reg, &reserved_ram_regions, next) {
> > +        next_reg =3D QLIST_NEXT(reg, next);
> > +
> > +        while (next_reg && next_reg->base <=3D (reg->base + reg->size)=
) {
> > +            next_end =3D next_reg->base + next_reg->size;
> > +            cur_end =3D reg->base + reg->size;
> > +            if (next_end > cur_end) {
> > +                reg->size +=3D (next_end - cur_end);
> > +            }
> > +
> > +            tmp_reg =3D QLIST_NEXT(next_reg, next);
> > +            QLIST_REMOVE(next_reg, next);
> > +            g_free(next_reg);
> > +            next_reg =3D tmp_reg;
> > +        }
> > +    }
> > +}
>=20
> Why isn't the above integrated into the reserved ram region insertion?
>=20
> > +
> > +static void update_memory_regions(VirtMachineState *vms, hwaddr
> ram_size)
> > +{
> > +
> > +    RAMRegion *new, *reg, *last =3D NULL;
> > +    hwaddr virt_start, virt_end;
>=20
> Either need a blank line here, or to initialize virt_start/end on the
> declaration lines.
>=20
> > +    virt_start =3D vms->memmap[VIRT_MEM].base;
> > +    virt_end =3D virt_start + ram_size - 1;
> > +
> > +    handle_reserved_ram_region_overlap();
> > +
> > +    QLIST_FOREACH(reg, &reserved_ram_regions, next) {
> > +        if (reg->base >=3D virt_start && reg->base < virt_end) {
>=20
> What about the case where reg->base + reg->size > virt_start?
>=20
> > +            if (reg->base =3D=3D virt_start) {
> > +                virt_start +=3D reg->size;
>=20
> We can't move virt_start without breaking AAVMF.
>=20
> > +                virt_end +=3D reg->size;
>=20
> We can't increase virt_end without checking it against RAMLIMIT.
>=20
> > +                continue;
> > +            } else {
> > +                new =3D g_new(RAMRegion, 1);
> > +                new->base =3D virt_start;
> > +                new->size =3D reg->base - virt_start;
> > +                virt_start =3D reg->base + reg->size;
> > +            }
> > +
> > +            if (QLIST_EMPTY(&vms->bootinfo.mem_list)) {
> > +                QLIST_INSERT_HEAD(&vms->bootinfo.mem_list, new, next);
> > +            } else {
> > +                QLIST_INSERT_AFTER(last, new, next);
> > +            }
> > +
> > +            last =3D new;
> > +            ram_size -=3D new->size;
> > +            virt_end +=3D reg->size;
> > +        }
> > +    }
> > +
> > +    if (ram_size > 0) {
> > +        new =3D g_new(RAMRegion, 1);
> > +        new->base =3D virt_start;
> > +        new->size =3D ram_size;
> > +
> > +        if (QLIST_EMPTY(&vms->bootinfo.mem_list)) {
> > +            QLIST_INSERT_HEAD(&vms->bootinfo.mem_list, new, next);
> > +        } else {
> > +            QLIST_INSERT_AFTER(last, new, next);
> > +        }
> > +    }
>=20
> Where's the else? ram_size <=3D 0 is not likely something we should ignor=
e.
>=20
> > +}
> > +
> > +static void create_ram_alias(VirtMachineState *vms,
> > +                             MemoryRegion *sysmem,
> > +                             MemoryRegion *ram)
> > +{
> > +    RAMRegion *reg;
> > +    MemoryRegion *ram_memory;
> > +    char *nodename;
> > +    hwaddr sz =3D 0;
> > +
> > +    QLIST_FOREACH(reg, &vms->bootinfo.mem_list, next) {
> > +        nodename =3D g_strdup_printf("ram@%" PRIx64, reg->base);
> > +        ram_memory =3D g_new(MemoryRegion, 1);
> > +        memory_region_init_alias(ram_memory, NULL, nodename, ram, sz,
> > +                                 reg->size);
> > +        memory_region_add_subregion(sysmem, reg->base, ram_memory);
> > +        sz +=3D reg->size;
> > +
> > +        g_free(nodename);
> > +    }
> > +}
>=20
> Instead of using memory region aliases, it would be best if each RAM
> region was modeled with pc-dimms, as that would move us towards supportin=
g
> memory hotplug and allow the regions to be explicitly identified
> (start/size) on the command line - supporting migration. Actually, how
> does this series address migration? What if the host we migrate to doesn'=
t
> have the same reserved regions in sysfs?

Thanks for going through this series and comments.

I am looking into reviving this series based on the new proposed vfio iova=
=20
interface[1]. The vfio interface will now provide  a list of valid iova ran=
ges.
That means, instead of working on reserved regions to find out the valid
 memory regions, the code here will have the valid regions list directly.

The above comment of yours mentions about modelling the memory regions
with pc-dimms. If I understand that proposal correctly, in case the iova li=
st
has  multiple entries in it(means there are holes in the memory) the extra
regions has to be added as a pc-dimm slot memory. Having gone through
the Qemu source, I am not sure what is the best way to accomplish that.
(of course I am not that familiar with the Qemu source). Is it ok to invoke
qdev_device_add() from here? Any pointers on this is very appreciated.

One more point is, considering the fact that ARM64 linux kernel still doesn=
't
support hotplug memory at the moment, not sure how much we gain
from the pc-dimm model.

Please let me know your thoughts on this.

Thanks,
Shameer

[1]. https://lkml.org/lkml/2018/4/18/293


> > +
> >  static void virt_ram_memory_region_init(Notifier *notifier, void *data=
)
> >  {
> >      MachineState *machine =3D MACHINE(qdev_get_machine());
> > @@ -1232,10 +1325,15 @@ static void
> virt_ram_memory_region_init(Notifier *notifier, void *data)
> >      MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> >      VirtMachineState *vms =3D container_of(notifier, VirtMachineState,
> >                                           ram_memory_region_init);
> > +    RAMRegion *first_mem_reg;
> >
> >      memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
> >                                           machine->ram_size);
> > -    memory_region_add_subregion(sysmem, vms-
> >memmap[VIRT_MEM].base, ram);
> > +    update_memory_regions(vms, machine->ram_size);
> > +    create_ram_alias(vms, sysmem, ram);
> > +
> > +    first_mem_reg =3D QLIST_FIRST(&vms->bootinfo.mem_list);
> > +    vms->bootinfo.loader_start =3D first_mem_reg->base;
> >  }
> >
> >  static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
> > @@ -1458,7 +1556,6 @@ static void machvirt_init(MachineState *machine)
> >      vms->bootinfo.initrd_filename =3D machine->initrd_filename;
> >      vms->bootinfo.nb_cpus =3D smp_cpus;
> >      vms->bootinfo.board_id =3D -1;
> > -    vms->bootinfo.loader_start =3D vms->memmap[VIRT_MEM].base;
> >      vms->bootinfo.get_dtb =3D machvirt_dtb;
> >      vms->bootinfo.firmware_loaded =3D firmware_loaded;
> >      arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
> > diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
> > index ce769bd..d953026 100644
> > --- a/include/hw/arm/arm.h
> > +++ b/include/hw/arm/arm.h
> > @@ -124,6 +124,7 @@ struct arm_boot_info {
> >      bool secure_board_setup;
> >
> >      arm_endianness endianness;
> > +    QLIST_HEAD(, RAMRegion) mem_list;
> >  };
> >
> >  /**
> > --
> > 1.8.3.1
> >
> >
> >
>=20
> Thanks,
> drew

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fO2Kg-00056Q-JH
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:44:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1fO2Kf-000891-CN
	for qemu-devel@nongnu.org; Wed, 30 May 2018 10:44:10 -0400
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Wed, 30 May 2018 14:43:54 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8386F17BD@FRAEML521-MBX.china.huawei.com>
References: <20180516152026.2920-1-shameerali.kolothum.thodi@huawei.com>
	<20180516152026.2920-3-shameerali.kolothum.thodi@huawei.com>
	<58fb3661-8c2a-7fef-aeaa-ab175ea5bdd9@redhat.com>
In-Reply-To: <58fb3661-8c2a-7fef-aeaa-ab175ea5bdd9@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 2/6] hw/arm/virt: Enable dynamic
 generation of guest RAM memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "drjones@redhat.com" <drjones@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Linuxarm <linuxarm@huawei.com>

Hi Eric.

> -----Original Message-----
> From: Auger Eric [mailto:eric.auger@redhat.com]
> Sent: Monday, May 28, 2018 3:22 PM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> qemu-devel@nongnu.org; qemu-arm@nongnu.org
> Cc: drjones@redhat.com; imammedo@redhat.com; peter.maydell@linaro.org;
> alex.williamson@redhat.com; Zhaoshenglong <zhaoshenglong@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>; Linuxarm
> <linuxarm@huawei.com>
> Subject: Re: [RFC v2 2/6] hw/arm/virt: Enable dynamic generation of guest
> RAM memory regions
>=20
> Hi Shameer,
> On 05/16/2018 05:20 PM, Shameer Kolothum wrote:
> > Register ram_memory_region_init notifier to allocate memory region
> > from system memory.
>=20
> At this stage the commit message does not explain why you need a machine
> init done notifier. Also the commit title does not summarize the actual
> change.
> Thanks

Right. I will reword/rephrase the text.

Thanks,
Shameer

> Eric
> >
> > Signed-off-by: Zhu Yijun <zhuyijun@huawei.com>
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > ---
> >  hw/arm/virt.c         | 28 ++++++++++++++++++++++------
> >  include/hw/arm/virt.h |  1 +
> >  2 files changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 94dcb12..05fcb62 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1171,6 +1171,19 @@ void virt_machine_done(Notifier *notifier, void
> *data)
> >      virt_build_smbios(vms);
> >  }
> >
> > +static void virt_ram_memory_region_init(Notifier *notifier, void *data=
)
> > +{
> > +    MemoryRegion *sysmem =3D get_system_memory();
> > +    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> > +    VirtMachineState *vms =3D container_of(notifier, VirtMachineState,
> > +                                         ram_memory_region_init);
> > +    MachineState *machine =3D MACHINE(vms);
> > +
> > +    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
> > +                                         machine->ram_size);
> > +    memory_region_add_subregion(sysmem, vms-
> >memmap[VIRT_MEM].base, ram);
> > +}
> > +
> >  static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
> >  {
> >      uint8_t clustersz =3D ARM_DEFAULT_CPUS_PER_CLUSTER;
> > @@ -1204,7 +1217,6 @@ static void machvirt_init(MachineState *machine)
> >      MemoryRegion *sysmem =3D get_system_memory();
> >      MemoryRegion *secure_sysmem =3D NULL;
> >      int n, virt_max_cpus;
> > -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> >      bool firmware_loaded =3D bios_name || drive_get(IF_PFLASH, 0, 0);
> >
> >      /* We can probe only here because during property set
> > @@ -1361,10 +1373,6 @@ static void machvirt_init(MachineState *machine)
> >      fdt_add_timer_nodes(vms);
> >      fdt_add_cpu_nodes(vms);
> >
> > -    memory_region_allocate_system_memory(ram, NULL, "mach-virt.ram",
> > -                                         machine->ram_size);
> > -    memory_region_add_subregion(sysmem, vms-
> >memmap[VIRT_MEM].base, ram);
> > -
> >      create_flash(vms, sysmem, secure_sysmem ? secure_sysmem : sysmem);
> >
> >      create_gic(vms, pic);
> > @@ -1405,15 +1413,23 @@ static void machvirt_init(MachineState
> *machine)
> >      vms->bootinfo.loader_start =3D vms->memmap[VIRT_MEM].base;
> >      vms->bootinfo.get_dtb =3D machvirt_dtb;
> >      vms->bootinfo.firmware_loaded =3D firmware_loaded;
> > +
> > +    /* Register notifiers. They are executed in registration reverse o=
rder */
> >      arm_load_kernel(ARM_CPU(first_cpu), &vms->bootinfo);
> >
> >      /*
> >       * arm_load_kernel machine init done notifier registration must
> >       * happen before the platform_bus_create call. In this latter,
> >       * another notifier is registered which adds platform bus nodes.
> > -     * Notifiers are executed in registration reverse order.
> >       */
> >      create_platform_bus(vms, pic);
> > +
> > +    /*
> > +     * Register memory region notifier last as this has to be executed
> > +     * first.
> > +     */
> > +    vms->ram_memory_region_init.notify =3D virt_ram_memory_region_init=
;
> > +    qemu_add_machine_init_done_notifier(&vms-
> >ram_memory_region_init);
> >  }
> >
> >  static bool virt_get_secure(Object *obj, Error **errp)
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > index ba0c1a4..fc24f3a 100644
> > --- a/include/hw/arm/virt.h
> > +++ b/include/hw/arm/virt.h
> > @@ -91,6 +91,7 @@ typedef struct {
> >  typedef struct {
> >      MachineState parent;
> >      Notifier machine_done;
> > +    Notifier ram_memory_region_init;
> >      FWCfgState *fw_cfg;
> >      bool secure;
> >      bool highmem;
> >

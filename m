Received: from eggs.gnu.org ([209.51.188.92]:49217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzfNM-0007Dc-FW
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzfNL-00068O-Lj
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:26:44 -0500
Date: Fri, 1 Mar 2019 11:26:35 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190301112635.40200742@redhat.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8392D81D6@lhreml524-mbs.china.huawei.com>
References: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
	<20190128110545.20644-4-shameerali.kolothum.thodi@huawei.com>
	<20190301101204.361adfb6@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392D81D6@lhreml524-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] hw/arm/virt: Enable pc-dimm
 hotplug support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>

On Fri, 1 Mar 2019 09:23:11 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov [mailto:imammedo@redhat.com]
> > Sent: 01 March 2019 09:12
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: eric.auger@redhat.com; shannon.zhaosl@gmail.com;
> > peter.maydell@linaro.org; qemu-devel@nongnu.org; qemu-arm@nongnu.org;
> > Linuxarm <linuxarm@huawei.com>; xuwei (O) <xuwei5@huawei.com>
> > Subject: Re: [Qemu-devel] [RFC PATCH 3/4] hw/arm/virt: Enable pc-dimm
> > hotplug support
> > 
> > On Mon, 28 Jan 2019 11:05:45 +0000
> > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:
> >   
> > > pc-dimm memory hotplug is enabled using GPIO(Pin 2) based ACPI
> > > event. Hot removal functionality is not yet supported.
> > >
> > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >  hw/arm/virt.c | 57  
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++--  
> > >  1 file changed, 55 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 884960d..cf64554 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -62,6 +62,7 @@
> > >  #include "hw/mem/pc-dimm.h"
> > >  #include "hw/mem/nvdimm.h"
> > >  #include "hw/acpi/acpi.h"
> > > +#include "hw/acpi/pc-hotplug.h"  
> > it looks like x86 specific file, what is this here for?  
> 
> Yes. That is for ACPI_MEMORY_HOTPLUG_BASE which is only used by x86
> at the moment. I guess, it can be moved to hw/acpi/memory_hotplug.h ?
it's GPA and pc/q35 impl. specific so you should use it,
this address will always be board specific one.
Makeup a virt specific one

> 
> > >
> > >  #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
> > >      static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
> > > @@ -1651,7 +1652,14 @@ static void machvirt_init(MachineState  
> > *machine)  
> > >          nvdimm_init_acpi_state(acpi_nvdimm_state, sysmem,
> > >                                 vms->fw_cfg, OBJECT(vms));
> > >      }
> > > +    if (vms->acpi_memhp_state.is_enabled) {
> > > +        MemHotplugState *state =  &vms->acpi_memhp_state;
> > > +        hwaddr base;
> > >
> > > +        state->hw_reduced_acpi = true;
> > > +        base = vms->memmap[VIRT_ACPI_IO].base +  
> > ACPI_MEMORY_HOTPLUG_BASE;  
well, this is confusing, why adding 2 base addresses?
If vms->memmap[VIRT_ACPI_IO].base is already set than why not use it
as is without adding an offset?


> > > +        acpi_memory_hotplug_init(sysmem, OBJECT(vms), state, base);
> > > +    }
> > >      vms->bootinfo.ram_size = machine->ram_size;
> > >      vms->bootinfo.kernel_filename = machine->kernel_filename;
> > >      vms->bootinfo.kernel_cmdline = machine->kernel_cmdline;  
> > [...]  

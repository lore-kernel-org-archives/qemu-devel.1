Received: from eggs.gnu.org ([209.51.188.92]:54258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzOnh-0000UV-7A
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:44:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gzOnf-0001CU-Kt
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 11:44:49 -0500
Date: Thu, 28 Feb 2019 17:44:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190228174424.1cae71b8@redhat.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8392D7AB9@lhreml524-mbs.china.huawei.com>
References: <20190128110545.20644-1-shameerali.kolothum.thodi@huawei.com>
	<20190128110545.20644-2-shameerali.kolothum.thodi@huawei.com>
	<b1cd0cb1-d914-3d04-8a48-c53e0c63eed2@redhat.com>
	<5FC3163CFD30C246ABAA99954A238FA8392D7AB9@lhreml524-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] hw:acpi: Make ACPI IO address
 space configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: Auger Eric <eric.auger@redhat.com>, "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei (O)" <xuwei5@huawei.com>, Linuxarm <linuxarm@huawei.com>

On Thu, 28 Feb 2019 16:09:48 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Hi Eric,
> 
> > -----Original Message-----
> > From: Auger Eric [mailto:eric.auger@redhat.com]
> > Sent: 27 February 2019 17:53
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > shannon.zhaosl@gmail.com; peter.maydell@linaro.org;
> > imammedo@redhat.com; qemu-devel@nongnu.org; qemu-arm@nongnu.org
> > Cc: xuwei (O) <xuwei5@huawei.com>; Linuxarm <linuxarm@huawei.com>
> > Subject: Re: [RFC PATCH 1/4] hw:acpi: Make ACPI IO address space
> > configurable
> > 
> > Hi Shameer,
> > On 1/28/19 12:05 PM, Shameer Kolothum wrote:  
> > > This is in preparation for adding support for ARM64 platforms where it
> > > doesn't use port mapped IO for ACPI IO space.
> > >
> > > Also add a flag to identify hw reduced ACPI platforms as they might
> > > use GPIO hw for signaling ACPI platform events.
> > >
> > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> > > ---
> > >  hw/acpi/memory_hotplug.c         | 13 ++++++++-----
> > >  hw/i386/acpi-build.c             |  3 ++-
> > >  include/hw/acpi/memory_hotplug.h |  6 ++++--
> > >  3 files changed, 14 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c index
> > > 921cad2..05f1d45 100644
> > > --- a/hw/acpi/memory_hotplug.c
> > > +++ b/hw/acpi/memory_hotplug.c
> > > @@ -34,7 +34,7 @@
> > >  #define MEMORY_HOTPLUG_IO_LEN         24
> > >  #define MEMORY_DEVICES_CONTAINER     "\\_SB.MHPC"
> > >
> > > -static uint16_t memhp_io_base;
> > > +static hwaddr memhp_io_base;
> > >
> > >  static ACPIOSTInfo *acpi_memory_device_status(int slot, MemStatus
> > > *mdev)  { @@ -208,7 +208,7 @@ static const MemoryRegionOps
> > > acpi_memory_hotplug_ops = {  };
> > >
> > >  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> > > -                              MemHotplugState *state, uint16_t  
> > io_base)  
> > > +                              MemHotplugState *state, hwaddr  
> > io_base)  
> > >  {
> > >      MachineState *machine = MACHINE(qdev_get_machine());
> > >
> > > @@ -279,7 +279,9 @@ void acpi_memory_plug_cb(HotplugHandler  
> > *hotplug_dev, MemHotplugState *mem_st,  
> > >      mdev->is_enabled = true;
> > >      if (dev->hotplugged) {
> > >          mdev->is_inserting = true;
> > > -        acpi_send_event(DEVICE(hotplug_dev),  
> > ACPI_MEMORY_HOTPLUG_STATUS);  
> > > +        if (!mem_st->hw_reduced_acpi) {
> > > +            acpi_send_event(DEVICE(hotplug_dev),  
> > ACPI_MEMORY_HOTPLUG_STATUS);  
> > > +        }
> > >      }
> > >  }
> > >
> > > @@ -341,7 +343,8 @@ const VMStateDescription  
> > vmstate_memory_hotplug =  
> > > {
> > >
> > >  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> > >                                const char *res_root,
> > > -                              const char *event_handler_method)
> > > +                              const char *event_handler_method,
> > > +                              AmlRegionSpace rs)
> > >  {
> > >      int i;
> > >      Aml *ifctx;
> > > @@ -371,7 +374,7 @@ void build_memory_hotplug_aml(Aml *table,  
> > uint32_t nr_mem,  
> > >          aml_append(mem_ctrl_dev, aml_name_decl("_CRS", crs));
> > >
> > >          aml_append(mem_ctrl_dev, aml_operation_region(
> > > -            MEMORY_HOTPLUG_IO_REGION, AML_SYSTEM_IO,
> > > +            MEMORY_HOTPLUG_IO_REGION, rs,
> > >              aml_int(memhp_io_base), MEMORY_HOTPLUG_IO_LEN)  
> > Given the change in the datatype (memhp_io_base) is it OK to keep the
> > aml_int() cast.  
> 
> Hmm...aml_int() has uint64_t but not sure hwaddr will cause any unwarranted effects on
> other platforms. Do you see any potential issues here?
aml_int encodes it according to the value so it should e fine

> 
> > Also we have
> > "
> >         aml_append(crs,
> >             aml_io(AML_DECODE16, memhp_io_base, memhp_io_base, 0,
> >                    MEMORY_HOTPLUG_IO_LEN)
> >         );
> > " where we have aml_io being used + AML_decode16. Shouldn't we have
> > aml_*_memory depending on rs?  
> 
> That looks like a valid point, but then I wonder how this worked. I will double check.

maybe use aml_memory32_fixed() or aml_[dq]word_memory()

  
> > I am not knowledged enough about the aml description but just in case.  
> 
> Same here :).
> 
> Thanks,
> Shameer
> 
> 
> > Thanks
> > 
> > Eric
> >   
> > >          );
> > >
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c index
> > > 2e21a31..b62c1a3 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -1852,7 +1852,8 @@ build_dsdt(GArray *table_data, BIOSLinker  
> > *linker,  
> > >          build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
> > >                         "\\_SB.PCI0", "\\_GPE._E02");
> > >      }
> > > -    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0",  
> > "\\_GPE._E03");  
> > > +    build_memory_hotplug_aml(dsdt, nr_mem, "\\_SB.PCI0",
> > > +                             "\\_GPE._E03", AML_SYSTEM_IO);
> > >
> > >      scope =  aml_scope("_GPE");
> > >      {
> > > diff --git a/include/hw/acpi/memory_hotplug.h
> > > b/include/hw/acpi/memory_hotplug.h
> > > index 77c6576..ec56579 100644
> > > --- a/include/hw/acpi/memory_hotplug.h
> > > +++ b/include/hw/acpi/memory_hotplug.h
> > > @@ -26,10 +26,11 @@ typedef struct MemHotplugState {
> > >      uint32_t selector;
> > >      uint32_t dev_count;
> > >      MemStatus *devs;
> > > +    bool hw_reduced_acpi; /*true for hw reduced acpi platform */
> > >  } MemHotplugState;
> > >
> > >  void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
> > > -                              MemHotplugState *state, uint16_t  
> > io_base);  
> > > +                              MemHotplugState *state, hwaddr
> > > + io_base);
> > >
> > >  void acpi_memory_plug_cb(HotplugHandler *hotplug_dev,  
> > MemHotplugState *mem_st,  
> > >                           DeviceState *dev, Error **errp); @@ -48,5
> > > +49,6 @@ void acpi_memory_ospm_status(MemHotplugState *mem_st,
> > > ACPIOSTInfoList ***list);
> > >
> > >  void build_memory_hotplug_aml(Aml *table, uint32_t nr_mem,
> > >                                const char *res_root,
> > > -                              const char *event_handler_method);
> > > +                              const char *event_handler_method,
> > > +                              AmlRegionSpace rs);
> > >  #endif
> > >  

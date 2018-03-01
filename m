Received: from eggs.gnu.org ([2001:4830:134:3::10]:58127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1erNpk-0002pf-UA
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1erNpe-0006dr-Pd
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:01:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1erNpe-0006dY-JP
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:01:10 -0500
Date: Thu, 1 Mar 2018 14:01:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180301140107.39f30ab5@redhat.com>
In-Reply-To: <20180301115651.tyzptkekkxb2p4rl@hz-desktop>
References: <20180228040300.8914-1-haozhong.zhang@intel.com>
	<20180228040300.8914-2-haozhong.zhang@intel.com>
	<20180301114212.0cc843b3@redhat.com>
	<20180301115651.tyzptkekkxb2p4rl@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] hw/acpi-build: build SRAT memory
 affinity structures for DIMM devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, mst@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Dan Williams <dan.j.williams@intel.com>, Richard Henderson <rth@twiddle.net>

On Thu, 1 Mar 2018 19:56:51 +0800
Haozhong Zhang <haozhong.zhang@intel.com> wrote:

> On 03/01/18 11:42 +0100, Igor Mammedov wrote:
> > On Wed, 28 Feb 2018 12:02:58 +0800
> > Haozhong Zhang <haozhong.zhang@intel.com> wrote:
> >   
> > > ACPI 6.2A Table 5-129 "SPA Range Structure" requires the proximity
> > > domain of a NVDIMM SPA range must match with corresponding entry in
> > > SRAT table.
> > > 
> > > The address ranges of vNVDIMM in QEMU are allocated from the
> > > hot-pluggable address space, which is entirely covered by one SRAT
> > > memory affinity structure. However, users can set the vNVDIMM
> > > proximity domain in NFIT SPA range structure by the 'node' property of
> > > '-device nvdimm' to a value different than the one in the above SRAT
> > > memory affinity structure.
> > > 
> > > In order to solve such proximity domain mismatch, this patch builds
> > > one SRAT memory affinity structure for each static-plugged DIMM device,  
> > s/static-plugged/present at boot/
> > since after hotplug and following reset SRAT will be recreated
> > and include hotplugged DIMMs as well.  
> 
> Ah yes, I'll fix the message in the next version.
> 
> >   
> > > including both PC-DIMM and NVDIMM, with the proximity domain specified
> > > in '-device pc-dimm' or '-device nvdimm'.
> > > 
> > > The remaining hot-pluggable address space is covered by one or multiple
> > > SRAT memory affinity structures with the proximity domain of the last
> > > node as before.
> > > 
> > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > > ---
> > >  hw/i386/acpi-build.c     | 50 ++++++++++++++++++++++++++++++++++++++++++++----
> > >  hw/mem/pc-dimm.c         |  8 ++++++++
> > >  include/hw/mem/pc-dimm.h | 10 ++++++++++
> > >  3 files changed, 64 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index deb440f286..a88de06d8f 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -2323,6 +2323,49 @@ build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
> > >  #define HOLE_640K_START  (640 * 1024)
> > >  #define HOLE_640K_END   (1024 * 1024)
> > >  
> > > +static void build_srat_hotpluggable_memory(GArray *table_data, uint64_t base,
> > > +                                           uint64_t len, int default_node)
> > > +{
> > > +    GSList *dimms = pc_dimm_get_device_list();
> > > +    GSList *ent = dimms;
> > > +    PCDIMMDevice *dev;
> > > +    Object *obj;
> > > +    uint64_t end = base + len, addr, size;
> > > +    int node;
> > > +    AcpiSratMemoryAffinity *numamem;
> > > +
> > > +    while (base < end) {  
> > It's just matter of taste but wouldn't 'for' loop be better here?
> > One can see start, end and next step from the begging.  
> 
> will switch to a for loop
> 
> >   
> > > +        numamem = acpi_data_push(table_data, sizeof *numamem);
> > > +
> > > +        if (!ent) {
> > > +            build_srat_memory(numamem, base, end - base, default_node,
> > > +                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> > > +            break;
> > > +        }
> > > +
> > > +        dev = PC_DIMM(ent->data);
> > > +        obj = OBJECT(dev);
> > > +        addr = object_property_get_uint(obj, PC_DIMM_ADDR_PROP, NULL);
> > > +        size = object_property_get_uint(obj, PC_DIMM_SIZE_PROP, NULL);
> > > +        node = object_property_get_uint(obj, PC_DIMM_NODE_PROP, NULL);
> > > +
> > > +        if (base < addr) {
> > > +            build_srat_memory(numamem, base, addr - base, default_node,
> > > +                              MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED);
> > > +            numamem = acpi_data_push(table_data, sizeof *numamem);
> > > +        }
> > > +        build_srat_memory(numamem, addr, size, node,
> > > +                          MEM_AFFINITY_HOTPLUGGABLE | MEM_AFFINITY_ENABLED |  
> > Is NVDIMM hotplug supported in QEMU?
> > If not we might need make MEM_AFFINITY_HOTPLUGGABLE conditional too.  
> 
> Yes, it's supported.
> 
> >   
> > > +                          (object_dynamic_cast(obj, TYPE_NVDIMM) ?
> > > +                           MEM_AFFINITY_NON_VOLATILE : 0));  
> > it might be cleaner without inline flags duplication
> > 
> >   flags = MEM_AFFINITY_ENABLED;
> >   ...
> >   if (!ent) {
> >       flags |= MEM_AFFINITY_HOTPLUGGABLE
> >   }
> >   ...
> >   if (PCDIMMDeviceInfo::hotpluggable) { // see ***
> >       flags |= MEM_AFFINITY_HOTPLUGGABLE
> >   }
> >   ...
> >   if (object_dynamic_cast(obj, TYPE_NVDIMM))
> >       flags |= MEM_AFFINITY_NON_VOLATILE
> >   }  
> 
> I'm fine for such changes, except ***
> 
> [..]
> > > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > > index 6e74b61cb6..9fd901e87a 100644
> > > --- a/hw/mem/pc-dimm.c
> > > +++ b/hw/mem/pc-dimm.c
> > > @@ -276,6 +276,14 @@ static int pc_dimm_built_list(Object *obj, void *opaque)
> > >      return 0;
> > >  }
> > >  
> > > +GSList *pc_dimm_get_device_list(void)
> > > +{
> > > +    GSList *list = NULL;
> > > +
> > > +    object_child_foreach(qdev_get_machine(), pc_dimm_built_list, &list);
> > > +    return list;
> > > +}  
> > (***)
> > see http://lists.gnu.org/archive/html/qemu-ppc/2018-02/msg00271.html
> > You could do that in separate patch, so that it won't matter
> > whose patch got merged first and it won't affect the rest of patches.  
> 
> Sure, I can separate this part, but I would still like to use a list
> of PCDIMMDevice rather than a list of MemoryDeviceInfo. The latter
> would need to be extended to include NVDIMM information (e.g., adding
> a NVDIMMDeviceInfo to the union).
You don't have to add NVDIMMDeviceInfo until there would be
need to expose NVDIMM specific information.

qmp_pc_dimm_device_list() API is sufficient in this case
(modulo missing sorting).

Suggestion has been made to keep number of public APIs that do
almost the same at minimum.

> Haozhong
> 
> > 
> >   
> > >  uint64_t pc_dimm_get_free_addr(uint64_t address_space_start,
> > >                                 uint64_t address_space_size,
> > >                                 uint64_t *hint, uint64_t align, uint64_t size,
> > > diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
> > > index d83b957829..4cf5cc49e9 100644
> > > --- a/include/hw/mem/pc-dimm.h
> > > +++ b/include/hw/mem/pc-dimm.h
> > > @@ -100,4 +100,14 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
> > >                           MemoryRegion *mr, uint64_t align, Error **errp);
> > >  void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
> > >                             MemoryRegion *mr);
> > > +
> > > +/*
> > > + * Return a list of DeviceState of pc-dimm and nvdimm devices. The
> > > + * list is sorted in the ascendant order of the base address of
> > > + * devices.
> > > + *
> > > + * Note: callers are responsible to free the list.
> > > + */
> > > +GSList *pc_dimm_get_device_list(void);
> > > +
> > >  #endif  
> >   

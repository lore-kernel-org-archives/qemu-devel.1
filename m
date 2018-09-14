Received: from eggs.gnu.org ([2001:4830:134:3::10]:48972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0pBa-0005w1-9v
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0pBW-0007Jg-JU
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17099)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g0pBW-0007GC-9x
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 10:35:02 -0400
Date: Fri, 14 Sep 2018 16:34:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180914163447.367cb2d3@redhat.com>
In-Reply-To: <20180913142025.55af60ae@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-6-david@redhat.com>
	<20180913142025.55af60ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/20] memory-device: convert
 get_region_size() to get_memory_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 13 Sep 2018 14:20:25 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Wed, 29 Aug 2018 17:36:09 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
> > To factor out plugging and unplugging of memory device we need access to
> > the memory region. So let's replace get_region_size() by
> > get_memory_region().
this part isn't clear and doesn't really answer "why" patch's been written
and how it will really help.

> > 
> > If any memory device will in the future have multiple memory regions
> > that make up the total region size, it can simply use a wrapping memory
> > region to embed the other ones.
It might be better to document expectation as part of get_memory_region() doc comment.


I'm not really getting reasoning behind this patch.
 * Why get_region_size() doesn't work for you?
   benefits I see is that's one less get_foo_size() callback,
   so it becomes less confusing

 * I get we might need access to memory region at MemoryDeviceClass level,
   but why are you keeping PCDIMMDeviceClass::get_memory_region()?
   I'd expect the later being generalized (moved) to MemoryDeviceClass
   so we would end up with one level indirection that we have now.

> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> >  hw/mem/memory-device.c         | 10 ++++++----
> >  hw/mem/pc-dimm.c               | 19 ++++++++++++++-----
> >  include/hw/mem/memory-device.h |  2 +-
> >  3 files changed, 21 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> > index d87599c280..3bd30d98bb 100644
> > --- a/hw/mem/memory-device.c
> > +++ b/hw/mem/memory-device.c
> > @@ -56,11 +56,13 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
> >  
> >      if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
> >          const DeviceState *dev = DEVICE(obj);
> > -        const MemoryDeviceState *md = MEMORY_DEVICE(obj);
> > +        MemoryDeviceState *md = MEMORY_DEVICE(obj);  
> it's a getter, why do we loose 'const' here?
> 
> >          const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
> >  
> >          if (dev->realized) {
> > -            *size += mdc->get_region_size(md, &error_abort);
> > +            MemoryRegion *mr = mdc->get_memory_region(md, &error_abort);
> > +
> > +            *size += memory_region_size(mr);
> >          }
> >      }
> >  
> > @@ -162,12 +164,12 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
> >      /* find address range that will fit new memory device */
> >      object_child_foreach(OBJECT(ms), memory_device_build_list, &list);
> >      for (item = list; item; item = g_slist_next(item)) {
> > -        const MemoryDeviceState *md = item->data;
> > +        MemoryDeviceState *md = item->data;  
> ditto
> 
> >          const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(OBJECT(md));
> >          uint64_t md_size, md_addr;
> >  
> >          md_addr = mdc->get_addr(md);
> > -        md_size = mdc->get_region_size(md, &error_abort);
> > +        md_size = memory_region_size(mdc->get_memory_region(md, &error_abort));
> >          if (*errp) {
> >              goto out;
> >          }
> > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > index 4bf1a0acc9..a208b17c64 100644
> > --- a/hw/mem/pc-dimm.c
> > +++ b/hw/mem/pc-dimm.c
> > @@ -236,8 +236,8 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
> >      return dimm->addr;
> >  }
> >  
> > -static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
> > -                                           Error **errp)
> > +static uint64_t pc_dimm_md_get_plugged_size(const MemoryDeviceState *md,
> > +                                            Error **errp)
> >  {
> >      /* dropping const here is fine as we don't touch the memory region */
> >      PCDIMMDevice *dimm = PC_DIMM(md);
> > @@ -249,9 +249,19 @@ static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
> >          return 0;
> >      }
> >  
> > +    /* for a dimm plugged_size == region_size */
> >      return memory_region_size(mr);
> >  }
> >  
> > +static MemoryRegion *pc_dimm_md_get_memory_region(MemoryDeviceState *md,
> > +                                                  Error **errp)
> > +{
> > +    PCDIMMDevice *dimm = PC_DIMM(md);
> > +    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
> > +
> > +    return ddc->get_memory_region(dimm, errp);
> > +}
> > +
> >  static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
> >                                          MemoryDeviceInfo *info)
> >  {
> > @@ -297,9 +307,8 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
> >      ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
> >  
> >      mdc->get_addr = pc_dimm_md_get_addr;
> > -    /* for a dimm plugged_size == region_size */
> > -    mdc->get_plugged_size = pc_dimm_md_get_region_size;
> > -    mdc->get_region_size = pc_dimm_md_get_region_size;
> > +    mdc->get_plugged_size = pc_dimm_md_get_plugged_size;
> > +    mdc->get_memory_region = pc_dimm_md_get_memory_region;
> >      mdc->fill_device_info = pc_dimm_md_fill_device_info;
> >  }
> >  
> > diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
> > index f02b229837..852fd8f98a 100644
> > --- a/include/hw/mem/memory-device.h
> > +++ b/include/hw/mem/memory-device.h
> > @@ -34,7 +34,7 @@ typedef struct MemoryDeviceClass {
> >  
> >      uint64_t (*get_addr)(const MemoryDeviceState *md);
> >      uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
> > -    uint64_t (*get_region_size)(const MemoryDeviceState *md, Error **errp);
> > +    MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
> >      void (*fill_device_info)(const MemoryDeviceState *md,
> >                               MemoryDeviceInfo *info);
> >  } MemoryDeviceClass;  
> 
> 

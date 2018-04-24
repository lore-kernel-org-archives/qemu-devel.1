Received: from eggs.gnu.org ([2001:4830:134:3::10]:59679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fAz66-0006j2-Ji
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fAz63-0001aQ-99
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 10:39:10 -0400
Date: Tue, 24 Apr 2018 16:38:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180424163856.6584a73c@redhat.com>
In-Reply-To: <44c86da6-7851-d0c6-1121-6d1395a705c6@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
	<20180420123456.22196-4-david@redhat.com>
	<20180423141928.7e64b380@redhat.com>
	<860a6828-e18f-555e-274d-f9be9245eccb@redhat.com>
	<20180424152824.7a87a85c@redhat.com>
	<44c86da6-7851-d0c6-1121-6d1395a705c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] pc-dimm: factor out address space
 logic into MemoryDevice code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Tue, 24 Apr 2018 15:39:30 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 24.04.2018 15:28, Igor Mammedov wrote:
> > On Mon, 23 Apr 2018 14:44:34 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> On 23.04.2018 14:19, Igor Mammedov wrote:  
> >>> On Fri, 20 Apr 2018 14:34:56 +0200
> >>> David Hildenbrand <david@redhat.com> wrote:  
> > considering v4 queued, I'm dropping mostly nor relevant points at this point.
> > wrt, virtio I'll elaborate more in reply to Pankaj
> > 
> > [...]
> >   
> >>>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> >>>> index b860c9c582..b96efa3bf4 100644
> >>>> --- a/hw/mem/memory-device.c
> >>>> +++ b/hw/mem/memory-device.c
> >>>> @@ -15,6 +15,8 @@
> >>>>  #include "qapi/error.h"
> >>>>  #include "hw/boards.h"
> >>>>  #include "qemu/range.h"
> >>>> +#include "hw/virtio/vhost.h"
> >>>> +#include "sysemu/kvm.h"
> >>>>  
> >>>>  static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
> >>>>  {
> >>>> @@ -106,6 +108,166 @@ uint64_t get_plugged_memory_size(void)
> >>>>      return size;
> >>>>  }
> >>>>  
> >>>> +static int memory_device_used_region_size_internal(Object *obj, void *opaque)
> >>>> +{
> >>>> +    uint64_t *size = opaque;
> >>>> +
> >>>> +    if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
> >>>> +        DeviceState *dev = DEVICE(obj);
> >>>> +        MemoryDeviceState *md = MEMORY_DEVICE(obj);
> >>>> +        MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
> >>>> +
> >>>> +        if (dev->realized) {
> >>>> +            *size += mdc->get_region_size(md, &error_abort);
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    object_child_foreach(obj, memory_device_used_region_size_internal, opaque);
> >>>> +    return 0;
> >>>> +}
> >>>> +
> >>>> +static uint64_t memory_device_used_region_size(void)
> >>>> +{
> >>>> +    uint64_t size = 0;
> >>>> +
> >>>> +    memory_device_used_region_size_internal(qdev_get_machine(), &size);
> >>>> +
> >>>> +    return size;
> >>>> +}
> >>>> +
> >>>> +uint64_t memory_device_get_free_addr(uint64_t *hint, uint64_t align,
> >>>> +                                     uint64_t size, Error **errp)    
> >>> I'd suggest to pc_dimm_memory_plug/pc_dimm_get_free_addr first,
> >>> namely most of the stuff it does like checks and assigning default
> >>> values should go to pre_plug (pre realize) handler and then only
> >>> actual mapping is left for plug (after realize) handler to deal with:
> >>>     
> >>
> >> Can you elaborate what you mean by pre-plug? If this is about pre plug
> >> handler of the (machine) hotplug handler, it might be problematic for
> >> virtio devices.  
> > yes, something along these lines: c871bc70b
> > 
> >   
> 
> Yes, we can factor that out (at least) for pc-dimm later on easily.
> Seems to be just about moving a couple of calls.
yep, but there is nice side effect,
there is no need to call devicefoo::unrealize() on failure since
devicefoo:realize() hasn't been called yet.

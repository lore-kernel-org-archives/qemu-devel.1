Received: from eggs.gnu.org ([2001:4830:134:3::10]:59495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvhnl-00032R-Fp
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fvhni-0006u4-Qm
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:41:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fvhni-0006tf-I2
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 07:41:18 -0400
Date: Fri, 31 Aug 2018 08:41:08 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180831114108.GX8359@habkost.net>
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-15-david@redhat.com>
	<20180831112316.GW8359@habkost.net>
	<18b94f86-baac-45ac-75da-e80f0766d7a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18b94f86-baac-45ac-75da-e80f0766d7a3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 14/20] memory-device: ids of virtio
 based devices are special
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Aug 31, 2018 at 01:26:03PM +0200, David Hildenbrand wrote:
> On 31.08.2018 13:23, Eduardo Habkost wrote:
> > On Wed, Aug 29, 2018 at 05:36:18PM +0200, David Hildenbrand wrote:
> >> When reporting the id of virtio-based memory devices, we always have to
> >> take the one of the proxy device (parent).
> >>
> >> Expose the function, so especially virtio-based memory devices can
> >> reuse the function when filling out the id in MemoryDeviceInfo.
> >>
> >> Details:
> >>
> >> When the user creates a virtio device (e.g.  virtio-balloon-pci), two
> >> devices are actually created.
> >>
> >> 1. Virtio proxy device (e.g. TYPE_VIRTIO_BALLOON_PCI)
> >> 2. The "real" virtio device (e.g. TYPE_VIRTIO_BALLOON).
> >>
> >> 1. aliases all properties of 2, so 2. can be properly configured using 1.
> >> 1. gets the device ID set specified by the user. 2. gets no ID set.
> >>
> >> If we want to make 2. a MemoryDevice but report errors/information to the
> >> user, we always have to report the id of 1. (because that's the device the
> >> user instantiated and configured).
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/mem/memory-device.c         | 21 +++++++++++++++++++--
> >>  include/hw/mem/memory-device.h |  1 +
> >>  2 files changed, 20 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> >> index a31ba73ea7..89a0c584be 100644
> >> --- a/hw/mem/memory-device.c
> >> +++ b/hw/mem/memory-device.c
> >> @@ -19,6 +19,22 @@
> >>  #include "sysemu/kvm.h"
> >>  #include "trace.h"
> >>  
> >> +const char *memory_device_id(const MemoryDeviceState *md)
> >> +{
> >> +    Object *obj = OBJECT(md);
> >> +
> >> +    /* always use the ID of the proxy device for virtio devices */
> >> +    if (object_dynamic_cast(obj, TYPE_VIRTIO_DEVICE)) {
> >> +        if (obj->parent && object_dynamic_cast(obj->parent, TYPE_DEVICE)) {
> >> +            const DeviceState *parent_dev = DEVICE(obj->parent);
> >> +
> >> +            return parent_dev->id;
> >> +        }
> >> +        return NULL;
> > 
> > I don't like having virtio-specific code on memory-device.c.
> > What about making it generic?  Let device 2 register a read-only
> > property for the user-visible ID, and make memory_device_id() use
> > that property if it's present.
> 
> Valid point. Or avoid properties and add a function to the memory-device
> class?

That works too, and it was my first thought.  But if you want a
method whose only purpose is to return a single value without
affecting object state, a QOM property seems like a perfect fit.

Either of those options would be good enough for me, though.

-- 
Eduardo

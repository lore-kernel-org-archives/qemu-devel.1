Received: from eggs.gnu.org ([2001:4830:134:3::10]:41367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fGlD7-0004kZ-VQ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fGlD3-0005eN-WD
	for qemu-devel@nongnu.org; Thu, 10 May 2018 09:02:18 -0400
Date: Thu, 10 May 2018 15:02:06 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180510150206.1ff3ce22@redhat.com>
In-Reply-To: <19eb43f8-3bdc-fbfe-47c1-bcc1de7a64ba@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
	<19eb43f8-3bdc-fbfe-47c1-bcc1de7a64ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/8] MemoryDevice: introduce and use
 ResourceHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>

On Wed, 9 May 2018 16:13:14 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 03.05.2018 17:49, David Hildenbrand wrote:
> > Hotplug handlers usually have the following tasks:
> > 1. Allocate some resources for a new device
> > 2. Make the new device visible for the guest
> > 3. Notify the guest about the new device
> > 
> > Hotplug handlers have right now one limitation: They handle their own
> > context and only care about resources they manage.
> > 
> > We can have devices that need certain other resources that are e.g.
> > system resources managed by the machine. We need a clean way to assign
> > these resources (without violating layers as brought up by Igor).
> > 
> > One example is virtio-mem/virtio-pmem. Both device types need to be
> > assigned some region in guest physical address space. This device memory
> > belongs to the machine and is managed by it. However, virito devices are
> > hotplugged using the hotplug handler their proxy device implements. So we
> > could trigger e.g. a PCI hotplug handler for virtio-pci or a CSS/CCW
> > hotplug handler for virtio-ccw. But definetly not the machine.
> > 
> > So let's generalize the task of "assigning" resources and use it directly
> > for memory devices. We now have a clean way to support any kind of memory
> > device - independent of the underlying device type. Right now, only one
> > resource handler per device can be supported (in addition to the existing
> > hotplug handler).
> > 
> > You can find more details in patch nr 2.
> > 
> > This work is based on the already queued patch series
> >     "[PATCH v4 00/11] pc-dimm: factor out MemoryDevice"
> > 
> > David Hildenbrand (8):
> >   memory-device: always compile support for memory devices for SOFTMMU
> >   qdev: introduce ResourceHandler as a first-stage hotplug handler
> >   machine: provide default resource handler
> >   memory-device: new functions to handle resource assignment
> >   pc-dimm: implement new memory device functions
> >   machine: introduce enforce_memory_device_align() and add it for pc
> >   memory-device: factor out pre-assign into default resource handler
> >   memory-device: factor out (un)assign into default resource handler
> > 
> >  hw/Makefile.objs               |   2 +-
> >  hw/core/Makefile.objs          |   1 +
> >  hw/core/machine.c              |  70 +++++++++++++++++++++++
> >  hw/core/qdev.c                 |  41 +++++++++++++-
> >  hw/core/resource-handler.c     |  57 +++++++++++++++++++
> >  hw/i386/pc.c                   |  31 ++++++-----
> >  hw/mem/Makefile.objs           |   2 +-
> >  hw/mem/memory-device.c         | 122 +++++++++++++++++++++++++----------------
> >  hw/mem/pc-dimm.c               |  53 ++++++++----------
> >  hw/mem/trace-events            |   4 +-
> >  hw/ppc/spapr.c                 |   5 +-
> >  include/hw/boards.h            |  17 ++++++
> >  include/hw/mem/memory-device.h |  17 ++++--
> >  include/hw/mem/pc-dimm.h       |   3 +-
> >  include/hw/resource-handler.h  |  46 ++++++++++++++++
> >  stubs/Makefile.objs            |   1 -
> >  stubs/qmp_memory_device.c      |  13 -----
> >  17 files changed, 364 insertions(+), 121 deletions(-)
> >  create mode 100644 hw/core/resource-handler.c
> >  create mode 100644 include/hw/resource-handler.h
> >  delete mode 100644 stubs/qmp_memory_device.c
> >   
> 
> If there are no further comments, I'll send a v2 by the end of this
> week. Thanks!
I couldn't convince myself that ResourceHandler is really necessary.
My main gripe with it, is that it imposes specific ordering wrt hotplug
handler that resources will be touched. Other issue is that it looks
a bit over-engineered with a lot of code fragmentation. Hence,

I'd suggest use simple hotplug handler chaining instead,
which should take care of wiring up virtio-mem/virtio-pmem,
keeping code compact at the same time.

Could you try something along these lines (I'll post a patch to
override default hotplug handler as reply here for you to pick up,
that should make following work):

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 100dfdc..c400c0c 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -393,12 +393,30 @@ static void s390_machine_reset(void)
     s390_ipl_prepare_cpu(ipl_cpu);
     s390_cpu_set_state(S390_CPU_STATE_OPERATING, ipl_cpu);
 }
+static void s390_machine_device_pre_plug(HotplugHandler *hotplug_dev,
+                                         DeviceState *dev, Error **errp)
+{
+    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_CCW)) {
+        /* do checks && set default values if it weren't set by user */
+        /* possibly pass to device's bus pre_plug handler if need */
+    }
+}
 
 static void s390_machine_device_plug(HotplugHandler *hotplug_dev,
                                      DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         s390_cpu_plug(hotplug_dev, dev, errp);
+    } if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_CCW)) {
+        HotplugHandler *hotplug_ctrl = dev->parent_bus->hotplug_handler;
+
+        /* do machine specific wiring, i.e.
+         * assign resources specified by user or by foo_pre_plug(),
+         * like map region into machine address space at specified address */
+        if (OK) {
+            /* pass control down to bus specific hotplug chain */
+            hotplug_handler_plug(hotplug_ctrl, dev, errp);
+        }
     }
 }
 
@@ -449,6 +467,8 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         return HOTPLUG_HANDLER(machine);
+    } (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM)) {
+        return HOTPLUG_HANDLER(machine);
     }
     return NULL;
 }

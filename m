Received: from eggs.gnu.org ([2001:4830:134:3::10]:36324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWOv-0006mj-Hk
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fEWOu-0005qW-G4
	for qemu-devel@nongnu.org; Fri, 04 May 2018 04:49:13 -0400
Date: Fri, 4 May 2018 10:49:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180504104907.2c0aebf4@redhat.com>
In-Reply-To: <20180503154936.18946-1-david@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
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
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu,  3 May 2018 17:49:28 +0200
David Hildenbrand <david@redhat.com> wrote:

> Hotplug handlers usually have the following tasks:
> 1. Allocate some resources for a new device
> 2. Make the new device visible for the guest
> 3. Notify the guest about the new device
> 
> Hotplug handlers have right now one limitation: They handle their own
> context and only care about resources they manage.
> 
> We can have devices that need certain other resources that are e.g.
> system resources managed by the machine. We need a clean way to assign
> these resources (without violating layers as brought up by Igor).
> 
> One example is virtio-mem/virtio-pmem. Both device types need to be
> assigned some region in guest physical address space. This device memory
> belongs to the machine and is managed by it. However, virito devices are
> hotplugged using the hotplug handler their proxy device implements. So we
> could trigger e.g. a PCI hotplug handler for virtio-pci or a CSS/CCW
> hotplug handler for virtio-ccw. But definetly not the machine.
> 
> So let's generalize the task of "assigning" resources and use it directly
> for memory devices. We now have a clean way to support any kind of memory
> device - independent of the underlying device type. Right now, only one
> resource handler per device can be supported (in addition to the existing
> hotplug handler).
So far I've just skimmed through series and still don't get clear
picture if new interface is really needed.
I'd like very much to see patches for how virtio-[p]mem in CCW and PCI
case would utilize this.


> You can find more details in patch nr 2.
> 
> This work is based on the already queued patch series
>     "[PATCH v4 00/11] pc-dimm: factor out MemoryDevice"
> 
> David Hildenbrand (8):
>   memory-device: always compile support for memory devices for SOFTMMU
>   qdev: introduce ResourceHandler as a first-stage hotplug handler
>   machine: provide default resource handler
>   memory-device: new functions to handle resource assignment
>   pc-dimm: implement new memory device functions
>   machine: introduce enforce_memory_device_align() and add it for pc
>   memory-device: factor out pre-assign into default resource handler
>   memory-device: factor out (un)assign into default resource handler
> 
>  hw/Makefile.objs               |   2 +-
>  hw/core/Makefile.objs          |   1 +
>  hw/core/machine.c              |  70 +++++++++++++++++++++++
>  hw/core/qdev.c                 |  41 +++++++++++++-
>  hw/core/resource-handler.c     |  57 +++++++++++++++++++
>  hw/i386/pc.c                   |  31 ++++++-----
>  hw/mem/Makefile.objs           |   2 +-
>  hw/mem/memory-device.c         | 122 +++++++++++++++++++++++++----------------
>  hw/mem/pc-dimm.c               |  53 ++++++++----------
>  hw/mem/trace-events            |   4 +-
>  hw/ppc/spapr.c                 |   5 +-
>  include/hw/boards.h            |  17 ++++++
>  include/hw/mem/memory-device.h |  17 ++++--
>  include/hw/mem/pc-dimm.h       |   3 +-
>  include/hw/resource-handler.h  |  46 ++++++++++++++++
>  stubs/Makefile.objs            |   1 -
>  stubs/qmp_memory_device.c      |  13 -----
>  17 files changed, 364 insertions(+), 121 deletions(-)
>  create mode 100644 hw/core/resource-handler.c
>  create mode 100644 include/hw/resource-handler.h
>  delete mode 100644 stubs/qmp_memory_device.c
> 

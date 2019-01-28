Received: from eggs.gnu.org ([209.51.188.92]:40958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1go7kR-0001L6-0c
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1go7kP-0000OS-G1
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:18:50 -0500
Date: Mon, 28 Jan 2019 15:18:33 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190128151833.15532428@redhat.com>
In-Reply-To: <20190123195527.29575-1-david@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFCv2 0/9] qdev: Hotplug handler chaining +
 virtio-pmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Wed, 23 Jan 2019 20:55:18 +0100
David Hildenbrand <david@redhat.com> wrote:

> This series implements supprt for hotplug handler chaining (proposed
> by Igor), something that is necessary to turn selected virtio devices into
> memory devices. Planned devices inlude virtio-mem and virtio-pmem. The
> current prototype of virtio-pmem is included.
> 
> The machine hotplug handler can intercept hotplug handler calls
> to properly prepare/teardown the memory device part of a device. Control
> is then passed on to the actual bus hotplug handler. So the default hotplug
> handler is effectively overwritten to make interception possible.
> 
> It is based on the following patches/series
> - [PATCH v1] pc: Use hotplug_handler_(plug|unplug|unplug_request)
> -- Queued by Paolo
> - [PATCH v3 0/2] s390x/pci: hotplug handler fixes and reworks
> 
> Patch 1-3 are the preparations for hotplug handler chaining.
we probably should merge this ones even without pmem patches.

> The remaining patches are a modified prototype of virtio-pmem.
I'm not sure yet that virtio-pmem should be merged.

Initial goal for fake pmem was to eliminate page-cache in guest
so that only host will have it and cached pages could be shared
between several guest.

However recently (if I read kernel driver thread right),
sharing is to be disabled due to security implication and then
only dropping page cache on one side is left, which could be done
using existing frontends/backends (disabling caching on host side).


> TODO:
> - More testing for patch #1 + eventually write some unplug tests
> - Pankaj has to fixup some things in "virtio-pmem: Prototype"
> -- See patch description for details
> 
> I modified Pankajs work to work with this series. virtio-pmem is included
> as it was requested during review of previous preparations to showcase a
> real user, so we can discuss if this is good enough for us or if we have
> to do further changes.
> 
> More details about virtio-pmem (including the Linux guest driver side)
> can be found at:
>     https://lkml.org/lkml/2018/7/13/102
>     https://lkml.org/lkml/2019/1/9/756
> 
> Example: defining a simple virtio-pmem device (on /dev/zero for simplicity):
> 
>     qemu-system-x86_64 \
>      -machine pc \
>      -monitor stdio \
>      -m 8G,maxmem=20G \
>      -object memory-backend-file,id=mem1,mem-path=/dev/zero,size=4G \
>      -device virtio-pmem-pci,id=vp1,memdev=mem1
> 
> QEMU 3.0.50 monitor - type 'help' for more information
> (qemu) info memory-devices
> Memory device [virtio-pmem]: "vp1"
>   memaddr: 0x240000000
>   size: 4294967296
>   memdev: /objects/mem1
> 
> (qemu) info memory_size_summary
> base memory: 8589934592
> plugged memory: 4294967296
> 
> RFC -> RFCv2
> - "virtio-pmem: Prototype"
> - Minor documentation/style changes
> - "virtio-pci: Proxy for virtio-pmem"
> -- Separate header file virtio-pmem-pci.h
> - "pc: Support for virtio-pmem-pci"
> -- Only handle virtio-pmem-pci specially
> 
> 
> David Hildenbrand (6):
>   qdev: Let the hotplug_handler_unplug() caller delete the device
>   qdev: Provide qdev_get_bus_hotplug_handler()
>   virtio-pci: Allow to specify additional interfaces for the base type
>   hmp: Handle virtio-pmem when printing memory device infos
>   numa: Handle virtio-pmem in NUMA stats
>   pc: Support for virtio-pmem-pci
> 
> Igor Mammedov (1):
>   qdev: Let machine hotplug handler to override bus hotplug handler
> 
> Pankaj Gupta (2):
>   virtio-pmem: Prototype
>   virtio-pci: Proxy for virtio-pmem
> 
>  default-configs/i386-softmmu.mak            |   1 +
>  hmp.c                                       |  27 +--
>  hw/acpi/cpu.c                               |   1 +
>  hw/acpi/memory_hotplug.c                    |   1 +
>  hw/acpi/pcihp.c                             |   3 +-
>  hw/core/qdev.c                              |  19 +-
>  hw/i386/pc.c                                |  75 +++++++-
>  hw/pci/pcie.c                               |   3 +-
>  hw/pci/shpc.c                               |   3 +-
>  hw/ppc/spapr.c                              |   4 +-
>  hw/ppc/spapr_pci.c                          |   3 +-
>  hw/s390x/css-bridge.c                       |   2 +-
>  hw/s390x/s390-pci-bus.c                     |  13 +-
>  hw/virtio/Makefile.objs                     |   3 +
>  hw/virtio/virtio-pci.c                      |   1 +
>  hw/virtio/virtio-pci.h                      |   1 +
>  hw/virtio/virtio-pmem-pci.c                 | 144 +++++++++++++++
>  hw/virtio/virtio-pmem-pci.h                 |  39 ++++
>  hw/virtio/virtio-pmem.c                     | 191 ++++++++++++++++++++
>  include/hw/qdev-core.h                      |  12 ++
>  include/hw/virtio/virtio-pmem.h             |  54 ++++++
>  include/standard-headers/linux/virtio_ids.h |   1 +
>  numa.c                                      |  24 +--
>  qapi/misc.json                              |  28 ++-
>  qdev-monitor.c                              |   9 +-
>  25 files changed, 612 insertions(+), 50 deletions(-)
>  create mode 100644 hw/virtio/virtio-pmem-pci.c
>  create mode 100644 hw/virtio/virtio-pmem-pci.h
>  create mode 100644 hw/virtio/virtio-pmem.c
>  create mode 100644 include/hw/virtio/virtio-pmem.h
> 

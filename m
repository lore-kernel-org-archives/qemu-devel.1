Received: from eggs.gnu.org ([2001:4830:134:3::10]:52929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fA75V-0001qA-8g
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 00:58:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1fA75R-0001RK-D4
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 00:58:56 -0400
Date: Sun, 22 Apr 2018 00:58:44 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <693523847.21650747.1524373124143.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180420123456.22196-1-david@redhat.com>
References: <20180420123456.22196-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] pc-dimm: factor out MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>


Hello,

This is good re-factoring and needed for 'virtio-pmem' as well to
reserve memory region in system address space.

I have tested this code with virtio-pmem and its working fine. Thank you
for the work.

I just have a small suggestion : when functions like(get_addr(), get_plugged_size etc) 
in the interface are not provided by derived class, Qemu crashes.

I think having a contract for must override functions with NULL check and error
at the calling sites would be better?

Thanks,
Pankaj  

> Right now we can only map PCDIMM/NVDIMM into guest address space. In the
> future, we might want to do the same for virtio devices - e.g.
> virtio-pmem or virtio-mem. Especially, they should be able to live side
> by side to each other.
> 
> E.g. the virto based memory devices regions will not be exposed via ACPI
> and friends. They will be detected just like other virtio devices and
> indicate the applicable memory region. This makes it possible to also use
> them on architectures without memory device detection support (e.g. s390x).
> 
> Let's factor out the memory device code into a MemoryDevice interface.
> 
> 
> v2 -> v3:
> - "pc-dimm: factor out MemoryDevice interface"
> --> Lookup both classes when comparing (David Gibson)
> 
> v1 -> v2:
> - Fix compile issues on ppc (still untested  )
> 
> 
> David Hildenbrand (3):
>   pc-dimm: factor out MemoryDevice interface
>   machine: make MemoryHotplugState accessible via the machine
>   pc-dimm: factor out address space logic into MemoryDevice code
> 
>  hw/i386/acpi-build.c                         |   3 +-
>  hw/i386/pc.c                                 |  24 ++-
>  hw/mem/Makefile.objs                         |   1 +
>  hw/mem/memory-device.c                       | 282 +++++++++++++++++++++++++
>  hw/mem/pc-dimm.c                             | 304
>  +++++++--------------------
>  hw/ppc/spapr.c                               |  24 ++-
>  hw/ppc/spapr_hcall.c                         |   1 +
>  include/hw/boards.h                          |  16 ++
>  include/hw/mem/memory-device.h               |  48 +++++
>  include/hw/mem/pc-dimm.h                     |  26 +--
>  numa.c                                       |   3 +-
>  qmp.c                                        |   4 +-
>  stubs/Makefile.objs                          |   2 +-
>  stubs/{qmp_pc_dimm.c => qmp_memory_device.c} |   4 +-
>  14 files changed, 465 insertions(+), 277 deletions(-)
>  create mode 100644 hw/mem/memory-device.c
>  create mode 100644 include/hw/mem/memory-device.h
>  rename stubs/{qmp_pc_dimm.c => qmp_memory_device.c} (61%)
> 
> --
> 2.14.3
> 
> 
> 

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpszX-0001EW-Sw
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpszS-0007cR-Uz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:20:55 -0400
Received: from ozlabs.ru ([107.173.13.209]:51528)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpszS-0007cA-Oj
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:20:50 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  7 Sep 2017 19:20:06 +1000
Message-Id: <20170907092010.3605-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 0/4] memory: Reduce memory use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=1481593

What happens ithere is that every virtio block device creates 2 address
spaces - for modern config space (called "virtio-pci-cfg-as") and
for busmaster (common pci thing, called after the device name,
in my case "virtio-blk-pci").

Each address_space_init() updates topology for every address space.
Every topology update (address_space_update_topology()) creates a new
dispatch tree - AddressSpaceDispatch with nodes (1KB) and
sections (48KB) and destroys the old one.

However the dispatch destructor is postponed via RCU which does not
get a chance to execute until the machine is initialized but before
we get there, memory is not returned to the pool, and this is a lot
of memory which grows n^2.

These patches are trying to address the memory use and boot time
issues but tbh only the first one provides visible outcome.

There are still things to polish and double check the use of RCU,
I'd like to get any feedback before proceeding - is this going
the right way or way too ugly?


This is based on sha1
1ab5eb4efb Peter Maydell "Update version for v2.10.0 release".

Please comment. Thanks.



Alexey Kardashevskiy (4):
  memory: Postpone flatview and dispatch tree building till all devices
    are added
  memory: Prepare for shared flat views
  memory: Share flat views and dispatch trees between address spaces
  memory: Add flat views to HMP "info mtree"

 include/exec/memory-internal.h |   6 +-
 include/exec/memory.h          |  93 +++++++++----
 exec.c                         | 242 +++++++++++++++++++--------------
 hw/alpha/typhoon.c             |   2 +-
 hw/dma/rc4030.c                |   4 +-
 hw/i386/amd_iommu.c            |   2 +-
 hw/i386/intel_iommu.c          |   9 +-
 hw/intc/openpic_kvm.c          |   2 +-
 hw/pci-host/apb.c              |   2 +-
 hw/pci/pci.c                   |   3 +-
 hw/ppc/spapr_iommu.c           |   4 +-
 hw/s390x/s390-pci-bus.c        |   2 +-
 hw/vfio/common.c               |   6 +-
 hw/virtio/vhost.c              |   6 +-
 memory.c                       | 299 +++++++++++++++++++++++++++--------------
 monitor.c                      |   3 +-
 vl.c                           |   4 +
 hmp-commands-info.hx           |   7 +-
 18 files changed, 448 insertions(+), 248 deletions(-)

-- 
2.11.0

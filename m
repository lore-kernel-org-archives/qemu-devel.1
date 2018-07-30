Received: from eggs.gnu.org ([2001:4830:134:3::10]:60575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkHN6-0001LE-Ct
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fkHN3-0006dw-8q
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:14:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fkHN2-0006dO-WD
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 19:14:33 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 30 Jul 2018 17:14:21 -0600
Message-ID: <153299246170.14411.6197545037372422542.stgit@gimli.home>
In-Reply-To: <153299204130.14411.11438396195753743913.stgit@gimli.home>
References: <153299204130.14411.11438396195753743913.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 3/4] vfio: Inhibit ballooning based on group
 attachment to a container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, peterx@redhat.com, cohuck@redhat.com, mst@redhat.com, david@redhat.com

We use a VFIOContainer to associate an AddressSpace to one or more
VFIOGroups.  The VFIOContainer represents the DMA context for that
AdressSpace for those VFIOGroups and is synchronized to changes in
that AddressSpace via a MemoryListener.  For IOMMU backed devices,
maintaining the DMA context for a VFIOGroup generally involves
pinning a host virtual address in order to create a stable host
physical address and then mapping a translation from the associated
guest physical address to that host physical address into the IOMMU.

While the above maintains the VFIOContainer synchronized to the QEMU
memory API of the VM, memory ballooning occurs outside of that API.
Inflating the memory balloon (ie. cooperatively capturing pages from
the guest for use by the host) simply uses MADV_DONTNEED to "zap"
pages from QEMU's host virtual address space.  The page pinning and
IOMMU mapping above remains in place, negating the host's ability to
reuse the page, but the host virtual to host physical mapping of the
page is invalidated outside of QEMU's memory API.

When the balloon is later deflated, attempting to cooperatively
return pages to the guest, the page is simply freed by the guest
balloon driver, allowing it to be used in the guest and incurring a
page fault when that occurs.  The page fault maps a new host physical
page backing the existing host virtual address, meanwhile the
VFIOContainer still maintains the translation to the original host
physical address.  At this point the guest vCPU and any assigned
devices will map different host physical addresses to the same guest
physical address.  Badness.

The IOMMU typically does not have page level granularity with which
it can track this mapping without also incurring inefficiencies in
using page size mappings throughout.  MMU notifiers in the host
kernel also provide indicators for invalidating the mapping on
balloon inflation, not for updating the mapping when the balloon is
deflated.  For these reasons we assume a default behavior that the
mapping of each VFIOGroup into the VFIOContainer is incompatible
with memory ballooning and increment the balloon inhibitor to match
the attached VFIOGroups.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fb396cf00ac4..4881b691a659 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -32,6 +32,7 @@
 #include "hw/hw.h"
 #include "qemu/error-report.h"
 #include "qemu/range.h"
+#include "sysemu/balloon.h"
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "qapi/error.h"
@@ -1049,6 +1050,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             group->container = container;
             QLIST_INSERT_HEAD(&container->group_list, group, container_next);
             vfio_kvm_device_add_group(group);
+            qemu_balloon_inhibit(true);
             return 0;
         }
     }
@@ -1198,6 +1200,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     }
 
     vfio_kvm_device_add_group(group);
+    qemu_balloon_inhibit(true);
 
     QLIST_INIT(&container->group_list);
     QLIST_INSERT_HEAD(&space->containers, container, next);
@@ -1222,6 +1225,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 listener_release_exit:
     QLIST_REMOVE(group, container_next);
     QLIST_REMOVE(container, next);
+    qemu_balloon_inhibit(false);
     vfio_kvm_device_del_group(group);
     vfio_listener_release(container);
 
@@ -1352,6 +1356,7 @@ void vfio_put_group(VFIOGroup *group)
         return;
     }
 
+    qemu_balloon_inhibit(false);
     vfio_kvm_device_del_group(group);
     vfio_disconnect_container(group);
     QLIST_REMOVE(group, next);

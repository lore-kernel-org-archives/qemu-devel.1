Received: from eggs.gnu.org ([2001:4830:134:3::10]:60117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fqiEu-0000qV-26
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fqiEt-0007lf-4P
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:08:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33516 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fqiEs-0007l7-V9
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:08:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A30AD4B765
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 17:08:42 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 17 Aug 2018 11:08:40 -0600
Message-ID: <153452572005.13804.10175795676768932286.stgit@gimli.home>
In-Reply-To: <153452552631.13804.12031418293966530953.stgit@gimli.home>
References: <153452552631.13804.12031418293966530953.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 3/4] vfio: Inhibit ballooning based on group
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

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/common.c |   30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index fb396cf00ac4..a3d758af8d8f 100644
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
@@ -1044,6 +1045,33 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     space = vfio_get_address_space(as);
 
+    /*
+     * VFIO is currently incompatible with memory ballooning insofar as the
+     * madvise to purge (zap) the page from QEMU's address space does not
+     * interact with the memory API and therefore leaves stale virtual to
+     * physical mappings in the IOMMU if the page was previously pinned.  We
+     * therefore add a balloon inhibit for each group added to a container,
+     * whether the container is used individually or shared.  This provides
+     * us with options to allow devices within a group to opt-in and allow
+     * ballooning, so long as it is done consistently for a group (for instance
+     * if the device is an mdev device where it is known that the host vendor
+     * driver will never pin pages outside of the working set of the guest
+     * driver, which would thus not be ballooning candidates).
+     *
+     * The first opportunity to induce pinning occurs here where we attempt to
+     * attach the group to existing containers within the AddressSpace.  If any
+     * pages are already zapped from the virtual address space, such as from a
+     * previous ballooning opt-in, new pinning will cause valid mappings to be
+     * re-established.  Likewise, when the overall MemoryListener for a new
+     * container is registered, a replay of mappings within the AddressSpace
+     * will occur, re-establishing any previously zapped pages as well.
+     *
+     * NB. Balloon inhibiting does not currently block operation of the
+     * balloon driver or revoke previously pinned pages, it only prevents
+     * calling madvise to modify the virtual mapping of ballooned pages.
+     */
+    qemu_balloon_inhibit(true);
+
     QLIST_FOREACH(container, &space->containers, next) {
         if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
             group->container = container;
@@ -1232,6 +1260,7 @@ close_fd_exit:
     close(fd);
 
 put_space_exit:
+    qemu_balloon_inhibit(false);
     vfio_put_address_space(space);
 
     return ret;
@@ -1352,6 +1381,7 @@ void vfio_put_group(VFIOGroup *group)
         return;
     }
 
+    qemu_balloon_inhibit(false);
     vfio_kvm_device_del_group(group);
     vfio_disconnect_container(group);
     QLIST_REMOVE(group, next);

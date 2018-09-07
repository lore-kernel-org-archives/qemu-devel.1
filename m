Received: from eggs.gnu.org ([2001:4830:134:3::10]:42154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fy6nQ-0004vq-Ca
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 22:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fy6nN-0000Vc-2P
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 22:46:56 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri,  7 Sep 2018 10:46:40 +0800
Message-Id: <20180907024640.15351-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3] intel_iommu: better handling of dmar state
 switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, QEMU Stable <qemu-stable@nongnu.org>

QEMU is not handling the global DMAR switch well, especially when from
"on" to "off".

Let's first take the example of system reset.

Assuming that a guest has IOMMU enabled.  When it reboots, we will drop
all the existing DMAR mappings to handle the system reset, however we'll
still keep the existing memory layouts which has the IOMMU memory region
enabled.  So after the reboot and before the kernel reloads again, there
will be no mapping at all for the host device.  That's problematic since
any software (for example, SeaBIOS) that runs earlier than the kernel
after the reboot will assume the IOMMU is disabled, so any DMA from the
software will fail.

For example, a guest that boots on an assigned NVMe device might fail to
find the boot device after a system reboot/reset and we'll be able to
observe SeaBIOS errors if we capture the debugging log:

  WARNING - Timeout at nvme_wait:144!

Meanwhile, we should see DMAR errors on the host of that NVMe device.
It's the DMA fault that caused a NVMe driver timeout.

The correct fix should be that we do proper switching of device DMA
address spaces when system resets, which will setup correct memory
regions and notify the backend of the devices.  This might not affect
much on non-assigned devices since QEMU VT-d emulation will assume a
default passthrough mapping if DMAR is not enabled in the GCMD
register (please refer to vtd_iommu_translate).  However that's required
for an assigned devices, since that'll rebuild the correct GPA to HPA
mapping that is needed for any DMA operation during guest bootstrap.

Besides the system reset, we have some other places that might change
the global DMAR status and we'd better do the same thing there.  For
example, when we change the state of GCMD register, or the DMAR root
pointer.  Do the same refresh for all these places.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1625173
CC: QEMU Stable <qemu-stable@nongnu.org>
Reported-by: Cong Li <coli@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
--
v2:
- do the same for GCMD write, or root pointer update [Alex]
- test is carried out by me this time, by observing the
  vtd_switch_address_space tracepoint after system reboot
v3:
- rewrite commit message as suggested by Alex
---
 hw/i386/intel_iommu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 3dfada19a6..59dc155911 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -37,6 +37,8 @@
 #include "kvm_i386.h"
 #include "trace.h"
 
+static void vtd_address_space_refresh_all(IntelIOMMUState *s);
+
 static void vtd_define_quad(IntelIOMMUState *s, hwaddr addr, uint64_t val,
                             uint64_t wmask, uint64_t w1cmask)
 {
@@ -1428,7 +1430,7 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
         vtd_reset_context_cache_locked(s);
     }
     vtd_iommu_unlock(s);
-    vtd_switch_address_space_all(s);
+    vtd_address_space_refresh_all(s);
     /*
      * From VT-d spec 6.5.2.1, a global context entry invalidation
      * should be followed by a IOTLB global invalidation, so we should
@@ -1719,6 +1721,7 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
     vtd_root_table_setup(s);
     /* Ok - report back to driver */
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
+    vtd_address_space_refresh_all(s);
 }
 
 /* Set Interrupt Remap Table Pointer */
@@ -1751,7 +1754,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
     }
 
-    vtd_switch_address_space_all(s);
+    vtd_address_space_refresh_all(s);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -3051,6 +3054,12 @@ static void vtd_address_space_unmap_all(IntelIOMMUState *s)
     }
 }
 
+static void vtd_address_space_refresh_all(IntelIOMMUState *s)
+{
+    vtd_address_space_unmap_all(s);
+    vtd_switch_address_space_all(s);
+}
+
 static int vtd_replay_hook(IOMMUTLBEntry *entry, void *private)
 {
     memory_region_notify_one((IOMMUNotifier *)private, entry);
@@ -3226,11 +3235,7 @@ static void vtd_reset(DeviceState *dev)
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
 
     vtd_init(s);
-
-    /*
-     * When device reset, throw away all mappings and external caches
-     */
-    vtd_address_space_unmap_all(s);
+    vtd_address_space_refresh_all(s);
 }
 
 static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
-- 
2.17.1

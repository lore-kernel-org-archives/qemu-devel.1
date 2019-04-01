Received: from eggs.gnu.org ([209.51.188.92]:41240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44w-0001iC-SX
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44v-0003fL-Az
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51492)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44u-0003Yn-Sv
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:49 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L29ip118993
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:37 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rkqt6064s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:36 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:36 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:29 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-56-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 55/97] intel_iommu: better handling of dmar
 state switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

From: Peter Xu <peterx@redhat.com>

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
pointer.  Do the same refresh for all these places.  For these two
places we'll also need to explicitly invalidate the context entry cache
and iotlb cache.

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
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 2cc9ddccebcaa48b3debfc279a83761fcbb7616c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/i386/intel_iommu.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f66e93ed2c..4dfa9d5e2b 100644
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
@@ -1426,7 +1428,7 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
         vtd_reset_context_cache_locked(s);
     }
     vtd_iommu_unlock(s);
-    vtd_switch_address_space_all(s);
+    vtd_address_space_refresh_all(s);
     /*
      * From VT-d spec 6.5.2.1, a global context entry invalidation
      * should be followed by a IOTLB global invalidation, so we should
@@ -1711,6 +1713,8 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
     vtd_root_table_setup(s);
     /* Ok - report back to driver */
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
+    vtd_reset_caches(s);
+    vtd_address_space_refresh_all(s);
 }
 
 /* Set Interrupt Remap Table Pointer */
@@ -1743,7 +1747,8 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
         vtd_set_clear_mask_long(s, DMAR_GSTS_REG, VTD_GSTS_TES, 0);
     }
 
-    vtd_switch_address_space_all(s);
+    vtd_reset_caches(s);
+    vtd_address_space_refresh_all(s);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -3022,6 +3027,12 @@ static void vtd_address_space_unmap_all(IntelIOMMUState *s)
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
@@ -3194,11 +3205,7 @@ static void vtd_reset(DeviceState *dev)
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

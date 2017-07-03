Received: from eggs.gnu.org ([2001:4830:134:3::10]:47136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7I3-0008Mw-Fu
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7I2-0003Pc-Ci
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS7I2-0003O8-3o
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:46 -0400
Date: Mon, 3 Jul 2017 22:45:41 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-17-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 16/21] intel_iommu: fix migration breakage on mr
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Peter Xu <peterx@redhat.com>

Migration is broken after the vfio integration work:

qemu-kvm: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
qemu-kvm: Failed to load ich9_ahci:ahci
qemu-kvm: error while loading state for instance 0x0 of device '0000:00:1f.2/ich9_ahci'
qemu-kvm: load of migration failed: Operation not permitted

The problem is that vfio work introduced dynamic memory region
switching (actually it is also used for future PT mode), and this memory
region layout is not properly delivered to destination when migration
happens. Solution is to rebuild the layout in post_load.

Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1459906
Fixes: 558e0024 ("intel_iommu: allow dynamic switch of IOMMU region")
Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2ddf3bd..88dc042 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2337,11 +2337,26 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
     }
 }
 
+static int vtd_post_load(void *opaque, int version_id)
+{
+    IntelIOMMUState *iommu = opaque;
+
+    /*
+     * Memory regions are dynamically turned on/off depending on
+     * context entry configurations from the guest. After migration,
+     * we need to make sure the memory regions are still correct.
+     */
+    vtd_switch_address_space_all(iommu);
+
+    return 0;
+}
+
 static const VMStateDescription vtd_vmstate = {
     .name = "iommu-intel",
     .version_id = 1,
     .minimum_version_id = 1,
     .priority = MIG_PRI_IOMMU,
+    .post_load = vtd_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(root, IntelIOMMUState),
         VMSTATE_UINT64(intr_root, IntelIOMMUState),
-- 
MST

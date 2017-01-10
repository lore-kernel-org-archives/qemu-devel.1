Received: from eggs.gnu.org ([2001:4830:134:3::10]:33248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9b-00074M-3q
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9a-0005L8-5W
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:27 -0500
Received: from mail.kernel.org ([198.145.29.136]:47500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=AJsY=YY=redhat.com=mst@kernel.org>)
	id 1cQp9Z-0005Kx-VU
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 00:39:26 -0500
Date: Tue, 10 Jan 2017 07:39:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1484026704-28027-3-git-send-email-mst@redhat.com>
References: <1484026704-28027-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484026704-28027-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 02/41] intel_iommu: allow migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

From: Peter Xu <peterx@redhat.com>

IOMMU needs to be migrated before all the PCI devices (in case there are
devices that will request for address translation). So marking it with a
priority higher than the default (which PCI devices and other belong).
Migration framework handled the rest.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/migration/vmstate.h |  1 +
 hw/i386/intel_iommu.c       | 22 +++++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1a22887..2125829 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -188,6 +188,7 @@ enum VMStateFlags {
 
 typedef enum {
     MIG_PRI_DEFAULT = 0,
+    MIG_PRI_IOMMU,              /* Must happen before PCI devices */
     MIG_PRI_MAX,
 } MigrationPriority;
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5f3e351..119217b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1996,7 +1996,27 @@ static void vtd_iommu_notify_flag_changed(MemoryRegion *iommu,
 
 static const VMStateDescription vtd_vmstate = {
     .name = "iommu-intel",
-    .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .priority = MIG_PRI_IOMMU,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(root, IntelIOMMUState),
+        VMSTATE_UINT64(intr_root, IntelIOMMUState),
+        VMSTATE_UINT64(iq, IntelIOMMUState),
+        VMSTATE_UINT32(intr_size, IntelIOMMUState),
+        VMSTATE_UINT16(iq_head, IntelIOMMUState),
+        VMSTATE_UINT16(iq_tail, IntelIOMMUState),
+        VMSTATE_UINT16(iq_size, IntelIOMMUState),
+        VMSTATE_UINT16(next_frcd_reg, IntelIOMMUState),
+        VMSTATE_UINT8_ARRAY(csr, IntelIOMMUState, DMAR_REG_SIZE),
+        VMSTATE_UINT8(iq_last_desc_type, IntelIOMMUState),
+        VMSTATE_BOOL(root_extended, IntelIOMMUState),
+        VMSTATE_BOOL(dmar_enabled, IntelIOMMUState),
+        VMSTATE_BOOL(qi_enabled, IntelIOMMUState),
+        VMSTATE_BOOL(intr_enabled, IntelIOMMUState),
+        VMSTATE_BOOL(intr_eime, IntelIOMMUState),
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 static const MemoryRegionOps vtd_mem_ops = {
-- 
MST

Received: from eggs.gnu.org ([2001:4830:134:3::10]:33431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dhrp6-0005FC-Ut
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1dhrp3-0008Kf-SY
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:29:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:6079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1dhrp3-0008Jv-Jn
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 02:28:57 -0400
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Tue, 15 Aug 2017 20:22:13 -0400
Message-Id: <1502842933-8323-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [PATCH] x86: Skip check apic_id_limit for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

Xen vIOMMU device model will be in Xen hypervisor. Skip vIOMMU
check for Xen here when vcpu number is more than 255.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5943539..fc17885 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1260,7 +1260,7 @@ void pc_machine_done(Notifier *notifier, void *data)
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
 
-    if (pcms->apic_id_limit > 255) {
+    if (pcms->apic_id_limit > 255 && !xen_enabled()) {
         IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
 
         if (!iommu || !iommu->x86_iommu.intr_supported ||
-- 
1.8.3.1

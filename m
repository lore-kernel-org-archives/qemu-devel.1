Received: from eggs.gnu.org ([2001:4830:134:3::10]:45006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7iok-00065v-OA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7ioe-0001md-O7
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7ioe-0001lZ-IL
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:07:24 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 26 Oct 2017 16:04:04 +0200
Message-Id: <20171026140404.21948-40-ehabkost@redhat.com>
In-Reply-To: <20171026140404.21948-1-ehabkost@redhat.com>
References: <20171026140404.21948-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 39/39] x86: Skip check apic_id_limit for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Lan Tianyu <tianyu.lan@intel.com>

From: Lan Tianyu <tianyu.lan@intel.com>

Xen vIOMMU device model will be in Xen hypervisor. Skip vIOMMU
check for Xen here when vcpu number is more than 255.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
Message-Id: <1502842933-8323-1-git-send-email-tianyu.lan@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/pc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 8e307f7aff..e11a65b545 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1228,7 +1228,7 @@ void pc_machine_done(Notifier *notifier, void *data)
         fw_cfg_modify_i16(pcms->fw_cfg, FW_CFG_NB_CPUS, pcms->boot_cpus);
     }
 
-    if (pcms->apic_id_limit > 255) {
+    if (pcms->apic_id_limit > 255 && !xen_enabled()) {
         IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
 
         if (!iommu || !iommu->x86_iommu.intr_supported ||
-- 
2.13.6

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dtxBi-0004fH-06
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mgamal@redhat.com>) id 1dtxBh-0005AU-18
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:38:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mgamal@redhat.com>) id 1dtxBg-0005AA-Rk
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:38:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 827B680464
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 14:38:15 +0000 (UTC)
From: Mohammed Gamal <mgamal@redhat.com>
Date: Mon, 18 Sep 2017 16:37:49 +0200
Message-Id: <1505745470-12208-3-git-send-email-mgamal@redhat.com>
In-Reply-To: <1505745470-12208-1-git-send-email-mgamal@redhat.com>
References: <1505745470-12208-1-git-send-email-mgamal@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/3] intel_iommu,
 amd_iommu: Remove redundant object_dynamic_cast calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com, thuth@redhat.com, peterx@redhat.com, pbonzini@redhat.com, Mohammed Gamal <mgamal@redhat.com>

Now that the calling x86_iommu_realize() calls object_dynamic_cast(),
doing the cast in amdvi_realize() and vtd_realize() is not needed.

Use PC_MACHINE macro directly.

Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
---
 hw/i386/amd_iommu.c   | 3 +--
 hw/i386/intel_iommu.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 839f01f..f2e1868 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1141,8 +1141,7 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
-    PCMachineState *pcms =
-        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
+    PCMachineState *pcms = PC_MACHINE(ms);
     PCIBus *bus = pcms->bus;
 
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index aa01812..0138b3b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3027,8 +3027,7 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 static void vtd_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-    PCMachineState *pcms =
-        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
+    PCMachineState *pcms = PC_MACHINE(ms);
     PCIBus *bus = pcms->bus;
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
-- 
1.8.3.1

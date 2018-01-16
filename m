Received: from eggs.gnu.org ([2001:4830:134:3::10]:48453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAd-0000Pz-PU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebJAa-00054O-O4
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebJAa-00053v-Es
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 23:48:20 -0500
Date: Tue, 16 Jan 2018 06:48:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516077852-7974-26-git-send-email-mst@redhat.com>
References: <1516077852-7974-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516077852-7974-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 25/33] x86_iommu: Move machine check to
 x86_iommu_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mohammed Gamal <mgamal@redhat.com>, Peter Xu <peterx@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>

From: Mohammed Gamal <mgamal@redhat.com>

Instead of having the same error checks in vtd_realize()
and amdvi_realize(), move that over to the generic
x86_iommu_realize().

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/amd_iommu.c   | 13 ++-----------
 hw/i386/intel_iommu.c | 13 ++-----------
 hw/i386/x86-iommu.c   | 13 +++++++++++++
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index eeaf0e0..63d46ff 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1144,18 +1144,9 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
-    PCMachineState *pcms =
-        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
-    PCIBus *bus;
-
-    if (!pcms) {
-        error_setg(err, "Machine-type '%s' not supported by amd-iommu",
-                   mc->name);
-        return;
-    }
+    PCMachineState *pcms = PC_MACHINE(ms);
+    PCIBus *bus = pcms->bus;
 
-    bus = pcms->bus;
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4e8642e..2e841cd 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3052,20 +3052,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 static void vtd_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-    MachineClass *mc = MACHINE_GET_CLASS(ms);
-    PCMachineState *pcms =
-        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
-    PCIBus *bus;
+    PCMachineState *pcms = PC_MACHINE(ms);
+    PCIBus *bus = pcms->bus;
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
 
-    if (!pcms) {
-        error_setg(errp, "Machine-type '%s' not supported by intel-iommu",
-                   mc->name);
-        return;
-    }
-
-    bus = pcms->bus;
     x86_iommu->type = TYPE_INTEL;
 
     if (!vtd_decide_config(s, errp)) {
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 293caf8..51de519 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -21,6 +21,8 @@
 #include "hw/sysbus.h"
 #include "hw/boards.h"
 #include "hw/i386/x86-iommu.h"
+#include "hw/i386/pc.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 
@@ -80,7 +82,18 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
     X86IOMMUClass *x86_class = X86_IOMMU_GET_CLASS(dev);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    PCMachineState *pcms =
+        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
     QLIST_INIT(&x86_iommu->iec_notifiers);
+
+    if (!pcms) {
+        error_setg(errp, "Machine-type '%s' not supported by IOMMU",
+                   mc->name);
+        return;
+    }
+
     if (x86_class->realize) {
         x86_class->realize(dev, errp);
     }
-- 
MST

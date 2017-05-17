Received: from eggs.gnu.org ([2001:4830:134:3::10]:48251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6l8-0000y6-A9
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dB6l5-0005QD-LV
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dB6l5-0005Pp-CW
	for qemu-devel@nongnu.org; Wed, 17 May 2017 17:45:27 -0400
Date: Thu, 18 May 2017 00:45:23 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1495057396-13387-8-git-send-email-mst@redhat.com>
References: <1495057396-13387-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495057396-13387-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 07/13] iommu: Don't crash if machine is not
 PC_MACHINE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

From: Eduardo Habkost <ehabkost@redhat.com>

Currently it's possible to crash QEMU using "-device *-iommu" and
"-machine none":

  $ qemu-system-x86_64 -machine none -device amd-iommu
  qemu/hw/i386/amd_iommu.c:1140:amdvi_realize: Object 0x55627dafbc90 is not an instance of type generic-pc-machine
  Aborted (core dumped)
  $ qemu-system-x86_64 -machine none -device intel-iommu
  qemu/hw/i386/intel_iommu.c:2972:vtd_realize: Object 0x56292ec0bc90 is not an instance of type generic-pc-machine
  Aborted (core dumped)

Fix amd-iommu and intel-iommu to ensure the current machine is really a
TYPE_PC_MACHINE instance at their realize methods.

Resulting error messages:

  $ qemu-system-x86_64 -machine none -device amd-iommu
  qemu-system-x86_64: -device amd-iommu: Machine-type 'none' not supported by amd-iommu
  $ qemu-system-x86_64 -machine none -device intel-iommu
  qemu-system-x86_64: -device intel-iommu: Machine-type 'none' not supported by intel-iommu

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c   | 15 ++++++++++++++-
 hw/i386/intel_iommu.c | 14 ++++++++++++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f86a40a..516ebae 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -21,6 +21,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/i386/amd_iommu.h"
+#include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 
@@ -1137,7 +1138,19 @@ static void amdvi_realize(DeviceState *dev, Error **err)
     int ret = 0;
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
-    PCIBus *bus = PC_MACHINE(qdev_get_machine())->bus;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    PCMachineState *pcms =
+        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
+    PCIBus *bus;
+
+    if (!pcms) {
+        error_setg(err, "Machine-type '%s' not supported by amd-iommu",
+                   mc->name);
+        return;
+    }
+
+    bus = pcms->bus;
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 02f047c..a12b176 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2969,11 +2969,21 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
 
 static void vtd_realize(DeviceState *dev, Error **errp)
 {
-    PCMachineState *pcms = PC_MACHINE(qdev_get_machine());
-    PCIBus *bus = pcms->bus;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    PCMachineState *pcms =
+        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
+    PCIBus *bus;
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
 
+    if (!pcms) {
+        error_setg(errp, "Machine-type '%s' not supported by intel-iommu",
+                   mc->name);
+        return;
+    }
+
+    bus = pcms->bus;
     VTD_DPRINTF(GENERAL, "");
     x86_iommu->type = TYPE_INTEL;
 
-- 
MST

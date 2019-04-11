Received: from eggs.gnu.org ([209.51.188.92]:37710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hETyG-0001oj-RP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hETyF-0005U6-Ut
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:18:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:47561)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hETyF-0005T4-Ki
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:18:03 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Thu, 11 Apr 2019 15:17:39 +0800
Message-Id: <20190411071739.22889-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] hw/i386/pc: check apci hotplug capability
 before nvdimm's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

pc_memory_pre_plug() is called during hotplug for both pc-dimm and
nvdimm. This is more proper to check apci hotplug capability before
check nvdimm specific capability.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 hw/i386/pc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f2c15bf1f2..d48b6f9582 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2091,17 +2091,17 @@ static void pc_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         return;
     }
 
-    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
-        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
-        return;
-    }
-
     hotplug_handler_pre_plug(pcms->acpi_dev, dev, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
 
+    if (is_nvdimm && !ms->nvdimms_state->is_enabled) {
+        error_setg(errp, "nvdimm is not enabled: missing 'nvdimm' in '-M'");
+        return;
+    }
+
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev),
                      pcmc->enforce_aligned_dimm ? NULL : &legacy_align, errp);
 }
-- 
2.19.1

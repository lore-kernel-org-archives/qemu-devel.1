Received: from eggs.gnu.org ([2001:4830:134:3::10]:39263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7j-0001Sq-AM
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7i-00073T-Gb
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctr7i-000731-8n
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:30 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 31 Mar 2017 15:36:32 +0800
Message-Id: <1490945793-21276-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1490945793-21276-1-git-send-email-peterx@redhat.com>
References: <1490945793-21276-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 4/5] q35: init vIOMMU during machine
 init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, "\\  Michael S . Tsirkin \\ " <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

Now x86 vIOMMUs are init along with all the rest of "-devices". That may
not be sufficient since some devices' realization will depend on the
vIOMMU object. Let's move the vIOMMU init back to machine init, so
that'll be far earlier than all the rest of devices.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/pci-host/q35.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 344f77b..c5becea 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -28,6 +28,8 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "qemu/option.h"
+#include "qemu/config-file.h"
 #include "hw/hw.h"
 #include "hw/pci-host/q35.h"
 #include "qapi/error.h"
@@ -460,6 +462,26 @@ static void mch_reset(DeviceState *qdev)
     mch_update(mch);
 }
 
+static int x86_iommu_detecter(void *opaque, QemuOpts *opts, Error **errp)
+{
+    const char *driver = qemu_opt_get(opts, "driver");
+
+    if (!driver) {
+        /*
+         * We don't need to set any error here. It'll be invoked later
+         * when init all the devices. Here we can just concentrate on
+         * the IOMMU device.
+         */
+        return -1;
+    }
+
+    if (!strcmp(driver, "intel-iommu") || !strcmp(driver, "amd-iommu")) {
+        return 0;
+    }
+
+    return -1;
+}
+
 static void mch_realize(PCIDevice *d, Error **errp)
 {
     int i;
@@ -518,6 +540,29 @@ static void mch_realize(PCIDevice *d, Error **errp)
                  mch->pci_address_space, &mch->pam_regions[i+1],
                  PAM_EXPAN_BASE + i * PAM_EXPAN_SIZE, PAM_EXPAN_SIZE);
     }
+
+    /*
+     * Initialize vIOMMUs during machine init. Now we have vIOMMUs
+     * configured with "-device", let's try to pick them out in the
+     * device list, and init them before the rest of the devices (some
+     * device will depend on the vIOMMU during its realization).
+     *
+     * TODO: support multiple vIOMMUs. This loop prepares for that.
+     */
+    while (1) {
+        QemuOpts *iommu_opts;
+
+        iommu_opts = qemu_opts_extract(qemu_find_opts("device"),
+                                       x86_iommu_detecter, NULL, errp);
+        if (!iommu_opts) {
+            break;
+        }
+
+        /* Found one IOMMU device, init it */
+        if (device_init_func(NULL, iommu_opts, errp)) {
+            return;
+        }
+    }
 }
 
 uint64_t mch_mcfg_base(void)
-- 
2.7.4

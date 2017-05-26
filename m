Received: from eggs.gnu.org ([2001:4830:134:3::10]:54854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEEAQ-0000Tx-IQ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEEAL-00034o-VT
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:16:30 -0400
Received: from [59.151.112.132] (port=42984 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEEAL-00034H-Jx
	for qemu-devel@nongnu.org; Fri, 26 May 2017 08:16:25 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Fri, 26 May 2017 20:15:16 +0800
Message-ID: <20170526121516.6607-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] pci-bridge/i82801b11: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel@redhat.com, mst@redhat.com, armbru@redhat.com

The pci-birdge device i82801b11 still implements the old
PCIDeviceClass .init() through i82801b11_bridge_init()
instead of the new .realize(). All devices need to be
converted to .realize(). So convert it and rename it to
i82801b11_bridge_realize().

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/pci-bridge/i82801b11.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 2404e7e..dca3162 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -44,6 +44,7 @@
 #include "qemu/osdep.h"
 #include "hw/pci/pci.h"
 #include "hw/i386/ich9.h"
+#include "qapi/error.h"
 
 
 /*****************************************************************************/
@@ -58,7 +59,7 @@ typedef struct I82801b11Bridge {
     /*< public >*/
 } I82801b11Bridge;
 
-static int i82801b11_bridge_initfn(PCIDevice *d)
+static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
 {
     int rc;
 
@@ -70,12 +71,10 @@ static int i82801b11_bridge_initfn(PCIDevice *d)
         goto err_bridge;
     }
     pci_config_set_prog_interface(d->config, PCI_CLASS_BRIDGE_PCI_INF_SUB);
-    return 0;
+    return;
 
 err_bridge:
     pci_bridge_exitfn(d);
-
-    return rc;
 }
 
 static const VMStateDescription i82801b11_bridge_dev_vmstate = {
@@ -95,7 +94,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
     k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82801BA_11;
     k->revision = ICH9_D2P_A2_REVISION;
-    k->init = i82801b11_bridge_initfn;
+    k->realize = i82801b11_bridge_realize;
     k->config_write = pci_bridge_write_config;
     dc->vmsd = &i82801b11_bridge_dev_vmstate;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
-- 
2.9.3

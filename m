Received: from eggs.gnu.org ([2001:4830:134:3::10]:60594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQl-0007x3-4Y
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gJjQk-0003Fj-5U
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gJjQj-0003F9-Qx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:16:54 -0500
Date: Mon, 5 Nov 2018 13:16:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181105181353.39804-23-mst@redhat.com>
References: <20181105181353.39804-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105181353.39804-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 22/33] hw/pci-host/x86: extract
 get_pci_hole64_start_value() helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Laszlo Ersek <lersek@redhat.com>

Expose the calculated "hole64 start" GPAs as plain uint64_t values,
extracting the internals of the current property getters.

This patch doesn't change behavior.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-host/piix.c | 15 +++++++++++----
 hw/pci-host/q35.c  | 15 +++++++++++----
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 47293a3915..ce271da9b0 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -249,9 +249,7 @@ static void i440fx_pcihost_get_pci_hole_end(Object *obj, Visitor *v,
  * the 64bit PCI hole will start after "over 4G RAM" and the
  * reserved space for memory hotplug if any.
  */
-static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
-                                                const char *name,
-                                                void *opaque, Error **errp)
+static uint64_t i440fx_pcihost_get_pci_hole64_start_value(Object *obj)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
@@ -263,7 +261,16 @@ static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
     if (!value && s->pci_hole64_fix) {
         value = pc_pci_hole64_start();
     }
-    visit_type_uint64(v, name, &value, errp);
+    return value;
+}
+
+static void i440fx_pcihost_get_pci_hole64_start(Object *obj, Visitor *v,
+                                                const char *name,
+                                                void *opaque, Error **errp)
+{
+    uint64_t hole64_start = i440fx_pcihost_get_pci_hole64_start_value(obj);
+
+    visit_type_uint64(v, name, &hole64_start, errp);
 }
 
 /*
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 966a7cf92d..ceb00f7706 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -113,9 +113,7 @@ static void q35_host_get_pci_hole_end(Object *obj, Visitor *v,
  * the 64bit PCI hole will start after "over 4G RAM" and the
  * reserved space for memory hotplug if any.
  */
-static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
-                                          const char *name, void *opaque,
-                                          Error **errp)
+static uint64_t q35_host_get_pci_hole64_start_value(Object *obj)
 {
     PCIHostState *h = PCI_HOST_BRIDGE(obj);
     Q35PCIHost *s = Q35_HOST_DEVICE(obj);
@@ -127,7 +125,16 @@ static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
     if (!value && s->pci_hole64_fix) {
         value = pc_pci_hole64_start();
     }
-    visit_type_uint64(v, name, &value, errp);
+    return value;
+}
+
+static void q35_host_get_pci_hole64_start(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    uint64_t hole64_start = q35_host_get_pci_hole64_start_value(obj);
+
+    visit_type_uint64(v, name, &hole64_start, errp);
 }
 
 /*
-- 
MST

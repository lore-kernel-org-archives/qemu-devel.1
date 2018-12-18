Received: from eggs.gnu.org ([2001:4830:134:3::10]:50996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pM-0005AY-0u
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZ6pI-00077N-AH
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:17:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZ6pH-0006vY-So
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:17:48 -0500
Date: Mon, 17 Dec 2018 23:17:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181218041625.24969-13-mst@redhat.com>
References: <20181218041625.24969-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218041625.24969-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/31] qapi: Define PCIe link speed and width
 properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>, Eric Blake <eblake@redhat.com>, Geoffrey McRae <geoff@hostfission.com>, Markus Armbruster <armbru@redhat.com>

From: Alex Williamson <alex.williamson@redhat.com>

Create properties to be able to define speeds and widths for PCIe
links.  The only tricky bit here is that our get and set callbacks
translate from the fixed QAPI automagic enums to those we define
in PCI code to represent the actual register segment value.

Cc: Eric Blake <eblake@redhat.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/common.json             |  42 +++++++++
 include/hw/qdev-properties.h |   8 ++
 hw/core/qdev-properties.c    | 176 +++++++++++++++++++++++++++++++++++
 3 files changed, 226 insertions(+)

diff --git a/qapi/common.json b/qapi/common.json
index 021174f04e..99d313ef3b 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -127,6 +127,48 @@
 { 'enum': 'OffAutoPCIBAR',
   'data': [ 'off', 'auto', 'bar0', 'bar1', 'bar2', 'bar3', 'bar4', 'bar5' ] }
 
+##
+# @PCIELinkSpeed:
+#
+# An enumeration of PCIe link speeds in units of GT/s
+#
+# @2_5: 2.5GT/s
+#
+# @5: 5.0GT/s
+#
+# @8: 8.0GT/s
+#
+# @16: 16.0GT/s
+#
+# Since: 4.0
+##
+{ 'enum': 'PCIELinkSpeed',
+  'data': [ '2_5', '5', '8', '16' ] }
+
+##
+# @PCIELinkWidth:
+#
+# An enumeration of PCIe link width
+#
+# @1: x1
+#
+# @2: x2
+#
+# @4: x4
+#
+# @8: x8
+#
+# @12: x12
+#
+# @16: x16
+#
+# @32: x32
+#
+# Since: 4.0
+##
+{ 'enum': 'PCIELinkWidth',
+  'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
+
 ##
 # @SysEmuTarget:
 #
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 3ab9cd2eb6..b6758c852e 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -36,6 +36,8 @@ extern const PropertyInfo qdev_prop_uuid;
 extern const PropertyInfo qdev_prop_arraylen;
 extern const PropertyInfo qdev_prop_link;
 extern const PropertyInfo qdev_prop_off_auto_pcibar;
+extern const PropertyInfo qdev_prop_pcie_link_speed;
+extern const PropertyInfo qdev_prop_pcie_link_width;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
         .name      = (_name),                                    \
@@ -217,6 +219,12 @@ extern const PropertyInfo qdev_prop_off_auto_pcibar;
 #define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
                         OffAutoPCIBAR)
+#define DEFINE_PROP_PCIE_LINK_SPEED(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_speed, \
+                        PCIExpLinkSpeed)
+#define DEFINE_PROP_PCIE_LINK_WIDTH(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_pcie_link_width, \
+                        PCIExpLinkWidth)
 
 #define DEFINE_PROP_UUID(_name, _state, _field) {                  \
         .name      = (_name),                                      \
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index bd84c4ea4c..943dc2654b 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1297,3 +1297,179 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
     .set = set_enum,
     .set_default_value = set_default_value_enum,
 };
+
+/* --- PCIELinkSpeed 2_5/5/8/16 -- */
+
+static void get_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
+    int speed;
+
+    switch (*p) {
+    case QEMU_PCI_EXP_LNK_2_5GT:
+        speed = PCIE_LINK_SPEED_2_5;
+        break;
+    case QEMU_PCI_EXP_LNK_5GT:
+        speed = PCIE_LINK_SPEED_5;
+        break;
+    case QEMU_PCI_EXP_LNK_8GT:
+        speed = PCIE_LINK_SPEED_8;
+        break;
+    case QEMU_PCI_EXP_LNK_16GT:
+        speed = PCIE_LINK_SPEED_16;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+
+    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
+    int speed;
+    Error *local_err = NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_enum(v, prop->name, &speed, prop->info->enum_table, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    switch (speed) {
+    case PCIE_LINK_SPEED_2_5:
+        *p = QEMU_PCI_EXP_LNK_2_5GT;
+        break;
+    case PCIE_LINK_SPEED_5:
+        *p = QEMU_PCI_EXP_LNK_5GT;
+        break;
+    case PCIE_LINK_SPEED_8:
+        *p = QEMU_PCI_EXP_LNK_8GT;
+        break;
+    case PCIE_LINK_SPEED_16:
+        *p = QEMU_PCI_EXP_LNK_16GT;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+}
+
+const PropertyInfo qdev_prop_pcie_link_speed = {
+    .name = "PCIELinkSpeed",
+    .description = "2_5/5/8/16",
+    .enum_table = &PCIELinkSpeed_lookup,
+    .get = get_prop_pcielinkspeed,
+    .set = set_prop_pcielinkspeed,
+    .set_default_value = set_default_value_enum,
+};
+
+/* --- PCIELinkWidth 1/2/4/8/12/16/32 -- */
+
+static void get_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
+    int width;
+
+    switch (*p) {
+    case QEMU_PCI_EXP_LNK_X1:
+        width = PCIE_LINK_WIDTH_1;
+        break;
+    case QEMU_PCI_EXP_LNK_X2:
+        width = PCIE_LINK_WIDTH_2;
+        break;
+    case QEMU_PCI_EXP_LNK_X4:
+        width = PCIE_LINK_WIDTH_4;
+        break;
+    case QEMU_PCI_EXP_LNK_X8:
+        width = PCIE_LINK_WIDTH_8;
+        break;
+    case QEMU_PCI_EXP_LNK_X12:
+        width = PCIE_LINK_WIDTH_12;
+        break;
+    case QEMU_PCI_EXP_LNK_X16:
+        width = PCIE_LINK_WIDTH_16;
+        break;
+    case QEMU_PCI_EXP_LNK_X32:
+        width = PCIE_LINK_WIDTH_32;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+
+    visit_type_enum(v, prop->name, &width, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
+    int width;
+    Error *local_err = NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_enum(v, prop->name, &width, prop->info->enum_table, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    switch (width) {
+    case PCIE_LINK_WIDTH_1:
+        *p = QEMU_PCI_EXP_LNK_X1;
+        break;
+    case PCIE_LINK_WIDTH_2:
+        *p = QEMU_PCI_EXP_LNK_X2;
+        break;
+    case PCIE_LINK_WIDTH_4:
+        *p = QEMU_PCI_EXP_LNK_X4;
+        break;
+    case PCIE_LINK_WIDTH_8:
+        *p = QEMU_PCI_EXP_LNK_X8;
+        break;
+    case PCIE_LINK_WIDTH_12:
+        *p = QEMU_PCI_EXP_LNK_X12;
+        break;
+    case PCIE_LINK_WIDTH_16:
+        *p = QEMU_PCI_EXP_LNK_X16;
+        break;
+    case PCIE_LINK_WIDTH_32:
+        *p = QEMU_PCI_EXP_LNK_X32;
+        break;
+    default:
+        /* Unreachable */
+        abort();
+    }
+}
+
+const PropertyInfo qdev_prop_pcie_link_width = {
+    .name = "PCIELinkWidth",
+    .description = "1/2/4/8/12/16/32",
+    .enum_table = &PCIELinkWidth_lookup,
+    .get = get_prop_pcielinkwidth,
+    .set = set_prop_pcielinkwidth,
+    .set_default_value = set_default_value_enum,
+};
-- 
MST

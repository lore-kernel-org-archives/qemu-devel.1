Received: from eggs.gnu.org ([2001:4830:134:3::10]:60378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gSsv3-0001lz-TQ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 19:14:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gSsv2-0005pU-P1
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 19:14:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gSsv2-0005pD-Hd
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 19:14:00 -0500
From: Alex Williamson <alex.williamson@redhat.com>
Date: Fri, 30 Nov 2018 17:13:56 -0700
Message-ID: <154362323657.7153.7729534719591329188.stgit@gimli.home>
In-Reply-To: <154362272919.7153.15101701755308287523.stgit@gimli.home>
References: <154362272919.7153.15101701755308287523.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-3.2 PATCH 3/9] qapi: Define PCIe link speed and
 width properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Geoffrey McRae <geoff@hostfission.com>

Create properties to be able to define speeds and widths for PCIe
links.  The only tricky bit here is that our get and set callbacks
translate from the fixed QAPI automagic enums to those we define
in PCI code to represent the actual register segment value.

Cc: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Tested-by: Geoffrey McRae <geoff@hostfission.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/core/qdev-properties.c    |  178 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/qdev-properties.h |    8 ++
 qapi/common.json             |   42 ++++++++++
 3 files changed, 228 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 35072dec1ecf..f5ca5b821a79 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1327,3 +1327,181 @@ const PropertyInfo qdev_prop_off_auto_pcibar = {
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
+    PCIELinkSpeed speed;
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
+    visit_type_enum(v, prop->name, (int *)&speed, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkspeed(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkSpeed *p = qdev_get_prop_ptr(dev, prop);
+    PCIELinkSpeed speed;
+    Error *local_err = NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_enum(v, prop->name, (int *)&speed,
+                    prop->info->enum_table, &local_err);
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
+    PCIELinkWidth width;
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
+    visit_type_enum(v, prop->name, (int *)&width, prop->info->enum_table, errp);
+}
+
+static void set_prop_pcielinkwidth(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    DeviceState *dev = DEVICE(obj);
+    Property *prop = opaque;
+    PCIExpLinkWidth *p = qdev_get_prop_ptr(dev, prop);
+    PCIELinkWidth width;
+    Error *local_err = NULL;
+
+    if (dev->realized) {
+        qdev_prop_set_after_realize(dev, name, errp);
+        return;
+    }
+
+    visit_type_enum(v, prop->name, (int *)&width,
+                    prop->info->enum_table, &local_err);
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
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 4f60cc88f325..6a13a284c48c 100644
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
diff --git a/qapi/common.json b/qapi/common.json
index 021174f04ea4..b6f3cca35c7e 100644
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
+# Since: 3.2
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
+# Since: 3.2
+##
+{ 'enum': 'PCIELinkWidth',
+  'data': [ '1', '2', '4', '8', '12', '16', '32' ] }
+
 ##
 # @SysEmuTarget:
 #

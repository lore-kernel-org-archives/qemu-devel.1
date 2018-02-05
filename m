Received: from eggs.gnu.org ([2001:4830:134:3::10]:35697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxe-0001iL-PN
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eilxd-0004Kg-NE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eilxd-0004KC-En
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 13:57:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A260649012
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 18:57:48 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 05 Feb 2018 11:57:47 -0700
Message-ID: <20180205185746.14391.34308.stgit@gimli.home>
In-Reply-To: <20180205185416.14391.5739.stgit@gimli.home>
References: <20180205185416.14391.5739.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 07/11] qapi: Create DEFINE_PROP_OFF_AUTO_PCIBAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Add an option which allows the user to specify a PCI BAR number,
including an 'off' and 'auto' selection.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/core/qdev-properties.c    |   11 +++++++++++
 include/hw/qdev-properties.h |    4 ++++
 qapi/common.json             |   26 ++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 24c17800e3f1..5bbc2d98b5a8 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1317,3 +1317,14 @@ const PropertyInfo qdev_prop_link = {
     .name = "link",
     .create = create_link_property,
 };
+
+/* --- OffAutoPCIBAR off/auto/bar0/bar1/bar2/bar3/bar4/bar5 --- */
+
+const PropertyInfo qdev_prop_off_auto_pcibar = {
+    .name = "OffAutoPCIBAR",
+    .description = "off/auto/bar0/bar1/bar2/bar3/bar4/bar5",
+    .enum_table = &OffAutoPCIBAR_lookup,
+    .get = get_enum,
+    .set = set_enum,
+    .set_default_value = set_default_value_enum,
+};
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 5bbfec634b29..1d61a351086d 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -34,6 +34,7 @@ extern const PropertyInfo qdev_prop_pci_host_devaddr;
 extern const PropertyInfo qdev_prop_uuid;
 extern const PropertyInfo qdev_prop_arraylen;
 extern const PropertyInfo qdev_prop_link;
+extern const PropertyInfo qdev_prop_off_auto_pcibar;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
         .name      = (_name),                                    \
@@ -214,6 +215,9 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
 #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
+#define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
+                        OffAutoPCIBAR)
 
 #define DEFINE_PROP_UUID(_name, _state, _field) {                  \
         .name      = (_name),                                      \
diff --git a/qapi/common.json b/qapi/common.json
index 6eb01821ef59..d9b14dd429f3 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -100,3 +100,29 @@
 { 'alternate': 'StrOrNull',
   'data': { 's': 'str',
             'n': 'null' } }
+
+##
+# @OffAutoPCIBAR:
+#
+# An enumeration of options for specifying a PCI BAR
+#
+# @off: The specified feature is disabled
+#
+# @auto: The PCI BAR for the feature is automatically selected
+#
+# @bar0: PCI BAR0 is used for the feature
+#
+# @bar1: PCI BAR1 is used for the feature
+#
+# @bar2: PCI BAR2 is used for the feature
+#
+# @bar3: PCI BAR3 is used for the feature
+#
+# @bar4: PCI BAR4 is used for the feature
+#
+# @bar5: PCI BAR5 is used for the feature
+#
+# Since: 2.12
+##
+{ 'enum': 'OffAutoPCIBAR',
+  'data': [ 'off', 'auto', 'bar0', 'bar1', 'bar2', 'bar3', 'bar4', 'bar5' ] }

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQnZk-00014B-VN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eQnZh-0001wU-St
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eQnZh-0001vN-K5
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:02:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC59C85540
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 05:02:48 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
Date: Sun, 17 Dec 2017 22:02:44 -0700
Message-ID: <20171218050244.13478.35553.stgit@gimli.home>
In-Reply-To: <20171218040852.13478.19208.stgit@gimli.home>
References: <20171218040852.13478.19208.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC/RFT PATCH 4/5] qapi: Create
 DEFINE_PROP_OFF_AUTO_PCIBAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com

Add an option which allows the user to specify a PCI BAR number,
including an 'off' and 'auto' selection.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/core/qdev-properties.c    |   11 +++++++++++
 include/hw/qdev-properties.h |    4 ++++
 qapi/common.json             |   26 ++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 1dc80fcea2af..e33184e5a342 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1256,3 +1256,14 @@ const PropertyInfo qdev_prop_link = {
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
index e2321f1cc1ec..9ca2af5e3625 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -32,6 +32,7 @@ extern const PropertyInfo qdev_prop_blocksize;
 extern const PropertyInfo qdev_prop_pci_host_devaddr;
 extern const PropertyInfo qdev_prop_arraylen;
 extern const PropertyInfo qdev_prop_link;
+extern const PropertyInfo qdev_prop_off_auto_pcibar;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type) { \
         .name      = (_name),                                    \
@@ -212,6 +213,9 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP(_n, _s, _f, qdev_prop_pci_host_devaddr, PCIHostDeviceAddress)
 #define DEFINE_PROP_MEMORY_REGION(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, qdev_prop_ptr, MemoryRegion *)
+#define DEFINE_PROP_OFF_AUTO_PCIBAR(_n, _s, _f, _d) \
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_off_auto_pcibar, \
+                        OffAutoPCIBAR)
 
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
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

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AY-00083x-MR
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d80AS-0007VY-CY
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d80AS-0007Tv-3c
	for qemu-devel@nongnu.org; Tue, 09 May 2017 04:06:48 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 305C9C04B316
	for <qemu-devel@nongnu.org>; Tue,  9 May 2017 08:06:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  9 May 2017 10:06:20 +0200
Message-Id: <1494317205-2211-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1494317205-2211-1-git-send-email-armbru@redhat.com>
References: <1494317205-2211-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v3 03/28] pci: Use struct instead of QDict to
 pass back parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

It's simpler to just use a C struct than it is to bundle things
into a QDict in one function just to pull them back out in the
caller.  Plus, doing this gets rid of one more user of dynamic
JSON through qobject_from_jsonf(), as well as a memory leak of
the QDict.

While cleaning the code, fix things to report all errors (the
code was previously silently ignoring a failure of
pcie_aer_inject_error(), at a distance).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170427215821.19397-2-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/pci/pcie_aer.c | 44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index a8c1820..653af86 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -44,6 +44,13 @@
 #define PCI_ERR_SRC_COR_OFFS    0
 #define PCI_ERR_SRC_UNCOR_OFFS  2
 
+typedef struct PCIEErrorDetails {
+    const char *id;
+    const char *root_bus;
+    int bus;
+    int devfn;
+} PCIEErrorDetails;
+
 /* From 6.2.7 Error Listing and Rules. Table 6-2, 6-3 and 6-4 */
 static uint32_t pcie_aer_uncor_default_severity(uint32_t status)
 {
@@ -942,8 +949,14 @@ static int pcie_aer_parse_error_string(const char *error_name,
     return -EINVAL;
 }
 
+/*
+ * Inject an error described by @qdict.
+ * On success, set @details to show where error was sent.
+ * Return negative errno if injection failed and a message was emitted.
+ */
 static int do_pcie_aer_inject_error(Monitor *mon,
-                                    const QDict *qdict, QObject **ret_data)
+                                    const QDict *qdict,
+                                    PCIEErrorDetails *details)
 {
     const char *id = qdict_get_str(qdict, "id");
     const char *error_name;
@@ -1005,33 +1018,28 @@ static int do_pcie_aer_inject_error(Monitor *mon,
     err.prefix[3] = qdict_get_try_int(qdict, "prefix3", 0);
 
     ret = pcie_aer_inject_error(dev, &err);
-    *ret_data = qobject_from_jsonf("{'id': %s, "
-                                   "'root_bus': %s, 'bus': %d, 'devfn': %d, "
-                                   "'ret': %d}",
-                                   id, pci_root_bus_path(dev),
-                                   pci_bus_num(dev->bus), dev->devfn,
-                                   ret);
-    assert(*ret_data);
+    if (ret < 0) {
+        monitor_printf(mon, "failed to inject error: %s\n",
+                       strerror(-ret));
+        return ret;
+    }
+    details->id = id;
+    details->root_bus = pci_root_bus_path(dev);
+    details->bus = pci_bus_num(dev->bus);
+    details->devfn = dev->devfn;
 
     return 0;
 }
 
 void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict)
 {
-    QObject *data;
-    int devfn;
+    PCIEErrorDetails data;
 
     if (do_pcie_aer_inject_error(mon, qdict, &data) < 0) {
         return;
     }
 
-    qdict = qobject_to_qdict(data);
-    assert(qdict);
-
-    devfn = (int)qdict_get_int(qdict, "devfn");
     monitor_printf(mon, "OK id: %s root bus: %s, bus: %x devfn: %x.%x\n",
-                   qdict_get_str(qdict, "id"),
-                   qdict_get_str(qdict, "root_bus"),
-                   (int) qdict_get_int(qdict, "bus"),
-                   PCI_SLOT(devfn), PCI_FUNC(devfn));
+                   data.id, data.root_bus, data.bus,
+                   PCI_SLOT(data.devfn), PCI_FUNC(data.devfn));
 }
-- 
2.7.4

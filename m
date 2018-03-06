Received: from eggs.gnu.org ([2001:4830:134:3::10]:42120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etFmt-00089X-Ov
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:50:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etFms-0000qt-P1
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:50:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etFms-0000ql-Ie
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:50:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DA4D04067734
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 16:50:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Mar 2018 17:49:56 +0100
Message-Id: <20180306164957.24275-3-pbonzini@redhat.com>
In-Reply-To: <20180306164957.24275-1-pbonzini@redhat.com>
References: <20180306164957.24275-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] net: allow using any PCI NICs in -net or
 -nic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

Remove the hard-coded list of PCI NIC names; instead, fill an array
using all PCI devices listed under DEVICE_CATEGORY_NETWORK. Keep
the old shortcut "virtio" for virtio-net-pci.

Suggested-by: Thomas Huth <thuth@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci/pci.c | 61 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2174c254eb..aa24a26680 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1815,49 +1815,48 @@ PciInfoList *qmp_query_pci(Error **errp)
     return head;
 }
 
-static const char * const pci_nic_models[] = {
-    "ne2k_pci",
-    "i82551",
-    "i82557b",
-    "i82559er",
-    "rtl8139",
-    "e1000",
-    "pcnet",
-    "virtio",
-    "sungem",
-    NULL
-};
-
-static const char * const pci_nic_names[] = {
-    "ne2k_pci",
-    "i82551",
-    "i82557b",
-    "i82559er",
-    "rtl8139",
-    "e1000",
-    "pcnet",
-    "virtio-net-pci",
-    "sungem",
-    NULL
-};
-
 /* Initialize a PCI NIC.  */
 PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
                                const char *default_model,
                                const char *default_devaddr)
 {
     const char *devaddr = nd->devaddr ? nd->devaddr : default_devaddr;
+    GSList *list;
+    GPtrArray *pci_nic_models;
     PCIBus *bus;
     PCIDevice *pci_dev;
     DeviceState *dev;
     int devfn;
     int i;
 
-    if (qemu_show_nic_models(nd->model, pci_nic_models)) {
+    if (!strcmp(nd->model, "virtio")) {
+        g_free(nd->model);
+        nd->model = g_strdup("virtio-net-pci");
+    }
+
+    list = object_class_get_list_sorted(TYPE_PCI_DEVICE, false);
+    pci_nic_models = g_ptr_array_new_with_free_func(g_free);
+    while (list) {
+        DeviceClass *dc = OBJECT_CLASS_CHECK(DeviceClass, list->data,
+                                             TYPE_DEVICE);
+        GSList *next;
+        if (test_bit(DEVICE_CATEGORY_NETWORK, dc->categories) &&
+            dc->user_creatable) {
+            const char *name = object_class_get_name(list->data) ;
+            g_ptr_array_add(pci_nic_models, (gpointer)name);
+        }
+        next = list->next;
+        g_slist_free_1(list);
+        list = next;
+    }
+    g_ptr_array_add(pci_nic_models, NULL);
+
+    if (qemu_show_nic_models(nd->model, (const char **)pci_nic_models->pdata)) {
         exit(0);
     }
 
-    i = qemu_find_nic_model(nd, pci_nic_models, default_model);
+    i = qemu_find_nic_model(nd, (const char **)pci_nic_models->pdata,
+                            default_model);
     if (i < 0) {
         exit(1);
     }
@@ -1865,15 +1864,15 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
     bus = pci_get_bus_devfn(&devfn, rootbus, devaddr);
     if (!bus) {
         error_report("Invalid PCI device address %s for device %s",
-                     devaddr, pci_nic_names[i]);
+                     devaddr, nd->model);
         exit(1);
     }
 
-    pci_dev = pci_create(bus, devfn, pci_nic_names[i]);
+    pci_dev = pci_create(bus, devfn, nd->model);
     dev = &pci_dev->qdev;
     qdev_set_nic_properties(dev, nd);
     qdev_init_nofail(dev);
-
+    g_ptr_array_free(pci_nic_models, true);
     return pci_dev;
 }
 
-- 
2.14.3

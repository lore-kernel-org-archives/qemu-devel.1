Received: from eggs.gnu.org ([2001:4830:134:3::10]:57742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshb-0005Lx-Q6
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1evshZ-0002fc-0Z
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:27 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1evshY-0002eU-QU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 18:47:24 -0400
Received: by mail-wr0-x241.google.com with SMTP id s12so12602wre.7
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 15:47:24 -0700 (PDT)
Received: from donizetti.lan (94-36-191-219.adsl-ull.clienti.tiscali.it.
	[94.36.191.219]) by smtp.gmail.com with ESMTPSA id
	x107sm1557951wrb.97.2018.03.13.15.47.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 13 Mar 2018 15:47:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 13 Mar 2018 23:46:12 +0100
Message-Id: <20180313224719.4954-3-pbonzini@redhat.com>
In-Reply-To: <20180313224719.4954-1-pbonzini@redhat.com>
References: <20180313224719.4954-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 02/69] net: allow using any PCI NICs in -net or
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

Remove the hard-coded list of PCI NIC names; instead, fill an array
using all PCI devices listed under DEVICE_CATEGORY_NETWORK. Keep
the old shortcut "virtio" for virtio-net-pci.

Suggested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/pci/pci.c  | 61 +++++++++++++++++++++++++++++------------------------------
 hw/ppc/e500.c |  2 +-
 2 files changed, 31 insertions(+), 32 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2174c254eb..67a3f72bd6 100644
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
+    if (nd->model && !strcmp(nd->model, "virtio")) {
+        g_free(nd->model);
+        nd->model = g_strdup("virtio-net-pci");
+    }
+
+    list = object_class_get_list_sorted(TYPE_PCI_DEVICE, false);
+    pci_nic_models = g_ptr_array_new();
+    while (list) {
+        DeviceClass *dc = OBJECT_CLASS_CHECK(DeviceClass, list->data,
+                                             TYPE_DEVICE);
+        GSList *next;
+        if (test_bit(DEVICE_CATEGORY_NETWORK, dc->categories) &&
+            dc->user_creatable) {
+            const char *name = object_class_get_name(list->data);
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
 
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 43c15d18c4..2238f963c4 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -916,7 +916,7 @@ void ppce500_init(MachineState *machine, PPCE500Params *params)
     if (pci_bus) {
         /* Register network interfaces. */
         for (i = 0; i < nb_nics; i++) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, "virtio", NULL);
+            pci_nic_init_nofail(&nd_table[i], pci_bus, "virtio-net-pci", NULL);
         }
     }
 
-- 
2.14.3

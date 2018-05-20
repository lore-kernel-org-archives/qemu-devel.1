Received: from eggs.gnu.org ([2001:4830:134:3::10]:52345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fKImU-00014m-Gc
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fKImR-0006xO-DR
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:29:26 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:36599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fKImR-0006xD-6Z
	for qemu-devel@nongnu.org; Sun, 20 May 2018 03:29:23 -0400
Received: by mail-pl0-x242.google.com with SMTP id v24-v6so6961097plo.3
	for <qemu-devel@nongnu.org>; Sun, 20 May 2018 00:29:23 -0700 (PDT)
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Sun, 20 May 2018 15:28:52 +0800
Message-Id: <1526801333-30613-3-git-send-email-whois.zihan.yang@gmail.com>
In-Reply-To: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
References: <1526801333-30613-1-git-send-email-whois.zihan.yang@gmail.com>
Subject: [Qemu-devel] [RFC 2/3] pci: Link pci_host_bridges with QTAILQ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

QLIST will place the original q35 host bridge at the end of list because it is
added first. Replace it with QTAILQ to make q35 at the first of queue, which
makes it convinient and compatible when there are pxb hosts other than q35 hosts

Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
---
 hw/pci/pci.c              | 9 +++++----
 include/hw/pci/pci_host.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 80bc459..ddc27ba 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -196,7 +196,8 @@ static void pci_del_option_rom(PCIDevice *pdev);
 static uint16_t pci_default_sub_vendor_id = PCI_SUBVENDOR_ID_REDHAT_QUMRANET;
 static uint16_t pci_default_sub_device_id = PCI_SUBDEVICE_ID_QEMU;
 
-static QLIST_HEAD(, PCIHostState) pci_host_bridges;
+static QTAILQ_HEAD(, PCIHostState) pci_host_bridges =
+    QTAILQ_HEAD_INITIALIZER(pci_host_bridges);
 
 int pci_bar(PCIDevice *d, int reg)
 {
@@ -330,7 +331,7 @@ static void pci_host_bus_register(DeviceState *host)
 {
     PCIHostState *host_bridge = PCI_HOST_BRIDGE(host);
 
-    QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
+    QTAILQ_INSERT_TAIL(&pci_host_bridges, host_bridge, next);
 }
 
 PCIBus *pci_device_root_bus(const PCIDevice *d)
@@ -1798,7 +1799,7 @@ PciInfoList *qmp_query_pci(Error **errp)
     PciInfoList *info, *head = NULL, *cur_item = NULL;
     PCIHostState *host_bridge;
 
-    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
+    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
         info = g_malloc0(sizeof(*info));
         info->value = qmp_query_pci_bus(host_bridge->bus,
                                         pci_bus_num(host_bridge->bus));
@@ -2493,7 +2494,7 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
     PCIHostState *host_bridge;
     int rc = -ENODEV;
 
-    QLIST_FOREACH(host_bridge, &pci_host_bridges, next) {
+    QTAILQ_FOREACH(host_bridge, &pci_host_bridges, next) {
         int tmp = pci_qdev_find_recursive(host_bridge->bus, id, pdev);
         if (!tmp) {
             rc = 0;
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index ba31595..a5617cf 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -47,7 +47,7 @@ struct PCIHostState {
     uint32_t config_reg;
     PCIBus *bus;
 
-    QLIST_ENTRY(PCIHostState) next;
+    QTAILQ_ENTRY(PCIHostState) next;
 };
 
 typedef struct PCIHostBridgeClass {
-- 
2.7.4

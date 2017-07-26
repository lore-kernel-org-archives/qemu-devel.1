Received: from eggs.gnu.org ([2001:4830:134:3::10]:50127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHu1-0002Oq-SB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHtx-0003tk-Ll
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:42:45 -0400
Received: from [59.151.112.132] (port=30138 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1daHtx-0003sj-A2
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 04:42:41 -0400
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Date: Wed, 26 Jul 2017 16:41:53 +0800
Message-ID: <20170726084153.10121-2-maozy.fnst@cn.fujitsu.com>
In-Reply-To: <20170726084153.10121-1-maozy.fnst@cn.fujitsu.com>
References: <20170726084153.10121-1-maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] hw/scsi/vmw_pvscsi: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

Convert a device model where initialization obviously
can't fail, make it implement realize() rather than init().

Cc: Dmitry Fleytman <dmitry@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
---
 hw/scsi/vmw_pvscsi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index d92973e..77d8b6f 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1103,8 +1103,8 @@ static const struct SCSIBusInfo pvscsi_scsi_info = {
         .cancel = pvscsi_request_cancelled,
 };
 
-static int
-pvscsi_init(PCIDevice *pci_dev)
+static void
+pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
 {
     PVSCSIState *s = PVSCSI(pci_dev);
 
@@ -1144,8 +1144,6 @@ pvscsi_init(PCIDevice *pci_dev)
     /* override default SCSI bus hotplug-handler, with pvscsi's one */
     qbus_set_hotplug_handler(BUS(&s->bus), DEVICE(s), &error_abort);
     pvscsi_reset_state(s);
-
-    return 0;
 }
 
 static void
@@ -1278,7 +1276,7 @@ static void pvscsi_class_init(ObjectClass *klass, void *data)
     PVSCSIClass *pvs_k = PVSCSI_DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    k->init = pvscsi_init;
+    k->realize = pvscsi_realizefn;
     k->exit = pvscsi_uninit;
     k->vendor_id = PCI_VENDOR_ID_VMWARE;
     k->device_id = PCI_DEVICE_ID_VMWARE_PVSCSI;
-- 
2.9.4

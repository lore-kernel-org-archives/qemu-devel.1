Received: from eggs.gnu.org ([2001:4830:134:3::10]:59665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrf-0004Vi-UX
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dcZrf-0007Ku-1r
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:47 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dcZre-0007KJ-Rd
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 12:17:46 -0400
Received: by mail-wr0-x242.google.com with SMTP id g32so1795886wrd.5
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 09:17:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  1 Aug 2017 18:17:21 +0200
Message-Id: <1501604245-33460-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/17] hw/scsi/vmw_pvscsi: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Convert a device model where initialization obviously
can't fail, make it implement realize() rather than init().

Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-Id: <20170726084153.10121-2-maozy.fnst@cn.fujitsu.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1

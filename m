Received: from eggs.gnu.org ([2001:4830:134:3::10]:39621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fx73k-0002Iy-M8
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 04:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1fx73g-00076u-2o
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 04:51:40 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:63408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1fx73f-00074N-NV
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 04:51:35 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Wed, 5 Sep 2018 01:04:36 +0800
Message-Id: <1536080676-33977-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] target-i386: add q35 0xcf8 port as
 coalesced_pio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rkrcmar@redhat.com, mst@redhat.com, ehabkost@redhat.com
Cc: liran.alon@oracle.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>

after coalesced pio series patches, the patch is a supplement to
q35 pci-host config port.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/pci-host/q35.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 02f9576..8ce1e09 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -51,6 +51,10 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
     sysbus_add_io(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, &pci->data_mem);
     sysbus_init_ioports(sbd, MCH_HOST_BRIDGE_CONFIG_DATA, 4);
 
+    /* register q35 0xcf8 port as coalesced pio */
+    memory_region_set_flush_coalesced(&pci->data_mem);
+    memory_region_add_coalescing(&pci->conf_mem, 0, 4);
+
     pci->bus = pci_root_bus_new(DEVICE(s), "pcie.0",
                                 s->mch.pci_address_space,
                                 s->mch.address_space_io,
-- 
1.8.3.1

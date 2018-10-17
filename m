Received: from eggs.gnu.org ([2001:4830:134:3::10]:56089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gChP1-0004Dt-Ip
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gChOw-0007vh-Bo
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:42:03 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:58500 helo=mxct.zte.com.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peng.hao2@zte.com.cn>)
	id 1gChOv-0007cp-R8
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:41:58 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Thu, 18 Oct 2018 00:52:57 +0800
Message-Id: <1539795177-21038-6-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1539795177-21038-1-git-send-email-peng.hao2@zte.com.cn>
References: <1539795177-21038-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH V6 5/5] target-i386: add q35 0xcf8 port as
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>

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

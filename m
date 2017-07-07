Received: from eggs.gnu.org ([2001:4830:134:3::10]:52309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTY18-00024H-6m
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1dTY14-0006lg-VX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1dTY14-0006ko-Q7
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 14:30:10 -0400
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Fri,  7 Jul 2017 11:30:03 -0700
Message-Id: <1499452204-20769-2-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1499452204-20769-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1707071117420.2919@sstabellini-ThinkPad-X260>
	<1499452204-20769-1-git-send-email-sstabellini@kernel.org>
Subject: [Qemu-devel] [PULL 2/3] xen-platform: Cleanup network
 infrastructure when emulated NICs are unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

When the guest unplugs the emulated NICs, cleanup the peer for each NIC
as it is not needed anymore. Most importantly, this allows the tap
interfaces which QEMU holds open to be closed and removed.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen_platform.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 1419fc9..f231558 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -102,8 +102,19 @@ static void unplug_nic(PCIBus *b, PCIDevice *d, void *o)
     }
 }
 
+/* Remove the peer of the NIC device. Normally, this would be a tap device. */
+static void del_nic_peer(NICState *nic, void *opaque)
+{
+    NetClientState *nc;
+
+    nc = qemu_get_queue(nic);
+    if (nc->peer)
+        qemu_del_net_client(nc->peer);
+}
+
 static void pci_unplug_nics(PCIBus *bus)
 {
+    qemu_foreach_nic(del_nic_peer, NULL);
     pci_for_each_device(bus, 0, unplug_nic, NULL);
 }
 
-- 
1.9.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:38999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=347f66864=ross.lagerwall@citrix.com>)
	id 1dQvNl-0001ud-LP
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:50:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=347f66864=ross.lagerwall@citrix.com>)
	id 1dQvNg-0003Tj-Tw
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:50:45 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:9193)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=347f66864=ross.lagerwall@citrix.com>)
	id 1dQvNg-0003TV-OX
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 08:50:40 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Fri, 30 Jun 2017 13:50:28 +0100
Message-ID: <20170630125028.30265-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] xen-platform: Cleanup network
 infrastructure when emulated NICs are unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

When the guest unplugs the emulated NICs, cleanup the peer for each NIC
as it is not needed anymore. Most importantly, this allows the tap
interfaces which QEMU holds open to be closed and removed.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---

In v2: Don't call nic_cleanup(), just remove the peer of the NIC which
will cleanup up the tap devices. This means that QEMU doesn't segv
when shutting down.

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
2.9.4

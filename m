Received: from eggs.gnu.org ([2001:4830:134:3::10]:36341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=336ecd02e=ross.lagerwall@citrix.com>)
	id 1dMrur-00007D-7U
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=336ecd02e=ross.lagerwall@citrix.com>)
	id 1dMrum-0002e8-Fb
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:20:09 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:14410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=336ecd02e=ross.lagerwall@citrix.com>)
	id 1dMrum-0002aq-A6
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 04:20:04 -0400
From: Ross Lagerwall <ross.lagerwall@citrix.com>
Date: Mon, 19 Jun 2017 09:19:45 +0100
Message-ID: <20170619081945.30001-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] xen-platform: Cleanup network infrastructure
 when emulated NICs are unplugged
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

When the guest unplugs the emulated NICs, call net_cleanup() to cleanup
the network infrastructure in QEMU as it is not needed anymore. Most
importantly, this allows the tap interfaces which QEMU holds open to be
closed and removed.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 hw/i386/xen/xen_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 1419fc9..180abc7 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -105,6 +105,7 @@ static void unplug_nic(PCIBus *b, PCIDevice *d, void *o)
 static void pci_unplug_nics(PCIBus *bus)
 {
     pci_for_each_device(bus, 0, unplug_nic, NULL);
+    net_cleanup();
 }
 
 static void unplug_disks(PCIBus *b, PCIDevice *d, void *opaque)
-- 
2.9.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eC8il-00087N-Fd
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:35:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eC8ig-0003CZ-Qp
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:35:35 -0500
Received: from relay2.gtri.gatech.edu ([130.207.199.168]:43732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Michael.Nawrocki@gtri.gatech.edu>)
	id 1eC8ig-0003BW-BW
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 13:35:30 -0500
From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Date: Tue, 7 Nov 2017 13:35:02 -0500
Message-ID: <20171107183503.6800-2-michael.nawrocki@gtri.gatech.edu>
In-Reply-To: <20171107183503.6800-1-michael.nawrocki@gtri.gatech.edu>
References: <20171107183503.6800-1-michael.nawrocki@gtri.gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/2] Fix eepro100 simple transmission mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, marcel@redhat.com, Mike
	Nawrocki <michael.nawrocki@gtri.gatech.edu>

The simple transmission mode was treating the area immediately after the
transmit command block (TCB) as if it were a transmit buffer descriptor,
when in reality it is simply the packet data. This change simply copies
the data following the TCB into the packet buffer.

Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
---
 hw/net/eepro100.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 80b8f47c4b..91dd058010 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -774,23 +774,11 @@ static void tx_command(EEPRO100State *s)
     }
     assert(tcb_bytes <= sizeof(buf));
     while (size < tcb_bytes) {
-        uint32_t tx_buffer_address = ldl_le_pci_dma(&s->dev, tbd_address);
-        uint16_t tx_buffer_size = lduw_le_pci_dma(&s->dev, tbd_address + 4);
-#if 0
-        uint16_t tx_buffer_el = lduw_le_pci_dma(&s->dev, tbd_address + 6);
-#endif
-        if (tx_buffer_size == 0) {
-            /* Prevent an endless loop. */
-            logout("loop in %s:%u\n", __FILE__, __LINE__);
-            break;
-        }
-        tbd_address += 8;
         TRACE(RXTX, logout
             ("TBD (simplified mode): buffer address 0x%08x, size 0x%04x\n",
-             tx_buffer_address, tx_buffer_size));
-        tx_buffer_size = MIN(tx_buffer_size, sizeof(buf) - size);
-        pci_dma_read(&s->dev, tx_buffer_address, &buf[size], tx_buffer_size);
-        size += tx_buffer_size;
+             tbd_address, tcb_bytes));
+        pci_dma_read(&s->dev, tbd_address, &buf[size], tcb_bytes);
+        size += tcb_bytes;
     }
     if (tbd_array == 0xffffffff) {
         /* Simplified mode. Was already handled by code above. */
-- 
2.14.2

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhq-00056U-Ka
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEQhp-0000re-NI
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:12:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEQhp-0000rK-HD
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 21:12:05 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Nov 2017 10:11:36 +0800
Message-Id: <1510625498-4821-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 6/8] Fix eepro100 simple transmission mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>, Jason Wang <jasowang@redhat.com>

From: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>

The simple transmission mode was treating the area immediately after the
transmit command block (TCB) as if it were a transmit buffer descriptor,
when in reality it is simply the packet data. This change simply copies
the data following the TCB into the packet buffer.

Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/eepro100.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 80b8f47..91dd058 100644
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
2.7.4

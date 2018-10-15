Received: from eggs.gnu.org ([2001:4830:134:3::10]:45756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXL-0004d3-EX
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXI-0004V6-4d
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:39 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:22 +0800
Message-Id: <1539593186-32183-23-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 22/26] rtl8139: fix possible out of bound access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org

In rtl8139_do_receive(), we try to assign size_ to size which converts
from size_t to integer. This will cause troubles when size_ is greater
INT_MAX, this will lead a negative value in size and it can then pass
the check of size < MIN_BUF_SIZE which may lead out of bound access of
for both buf and buf1.

Fixing by converting the type of size to size_t.

CC: qemu-stable@nongnu.org
Reported-by: Daniel Shapira <daniel@twistlock.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/rtl8139.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 46daa16..2342a09 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -817,7 +817,7 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
     RTL8139State *s = qemu_get_nic_opaque(nc);
     PCIDevice *d = PCI_DEVICE(s);
     /* size is the length of the buffer passed to the driver */
-    int size = size_;
+    size_t size = size_;
     const uint8_t *dot1q_buf = NULL;
 
     uint32_t packet_header = 0;
@@ -826,7 +826,7 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
     static const uint8_t broadcast_macaddr[6] =
         { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
 
-    DPRINTF(">>> received len=%d\n", size);
+    DPRINTF(">>> received len=%zu\n", size);
 
     /* test if board clock is stopped */
     if (!s->clock_enabled)
@@ -1035,7 +1035,7 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
 
         if (size+4 > rx_space)
         {
-            DPRINTF("C+ Rx mode : descriptor %d size %d received %d + 4\n",
+            DPRINTF("C+ Rx mode : descriptor %d size %d received %zu + 4\n",
                 descriptor, rx_space, size);
 
             s->IntrStatus |= RxOverflow;
@@ -1148,7 +1148,7 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
         if (avail != 0 && RX_ALIGN(size + 8) >= avail)
         {
             DPRINTF("rx overflow: rx buffer length %d head 0x%04x "
-                "read 0x%04x === available 0x%04x need 0x%04x\n",
+                "read 0x%04x === available 0x%04x need 0x%04zx\n",
                 s->RxBufferSize, s->RxBufAddr, s->RxBufPtr, avail, size + 8);
 
             s->IntrStatus |= RxOverflow;
-- 
2.5.0

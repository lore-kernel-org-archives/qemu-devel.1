Received: from eggs.gnu.org ([209.51.188.92]:41090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44m-0001Zo-Q9
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1hB44l-0003Zm-Ew
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1hB44l-0003Se-2G
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:02:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x31L1rsv122343
	for <qemu-devel@nongnu.org>; Mon, 1 Apr 2019 17:02:27 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rksyg8r8k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 17:02:27 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 1 Apr 2019 22:02:24 +0100
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  1 Apr 2019 15:59:20 -0500
In-Reply-To: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
References: <20190401210011.16009-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20190401210011.16009-47-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 46/97] rtl8139: fix possible out of bound access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: Jason Wang <jasowang@redhat.com>

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
(cherry picked from commit 1a326646fef38782e5542280040ec3ea23e4a730)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/rtl8139.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 46daa16202..2342a095e3 100644
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
2.17.1

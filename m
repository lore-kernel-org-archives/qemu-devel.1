Received: from eggs.gnu.org ([2001:4830:134:3::10]:50145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFRX4-0004PA-QN
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:17:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eFRX1-0004eU-K7
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 16:17:10 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 16 Nov 2017 22:16:54 +0100
Message-Id: <1510867014-13423-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11] hw/net/eepro100: Fix endianness
 problem on big endian hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Michael Nawrocki <michael.nawrocki@gtri.gatech.edu>, mst@redhat.com, qemu-s390x@nongnu.org

Since commit 1865e288a823c764cd4344d ("Fix eepro100 simple transmission
mode"), the test/pxe-test is broken for the eepro100 device on big
endian hosts. However, it seems like that commit did not introduce the
problem, but just uncovered it: The EEPRO100State->tx.tbd_array_addr and
EEPRO100State->tx.tcb_bytes fields are already in host byte order, since
they have already been byte-swapped in the read_cb() function.
Thus byte-swapping them in tx_command() again results in the wrong
endianness. Removing the byte-swapping here fixes the pxe-test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/net/eepro100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index a63ed2c..03e00f7 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -756,8 +756,8 @@ static void read_cb(EEPRO100State *s)
 
 static void tx_command(EEPRO100State *s)
 {
-    uint32_t tbd_array = le32_to_cpu(s->tx.tbd_array_addr);
-    uint16_t tcb_bytes = (le16_to_cpu(s->tx.tcb_bytes) & 0x3fff);
+    uint32_t tbd_array = s->tx.tbd_array_addr;
+    uint16_t tcb_bytes = s->tx.tcb_bytes & 0x3fff;
     /* Sends larger than MAX_ETH_FRAME_SIZE are allowed, up to 2600 bytes. */
     uint8_t buf[2600];
     uint16_t size = 0;
-- 
1.8.3.1

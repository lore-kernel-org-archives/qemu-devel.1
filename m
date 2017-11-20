Received: from eggs.gnu.org ([2001:4830:134:3::10]:39439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGcoC-0007AW-Ei
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eGcoB-0000uu-Ku
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eGcoB-0000ui-EO
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 22:31:43 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Nov 2017 11:31:24 +0800
Message-Id: <1511148687-24909-4-git-send-email-jasowang@redhat.com>
In-Reply-To: <1511148687-24909-1-git-send-email-jasowang@redhat.com>
References: <1511148687-24909-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 3/6] hw/net/eepro100: Fix endianness problem on
 big endian hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Since commit 1865e288a823c764cd4344d ("Fix eepro100 simple transmission
mode"), the test/pxe-test is broken for the eepro100 device on big
endian hosts. However, it seems like that commit did not introduce the
problem, but just uncovered it: The EEPRO100State->tx.tbd_array_addr and
EEPRO100State->tx.tcb_bytes fields are already in host byte order, since
they have already been byte-swapped in the read_cb() function.
Thus byte-swapping them in tx_command() again results in the wrong
endianness. Removing the byte-swapping here fixes the pxe-test.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/eepro100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 91dd058..1c0def5 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -754,8 +754,8 @@ static void read_cb(EEPRO100State *s)
 
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
2.7.4

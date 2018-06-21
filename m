Received: from eggs.gnu.org ([2001:4830:134:3::10]:50410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39L-0004xQ-Af
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fW39J-0002DP-8g
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:13:35 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 14:12:55 -0300
Message-Id: <20180621171257.14897-10-f4bug@amsat.org>
In-Reply-To: <20180621171257.14897-1-f4bug@amsat.org>
References: <20180621171257.14897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 09/11] hw/net/etraxfs_eth: Convert printf()
 calls to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jason Wang <jasowang@redhat.com>

Suggested-by: Alistair Francis <alistair@alistair23.me>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/net/etraxfs_eth.c | 8 ++++----
 hw/net/trace-events  | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 013c8d0a41..a6932432b1 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -27,6 +27,7 @@
 #include "net/net.h"
 #include "hw/cris/etraxfs.h"
 #include "qemu/error-report.h"
+#include "trace.h"
 
 #define D(x)
 
@@ -106,7 +107,7 @@ static unsigned int tdk_read(struct qemu_phy *phy, unsigned int req)
         r = phy->regs[regnum];
         break;
     }
-    D(printf("\n%s %x = reg[%d]\n", __func__, r, regnum));
+    trace_mdio_phy_read(regnum, r);
     return r;
 }
 
@@ -116,7 +117,7 @@ tdk_write(struct qemu_phy *phy, unsigned int req, unsigned int data)
     int regnum;
 
     regnum = req & 0x1f;
-    D(printf("%s reg[%d] = %x\n", __func__, regnum, data));
+    trace_mdio_phy_write(regnum, data);
     switch (regnum) {
     default:
         phy->regs[regnum] = data;
@@ -206,8 +207,7 @@ static void mdio_cycle(struct qemu_mdio *bus)
 {
     bus->cnt++;
 
-    D(printf("mdc=%d mdio=%d state=%d cnt=%d drv=%d\n",
-        bus->mdc, bus->mdio, bus->state, bus->cnt, bus->drive));
+    trace_mdio_bitbang(bus->mdc, bus->mdio, bus->state, bus->cnt, bus->drive);
 #if 0
     if (bus->mdc) {
         printf("%d", bus->mdio);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index f57010df37..663bea1b74 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -1,5 +1,10 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/net/etraxfs_eth.c
+mdio_phy_read(int regnum, uint16_t value) "read phy_reg:%d value:0x%04x"
+mdio_phy_write(int regnum, uint16_t value) "write phy_reg:%d value:0x%04x"
+mdio_bitbang(bool mdc, bool mdio, int state, uint16_t cnt, unsigned int drive) "bitbang mdc=%u mdio=%u state=%d cnt=%u drv=%d"
+
 # hw/net/lance.c
 lance_mem_readw(uint64_t addr, uint32_t ret) "addr=0x%"PRIx64"val=0x%04x"
 lance_mem_writew(uint64_t addr, uint32_t val) "addr=0x%"PRIx64"val=0x%04x"
-- 
2.18.0.rc2

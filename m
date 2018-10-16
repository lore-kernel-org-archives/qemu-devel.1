Received: from eggs.gnu.org ([2001:4830:134:3::10]:42871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC6-0000de-72
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC5-0007nj-C8
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:38 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC5-0007ll-3d
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC4-0003ne-5P
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:36 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:13 +0100
Message-Id: <20181016152325.31367-8-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/19] net: cadence_gem: Announce availability
 of priority queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Announce the availability of the various priority queues.
This fixes an issue where guest kernels would miss to
configure secondary queues due to inproper feature bits.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181011021931.4249-3-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/cadence_gem.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index e560b7a142e..901c1739709 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1213,6 +1213,7 @@ static void gem_reset(DeviceState *d)
     int i;
     CadenceGEMState *s = CADENCE_GEM(d);
     const uint8_t *a;
+    uint32_t queues_mask;
 
     DB_PRINT("\n");
 
@@ -1229,7 +1230,10 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_DESCONF] = 0x02500111;
     s->regs[GEM_DESCONF2] = 0x2ab13fff;
     s->regs[GEM_DESCONF5] = 0x002f2045;
-    s->regs[GEM_DESCONF6] = 0x00000200;
+    s->regs[GEM_DESCONF6] = 0x0;
+
+    queues_mask = MAKE_64BIT_MASK(1, s->num_priority_queues - 1);
+    s->regs[GEM_DESCONF6] |= queues_mask;
 
     /* Set MAC address */
     a = &s->conf.macaddr.a[0];
-- 
2.19.0

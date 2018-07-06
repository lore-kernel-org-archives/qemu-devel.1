Received: from eggs.gnu.org ([2001:4830:134:3::10]:56770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fbUlN-0006iX-0X
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fbUlM-0000y2-6j
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:43:21 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fbUlL-0000wE-La
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 13:43:19 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  6 Jul 2018 18:43:09 +0100
Message-Id: <20180706174309.27110-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0] hw/net/dp8393x: don't make prom region
 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Jason Wang <jasowang@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <aleksandar.markovic@mips.com>

Currently we use memory_region_init_rom_nomigrate() to create
the "dp3893x-prom" memory region, and we don't manually register
it with vmstate_register_ram(). This currently means that its
contents are migrated but as a ram block whose name is the empty
string; in future it may mean they are not migrated at all. Use
memory_region_init_ram() instead.

Note that this is a a cross-version migration compatibility break
for the MIPS "magnum" and "pica61" machines.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is I think the last device that creates a RAM memory
region and never registers it for migration.  Only used on
the MIPS 'jazz' boards.

 hw/net/dp8393x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index f2d2ce344cc..b53fcaa8bc3 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -887,7 +887,7 @@ static void dp8393x_realize(DeviceState *dev, Error **errp)
     s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
     s->regs[SONIC_SR] = 0x0004; /* only revision recognized by Linux */
 
-    memory_region_init_ram_nomigrate(&s->prom, OBJECT(dev),
+    memory_region_init_ram(&s->prom, OBJECT(dev),
                            "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.17.1

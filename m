Received: from eggs.gnu.org ([2001:4830:134:3::10]:49777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7d5y-0002ox-6A
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7d5s-00057k-4J
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:00:54 -0400
Received: from ozlabs.ru ([107.173.13.209]:40202)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1e7d5r-00057K-Tn
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:00:48 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu, 26 Oct 2017 19:00:41 +1100
Message-Id: <20171026080041.8280-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] isa-bus: Replace assert() about DMA with
 error report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

Running "qemu-system-ppc64 -machine prep -device i82374" creates an ISA
bus with two i82374 DMA controllers - one is implicit from ppc_prep_init(),
the other one is from "-device i82374". QEMU asserts but it is not
immediately clear why.

This adds an error message to explain the failure.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---


Better phase suggestions are welcome. Thanks!


---
 hw/isa/isa-bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 348e0eab9d..553707b18d 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -107,7 +107,10 @@ void isa_connect_gpio_out(ISADevice *isadev, int gpioirq, int isairq)
 void isa_bus_dma(ISABus *bus, IsaDma *dma8, IsaDma *dma16)
 {
     assert(bus && dma8 && dma16);
-    assert(!bus->dma[0] && !bus->dma[1]);
+    if (bus->dma[0] || bus->dma[1]) {
+        error_setg(&error_fatal,
+                   "DMA is already set to ISA bus, duplicated DMA controller?");
+    }
     bus->dma[0] = dma8;
     bus->dma[1] = dma16;
 }
-- 
2.11.0

Received: from eggs.gnu.org ([2001:4830:134:3::10]:37249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUP-00043U-Kg
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUO-0005g1-TU
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:49 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44580)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frhUO-0005fg-M6
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:32:48 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1frhUN-0003F4-Ps
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:32:47 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 11:32:10 +0100
Message-Id: <20180820103212.2810-24-peter.maydell@linaro.org>
In-Reply-To: <20180820103212.2810-1-peter.maydell@linaro.org>
References: <20180820103212.2810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/25] hw/dma/pl080: Provide device reset
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The PL080/PL081 model is missing a reset function; implement it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/dma/pl080.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 8f9f3e08d9a..a7aacad74f0 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -348,6 +348,30 @@ static const MemoryRegionOps pl080_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static void pl080_reset(DeviceState *dev)
+{
+    PL080State *s = PL080(dev);
+    int i;
+
+    s->tc_int = 0;
+    s->tc_mask = 0;
+    s->err_int = 0;
+    s->err_mask = 0;
+    s->conf = 0;
+    s->sync = 0;
+    s->req_single = 0;
+    s->req_burst = 0;
+    s->running = 0;
+
+    for (i = 0; i < s->nchannels; i++) {
+        s->chan[i].src = 0;
+        s->chan[i].dest = 0;
+        s->chan[i].lli = 0;
+        s->chan[i].ctrl = 0;
+        s->chan[i].conf = 0;
+    }
+}
+
 static void pl080_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
@@ -393,6 +417,7 @@ static void pl080_class_init(ObjectClass *oc, void *data)
     dc->vmsd = &vmstate_pl080;
     dc->realize = pl080_realize;
     dc->props = pl080_properties;
+    dc->reset = pl080_reset;
 }
 
 static const TypeInfo pl080_info = {
-- 
2.18.0

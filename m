Received: from eggs.gnu.org ([2001:4830:134:3::10]:60743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfU-0001bS-Ay
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfT-0006DC-7K
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:36 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfS-0006Bk-Un
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:35 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfL-0003d8-Pz
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:27 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:45 +0100
Message-Id: <20180615142521.19143-8-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/43] hw/input/pckbd: Convert away from old_mmio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Convert the pckbd device away from using the old_mmio field
of MemoryRegionOps. This change only affects the memory-mapped
variant of the i8042, which is used by the Unicore32 'puv3'
board and the MIPS Jazz boards 'magnum' and 'pica61'.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180601141223.26630-6-peter.maydell@linaro.org
---
 hw/input/pckbd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index f17f18e51b3..f33e3fc63d6 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -434,7 +434,7 @@ static const VMStateDescription vmstate_kbd = {
 };
 
 /* Memory mapped interface */
-static uint32_t kbd_mm_readb (void *opaque, hwaddr addr)
+static uint64_t kbd_mm_readfn(void *opaque, hwaddr addr, unsigned size)
 {
     KBDState *s = opaque;
 
@@ -444,7 +444,8 @@ static uint32_t kbd_mm_readb (void *opaque, hwaddr addr)
         return kbd_read_data(s, 0, 1) & 0xff;
 }
 
-static void kbd_mm_writeb (void *opaque, hwaddr addr, uint32_t value)
+static void kbd_mm_writefn(void *opaque, hwaddr addr,
+                           uint64_t value, unsigned size)
 {
     KBDState *s = opaque;
 
@@ -454,12 +455,13 @@ static void kbd_mm_writeb (void *opaque, hwaddr addr, uint32_t value)
         kbd_write_data(s, 0, value & 0xff, 1);
 }
 
+
 static const MemoryRegionOps i8042_mmio_ops = {
+    .read = kbd_mm_readfn,
+    .write = kbd_mm_writefn,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
     .endianness = DEVICE_NATIVE_ENDIAN,
-    .old_mmio = {
-        .read = { kbd_mm_readb, kbd_mm_readb, kbd_mm_readb },
-        .write = { kbd_mm_writeb, kbd_mm_writeb, kbd_mm_writeb },
-    },
 };
 
 void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
-- 
2.17.1

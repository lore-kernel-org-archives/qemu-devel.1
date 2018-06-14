Received: from eggs.gnu.org ([2001:4830:134:3::10]:55135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTWYt-0006zA-24
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTWYr-0000PE-JP
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:01:31 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:44433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTWYr-0000PA-Eu
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 14:01:29 -0400
Received: by mail-qk0-x242.google.com with SMTP id 185-v6so4134963qkk.11
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 11:01:29 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Jun 2018 15:01:18 -0300
Message-Id: <20180614180119.1704-2-f4bug@amsat.org>
In-Reply-To: <20180614180119.1704-1-f4bug@amsat.org>
References: <20180614180119.1704-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 1/2] hw/isa/smc37c669-superio: Basic
 'Config Registers' implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

The Config Register 0..3 are used by the BIOS to enable functionalities.

    The FDC37C669 incorporates Software Configurable Logic (SCL)
    for ease of use. Use of the SCL feature allows programmable
    system configuration of key functions such as the FDC,
    parallel port, and UARTs.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/isa/smc37c669-superio.c | 73 +++++++++++++++++++++++++++++++++-----
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/hw/isa/smc37c669-superio.c b/hw/isa/smc37c669-superio.c
index aa233c6967..49d0984ad9 100644
--- a/hw/isa/smc37c669-superio.c
+++ b/hw/isa/smc37c669-superio.c
@@ -6,16 +6,37 @@
  * This code is licensed under the GNU GPLv2 and later.
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Data Sheet (Rev. 06/29/2007):
+ * http://ww1.microchip.com/downloads/en/DeviceDoc/37c669.pdf
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
 #include "hw/isa/superio.h"
+#include "trace.h"
+
+#define SMC37C669(obj) \
+            OBJECT_CHECK(SMC37C669State, (obj), TYPE_SMC37C669_SUPERIO)
+
+typedef struct SMC37C669State {
+    /*< private >*/
+    ISASuperIODevice parent_dev;
+    /*< public >*/
+
+    uint32_t config; /* initial configuration */
+
+    uint8_t cr[4];
+} SMC37C669State;
 
-/* UARTs (compatible with NS16450 or PC16550) */
+/* UARTs (NS16C550 compatible) */
 
 static bool is_serial_enabled(ISASuperIODevice *sio, uint8_t index)
 {
-    return index < 2;
+    SMC37C669State *s = SMC37C669(sio);
+
+    return extract32(s->cr[2], 3 + index * 4, 1);
 }
 
 static uint16_t get_serial_iobase(ISASuperIODevice *sio, uint8_t index)
@@ -28,11 +49,13 @@ static unsigned int get_serial_irq(ISASuperIODevice *sio, uint8_t index)
     return index ? 3 : 4;
 }
 
-/* Parallel port */
+/* Parallel port (EPP and ECP support) */
 
 static bool is_parallel_enabled(ISASuperIODevice *sio, uint8_t index)
 {
-    return index < 1;
+    SMC37C669State *s = SMC37C669(sio);
+
+    return extract32(s->cr[1], 2, 1);
 }
 
 static uint16_t get_parallel_iobase(ISASuperIODevice *sio, uint8_t index)
@@ -50,11 +73,13 @@ static unsigned int get_parallel_dma(ISASuperIODevice *sio, uint8_t index)
     return 3;
 }
 
-/* Diskette controller (Software compatible with the Intel PC8477) */
+/* Diskette controller (Intel 82077 compatible) */
 
 static bool is_fdc_enabled(ISASuperIODevice *sio, uint8_t index)
 {
-    return index < 1;
+    SMC37C669State *s = SMC37C669(sio);
+
+    return extract32(s->cr[0], 3, 1);
 }
 
 static uint16_t get_fdc_iobase(ISASuperIODevice *sio, uint8_t index)
@@ -72,10 +97,43 @@ static unsigned int get_fdc_dma(ISASuperIODevice *sio, uint8_t index)
     return 2;
 }
 
+static void smc37c669_reset(DeviceState *d)
+{
+    SMC37C669State *s = SMC37C669(d);
+
+    stl_he_p(s->cr, s->config);
+}
+
+static void smc37c669_realize(DeviceState *dev, Error **errp)
+{
+    ISASuperIOClass *sc = ISA_SUPERIO_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    smc37c669_reset(dev);
+
+    sc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static Property smc37c669_properties[] = {
+    DEFINE_PROP_UINT32("config", SMC37C669State, config, 0x78889c28),
+    DEFINE_PROP_BIT("parallel", SMC37C669State, config, 8 + 2, true),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void smc37c669_class_init(ObjectClass *klass, void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(klass);
     ISASuperIOClass *sc = ISA_SUPERIO_CLASS(klass);
 
+    sc->parent_realize = dc->realize;
+    dc->realize = smc37c669_realize;
+    dc->reset = smc37c669_reset;
+    dc->props = smc37c669_properties;
+
     sc->parallel = (ISASuperIOFuncs){
         .count = 1,
         .is_enabled = is_parallel_enabled,
@@ -96,13 +154,12 @@ static void smc37c669_class_init(ObjectClass *klass, void *data)
         .get_irq    = get_fdc_irq,
         .get_dma    = get_fdc_dma,
     };
-    sc->ide.count = 0;
 }
 
 static const TypeInfo smc37c669_type_info = {
     .name          = TYPE_SMC37C669_SUPERIO,
     .parent        = TYPE_ISA_SUPERIO,
-    .instance_size = sizeof(ISASuperIODevice),
+    .instance_size = sizeof(SMC37C669State),
     .class_size    = sizeof(ISASuperIOClass),
     .class_init    = smc37c669_class_init,
 };
-- 
2.17.1

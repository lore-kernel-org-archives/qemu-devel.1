Received: from eggs.gnu.org ([2001:4830:134:3::10]:52078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcoN-0005q7-UB
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ehcoK-0002oU-1F
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:59:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ehcoJ-0002o5-PX
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:59:27 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  2 Feb 2018 08:50:09 +0100
Message-Id: <20180202075009.11653-3-kraxel@redhat.com>
In-Reply-To: <20180202075009.11653-1-kraxel@redhat.com>
References: <20180202075009.11653-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] hw/audio/sb16.c: change dolog() to
 qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>

From: John Arbuckle <programmingkidx@gmail.com>

Changes all the occurrances of dolog() to qemu_log_mask().

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
Message-id: 20180201172744.7504-1-programmingkidx@gmail.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/sb16.c | 79 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 6ab2f6f89a..31de264ab7 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -29,6 +29,8 @@
 #include "hw/qdev.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
 
 #define dolog(...) AUD_log ("sb16", __VA_ARGS__)
 
@@ -123,7 +125,7 @@ static int magic_of_irq (int irq)
     case 10:
         return 8;
     default:
-        dolog ("bad irq %d\n", irq);
+        qemu_log_mask(LOG_GUEST_ERROR, "bad irq %d\n", irq);
         return 2;
     }
 }
@@ -140,7 +142,7 @@ static int irq_of_magic (int magic)
     case 8:
         return 10;
     default:
-        dolog ("bad irq magic %d\n", magic);
+        qemu_log_mask(LOG_GUEST_ERROR, "bad irq magic %d\n", magic);
         return -1;
     }
 }
@@ -258,8 +260,8 @@ static void dma_cmd8 (SB16State *s, int mask, int dma_len)
     s->align = (1 << s->fmt_stereo) - 1;
 
     if (s->block_size & s->align) {
-        dolog ("warning: misaligned block size %d, alignment %d\n",
-               s->block_size, s->align + 1);
+        qemu_log_mask(LOG_GUEST_ERROR, "warning: misaligned block size %d,"
+                      " alignment %d\n", s->block_size, s->align + 1);
     }
 
     ldebug ("freq %d, stereo %d, sign %d, bits %d, "
@@ -338,8 +340,8 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
     s->highspeed = 0;
     s->align = (1 << (s->fmt_stereo + (s->fmt_bits == 16))) - 1;
     if (s->block_size & s->align) {
-        dolog ("warning: misaligned block size %d, alignment %d\n",
-               s->block_size, s->align + 1);
+        qemu_log_mask(LOG_GUEST_ERROR, "warning: misaligned block size %d,"
+                      " alignment %d\n", s->block_size, s->align + 1);
     }
 
     if (s->freq) {
@@ -391,7 +393,8 @@ static void command (SB16State *s, uint8_t cmd)
 
     if (cmd > 0xaf && cmd < 0xd0) {
         if (cmd & 8) {
-            dolog ("ADC not yet supported (command %#x)\n", cmd);
+            qemu_log_mask(LOG_UNIMP, "ADC not yet supported (command %#x)\n",
+                          cmd);
         }
 
         switch (cmd >> 4) {
@@ -399,7 +402,7 @@ static void command (SB16State *s, uint8_t cmd)
         case 12:
             break;
         default:
-            dolog ("%#x wrong bits\n", cmd);
+            qemu_log_mask(LOG_GUEST_ERROR, "%#x wrong bits\n", cmd);
         }
         s->needed_bytes = 3;
     }
@@ -453,7 +456,7 @@ static void command (SB16State *s, uint8_t cmd)
             goto warn;
 
         case 0x35:
-            dolog ("0x35 - MIDI command not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "0x35 - MIDI command not implemented\n");
             break;
 
         case 0x40:
@@ -487,34 +490,38 @@ static void command (SB16State *s, uint8_t cmd)
 
         case 0x74:
             s->needed_bytes = 2; /* DMA DAC, 4-bit ADPCM */
-            dolog ("0x75 - DMA DAC, 4-bit ADPCM not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "0x75 - DMA DAC, 4-bit ADPCM not"
+                          " implemented\n");
             break;
 
         case 0x75:              /* DMA DAC, 4-bit ADPCM Reference */
             s->needed_bytes = 2;
-            dolog ("0x74 - DMA DAC, 4-bit ADPCM Reference not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "0x74 - DMA DAC, 4-bit ADPCM Reference not"
+                          " implemented\n");
             break;
 
         case 0x76:              /* DMA DAC, 2.6-bit ADPCM */
             s->needed_bytes = 2;
-            dolog ("0x74 - DMA DAC, 2.6-bit ADPCM not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "0x74 - DMA DAC, 2.6-bit ADPCM not"
+                          " implemented\n");
             break;
 
         case 0x77:              /* DMA DAC, 2.6-bit ADPCM Reference */
             s->needed_bytes = 2;
-            dolog ("0x74 - DMA DAC, 2.6-bit ADPCM Reference not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "0x74 - DMA DAC, 2.6-bit ADPCM Reference"
+                          " not implemented\n");
             break;
 
         case 0x7d:
-            dolog ("0x7d - Autio-Initialize DMA DAC, 4-bit ADPCM Reference\n");
-            dolog ("not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "0x7d - Autio-Initialize DMA DAC, 4-bit"
+                          " ADPCM Reference\n");
+            qemu_log_mask(LOG_UNIMP, "not implemented\n");
             break;
 
         case 0x7f:
-            dolog (
-                "0x7d - Autio-Initialize DMA DAC, 2.6-bit ADPCM Reference\n"
-                );
-            dolog ("not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "0x7d - Autio-Initialize DMA DAC, 2.6-bit"
+                          " ADPCM Reference\n");
+            qemu_log_mask(LOG_UNIMP, "not implemented\n");
             break;
 
         case 0x80:
@@ -586,7 +593,7 @@ static void command (SB16State *s, uint8_t cmd)
             break;
 
         case 0xe7:
-            dolog ("Attempt to probe for ESS (0xe7)?\n");
+            qemu_log_mask(LOG_UNIMP, "Attempt to probe for ESS (0xe7)?\n");
             break;
 
         case 0xe8:              /* read test reg */
@@ -613,7 +620,7 @@ static void command (SB16State *s, uint8_t cmd)
             goto warn;
 
         default:
-            dolog ("Unrecognized command %#x\n", cmd);
+            qemu_log_mask(LOG_UNIMP, "Unrecognized command %#x\n", cmd);
             break;
         }
     }
@@ -632,8 +639,8 @@ static void command (SB16State *s, uint8_t cmd)
     return;
 
  warn:
-    dolog ("warning: command %#x,%d is not truly understood yet\n",
-           cmd, s->needed_bytes);
+    qemu_log_mask(LOG_UNIMP, "warning: command %#x,%d is not truly understood"
+                  " yet\n", cmd, s->needed_bytes);
     goto exit;
 
 }
@@ -735,9 +742,8 @@ static void complete (SB16State *s)
             break;
 
         case 0x42:              /* FT2 sets output freq with this, go figure */
-#if 0
-            dolog ("cmd 0x42 might not do what it think it should\n");
-#endif
+            qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
+                          " should\n");
         case 0x41:
             s->freq = dsp_get_hilo (s);
             ldebug ("set freq %d\n", s->freq);
@@ -820,7 +826,8 @@ static void complete (SB16State *s)
             break;
 
         default:
-            dolog ("complete: unrecognized command %#x\n", s->cmd);
+            qemu_log_mask(LOG_UNIMP, "complete: unrecognized command %#x\n",
+                          s->cmd);
             return;
         }
     }
@@ -1095,10 +1102,9 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
             dma = ctz32 (val & 0xf);
             hdma = ctz32 (val & 0xf0);
             if (dma != s->dma || hdma != s->hdma) {
-                dolog (
-                    "attempt to change DMA "
-                    "8bit %d(%d), 16bit %d(%d) (val=%#x)\n",
-                    dma, s->dma, hdma, s->hdma, val);
+                qemu_log_mask(LOG_GUEST_ERROR, "attempt to change DMA 8bit"
+                              " %d(%d), 16bit %d(%d) (val=%#x)\n", dma, s->dma,
+                              hdma, s->hdma, val);
             }
 #if 0
             s->dma = dma;
@@ -1108,8 +1114,8 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
         break;
 
     case 0x82:
-        dolog ("attempt to write into IRQ status register (val=%#x)\n",
-               val);
+        qemu_log_mask(LOG_GUEST_ERROR, "attempt to write into IRQ status"
+                      " register (val=%#x)\n", val);
         return;
 
     default:
@@ -1181,8 +1187,9 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     int till, copy, written, free;
 
     if (s->block_size <= 0) {
-        dolog ("invalid block size=%d nchan=%d dma_pos=%d dma_len=%d\n",
-               s->block_size, nchan, dma_pos, dma_len);
+        qemu_log_mask(LOG_GUEST_ERROR, "invalid block size=%d nchan=%d"
+                      " dma_pos=%d dma_len=%d\n", s->block_size, nchan,
+                      dma_pos, dma_len);
         return dma_pos;
     }
 
@@ -1376,7 +1383,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     reset_mixer (s);
     s->aux_ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, aux_timer, s);
     if (!s->aux_ts) {
-        dolog ("warning: Could not create auxiliary timer\n");
+        error_setg(errp, "warning: Could not create auxiliary timer");
     }
 
     isa_register_portio_list(isadev, &s->portio_list, s->port,
-- 
2.9.3

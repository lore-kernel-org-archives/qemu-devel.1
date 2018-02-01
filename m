Received: from eggs.gnu.org ([2001:4830:134:3::10]:32892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ehF05-00019N-FB
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1ehF02-0003hZ-2H
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:34:01 -0500
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:35186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1ehF01-0003hJ-Re
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:33:57 -0500
Received: by mail-io0-x241.google.com with SMTP id m11so19182974iob.2
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 05:33:57 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  1 Feb 2018 08:33:47 -0500
Message-Id: <20180201133347.3146-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/audio/sb16.c: change dolog() to
 qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, kraxel@redhat.com
Cc: John Arbuckle <programmingkidx@gmail.com>

Changes all the occurrances of dolog() to qemu_log_mask().

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 hw/audio/sb16.c | 105 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 53 insertions(+), 52 deletions(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 6ab2f6f89a..d32c568650 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -29,6 +29,7 @@
 #include "hw/qdev.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
+#include "qemu/log.h"
 
 #define dolog(...) AUD_log ("sb16", __VA_ARGS__)
 
@@ -123,7 +124,7 @@ static int magic_of_irq (int irq)
     case 10:
         return 8;
     default:
-        dolog ("bad irq %d\n", irq);
+        qemu_log_mask(LOG_UNIMP, "bad irq %d\n", irq);
         return 2;
     }
 }
@@ -140,7 +141,7 @@ static int irq_of_magic (int magic)
     case 8:
         return 10;
     default:
-        dolog ("bad irq magic %d\n", magic);
+        qemu_log_mask(LOG_UNIMP, "bad irq magic %d\n", magic);
         return -1;
     }
 }
@@ -258,8 +259,8 @@ static void dma_cmd8 (SB16State *s, int mask, int dma_len)
     s->align = (1 << s->fmt_stereo) - 1;
 
     if (s->block_size & s->align) {
-        dolog ("warning: misaligned block size %d, alignment %d\n",
-               s->block_size, s->align + 1);
+        qemu_log_mask(LOG_UNIMP, "warning: misaligned block size %d, alignment"
+                      " %d\n", s->block_size, s->align + 1);
     }
 
     ldebug ("freq %d, stereo %d, sign %d, bits %d, "
@@ -338,8 +339,8 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
     s->highspeed = 0;
     s->align = (1 << (s->fmt_stereo + (s->fmt_bits == 16))) - 1;
     if (s->block_size & s->align) {
-        dolog ("warning: misaligned block size %d, alignment %d\n",
-               s->block_size, s->align + 1);
+        qemu_log_mask(LOG_UNIMP, "warning: misaligned block size %d, alignment"
+                      " %d\n", s->block_size, s->align + 1);
     }
 
     if (s->freq) {
@@ -380,7 +381,7 @@ static inline uint8_t dsp_get_data (SB16State *s)
         return s->in2_data[--s->in_index];
     }
     else {
-        dolog ("buffer underflow\n");
+        qemu_log_mask(LOG_UNIMP, "buffer underflow\n");
         return 0;
     }
 }
@@ -391,7 +392,8 @@ static void command (SB16State *s, uint8_t cmd)
 
     if (cmd > 0xaf && cmd < 0xd0) {
         if (cmd & 8) {
-            dolog ("ADC not yet supported (command %#x)\n", cmd);
+            qemu_log_mask(LOG_UNIMP, "ADC not yet supported (command %#x)\n",
+                          cmd);
         }
 
         switch (cmd >> 4) {
@@ -399,7 +401,7 @@ static void command (SB16State *s, uint8_t cmd)
         case 12:
             break;
         default:
-            dolog ("%#x wrong bits\n", cmd);
+            qemu_log_mask(LOG_UNIMP, "%#x wrong bits\n", cmd);
         }
         s->needed_bytes = 3;
     }
@@ -453,7 +455,7 @@ static void command (SB16State *s, uint8_t cmd)
             goto warn;
 
         case 0x35:
-            dolog ("0x35 - MIDI command not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "0x35 - MIDI command not implemented\n");
             break;
 
         case 0x40:
@@ -487,34 +489,38 @@ static void command (SB16State *s, uint8_t cmd)
 
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
@@ -586,7 +592,7 @@ static void command (SB16State *s, uint8_t cmd)
             break;
 
         case 0xe7:
-            dolog ("Attempt to probe for ESS (0xe7)?\n");
+            qemu_log_mask(LOG_UNIMP, "Attempt to probe for ESS (0xe7)?\n");
             break;
 
         case 0xe8:              /* read test reg */
@@ -613,7 +619,7 @@ static void command (SB16State *s, uint8_t cmd)
             goto warn;
 
         default:
-            dolog ("Unrecognized command %#x\n", cmd);
+            qemu_log_mask(LOG_UNIMP, "Unrecognized command %#x\n", cmd);
             break;
         }
     }
@@ -632,8 +638,8 @@ static void command (SB16State *s, uint8_t cmd)
     return;
 
  warn:
-    dolog ("warning: command %#x,%d is not truly understood yet\n",
-           cmd, s->needed_bytes);
+    qemu_log_mask(LOG_UNIMP, "warning: command %#x,%d is not truly understood"
+                  " yet\n", cmd, s->needed_bytes);
     goto exit;
 
 }
@@ -664,8 +670,8 @@ static void complete (SB16State *s)
         d0 = dsp_get_data (s);
 
         if (s->cmd & 8) {
-            dolog ("ADC params cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
-                   s->cmd, d0, d1, d2);
+            qemu_log_mask(LOG_UNIMP, "ADC params cmd = %#x d0 = %d, d1 = %d,"
+                          " d2 = %d\n", s->cmd, d0, d1, d2);
         }
         else {
             ldebug ("cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
@@ -722,7 +728,7 @@ static void complete (SB16State *s)
 
         case 0x10:
             d0 = dsp_get_data (s);
-            dolog ("cmd 0x10 d0=%#x\n", d0);
+            qemu_log_mask(LOG_UNIMP, "cmd 0x10 d0=%#x\n", d0);
             break;
 
         case 0x14:
@@ -735,9 +741,8 @@ static void complete (SB16State *s)
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
@@ -787,10 +792,8 @@ static void complete (SB16State *s)
             break;
 
         case 0xe2:
-#ifdef DEBUG
             d0 = dsp_get_data (s);
-            dolog ("E2 = %#x\n", d0);
-#endif
+            qemu_log_mask(LOG_UNIMP, "E2 = %#x\n", d0);
             break;
 
         case 0xe4:
@@ -820,7 +823,8 @@ static void complete (SB16State *s)
             break;
 
         default:
-            dolog ("complete: unrecognized command %#x\n", s->cmd);
+            qemu_log_mask(LOG_UNIMP, "complete: unrecognized command %#x\n",
+                          s->cmd);
             return;
         }
     }
@@ -939,7 +943,7 @@ static void dsp_write(void *opaque, uint32_t nport, uint32_t val)
         }
         else {
             if (s->in_index == sizeof (s->in2_data)) {
-                dolog ("in data overrun\n");
+                qemu_log_mask(LOG_UNIMP, "in data overrun\n");
             }
             else {
                 s->in2_data[s->in_index++] = val;
@@ -979,8 +983,8 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
         }
         else {
             if (s->cmd != -1) {
-                dolog ("empty output buffer for command %#x\n",
-                       s->cmd);
+                qemu_log_mask(LOG_UNIMP, "empty output buffer for command"
+                              " %#x\n", s->cmd);
             }
             retval = s->last_read_byte;
             /* goto error; */
@@ -992,7 +996,7 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
         break;
 
     case 0x0d:                  /* timer interrupt clear */
-        /* dolog ("timer interrupt clear\n"); */
+        /* qemu_log_mask(LOG_UNIMP, "timer interrupt clear\n"); */
         retval = 0;
         break;
 
@@ -1025,7 +1029,7 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
     return retval;
 
  error:
-    dolog ("warning: dsp_read %#x error\n", nport);
+    qemu_log_mask(LOG_UNIMP, "warning: dsp_read %#x error\n", nport);
     return 0xff;
 }
 
@@ -1095,10 +1099,9 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
             dma = ctz32 (val & 0xf);
             hdma = ctz32 (val & 0xf0);
             if (dma != s->dma || hdma != s->hdma) {
-                dolog (
-                    "attempt to change DMA "
-                    "8bit %d(%d), 16bit %d(%d) (val=%#x)\n",
-                    dma, s->dma, hdma, s->hdma, val);
+                qemu_log_mask(LOG_UNIMP, "attempt to change DMA 8bit %d(%d),"
+                              " 16bit %d(%d) (val=%#x)\n", dma, s->dma, hdma,
+                              s->hdma, val);
             }
 #if 0
             s->dma = dma;
@@ -1108,8 +1111,8 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
         break;
 
     case 0x82:
-        dolog ("attempt to write into IRQ status register (val=%#x)\n",
-               val);
+        qemu_log_mask(LOG_UNIMP, "attempt to write into IRQ status register"
+                      " (val=%#x)\n", val);
         return;
 
     default:
@@ -1181,8 +1184,8 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     int till, copy, written, free;
 
     if (s->block_size <= 0) {
-        dolog ("invalid block size=%d nchan=%d dma_pos=%d dma_len=%d\n",
-               s->block_size, nchan, dma_pos, dma_len);
+        qemu_log_mask(LOG_UNIMP, "invalid block size=%d nchan=%d dma_pos=%d"
+                      " dma_len=%d\n", s->block_size, nchan, dma_pos, dma_len);
         return dma_pos;
     }
 
@@ -1203,10 +1206,8 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     copy = free;
     till = s->left_till_irq;
 
-#ifdef DEBUG_SB16_MOST
-    dolog ("pos:%06d %d till:%d len:%d\n",
-           dma_pos, free, till, dma_len);
-#endif
+    qemu_log_mask(LOG_UNIMP, "pos:%06d %d till:%d len:%d\n", dma_pos, free,
+                  till, dma_len);
 
     if (till <= copy) {
         if (s->dma_auto == 0) {
@@ -1376,7 +1377,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     reset_mixer (s);
     s->aux_ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, aux_timer, s);
     if (!s->aux_ts) {
-        dolog ("warning: Could not create auxiliary timer\n");
+        qemu_log_mask(LOG_UNIMP, "warning: Could not create auxiliary timer\n");
     }
 
     isa_register_portio_list(isadev, &s->portio_list, s->port,
-- 
2.14.3 (Apple Git-98)

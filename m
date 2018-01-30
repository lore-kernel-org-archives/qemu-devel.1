Received: from eggs.gnu.org ([2001:4830:134:3::10]:36556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egOJn-0005zE-1C
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 00:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1egOJj-0000hG-KW
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 00:18:51 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:36443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1egOJj-0000go-Ca
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 00:18:47 -0500
Received: by mail-io0-x243.google.com with SMTP id l17so10076953ioc.3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 21:18:47 -0800 (PST)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Tue, 30 Jan 2018 00:18:37 -0500
Message-Id: <20180130051837.8725-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] hw/audio/sb16.c: Convert file to new logging
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kraxel@redhat.com, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Use the qemu_log_mask() function to log messages.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 hw/audio/sb16.c | 221 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 112 insertions(+), 109 deletions(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 6ab2f6f89a..bdb79aeafa 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -29,18 +29,12 @@
 #include "hw/qdev.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
+#include "qemu/log.h"
 
-#define dolog(...) AUD_log ("sb16", __VA_ARGS__)
 
 /* #define DEBUG */
 /* #define DEBUG_SB16_MOST */
 
-#ifdef DEBUG
-#define ldebug(...) dolog (__VA_ARGS__)
-#else
-#define ldebug(...)
-#endif
-
 static const char e3[] = "COPYRIGHT (C) CREATIVE TECHNOLOGY LTD, 1992.";
 
 #define TYPE_SB16 "sb16"
@@ -123,7 +117,7 @@ static int magic_of_irq (int irq)
     case 10:
         return 8;
     default:
-        dolog ("bad irq %d\n", irq);
+        qemu_log_mask(LOG_UNIMP, "bad irq %d\n", irq);
         return 2;
     }
 }
@@ -140,7 +134,7 @@ static int irq_of_magic (int magic)
     case 8:
         return 10;
     default:
-        dolog ("bad irq magic %d\n", magic);
+        qemu_log_mask(LOG_UNIMP, "bad irq magic %d\n", magic);
         return -1;
     }
 }
@@ -148,15 +142,16 @@ static int irq_of_magic (int magic)
 #if 0
 static void log_dsp (SB16State *dsp)
 {
-    ldebug ("%s:%s:%d:%s:dmasize=%d:freq=%d:const=%d:speaker=%d\n",
-            dsp->fmt_stereo ? "Stereo" : "Mono",
-            dsp->fmt_signed ? "Signed" : "Unsigned",
-            dsp->fmt_bits,
-            dsp->dma_auto ? "Auto" : "Single",
-            dsp->block_size,
-            dsp->freq,
-            dsp->time_const,
-            dsp->speaker);
+    qemu_log_mask(LOG_UNIMP, "%s:%s:%d:%s:dmasize=%d:freq=%d:const=%d:"
+                  "speaker=%d\n",
+                  dsp->fmt_stereo ? "Stereo" : "Mono",
+                  dsp->fmt_signed ? "Signed" : "Unsigned",
+                  dsp->fmt_bits,
+                  dsp->dma_auto ? "Auto" : "Single",
+                  dsp->block_size,
+                  dsp->freq,
+                  dsp->time_const,
+                  dsp->speaker);
 }
 #endif
 
@@ -173,7 +168,8 @@ static void control (SB16State *s, int hold)
     IsaDmaClass *k = ISADMA_GET_CLASS(isa_dma);
     s->dma_running = hold;
 
-    ldebug ("hold %d high %d dma %d\n", hold, s->use_hdma, dma);
+    qemu_log_mask(LOG_UNIMP, "hold %d high %d dma %d\n", hold, s->use_hdma,
+                  dma);
 
     if (hold) {
         k->hold_DREQ(isa_dma, dma);
@@ -258,14 +254,14 @@ static void dma_cmd8 (SB16State *s, int mask, int dma_len)
     s->align = (1 << s->fmt_stereo) - 1;
 
     if (s->block_size & s->align) {
-        dolog ("warning: misaligned block size %d, alignment %d\n",
-               s->block_size, s->align + 1);
+        qemu_log_mask(LOG_UNIMP, "warning: misaligned block size %d, alignment"
+                      " %d\n", s->block_size, s->align + 1);
     }
 
-    ldebug ("freq %d, stereo %d, sign %d, bits %d, "
-            "dma %d, auto %d, fifo %d, high %d\n",
-            s->freq, s->fmt_stereo, s->fmt_signed, s->fmt_bits,
-            s->block_size, s->dma_auto, s->fifo, s->highspeed);
+    qemu_log_mask(LOG_UNIMP, "freq %d, stereo %d, sign %d, bits %d, "
+                  "dma %d, auto %d, fifo %d, high %d\n",
+                  s->freq, s->fmt_stereo, s->fmt_signed, s->fmt_bits,
+                  s->block_size, s->dma_auto, s->fifo, s->highspeed);
 
     continue_dma8 (s);
     speaker (s, 1);
@@ -310,10 +306,10 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
         s->block_size <<= s->fmt_stereo;
     }
 
-    ldebug ("freq %d, stereo %d, sign %d, bits %d, "
-            "dma %d, auto %d, fifo %d, high %d\n",
-            s->freq, s->fmt_stereo, s->fmt_signed, s->fmt_bits,
-            s->block_size, s->dma_auto, s->fifo, s->highspeed);
+    qemu_log_mask(LOG_UNIMP, "freq %d, stereo %d, sign %d, bits %d, "
+                  "dma %d, auto %d, fifo %d, high %d\n",
+                  s->freq, s->fmt_stereo, s->fmt_signed, s->fmt_bits,
+                  s->block_size, s->dma_auto, s->fifo, s->highspeed);
 
     if (16 == s->fmt_bits) {
         if (s->fmt_signed) {
@@ -338,8 +334,8 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
     s->highspeed = 0;
     s->align = (1 << (s->fmt_stereo + (s->fmt_bits == 16))) - 1;
     if (s->block_size & s->align) {
-        dolog ("warning: misaligned block size %d, alignment %d\n",
-               s->block_size, s->align + 1);
+        qemu_log_mask(LOG_UNIMP, "warning: misaligned block size %d, alignment"
+                      " %d\n", s->block_size, s->align + 1);
     }
 
     if (s->freq) {
@@ -368,7 +364,7 @@ static void dma_cmd (SB16State *s, uint8_t cmd, uint8_t d0, int dma_len)
 
 static inline void dsp_out_data (SB16State *s, uint8_t val)
 {
-    ldebug ("outdata %#x\n", val);
+    qemu_log_mask(LOG_UNIMP, "outdata %#x\n", val);
     if ((size_t) s->out_data_len < sizeof (s->out_data)) {
         s->out_data[s->out_data_len++] = val;
     }
@@ -380,18 +376,19 @@ static inline uint8_t dsp_get_data (SB16State *s)
         return s->in2_data[--s->in_index];
     }
     else {
-        dolog ("buffer underflow\n");
+        qemu_log_mask(LOG_UNIMP, "buffer underflow\n");
         return 0;
     }
 }
 
 static void command (SB16State *s, uint8_t cmd)
 {
-    ldebug ("command %#x\n", cmd);
+    qemu_log_mask(LOG_UNIMP, "command %#x\n", cmd);
 
     if (cmd > 0xaf && cmd < 0xd0) {
         if (cmd & 8) {
-            dolog ("ADC not yet supported (command %#x)\n", cmd);
+            qemu_log_mask(LOG_UNIMP, "ADC not yet supported (command %#x)\n",
+                          cmd);
         }
 
         switch (cmd >> 4) {
@@ -399,7 +396,7 @@ static void command (SB16State *s, uint8_t cmd)
         case 12:
             break;
         default:
-            dolog ("%#x wrong bits\n", cmd);
+            qemu_log_mask(LOG_UNIMP, "%#x wrong bits\n", cmd);
         }
         s->needed_bytes = 3;
     }
@@ -453,7 +450,7 @@ static void command (SB16State *s, uint8_t cmd)
             goto warn;
 
         case 0x35:
-            dolog ("0x35 - MIDI command not implemented\n");
+            qemu_log_mask(LOG_UNIMP, "0x35 - MIDI command not implemented\n");
             break;
 
         case 0x40:
@@ -487,34 +484,37 @@ static void command (SB16State *s, uint8_t cmd)
 
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
+                          " ADPCM Reference\nnot implemented\n");
             break;
 
         case 0x80:
@@ -586,7 +586,7 @@ static void command (SB16State *s, uint8_t cmd)
             break;
 
         case 0xe7:
-            dolog ("Attempt to probe for ESS (0xe7)?\n");
+            qemu_log_mask(LOG_UNIMP, "Attempt to probe for ESS (0xe7)?\n");
             break;
 
         case 0xe8:              /* read test reg */
@@ -613,13 +613,13 @@ static void command (SB16State *s, uint8_t cmd)
             goto warn;
 
         default:
-            dolog ("Unrecognized command %#x\n", cmd);
+            qemu_log_mask(LOG_UNIMP, "Unrecognized command %#x\n", cmd);
             break;
         }
     }
 
     if (!s->needed_bytes) {
-        ldebug ("\n");
+        qemu_log_mask(LOG_UNIMP, "\n");
     }
 
  exit:
@@ -632,8 +632,8 @@ static void command (SB16State *s, uint8_t cmd)
     return;
 
  warn:
-    dolog ("warning: command %#x,%d is not truly understood yet\n",
-           cmd, s->needed_bytes);
+    qemu_log_mask(LOG_UNIMP, "warning: command %#x,%d is not truly understood"
+                  " yet\n", cmd, s->needed_bytes);
     goto exit;
 
 }
@@ -655,8 +655,8 @@ static uint16_t dsp_get_hilo (SB16State *s)
 static void complete (SB16State *s)
 {
     int d0, d1, d2;
-    ldebug ("complete command %#x, in_index %d, needed_bytes %d\n",
-            s->cmd, s->in_index, s->needed_bytes);
+    qemu_log_mask(LOG_UNIMP, "complete command %#x, in_index %d, needed_bytes"
+                  " %d\n", s->cmd, s->in_index, s->needed_bytes);
 
     if (s->cmd > 0xaf && s->cmd < 0xd0) {
         d2 = dsp_get_data (s);
@@ -664,12 +664,12 @@ static void complete (SB16State *s)
         d0 = dsp_get_data (s);
 
         if (s->cmd & 8) {
-            dolog ("ADC params cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
-                   s->cmd, d0, d1, d2);
+            qemu_log_mask(LOG_UNIMP, "ADC params cmd = %#x d0 = %d, d1 = %d,"
+                          " d2 = %d\n", s->cmd, d0, d1, d2);
         }
         else {
-            ldebug ("cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
-                    s->cmd, d0, d1, d2);
+            qemu_log_mask(LOG_UNIMP, "cmd = %#x d0 = %d, d1 = %d, d2 = %d\n",
+                          s->cmd, d0, d1, d2);
             dma_cmd (s, s->cmd, d0, d1 + (d2 << 8));
         }
     }
@@ -679,23 +679,24 @@ static void complete (SB16State *s)
             s->csp_mode = dsp_get_data (s);
             s->csp_reg83r = 0;
             s->csp_reg83w = 0;
-            ldebug ("CSP command 0x04: mode=%#x\n", s->csp_mode);
+            qemu_log_mask(LOG_UNIMP, "CSP command 0x04: mode=%#x\n",
+                          s->csp_mode);
             break;
 
         case 0x05:
             s->csp_param = dsp_get_data (s);
             s->csp_value = dsp_get_data (s);
-            ldebug ("CSP command 0x05: param=%#x value=%#x\n",
-                    s->csp_param,
-                    s->csp_value);
+            qemu_log_mask(LOG_UNIMP, "CSP command 0x05: param=%#x value=%#x\n",
+                          s->csp_param, s->csp_value);
             break;
 
         case 0x0e:
             d0 = dsp_get_data (s);
             d1 = dsp_get_data (s);
-            ldebug ("write CSP register %d <- %#x\n", d1, d0);
+            qemu_log_mask(LOG_UNIMP, "write CSP register %d <- %#x\n", d1, d0);
             if (d1 == 0x83) {
-                ldebug ("0x83[%d] <- %#x\n", s->csp_reg83r, d0);
+                qemu_log_mask(LOG_UNIMP, "0x83[%d] <- %#x\n", s->csp_reg83r,
+                              d0);
                 s->csp_reg83[s->csp_reg83r % 4] = d0;
                 s->csp_reg83r += 1;
             }
@@ -706,12 +707,11 @@ static void complete (SB16State *s)
 
         case 0x0f:
             d0 = dsp_get_data (s);
-            ldebug ("read CSP register %#x -> %#x, mode=%#x\n",
-                    d0, s->csp_regs[d0], s->csp_mode);
+            qemu_log_mask(LOG_UNIMP, "read CSP register %#x -> %#x, mode=%#x\n",
+                          d0, s->csp_regs[d0], s->csp_mode);
             if (d0 == 0x83) {
-                ldebug ("0x83[%d] -> %#x\n",
-                        s->csp_reg83w,
-                        s->csp_reg83[s->csp_reg83w % 4]);
+                qemu_log_mask(LOG_UNIMP, "0x83[%d] -> %#x\n",
+                              s->csp_reg83w, s->csp_reg83[s->csp_reg83w % 4]);
                 dsp_out_data (s, s->csp_reg83[s->csp_reg83w % 4]);
                 s->csp_reg83w += 1;
             }
@@ -722,7 +722,7 @@ static void complete (SB16State *s)
 
         case 0x10:
             d0 = dsp_get_data (s);
-            dolog ("cmd 0x10 d0=%#x\n", d0);
+            qemu_log_mask(LOG_UNIMP, "cmd 0x10 d0=%#x\n", d0);
             break;
 
         case 0x14:
@@ -731,21 +731,22 @@ static void complete (SB16State *s)
 
         case 0x40:
             s->time_const = dsp_get_data (s);
-            ldebug ("set time const %d\n", s->time_const);
+            qemu_log_mask(LOG_UNIMP, "set time const %d\n", s->time_const);
             break;
 
         case 0x42:              /* FT2 sets output freq with this, go figure */
 #if 0
-            dolog ("cmd 0x42 might not do what it think it should\n");
+            qemu_log_mask(LOG_UNIMP, "cmd 0x42 might not do what it think it"
+                          " should\n");
 #endif
         case 0x41:
             s->freq = dsp_get_hilo (s);
-            ldebug ("set freq %d\n", s->freq);
+            qemu_log_mask(LOG_UNIMP, "set freq %d\n", s->freq);
             break;
 
         case 0x48:
             s->block_size = dsp_get_lohi (s) + 1;
-            ldebug ("set dma block len %d\n", s->block_size);
+            qemu_log_mask(LOG_UNIMP, "set dma block len %d\n", s->block_size);
             break;
 
         case 0x74:
@@ -775,21 +776,22 @@ static void complete (SB16State *s)
                             );
                     }
                 }
-                ldebug ("mix silence %d %d %" PRId64 "\n", samples, bytes, ticks);
+                qemu_log_mask(LOG_UNIMP, "mix silence %d %d %" PRId64 "\n",
+                              samples, bytes, ticks);
             }
             break;
 
         case 0xe0:
             d0 = dsp_get_data (s);
             s->out_data_len = 0;
-            ldebug ("E0 data = %#x\n", d0);
+            qemu_log_mask(LOG_UNIMP, "E0 data = %#x\n", d0);
             dsp_out_data (s, ~d0);
             break;
 
         case 0xe2:
 #ifdef DEBUG
             d0 = dsp_get_data (s);
-            dolog ("E2 = %#x\n", d0);
+            qemu_log_mask(LOG_UNIMP, "E2 = %#x\n", d0);
 #endif
             break;
 
@@ -799,7 +801,7 @@ static void complete (SB16State *s)
 
         case 0xf9:
             d0 = dsp_get_data (s);
-            ldebug ("command 0xf9 with %#x\n", d0);
+            qemu_log_mask(LOG_UNIMP, "command 0xf9 with %#x\n", d0);
             switch (d0) {
             case 0x0e:
                 dsp_out_data (s, 0xff);
@@ -820,12 +822,13 @@ static void complete (SB16State *s)
             break;
 
         default:
-            dolog ("complete: unrecognized command %#x\n", s->cmd);
+            qemu_log_mask(LOG_UNIMP, "complete: unrecognized command %#x\n",
+                          s->cmd);
             return;
         }
     }
 
-    ldebug ("\n");
+    qemu_log_mask(LOG_UNIMP, "\n");
     s->cmd = -1;
 }
 
@@ -889,7 +892,7 @@ static void dsp_write(void *opaque, uint32_t nport, uint32_t val)
 
     iport = nport - s->port;
 
-    ldebug ("write %#x <- %#x\n", nport, val);
+    qemu_log_mask(LOG_UNIMP, "write %#x <- %#x\n", nport, val);
     switch (iport) {
     case 0x06:
         switch (val) {
@@ -939,7 +942,7 @@ static void dsp_write(void *opaque, uint32_t nport, uint32_t val)
         }
         else {
             if (s->in_index == sizeof (s->in2_data)) {
-                dolog ("in data overrun\n");
+                qemu_log_mask(LOG_UNIMP, "in data overrun\n");
             }
             else {
                 s->in2_data[s->in_index++] = val;
@@ -955,7 +958,7 @@ static void dsp_write(void *opaque, uint32_t nport, uint32_t val)
         break;
 
     default:
-        ldebug ("(nport=%#x, val=%#x)\n", nport, val);
+        qemu_log_mask(LOG_UNIMP, "(nport=%#x, val=%#x)\n", nport, val);
         break;
     }
 }
@@ -979,8 +982,8 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
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
@@ -992,7 +995,7 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
         break;
 
     case 0x0d:                  /* timer interrupt clear */
-        /* dolog ("timer interrupt clear\n"); */
+        /* qemu_log_mask(LOG_UNIMP, "timer interrupt clear\n"); */
         retval = 0;
         break;
 
@@ -1019,13 +1022,13 @@ static uint32_t dsp_read(void *opaque, uint32_t nport)
     }
 
     if (!ack) {
-        ldebug ("read %#x -> %#x\n", nport, retval);
+        qemu_log_mask(LOG_UNIMP, "read %#x -> %#x\n", nport, retval);
     }
 
     return retval;
 
  error:
-    dolog ("warning: dsp_read %#x error\n", nport);
+    qemu_log_mask(LOG_UNIMP, "warning: dsp_read %#x error\n", nport);
     return 0xff;
 }
 
@@ -1071,7 +1074,7 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
     SB16State *s = opaque;
 
     (void) nport;
-    ldebug ("mixer_write [%#x] <- %#x\n", s->mixer_nreg, val);
+    qemu_log_mask(LOG_UNIMP, "mixer_write [%#x] <- %#x\n", s->mixer_nreg, val);
 
     switch (s->mixer_nreg) {
     case 0x00:
@@ -1081,7 +1084,7 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
     case 0x80:
         {
             int irq = irq_of_magic (val);
-            ldebug ("setting irq to %d (val=%#x)\n", irq, val);
+            qemu_log_mask(LOG_UNIMP, "setting irq to %d (val=%#x)\n", irq, val);
             if (irq > 0) {
                 s->irq = irq;
             }
@@ -1095,10 +1098,9 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
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
@@ -1108,13 +1110,14 @@ static void mixer_write_datab(void *opaque, uint32_t nport, uint32_t val)
         break;
 
     case 0x82:
-        dolog ("attempt to write into IRQ status register (val=%#x)\n",
-               val);
+        qemu_log_mask(LOG_UNIMP, "attempt to write into IRQ status register"
+                      " (val=%#x)\n", val);
         return;
 
     default:
         if (s->mixer_nreg >= 0x80) {
-            ldebug ("attempt to write mixer[%#x] <- %#x\n", s->mixer_nreg, val);
+            qemu_log_mask(LOG_UNIMP, "attempt to write mixer[%#x] <- %#x\n",
+                          s->mixer_nreg, val);
         }
         break;
     }
@@ -1129,12 +1132,12 @@ static uint32_t mixer_read(void *opaque, uint32_t nport)
     (void) nport;
 #ifndef DEBUG_SB16_MOST
     if (s->mixer_nreg != 0x82) {
-        ldebug ("mixer_read[%#x] -> %#x\n",
-                s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
+        qemu_log_mask(LOG_UNIMP, "mixer_read[%#x] -> %#x\n", s->mixer_nreg,
+                      s->mixer_regs[s->mixer_nreg]);
     }
 #else
-    ldebug ("mixer_read[%#x] -> %#x\n",
-            s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
+    qemu_log_mask(LOG_UNIMP, "mixer_read[%#x] -> %#x\n",
+                  s->mixer_nreg, s->mixer_regs[s->mixer_nreg]);
 #endif
     return s->mixer_regs[s->mixer_nreg];
 }
@@ -1181,8 +1184,8 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     int till, copy, written, free;
 
     if (s->block_size <= 0) {
-        dolog ("invalid block size=%d nchan=%d dma_pos=%d dma_len=%d\n",
-               s->block_size, nchan, dma_pos, dma_len);
+        qemu_log_mask(LOG_UNIMP, "invalid block size=%d nchan=%d dma_pos=%d"
+                      " dma_len=%d\n", s->block_size, nchan, dma_pos, dma_len);
         return dma_pos;
     }
 
@@ -1204,8 +1207,8 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     till = s->left_till_irq;
 
 #ifdef DEBUG_SB16_MOST
-    dolog ("pos:%06d %d till:%d len:%d\n",
-           dma_pos, free, till, dma_len);
+    qemu_log_mask(LOG_UNIMP, "pos:%06d %d till:%d len:%d\n", dma_pos, free,
+                  till, dma_len);
 #endif
 
     if (till <= copy) {
@@ -1228,9 +1231,9 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     }
 
 #ifdef DEBUG_SB16_MOST
-    ldebug ("pos %5d free %5d size %5d till % 5d copy %5d written %5d size %5d\n",
-            dma_pos, free, dma_len, s->left_till_irq, copy, written,
-            s->block_size);
+    qemu_log_mask(LOG_UNIMP, "pos %5d free %5d size %5d till % 5d copy %5d"
+                  " written %5d size %5d\n", dma_pos, free, dma_len,
+                  s->left_till_irq, copy, written, s->block_size);
 #endif
 
     while (s->left_till_irq <= 0) {
@@ -1376,7 +1379,7 @@ static void sb16_realizefn (DeviceState *dev, Error **errp)
     reset_mixer (s);
     s->aux_ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, aux_timer, s);
     if (!s->aux_ts) {
-        dolog ("warning: Could not create auxiliary timer\n");
+        qemu_log_mask(LOG_UNIMP, "warning: Could not create auxiliary timer\n");
     }
 
     isa_register_portio_list(isadev, &s->portio_list, s->port,
-- 
2.14.3 (Apple Git-98)

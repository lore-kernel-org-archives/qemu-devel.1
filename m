Received: from eggs.gnu.org ([2001:4830:134:3::10]:47845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnT0-0000Vu-61
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSy-00071f-DF
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:42 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnSy-00071H-6K
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:40 -0500
Received: by mail-qt0-x242.google.com with SMTP id e2so3141618qti.0
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:08:40 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:07:57 -0300
Message-Id: <20180103180805.18140-10-f4bug@amsat.org>
In-Reply-To: <20180103180805.18140-1-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 09/17] sdhci: convert the DPRINT() calls
 into trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

zero-initialize ADMADescr 'dscr' in sdhci_do_adma() to avoid:

  hw/sd/sdhci.c: In function ‘sdhci_do_adma’:
  hw/sd/sdhci.c:714:29: error: ‘dscr.addr’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
             trace_sdhci_adma("link", s->admasysaddr);
                             ^

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c      | 89 ++++++++++++++++++------------------------------------
 hw/sd/trace-events | 14 +++++++++
 2 files changed, 44 insertions(+), 59 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 0e27dc3042..a781cc5211 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -33,30 +33,7 @@
 #include "sdhci-internal.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
-
-/* host controller debug messages */
-#ifndef SDHC_DEBUG
-#define SDHC_DEBUG                        0
-#endif
-
-#define DPRINT_L1(fmt, args...) \
-    do { \
-        if (SDHC_DEBUG) { \
-            fprintf(stderr, "QEMU SDHC: " fmt, ## args); \
-        } \
-    } while (0)
-#define DPRINT_L2(fmt, args...) \
-    do { \
-        if (SDHC_DEBUG > 1) { \
-            fprintf(stderr, "QEMU SDHC: " fmt, ## args); \
-        } \
-    } while (0)
-#define ERRPRINT(fmt, args...) \
-    do { \
-        if (SDHC_DEBUG) { \
-            fprintf(stderr, "QEMU SDHC ERROR: " fmt, ## args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 #define TYPE_SDHCI_BUS "sdhci-bus"
 #define SDHCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_SDHCI_BUS)
@@ -155,8 +132,8 @@ static void sdhci_raise_insertion_irq(void *opaque)
 static void sdhci_set_inserted(DeviceState *dev, bool level)
 {
     SDHCIState *s = (SDHCIState *)dev;
-    DPRINT_L1("Card state changed: %s!\n", level ? "insert" : "eject");
 
+    trace_sdhci_set_inserted(level ? "insert" : "eject");
     if ((s->norintsts & SDHC_NIS_REMOVE) && level) {
         /* Give target some time to notice card ejection */
         timer_mod(s->insert_timer,
@@ -238,7 +215,8 @@ static void sdhci_send_command(SDHCIState *s)
     s->acmd12errsts = 0;
     request.cmd = s->cmdreg >> 8;
     request.arg = s->argument;
-    DPRINT_L1("sending CMD%u ARG[0x%08x]\n", request.cmd, request.arg);
+
+    trace_sdhci_send_command(request.cmd, request.arg);
     rlen = sdbus_do_command(&s->sdbus, &request, response);
 
     if (s->cmdreg & SDHC_CMD_RESPONSE) {
@@ -246,7 +224,7 @@ static void sdhci_send_command(SDHCIState *s)
             s->rspreg[0] = (response[0] << 24) | (response[1] << 16) |
                            (response[2] << 8)  |  response[3];
             s->rspreg[1] = s->rspreg[2] = s->rspreg[3] = 0;
-            DPRINT_L1("Response: RSPREG[31..0]=0x%08x\n", s->rspreg[0]);
+            trace_sdhci_response4(s->rspreg[0]);
         } else if (rlen == 16) {
             s->rspreg[0] = (response[11] << 24) | (response[12] << 16) |
                            (response[13] << 8) |  response[14];
@@ -256,11 +234,10 @@ static void sdhci_send_command(SDHCIState *s)
                            (response[5] << 8)  |  response[6];
             s->rspreg[3] = (response[0] << 16) | (response[1] << 8) |
                             response[2];
-            DPRINT_L1("Response received:\n RSPREG[127..96]=0x%08x, RSPREG[95.."
-                  "64]=0x%08x,\n RSPREG[63..32]=0x%08x, RSPREG[31..0]=0x%08x\n",
-                  s->rspreg[3], s->rspreg[2], s->rspreg[1], s->rspreg[0]);
+            trace_sdhci_response16(s->rspreg[3], s->rspreg[2],
+                                   s->rspreg[1], s->rspreg[0]);
         } else {
-            ERRPRINT("Timeout waiting for command response\n");
+            trace_sdhci_error("timeout waiting for command response");
             if (s->errintstsen & SDHC_EISEN_CMDTIMEOUT) {
                 s->errintsts |= SDHC_EIS_CMDTIMEOUT;
                 s->norintsts |= SDHC_NIS_ERR;
@@ -294,7 +271,7 @@ static void sdhci_end_transfer(SDHCIState *s)
 
         request.cmd = 0x0C;
         request.arg = 0;
-        DPRINT_L1("Automatically issue CMD%d %08x\n", request.cmd, request.arg);
+        trace_sdhci_end_transfer(request.cmd, request.arg);
         sdbus_do_command(&s->sdbus, &request, response);
         /* Auto CMD12 response goes to the upper Response register */
         s->rspreg[3] = (response[0] << 24) | (response[1] << 16) |
@@ -363,7 +340,7 @@ static uint32_t sdhci_read_dataport(SDHCIState *s, unsigned size)
 
     /* first check that a valid data exists in host controller input buffer */
     if ((s->prnsts & SDHC_DATA_AVAILABLE) == 0) {
-        ERRPRINT("Trying to read from empty buffer\n");
+        trace_sdhci_error("read from empty buffer");
         return 0;
     }
 
@@ -372,8 +349,7 @@ static uint32_t sdhci_read_dataport(SDHCIState *s, unsigned size)
         s->data_count++;
         /* check if we've read all valid data (blksize bytes) from buffer */
         if ((s->data_count) >= (s->blksize & 0x0fff)) {
-            DPRINT_L2("All %u bytes of data have been read from input buffer\n",
-                    s->data_count);
+            trace_sdhci_read_dataport(s->data_count);
             s->prnsts &= ~SDHC_DATA_AVAILABLE; /* no more data in a buffer */
             s->data_count = 0;  /* next buff read must start at position [0] */
 
@@ -456,7 +432,7 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
 
     /* Check that there is free space left in a buffer */
     if (!(s->prnsts & SDHC_SPACE_AVAILABLE)) {
-        ERRPRINT("Can't write to data buffer: buffer full\n");
+        trace_sdhci_error("Can't write to data buffer: buffer full");
         return;
     }
 
@@ -465,8 +441,7 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
         s->data_count++;
         value >>= 8;
         if (s->data_count >= (s->blksize & 0x0fff)) {
-            DPRINT_L2("write buffer filled with %u bytes of data\n",
-                    s->data_count);
+            trace_sdhci_write_dataport(s->data_count);
             s->data_count = 0;
             s->prnsts &= ~SDHC_SPACE_AVAILABLE;
             if (s->prnsts & SDHC_DOING_WRITE) {
@@ -654,15 +629,14 @@ static void sdhci_do_adma(SDHCIState *s)
 {
     unsigned int n, begin, length;
     const uint16_t block_size = s->blksize & 0x0fff;
-    ADMADescr dscr;
+    ADMADescr dscr = {};
     int i;
 
     for (i = 0; i < SDHC_ADMA_DESCS_PER_DELAY; ++i) {
         s->admaerr &= ~SDHC_ADMAERR_LENGTH_MISMATCH;
 
         get_adma_description(s, &dscr);
-        DPRINT_L2("ADMA loop: addr=" TARGET_FMT_plx ", len=%d, attr=%x\n",
-                dscr.addr, dscr.length, dscr.attr);
+        trace_sdhci_adma_loop(dscr.addr, dscr.length, dscr.attr);
 
         if ((dscr.attr & SDHC_ADMA_ATTR_VALID) == 0) {
             /* Indicate that error occurred in ST_FDS state */
@@ -745,8 +719,7 @@ static void sdhci_do_adma(SDHCIState *s)
             break;
         case SDHC_ADMA_ATTR_ACT_LINK:   /* link to next descriptor table */
             s->admasysaddr = dscr.addr;
-            DPRINT_L1("ADMA link: admasysaddr=0x%" PRIx64 "\n",
-                      s->admasysaddr);
+            trace_sdhci_adma("link", s->admasysaddr);
             break;
         default:
             s->admasysaddr += dscr.incr;
@@ -754,8 +727,7 @@ static void sdhci_do_adma(SDHCIState *s)
         }
 
         if (dscr.attr & SDHC_ADMA_ATTR_INT) {
-            DPRINT_L1("ADMA interrupt: admasysaddr=0x%" PRIx64 "\n",
-                      s->admasysaddr);
+            trace_sdhci_adma("interrupt", s->admasysaddr);
             if (s->norintstsen & SDHC_NISEN_DMA) {
                 s->norintsts |= SDHC_NIS_DMA;
             }
@@ -766,15 +738,15 @@ static void sdhci_do_adma(SDHCIState *s)
         /* ADMA transfer terminates if blkcnt == 0 or by END attribute */
         if (((s->trnmod & SDHC_TRNS_BLK_CNT_EN) &&
                     (s->blkcnt == 0)) || (dscr.attr & SDHC_ADMA_ATTR_END)) {
-            DPRINT_L2("ADMA transfer completed\n");
+            trace_sdhci_adma_transfer_completed();
             if (length || ((dscr.attr & SDHC_ADMA_ATTR_END) &&
                 (s->trnmod & SDHC_TRNS_BLK_CNT_EN) &&
                 s->blkcnt != 0)) {
-                ERRPRINT("SD/MMC host ADMA length mismatch\n");
+                trace_sdhci_error("SD/MMC host ADMA length mismatch");
                 s->admaerr |= SDHC_ADMAERR_LENGTH_MISMATCH |
                         SDHC_ADMAERR_STATE_ST_TFR;
                 if (s->errintstsen & SDHC_EISEN_ADMAERR) {
-                    ERRPRINT("Set ADMA error flag\n");
+                    trace_sdhci_error("Set ADMA error flag");
                     s->errintsts |= SDHC_EIS_ADMAERR;
                     s->norintsts |= SDHC_NIS_ERR;
                 }
@@ -810,7 +782,7 @@ static void sdhci_data_transfer(void *opaque)
             break;
         case SDHC_CTRL_ADMA1_32:
             if (!(s->capareg & SDHC_CAN_DO_ADMA1)) {
-                ERRPRINT("ADMA1 not supported\n");
+                trace_sdhci_error("ADMA1 not supported");
                 break;
             }
 
@@ -818,7 +790,7 @@ static void sdhci_data_transfer(void *opaque)
             break;
         case SDHC_CTRL_ADMA2_32:
             if (!(s->capareg & SDHC_CAN_DO_ADMA2)) {
-                ERRPRINT("ADMA2 not supported\n");
+                trace_sdhci_error("ADMA2 not supported");
                 break;
             }
 
@@ -827,14 +799,14 @@ static void sdhci_data_transfer(void *opaque)
         case SDHC_CTRL_ADMA2_64:
             if (!(s->capareg & SDHC_CAN_DO_ADMA2) ||
                     !(s->capareg & SDHC_64_BIT_BUS_SUPPORT)) {
-                ERRPRINT("64 bit ADMA not supported\n");
+                trace_sdhci_error("64 bit ADMA not supported");
                 break;
             }
 
             sdhci_do_adma(s);
             break;
         default:
-            ERRPRINT("Unsupported DMA type\n");
+            trace_sdhci_error("Unsupported DMA type");
             break;
         }
     } else {
@@ -869,8 +841,8 @@ static inline bool
 sdhci_buff_access_is_sequential(SDHCIState *s, unsigned byte_num)
 {
     if ((s->data_count & 0x3) != byte_num) {
-        ERRPRINT("Non-sequential access to Buffer Data Port register"
-                "is prohibited\n");
+        trace_sdhci_error("Non-sequential access to Buffer Data Port register"
+                          "is prohibited\n");
         return false;
     }
     return true;
@@ -900,8 +872,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
     case  SDHC_BDATA:
         if (sdhci_buff_access_is_sequential(s, offset - SDHC_BDATA)) {
             ret = sdhci_read_dataport(s, size);
-            DPRINT_L2("read %ub: addr[0x%04x] -> %u(0x%x)\n", size, (int)offset,
-                      ret, ret);
+            trace_sdhci_access("read", size, offset, "->", ret, ret);
             return ret;
         }
         break;
@@ -953,7 +924,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
 
     ret >>= (offset & 0x3) * 8;
     ret &= (1ULL << (size * 8)) - 1;
-    DPRINT_L2("read %ub: addr[0x%04x] -> %u(0x%x)\n", size, (int)offset, ret, ret);
+    trace_sdhci_access("read", size, offset, "->", ret, ret);
     return ret;
 }
 
@@ -1157,8 +1128,8 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
                       "not implemented\n", size, offset, value >> shift);
         break;
     }
-    DPRINT_L2("write %ub: addr[0x%04x] <- %u(0x%x)\n",
-              size, (int)offset, value >> shift, value >> shift);
+    trace_sdhci_access("write", size, offset, "<-",
+                       value >> shift, value >> shift);
 }
 
 static const MemoryRegionOps sdhci_mmio_ops = {
diff --git a/hw/sd/trace-events b/hw/sd/trace-events
index 1fc0bcf44b..e4e26c6d73 100644
--- a/hw/sd/trace-events
+++ b/hw/sd/trace-events
@@ -1,5 +1,19 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# hw/sd/sdhci.c
+sdhci_set_inserted(const char *level) "card state changed: %s"
+sdhci_send_command(uint8_t cmd, uint32_t arg) "sending CMD%02u ARG[0x%08x]"
+sdhci_error(const char *msg) "%s"
+sdhci_response4(uint32_t r0) "Response: RSPREG[31..0]=0x%08x"
+sdhci_response16(uint32_t r3, uint32_t r2, uint32_t r1, uint32_t r0) "Response received: RSPREG[127..96]=0x%08x, RSPREG[95..64]=0x%08x, RSPREG[63..32]=0x%08x, RSPREG[31..0]=0x%08x"
+sdhci_end_transfer(uint8_t cmd, uint32_t arg) "Automatically issue CMD%02u 0x%08x"
+sdhci_adma(const char *desc, uint32_t sysad) "ADMA %s: admasysaddr=0x%" PRIx32
+sdhci_adma_loop(uint64_t addr, uint16_t length, uint8_t attr) "ADMA loop: addr=0x%08" PRIx64 ", len=%d, attr=0x%x"
+sdhci_adma_transfer_completed(void) "ADMA transfer completed"
+sdhci_access(const char *access, unsigned int size, uint64_t offset, const char *dir, uint64_t val, uint64_t val2) "%s %ub: addr[0x%04" PRIx64 "] %s %" PRIu64 "(0x%" PRIx64 ")"
+sdhci_read_dataport(uint16_t data_count) "all %u bytes of data have been read from input buffer"
+sdhci_write_dataport(uint16_t data_count) "write buffer filled with %u bytes of data"
+
 # hw/sd/milkymist-memcard.c
 milkymist_memcard_memory_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 milkymist_memcard_memory_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-- 
2.15.1

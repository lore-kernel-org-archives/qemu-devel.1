Received: from eggs.gnu.org ([2001:4830:134:3::10]:51710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnZcf-0000Hh-Vy
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnZce-0004jL-8O
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:15:45 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 31 Aug 2017 20:14:57 -0400
Message-Id: <20170901001502.29915-5-jsnow@redhat.com>
In-Reply-To: <20170901001502.29915-1-jsnow@redhat.com>
References: <20170901001502.29915-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/9] ATAPI: Replace DEBUG_IDE_ATAPI with
 tracing events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, f4bug@amsat.org, John Snow <jsnow@redhat.com>

As part of the ongoing effort to modernize the tracing facilities for
the IDE family of devices, remove PRINTFs in the ATAPI device with
actual tracing events.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/atapi.c            | 64 +++++++++++++++++------------------------------
 hw/ide/trace-events       | 15 +++++++++++
 include/hw/ide/internal.h |  1 -
 3 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index fc1d19c..9b84a1b 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -27,6 +27,7 @@
 #include "hw/ide/internal.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/block-backend.h"
+#include "trace.h"
 
 #define ATAPI_SECTOR_BITS (2 + BDRV_SECTOR_BITS)
 #define ATAPI_SECTOR_SIZE (1 << ATAPI_SECTOR_BITS)
@@ -116,9 +117,7 @@ cd_read_sector_sync(IDEState *s)
     block_acct_start(blk_get_stats(s->blk), &s->acct,
                      ATAPI_SECTOR_SIZE, BLOCK_ACCT_READ);
 
-#ifdef DEBUG_IDE_ATAPI
-    printf("cd_read_sector_sync: lba=%d\n", s->lba);
-#endif
+    trace_cd_read_sector_sync(s->lba);
 
     switch (s->cd_sector_size) {
     case 2048:
@@ -152,9 +151,7 @@ static void cd_read_sector_cb(void *opaque, int ret)
 {
     IDEState *s = opaque;
 
-#ifdef DEBUG_IDE_ATAPI
-    printf("cd_read_sector_cb: lba=%d ret=%d\n", s->lba, ret);
-#endif
+    trace_cd_read_sector_cb(s->lba, ret);
 
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->blk), &s->acct);
@@ -188,9 +185,7 @@ static int cd_read_sector(IDEState *s)
     s->iov.iov_len = ATAPI_SECTOR_SIZE;
     qemu_iovec_init_external(&s->qiov, &s->iov, 1);
 
-#ifdef DEBUG_IDE_ATAPI
-    printf("cd_read_sector: lba=%d\n", s->lba);
-#endif
+    trace_cd_read_sector(s->lba);
 
     block_acct_start(blk_get_stats(s->blk), &s->acct,
                      ATAPI_SECTOR_SIZE, BLOCK_ACCT_READ);
@@ -213,9 +208,7 @@ void ide_atapi_cmd_ok(IDEState *s)
 
 void ide_atapi_cmd_error(IDEState *s, int sense_key, int asc)
 {
-#ifdef DEBUG_IDE_ATAPI
-    printf("atapi_cmd_error: sense=0x%x asc=0x%x\n", sense_key, asc);
-#endif
+    trace_ide_atapi_cmd_error(s, sense_key, asc);
     s->error = sense_key << 4;
     s->status = READY_STAT | ERR_STAT;
     s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO | ATAPI_INT_REASON_CD;
@@ -252,19 +245,14 @@ static uint16_t atapi_byte_count_limit(IDEState *s)
 void ide_atapi_cmd_reply_end(IDEState *s)
 {
     int byte_count_limit, size, ret;
-#ifdef DEBUG_IDE_ATAPI
-    printf("reply: tx_size=%d elem_tx_size=%d index=%d\n",
-           s->packet_transfer_size,
-           s->elementary_transfer_size,
-           s->io_buffer_index);
-#endif
+    trace_ide_atapi_cmd_reply_end(s, s->packet_transfer_size,
+                                  s->elementary_transfer_size,
+                                  s->io_buffer_index);
     if (s->packet_transfer_size <= 0) {
         /* end of transfer */
         ide_atapi_cmd_ok(s);
         ide_set_irq(s->bus);
-#ifdef DEBUG_IDE_ATAPI
-        printf("end of transfer, status=0x%x\n", s->status);
-#endif
+        trace_ide_atapi_cmd_reply_end_eot(s, s->status);
     } else {
         /* see if a new sector must be read */
         if (s->lba != -1 && s->io_buffer_index >= s->cd_sector_size) {
@@ -300,9 +288,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
             /* a new transfer is needed */
             s->nsector = (s->nsector & ~7) | ATAPI_INT_REASON_IO;
             byte_count_limit = atapi_byte_count_limit(s);
-#ifdef DEBUG_IDE_ATAPI
-            printf("byte_count_limit=%d\n", byte_count_limit);
-#endif
+            trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
             size = s->packet_transfer_size;
             if (size > byte_count_limit) {
                 /* byte count limit must be even if this case */
@@ -324,9 +310,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
             ide_transfer_start(s, s->io_buffer + s->io_buffer_index - size,
                                size, ide_atapi_cmd_reply_end);
             ide_set_irq(s->bus);
-#ifdef DEBUG_IDE_ATAPI
-            printf("status=0x%x\n", s->status);
-#endif
+            trace_ide_atapi_cmd_reply_end_new(s, s->status);
         }
     }
 }
@@ -368,9 +352,7 @@ static void ide_atapi_cmd_read_pio(IDEState *s, int lba, int nb_sectors,
 
 static void ide_atapi_cmd_check_status(IDEState *s)
 {
-#ifdef DEBUG_IDE_ATAPI
-    printf("atapi_cmd_check_status\n");
-#endif
+    trace_ide_atapi_cmd_check_status(s);
     s->error = MC_ERR | (UNIT_ATTENTION << 4);
     s->status = ERR_STAT;
     s->nsector = 0;
@@ -477,10 +459,8 @@ static void ide_atapi_cmd_read_dma(IDEState *s, int lba, int nb_sectors,
 static void ide_atapi_cmd_read(IDEState *s, int lba, int nb_sectors,
                                int sector_size)
 {
-#ifdef DEBUG_IDE_ATAPI
-    printf("read %s: LBA=%d nb_sectors=%d\n", s->atapi_dma ? "dma" : "pio",
-        lba, nb_sectors);
-#endif
+    trace_ide_atapi_cmd_read(s, s->atapi_dma ? "dma" : "pio",
+                             lba, nb_sectors);
     if (s->atapi_dma) {
         ide_atapi_cmd_read_dma(s, lba, nb_sectors, sector_size);
     } else {
@@ -1330,16 +1310,18 @@ void ide_atapi_cmd(IDEState *s)
     uint8_t *buf = s->io_buffer;
     const struct AtapiCmd *cmd = &atapi_cmd_table[s->io_buffer[0]];
 
-#ifdef DEBUG_IDE_ATAPI
-    {
+    trace_ide_atapi_cmd(s, s->io_buffer[0]);
+
+    if (trace_event_get_state_backends(TRACE_IDE_ATAPI_CMD_PACKET)) {
+        /* Each pretty-printed byte needs two bytes and a space; */
+        char *ppacket = g_malloc(ATAPI_PACKET_SIZE * 3 + 1);
         int i;
-        printf("ATAPI limit=0x%x packet:", s->lcyl | (s->hcyl << 8));
-        for(i = 0; i < ATAPI_PACKET_SIZE; i++) {
-            printf(" %02x", buf[i]);
+        for (i = 0; i < ATAPI_PACKET_SIZE; i++) {
+            sprintf(ppacket + (i * 3), "%02x ", buf[i]);
         }
-        printf("\n");
+        trace_ide_atapi_cmd_packet(s, s->lcyl | (s->hcyl << 8), ppacket);
+        g_free(ppacket);
     }
-#endif
 
     /*
      * If there's a UNIT_ATTENTION condition pending, only command flagged with
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 17bc6f1..8c79a6c 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -38,3 +38,18 @@ bmdma_write(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"PRIx
 # hw/ide/via.c
 bmdma_read_via(uint64_t addr, uint32_t val) "bmdma: readb 0x%"PRIx64" : 0x%02x"
 bmdma_write_via(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" : 0x%02"PRIx64
+
+# hw/ide/atapi.c
+cd_read_sector_sync(int lba) "lba=%d"
+cd_read_sector_cb(int lba, int ret) "lba=%d ret=%d"
+cd_read_sector(int lba) "lba=%d"
+ide_atapi_cmd_error(void *s, int sense_key, int asc) "IDEState: %p; sense=0x%x asc=0x%x"
+ide_atapi_cmd_reply_end(void *s, int tx_size, int elem_tx_size, int32_t index) "IDEState %p; reply: tx_size=%d elem_tx_size=%d index=%"PRId32
+ide_atapi_cmd_reply_end_eot(void *s, int status) "IDEState: %p; end of transfer, status=0x%x"
+ide_atapi_cmd_reply_end_bcl(void *s, int bcl) "IDEState: %p; byte_count_limit=%d"
+ide_atapi_cmd_reply_end_new(void *s, int status) "IDEState: %p; new transfer started, status=0x%x"
+ide_atapi_cmd_check_status(void *s) "IDEState: %p"
+ide_atapi_cmd_read(void *s, const char *method, int lba, int nb_sectors) "IDEState: %p; read %s: LBA=%d nb_sectors=%d"
+ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd: 0x%02x"
+# Warning: Verbose
+ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDEState: %p; limit=0x%x packet: %s"
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 4a92f0a..74efe8a 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -14,7 +14,6 @@
 #include "block/scsi.h"
 
 /* debug IDE devices */
-//#define DEBUG_IDE_ATAPI
 //#define DEBUG_AIO
 #define USE_DMA_CDROM
 
-- 
2.9.5

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WF-0005Aq-Jg
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dt1WD-0006Ah-UC
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dt1WD-00069g-LQ
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 21:03:37 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 15 Sep 2017 21:03:25 -0400
Message-Id: <20170916010330.10435-7-jsnow@redhat.com>
In-Reply-To: <20170916010330.10435-1-jsnow@redhat.com>
References: <20170916010330.10435-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/11] ATAPI: Replace DEBUG_IDE_ATAPI with
 tracing events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

As part of the ongoing effort to modernize the tracing facilities for
the IDE family of devices, remove PRINTFs in the ATAPI device with
actual tracing events.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20170901001502.29915-5-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/atapi.c            | 64 +++++++++++++++++------------------------=
------
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
=20
 #define ATAPI_SECTOR_BITS (2 + BDRV_SECTOR_BITS)
 #define ATAPI_SECTOR_SIZE (1 << ATAPI_SECTOR_BITS)
@@ -116,9 +117,7 @@ cd_read_sector_sync(IDEState *s)
     block_acct_start(blk_get_stats(s->blk), &s->acct,
                      ATAPI_SECTOR_SIZE, BLOCK_ACCT_READ);
=20
-#ifdef DEBUG_IDE_ATAPI
-    printf("cd_read_sector_sync: lba=3D%d\n", s->lba);
-#endif
+    trace_cd_read_sector_sync(s->lba);
=20
     switch (s->cd_sector_size) {
     case 2048:
@@ -152,9 +151,7 @@ static void cd_read_sector_cb(void *opaque, int ret)
 {
     IDEState *s =3D opaque;
=20
-#ifdef DEBUG_IDE_ATAPI
-    printf("cd_read_sector_cb: lba=3D%d ret=3D%d\n", s->lba, ret);
-#endif
+    trace_cd_read_sector_cb(s->lba, ret);
=20
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->blk), &s->acct);
@@ -188,9 +185,7 @@ static int cd_read_sector(IDEState *s)
     s->iov.iov_len =3D ATAPI_SECTOR_SIZE;
     qemu_iovec_init_external(&s->qiov, &s->iov, 1);
=20
-#ifdef DEBUG_IDE_ATAPI
-    printf("cd_read_sector: lba=3D%d\n", s->lba);
-#endif
+    trace_cd_read_sector(s->lba);
=20
     block_acct_start(blk_get_stats(s->blk), &s->acct,
                      ATAPI_SECTOR_SIZE, BLOCK_ACCT_READ);
@@ -213,9 +208,7 @@ void ide_atapi_cmd_ok(IDEState *s)
=20
 void ide_atapi_cmd_error(IDEState *s, int sense_key, int asc)
 {
-#ifdef DEBUG_IDE_ATAPI
-    printf("atapi_cmd_error: sense=3D0x%x asc=3D0x%x\n", sense_key, asc)=
;
-#endif
+    trace_ide_atapi_cmd_error(s, sense_key, asc);
     s->error =3D sense_key << 4;
     s->status =3D READY_STAT | ERR_STAT;
     s->nsector =3D (s->nsector & ~7) | ATAPI_INT_REASON_IO | ATAPI_INT_R=
EASON_CD;
@@ -252,19 +245,14 @@ static uint16_t atapi_byte_count_limit(IDEState *s)
 void ide_atapi_cmd_reply_end(IDEState *s)
 {
     int byte_count_limit, size, ret;
-#ifdef DEBUG_IDE_ATAPI
-    printf("reply: tx_size=3D%d elem_tx_size=3D%d index=3D%d\n",
-           s->packet_transfer_size,
-           s->elementary_transfer_size,
-           s->io_buffer_index);
-#endif
+    trace_ide_atapi_cmd_reply_end(s, s->packet_transfer_size,
+                                  s->elementary_transfer_size,
+                                  s->io_buffer_index);
     if (s->packet_transfer_size <=3D 0) {
         /* end of transfer */
         ide_atapi_cmd_ok(s);
         ide_set_irq(s->bus);
-#ifdef DEBUG_IDE_ATAPI
-        printf("end of transfer, status=3D0x%x\n", s->status);
-#endif
+        trace_ide_atapi_cmd_reply_end_eot(s, s->status);
     } else {
         /* see if a new sector must be read */
         if (s->lba !=3D -1 && s->io_buffer_index >=3D s->cd_sector_size)=
 {
@@ -300,9 +288,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
             /* a new transfer is needed */
             s->nsector =3D (s->nsector & ~7) | ATAPI_INT_REASON_IO;
             byte_count_limit =3D atapi_byte_count_limit(s);
-#ifdef DEBUG_IDE_ATAPI
-            printf("byte_count_limit=3D%d\n", byte_count_limit);
-#endif
+            trace_ide_atapi_cmd_reply_end_bcl(s, byte_count_limit);
             size =3D s->packet_transfer_size;
             if (size > byte_count_limit) {
                 /* byte count limit must be even if this case */
@@ -324,9 +310,7 @@ void ide_atapi_cmd_reply_end(IDEState *s)
             ide_transfer_start(s, s->io_buffer + s->io_buffer_index - si=
ze,
                                size, ide_atapi_cmd_reply_end);
             ide_set_irq(s->bus);
-#ifdef DEBUG_IDE_ATAPI
-            printf("status=3D0x%x\n", s->status);
-#endif
+            trace_ide_atapi_cmd_reply_end_new(s, s->status);
         }
     }
 }
@@ -368,9 +352,7 @@ static void ide_atapi_cmd_read_pio(IDEState *s, int l=
ba, int nb_sectors,
=20
 static void ide_atapi_cmd_check_status(IDEState *s)
 {
-#ifdef DEBUG_IDE_ATAPI
-    printf("atapi_cmd_check_status\n");
-#endif
+    trace_ide_atapi_cmd_check_status(s);
     s->error =3D MC_ERR | (UNIT_ATTENTION << 4);
     s->status =3D ERR_STAT;
     s->nsector =3D 0;
@@ -477,10 +459,8 @@ static void ide_atapi_cmd_read_dma(IDEState *s, int =
lba, int nb_sectors,
 static void ide_atapi_cmd_read(IDEState *s, int lba, int nb_sectors,
                                int sector_size)
 {
-#ifdef DEBUG_IDE_ATAPI
-    printf("read %s: LBA=3D%d nb_sectors=3D%d\n", s->atapi_dma ? "dma" :=
 "pio",
-        lba, nb_sectors);
-#endif
+    trace_ide_atapi_cmd_read(s, s->atapi_dma ? "dma" : "pio",
+                             lba, nb_sectors);
     if (s->atapi_dma) {
         ide_atapi_cmd_read_dma(s, lba, nb_sectors, sector_size);
     } else {
@@ -1330,16 +1310,18 @@ void ide_atapi_cmd(IDEState *s)
     uint8_t *buf =3D s->io_buffer;
     const struct AtapiCmd *cmd =3D &atapi_cmd_table[s->io_buffer[0]];
=20
-#ifdef DEBUG_IDE_ATAPI
-    {
+    trace_ide_atapi_cmd(s, s->io_buffer[0]);
+
+    if (trace_event_get_state_backends(TRACE_IDE_ATAPI_CMD_PACKET)) {
+        /* Each pretty-printed byte needs two bytes and a space; */
+        char *ppacket =3D g_malloc(ATAPI_PACKET_SIZE * 3 + 1);
         int i;
-        printf("ATAPI limit=3D0x%x packet:", s->lcyl | (s->hcyl << 8));
-        for(i =3D 0; i < ATAPI_PACKET_SIZE; i++) {
-            printf(" %02x", buf[i]);
+        for (i =3D 0; i < ATAPI_PACKET_SIZE; i++) {
+            sprintf(ppacket + (i * 3), "%02x ", buf[i]);
         }
-        printf("\n");
+        trace_ide_atapi_cmd_packet(s, s->lcyl | (s->hcyl << 8), ppacket)=
;
+        g_free(ppacket);
     }
-#endif
=20
     /*
      * If there's a UNIT_ATTENTION condition pending, only command flagg=
ed with
diff --git a/hw/ide/trace-events b/hw/ide/trace-events
index 17bc6f1..8c79a6c 100644
--- a/hw/ide/trace-events
+++ b/hw/ide/trace-events
@@ -38,3 +38,18 @@ bmdma_write(uint64_t addr, uint64_t val) "bmdma: write=
b 0x%"PRIx64" : 0x%02"PRIx
 # hw/ide/via.c
 bmdma_read_via(uint64_t addr, uint32_t val) "bmdma: readb 0x%"PRIx64" : =
0x%02x"
 bmdma_write_via(uint64_t addr, uint64_t val) "bmdma: writeb 0x%"PRIx64" =
: 0x%02"PRIx64
+
+# hw/ide/atapi.c
+cd_read_sector_sync(int lba) "lba=3D%d"
+cd_read_sector_cb(int lba, int ret) "lba=3D%d ret=3D%d"
+cd_read_sector(int lba) "lba=3D%d"
+ide_atapi_cmd_error(void *s, int sense_key, int asc) "IDEState: %p; sens=
e=3D0x%x asc=3D0x%x"
+ide_atapi_cmd_reply_end(void *s, int tx_size, int elem_tx_size, int32_t =
index) "IDEState %p; reply: tx_size=3D%d elem_tx_size=3D%d index=3D%"PRId=
32
+ide_atapi_cmd_reply_end_eot(void *s, int status) "IDEState: %p; end of t=
ransfer, status=3D0x%x"
+ide_atapi_cmd_reply_end_bcl(void *s, int bcl) "IDEState: %p; byte_count_=
limit=3D%d"
+ide_atapi_cmd_reply_end_new(void *s, int status) "IDEState: %p; new tran=
sfer started, status=3D0x%x"
+ide_atapi_cmd_check_status(void *s) "IDEState: %p"
+ide_atapi_cmd_read(void *s, const char *method, int lba, int nb_sectors)=
 "IDEState: %p; read %s: LBA=3D%d nb_sectors=3D%d"
+ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd: 0x%02x"
+# Warning: Verbose
+ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet) "IDESt=
ate: %p; limit=3D0x%x packet: %s"
diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
index 4a92f0a..74efe8a 100644
--- a/include/hw/ide/internal.h
+++ b/include/hw/ide/internal.h
@@ -14,7 +14,6 @@
 #include "block/scsi.h"
=20
 /* debug IDE devices */
-//#define DEBUG_IDE_ATAPI
 //#define DEBUG_AIO
 #define USE_DMA_CDROM
=20
--=20
2.9.5

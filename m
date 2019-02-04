Received: from eggs.gnu.org ([209.51.188.92]:60187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7y-00068L-SE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7u-0004F0-Fz
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:54 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7u-000468-2T
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id q18so933905wrx.9
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:17 +0100
Message-Id: <1549305379-51117-76-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 75/77] scsi-disk: Convert from DPRINTF() macro
 to trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181211163105.31834-2-lvivier@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c  | 103 +++++++++++++++++++++++++--------------------------
 hw/scsi/trace-events |  29 +++++++++++++++
 2 files changed, 79 insertions(+), 53 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e6db6d7..d4e83ae 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -19,15 +19,6 @@
  * the host adapter emulator.
  */
 
-//#define DEBUG_SCSI
-
-#ifdef DEBUG_SCSI
-#define DPRINTF(fmt, ...) \
-do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
-
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
@@ -41,6 +32,7 @@ do { printf("scsi-disk: " fmt , ## __VA_ARGS__); } while (0)
 #include "hw/block/block.h"
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
+#include "trace.h"
 
 #ifdef __linux
 #include <scsi/sg.h>
@@ -129,8 +121,8 @@ static void scsi_free_request(SCSIRequest *req)
 /* Helper function for command completion with sense.  */
 static void scsi_check_condition(SCSIDiskReq *r, SCSISense sense)
 {
-    DPRINTF("Command complete tag=0x%x sense=%d/%d/%d\n",
-            r->req.tag, sense.key, sense.asc, sense.ascq);
+    trace_scsi_disk_check_condition(r->req.tag, sense.key, sense.asc,
+                                    sense.ascq);
     scsi_req_build_sense(&r->req, sense);
     scsi_req_complete(&r->req, CHECK_CONDITION);
 }
@@ -318,7 +310,7 @@ static void scsi_read_complete(void * opaque, int ret)
     }
 
     block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
-    DPRINTF("Data ready tag=0x%x len=%zd\n", r->req.tag, r->qiov.size);
+    trace_scsi_disk_read_complete(r->req.tag, r->qiov.size);
 
     n = r->qiov.size / 512;
     r->sector += n;
@@ -389,7 +381,7 @@ static void scsi_read_data(SCSIRequest *req)
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     bool first;
 
-    DPRINTF("Read sector_count=%d\n", r->sector_count);
+    trace_scsi_disk_read_data_count(r->sector_count);
     if (r->sector_count == 0) {
         /* This also clears the sense buffer for REQUEST SENSE.  */
         scsi_req_complete(&r->req, GOOD);
@@ -402,7 +394,7 @@ static void scsi_read_data(SCSIRequest *req)
     /* The request is used as the AIO opaque value, so add a ref.  */
     scsi_req_ref(&r->req);
     if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
-        DPRINTF("Data transfer direction invalid\n");
+        trace_scsi_disk_read_data_invalid();
         scsi_read_complete(r, -EINVAL);
         return;
     }
@@ -503,7 +495,7 @@ static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
         return;
     } else {
         scsi_init_iovec(r, SCSI_DMA_BUF_SIZE);
-        DPRINTF("Write complete tag=0x%x more=%zd\n", r->req.tag, r->qiov.size);
+        trace_scsi_disk_write_complete_noio(r->req.tag, r->qiov.size);
         scsi_req_data(&r->req, r->qiov.size);
     }
 
@@ -541,7 +533,7 @@ static void scsi_write_data(SCSIRequest *req)
     /* The request is used as the AIO opaque value, so add a ref.  */
     scsi_req_ref(&r->req);
     if (r->req.cmd.mode != SCSI_XFER_TO_DEV) {
-        DPRINTF("Data transfer direction invalid\n");
+        trace_scsi_disk_write_data_invalid();
         scsi_write_complete_noio(r, -EINVAL);
         return;
     }
@@ -606,8 +598,7 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
     switch (page_code) {
     case 0x00: /* Supported page codes, mandatory */
     {
-        DPRINTF("Inquiry EVPD[Supported pages] "
-                "buffer size %zd\n", req->cmd.xfer);
+        trace_scsi_disk_emulate_vpd_page_00(req->cmd.xfer);
         outbuf[buflen++] = 0x00; /* list of supported pages (this page) */
         if (s->serial) {
             outbuf[buflen++] = 0x80; /* unit serial number */
@@ -625,7 +616,7 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
         int l;
 
         if (!s->serial) {
-            DPRINTF("Inquiry (EVPD[Serial number] not supported\n");
+            trace_scsi_disk_emulate_vpd_page_80_not_supported();
             return -1;
         }
 
@@ -634,8 +625,7 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
             l = 36;
         }
 
-        DPRINTF("Inquiry EVPD[Serial number] "
-                "buffer size %zd\n", req->cmd.xfer);
+        trace_scsi_disk_emulate_vpd_page_80(req->cmd.xfer);
         memcpy(outbuf + buflen, s->serial, l);
         buflen += l;
         break;
@@ -645,8 +635,7 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
     {
         int id_len = s->device_id ? MIN(strlen(s->device_id), 255 - 8) : 0;
 
-        DPRINTF("Inquiry EVPD[Device identification] "
-                "buffer size %zd\n", req->cmd.xfer);
+        trace_scsi_disk_emulate_vpd_page_83(req->cmd.xfer);
 
         if (id_len) {
             outbuf[buflen++] = 0x2; /* ASCII */
@@ -693,8 +682,7 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
         SCSIBlockLimits bl = {};
 
         if (s->qdev.type == TYPE_ROM) {
-            DPRINTF("Inquiry (EVPD[%02X] not supported for CDROM\n",
-                    page_code);
+            trace_scsi_disk_emulate_vpd_page_b0_not_supported();
             return -1;
         }
         bl.wsnz = 1;
@@ -1241,8 +1229,9 @@ static int scsi_disk_emulate_mode_sense(SCSIDiskReq *r, uint8_t *outbuf)
     dbd = (r->req.cmd.buf[1] & 0x8) != 0;
     page = r->req.cmd.buf[2] & 0x3f;
     page_control = (r->req.cmd.buf[2] & 0xc0) >> 6;
-    DPRINTF("Mode Sense(%d) (page %d, xfer %zd, page_control %d)\n",
-        (r->req.cmd.buf[0] == MODE_SENSE) ? 6 : 10, page, r->req.cmd.xfer, page_control);
+
+    trace_scsi_disk_emulate_mode_sense((r->req.cmd.buf[0] == MODE_SENSE) ? 6 :
+                                       10, page, r->req.cmd.xfer, page_control);
     memset(outbuf, 0, r->req.cmd.xfer);
     p = outbuf;
 
@@ -1334,7 +1323,7 @@ static int scsi_disk_emulate_read_toc(SCSIRequest *req, uint8_t *outbuf)
     format = req->cmd.buf[2] & 0xf;
     start_track = req->cmd.buf[6];
     blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
-    DPRINTF("Read TOC (track %d format %d msf %d)\n", start_track, format, msf >> 1);
+    trace_scsi_disk_emulate_read_toc(start_track, format, msf >> 1);
     nb_sectors /= s->qdev.blocksize / 512;
     switch (format) {
     case 0:
@@ -1393,7 +1382,7 @@ static void scsi_disk_emulate_read_data(SCSIRequest *req)
     int buflen = r->iov.iov_len;
 
     if (buflen) {
-        DPRINTF("Read buf_len=%d\n", buflen);
+        trace_scsi_disk_emulate_read_data(buflen);
         r->iov.iov_len = 0;
         r->started = true;
         scsi_req_data(&r->req, buflen);
@@ -1812,7 +1801,7 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
 
     if (r->iov.iov_len) {
         int buflen = r->iov.iov_len;
-        DPRINTF("Write buf_len=%d\n", buflen);
+        trace_scsi_disk_emulate_write_data(buflen);
         r->iov.iov_len = 0;
         scsi_req_data(&r->req, buflen);
         return;
@@ -2021,7 +2010,7 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
     case SERVICE_ACTION_IN_16:
         /* Service Action In subcommands. */
         if ((req->cmd.buf[1] & 31) == SAI_READ_CAPACITY_16) {
-            DPRINTF("SAI READ CAPACITY(16)\n");
+            trace_scsi_disk_emulate_command_SAI_16();
             memset(outbuf, 0, req->cmd.xfer);
             blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
             if (!nb_sectors) {
@@ -2059,7 +2048,7 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
             /* Protection, exponent and lowest lba field left blank. */
             break;
         }
-        DPRINTF("Unsupported Service Action In\n");
+        trace_scsi_disk_emulate_command_SAI_unsupported();
         goto illegal_request;
     case SYNCHRONIZE_CACHE:
         /* The request is used as the AIO opaque value, so add a ref.  */
@@ -2069,37 +2058,36 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
         r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_aio_complete, r);
         return 0;
     case SEEK_10:
-        DPRINTF("Seek(10) (sector %" PRId64 ")\n", r->req.cmd.lba);
+        trace_scsi_disk_emulate_command_SEEK_10(r->req.cmd.lba);
         if (r->req.cmd.lba > s->qdev.max_lba) {
             goto illegal_lba;
         }
         break;
     case MODE_SELECT:
-        DPRINTF("Mode Select(6) (len %lu)\n", (unsigned long)r->req.cmd.xfer);
+        trace_scsi_disk_emulate_command_MODE_SELECT(r->req.cmd.xfer);
         break;
     case MODE_SELECT_10:
-        DPRINTF("Mode Select(10) (len %lu)\n", (unsigned long)r->req.cmd.xfer);
+        trace_scsi_disk_emulate_command_MODE_SELECT_10(r->req.cmd.xfer);
         break;
     case UNMAP:
-        DPRINTF("Unmap (len %lu)\n", (unsigned long)r->req.cmd.xfer);
+        trace_scsi_disk_emulate_command_UNMAP(r->req.cmd.xfer);
         break;
     case VERIFY_10:
     case VERIFY_12:
     case VERIFY_16:
-        DPRINTF("Verify (bytchk %d)\n", (req->cmd.buf[1] >> 1) & 3);
+        trace_scsi_disk_emulate_command_VERIFY((req->cmd.buf[1] >> 1) & 3);
         if (req->cmd.buf[1] & 6) {
             goto illegal_request;
         }
         break;
     case WRITE_SAME_10:
     case WRITE_SAME_16:
-        DPRINTF("WRITE SAME %d (len %lu)\n",
-                req->cmd.buf[0] == WRITE_SAME_10 ? 10 : 16,
-                (unsigned long)r->req.cmd.xfer);
+        trace_scsi_disk_emulate_command_WRITE_SAME(
+                req->cmd.buf[0] == WRITE_SAME_10 ? 10 : 16, r->req.cmd.xfer);
         break;
     default:
-        DPRINTF("Unknown SCSI command (%2.2x=%s)\n", buf[0],
-                scsi_command_name(buf[0]));
+        trace_scsi_disk_emulate_command_UNKNOWN(buf[0],
+                                                scsi_command_name(buf[0]));
         scsi_check_condition(r, SENSE_CODE(INVALID_OPCODE));
         return 0;
     }
@@ -2152,7 +2140,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
     case READ_10:
     case READ_12:
     case READ_16:
-        DPRINTF("Read (sector %" PRId64 ", count %u)\n", r->req.cmd.lba, len);
+        trace_scsi_disk_dma_command_READ(r->req.cmd.lba, len);
         /* Protection information is not supported.  For SCSI versions 2 and
          * older (as determined by snooping the guest's INQUIRY commands),
          * there is no RD/WR/VRPROTECT, so skip this check in these versions.
@@ -2177,7 +2165,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
             scsi_check_condition(r, SENSE_CODE(WRITE_PROTECTED));
             return 0;
         }
-        DPRINTF("Write %s(sector %" PRId64 ", count %u)\n",
+        trace_scsi_disk_dma_command_WRITE(
                 (command & 0xe) == 0xe ? "And Verify " : "",
                 r->req.cmd.lba, len);
         /* fall through */
@@ -2515,6 +2503,22 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
     [WRITE_VERIFY_16]                 = &scsi_disk_dma_reqops,
 };
 
+static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
+{
+    int i;
+    int len = scsi_cdb_length(buf);
+    char *line_buffer, *p;
+
+    line_buffer = g_malloc(len * 5 + 1);
+
+    for (i = 0, p = line_buffer; i < len; i++) {
+        p += sprintf(p, " 0x%02x", buf[i]);
+    }
+    trace_scsi_disk_new_request(lun, tag, line_buffer);
+
+    g_free(line_buffer);
+}
+
 static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
                                      uint8_t *buf, void *hba_private)
 {
@@ -2530,16 +2534,9 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
     }
     req = scsi_req_alloc(ops, &s->qdev, tag, lun, hba_private);
 
-#ifdef DEBUG_SCSI
-    DPRINTF("Command: lun=%d tag=0x%x data=0x%02x", lun, tag, buf[0]);
-    {
-        int i;
-        for (i = 1; i < scsi_cdb_length(buf); i++) {
-            printf(" 0x%02x", buf[i]);
-        }
-        printf("\n");
+    if (trace_event_get_state_backends(TRACE_SCSI_DISK_NEW_REQUEST)) {
+        scsi_disk_new_request_dump(lun, tag, buf);
     }
-#endif
 
     return req;
 }
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index 2fe8a7c..dbd529e 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -292,3 +292,32 @@ lsi_execute_script_stop(void) "SCRIPTS execution stopped"
 lsi_awoken(void) "Woken by SIGP"
 lsi_reg_read(const char *name, int offset, uint8_t ret) "Read reg %s 0x%x = 0x%02x"
 lsi_reg_write(const char *name, int offset, uint8_t val) "Write reg %s 0x%x = 0x%02x"
+
+# hw/scsi/scsi-disk.c
+scsi_disk_check_condition(uint32_t tag, uint8_t key, uint8_t asc, uint8_t ascq) "Command complete tag=0x%x sense=%d/%d/%d"
+scsi_disk_read_complete(uint32_t tag, size_t size) "Data ready tag=0x%x len=%zd"
+scsi_disk_read_data_count(uint32_t sector_count) "Read sector_count=%d"
+scsi_disk_read_data_invalid(void) "Data transfer direction invalid"
+scsi_disk_write_complete_noio(uint32_t tag, size_t size) "Write complete tag=0x%x more=%zd"
+scsi_disk_write_data_invalid(void) "Data transfer direction invalid"
+scsi_disk_emulate_vpd_page_00(size_t xfer) "Inquiry EVPD[Supported pages] buffer size %zd"
+scsi_disk_emulate_vpd_page_80_not_supported(void) "Inquiry (EVPD[Serial number] not supported"
+scsi_disk_emulate_vpd_page_80(size_t xfer) "Inquiry EVPD[Serial number] buffer size %zd"
+scsi_disk_emulate_vpd_page_83(size_t xfer) "Inquiry EVPD[Device identification] buffer size %zd"
+scsi_disk_emulate_vpd_page_b0_not_supported(void) "Inquiry (EVPD[Block limits] not supported for CDROM"
+scsi_disk_emulate_mode_sense(int cmd, int page, size_t xfer, int control) "Mode Sense(%d) (page %d, xfer %zd, page_control %d)"
+scsi_disk_emulate_read_toc(int start_track, int format, int msf) "Read TOC (track %d format %d msf %d)"
+scsi_disk_emulate_read_data(int buflen) "Read buf_len=%d"
+scsi_disk_emulate_write_data(int buflen) "Write buf_len=%d"
+scsi_disk_emulate_command_SAI_16(void) "SAI READ CAPACITY(16)"
+scsi_disk_emulate_command_SAI_unsupported(void) "Unsupported Service Action In"
+scsi_disk_emulate_command_SEEK_10(uint64_t lba) "Seek(10) (sector %" PRId64 ")"
+scsi_disk_emulate_command_MODE_SELECT(size_t xfer) "Mode Select(6) (len %zd)"
+scsi_disk_emulate_command_MODE_SELECT_10(size_t xfer) "Mode Select(10) (len %zd)"
+scsi_disk_emulate_command_UNMAP(size_t xfer) "Unmap (len %zd)"
+scsi_disk_emulate_command_VERIFY(int bytchk) "Verify (bytchk %d)"
+scsi_disk_emulate_command_WRITE_SAME(int cmd, size_t xfer) "WRITE SAME %d (len %zd)"
+scsi_disk_emulate_command_UNKNOWN(int cmd, const char *name) "Unknown SCSI command (0x%2.2x=%s)"
+scsi_disk_dma_command_READ(uint64_t lba, uint32_t len) "Read (sector %" PRId64 ", count %u)"
+scsi_disk_dma_command_WRITE(const char *cmd, uint64_t lba, int len) "Write %s(sector %" PRId64 ", count %u)"
+scsi_disk_new_request(uint32_t lun, uint32_t tag, const char *line) "Command: lun=%d tag=0x%x data=%s"
-- 
1.8.3.1

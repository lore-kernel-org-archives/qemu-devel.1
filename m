Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C0C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34724218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34724218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0l6-0007oh-4N
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iT0hu-0004MZ-Eg
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>) id 1iT0hs-00035s-QY
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:37:30 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:4100)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <baiyaowei@cmss.chinamobile.com>)
 id 1iT0ho-00031u-MA; Fri, 08 Nov 2019 04:37:25 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.3]) by
 rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85dc536d7063-85542;
 Fri, 08 Nov 2019 17:35:19 +0800 (CST)
X-RM-TRANSID: 2ee85dc536d7063-85542
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.novalocal (unknown[112.25.65.41])
 by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee25dc536d2c26-16e46;
 Fri, 08 Nov 2019 17:35:19 +0800 (CST)
X-RM-TRANSID: 2ee25dc536d2c26-16e46
From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
To: pbonzini@redhat.com, fam@euphon.net, dillaman@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com
Subject: [PATCH 3/4 V2] hw/scsi: add SCSI COMPARE_AND_WRITE support
Date: Fri,  8 Nov 2019 17:35:40 +0800
Message-Id: <1573205741-2094-4-git-send-email-baiyaowei@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573205741-2094-1-git-send-email-baiyaowei@cmss.chinamobile.com>
References: <1573205741-2094-1-git-send-email-baiyaowei@cmss.chinamobile.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.80
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: baiyaowei@cmss.chinamobile.com, yangjun@cmss.chinamobile.com,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch emulates COMPARE_AND_WRITE command with the
BDRV_REQ_COMPARE_AND_WRITE flag introduced by last patch. It matches
the SBC-4 standard except the FUA bit support, it'll be finished in
the next patch.

Note that cmd->xfer is set 2 * the number got by scsi_data_cdb_xfer
so we could touch the least code.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 hw/scsi/emulation.c         |  1 +
 hw/scsi/scsi-bus.c          |  4 +++
 hw/scsi/scsi-disk.c         | 88 +++++++++++++++++++++++++++++++++++++++++++++
 hw/scsi/trace-events        |  1 +
 include/hw/scsi/emulation.h |  3 ++
 include/scsi/utils.h        |  2 ++
 scsi/utils.c                |  5 +++
 7 files changed, 104 insertions(+)

diff --git a/hw/scsi/emulation.c b/hw/scsi/emulation.c
index 06d62f3..1f53c4a 100644
--- a/hw/scsi/emulation.c
+++ b/hw/scsi/emulation.c
@@ -9,6 +9,7 @@ int scsi_emulate_block_limits(uint8_t *outbuf, const SCSIBlockLimits *bl)
     memset(outbuf, 0, 0x3c);
 
     outbuf[0] = bl->wsnz; /* wsnz */
+    outbuf[1] = MAX_COMPARE_AND_WRITE_LENGTH;
 
     if (bl->max_io_sectors) {
         /* optimal transfer length granularity.  This field and the optimal
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 359d50d..a20eb11 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1003,6 +1003,9 @@ static int scsi_req_xfer(SCSICommand *cmd, SCSIDevice *dev, uint8_t *buf)
     case WRITE_VERIFY_16:
         cmd->xfer *= dev->blocksize;
         break;
+    case COMPARE_AND_WRITE:
+        cmd->xfer *= 2 * dev->blocksize;
+        break;
     case READ_6:
     case READ_REVERSE:
         /* length 0 means 256 blocks */
@@ -1222,6 +1225,7 @@ static void scsi_cmd_xfer_mode(SCSICommand *cmd)
     case PERSISTENT_RESERVE_OUT:
     case MAINTENANCE_OUT:
     case SET_WINDOW:
+    case COMPARE_AND_WRITE:
     case SCAN:
         /* SCAN conflicts with START_STOP.  START_STOP has cmd->xfer set to 0 for
          * non-scanner devices, so we only get here for SCAN and not for START_STOP.
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 07fb5eb..f9a0267 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -478,6 +478,9 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
         case ENOSPC:
             scsi_check_condition(r, SENSE_CODE(SPACE_ALLOC_FAILED));
             break;
+        case EILSEQ:
+            scsi_check_condition(r, SENSE_CODE(MISCOMPARE_DURING_VERIFY));
+            break;
         default:
             scsi_check_condition(r, SENSE_CODE(IO_ERROR));
             break;
@@ -1825,6 +1828,84 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
                                    scsi_write_same_complete, data);
 }
 
+typedef struct CompareAndWriteCBData {
+    SCSIDiskReq *r;
+    int64_t sector;
+    int nb_sectors;
+    QEMUIOVector qiov;
+    struct iovec iov;
+} CompareAndWriteCBData;
+
+static void scsi_compare_and_write_complete(void *opaque, int ret)
+{
+    CompareAndWriteCBData *data = opaque;
+    SCSIDiskReq *r = data->r;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
+    if (scsi_disk_req_check_error(r, ret, true)) {
+        goto done;
+    }
+
+    block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
+    scsi_req_complete(&r->req, GOOD);
+
+done:
+    scsi_req_unref(&r->req);
+    qemu_vfree(data->iov.iov_base);
+    g_free(data);
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
+}
+
+static void scsi_disk_emulate_compare_and_write(SCSIDiskReq *r, uint8_t *inbuf)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+    uint32_t nb_sectors = scsi_data_cdb_xfer(r->req.cmd.buf);
+    CompareAndWriteCBData *data;
+    uint8_t *buf;
+    int i;
+
+    if (nb_sectors > MAX_COMPARE_AND_WRITE_LENGTH) {
+        scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
+        return;
+    }
+
+    if (blk_is_read_only(s->qdev.conf.blk)) {
+        scsi_check_condition(r, SENSE_CODE(WRITE_PROTECTED));
+        return;
+    }
+
+    if (r->req.cmd.lba > s->qdev.max_lba ||
+                !check_lba_range(s, r->req.cmd.lba, nb_sectors)) {
+        scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
+        return;
+    }
+
+    data = g_new0(CompareAndWriteCBData, 1);
+    data->r = r;
+    data->sector = r->req.cmd.lba * (s->qdev.blocksize / 512);
+    data->nb_sectors = r->req.cmd.xfer * (s->qdev.blocksize / 512);
+    data->iov.iov_len = data->nb_sectors;
+    data->iov.iov_base = buf = blk_blockalign(s->qdev.conf.blk,
+                                              data->iov.iov_len);
+    qemu_iovec_init_external(&data->qiov, &data->iov, 1);
+
+    for (i = 0; i < data->iov.iov_len; i += s->qdev.blocksize) {
+        memcpy(&buf[i], &inbuf[i], s->qdev.blocksize);
+    }
+
+    scsi_req_ref(&r->req);
+    block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+                     data->iov.iov_len, BLOCK_ACCT_WRITE);
+    r->req.aiocb = blk_aio_pwritev(s->qdev.conf.blk,
+                                   data->sector << BDRV_SECTOR_BITS,
+                                   &data->qiov, BDRV_REQ_COMPARE_AND_WRITE,
+                                   scsi_compare_and_write_complete, data);
+}
+
 static void scsi_disk_emulate_write_data(SCSIRequest *req)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
@@ -1861,6 +1942,9 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
         scsi_disk_emulate_write_same(r, r->iov.iov_base);
         break;
 
+    case COMPARE_AND_WRITE:
+        scsi_disk_emulate_compare_and_write(r, r->iov.iov_base);
+        break;
     default:
         abort();
     }
@@ -2115,6 +2199,9 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
         trace_scsi_disk_emulate_command_WRITE_SAME(
                 req->cmd.buf[0] == WRITE_SAME_10 ? 10 : 16, r->req.cmd.xfer);
         break;
+    case COMPARE_AND_WRITE:
+        trace_scsi_disk_emulate_command_COMPARE_AND_WRITE(r->req.cmd.xfer);
+        break;
     default:
         trace_scsi_disk_emulate_command_UNKNOWN(buf[0],
                                                 scsi_command_name(buf[0]));
@@ -2542,6 +2629,7 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
     [VERIFY_10]                       = &scsi_disk_emulate_reqops,
     [VERIFY_12]                       = &scsi_disk_emulate_reqops,
     [VERIFY_16]                       = &scsi_disk_emulate_reqops,
+    [COMPARE_AND_WRITE]               = &scsi_disk_emulate_reqops,
 
     [READ_6]                          = &scsi_disk_dma_reqops,
     [READ_10]                         = &scsi_disk_dma_reqops,
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index b082005..0783e58 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -317,6 +317,7 @@ scsi_disk_emulate_command_MODE_SELECT_10(size_t xfer) "Mode Select(10) (len %zd)
 scsi_disk_emulate_command_UNMAP(size_t xfer) "Unmap (len %zd)"
 scsi_disk_emulate_command_VERIFY(int bytchk) "Verify (bytchk %d)"
 scsi_disk_emulate_command_WRITE_SAME(int cmd, size_t xfer) "WRITE SAME %d (len %zd)"
+scsi_disk_emulate_command_COMPARE_AND_WRITE(size_t xfer) "COMPARE AND WRITE (len %zd)"
 scsi_disk_emulate_command_UNKNOWN(int cmd, const char *name) "Unknown SCSI command (0x%2.2x=%s)"
 scsi_disk_dma_command_READ(uint64_t lba, uint32_t len) "Read (sector %" PRId64 ", count %u)"
 scsi_disk_dma_command_WRITE(const char *cmd, uint64_t lba, int len) "Write %s(sector %" PRId64 ", count %u)"
diff --git a/include/hw/scsi/emulation.h b/include/hw/scsi/emulation.h
index 9521704..2148316 100644
--- a/include/hw/scsi/emulation.h
+++ b/include/hw/scsi/emulation.h
@@ -1,6 +1,9 @@
 #ifndef HW_SCSI_EMULATION_H
 #define HW_SCSI_EMULATION_H
 
+/* maximum compare and write length : 64kb */
+#define MAX_COMPARE_AND_WRITE_LENGTH 128
+
 typedef struct SCSIBlockLimits {
     bool wsnz;
     uint16_t min_io_size;
diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index fbc5588..35f554e 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -101,6 +101,8 @@ extern const struct SCSISense sense_code_DEVICE_INTERNAL_RESET;
 extern const struct SCSISense sense_code_WRITE_PROTECTED;
 /* Data Protection, Space Allocation Failed Write Protect */
 extern const struct SCSISense sense_code_SPACE_ALLOC_FAILED;
+/* Miscompare, Miscompare During Verify Operation */
+extern const struct SCSISense sense_code_MISCOMPARE_DURING_VERIFY;
 
 #define SENSE_CODE(x) sense_code_ ## x
 
diff --git a/scsi/utils.c b/scsi/utils.c
index c50e81f..c142a53 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -311,6 +311,11 @@ const struct SCSISense sense_code_SPACE_ALLOC_FAILED = {
     .key = DATA_PROTECT, .asc = 0x27, .ascq = 0x07
 };
 
+/* Miscompare, Miscompare During Verify Operation */
+const struct SCSISense sense_code_MISCOMPARE_DURING_VERIFY = {
+    .key = MISCOMPARE, .asc = 0x1d, .ascq = 0x00
+};
+
 /*
  * scsi_convert_sense
  *
-- 
1.8.3.1





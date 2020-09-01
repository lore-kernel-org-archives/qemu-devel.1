Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF83C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:24:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA2B206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA2B206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Ck-0002Av-Fl
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zT-0005qr-EP; Tue, 01 Sep 2020 10:10:27 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zP-0003x6-GM; Tue, 01 Sep 2020 10:10:27 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MfpGL-1koumX3uO1-00gG4y; Tue, 01 Sep 2020 16:10:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 29/44] hw/scsi/scsi-disk: Replace magic '512' value by
 BDRV_SECTOR_SIZE
Date: Tue,  1 Sep 2020 16:09:39 +0200
Message-Id: <20200901140954.889743-30-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VctxRDI2bXcWpd7d+kSybLSYQKi5P11DeTolnm84WZvO9ipCXIG
 q8rHw5sjxHrQ3pRrmWcW7sEl4y9h0NWZDc/vbg/dFbk6Z2lSj2sse9qsfzl7Op8a2UIi4Bk
 iy5igbitoNEZVNooHvZVr12Ds3nzhCTRMZS8wusmRQyVMv51KpnCkktjkNjQFgD4Ce3S5i7
 /UWRfA7gXAKp9By1LKdCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MBro4QvSGxM=:G7OACUmsFn20ySSwNc81Dq
 wC9JSngnU8yax+/2gq8DEBHxrjSj1L3torXUC3nYw4tLsI/M6K9ZRlQll6UGa1HGpnT30ihax
 PCaaABxsgt4a9xC8lGzbpKgp/qNvNUfiIguLwLGBIPPjRCvLPwQrzBIjgQVjnf30WFCaQf/+0
 Apzk9jfv779TLt+4Iasj59SDJqWbycFNjIftavy1tDAE8Pl+XOcVVUx511CEDeWduuhvDKU6m
 JwxByksbm3L30mXriCtIPRAvUFyiYfe5tjA7ljARsvK3p7RkFdu5ZChp7EzH8UdTOp5WQEDoo
 79DCQp/LTelYDVSXmjGUreZJtR+451Lty1Is74GNREauccqvDLfUa4ftTbDgnh5BLZ3sQCX2/
 /QKDPHLN1SzpGqXhFNFkHjGV0oIWTNgv5XwlGvUh3ynOHaysPe8TzKRWA6eci+szmy+r56aVQ
 88cNmzc/Mi8gQn1FDPdNg6zRUVZBodVdTazeTzovmoVgSlou4oED3YRlb2wY3MsGWzmI1OgL6
 K7YMQIsohXXeICgeaX6+4HVw8MZByzQ2d4NCmh8yOWh/I+KyRBlLzsqHVurTEXUk4vd//lACp
 f8fXp2TFFcz3odoMhDeBEUMJkFwmt8rHX69BA7+SqSgzY+6j1ZeJqBdaAOliHu6N5z0p7GxiZ
 iZkow1OG7kqhVIJtHioQ/a4KRKq+Qa9d2+8dd3egeGd5d3WbhBllqERlvaHDULWVnpsadbHmX
 FN1UFRrx33LvV8P4jAYMSddwcgvgDUIFe+9hiJwx/6/4pid0zAz+mqFQebhzsrJAMl1sX4hv0
 kKzTDx3YtzpX5F3Rvvk3bRRxElAe6mDBLYfc1bZYUk9lbOscKiUxQ/KF+HdW4UReHcTUcIW
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-trivial@nongnu.org,
 Li Qiang <liq3ea@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Use self-explicit definitions instead of magic '512' value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200814082841.27000-8-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/scsi/scsi-disk.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 8ce68a9dd64a..7612035a4e4b 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -71,7 +71,7 @@ typedef struct SCSIDiskClass {
 
 typedef struct SCSIDiskReq {
     SCSIRequest req;
-    /* Both sector and sector_count are in terms of qemu 512 byte blocks.  */
+    /* Both sector and sector_count are in terms of BDRV_SECTOR_SIZE bytes.  */
     uint64_t sector;
     uint32_t sector_count;
     uint32_t buflen;
@@ -141,7 +141,7 @@ static void scsi_init_iovec(SCSIDiskReq *r, size_t size)
         r->buflen = size;
         r->iov.iov_base = blk_blockalign(s->qdev.conf.blk, r->buflen);
     }
-    r->iov.iov_len = MIN(r->sector_count * 512, r->buflen);
+    r->iov.iov_len = MIN(r->sector_count * BDRV_SECTOR_SIZE, r->buflen);
     qemu_iovec_init_external(&r->qiov, &r->iov, 1);
 }
 
@@ -311,7 +311,7 @@ static void scsi_read_complete_noio(SCSIDiskReq *r, int ret)
         goto done;
     }
 
-    n = r->qiov.size / 512;
+    n = r->qiov.size / BDRV_SECTOR_SIZE;
     r->sector += n;
     r->sector_count -= n;
     scsi_req_data(&r->req, r->qiov.size);
@@ -505,7 +505,7 @@ static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
         goto done;
     }
 
-    n = r->qiov.size / 512;
+    n = r->qiov.size / BDRV_SECTOR_SIZE;
     r->sector += n;
     r->sector_count -= n;
     if (r->sector_count == 0) {
@@ -1284,7 +1284,7 @@ static int scsi_disk_emulate_mode_sense(SCSIDiskReq *r, uint8_t *outbuf)
         } else { /* MODE_SENSE_10 */
             outbuf[7] = 8; /* Block descriptor length  */
         }
-        nb_sectors /= (s->qdev.blocksize / 512);
+        nb_sectors /= (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         if (nb_sectors > 0xffffff) {
             nb_sectors = 0;
         }
@@ -1342,7 +1342,7 @@ static int scsi_disk_emulate_read_toc(SCSIRequest *req, uint8_t *outbuf)
     start_track = req->cmd.buf[6];
     blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
     trace_scsi_disk_emulate_read_toc(start_track, format, msf >> 1);
-    nb_sectors /= s->qdev.blocksize / 512;
+    nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
     switch (format) {
     case 0:
         toclen = cdrom_read_toc(nb_sectors, outbuf, msf, start_track);
@@ -1738,9 +1738,10 @@ static void scsi_write_same_complete(void *opaque, int ret)
 
     block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
 
-    data->nb_sectors -= data->iov.iov_len / 512;
-    data->sector += data->iov.iov_len / 512;
-    data->iov.iov_len = MIN(data->nb_sectors * 512, data->iov.iov_len);
+    data->nb_sectors -= data->iov.iov_len / BDRV_SECTOR_SIZE;
+    data->sector += data->iov.iov_len / BDRV_SECTOR_SIZE;
+    data->iov.iov_len = MIN(data->nb_sectors * BDRV_SECTOR_SIZE,
+                            data->iov.iov_len);
     if (data->iov.iov_len) {
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
                          data->iov.iov_len, BLOCK_ACCT_WRITE);
@@ -1805,9 +1806,10 @@ static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
 
     data = g_new0(WriteSameCBData, 1);
     data->r = r;
-    data->sector = r->req.cmd.lba * (s->qdev.blocksize / 512);
-    data->nb_sectors = nb_sectors * (s->qdev.blocksize / 512);
-    data->iov.iov_len = MIN(data->nb_sectors * 512, SCSI_WRITE_SAME_MAX);
+    data->sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+    data->nb_sectors = nb_sectors * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+    data->iov.iov_len = MIN(data->nb_sectors * BDRV_SECTOR_SIZE,
+                            SCSI_WRITE_SAME_MAX);
     data->iov.iov_base = buf = blk_blockalign(s->qdev.conf.blk,
                                               data->iov.iov_len);
     qemu_iovec_init_external(&data->qiov, &data->iov, 1);
@@ -1980,7 +1982,7 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
         if ((req->cmd.buf[8] & 1) == 0 && req->cmd.lba) {
             goto illegal_request;
         }
-        nb_sectors /= s->qdev.blocksize / 512;
+        nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
         /* Returned value is the address of the last sector.  */
         nb_sectors--;
         /* Remember the new size for read/write sanity checking. */
@@ -2049,7 +2051,7 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
             if ((req->cmd.buf[14] & 1) == 0 && req->cmd.lba) {
                 goto illegal_request;
             }
-            nb_sectors /= s->qdev.blocksize / 512;
+            nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
             /* Returned value is the address of the last sector.  */
             nb_sectors--;
             /* Remember the new size for read/write sanity checking. */
@@ -2180,8 +2182,8 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
             goto illegal_lba;
         }
-        r->sector = r->req.cmd.lba * (s->qdev.blocksize / 512);
-        r->sector_count = len * (s->qdev.blocksize / 512);
+        r->sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+        r->sector_count = len * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         break;
     case WRITE_6:
     case WRITE_10:
@@ -2211,8 +2213,8 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         if (!check_lba_range(s, r->req.cmd.lba, len)) {
             goto illegal_lba;
         }
-        r->sector = r->req.cmd.lba * (s->qdev.blocksize / 512);
-        r->sector_count = len * (s->qdev.blocksize / 512);
+        r->sector = r->req.cmd.lba * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
+        r->sector_count = len * (s->qdev.blocksize / BDRV_SECTOR_SIZE);
         break;
     default:
         abort();
@@ -2229,9 +2231,9 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
     }
     assert(r->iov.iov_len == 0);
     if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
-        return -r->sector_count * 512;
+        return -r->sector_count * BDRV_SECTOR_SIZE;
     } else {
-        return r->sector_count * 512;
+        return r->sector_count * BDRV_SECTOR_SIZE;
     }
 }
 
@@ -2243,7 +2245,7 @@ static void scsi_disk_reset(DeviceState *dev)
     scsi_device_purge_requests(&s->qdev, SENSE_CODE(RESET));
 
     blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
-    nb_sectors /= s->qdev.blocksize / 512;
+    nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
     if (nb_sectors) {
         nb_sectors--;
     }
-- 
2.26.2



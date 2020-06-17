Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF16C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DC920DD4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DC920DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVKP-0000bG-3j
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@localhost>)
 id 1jlVGq-0004Ge-D8; Wed, 17 Jun 2020 06:26:16 -0400
Received: from [114.255.249.163] (port=23486 helo=localhost)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@localhost>)
 id 1jlVGo-0007Og-Fm; Wed, 17 Jun 2020 06:26:16 -0400
Received: by localhost (Postfix, from userid 0)
 id 1F7BA1415FB; Wed, 17 Jun 2020 18:20:24 +0800 (CST)
From: Lin Ma <lma@suse.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 3/3] scsi-disk: Add support for the GET LBA STATUS 16
 command
Date: Wed, 17 Jun 2020 18:20:19 +0800
Message-Id: <20200617102019.29652-4-lma@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617102019.29652-1-lma@suse.com>
References: <20200617102019.29652-1-lma@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 114.255.249.163 (failed)
Received-SPF: none client-ip=114.255.249.163; envelope-from=root@localhost;
 helo=localhost
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 06:20:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: 68
X-Spam_score: 6.8
X-Spam_bar: ++++++
X-Spam_report: (6.8 / 5.0 requ) BAYES_00=-1.9, FSL_HELO_NON_FQDN_1=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, HELO_LOCALHOST=3.828, RCVD_IN_MSPIKE_BL=0.01,
 RCVD_IN_MSPIKE_ZBI=2.7, RCVD_IN_XBL=0.375, RDNS_NONE=0.793,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: reject
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, Lin Ma <lma@suse.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Lin Ma <lma@suse.com>
---
 hw/scsi/scsi-disk.c        | 90 ++++++++++++++++++++++++++++++++++++++
 include/block/accounting.h |  1 +
 include/scsi/constants.h   |  1 +
 3 files changed, 92 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 387503e11b..9e3002ddaf 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1866,6 +1866,89 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
     }
 }
 
+typedef struct GetLbaStatusCBData {
+    uint32_t num_blocks;
+    uint32_t is_deallocated;
+    SCSIDiskReq *r;
+} GetLbaStatusCBData;
+
+static void scsi_get_lba_status_complete(void *opaque, int ret);
+
+static void scsi_get_lba_status_complete_noio(GetLbaStatusCBData *data, int ret)
+{
+    SCSIDiskReq *r = data->r;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(r->req.aiocb == NULL);
+
+    block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+                     s->qdev.blocksize, BLOCK_ACCT_GET_LBA_STATUS);
+
+    r->req.aiocb = blk_aio_get_lba_status(s->qdev.conf.blk,
+                                          r->req.cmd.lba * s->qdev.blocksize,
+                                          s->qdev.blocksize,
+                                          scsi_get_lba_status_complete, data);
+}
+
+static void scsi_get_lba_status_complete(void *opaque, int ret)
+{
+    GetLbaStatusCBData *data = opaque;
+    SCSIDiskReq *r = data->r;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
+    if (scsi_disk_req_check_error(r, ret, true)) {
+        g_free(data);
+        goto done;
+    }
+
+    block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
+    scsi_req_unref(&r->req);
+    g_free(data);
+
+done:
+    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
+}
+
+static void scsi_disk_emulate_get_lba_status(SCSIRequest *req, uint8_t *outbuf)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    GetLbaStatusCBData *data;
+    uint32_t *num_blocks;
+    uint32_t *is_deallocated;
+
+    data = g_new0(GetLbaStatusCBData, 1);
+    data->r = r;
+    num_blocks = &(data->num_blocks);
+    is_deallocated = &(data->is_deallocated);
+
+    scsi_req_ref(&r->req);
+    scsi_get_lba_status_complete_noio(data, 0);
+
+    /*
+     * 8 + 16 is the length in bytes of response header and
+     * one LBA status descriptor
+     */
+    memset(outbuf, 0, 8 + 16);
+    outbuf[3] = 20;
+    outbuf[8] = (req->cmd.lba >> 56) & 0xff;
+    outbuf[9] = (req->cmd.lba >> 48) & 0xff;
+    outbuf[10] = (req->cmd.lba >> 40) & 0xff;
+    outbuf[11] = (req->cmd.lba >> 32) & 0xff;
+    outbuf[12] = (req->cmd.lba >> 24) & 0xff;
+    outbuf[13] = (req->cmd.lba >> 16) & 0xff;
+    outbuf[14] = (req->cmd.lba >> 8) & 0xff;
+    outbuf[15] = req->cmd.lba & 0xff;
+    outbuf[16] = (*num_blocks >> 24) & 0xff;
+    outbuf[17] = (*num_blocks >> 16) & 0xff;
+    outbuf[18] = (*num_blocks >> 8) & 0xff;
+    outbuf[19] = *num_blocks & 0xff;
+    outbuf[20] = *is_deallocated ? 1 : 0;
+}
+
 static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
@@ -2076,6 +2159,13 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
 
             /* Protection, exponent and lowest lba field left blank. */
             break;
+        } else if ((req->cmd.buf[1] & 31) == SAI_GET_LBA_STATUS) {
+            if (req->cmd.lba > s->qdev.max_lba) {
+                goto illegal_lba;
+            }
+            scsi_disk_emulate_get_lba_status(req, outbuf);
+            r->iov.iov_len = req->cmd.xfer;
+            return r->iov.iov_len;
         }
         trace_scsi_disk_emulate_command_SAI_unsupported();
         goto illegal_request;
diff --git a/include/block/accounting.h b/include/block/accounting.h
index 878b4c3581..645014fb0b 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -38,6 +38,7 @@ enum BlockAcctType {
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
     BLOCK_ACCT_UNMAP,
+    BLOCK_ACCT_GET_LBA_STATUS,
     BLOCK_MAX_IOTYPE,
 };
 
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 874176019e..b18377b214 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -154,6 +154,7 @@
  * SERVICE ACTION IN subcodes
  */
 #define SAI_READ_CAPACITY_16  0x10
+#define SAI_GET_LBA_STATUS    0x12
 
 /*
  * READ POSITION service action codes
-- 
2.26.0



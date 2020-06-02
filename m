Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F9FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110C9206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 07:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZTuFCuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110C9206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg1aH-0005pT-89
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 03:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <morecache@gmail.com>)
 id 1jg1ZM-00046k-HL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:42:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <morecache@gmail.com>)
 id 1jg1ZL-0000a3-QE
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 03:42:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so2270514wrr.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 00:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lSNxJ+he1VqHG88avCPlJcq6eRPaf7eHxjBV+zd6EhI=;
 b=kZTuFCuMjB3ghBIgMQ0K9uRPLmJWGOcOVynrHoAsZqekzg/xKbK9woa7hBqkXtDmJv
 Nenln085oeOakQLqltvMCp/FEdcoF6FSZraZNdWi0Ev5vgY3r83h0Yx6c3AVm/LlFkiC
 PuUxtPkjAV8OKXzpdnklCc2389JpCA2jYO78tc49XWHiyMyqeLN6rSnql0PlduiFKkIh
 8vSs5s4JPyBA3VAWc6kArp426KNNBlc6ecfk4bqe6gSN5cy6OZolxz+VxD4KFv7fTZOA
 BwPRZN2mnMCO9Tsyba3Mn/dvlEJmXKMNI/bpCsPUUOPL1FAsDZHq2yj+FQUJprRqp9U/
 Ruqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=lSNxJ+he1VqHG88avCPlJcq6eRPaf7eHxjBV+zd6EhI=;
 b=Oen859da21EblgiYqXIybhwRY4eTXTTROBULNTJdR4nKG6UM9YcgNg5KGi5/FNec1R
 cTeOgzwTYV0DpDY4JOZzLFEz6KHrbmg7IHNFj7l87DUIUf8xIFGNnlRFIYmtUzOTVWd4
 Bj/Uf4Pt2JUz1L48Bi6aklvPJBMtfKpuMqNkpZxVHNCs+8b2pJv8gIP5f00Mic3HPTF9
 yuZPEeOEnZQSmk35OgdSNx+pctF3KWb0D6ZeAaVFJAa/m0xtTo1tXtbb1C2xqJBYX0u5
 I39j7Tu9IvLJhaFnw6zSTHQKSXNzgMlN8+TQvufQ8sUoJGZr5njBKCSs28EhHsLXqI9e
 bB9Q==
X-Gm-Message-State: AOAM5302A6k4y4OqI30SlV3aPrECB7qoYSxSJPb30g478PohyPZZRX/G
 S+doFAzLhBnwFJMBpC6whcYNhXSOOiI=
X-Google-Smtp-Source: ABdhPJx37iEAkXIMtWiY0UI6lVC5EbjpCaKyW+Z5CJuc7DiZR3OYR5+09G5Q1OcpEB+B/L4Il0+Agw==
X-Received: by 2002:adf:f186:: with SMTP id h6mr23913799wro.22.1591083762300; 
 Tue, 02 Jun 2020 00:42:42 -0700 (PDT)
Received: from t440p.suse.asia (60-251-47-115.HINET-IP.hinet.net.
 [60.251.47.115])
 by smtp.gmail.com with ESMTPSA id w3sm2294518wmg.44.2020.06.02.00.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 00:42:41 -0700 (PDT)
From: Lin Ma <lma@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] scsi-disk: Add support for the GET LBA STATUS 16 command
Date: Tue,  2 Jun 2020 15:42:01 +0800
Message-Id: <20200602074201.10879-5-lma@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200602074201.10879-1-lma@suse.com>
References: <20200602074201.10879-1-lma@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=morecache@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, stefanha@redhat.com, Lin Ma <lma@suse.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Lin Ma <lma@suse.com>
---
 hw/scsi/scsi-disk.c      | 92 ++++++++++++++++++++++++++++++++++++++++
 include/scsi/constants.h |  1 +
 2 files changed, 93 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 387503e11b..2d2c6b4b82 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1866,6 +1866,91 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
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
+    return;
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
+    /* 8 + 16 is the length in bytes of response header and
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
+
+    return;
+}
+
 static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
@@ -2076,6 +2161,13 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
 
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
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 874176019e..1b6417898a 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -154,6 +154,7 @@
  * SERVICE ACTION IN subcodes
  */
 #define SAI_READ_CAPACITY_16  0x10
+#define SAI_GET_LBA_STATUS  0x12
 
 /*
  * READ POSITION service action codes
-- 
2.24.0



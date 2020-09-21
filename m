Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15EBC4346F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1B5239D1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEfiBlN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1B5239D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOls-0006Pj-2s
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhm-0004WE-Oh
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25381)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhk-0007RV-Dz
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600705811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3VSohO81qj1Qy9GMUYU8rCdXvyUaEcpLhj6tPxRG5I=;
 b=FEfiBlN+hmGU9ysVWNegYuWrvEmJ23wMUtkZ7OOQTLU0oa/ghSu1GKE+oOUt9tnpeDQvxF
 ujGGXdtYBE6tmpUO5DUFSPAks832ErtUEV03o8kPgIFHIDcLnv0Mcpb+C7Gfw2hd64z2/E
 ncPrVjRJnmtfXk3tbCOheHYO4V3i4Qw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-bm23Jyp0P62dA4v0hldadw-1; Mon, 21 Sep 2020 12:30:07 -0400
X-MC-Unique: bm23Jyp0P62dA4v0hldadw-1
Received: by mail-wr1-f70.google.com with SMTP id a12so6094587wrg.13
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 09:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w3VSohO81qj1Qy9GMUYU8rCdXvyUaEcpLhj6tPxRG5I=;
 b=Yq1WpIztc+mxmNND2mbh1dF3xm2d4eeQ1wVYJxA0k+BQaDg1TRf0+kjdj7f+Kto3Lw
 djOEPgSMeW9pa5L1LrqIPxGIbJZGecI6NTbfgFtYHrfXOdbmWW9f7R33mzZuqAN0ia0U
 6HY51E4n5zbbbgM7IjBRKgf7yfkCjYl8a1Ps8f8Tdbg1T0fu5hbaK4wp+ENPVoCvNskQ
 H3BdOZWmLS/klJ3Xlbj0vkOEncW90dhWg0fOoS+/B2Q8rzUGiqPa6cw5nREIRRWMgocZ
 v/8J2OO8i0JsZSeACpJP7Ob58pngBJCMI8eZ+lUWYtXuJzC3c3oT1A82JATdE7e8ifaM
 QnPg==
X-Gm-Message-State: AOAM530v98RkMV8UBrggyPySfBiGcrDUSzAGCAqlWmFwXmXVlyGpWGMg
 S1kP+cqk4U6YgX4FIZd9byn5Xnm6UT1gvg0EncEqoM6coYjPTbyusarv3DiQTdfana8KmpVPxdx
 G0KMH09+T7YusvCI=
X-Received: by 2002:adf:fa02:: with SMTP id m2mr563558wrr.273.1600705806549;
 Mon, 21 Sep 2020 09:30:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuDGMPIjXlDaa/Q2cAnMtwWTcDs/LdCrlPAtloxT7TwCerzSsyfhCE1mhYxu9hvZLyV2rIhw==
X-Received: by 2002:adf:fa02:: with SMTP id m2mr563529wrr.273.1600705806306;
 Mon, 21 Sep 2020 09:30:06 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id c4sm22477296wrp.85.2020.09.21.09.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 09:30:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/6] block/nvme: Reduce I/O registers scope
Date: Mon, 21 Sep 2020 18:29:46 +0200
Message-Id: <20200921162949.553863-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921162949.553863-1-philmd@redhat.com>
References: <20200921162949.553863-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only access the I/O register in nvme_init().
Remove the reference in BDRVNVMeState and reduce its scope.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 3c834da8fec..e517c7539ff 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -98,7 +98,6 @@ enum {
 struct BDRVNVMeState {
     AioContext *aio_context;
     QEMUVFIOState *vfio;
-    NVMeRegs *regs;
     /* Memory mapped registers */
     volatile struct {
         uint32_t sq_tail;
@@ -695,6 +694,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     uint64_t timeout_ms;
     uint64_t deadline, now;
     Error *local_err = NULL;
+    NVMeRegs *regs;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -713,16 +713,16 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         goto out;
     }
 
-    s->regs = qemu_vfio_pci_map_bar(s->vfio, 0, 0, sizeof(NvmeBar),
-                                    PROT_READ | PROT_WRITE, errp);
-    if (!s->regs) {
+    regs = qemu_vfio_pci_map_bar(s->vfio, 0, 0, sizeof(NvmeBar),
+                                 PROT_READ | PROT_WRITE, errp);
+    if (!regs) {
         ret = -EINVAL;
         goto out;
     }
     /* Perform initialize sequence as described in NVMe spec "7.6.1
      * Initialization". */
 
-    cap = le64_to_cpu(s->regs->ctrl.cap);
+    cap = le64_to_cpu(regs->ctrl.cap);
     if (!(cap & (1ULL << 37))) {
         error_setg(errp, "Device doesn't support NVMe command set");
         ret = -EINVAL;
@@ -735,10 +735,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
 
     /* Reset device to get a clean state. */
-    s->regs->ctrl.cc = cpu_to_le32(le32_to_cpu(s->regs->ctrl.cc) & 0xFE);
+    regs->ctrl.cc = cpu_to_le32(le32_to_cpu(regs->ctrl.cc) & 0xFE);
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
-    while (le32_to_cpu(s->regs->ctrl.csts) & 0x1) {
+    while (le32_to_cpu(regs->ctrl.csts) & 0x1) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
                              PRId64 " ms)",
@@ -766,18 +766,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
     s->nr_queues = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
-    s->regs->ctrl.aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
-    s->regs->ctrl.asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
-    s->regs->ctrl.acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
+    regs->ctrl.aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
+    regs->ctrl.asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
+    regs->ctrl.acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
-    s->regs->ctrl.cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
+    regs->ctrl.cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
                               (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
                               0x1);
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     deadline = now + timeout_ms * 1000000;
-    while (!(le32_to_cpu(s->regs->ctrl.csts) & 0x1)) {
+    while (!(le32_to_cpu(regs->ctrl.csts) & 0x1)) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
                              PRId64 " ms)",
@@ -808,6 +808,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         ret = -EIO;
     }
 out:
+    if (regs) {
+        qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)regs, 0, sizeof(NvmeBar));
+    }
+
     /* Cleaning up is done in nvme_file_open() upon error. */
     return ret;
 }
@@ -882,7 +886,6 @@ static void nvme_close(BlockDriverState *bs)
     event_notifier_cleanup(&s->irq_notifier[MSIX_SHARED_IRQ_IDX]);
     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->doorbells,
                             sizeof(NvmeBar), NVME_DOORBELL_SIZE);
-    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, sizeof(NvmeBar));
     qemu_vfio_close(s->vfio);
 
     g_free(s->device);
-- 
2.26.2



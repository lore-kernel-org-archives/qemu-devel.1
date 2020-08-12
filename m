Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D353120774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsntDiTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D353120774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vsA-0005Av-U4
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpk-0008Pi-Lm
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27249
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpi-0004dJ-Jx
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLPhS882HiIE0uYLR21hv6KtczqCogQ4mTGHTp54OcQ=;
 b=FsntDiTc79qLQHQQDINxCYvf7MUKpO7ZWFQMv0Oe2RqI7uXpZsm505tf2XJ1SlcLcSRbUK
 xO+KHqNNaDkcA6JhaRnxNjAeNaeh+wws8UuWKbQO7ZyfbtKba1fKFPi1BABMtRfRM+N2bk
 gZEoQVV00jgF/zu6mEiLQRvnH9NTtrU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-Uyim7hphM_C7CG9EYjqOOQ-1; Wed, 12 Aug 2020 14:50:40 -0400
X-MC-Unique: Uyim7hphM_C7CG9EYjqOOQ-1
Received: by mail-wm1-f71.google.com with SMTP id v8so962339wma.6
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MLPhS882HiIE0uYLR21hv6KtczqCogQ4mTGHTp54OcQ=;
 b=fLYrLfJXpf9lxNL+ReqnhnzTQitY5VKPKsRhEx8f5mfUzP8lrHBb/OlGZkLDPBWQFo
 8l2f8CbmMsiph+CBXBqsRQhB1Z2RViX70HYB0Z7xosIOF2wrtK14BzeBby/IxziXvsF9
 KVaw/Iq87aKendEF9tVPqxDSvs1yy4Zdk37iBeICUGeb/z0kXuw29C8izWCn7WFQTsjW
 /n8tw5Jzy2A7G2s8qRmil3cNm51xY1+z2vZepZ4AZo3hdLJSIPDncJP8pNjgca1IFyny
 b9EC38SMVPHHqpAc/e3Bf7lPc5etHn6cJ+zFgfOIgmcfNwDR5daqPfG2RFUFmYGpQIDT
 bnoA==
X-Gm-Message-State: AOAM531ei0t1NrXftumY/OIutOC2oVrDI8x+GhaB0FNIoeNaVPEijD7k
 RyLGqezsC8uPJxwfQCOysjym1fr1dTewTCNVcW98Z3gy+QvqGRD6VkqL3SONSN1P47Vx21hPJ0c
 1fJ4bmHY142M1UdE=
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr562606wrw.148.1597258239017; 
 Wed, 12 Aug 2020 11:50:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFv6XPe2TUoXbosM2M6TzpTawwp0cuiMvcq+QDZjEZfSgWn+3QuxmP1aM00kxaQxVL353t4A==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr562590wrw.148.1597258238814; 
 Wed, 12 Aug 2020 11:50:38 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c4sm5525319wrt.41.2020.08.12.11.50.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:50:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/14] block/nvme: Define INDEX macros to ease code review
Date: Wed, 12 Aug 2020 20:50:04 +0200
Message-Id: <20200812185014.18267-5-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:50:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use definitions instead of '0' or '1' indexes. Also this will
be useful when using multi-queues later.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index e1893b4e79..003809fbd8 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -103,6 +103,9 @@ typedef volatile struct {
 
 QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
 
+#define INDEX_ADMIN     0
+#define INDEX_IO(n)     (1 + n)
+
 struct BDRVNVMeState {
     AioContext *aio_context;
     QEMUVFIOState *vfio;
@@ -531,7 +534,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     }
     cmd.prp1 = cpu_to_le64(iova);
 
-    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to identify controller");
         goto out;
     }
@@ -555,7 +558,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
-    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to identify namespace");
         goto out;
     }
@@ -644,7 +647,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 = cpu_to_le32(0x3),
     };
-    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
@@ -655,7 +658,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 = cpu_to_le32(0x1 | (n << 16)),
     };
-    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create io queue [%d]", n);
         nvme_free_queue_pair(q);
         return false;
@@ -739,16 +742,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[0] = nvme_create_queue_pair(bs, 0, NVME_QUEUE_SIZE, errp);
-    if (!s->queues[0]) {
+    s->queues[INDEX_ADMIN] = nvme_create_queue_pair(bs, 0,
+                                                          NVME_QUEUE_SIZE,
+                                                          errp);
+    if (!s->queues[INDEX_ADMIN]) {
         ret = -EINVAL;
         goto out;
     }
     s->nr_queues = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
     s->regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
-    s->regs->asq = cpu_to_le64(s->queues[0]->sq.iova);
-    s->regs->acq = cpu_to_le64(s->queues[0]->cq.iova);
+    s->regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
+    s->regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
     s->regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
@@ -839,7 +844,7 @@ static int nvme_enable_disable_write_cache(BlockDriverState *bs, bool enable,
         .cdw11 = cpu_to_le32(enable ? 0x01 : 0x00),
     };
 
-    ret = nvme_cmd_sync(bs, s->queues[0], &cmd);
+    ret = nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd);
     if (ret) {
         error_setg(errp, "Failed to configure NVMe write cache");
     }
@@ -1056,7 +1061,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
 {
     int r;
     BDRVNVMeState *s = bs->opaque;
-    NVMeQueuePair *ioq = s->queues[1];
+    NVMeQueuePair *ioq = s->queues[INDEX_IO(0)];
     NVMeRequest *req;
 
     uint32_t cdw12 = (((bytes >> s->blkshift) - 1) & 0xFFFF) |
@@ -1171,7 +1176,7 @@ static coroutine_fn int nvme_co_pwritev(BlockDriverState *bs,
 static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
 {
     BDRVNVMeState *s = bs->opaque;
-    NVMeQueuePair *ioq = s->queues[1];
+    NVMeQueuePair *ioq = s->queues[INDEX_IO(0)];
     NVMeRequest *req;
     NvmeCmd cmd = {
         .opcode = NVME_CMD_FLUSH,
@@ -1202,7 +1207,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
                                               BdrvRequestFlags flags)
 {
     BDRVNVMeState *s = bs->opaque;
-    NVMeQueuePair *ioq = s->queues[1];
+    NVMeQueuePair *ioq = s->queues[INDEX_IO(0)];
     NVMeRequest *req;
 
     uint32_t cdw12 = ((bytes >> s->blkshift) - 1) & 0xFFFF;
@@ -1255,7 +1260,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
                                          int bytes)
 {
     BDRVNVMeState *s = bs->opaque;
-    NVMeQueuePair *ioq = s->queues[1];
+    NVMeQueuePair *ioq = s->queues[INDEX_IO(0)];
     NVMeRequest *req;
     NvmeDsmRange *buf;
     QEMUIOVector local_qiov;
@@ -1398,7 +1403,7 @@ static void nvme_aio_unplug(BlockDriverState *bs)
     BDRVNVMeState *s = bs->opaque;
     assert(s->plugged);
     s->plugged = false;
-    for (i = 1; i < s->nr_queues; i++) {
+    for (i = INDEX_IO(0); i < s->nr_queues; i++) {
         NVMeQueuePair *q = s->queues[i];
         qemu_mutex_lock(&q->lock);
         nvme_kick(q);
-- 
2.21.3



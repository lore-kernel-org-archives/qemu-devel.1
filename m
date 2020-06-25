Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C49C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44684206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGVr6P6S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44684206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX0A-0006TF-Gg
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvm-0007rh-9n
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57957
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWvk-0000wp-L1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3lKu2bLyLD7fPfOalxcX/nhKuHHYEWSy1yNdZN63cz4=;
 b=VGVr6P6SuHMcojTKL7E3ggQ+wPXnkaze5ibaE32uNlFFzlOJDMvQFdrlBQ4Txmf7QQBAbb
 SIbTx6HXYi1A+30X400NHZHjDibVrmeShbK56qxWMOV2bOur29MVLiN/MP7dybQd2LTTJ6
 I6frZHStnL9yG51HFhzNsigvYm2fYEg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-eBZj8wxTOfC0_7MVoR3Mzg-1; Thu, 25 Jun 2020 14:48:56 -0400
X-MC-Unique: eBZj8wxTOfC0_7MVoR3Mzg-1
Received: by mail-wm1-f70.google.com with SMTP id a21so7770596wmd.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3lKu2bLyLD7fPfOalxcX/nhKuHHYEWSy1yNdZN63cz4=;
 b=Cy/JMBaYsUaipyrckOVEg7shzKRrp1MPVmK7ewwVND9UoCZq48Qv8qN2NmDAosZWMo
 dkTe1+8bNzpOsQsjO0vjoWxR9maY+hcch7YeXSdYXk2G252SINAWrDValryETXbJeK9u
 lzmaicAx+5MBQ8IXyN4yJmrvAKcEv6iQJs89yOb3bIB/tHXG+2KHRQj7jzJ5PNVygij/
 xEKo+Y67ZhdQJkqkaBmxVELHQyZ8UltRVinncrorXSjhQUCVd+Hv5oQX2/hBhtnJhqGX
 2gdeKanQvf4GGAeI0YxxyqZo1mOmXmEiIFYi7eSY2FmjE8IK8p0Ej3o90qqCQuoF4p3r
 013g==
X-Gm-Message-State: AOAM530cbKnlEjMabZ0FifMOJQhnXHDh0FPg4Oxln2rfHvrXzyyldMRe
 d+tBdx/024oTw880NIUVfIUJXpObTgBshT2FdtImHiUlAoLdW3ZyWG2zgvJmxEsnoQM4CmsSnWL
 lTwErRmeJqz/0Aq4=
X-Received: by 2002:a5d:4649:: with SMTP id j9mr7478237wrs.270.1593110934888; 
 Thu, 25 Jun 2020 11:48:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx450ca/v+IpqoY6PdDyrswPoGGtcjmNYWJ9pzcdZReqGBpyZBRt1O3d+kPTyF+bubzeG8gOg==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr7478221wrs.270.1593110934658; 
 Thu, 25 Jun 2020 11:48:54 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id f14sm16513976wro.90.2020.06.25.11.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:48:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 03/17] block/nvme: Define QUEUE_INDEX macros to ease code
 review
Date: Thu, 25 Jun 2020 20:48:24 +0200
Message-Id: <20200625184838.28172-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use definitions instead of '0' or '1' indexes. Also this will
be useful when using multi-queues later.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index ec0dd21b6e..71f8cf27a8 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -89,6 +89,9 @@ typedef volatile struct {
 
 QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
 
+#define QUEUE_INDEX_ADMIN   0
+#define QUEUE_INDEX_IO(n)   (1 + n)
+
 typedef struct {
     AioContext *aio_context;
     QEMUVFIOState *vfio;
@@ -459,7 +462,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     }
     cmd.prp1 = cpu_to_le64(iova);
 
-    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+    if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to identify controller");
         goto out;
     }
@@ -483,7 +486,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
-    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+    if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to identify namespace");
         goto out;
     }
@@ -560,7 +563,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 = cpu_to_le32(0x3),
     };
-    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+    if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create io queue [%d]", n);
         nvme_free_queue_pair(bs, q);
         return false;
@@ -571,7 +574,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
         .cdw11 = cpu_to_le32(0x1 | (n << 16)),
     };
-    if (nvme_cmd_sync(bs, s->queues[0], &cmd)) {
+    if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create io queue [%d]", n);
         nvme_free_queue_pair(bs, q);
         return false;
@@ -655,16 +658,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[0] = nvme_create_queue_pair(bs, 0, NVME_QUEUE_SIZE, errp);
-    if (!s->queues[0]) {
+    s->queues[QUEUE_INDEX_ADMIN] = nvme_create_queue_pair(bs, 0,
+                                                          NVME_QUEUE_SIZE,
+                                                          errp);
+    if (!s->queues[QUEUE_INDEX_ADMIN]) {
         ret = -EINVAL;
         goto out;
     }
     s->nr_queues = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
     s->regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
-    s->regs->asq = cpu_to_le64(s->queues[0]->sq.iova);
-    s->regs->acq = cpu_to_le64(s->queues[0]->cq.iova);
+    s->regs->asq = cpu_to_le64(s->queues[QUEUE_INDEX_ADMIN]->sq.iova);
+    s->regs->acq = cpu_to_le64(s->queues[QUEUE_INDEX_ADMIN]->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
     s->regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
@@ -755,7 +760,7 @@ static int nvme_enable_disable_write_cache(BlockDriverState *bs, bool enable,
         .cdw11 = cpu_to_le32(enable ? 0x01 : 0x00),
     };
 
-    ret = nvme_cmd_sync(bs, s->queues[0], &cmd);
+    ret = nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd);
     if (ret) {
         error_setg(errp, "Failed to configure NVMe write cache");
     }
@@ -972,7 +977,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
 {
     int r;
     BDRVNVMeState *s = bs->opaque;
-    NVMeQueuePair *ioq = s->queues[1];
+    NVMeQueuePair *ioq = s->queues[QUEUE_INDEX_IO(0)];
     NVMeRequest *req;
 
     uint32_t cdw12 = (((bytes >> s->blkshift) - 1) & 0xFFFF) |
@@ -1087,7 +1092,7 @@ static coroutine_fn int nvme_co_pwritev(BlockDriverState *bs,
 static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
 {
     BDRVNVMeState *s = bs->opaque;
-    NVMeQueuePair *ioq = s->queues[1];
+    NVMeQueuePair *ioq = s->queues[QUEUE_INDEX_IO(0)];
     NVMeRequest *req;
     NvmeCmd cmd = {
         .opcode = NVME_CMD_FLUSH,
@@ -1118,7 +1123,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
                                               BdrvRequestFlags flags)
 {
     BDRVNVMeState *s = bs->opaque;
-    NVMeQueuePair *ioq = s->queues[1];
+    NVMeQueuePair *ioq = s->queues[QUEUE_INDEX_IO(0)];
     NVMeRequest *req;
 
     uint32_t cdw12 = ((bytes >> s->blkshift) - 1) & 0xFFFF;
@@ -1171,7 +1176,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
                                          int bytes)
 {
     BDRVNVMeState *s = bs->opaque;
-    NVMeQueuePair *ioq = s->queues[1];
+    NVMeQueuePair *ioq = s->queues[QUEUE_INDEX_IO(0)];
     NVMeRequest *req;
     NvmeDsmRange *buf;
     QEMUIOVector local_qiov;
@@ -1300,7 +1305,7 @@ static void nvme_aio_unplug(BlockDriverState *bs)
     BDRVNVMeState *s = bs->opaque;
     assert(s->plugged);
     s->plugged = false;
-    for (i = 1; i < s->nr_queues; i++) {
+    for (i = QUEUE_INDEX_IO(0); i < s->nr_queues; i++) {
         NVMeQueuePair *q = s->queues[i];
         qemu_mutex_lock(&q->lock);
         nvme_kick(s, q);
-- 
2.21.3



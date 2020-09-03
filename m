Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235D6C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF29B20639
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYffjeW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF29B20639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoSJ-0000c5-RR
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLu-00086l-GG
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoLs-0007p1-LK
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EBREVqe86w/qV8xj/jHdOJ+D9gTNwJHNOwqeZKQd6RY=;
 b=LYffjeW2WX3s33oSYh17XwfdAhDQ6AwCxN3C6BXVvLXqRRzmBc9ynKSs2ceM1B4xMLuuXp
 n78Jqk4Y4940K/PF72U51Re/r/59ww9so3SrKBg7kCjh5fWtOzqaQbC0VXNftwlxbPh2BY
 +o55z5yVxXHOMFWISIH0TIxfJI+Xx3A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-AzyYNjP1O2-Gt9CAgr49Xw-1; Thu, 03 Sep 2020 08:28:26 -0400
X-MC-Unique: AzyYNjP1O2-Gt9CAgr49Xw-1
Received: by mail-wm1-f70.google.com with SMTP id c198so920091wme.5
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EBREVqe86w/qV8xj/jHdOJ+D9gTNwJHNOwqeZKQd6RY=;
 b=bM18uMbSTZ29gYV2XQzIrf7/ceDB8QBaTscNwmwx68tkxj+DjfBlZCfGa6mPdehjwt
 U9mCVmca41Vy3NX1A4F5AZ1w3B5uGsvSksIIIa0F+ltYnTdp4f+pGT0xg0gBClJXpV66
 S5uCBQQMr/ToSHuyRN31lyWZKU0X9yy8v2Pe3ppxL6c35g2soJYkBeR/TQEHLWE8Myw+
 qq6+6ytzuA+q9oNMG2xCkyazRkf6fYv5Bqi3MFlg92IFSI0mqkdSqcWnIFTYZzsIKFgl
 zJGXb7sYFADfslJLH/WdGAmO+prRVHbD0syBLNPk+DJU852HQQNIpWGEI0r0KkEXtVw7
 yueA==
X-Gm-Message-State: AOAM533BBrXBnYDMsgi12xu2lv2jrlLwxKwH8is606x1SV/PPVJwDLVT
 6dq2J5cFIJoCAFT1KEBrA121sOe5k8pwfEBjPHhkInUAo0720qdXADW/n0mgDg85z84Y1gg6qIl
 yWBvfWZpo5h7JW8g=
X-Received: by 2002:adf:f149:: with SMTP id y9mr2152343wro.93.1599136105025;
 Thu, 03 Sep 2020 05:28:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym8SdPMuTrQF/qKRC4BamPWHAPQNevAOuB6lz85pdqrdqAmnSUHoQARZi2v12uTEjpcCjfkQ==
X-Received: by 2002:adf:f149:: with SMTP id y9mr2152315wro.93.1599136104771;
 Thu, 03 Sep 2020 05:28:24 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id s124sm4227408wme.29.2020.09.03.05.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 04/15] block/nvme: Define INDEX macros to ease code review
Date: Thu,  3 Sep 2020 14:27:52 +0200
Message-Id: <20200903122803.405265-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use definitions instead of '0' or '1' indexes. Also this will
be useful when using multi-queues later.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index ca8b039f4f0..488d4ddb3b8 100644
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
     cmd.dptr.prp1 = cpu_to_le64(iova);
 
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
2.26.2



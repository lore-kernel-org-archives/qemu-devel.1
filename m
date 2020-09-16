Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1BDC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2D321D7D
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BN2tr5Hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2D321D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIeG9-000823-Ip
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 16:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIeE9-0006IO-Cl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 16:40:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIeE2-0002y6-R8
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 16:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600288820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qm07GWZnH+HjHqIDhmqiLd8bzLDbx2r61BRcywFirDc=;
 b=BN2tr5Hxz7Xh4CCJnT0mvh8CNCNyH6leEjTOjnCJZHdr2CbjkRs4EkqkBja65F8y4D51Hj
 9pp2cjHueW88bjdOKMdquZ4+YTfmbrfFvje5VvJRjPeuSAtiCfCRNGsCiC7mzMEnJh9KVj
 faSD5QeKLq1eS7KAeEpUxZ/1HZDFiac=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-JSDIBgpENdqjohMlyhQmPw-1; Wed, 16 Sep 2020 16:40:19 -0400
X-MC-Unique: JSDIBgpENdqjohMlyhQmPw-1
Received: by mail-wr1-f70.google.com with SMTP id i10so3002702wrq.5
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 13:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qm07GWZnH+HjHqIDhmqiLd8bzLDbx2r61BRcywFirDc=;
 b=Hj0QlicGWkrLp7QuYR6Pk1XtkQxpBPBubQO2Gwryel/sjku4L1lqDV117ZrB8JT9pe
 xjxYba5F8dMQT+li5oZjHT3HCcD4uD0L7jK4U+y07nZxlJLhukmmMq/PT25K4Nx9EK50
 co4hzV5UYZUiqW2D1B4pSJW3oeKF6DvMX4u7ArDwDhqvwsj1Qy5sO6z1ggN+gMowwP9H
 tBKHZj7BEkQYoI1XkLWAnhqiFgqNkGExJqkhlVvufSAB2UJKQ0v6SZTQ80BWGde/1CRS
 RRHBTAGi+Sz26/RUgFmmpxs1uakngwqun4SGEPuWdddhuqIrorBtZDHU7ulkusaDhFuk
 hJ1A==
X-Gm-Message-State: AOAM532RIlSgzOK/S/WdysxfFjYRtmo64YV/N+JJZE6A9w+S3+1KzfUf
 0cfQpg9tKCGxBUDabTXUDqeD7uJCAsYk2tC7wlK3lt88RAzz6YdgeLs466JQsSGbOjgquMZ3aJH
 PDrPcu8pLdNV7eB8=
X-Received: by 2002:adf:aa84:: with SMTP id h4mr273537wrc.426.1600288817052;
 Wed, 16 Sep 2020 13:40:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7vEST5Ur8LVeJIobOz4HPFX+nugYdCKv8TmedVNUleIL4s45qOXqiXs5SnyjaQpNfB6P+cQ==
X-Received: by 2002:adf:aa84:: with SMTP id h4mr273514wrc.426.1600288816798;
 Wed, 16 Sep 2020 13:40:16 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 10sm7341031wmi.37.2020.09.16.13.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 13:40:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] block/nvme: Use atomic operations instead of 'volatile'
 keyword
Date: Wed, 16 Sep 2020 22:40:03 +0200
Message-Id: <20200916204004.1511985-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916204004.1511985-1-philmd@redhat.com>
References: <20200916204004.1511985-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Follow docs/devel/atomics.rst guidelines and use atomic operations.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index b91749713e0..be80ea1f410 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -46,7 +46,7 @@ typedef struct {
     uint8_t  *queue;
     uint64_t iova;
     /* Hardware MMIO register */
-    volatile uint32_t *doorbell;
+    uint32_t *doorbell;
 } NVMeQueue;
 
 typedef struct {
@@ -82,7 +82,7 @@ typedef struct {
 } NVMeQueuePair;
 
 /* Memory mapped registers */
-typedef volatile struct {
+typedef struct {
     NvmeBar ctrl;
     struct {
         uint32_t sq_tail;
@@ -273,8 +273,7 @@ static void nvme_kick(NVMeQueuePair *q)
     trace_nvme_kick(s, q->index);
     assert(!(q->sq.tail & 0xFF00));
     /* Fence the write to submission queue entry before notifying the device. */
-    smp_wmb();
-    *q->sq.doorbell = cpu_to_le32(q->sq.tail);
+    atomic_rcu_set(q->sq.doorbell, cpu_to_le32(q->sq.tail));
     q->inflight += q->need_kick;
     q->need_kick = 0;
 }
@@ -414,8 +413,7 @@ static bool nvme_process_completion(NVMeQueuePair *q)
     }
     if (progress) {
         /* Notify the device so it can post more completions. */
-        smp_mb_release();
-        *q->cq.doorbell = cpu_to_le32(q->cq.head);
+        atomic_store_release(q->cq.doorbell, cpu_to_le32(q->cq.head));
         nvme_wake_free_req_locked(q);
     }
 
@@ -433,8 +431,7 @@ static void nvme_process_completion_bh(void *opaque)
      * called aio_poll(). The callback may be waiting for further completions
      * so notify the device that it has space to fill in more completions now.
      */
-    smp_mb_release();
-    *q->cq.doorbell = cpu_to_le32(q->cq.head);
+    atomic_store_release(q->cq.doorbell, cpu_to_le32(q->cq.head));
     nvme_wake_free_req_locked(q);
 
     nvme_process_completion(q);
@@ -721,7 +718,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     /* Perform initialize sequence as described in NVMe spec "7.6.1
      * Initialization". */
 
-    cap = le64_to_cpu(s->regs->ctrl.cap);
+    cap = le64_to_cpu(atomic_read(&s->regs->ctrl.cap));
     if (!(cap & (1ULL << 37))) {
         error_setg(errp, "Device doesn't support NVMe command set");
         ret = -EINVAL;
@@ -734,10 +731,11 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
 
     /* Reset device to get a clean state. */
-    s->regs->ctrl.cc &= const_le32(0xFE);
+    atomic_set(&s->regs->ctrl.cc,
+               cpu_to_le32(atomic_read(&s->regs->ctrl.cc) & const_le32(0xFE)));
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
-    while (s->regs->ctrl.csts & const_le32(0x1)) {
+    while (atomic_read(&s->regs->ctrl.csts) & const_le32(0x1)) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
                              PRId64 " ms)",
@@ -758,18 +756,22 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
     s->nr_queues = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
-    s->regs->ctrl.aqa = const_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
-    s->regs->ctrl.asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
-    s->regs->ctrl.acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
+    atomic_set(&s->regs->ctrl.aqa,
+               const_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE));
+    atomic_set(&s->regs->ctrl.asq,
+               cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova));
+    atomic_set(&s->regs->ctrl.acq,
+               cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova));
 
     /* After setting up all control registers we can enable device now. */
-    s->regs->ctrl.cc = const_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
-                              (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
-                              0x1);
+    atomic_set(&s->regs->ctrl.cc,
+               const_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
+                          (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
+                          0x1));
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     deadline = now + timeout_ms * 1000000;
-    while (!(s->regs->ctrl.csts & const_le32(0x1))) {
+    while (!(atomic_read(&s->regs->ctrl.csts) & const_le32(0x1))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
                              PRId64 " ms)",
-- 
2.26.2



Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2641C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71992206DC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eas334//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71992206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOnR-0000LJ-Fd
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOho-0004ZI-Kx
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhm-0007Ru-DL
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600705816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FMAxBBU4xA4hxywxEtXVcIMFGGDQnTZkLrdHa6P7weY=;
 b=eas334///4NgIjNFlVGzJMGUYYhsiLRBrsv/2ULd/ZSFPTPaBozNwrF+ys3tPJ/I1BQVKZ
 rOvBEdm5X2MnwOsVmJ7KtkhS8GpTLZSmAANEPh88LfCreSMaHH27QB0fQgZ3vfBwCwODd3
 g0bUllVlZgHzNmb+q0JdKYZk3N2zzL8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-1m5LswMWMFejBZRQ64LMBA-1; Mon, 21 Sep 2020 12:30:13 -0400
X-MC-Unique: 1m5LswMWMFejBZRQ64LMBA-1
Received: by mail-wr1-f71.google.com with SMTP id w7so6124383wrp.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 09:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FMAxBBU4xA4hxywxEtXVcIMFGGDQnTZkLrdHa6P7weY=;
 b=ctNeayWTBITF5J6HrXC5CycNkTaUSQ1vVuG5p6IObUwll2ehQ6XRHPhZ/ceFkScWNG
 rqFgWjHoM37XCXPN3RJGEi5LimbUXEZ3xOJ2n1CTbFeDCwbkfPoEmVEua9Gla8ePr0Wk
 7FMh7fdpAp749bFdt097shHIAGDY4jjUQY2EJ+oM86LFDapHdogA4AUEvkcoOfpvtIxd
 E890PLYZuBNjUySqQ83AB3neJ3jFIbjvJykUCI62jBpqPYEgVFCg1L/Sm9WsWE6rasoM
 zPt+R149w40J0Z2wAzLukYeBs18gtudgXpoh9ND00MmFCvW66ESHtbqmuFkvghrSMQEE
 Ggfw==
X-Gm-Message-State: AOAM530/wSnqveR4HRwg09VJtagtgQlKbRkkbYpC/F7pJJDvUIDdljPl
 F7t4uNyM51CfyhZBy4c9uIA0WL0aBEJ78lFz0IO9LGrFQAW6M0kBnlk4R7+LRcJJn+VtqXC/KGA
 ZC8QxmboXxDqJLDQ=
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr201512wmg.164.1600705811740; 
 Mon, 21 Sep 2020 09:30:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKHKSmbEWFYlkMpEA9JJFVzHCJ6N5zFm4+VCgrxwIR4eGdI5IH/F1V3OEA/63qAmkNBHfM2w==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr201487wmg.164.1600705811494; 
 Mon, 21 Sep 2020 09:30:11 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id m10sm177258wmi.9.2020.09.21.09.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 09:30:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 4/6] block/nvme: Drop NVMeRegs structure, directly use NvmeBar
Date: Mon, 21 Sep 2020 18:29:47 +0200
Message-Id: <20200921162949.553863-5-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 04:38:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NVMeRegs only contains NvmeBar. Simplify the code by using NvmeBar
directly.

This triggers a checkpatch.pl error:

  ERROR: Use of volatile is usually wrong, please add a comment
  #30: FILE: block/nvme.c:691:
  +    volatile NvmeBar *regs;

This is a false positive as in our case we are using I/O registers,
so the 'volatile' use is justified.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index e517c7539ff..83bae6b2f13 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -81,11 +81,6 @@ typedef struct {
     QEMUBH      *completion_bh;
 } NVMeQueuePair;
 
-/* Memory mapped registers */
-typedef volatile struct {
-    NvmeBar ctrl;
-} NVMeRegs;
-
 #define INDEX_ADMIN     0
 #define INDEX_IO(n)     (1 + n)
 
@@ -694,7 +689,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     uint64_t timeout_ms;
     uint64_t deadline, now;
     Error *local_err = NULL;
-    NVMeRegs *regs;
+    volatile NvmeBar *regs;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -722,7 +717,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     /* Perform initialize sequence as described in NVMe spec "7.6.1
      * Initialization". */
 
-    cap = le64_to_cpu(regs->ctrl.cap);
+    cap = le64_to_cpu(regs->cap);
     if (!(cap & (1ULL << 37))) {
         error_setg(errp, "Device doesn't support NVMe command set");
         ret = -EINVAL;
@@ -735,10 +730,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
 
     /* Reset device to get a clean state. */
-    regs->ctrl.cc = cpu_to_le32(le32_to_cpu(regs->ctrl.cc) & 0xFE);
+    regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
-    while (le32_to_cpu(regs->ctrl.csts) & 0x1) {
+    while (le32_to_cpu(regs->csts) & 0x1) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
                              PRId64 " ms)",
@@ -766,18 +761,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
     s->nr_queues = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
-    regs->ctrl.aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
-    regs->ctrl.asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
-    regs->ctrl.acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
+    regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
+    regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
+    regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
-    regs->ctrl.cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
+    regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
                               (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
                               0x1);
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     deadline = now + timeout_ms * 1000000;
-    while (!(le32_to_cpu(regs->ctrl.csts) & 0x1)) {
+    while (!(le32_to_cpu(regs->csts) & 0x1)) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
                              PRId64 " ms)",
-- 
2.26.2



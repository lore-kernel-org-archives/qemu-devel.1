Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C9C4727E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F40AE23A69
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6ftMpzz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F40AE23A69
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdpx-0007S2-VY
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdp6-0005oY-SG
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdp4-0008DX-2p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600763929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0oUMbvSMybNmnNxDNxqBQV+vJ3XelXwsh3Q4bryO1QA=;
 b=g6ftMpzzoiqrPICcjAt1n/flzZUTZ4wDxT0GF5pR9ZG+/42kZNlWCcPV9RmzmR3JG08s0V
 e4AzNw2zgI9YNTg1t891qMF3i9tzvnSgGRtYLwxaX+iEXrLv+fLBTPrE0f+V6a0Wxn8tcI
 3y97UKdMqvWSO/DOz9RlfIPmVroEp4E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-DYrOfMKoOCS4Pyv_cgmtrg-1; Tue, 22 Sep 2020 04:38:46 -0400
X-MC-Unique: DYrOfMKoOCS4Pyv_cgmtrg-1
Received: by mail-wr1-f69.google.com with SMTP id v5so7044462wrs.17
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0oUMbvSMybNmnNxDNxqBQV+vJ3XelXwsh3Q4bryO1QA=;
 b=OxE3Y+V2OrYwGuHSBbb2W3KbPIXrvj+bZHJSc2kcW8WVWrynfcJFJUTO/uJbLbtDqb
 lCJ+hlIf8vVXhqxSInN1wGvBWWc4drALStNUkrlomH1bVZZYyNJ9+pI7saJCGZw1uFSm
 vwjhbwBh0YqvpfwKDiDpp4x2N9sqqbCocQPKjvjYbJzIQ7fWIDYoVx313c/za69w3/9U
 /97cTo/7Rs8APjSRLfUP/ogADO/28opT8XMgl4AT+y/iU3f/VxAChLacLP0ydJKkLWFs
 knv4MesqiqIQiWzv4Vk2s9cpNPfaGjHSoRmrWtVkrOQ9ypz3nJBPhQnjk04d5MW6qF/Z
 HPXA==
X-Gm-Message-State: AOAM530Iy9B/akNpT0ymoYGF6UTcJi+Mc09JdazosdGpUl6UZR4QYVFm
 xbKwIKAV3gQribeuV2Daq0WWXpu83R1yOfLZ2yfz5MLI3ddmGlDAAk7OdN0/YNN6HEecvlaE0x6
 DV4NwoQwkVJR4zRI=
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr4037247wru.248.1600763924458; 
 Tue, 22 Sep 2020 01:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoT63a4O62yTIZCWlOOnvcKmJ+6l9YijfzUd62oqIbvbXG5RnJkhxDcC4oNk4iulDEYZn9Hg==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr4037224wru.248.1600763924289; 
 Tue, 22 Sep 2020 01:38:44 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm3634947wme.12.2020.09.22.01.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 01:38:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 4/6] block/nvme: Drop NVMeRegs structure,
 directly use NvmeBar
Date: Tue, 22 Sep 2020 10:38:19 +0200
Message-Id: <20200922083821.578519-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922083821.578519-1-philmd@redhat.com>
References: <20200922083821.578519-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
index e517c7539ff..bd82990b66c 100644
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
+    volatile NvmeBar *regs = NULL;
 
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



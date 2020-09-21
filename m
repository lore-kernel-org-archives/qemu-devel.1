Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAFBC43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3594523998
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AczBFgg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3594523998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOop-0001e2-2P
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhx-0004j3-2J
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhq-0007Sl-9V
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600705821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vspmClAclQUpTq3+aAb1q9Vz9LFQ93oZxnmdQ7/mR4=;
 b=AczBFgg3m1KsBG357BTpJBUqdkXMn7DdndFLXtX/+0q36d1tkgVvpAwyrvAI4eOUMdblt0
 93AYhCxPBzzqrrN5POQUgqh7CsG0fTH62SnmxXr47FP9mVLwjLWVaOi3KC6EPPc0UjQCJM
 afc1Mf+3xPgMj5yiifOHwD03krZgQZk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-cv2pv6DFM5i5MhSotCZnrg-1; Mon, 21 Sep 2020 12:30:19 -0400
X-MC-Unique: cv2pv6DFM5i5MhSotCZnrg-1
Received: by mail-wr1-f71.google.com with SMTP id d9so6093467wrv.16
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 09:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+vspmClAclQUpTq3+aAb1q9Vz9LFQ93oZxnmdQ7/mR4=;
 b=I4K1fkFNTCQev5Tr4IWi9/gFZWE2JGsOMyRQ+F5BnS8uQbUYDJ8yiZEuUb7DA5o275
 7gXxuHlW2j87A5dc5hu++2XByHfhWW3neZj+cznzG8AlVnsv1emGnmSI3bOqmzdgWZOv
 am3517r8kjveEbqg47fhIVFhXe77YyAcjv6USQ+y2eg+G+FB5OqsYIIXMzOvEM4FCdi7
 7JueK6T9sHHwKqn7gjyGfXyy//SMmIc4lcbPxK4MzEadZdwdoQSPpNm1JRpGN86o4C6t
 HUSVvzXntmb0KsRSS2kXDSwuxj2F31OlkmsjAAIoeOzGLNe/D1kg7WxxnAR6MAX5i3os
 z2vA==
X-Gm-Message-State: AOAM53399hKl8EjRXBfthsdebStIFw4XzEOYzo/fPOmTv7mUEQdyHZ31
 zPG2eODxTnUdlHkwgGHzL0Qvl4p/3O1/d2gvEC1kT0aoiXRbxMB57qPekAM3JcDazqwfdcztWyS
 epC8pjDKoKz5tcYg=
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr593400wrn.238.1600705816978;
 Mon, 21 Sep 2020 09:30:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBe1lBO1v5Fdq7q+orSp7/mnoAJSOSkMPj14A7yw18rRjFNDh6xsmA4Sgc37fKjk3U9q2nbw==
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr593379wrn.238.1600705816798;
 Mon, 21 Sep 2020 09:30:16 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id i26sm176802wmb.17.2020.09.21.09.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 09:30:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 5/6] block/nvme: Use register definitions from 'block/nvme.h'
Date: Mon, 21 Sep 2020 18:29:48 +0200
Message-Id: <20200921162949.553863-6-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the NVMe register definitions from "block/nvme.h" which
ease a bit reviewing the code while matching the datasheet.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 83bae6b2f13..d18e897c7c9 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -718,22 +718,22 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
      * Initialization". */
 
     cap = le64_to_cpu(regs->cap);
-    if (!(cap & (1ULL << 37))) {
+    if (!NVME_CAP_CSS(cap)) {
         error_setg(errp, "Device doesn't support NVMe command set");
         ret = -EINVAL;
         goto out;
     }
 
-    s->page_size = MAX(4096, 1 << (12 + ((cap >> 48) & 0xF)));
-    s->doorbell_scale = (4 << (((cap >> 32) & 0xF))) / sizeof(uint32_t);
+    s->page_size = MAX(4096, 1 << NVME_CAP_MPSMIN(cap));
+    s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
     bs->bl.opt_mem_alignment = s->page_size;
-    timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
+    timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
 
     /* Reset device to get a clean state. */
     regs->cc = cpu_to_le32(le32_to_cpu(regs->cc) & 0xFE);
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
-    while (le32_to_cpu(regs->csts) & 0x1) {
+    while (NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
                              PRId64 " ms)",
@@ -761,18 +761,19 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
     s->nr_queues = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
-    regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
+    regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << AQA_ACQS_SHIFT) |
+                            (NVME_QUEUE_SIZE << AQA_ASQS_SHIFT));
     regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
     regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
-    regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
-                              (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
-                              0x1);
+    regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << CC_IOCQES_SHIFT) |
+                           (ctz32(NVME_SQ_ENTRY_BYTES) << CC_IOSQES_SHIFT) |
+                           CC_EN_MASK);
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     deadline = now + timeout_ms * 1000000;
-    while (!(le32_to_cpu(regs->csts) & 0x1)) {
+    while (!NVME_CSTS_RDY(le32_to_cpu(regs->csts))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
                              PRId64 " ms)",
-- 
2.26.2



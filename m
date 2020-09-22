Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4DDC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61182085B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IKGW3DAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61182085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdsi-0002E1-Ls
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdpA-0005qy-KH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42093)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdp8-0008Du-5g
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600763933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtGoZwu6xHPSB07J+UgiWcxCLBb0xpG4Cx8oWnT4spA=;
 b=IKGW3DAINRGrPM1X9AMJYizxa5LND0UMNwfiOw0UVe++7ZbMVY8uLzdUSifTQCNazJRYRr
 W2tbODi1YzXP+Fooss3DOEqht/fBLJYGX+noI93ZyiWzoPnDF9NN1TV8aXPjLu6JNIMkaP
 WsBKjXL6t2CJUnNvqB9rbi93uFBV9os=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-fJfUhEPiORuZo05a2_cQDg-1; Tue, 22 Sep 2020 04:38:50 -0400
X-MC-Unique: fJfUhEPiORuZo05a2_cQDg-1
Received: by mail-wm1-f72.google.com with SMTP id x6so632378wmi.1
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:38:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZtGoZwu6xHPSB07J+UgiWcxCLBb0xpG4Cx8oWnT4spA=;
 b=e3m3SPV8BBR37vBszI/Aq3pCJKErMYPWmKARlw+Dhpsaqr1CvQJKoc9lULbM7EaIMR
 +vbh/gXC+1utHcrrbXZJrtw/8d4EoH7lLCFmeok7kBaruAZ3ldMSmB4LBhGDqvcpPglO
 TlPsWnyqjFfLldu7OWeUqWprNHvtfbo+F/SAVX/8RS04Fl6p6pT6ga9xR50uJ04X99ll
 giZ2IrXINbyslf579tNfo6AyMuHFklN6RWXfKJC8JUUWO6O6IV/C7dp2p6NIhMORVESL
 D2l5q9NCVoPhukEZ3LTANAwxyh7gvj7Xf+cz4zxeZADmf7AQbstHZPWzYh/yhwMvuc6X
 g0fA==
X-Gm-Message-State: AOAM531dHcTEv2CjIOwxVmZMPsUXg145fORV0HZaooYtf+8ZBEsVaUJk
 i/vflTIw9dh18YGkMcSLiFx5oKiA2Mp+omz5MwmiEz9xCaR6Etto3X3siVSTq/Pb7N3HqbAmcgZ
 9gYFihbxebPAGJpM=
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr3359106wmg.0.1600763929384;
 Tue, 22 Sep 2020 01:38:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHegFdYPfsW2i5m9hJm5ucXISWGJOPhDFbqGTGXl2p02X58+aF0aDkwwZM56BfE3ksAhuz0w==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr3359083wmg.0.1600763929158;
 Tue, 22 Sep 2020 01:38:49 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id p9sm3285820wma.42.2020.09.22.01.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 01:38:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 5/6] block/nvme: Use register definitions from
 'block/nvme.h'
Date: Tue, 22 Sep 2020 10:38:20 +0200
Message-Id: <20200922083821.578519-6-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
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

Use the NVMe register definitions from "block/nvme.h" which
ease a bit reviewing the code while matching the datasheet.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index bd82990b66c..959569d262f 100644
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



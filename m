Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E14AC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:43:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9AC206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 12:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5sApBY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9AC206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEB3T-0007Wz-Cm
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 08:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEB2K-00069n-8W
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kEB2G-0006YV-TI
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 08:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599223302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sb4uXiFvtrqRn/GlqalTIrcUPoERtLqLldrd535gyMg=;
 b=G5sApBY7ycCOYBOzrOsSJsIlYJ2qgUyuMM5i+JU4cUqgvY9Sw3hBD2eL5bqHo018TIP2L4
 +EFnhS0nK3pj5xyW2+Llaef+Ltwu3RgiO7aDfHc7NqE6PJ5jpo1V3v031UXYTqXDbyz3A2
 PaakpFk0EYL5xZUmXnbvWKpCkePbEiE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-i6YFI_OcNyO67MYh-Ku1iA-1; Fri, 04 Sep 2020 08:41:39 -0400
X-MC-Unique: i6YFI_OcNyO67MYh-Ku1iA-1
Received: by mail-wm1-f69.google.com with SMTP id g79so3357322wmg.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 05:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sb4uXiFvtrqRn/GlqalTIrcUPoERtLqLldrd535gyMg=;
 b=gKOOtJNjoxNPr/fKSDsg5QiX821707lfG9VK0j6miOmkeYDP+PxJ/zk5DBozUDepLh
 lAXIRDWFJ6epT8oz7cTVg1QVhvbbCm0rgj+FC0anD3glEehYLC/2X6BXOf5WaVdtdo8X
 FKiOoH2CDcaeMJdgCr1KnH1SfWYBn1Y7oCgPaIUJUc4ZXGx8tnTZEaXJ221mKPI9iKlM
 MW/iipeSJ/8iyWRhxbWInNRWuzF6p7aJmwym7FHSDYdbNrluvWy0TQ5Q1lQoAgsQLmwu
 RLrG7cYuiH8I6HartEcm16GPlcMDzkdFo4lZkFQgm6JqX2unw8gkYg2w5NlfmJlPQUak
 Ji6g==
X-Gm-Message-State: AOAM530gp3ZKjzwzmk1sWwkeCQIQiEjiKSxzpCOtGFpyB0f8HPabd8uC
 5m5klTo4EHAchHzWOMM2gnSNA9p4WR+IXrqIWx1Al99SjnetUmXPweDWem7ebEV+g4xkrHpRX6F
 Cpuv5F3ui+hCPHuw=
X-Received: by 2002:a1c:6145:: with SMTP id v66mr7792026wmb.171.1599223298259; 
 Fri, 04 Sep 2020 05:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2AWjwRNhrOuxy5aVntw74Dd2eAwFLf58CSi/Y0Z9nEHjuMs6mZ20121sSBuFKRE61s1PTuw==
X-Received: by 2002:a1c:6145:: with SMTP id v66mr7792003wmb.171.1599223298008; 
 Fri, 04 Sep 2020 05:41:38 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 185sm3626889wma.18.2020.09.04.05.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 05:41:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] block/nvme: Group controller registers in NVMeRegs
 structure
Date: Fri,  4 Sep 2020 14:41:28 +0200
Message-Id: <20200904124130.583838-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200904124130.583838-1-philmd@redhat.com>
References: <20200904124130.583838-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 07:42:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to use the NvmeBar structure from "block/nvme.h" in the
next commit. As a preliminary step, group all the NVMe controller
registers in the 'ctrl' field, keeping the doorbells registers
out of it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 24e6e7f0866..c9c3fc02fed 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -83,21 +83,23 @@ typedef struct {
 
 /* Memory mapped registers */
 typedef volatile struct {
-    uint64_t cap;
-    uint32_t vs;
-    uint32_t intms;
-    uint32_t intmc;
-    uint32_t cc;
-    uint32_t reserved0;
-    uint32_t csts;
-    uint32_t nssr;
-    uint32_t aqa;
-    uint64_t asq;
-    uint64_t acq;
-    uint32_t cmbloc;
-    uint32_t cmbsz;
-    uint8_t  reserved1[0xec0];
-    uint8_t  cmd_set_specfic[0x100];
+    struct {
+        uint64_t cap;
+        uint32_t vs;
+        uint32_t intms;
+        uint32_t intmc;
+        uint32_t cc;
+        uint32_t reserved0;
+        uint32_t csts;
+        uint32_t nssr;
+        uint32_t aqa;
+        uint64_t asq;
+        uint64_t acq;
+        uint32_t cmbloc;
+        uint32_t cmbsz;
+        uint8_t  reserved1[0xec0];
+        uint8_t  cmd_set_specfic[0x100];
+    } ctrl;
     uint32_t doorbells[];
 } NVMeRegs;
 
@@ -734,7 +736,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     /* Perform initialize sequence as described in NVMe spec "7.6.1
      * Initialization". */
 
-    cap = le64_to_cpu(s->regs->cap);
+    cap = le64_to_cpu(s->regs->ctrl.cap);
     if (!(cap & (1ULL << 37))) {
         error_setg(errp, "Device doesn't support NVMe command set");
         ret = -EINVAL;
@@ -747,10 +749,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
 
     /* Reset device to get a clean state. */
-    s->regs->cc = cpu_to_le32(le32_to_cpu(s->regs->cc) & 0xFE);
+    s->regs->ctrl.cc = cpu_to_le32(le32_to_cpu(s->regs->ctrl.cc) & 0xFE);
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
-    while (le32_to_cpu(s->regs->csts) & 0x1) {
+    while (le32_to_cpu(s->regs->ctrl.csts) & 0x1) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
                              PRId64 " ms)",
@@ -771,18 +773,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
     s->nr_queues = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
-    s->regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
-    s->regs->asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
-    s->regs->acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
+    s->regs->ctrl.aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
+    s->regs->ctrl.asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
+    s->regs->ctrl.acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
-    s->regs->cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
+    s->regs->ctrl.cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
                               (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
                               0x1);
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     deadline = now + timeout_ms * 1000000;
-    while (!(le32_to_cpu(s->regs->csts) & 0x1)) {
+    while (!(le32_to_cpu(s->regs->ctrl.csts) & 0x1)) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
                              PRId64 " ms)",
-- 
2.26.2



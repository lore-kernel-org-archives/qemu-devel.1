Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61976C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 927E721D24
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 20:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzUAbqvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 927E721D24
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIeHt-0001Vx-7c
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 16:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIeDy-0006BZ-DR
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 16:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kIeDw-0002xN-JN
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 16:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600288815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iV/ElKucvX82AYjveXxyl1sOCENXpVHeSTvARkSKpI4=;
 b=GzUAbqvkBapxooNEQm47EEdX2CqYevCH992Fzoq6Bp/DFjlfjsacWNFaK8NBj3VrYo+pWe
 /OorasKjUxZH5jpzTxFiNXtJZpzh+mKSC+pI5p9r2QVZZ6tYiRAvmAooJPfdSsePiWAU3I
 lkvP105ki9S/k/1xAmFWadBBGeXqSVo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-uHBPRmjAPCGXPLxzcTVT5A-1; Wed, 16 Sep 2020 16:40:13 -0400
X-MC-Unique: uHBPRmjAPCGXPLxzcTVT5A-1
Received: by mail-wr1-f70.google.com with SMTP id v5so2974378wrs.17
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 13:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iV/ElKucvX82AYjveXxyl1sOCENXpVHeSTvARkSKpI4=;
 b=f/FLMN0uCxYakaci40o5HmoZcK3lCO+9RO8tFzl18skB7ZSXwsiOCGE2KWPU/7OByc
 sNhmk8kayjVAj5mOc8IXannnY6zah1n6yg+3VMYyKz6AUA5XSK58eDAUTL/oIG7G0luN
 B8b1l9KzhqM+x7EMBIubmfE13YTm1yqVnlHRdH1xOT2aMW+oKxKLE6hTOwrsy17/lPam
 VzRDFNhIH8b8ZC/ftMrtISZQtz5FeXfmw2xf67KUtWpFy0ZA3b9Z1HA9jqqB4Q0R4UJW
 Z6eibdItBDt8dFeN6o/lJTZUKdrnkNidfBM5CICyMORpKau8v8KE3ZGsseuioaNEKAlS
 V2LQ==
X-Gm-Message-State: AOAM530z5zzJ+xCp1PyQFufHt5cACmruL5f/W8E7hv0QtMZagB3YI5uX
 +gh1E3VIqg1S22v9LGpG0yTeFe9DCZ0Mv6sbrvj86ud0do59zV4OaLBv0EgnBVJSyNyClqjxCeI
 YckeTqIvpv3xv1Hk=
X-Received: by 2002:a1c:f715:: with SMTP id v21mr7039780wmh.117.1600288811944; 
 Wed, 16 Sep 2020 13:40:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0BRSKUk1/BHT7jquOHQu/rHGGRcmepdVQVvD/tPFjMeB7ZqbrnLPBFIgCzuuH4wtZxUTP+Q==
X-Received: by 2002:a1c:f715:: with SMTP id v21mr7039762wmh.117.1600288811765; 
 Wed, 16 Sep 2020 13:40:11 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d6sm35474850wrq.67.2020.09.16.13.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 13:40:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] block/nvme: Initialize constant values with const_le32()
Date: Wed, 16 Sep 2020 22:40:02 +0200
Message-Id: <20200916204004.1511985-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200916204004.1511985-1-philmd@redhat.com>
References: <20200916204004.1511985-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid multiple endianess conversion, as we know the device
registers are in little-endian, directly use const_le32() with
constant values.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index f4f27b6da7d..b91749713e0 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -511,7 +511,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     uint64_t iova;
     NvmeCmd cmd = {
         .opcode = NVME_ADM_CMD_IDENTIFY,
-        .cdw10 = cpu_to_le32(0x1),
+        .cdw10 = const_le32(0x1),
     };
 
     id = qemu_try_memalign(s->page_size, sizeof(*id));
@@ -649,7 +649,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .opcode = NVME_ADM_CMD_CREATE_CQ,
         .dptr.prp1 = cpu_to_le64(q->cq.iova),
         .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
-        .cdw11 = cpu_to_le32(0x3),
+        .cdw11 = const_le32(0x3),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create CQ io queue [%d]", n);
@@ -734,10 +734,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     timeout_ms = MIN(500 * ((cap >> 24) & 0xFF), 30000);
 
     /* Reset device to get a clean state. */
-    s->regs->ctrl.cc = cpu_to_le32(le32_to_cpu(s->regs->ctrl.cc) & 0xFE);
+    s->regs->ctrl.cc &= const_le32(0xFE);
     /* Wait for CSTS.RDY = 0. */
     deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) + timeout_ms * SCALE_MS;
-    while (le32_to_cpu(s->regs->ctrl.csts) & 0x1) {
+    while (s->regs->ctrl.csts & const_le32(0x1)) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to reset (%"
                              PRId64 " ms)",
@@ -758,18 +758,18 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
     s->nr_queues = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
-    s->regs->ctrl.aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
+    s->regs->ctrl.aqa = const_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
     s->regs->ctrl.asq = cpu_to_le64(s->queues[INDEX_ADMIN]->sq.iova);
     s->regs->ctrl.acq = cpu_to_le64(s->queues[INDEX_ADMIN]->cq.iova);
 
     /* After setting up all control registers we can enable device now. */
-    s->regs->ctrl.cc = cpu_to_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
+    s->regs->ctrl.cc = const_le32((ctz32(NVME_CQ_ENTRY_BYTES) << 20) |
                               (ctz32(NVME_SQ_ENTRY_BYTES) << 16) |
                               0x1);
     /* Wait for CSTS.RDY = 1. */
     now = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
     deadline = now + timeout_ms * 1000000;
-    while (!(le32_to_cpu(s->regs->ctrl.csts) & 0x1)) {
+    while (!(s->regs->ctrl.csts & const_le32(0x1))) {
         if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > deadline) {
             error_setg(errp, "Timeout while waiting for device to start (%"
                              PRId64 " ms)",
@@ -848,8 +848,8 @@ static int nvme_enable_disable_write_cache(BlockDriverState *bs, bool enable,
     NvmeCmd cmd = {
         .opcode = NVME_ADM_CMD_SET_FEATURES,
         .nsid = cpu_to_le32(s->nsid),
-        .cdw10 = cpu_to_le32(0x06),
-        .cdw11 = cpu_to_le32(enable ? 0x01 : 0x00),
+        .cdw10 = const_le32(0x06),
+        .cdw11 = enable ? const_le32(0x01) : 0x00,
     };
 
     ret = nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd);
@@ -1278,8 +1278,8 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     NvmeCmd cmd = {
         .opcode = NVME_CMD_DSM,
         .nsid = cpu_to_le32(s->nsid),
-        .cdw10 = cpu_to_le32(0), /*number of ranges - 0 based*/
-        .cdw11 = cpu_to_le32(1 << 2), /*deallocate bit*/
+        .cdw10 = const_le32(0), /*number of ranges - 0 based*/
+        .cdw11 = const_le32(1 << 2), /*deallocate bit*/
     };
 
     NVMeCoData data = {
-- 
2.26.2



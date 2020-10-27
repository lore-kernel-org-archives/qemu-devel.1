Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A3AC388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA41218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0AP6k8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA41218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPiU-00042G-PX
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTh-0003fL-Jn
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTc-0004Q8-6B
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JEjEb5blaJCbCH8yHzb9rLLKFCJ8kP8Dq4wMBDtqfPA=;
 b=P0AP6k8iEswjrjoT1amWfSTTI8OQp7uqS+df8WA7ugprslNgPKC139GWhO5+b5lzsYVVk5
 5t/fnDipq/Yr72XcBaSGfcZrtM6z5r5ok2ZyJiRbYwR5VNWZo35Q4DOMHTf+m8ZAmRFlHe
 /0B5r1fvCCXFew+CG+Jua7QJcFMQbNA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-olnpzhPvOliE7thc2Pe0MA-1; Tue, 27 Oct 2020 09:57:23 -0400
X-MC-Unique: olnpzhPvOliE7thc2Pe0MA-1
Received: by mail-ej1-f71.google.com with SMTP id gh22so914102ejb.8
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JEjEb5blaJCbCH8yHzb9rLLKFCJ8kP8Dq4wMBDtqfPA=;
 b=KMEaTSU+XHv3OORzikWaHdMK1egR9YTKqYTNtqqzK0wLXVzOwHjyagX3VTHbLK/Vbv
 VUmlB8zYFeqANrzrbaoL/l5Ve0eWbE8BUkI6sMOSDFTImedNTR+s+Yz9TnZCF4Mqo/gr
 x2dcHjXjw5Tdeecrc68BBQrd8RR1vvEMBftF8I3h26zYkz8PdD0Zh3kMIZBnIrwxUYuW
 k6XztQY3Q3mWDQrVjluQwQj/HWsrm4qMCTKkTQ08skRxq3NfozIEFIebGWiUTCMlxqWy
 xz6JbIOFei8NteYfCpq3hNCvtZPIHv+yCD0N142YkeTe9EI+Qkw9uFPCrGILQAcqisHi
 FLmQ==
X-Gm-Message-State: AOAM533Zf6iiOa3tqoIoKKpQckUAvHu7fwzjE6IDXKiy9GT31yZJFtfk
 HRtNv/DoiQGRLDbTlsZ6HTGpTRelsow+2vkResBC68otqCZ0yBKGU2NdQDhyaSf0TAUFUNRq14e
 5j8jQNc4WSsKNMqM=
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr2419633eds.379.1603807042129; 
 Tue, 27 Oct 2020 06:57:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHzC8M0tCzJel8YX0kGF1EMexn+eDGjWUUDLUlYJfBpsXKZY4Rvx+F51v4fc4xwiZFIoshjg==
X-Received: by 2002:aa7:c5c4:: with SMTP id h4mr2419610eds.379.1603807041895; 
 Tue, 27 Oct 2020 06:57:21 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id ld2sm1090588ejb.94.2020.10.27.06.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/25] block/nvme: Simplify nvme_cmd_sync()
Date: Tue, 27 Oct 2020 14:55:39 +0100
Message-Id: <20201027135547.374946-18-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As all commands use the ADMIN queue, it is pointless to pass
it as argument each time. Remove the argument.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 2d3648694b0..68f0c3f7959 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -487,9 +487,10 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
     aio_wait_kick();
 }
 
-static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
-                         NvmeCmd *cmd)
+static int nvme_cmd_sync(BlockDriverState *bs, NvmeCmd *cmd)
 {
+    BDRVNVMeState *s = bs->opaque;
+    NVMeQueuePair *q = s->queues[INDEX_ADMIN];
     AioContext *aio_context = bdrv_get_aio_context(bs);
     NVMeRequest *req;
     int ret = -EINPROGRESS;
@@ -534,7 +535,7 @@ static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 
     memset(id, 0, sizeof(*id));
     cmd.dptr.prp1 = cpu_to_le64(iova);
-    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
+    if (nvme_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to identify controller");
         goto out;
     }
@@ -557,7 +558,7 @@ static bool nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     memset(id, 0, sizeof(*id));
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
-    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
+    if (nvme_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to identify namespace");
         goto out;
     }
@@ -663,7 +664,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),
         .cdw11 = cpu_to_le32(NVME_CQ_IEN | NVME_CQ_PC),
     };
-    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
+    if (nvme_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to create CQ io queue [%u]", n);
         goto out_error;
     }
@@ -673,7 +674,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),
         .cdw11 = cpu_to_le32(NVME_SQ_PC | (n << 16)),
     };
-    if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
+    if (nvme_cmd_sync(bs, &cmd)) {
         error_setg(errp, "Failed to create SQ io queue [%u]", n);
         goto out_error;
     }
@@ -889,7 +890,7 @@ static int nvme_enable_disable_write_cache(BlockDriverState *bs, bool enable,
         .cdw11 = cpu_to_le32(enable ? 0x01 : 0x00),
     };
 
-    ret = nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd);
+    ret = nvme_cmd_sync(bs, &cmd);
     if (ret) {
         error_setg(errp, "Failed to configure NVMe write cache");
     }
-- 
2.26.2



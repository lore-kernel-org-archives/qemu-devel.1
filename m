Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499B9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B718206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMgJvRJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B718206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjMp-0000Ks-5n
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBK-0004eF-Ge
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29037)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjBF-0000xh-9M
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8P+APGAGVBASJKD+E4d9JUwx3Znjoc4buR2IIfeAxOA=;
 b=YMgJvRJoFve12amM0SajTEMua3SDqtIf2ClDA1OZjxqf1BqdLeZY4Z5IhLdaspu6wNr9vV
 m07gl+5S+YrrLrI3OVCXtptjbAjt90+AONIWw955I8qz4wxl7M6SWJEYLg0tfQJbO56W7w
 CoDpOoCHq0AzTkrYW5oj+3UgJeqaSs8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-xJKFrdOOPEajwS7tgsZOnA-1; Wed, 14 Oct 2020 11:59:04 -0400
X-MC-Unique: xJKFrdOOPEajwS7tgsZOnA-1
Received: by mail-wr1-f69.google.com with SMTP id f11so1537033wro.15
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8P+APGAGVBASJKD+E4d9JUwx3Znjoc4buR2IIfeAxOA=;
 b=edq/IgCI6r/MyAdVB4ooWttRWiE3UOXViqDeKlAP82rt4qLBPBEO59SUdu0aA9bzDw
 J4ZHqwcUW0DvnjzJaJXq7R0O+yA271h4xjEwDus6+gHKL9dy6YsoZDQ6kr/J3NsBW1sA
 ANnq61Y8ISQ8kldjZQ0cRkCtZPPKBKSHaz5hKI5mdLjcsXkZbD1Y5W+W4Qqf+F0rqyx4
 A8aBDGvtD2wqHyGRkAyM0I760jTOGBizMq1loRRw51/lgadFv8m8Ty4YZmIvyDbldH4R
 2HFUWBVlX2TiPka1chn0A51FugU8hwjrqdxsRsOnkZ+Z2CStIzfX8AbYN/Ksk/58c6bb
 hqeA==
X-Gm-Message-State: AOAM531kzD5BnoMGvTVWblUaWfxSksMqsPZLEJiLZ8zQuyA6FPIEPSk6
 zQw/sjDBJxRQnFJ+d7DbHBMEfhvlXuWPMbCi7jiH98IlsIi6pJR/aQpyn8+0WJ0KYutuCsWzJBH
 xIzrsj2lldNKNJgg=
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr141584wme.18.1602691142983;
 Wed, 14 Oct 2020 08:59:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyf/HbfO5K0bSOwQFaE37QJp53txyIDwWfEl6EYjydcLED8ojLbkCqAneZc0RnmFflXM8nm4A==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr141573wme.18.1602691142784;
 Wed, 14 Oct 2020 08:59:02 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y14sm53518wma.48.2020.10.14.08.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:59:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/15] block/nvme: Use definitions instead of magic values in
 add_io_queue()
Date: Wed, 14 Oct 2020 17:58:05 +0200
Message-Id: <20201014155810.102841-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014155810.102841-1-philmd@redhat.com>
References: <20201014155810.102841-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace magic values by definitions, and simplifiy since the
number of queues will never reach 64K.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index b841c5950c5..11fba2d754d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -652,6 +652,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs,
     NvmeCmd cmd;
     unsigned queue_size = NVME_QUEUE_SIZE;
 
+    assert(n <= UINT16_MAX);
     q = nvme_create_queue_pair(s, aio_context, n, queue_size, errp);
     if (!q) {
         return false;
@@ -659,8 +660,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs,
     cmd = (NvmeCmd) {
         .opcode = NVME_ADM_CMD_CREATE_CQ,
         .dptr.prp1 = cpu_to_le64(q->cq.iova),
-        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
-        .cdw11 = cpu_to_le32(0x3),
+        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),
+        .cdw11 = cpu_to_le32(NVME_CQ_IEN | NVME_CQ_PC),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create CQ io queue [%u]", n);
@@ -669,8 +670,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs,
     cmd = (NvmeCmd) {
         .opcode = NVME_ADM_CMD_CREATE_SQ,
         .dptr.prp1 = cpu_to_le64(q->sq.iova),
-        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | (n & 0xFFFF)),
-        .cdw11 = cpu_to_le32(0x1 | (n << 16)),
+        .cdw10 = cpu_to_le32(((queue_size - 1) << 16) | n),
+        .cdw11 = cpu_to_le32(NVME_SQ_PC | (n << 16)),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
         error_setg(errp, "Failed to create SQ io queue [%u]", n);
-- 
2.26.2



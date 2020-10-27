Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08355C55179
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7709E22258
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwWfLw9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7709E22258
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPct-00051R-9w
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTW-0003Yv-6j
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTL-0004OX-MJ
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZTuWnB45c6bHWmlLJk/6WmCKmM3xNLscyekei4DbYk=;
 b=YwWfLw9pSto5zrViQ9k5FBYVgsUxuWRASkeYHqx/VVi1/4tzI+JH9hRB4UGbkVQwm+DP0e
 B+ch3MzLbej8OE2Dh3i88LIbEE+R8fp+wFcLbDe9ENUU1h5q0aLWXXJnpcBsK/wPkI4SGV
 H5Q+1f4GO5VzJFftq3ssI/OuY5+uubY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-NNRt9nR_OM29DTT88jKZnA-1; Tue, 27 Oct 2020 09:57:07 -0400
X-MC-Unique: NNRt9nR_OM29DTT88jKZnA-1
Received: by mail-ed1-f70.google.com with SMTP id w24so734413edl.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wZTuWnB45c6bHWmlLJk/6WmCKmM3xNLscyekei4DbYk=;
 b=nfCDLTeQCQuj9dQ+ubMlO6LoS7R/9HH+r20j8yE5PlihLj5zcjJVE3w/dEXPFfSNfz
 IYr0HKRXinBKfMlDX7nJK+cjYewF7IyiqTEnwRoO7OPhxYG8twPHh9nOTz8VW/Q1y9ex
 k4ReXTs1IKy9ap3rUpJcL2EEtLbW96vS7bl6vVWqX/q5cgTwrM0YhIfoiYtSBWhNtzIQ
 L1PUBKFHykUXtWO+UVwsL7LEy9L7phuZ5+8w7nVZoOyGA+sOkA489JFpSN9wwLm0m81V
 S4guotAm3DOH60qlK9X69EYa34Tm4ow3Xd0BufAYjD6cH0fsm/y0qGkEw5KrkPnuAf7o
 4ivQ==
X-Gm-Message-State: AOAM532ojXngT7hxKHh2y3HCeEtm3RndG8yo1wWsb8T2FqzbDfoXmM6d
 2DsY60wLlBHD3KIPX/7Rc02Jt7JhqEpFJUFDVIHQp0R9sUr51TE5pr8HMz+X2cE4ZXGaJ3FZOqv
 P1D5WmG0FssGJREM=
X-Received: by 2002:a17:906:7e0e:: with SMTP id
 e14mr2491171ejr.238.1603807026171; 
 Tue, 27 Oct 2020 06:57:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1wYqlaQlG8sxRdujiq3rO5sh9mL8zesoXuQ6cAyg+E4ABW83HnXdcg42awns1qsnWrdInCg==
X-Received: by 2002:a17:906:7e0e:: with SMTP id
 e14mr2491151ejr.238.1603807025948; 
 Tue, 27 Oct 2020 06:57:05 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id d11sm1020685eds.83.2020.10.27.06.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:57:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/25] block/nvme: Use definitions instead of magic values in
 add_io_queue()
Date: Tue, 27 Oct 2020 14:55:36 +0100
Message-Id: <20201027135547.374946-15-philmd@redhat.com>
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

Replace magic values by definitions, and simplifiy since the
number of queues will never reach 64K.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 9324f0bfdc4..2dfcf8c41d7 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -651,6 +651,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     NvmeCmd cmd;
     unsigned queue_size = NVME_QUEUE_SIZE;
 
+    assert(n <= UINT16_MAX);
     q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
                                n, queue_size, errp);
     if (!q) {
@@ -659,8 +660,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
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
@@ -669,8 +670,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
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



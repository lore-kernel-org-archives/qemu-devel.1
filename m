Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE8EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C78520774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIKePYyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C78520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vvx-0003iO-O0
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpz-0000VT-Jh
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41655
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vpx-0004fm-Uq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEv01UlOWkkBHI+HUgfHlgknxCIpEGzNYGd43Sq3Mjg=;
 b=XIKePYyFSeLTwavwwOwLAxgTM8LnEXJbfm6HTVR9zmqHSl9TpRYugiGH1TLZwbE0Rvavei
 32LrCW1lzvz/ym+szQ+rzAG2wYIBty/zpowDJAbaLIZtPH/Cz2FRXATZUnGSDWaFh0KllZ
 +RoYz0rKKrgHIjxrTjkADzb9DTDg8QI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-gqGyqAX2Ml6MAFaZOTgAsg-1; Wed, 12 Aug 2020 14:50:54 -0400
X-MC-Unique: gqGyqAX2Ml6MAFaZOTgAsg-1
Received: by mail-wm1-f71.google.com with SMTP id u14so1710731wml.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SEv01UlOWkkBHI+HUgfHlgknxCIpEGzNYGd43Sq3Mjg=;
 b=jj/fA3sVtfDOF1CXB1hFyDURrpUR3SCwrYDORoeLs3ArwP70P6LL1Oe1Zu5UxKDSXX
 s32b6WiJtnazk8ooEMaYQnZYAPfBJFfqac8D+YNxIiqcy+D9K2wbuCBJklQY9AN7isYb
 wRwUvsGhe7D23Gm6gCmoIRImeyHDijlK5RvyvX4EM4jKMN/1QJgEk5wXQYYWAolhJ/JT
 o08zp5jq/dr2I9DCqMPN5sdpx+sjqDeFBlMuVNpCN8jDNDxc2ErOo3t5rBpild+JK1+B
 OHwJEkn93WY2IQuL32GP4gstybPfLxwCax8dq9rlK7Ef9o15WdlrvIIMb8bNCyTZ6XT0
 upGA==
X-Gm-Message-State: AOAM532plfcDgmh/pEtdx3cPhdZFZynl/cgrxZS/rC6GSUiuWsnlxe08
 +oQUPvKz1fN+Oua+lMcBxs2uN9kktXw2hesK1oDKqipqAfgm23ntCqn4gRA4lXQ50qDA6tpqeDa
 QvT+YWAaxlO9S/78=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr922164wmh.55.1597258253588;
 Wed, 12 Aug 2020 11:50:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpP3+0VFdyIseq2AoOQSg64+0+52YugevHoKb/SnHflllS3/LZuFBIgtOwmyP2vmgT/51eWg==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr922151wmh.55.1597258253408;
 Wed, 12 Aug 2020 11:50:53 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 3sm4830894wms.36.2020.08.12.11.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:50:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/14] block/nvme: Rename local variable
Date: Wed, 12 Aug 2020 20:50:07 +0200
Message-Id: <20200812185014.18267-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200812185014.18267-1-philmd@redhat.com>
References: <20200812185014.18267-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to modify the code in the next commit. Renaming
the 'resp' variable to 'id' first makes the next commit easier
to review. No logical changes.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 3101f1ad55..99822d9fd3 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -510,8 +510,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     BDRVNVMeState *s = bs->opaque;
     NvmeIdCtrl *idctrl;
     NvmeIdNs *idns;
+    uint8_t *id;
     NvmeLBAF *lbaf;
-    uint8_t *resp;
     uint16_t oncs;
     int r;
     uint64_t iova;
@@ -520,14 +520,14 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         .cdw10 = cpu_to_le32(0x1),
     };
 
-    resp = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
-    if (!resp) {
+    id = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
+    if (!id) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
     }
-    idctrl = (NvmeIdCtrl *)resp;
-    idns = (NvmeIdNs *)resp;
-    r = qemu_vfio_dma_map(s->vfio, resp, sizeof(NvmeIdCtrl), true, &iova);
+    idctrl = (NvmeIdCtrl *)id;
+    idns = (NvmeIdNs *)id;
+    r = qemu_vfio_dma_map(s->vfio, id, sizeof(NvmeIdCtrl), true, &iova);
     if (r) {
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
@@ -554,8 +554,7 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
     s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
-    memset(resp, 0, 4096);
-
+    memset(id, 0, 4096);
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
@@ -587,8 +586,8 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 
     s->blkshift = lbaf->ds;
 out:
-    qemu_vfio_dma_unmap(s->vfio, resp);
-    qemu_vfree(resp);
+    qemu_vfio_dma_unmap(s->vfio, id);
+    qemu_vfree(id);
 }
 
 static bool nvme_poll_queues(BDRVNVMeState *s)
-- 
2.21.3



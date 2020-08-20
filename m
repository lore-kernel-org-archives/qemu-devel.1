Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC38AC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B567D208B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHQLRbw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B567D208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nyr-0001wi-08
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nuj-0003tv-St
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nui-0006E9-2w
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKc50BIrrP5rch9WHJ6NJlXLamMISYumaOhjTxgnFao=;
 b=iHQLRbw6LiAkf4dxUbr2marWfHumGg450DMysK1KDhWIbA43rwQGGMX7sh9aDc39LT4p8n
 YqPp5RNzuv6tyl+8BONnIWvjJ8NfrW8OgAV3dGkOv1skXPPzQtvW1MOaYgmBWtFebLaKDI
 TV057vdp1tHe1mCxJspB5AchNVY814k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-RZyDiQK8NkaeNqIOfiVgKQ-1; Thu, 20 Aug 2020 12:59:41 -0400
X-MC-Unique: RZyDiQK8NkaeNqIOfiVgKQ-1
Received: by mail-wm1-f71.google.com with SMTP id b73so1010205wmb.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NKc50BIrrP5rch9WHJ6NJlXLamMISYumaOhjTxgnFao=;
 b=OpUvPLwsF4LU/hxn2RLC5opwUzkOCmbRW5wSFMvhnRej9b537Rb9Jvr8SCwK/f+c0H
 sKg4h3ehQ3LX3DmSUy1MQK/VxhDJELJkSlm50kMJbK1ObozfyaRwyJytCQOZQYaCgmg2
 DI4Y08bc0UUHMOKwwr9pg2f9NKGqoShOVRp5XZthn+hr4qY2vGLXnX8mSpFseikaNdSD
 ulT/PP+8UsrPMfo3saWAxySYvvFbwtyLfx96o1xz6+vQVZrJazNaAuocS1cUe6wTfFTC
 fpR9fUpTXhWfhhAn7KbV4jdlCMswUGkb+88IUdki9ih7e6iBlTgsdfsCp9wKR+KeNRNO
 Nmmg==
X-Gm-Message-State: AOAM532CSePRTDe8ZDIfjv3AFgcbQzrq7NTnXNzXhEU6cyAabNrtWEKs
 ed7Mxl33gSG6RXzIv0a2VoHAAhH+XYqbJnvrR8GcvQmCvIOWDGcaNYLM7aCchGsFsHZH7JwCela
 W9d6ld8BnCqddrNU=
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr4343876wmj.92.1597942780265; 
 Thu, 20 Aug 2020 09:59:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFonyEwhB0zxrU2YR0L4qmUUhyhI1V4G1yP632cW+r7rqLl5uZMvjeDbImfXO5ymJnV1F2Pg==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr4343862wmj.92.1597942780103; 
 Thu, 20 Aug 2020 09:59:40 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id w64sm5977018wmb.26.2020.08.20.09.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 09:59:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 07/15] block/nvme: Rename local variable
Date: Thu, 20 Aug 2020 18:58:53 +0200
Message-Id: <20200820165901.1139109-8-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820165901.1139109-1-philmd@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
index 3101f1ad55d..99822d9fd36 100644
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
2.26.2



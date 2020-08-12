Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EF0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:59:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0976D20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 18:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SSX/BLa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0976D20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5vxo-0007rz-6Q
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 14:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vq7-0000lp-2H
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:51:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5vq4-0004gf-Bq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 14:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597258263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nDougWZqyxk6a7sj+gOtYRrtTc4TJ1zaE89TG5FuoS0=;
 b=SSX/BLa5rGXECHdvC0kzgxYlALAhDf9iq1Fr2sAcgrXCRWohBWBNUhUJxf2q3lFeYOSUTz
 04ibsDeK/MiLS0NRK2uHbjj+BiIAhe5Pa5jtckRFEvmqXnTv7v9pg8IXFcYgviajAp/jno
 2dSt5CFA+Myv39Sec7XJn4ozmDbv9t4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-5nGmpvIHNPeBuwr6HiPFxA-1; Wed, 12 Aug 2020 14:50:59 -0400
X-MC-Unique: 5nGmpvIHNPeBuwr6HiPFxA-1
Received: by mail-wm1-f69.google.com with SMTP id v8so962680wma.6
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 11:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nDougWZqyxk6a7sj+gOtYRrtTc4TJ1zaE89TG5FuoS0=;
 b=WCLhYfaF1UVsLYMj6cTBUfE60mssmGEIReR8Vw5vXcczrmuXloTTaf3AJjgm9H3A9D
 rGD9CbWCduGksGz+8oiE3T1rbjDOrFI+8nlMtt10fBAAPjzctf87JgiS3Fa3617KW4/0
 S+CXatwOsuJGfJz0GX+xisGHjg7HJgZAG403pYZlVRKS2ZjkvYqtQonLy9gy2v1F18h1
 LPMAMbpSwVNajqUnuJwMI4jenjoFqfVxLNfRr/x3OSzY2szh4CC3i2T9JnIGFbHf+4/S
 eiV185AljiL8zAvsk7/tLUWZqFRflLHklIJNecgcQgVhZPLDONdiNMyB9G7u8J+4VzFj
 gbBg==
X-Gm-Message-State: AOAM532O2qzWKwkCXdZTARGd0iLyWeMXpczwK/QvwsUBfjiSZMUZ04/p
 JCxBInT7/zz2T9yukWoN+bd4EzouaA7clYdQDkzxVViOm8FKeEy9AnIELcRrtl86Nb80ezw5twD
 iC0ErU9hyB5DzC2A=
X-Received: by 2002:a1c:e919:: with SMTP id q25mr897807wmc.123.1597258258522; 
 Wed, 12 Aug 2020 11:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp/yN6wH0cugGx9B/9Um7WlYaIudLkQmMq4gkEiYdwqcx9F7uO7CU447P1pdjCwzhYhsVm2A==
X-Received: by 2002:a1c:e919:: with SMTP id q25mr897798wmc.123.1597258258354; 
 Wed, 12 Aug 2020 11:50:58 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j11sm5721568wrq.69.2020.08.12.11.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 11:50:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 08/14] block/nvme: Use union of NvmeIdCtrl / NvmeIdNs
 structures
Date: Wed, 12 Aug 2020 20:50:08 +0200
Message-Id: <20200812185014.18267-9-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 14:50:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We allocate an unique chunk of memory then use it for two
different structures. By using an union, we make it clear
the data is overlapping (and we can remove the casts).

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 99822d9fd3..2bd1935f95 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -508,9 +508,10 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
 static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
-    NvmeIdCtrl *idctrl;
-    NvmeIdNs *idns;
-    uint8_t *id;
+    union {
+        NvmeIdCtrl ctrl;
+        NvmeIdNs ns;
+    } *id;
     NvmeLBAF *lbaf;
     uint16_t oncs;
     int r;
@@ -520,14 +521,12 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         .cdw10 = cpu_to_le32(0x1),
     };
 
-    id = qemu_try_blockalign0(bs, sizeof(NvmeIdCtrl));
+    id = qemu_try_blockalign0(bs, sizeof(*id));
     if (!id) {
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
     }
-    idctrl = (NvmeIdCtrl *)id;
-    idns = (NvmeIdNs *)id;
-    r = qemu_vfio_dma_map(s->vfio, id, sizeof(NvmeIdCtrl), true, &iova);
+    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova);
     if (r) {
         error_setg(errp, "Cannot map buffer for DMA");
         goto out;
@@ -539,22 +538,22 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         goto out;
     }
 
-    if (le32_to_cpu(idctrl->nn) < namespace) {
+    if (le32_to_cpu(id->ctrl.nn) < namespace) {
         error_setg(errp, "Invalid namespace");
         goto out;
     }
-    s->write_cache_supported = le32_to_cpu(idctrl->vwc) & 0x1;
-    s->max_transfer = (idctrl->mdts ? 1 << idctrl->mdts : 0) * s->page_size;
+    s->write_cache_supported = le32_to_cpu(id->ctrl.vwc) & 0x1;
+    s->max_transfer = (id->ctrl.mdts ? 1 << id->ctrl.mdts : 0) * s->page_size;
     /* For now the page list buffer per command is one page, to hold at most
      * s->page_size / sizeof(uint64_t) entries. */
     s->max_transfer = MIN_NON_ZERO(s->max_transfer,
                           s->page_size / sizeof(uint64_t) * s->page_size);
 
-    oncs = le16_to_cpu(idctrl->oncs);
+    oncs = le16_to_cpu(id->ctrl.oncs);
     s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROS);
     s->supports_discard = !!(oncs & NVME_ONCS_DSM);
 
-    memset(id, 0, 4096);
+    memset(id, 0, sizeof(*id));
     cmd.cdw10 = 0;
     cmd.nsid = cpu_to_le32(namespace);
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
@@ -562,11 +561,11 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         goto out;
     }
 
-    s->nsze = le64_to_cpu(idns->nsze);
-    lbaf = &idns->lbaf[NVME_ID_NS_FLBAS_INDEX(idns->flbas)];
+    s->nsze = le64_to_cpu(id->ns.nsze);
+    lbaf = &id->ns.lbaf[NVME_ID_NS_FLBAS_INDEX(id->ns.flbas)];
 
-    if (NVME_ID_NS_DLFEAT_WRITE_ZEROES(idns->dlfeat) &&
-            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(idns->dlfeat) ==
+    if (NVME_ID_NS_DLFEAT_WRITE_ZEROES(id->ns.dlfeat) &&
+            NVME_ID_NS_DLFEAT_READ_BEHAVIOR(id->ns.dlfeat) ==
                     NVME_ID_NS_DLFEAT_READ_BEHAVIOR_ZEROES) {
         bs->supported_write_flags |= BDRV_REQ_MAY_UNMAP;
     }
-- 
2.21.3



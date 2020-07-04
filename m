Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE37C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27BF20CC7
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 21:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGUrMYwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27BF20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrpoQ-0000jV-Vd
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 17:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpl3-0002kY-SR
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28452
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrpl2-00043G-1u
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 17:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593898295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qf4SB5pxS18EQoWD8ox8JEyWFcG4DNexsgvb6j1d6o=;
 b=YGUrMYwLLEqPW70SY7lXcvYrQugF9Lijh+uj8n6zGMdxTKX0A/T3ynUmSoyDFLSPXDIC4x
 emsgOHi/I2eebfziaA1sqP5+OGUpGKFwxUYKLEj4ljDUlq+WWE/IyZqzXsn3MB0YTRZzFF
 0Gkpf7Izhra5JL6huUHVJPRTO3y84zQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-MqgWfbKWMz20BYJWrCFkdA-1; Sat, 04 Jul 2020 17:31:33 -0400
X-MC-Unique: MqgWfbKWMz20BYJWrCFkdA-1
Received: by mail-wm1-f69.google.com with SMTP id q20so30916559wme.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 14:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7qf4SB5pxS18EQoWD8ox8JEyWFcG4DNexsgvb6j1d6o=;
 b=s2Dz+8+DUcPECo15Z7jVJqR/J8FCMsXQrpL4zDEps/9kuBDx/qzVjtqaGrvpciW2fn
 LNJnOA0gs4mJgfvabBI2ueoinqIcLWH142Ty7CvDhdHlpZUaQC6y0ypTGvZRGyA0NjTB
 QF6xVd8gNeYImIufVGzMIQkxhF6g1ZfdK4WJpmVKVMhRJxUEv27FeTZ6L7uBlaqIFdKK
 5Pi3yoQ1BqDUCEPDL/GJTDivu9pSqbg215BNe7/6tTVeG/HpSDK4VgiZYmngVmIgyp+L
 9uucq7FqOB6UZhW0D5DeI+Qsr+BkQcGDD7L/OkvF903R+v3TYaDVf2sAu6sBtPGM7OlR
 8s7g==
X-Gm-Message-State: AOAM5314B+8X0Z8MK8FBQu68m2yBaJC/GgPEuIXoygp1JKXZFunr7niZ
 MAWvovqCG02lGL79GiQw0OE0W9TlYAvrrJpvDmrisBfI5/GjwsKEdc35yla3ebt7nKOJ5D5CeSX
 cAN5UndO/1oaM9/c=
X-Received: by 2002:a5d:5084:: with SMTP id a4mr43626174wrt.191.1593898292529; 
 Sat, 04 Jul 2020 14:31:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWZ6cqaet+xGZT+rxDEj0LCHULPaKuxp+RUf2wP9dTq3+Unvrxr1hYE96/HwxCw6wdhE6XaA==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr43626159wrt.191.1593898292306; 
 Sat, 04 Jul 2020 14:31:32 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w17sm19531102wra.42.2020.07.04.14.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 14:31:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 08/16] block/nvme: Use union of NvmeIdCtrl / NvmeIdNs
 structures
Date: Sat,  4 Jul 2020 23:30:43 +0200
Message-Id: <20200704213051.19749-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704213051.19749-1-philmd@redhat.com>
References: <20200704213051.19749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 08:57:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
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
index 0e4e5ff107..a611fdd71e 100644
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
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
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



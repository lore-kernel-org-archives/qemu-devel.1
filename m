Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435E2C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA9720639
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRGrU0xS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA9720639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDoQI-0005Xr-UK
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMD-0000FI-Tc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMB-0007qf-SP
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aOcjV7su5QwStC1VAK815NSfg5qEBVvoHtC3IGwZAQM=;
 b=dRGrU0xSR+coUb3qpegtU2hYs7uOScU9mSxmlfuF+I48D7tVv0jApxHR/mcPiDz//0rtHM
 RqV1zynEXZ1i0Y2twxWpPpY9cikrEf9N6zybAsONgQ/Gv5wxeZSfPIcMGJfESAQLWjJQ6a
 WtZWdUWb1vklHRkXM718JQRt0iNTlMc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-YQx5C8bBOFOEksJAbZdesg-1; Thu, 03 Sep 2020 08:28:46 -0400
X-MC-Unique: YQx5C8bBOFOEksJAbZdesg-1
Received: by mail-wr1-f69.google.com with SMTP id 33so1018022wrk.12
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aOcjV7su5QwStC1VAK815NSfg5qEBVvoHtC3IGwZAQM=;
 b=qBb38CEehoqtA745fY7q5k9G95pUtIhAuTvEBA30ru21WV1SAwzzfEsQQzL63lRnD4
 zzyoqrBnqvom9tfzChg/uphmFh7RQJtNT7xKXwxDNETJjr5C9bRZG29fxJW8Zi1/ftbX
 2JAOGwPVUUfUkwhNNcqveMj+30p+bk8c4SysHXcIYIIZ8d5isbf4S5rHxSUNZuNRZnA9
 vQ5h6AXGIV/mPe5v0gWichhO7bC45HjRQYwiNX0ZaqrstTvzjYLthNVuaaAQuyHhEzXa
 6Qeo1HAX7e/dKgkm9ypTk5jWV3lUfpaI3Rsu7AgWNu8wn/BVl/0X46jA7Mv2fGBh9qFg
 R0iA==
X-Gm-Message-State: AOAM530bTcPObaf4zy9sXDk+FNeJsL6qctKRVh78rmWoApHXyDSbkzFe
 bM6uybyOG/5x4X42M66cS7RJMt16EFYghUHhnOd9N/TP7MdjvxkEoZQS40Ygn3XeG0lrMcIXYRL
 GDZ72bghKmqDh4ik=
X-Received: by 2002:a5d:574c:: with SMTP id q12mr2194096wrw.253.1599136124630; 
 Thu, 03 Sep 2020 05:28:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEpS27EsHSq1Iv/j/QMP8BSqyIEFn+6TH/JW5kRISOmgmT/ihYefQc4XEonpVfSN2ctoQPPA==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr2194068wrw.253.1599136124366; 
 Thu, 03 Sep 2020 05:28:44 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id o6sm2966838wrm.76.2020.09.03.05.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:28:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/15] block/nvme: Use union of NvmeIdCtrl / NvmeIdNs
 structures
Date: Thu,  3 Sep 2020 14:27:56 +0200
Message-Id: <20200903122803.405265-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
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
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We allocate an unique chunk of memory then use it for two
different structures. By using an union, we make it clear
the data is overlapping (and we can remove the casts).

Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 0992f2fb579..b0d55ecfb25 100644
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
     s->supports_write_zeroes = !!(oncs & NVME_ONCS_WRITE_ZEROES);
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
2.26.2



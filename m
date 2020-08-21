Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81953C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7D12072D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2rinsd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7D12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9D9p-00038f-J8
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7k-0007RR-BC
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53515
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k9D7i-0002kv-PT
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598039690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtBrq1bijthgDexWbDxZSKtNjp9JLqgaI8U5ThisE0A=;
 b=V2rinsd0fFKpQf/gmCANZZUJH0DteHMfX9ahKqgQaqriJESSlssu3EbweYSk3jCgyIsA0X
 b7vOTlmgl7jswx1ij4j9yb1co/YfOs23GEnT3e0uin+truZNlKZXjwWO1ptRFpYLT5a9fw
 5MX6lv3nN3JLbk2ZB5+jPZHaiFM5Oek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-cwKMXIJDNHGa022alVp3EA-1; Fri, 21 Aug 2020 15:54:46 -0400
X-MC-Unique: cwKMXIJDNHGa022alVp3EA-1
Received: by mail-wr1-f70.google.com with SMTP id j2so905744wrr.14
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WtBrq1bijthgDexWbDxZSKtNjp9JLqgaI8U5ThisE0A=;
 b=AsTz018KB5DkSMy4ExSpi0+HK2M1Y6JeuB+FuPXD3l6m2oxeCk0lhGB9yZYk18NkOL
 AmeDlv8A5Oeaq86JPLUoKkfDQN7IEn4SaIVEaXwwhOXnxmmWH4oX341MfPYQh93damTR
 C/8dIFC46jmEE5E3n5qiD3XP+sPa6x74CrwKNCgqp7D4FcyM9FUtqlEmR+000aqMMlVY
 cIGrKZJdMv9TAgmQo1yZ9o2SWsWHznkQERBddtTRC1o8WQk6LtlxzuznzlI2ChQgFr+k
 i9PyLGZTnypmrexbs/oqnBtel5L3qfAlWl0bLlsYH2jYRCpiQtAEXTxUq5k9NFKH1LVt
 p4Xg==
X-Gm-Message-State: AOAM532KrWQRMmylnZBrxVZ45P2IHRFaeSft0rHN5rwRd+DLcbFekSnQ
 9rnpYpFIFLH8eClwBf5+vMSAPofwQF4cNAQiRu5z3JrPN0SGO7YEDjobYhXannqYHJQkUpAQ4su
 jMQKOGbvS6LvYUao=
X-Received: by 2002:a1c:7215:: with SMTP id n21mr4506800wmc.156.1598039684788; 
 Fri, 21 Aug 2020 12:54:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVgFwQsWuAYY8uYC/Qoa8fuz/XnCXc1ATlaWF27Pnj+R1KPsBX+A7evqzWWtY6mFxaw6NzxQ==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr4506743wmc.156.1598039683888; 
 Fri, 21 Aug 2020 12:54:43 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id j4sm7191494wmi.48.2020.08.21.12.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 12:54:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 08/15] block/nvme: Use union of NvmeIdCtrl / NvmeIdNs
 structures
Date: Fri, 21 Aug 2020 21:53:52 +0200
Message-Id: <20200821195359.1285345-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821195359.1285345-1-philmd@redhat.com>
References: <20200821195359.1285345-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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
index 15c5202c03c..af3176a9669 100644
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
2.26.2



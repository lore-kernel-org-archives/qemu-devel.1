Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E99C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E24A206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWo2dr3L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E24A206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLpz-0002S1-L9
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLht-0006uR-Fh
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhp-0005ZM-11
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593544447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EcEIQ0Xt95Hgt2rsFb2a6/aei8m4wjvow7AnP4TfaSs=;
 b=XWo2dr3LzxmA11kvVhfg/0XTZTll52/bcS8s9m3vlLd1OmuwxmdOocD2VHaHrevD/PQ7ov
 joBcLWmcc+gz3P9gsf70Pcip9O9a816QYJXIgn9TBhNO/HIN0UuUUXnijQvDukK0weJ9WZ
 lxfsy8t40gQRvj2CvSUcKBvFRXW7Kws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-a3ThsnsIPA2pf3dMFdcq-Q-1; Tue, 30 Jun 2020 15:13:51 -0400
X-MC-Unique: a3ThsnsIPA2pf3dMFdcq-Q-1
Received: by mail-wr1-f70.google.com with SMTP id o12so19019113wrj.23
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:13:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EcEIQ0Xt95Hgt2rsFb2a6/aei8m4wjvow7AnP4TfaSs=;
 b=S+PARvbU3X1B7kaXjs+kIP4FDQ7BGhc7ZzTAScCrm7skxddbOhXjh8A5DyrvpWCy7B
 oy58i7XUTvMKng8qF+rQHS4cAkEAcyYxxtdHFeOWqWdK2qb+bAqbsqIrRDDs0udM4rcr
 8jP7CFBbuBwCxKF3UjQBSBH8XnXMSfA/to/ifg9waV7k3nBApPFYbSGTCVUif/htnDP8
 MvMZv48nxYY4wBKRpKkiac0dzirxouS6ptipw909MOPnIpvWWZu3anN28Lx8pdsVMruE
 eFWQeSiRlHefLeTg1vSC51NTbfobMJh1c6TfTTRrF1RGx7MGfqloC2vD70xdYKllf96r
 Vy7A==
X-Gm-Message-State: AOAM5305WSAdUjtVFzJZh7vfJT4s/BAzO1t+uNAnaCUtwsZbODyJixuH
 sfrstpy15wTx+Ub4SCg9sFkdaluF2az2vnulFv7Y48nGx2usM+Uf3REUpAUZvVnbTG7oFnUI//J
 5+hpjU+Z3X+y4P/E=
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr22304554wmh.134.1593544429923; 
 Tue, 30 Jun 2020 12:13:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOmAb1pXfLdMTML9O6YmWsoD58SvUu2/u2ZsHvpSZX+YLHW1yBXSmPY3zUc9mG8On17Zm/yA==
X-Received: by 2002:a1c:4d11:: with SMTP id o17mr22304540wmh.134.1593544429733; 
 Tue, 30 Jun 2020 12:13:49 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c2sm4731485wrv.47.2020.06.30.12.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:13:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 06/12] block/nvme: Use union of NvmeIdCtrl / NvmeIdNs
 structures
Date: Tue, 30 Jun 2020 21:13:12 +0200
Message-Id: <20200630191318.30021-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630191318.30021-1-philmd@redhat.com>
References: <20200630191318.30021-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index b9760ff04f..7ebd5be1f3 100644
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



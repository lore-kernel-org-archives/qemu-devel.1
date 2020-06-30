Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DCBC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DBA206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+xkyFnh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DBA206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLnU-0007Rp-QU
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLha-0006Uw-B6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:13:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40639
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLhX-0005XV-Vd
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593544429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JwOS0dTFEWL6oyJkADDTKayrcrCvjz0aXfTaNffA7dY=;
 b=A+xkyFnhnBN7pSVTVJtB2f/FWv115ToqGxC7GhRFC1dWTVR0Klnkeg4OtQcbNM0SOVZqKS
 8/2sOOVpq7KFqRtKZ4oRnAHTgY5satxKUHCvJ6Rzh+zAFcK3Qp8zryIUYliTiQw7TIjSB0
 ScUbrNjJflTzR3X5I1/avSIZpH3R8VE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-oxSFFa8sPv6rTRujviHvQg-1; Tue, 30 Jun 2020 15:13:48 -0400
X-MC-Unique: oxSFFa8sPv6rTRujviHvQg-1
Received: by mail-wm1-f72.google.com with SMTP id a21so21154028wmd.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JwOS0dTFEWL6oyJkADDTKayrcrCvjz0aXfTaNffA7dY=;
 b=X72gJTF8ujGeZ8PjuuumZhupi32kd7/LV9MAIwBaoRg+C0lVfn99+9wwQqyz1mKJ8l
 W3bp8u1OYycCWoSmmg/ID82mqLcCG+o1qLK84k3VlNkkKuSF6IBBq2GZ6JvOW5OBYYxP
 BSVB7NxPlRFLvU1Ih0vAiuAK+8s8Pn4tM46zZRAkMju5MmnsTORdhMdDqIpjitnVqkNQ
 kSKWlRoRxK6tYvfl837NGIOpQCFkfjl/vReKGG1+IjLplbeanGNrLt/+daGCWdjXMrcG
 tGrNEyB+Lr/xWotP/gkU9cOxUQp5Jg4ZbHLZEczJLHJWRjrLckoJjuEQgN7LeLh9nqxa
 KVTQ==
X-Gm-Message-State: AOAM531MvsMlcugflJT8byAhZ4rCoo+71PQUnXh3w4mwiCB5yB2yqNIr
 51efT+LdU6l81UgcLW32s6o6Ylj8A2pz26gg/pDZnrexuAttbOkRalUDsWtl64kJtOmKaccMNZE
 MF/+SrwlN2ugb/9A=
X-Received: by 2002:adf:e948:: with SMTP id m8mr23627167wrn.398.1593544426608; 
 Tue, 30 Jun 2020 12:13:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6sSf6GxnS8+vTJS8mFterJVik6kcKKrFZr5Z33nidnpIjIjpS8zSEYkw8IA7Rk6e1NcoHOQ==
X-Received: by 2002:adf:e948:: with SMTP id m8mr23627062wrn.398.1593544424684; 
 Tue, 30 Jun 2020 12:13:44 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w17sm4990456wra.42.2020.06.30.12.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:13:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 05/12] block/nvme: Rename local variable
Date: Tue, 30 Jun 2020 21:13:11 +0200
Message-Id: <20200630191318.30021-6-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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

We are going to modify the code in the next commit. Renaming
the 'resp' variable to 'id' first makes the next commit easier
to review. No logical changes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 28762d7ee8..b9760ff04f 100644
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
     if (nvme_cmd_sync(bs, s->queues[QUEUE_INDEX_ADMIN], &cmd)) {
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



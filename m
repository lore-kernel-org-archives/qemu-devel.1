Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32E0C55178
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F8AD2076E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 09:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QipEwxeY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8AD2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY4Vd-0006n9-1a
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 05:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4L2-0007dU-RZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kY4Kz-0006wT-E5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 05:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603964115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98878GiMo+xjdVFdoB+TjeRF3YgJ60igYiOFDXm/QLU=;
 b=QipEwxeYlro8IYd1NNxm09+qmyA8CjRWsriPXTV1Y9hYMPMBF7hDT+TFAWJAG8hQMICzc0
 m19EvaWCCLYmp47wQ9dDPcaa55jgNBm3wMJZmcJpmFIK/ZyczI415jBVkTHM30BD9LCTIl
 CLJuJwGl/ld3qGifa2gw/jfDz5hyvZI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-TzowVO2YPrGepcrv8EN9bQ-1; Thu, 29 Oct 2020 05:35:14 -0400
X-MC-Unique: TzowVO2YPrGepcrv8EN9bQ-1
Received: by mail-ej1-f69.google.com with SMTP id x22so926736ejs.17
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 02:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=98878GiMo+xjdVFdoB+TjeRF3YgJ60igYiOFDXm/QLU=;
 b=P0B6Yi9w7B8YdJghx9lDAFBk5aDHYQp1wKpKI8MZvGpySrZ3cZ+NdBoW3fslyL/7mR
 hk5hV7ch/xEnSJo9wmfIO4OcDBCQJ5aJQHfapX8aD66/TVUN8N9CL6fbb3+jv82eYc03
 mlfqJXyGkf8AM12V6KAKzUOMD3Cx6M22189gBqMG0ohlI0koEwGq/iRF18FhA8VjnVmW
 aHRQFKSEVwdOC6Hn2d+btpKHMAMMi1pfAzvfZu/NVrkS4rLOZkV9BjQW/mBn7dEuoJBQ
 4VPFFmive1zt4TKA6fy/rDjBo4UEcoayc0KmKtPdawxdKFXAYyCKsoLahtoARqiGOwXG
 2ZpA==
X-Gm-Message-State: AOAM530Dwqme+w3wXw5irmQZEwu9HCfV+nGCt/fInsURFzg5enN/hejA
 IxLY1x6Lsqv+L7czYthiJtaD1vDoKxHv+w4mY5SW9hgLa9zrRjmMIJCv6NqUwc/M0daRAoasSTY
 WZBgNe2a/8ugujUo=
X-Received: by 2002:a17:906:400f:: with SMTP id
 v15mr3072904ejj.378.1603964112373; 
 Thu, 29 Oct 2020 02:35:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFJ+q1BWMaXOzvorAV1c/Ju86MCTBCYBhdj5L58nZSQnc5XWJk9FPRccn1+tIjdzqhZmBbug==
X-Received: by 2002:a17:906:400f:: with SMTP id
 v15mr3072892ejj.378.1603964112216; 
 Thu, 29 Oct 2020 02:35:12 -0700 (PDT)
Received: from x1w.redhat.com (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m25sm1158234edp.36.2020.10.29.02.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2020 02:35:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2 23/25] block/nvme: Fix use of write-only doorbells
 page on Aarch64 arch
Date: Thu, 29 Oct 2020 10:33:04 +0100
Message-Id: <20201029093306.1063879-24-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029093306.1063879-1-philmd@redhat.com>
References: <20201029093306.1063879-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_vfio_pci_map_bar() calls mmap(), and mmap(2) states:

  'offset' must be a multiple of the page size as returned
   by sysconf(_SC_PAGE_SIZE).

In commit f68453237b9 we started to use an offset of 4K which
broke this contract on Aarch64 arch.

Fix by mapping at offset 0, and and accessing doorbells at offset=4K.

Fixes: f68453237b9 ("block/nvme: Map doorbells pages write-only")
Reported-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index f1e2fd34cdf..c8ef69cbb28 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -94,6 +94,7 @@ typedef struct {
 struct BDRVNVMeState {
     AioContext *aio_context;
     QEMUVFIOState *vfio;
+    void *bar0_wo_map;
     /* Memory mapped registers */
     volatile struct {
         uint32_t sq_tail;
@@ -777,8 +778,10 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
-    s->doorbells = qemu_vfio_pci_map_bar(s->vfio, 0, sizeof(NvmeBar),
-                                         NVME_DOORBELL_SIZE, PROT_WRITE, errp);
+    s->bar0_wo_map = qemu_vfio_pci_map_bar(s->vfio, 0, 0,
+                                           sizeof(NvmeBar) + NVME_DOORBELL_SIZE,
+                                           PROT_WRITE, errp);
+    s->doorbells = (void *)((uintptr_t)s->bar0_wo_map + sizeof(NvmeBar));
     if (!s->doorbells) {
         ret = -EINVAL;
         goto out;
@@ -910,8 +913,8 @@ static void nvme_close(BlockDriverState *bs)
                            &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
                            false, NULL, NULL);
     event_notifier_cleanup(&s->irq_notifier[MSIX_SHARED_IRQ_IDX]);
-    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->doorbells,
-                            sizeof(NvmeBar), NVME_DOORBELL_SIZE);
+    qemu_vfio_pci_unmap_bar(s->vfio, 0, s->bar0_wo_map,
+                            0, sizeof(NvmeBar) + NVME_DOORBELL_SIZE);
     qemu_vfio_close(s->vfio);
 
     g_free(s->device);
-- 
2.26.2



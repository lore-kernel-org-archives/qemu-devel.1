Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668F0C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F7F22282
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPPAHYie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F7F22282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0E4-000446-Qf
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX09w-00074X-5u
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX09t-00088l-TD
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TR2vPgke7yC3Tw04v9RRPAjEqIwyrI6NV8B8irqGPbU=;
 b=GPPAHYieH7zqqIJ9lSLHgCSSZy1HfDS2iaD+RfSY1Uvmf1SJK7JqV/xDWvAvWsIl6ZoeIM
 hc5AHJ/CmBwc7+bnC0KW+jnqWECSANX706kRmQDGbtEpwc9W5yRhPQhKlVpE/Z6A4m+1Vw
 +mBuq4bfKQXPIy2VjfR5BHWSTq3dOus=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-7HYDXEHBOwyLA0zH5t9ycQ-1; Mon, 26 Oct 2020 06:55:23 -0400
X-MC-Unique: 7HYDXEHBOwyLA0zH5t9ycQ-1
Received: by mail-wr1-f72.google.com with SMTP id k14so8191876wrd.6
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TR2vPgke7yC3Tw04v9RRPAjEqIwyrI6NV8B8irqGPbU=;
 b=s/K6Zre0kCbfMyo9tuWPmySUfEkv0587X+uFtBOYw/hSZofWqMlA4sgfr6ZDyQaDvF
 kaES6z5T2fgPJuthTtt9+1D4bEdaC3GLH6Ie8ANgW9xgY8sYBeFI6yzlDkmBHwb1/Y2b
 ozkFUWJfOjtWs2QO4NVE8KcCG3/12j34YU3sz5AbV0veC0ZUMt4QRmjAWdnAI94DChiJ
 jQIVEWworFXlzi6b9E+M5loUxweuTCCwXekKTcMEuESAXZUxZZarpuuDSJplXL+7FQi3
 dLdlxl7/pBCPxvGDBqjr2XDtxKWGYDmBiZ3/YqHNnh7HZtMD0GGh9+vRHPpYMIwk/r6T
 YE9g==
X-Gm-Message-State: AOAM5331eFODYsWuNsnLRk3+Bx//iMVHWciGGHn+dlZSt641C7xF32Kd
 ORPYemhyZuJp5Qvmrq+e7ZKr1kvgI6GUf9I/SLVhtNnhGz4Jjf3oaQGnEl86Du81mho6fJzrymj
 DcVb2dPhi4E8cXP4=
X-Received: by 2002:adf:fac3:: with SMTP id a3mr16453402wrs.240.1603709721621; 
 Mon, 26 Oct 2020 03:55:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfKtDEGK6X/lpxCTfTGZoxf5rtNsDcwucctNYJkaT3xbI2aPqz9CPIhL4qSEngN9llLEwczA==
X-Received: by 2002:adf:fac3:: with SMTP id a3mr16453371wrs.240.1603709721380; 
 Mon, 26 Oct 2020 03:55:21 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x6sm22609887wmb.17.2020.10.26.03.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 03/19] block/nvme: Introduce device/iommu 'page_size_min'
 variables
Date: Mon, 26 Oct 2020 11:54:48 +0100
Message-Id: <20201026105504.4023620-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce device/iommu 'page_size_min' variables to make
the code clearer.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index aa290996679..5abd7257cac 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -690,6 +690,8 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     uint64_t deadline, now;
     Error *local_err = NULL;
     volatile NvmeBar *regs = NULL;
+    size_t device_page_size_min;
+    size_t iommu_page_size_min = 4096;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -724,7 +726,8 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         goto out;
     }
 
-    s->page_size = MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
+    device_page_size_min = 1u << (12 + NVME_CAP_MPSMIN(cap));
+    s->page_size = MAX(iommu_page_size_min, device_page_size_min);
     s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
     bs->bl.opt_mem_alignment = s->page_size;
     bs->bl.request_alignment = s->page_size;
-- 
2.26.2



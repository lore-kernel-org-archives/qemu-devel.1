Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75760C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EAF720774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUkUHXa8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAF720774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Y7t-0000g0-HM
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y5B-0006GR-Qp
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y5A-0007sa-9Y
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597166943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+GoqSUej3zgwZ+xiUnpDsXAhP2y+mvV6f0QWRC1FMg=;
 b=cUkUHXa8cTOYlhSk+Kqm4G6c91N9Q9yrlvAPkcvJW1VL81+JIz0EoqIgejiRfXO6hdLiaI
 mEIkJ/oxcNqHgbCDrAY6MplSe14SNNXDWBte2wfomjFyerwi9uCpW84dE0VZOOtlH3L+FB
 FLkRn8CgSNyb1joi03wJD+0dPasNP6A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-639HGpZ_OpuCTOQa1QhC9A-1; Tue, 11 Aug 2020 13:28:59 -0400
X-MC-Unique: 639HGpZ_OpuCTOQa1QhC9A-1
Received: by mail-wm1-f69.google.com with SMTP id q15so1047130wmj.6
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 10:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V+GoqSUej3zgwZ+xiUnpDsXAhP2y+mvV6f0QWRC1FMg=;
 b=P3MwKky7K/mqsQkXJM4+l52ng80I/WNGLVwuApFZaQUj/JG9x9S41FqMvbE291xr6m
 DCjuwLxKWEvIizJor4vCPrLo02jVjJ39GKToL/gaazdeHiY22FmiOwV7yItwJN8P2vrg
 BrrNoWwMpfMPNkEUVRcJMwbzPRre+vy8ujT6/RGwD42CXP2j4feVDfJ8t1jOguQDQTIt
 +IYaF79/wXlx2BVF8tyX/rEAInhI2qIVfEwriCVtFVIdA7F/YxfKxXO2+z/SMyv1B+Km
 AJcGXNst61IXBkD0WTuDJLx51LuXhMrHKNYF5wwJOmZAIcOVpTmvNRp5f73vlCr4Fg1n
 tt6w==
X-Gm-Message-State: AOAM530SSjKX6+Go0O074iZf/BvUGcW4j/3jDGYoDjYzBZvVIT1tzWdK
 YtCMTCiIU38U9jhMxb4BFpJmhhT6DoSZ3OaLMklnIZp8fShiKoZvH4FaK2W2aBw36nR3ozntRNZ
 q4KuQtnhj6ST2CZI=
X-Received: by 2002:adf:ee51:: with SMTP id w17mr7248663wro.239.1597166937720; 
 Tue, 11 Aug 2020 10:28:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzMF1uk8kTBfDHKEF29ER7wiqkEMIsSs/qghTfRmatAEW10o1ExrkOxQfd+N5agvMTBp/oEg==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr7248647wro.239.1597166937517; 
 Tue, 11 Aug 2020 10:28:57 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id m126sm6405968wmf.3.2020.08.11.10.28.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 10:28:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/3] util/vfio-helpers: Add trace event to display device
 IRQs available
Date: Tue, 11 Aug 2020 19:28:44 +0200
Message-Id: <20200811172845.16698-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200811172845.16698-1-philmd@redhat.com>
References: <20200811172845.16698-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 05:47:20
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a trace event to display the amount of IRQs available
on the device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 1 +
 util/trace-events   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 6defefcc01..3ad7e6be52 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -192,6 +192,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         error_setg(errp, "Device interrupt doesn't support eventfd");
         return -EINVAL;
     }
+    trace_qemu_vfio_pci_init_irq(irq_info.count);
 
     irq_set_size = sizeof(*irq_set) + sizeof(int32_t);
     irq_set = g_malloc0(irq_set_size);
diff --git a/util/trace-events b/util/trace-events
index 0ce42822eb..351dbdbe3c 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -83,3 +83,4 @@ qemu_vfio_new_mapping(void *s, void *host, size_t size, int index, uint64_t iova
 qemu_vfio_do_mapping(void *s, void *host, size_t size, uint64_t iova) "s %p host %p size %zu iova 0x%"PRIx64
 qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size %zu temporary %d iova %p"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
+qemu_vfio_pci_init_irq(uint32_t count) "device interrupt count: %"PRIu32
-- 
2.21.3



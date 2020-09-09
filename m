Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37692C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FAA215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJ1OF0TY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FAA215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG13c-0003d7-O8
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG11K-00087J-L4
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38770)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG11I-0004Qn-UQ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599661460;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hl24NRJ8Rt13BsX1usyBfMcCTpzjZpiQVXtc8EueBIg=;
 b=AJ1OF0TYGzo2vwRmFJANqrtrvQjrtcXGXBAt9AIbzBgE8Dr1YqZTGH+NnexamYDVN0tNBf
 Kp4WG3Xk4QvbGibR5GVXypv3YOnd/aDSYuRx82vQArc2oj0a4KlH1w6/t9ZiT6UJqhRZ3M
 /MifBle//pdkSXTRmf4RDcMU69+MRq4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-cYC8fy7nOlOjoaABe1dcBA-1; Wed, 09 Sep 2020 10:24:19 -0400
X-MC-Unique: cYC8fy7nOlOjoaABe1dcBA-1
Received: by mail-wr1-f72.google.com with SMTP id v12so1031576wrm.9
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 07:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hl24NRJ8Rt13BsX1usyBfMcCTpzjZpiQVXtc8EueBIg=;
 b=rDc63UiJic2ikm9xg4CPF7gBjUaIWh7UWsin8Z/nxSCFQKOgMlFFQ7tnWmMIvjglKt
 b37Q6cCsWpetWavck47q/QGyIDgwGp10qzs4SUNyCsyl7BzRVrb0lyLQifu24M9Xklp2
 o86KflcNFm+53QWvYlx2FjLumhR6vaKLYvocfcON/qUJhCcB/c0Te4F3AFG/H3Ej1sdh
 J0HoXC2KmN9Fr9/xTOTeUwte/TfA8azz/6CHw+IWeiXZ5u6vyJAqe/Nf06SNQy+KNJ8E
 Jj+QB5rLa/iXZhGHINyPQf/N0i3y2/voxmJBxGrfTXFGbjRVezyklbskZ3K9q78/HK6m
 xXCA==
X-Gm-Message-State: AOAM530VH3AX1kSFtz7eZiUdiVFW3CBIET9w6MVZBeki5XRI6kVxCO9E
 mRC/u1Gg4NMLxneyAGT6N5RGrvUfs3Rs/Dfslo/HkvfTjHIbOc0/7/hgfDKzgla056xi7KtTB9J
 A7iIMEr2dlKas5tk=
X-Received: by 2002:a1c:6341:: with SMTP id x62mr3814942wmb.70.1599661456337; 
 Wed, 09 Sep 2020 07:24:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2AuS7XclxQglsXhutPrkRcK+UtTdydKLuczpxR70nsEyCL2jF0vcml4H9rgqTzZrK7nihWw==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr3814920wmb.70.1599661456134; 
 Wed, 09 Sep 2020 07:24:16 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b187sm4172577wmb.8.2020.09.09.07.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 07:24:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 4/4] block/nvme: Use qemu_vfio_pci_init_msix_irqs() to
 initialize our IRQ
Date: Wed,  9 Sep 2020 16:23:54 +0200
Message-Id: <20200909142354.334859-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909142354.334859-1-philmd@redhat.com>
References: <20200909142354.334859-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 07:20:24
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
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of initializing one MSIX IRQ with the generic
qemu_vfio_pci_init_irq() function, use the MSIX specific one which
will allow us to use multiple IRQs. For now we provide an array of
a single IRQ.

Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index f4f27b6da7d..e6dac027f72 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -694,6 +694,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     uint64_t timeout_ms;
     uint64_t deadline, now;
     Error *local_err = NULL;
+    unsigned irq_count = MSIX_IRQ_COUNT;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -779,9 +780,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
-    ret = qemu_vfio_pci_init_irq(s->vfio, s->irq_notifier,
-                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
+    ret = qemu_vfio_pci_init_msix_irqs(s->vfio, s->irq_notifier,
+                                       &irq_count, errp);
     if (ret) {
+        if (ret == -EOVERFLOW) {
+            error_append_hint(errp, "%u IRQs requested but only %u available\n",
+                              MSIX_IRQ_COUNT, irq_count);
+        }
         goto out;
     }
     aio_set_event_notifier(bdrv_get_aio_context(bs),
-- 
2.26.2



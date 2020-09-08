Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF72C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:07:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A52B2078E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8Ot4vq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A52B2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFi1O-0001Ua-0T
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:07:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyV-0004bA-QY
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyU-0004wI-8G
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599588249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4smBdlAc0sZG3krNCT9P/6joeN88R8GXoueqJ2wfC6o=;
 b=c8Ot4vq4qZpfBjA4hjifs5UIhhwF2EOAtlYsRLi2OS+6mcPEeYVpg7HTPUWNTBhoZ/yA0x
 rWxzu5jUw3WQItMi3IpLKG+nAeRejmk4i8rzBVyj2jwgfGkRLmDb1BS7pkREfRW93DN+YP
 w5Tsa01aKtAwESlPPRSaG3WXq/zg+VE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-KCiC9DuRMRiKv3Vu3Y4CyQ-1; Tue, 08 Sep 2020 14:04:08 -0400
X-MC-Unique: KCiC9DuRMRiKv3Vu3Y4CyQ-1
Received: by mail-wm1-f70.google.com with SMTP id s24so62662wmh.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4smBdlAc0sZG3krNCT9P/6joeN88R8GXoueqJ2wfC6o=;
 b=umg8w27HILvdtehe+jC4VcVj5/NWZPp5mSVNuRdwlWYKoqvoruVXoFOTJVN6+Yqf8Z
 vMTGWXrdLjqrFLLDvW10F1HrFbALKTQVoPULYWqPnS6FR6W+tiY8lJAGN7UXMMqvqGVJ
 FedMfEKmUn4HYPQYtFJL0nlu95mJseOOxsqJF4jQ2/CVXQywbBIU8JdGWzoY/CDzWgfY
 yfI38ht4gz27YVeBqN8GmJBx7O9LHUar4yOnXMzfU5XCqJmtHW0puLnZpDMe1AhXn1IL
 CkgijCv8IzIdeClxYqsXy4vLs27UPH3I6A6tyl4q/IMxKMe6pTXwdAJlTrgplNuV7hdH
 Xbdw==
X-Gm-Message-State: AOAM530adhvfLLHmG+5Us+DHegaFkBPzIGy3umKRnX+M2oiwdUY3Ny+D
 Y/pUfet5iDHYWTiq2Bk8LVGpK4Zr1APWeJ2jYoluMOlVpijW5wi1watHjdfwVu6FzFo3kw5gN8M
 WtDofZEyg1jmimR4=
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr334792wme.18.1599588246923;
 Tue, 08 Sep 2020 11:04:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpBqDum+bXDlKYU0E8MXGSZtFEiFMyZnZASZIE8kAGlKmub1z5YngpEAbSKiZ1g8cOaaLcPw==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr334775wme.18.1599588246756;
 Tue, 08 Sep 2020 11:04:06 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id d18sm362895wrm.10.2020.09.08.11.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:04:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v5 4/4] block/nvme: Use qemu_vfio_pci_init_msix_irqs() to
 initialize our IRQ
Date: Tue,  8 Sep 2020 20:03:42 +0200
Message-Id: <20200908180342.280749-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908180342.280749-1-philmd@redhat.com>
References: <20200908180342.280749-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:54
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
ill allow us to use multiple IRQs. For now we provide an array of
a single IRQ.

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



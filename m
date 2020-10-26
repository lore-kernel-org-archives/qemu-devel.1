Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3278C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F0222263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDGq7RtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F0222263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0RU-0004SU-WE
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0B5-0000HC-Gt
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0B3-00009r-Oe
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owqIkSbFHgdfPD7uMP3x2r37Kgl7CGcfC6ZJAfrhmJc=;
 b=ZDGq7RtErFHi3aNctJOhV6/b4tHE86VWn+rYLVe7Zb3Xnbhkpd3vDGOlgV7Wn/2LOxHR9s
 fwC9c8hNV5Cs/22beLjvM3jo1tTaMmiQ5pWCA+aFUIe1cQL4o7LkXZxGc0qACKnQFt25m6
 5cDXp9IrWaL2YxF8mC/Swdh/UQm9oAk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-ypyj7U-xMC6-QStvdKCjEA-1; Mon, 26 Oct 2020 06:56:35 -0400
X-MC-Unique: ypyj7U-xMC6-QStvdKCjEA-1
Received: by mail-wr1-f72.google.com with SMTP id 31so8159199wrg.12
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:56:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=owqIkSbFHgdfPD7uMP3x2r37Kgl7CGcfC6ZJAfrhmJc=;
 b=D4KCHvX1f30qIA1kER/x3L7I50RkopHi0Hii3hvOqt0P4ywJ4JNRlCeLVxuMcGAYwp
 kUdZ4uP0tsrUjxFYmSpbNxeu0LCz/MHrHeAfyXQ5J596+s+8SXsOqnDt6Cp/4eI7JISw
 Cqoz6rGWg9L9HnpAJFXx60oP0zOKxqFMfjiNGMXu6BjbtLji0UCc+xZUQTJQatNTIWC8
 ayHZ5s0FArQ8zQmrfSh4YaPaomfyNolAUTQ+8LKDD25bJlpkiSEpsR6z6jZupqO6NGb1
 RdCRK96I2Sk5n7h95G62iVbSKAiA+yRRJ5KqjJsi9unNObj6Vkl77cMhgCLCHKxxLL/D
 o3aA==
X-Gm-Message-State: AOAM532FrriYEMqgwCn8ON4/HMxnDVHjySf6u9Z5k1/DbW34yls3cbKn
 PI3feKlmK56Oy3sLtV+kvnX+3FC8qji33KkA3KhlHalMCoLkGiom/VVN648o/NrPWse/0QQAm/Z
 qRaZqu3UL/vzzxJY=
X-Received: by 2002:adf:cd8d:: with SMTP id q13mr16960612wrj.268.1603709794047; 
 Mon, 26 Oct 2020 03:56:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyStCr9GxFzTzPbqA2g6ofgt9QpElmIywQhpDNkYRmZvTibmFmzj5jiI6159FHxiZD587MCGQ==
X-Received: by 2002:adf:cd8d:: with SMTP id q13mr16960590wrj.268.1603709793897; 
 Mon, 26 Oct 2020 03:56:33 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id k18sm21115302wrx.96.2020.10.26.03.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:56:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 18/19] block/nvme: Switch to using the MSIX API
Date: Mon, 26 Oct 2020 11:55:03 +0100
Message-Id: <20201026105504.4023620-19-philmd@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

In preparation of using multiple IRQs, switch to using the recently
introduced MSIX API. Instead of allocating and assigning IRQ in
a single step, we now have to use two distinct calls.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 46b09b3a3a7..191678540b6 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -693,6 +693,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     size_t device_page_size_min;
     size_t device_page_size_max;
     size_t iommu_page_size_min = 4096;
+    unsigned irq_count = MSIX_IRQ_COUNT;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -809,8 +810,17 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
-    ret = qemu_vfio_pci_init_irq(s->vfio, s->irq_notifier,
-                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
+    ret = qemu_vfio_pci_msix_init_irqs(s->vfio, &irq_count, errp);
+    if (ret) {
+        if (ret == -EOVERFLOW) {
+            error_append_hint(errp, "%u IRQs requested but only %u available\n",
+                              MSIX_IRQ_COUNT, irq_count);
+        }
+        goto out;
+    }
+
+    ret = qemu_vfio_pci_msix_set_irq(s->vfio, MSIX_SHARED_IRQ_IDX,
+                                     s->irq_notifier, errp);
     if (ret) {
         goto out;
     }
-- 
2.26.2



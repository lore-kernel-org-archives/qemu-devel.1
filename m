Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC066C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DF0E20888
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoO8K+rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF0E20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Qem-0001fT-Kr
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QZ7-0003mG-HX
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:03:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44460
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QZ5-0005si-FB
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597853030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMq/IR7jWnYFLcjiv5ZIbAiXOU9p9ozhKfQJrVCkul8=;
 b=UoO8K+rwtZkezH+viUzeLAC7FltDG+hsSyfMWKIYYpXU3ooAL4v1yHQGdEro10qhcYjzoK
 PP0bWeGkti5KPORmyDX7s+JMoywZ6mJ4Fv13bc+4apQDGrIg8mJHad8oRBYL9d/76yV4x4
 OPvov6FVKvuKFRuoatinfGJu8slxAvI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-nqhFs9q6O4GBrbs1vMpfUw-1; Wed, 19 Aug 2020 12:03:48 -0400
X-MC-Unique: nqhFs9q6O4GBrbs1vMpfUw-1
Received: by mail-wm1-f71.google.com with SMTP id z1so1084773wmf.9
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 09:03:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XMq/IR7jWnYFLcjiv5ZIbAiXOU9p9ozhKfQJrVCkul8=;
 b=Y5woqpAPAhGQhkK0J5jzxxr44fTMUl9W0MSPOoPiB1tKGpmjp6+fdnJBl1mUmImRyN
 /l+uOVWa3zarmjka4PjFT80fu1qE5iD2+vcS0XtKmoQ73Q55R7Kd3bfQolmDev9t6NsN
 3ojkt4gU4nowjG7Wa20IuclCc7UpPORxTA1Ouud96CR3xihzv4mI+ZWzNDQXBsZBF3IU
 5wlUiokNgECUlAA2YZK8IetldQsCCy/XuDtSvFIVL0d4M+0xaVLu1MajAdnhujh+h7GG
 6QF+OUjy4f2lRxWcVzqqUN4PBnxlETN5QmQBqsv5GqqQpEXVTI/Uj/YpKNLaObhxvwhX
 fU0g==
X-Gm-Message-State: AOAM532OSTKIwIb61ksPMwKLv+tk5q/IQerkz5Kac9VOdxKVI3Q1JDf7
 pZsJcA2eZT/mhpAAMDRy/6Fra37l/45U+5Vc3I8R2eAoESPNk88bFzrMIMUQ4lwXcpJbZgdH29Y
 lwzJ/PNB53L+t/rI=
X-Received: by 2002:adf:ce89:: with SMTP id r9mr27416799wrn.116.1597853027307; 
 Wed, 19 Aug 2020 09:03:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5d9WBPzgvJcaTjW0wutP9XrT/+KrpHr3fKA2d3s0x0o2pVbBqzh3pv+vnxDmp++G8v3ZIrQ==
X-Received: by 2002:adf:ce89:: with SMTP id r9mr27416771wrn.116.1597853026994; 
 Wed, 19 Aug 2020 09:03:46 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k10sm42030644wrm.74.2020.08.19.09.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 09:03:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 5/5] block/nvme: Use qemu_vfio_pci_init_msix_irqs() to
 initialize our IRQ
Date: Wed, 19 Aug 2020 18:03:18 +0200
Message-Id: <20200819160318.835292-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819160318.835292-1-philmd@redhat.com>
References: <20200819160318.835292-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 04:57:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index fe8a40b7ede..cafa2cb3f95 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -707,6 +707,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     uint64_t timeout_ms;
     uint64_t deadline, now;
     Error *local_err = NULL;
+    unsigned irq_count = MSIX_IRQ_COUNT;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -792,9 +793,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
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



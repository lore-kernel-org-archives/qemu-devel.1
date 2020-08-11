Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74656C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEBF20774
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOpJgJII"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEBF20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Y8J-0001IO-En
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y5D-0006KD-Ts
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:29:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y5C-0007sl-8D
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597166945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X2/WNd4jTi0UkVLBRLD3Xj2+RUbiow3/I7nhgprFGEU=;
 b=fOpJgJII6HvPp5IAHZU1f9yitxnTzpdqC1a1wGxFmYR/I/xl970HMju6K1Vq1mpHaAE9/Q
 EchlRb98My54d7MeJ2udy22YYzlneEV1qLGjjwawPrE1NxUgVFbEEnm/Wj6Lkg5hJunSVE
 8nZGUj15KhMPN5tzO2wkCsMlO6TuuwI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-KO2d97RHOnWBsjidTl9Okw-1; Tue, 11 Aug 2020 13:29:04 -0400
X-MC-Unique: KO2d97RHOnWBsjidTl9Okw-1
Received: by mail-wr1-f72.google.com with SMTP id 89so5824321wrr.15
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 10:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X2/WNd4jTi0UkVLBRLD3Xj2+RUbiow3/I7nhgprFGEU=;
 b=EA4ImWX5PBEFZrk3xR5egvVaDRyNhL8GtKbpphU+sKknFQZy0VosIJbpN3/FLap+rf
 sEoNehmh13Ie2+fbcqmL5mTDM4oRqgwa/3acdSfJixdedA2HlcTnjFD1o/QirRJYKVkx
 mkUQqXTXqAjY3TE9pGDR3Q7xhGACzRKA32afy59TBur9hjIH9ORiVT+4EFThIOTg43Ju
 knS2sZwGk5P12WEYb3csYein1raJ9D5ePH1GnwgP422a0syAz/+Et/fNhkzn4D4xODl5
 lLOfrnzn0rZ6/6s/6j+5hjomKxJcY6wn9RMu0sBYtYlrT8BasBC8saFFDptJJGvdaj2R
 MRWQ==
X-Gm-Message-State: AOAM530MaG7CnmOq0OInZlQaRfxfVuCvPp0E/oJyi01b5FoIXaWFBIlL
 FtpRi7JYjU/mcOUbpMzhwHF6q2EFT1MLLzqoY/84ntVUTuz5VcXj+3NwQhNXyptO8rTYWQVS3Vt
 XufRmG/c/6KrQDcQ=
X-Received: by 2002:adf:f64f:: with SMTP id x15mr32338170wrp.180.1597166942517; 
 Tue, 11 Aug 2020 10:29:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9KHwi/lLfo3xCfccvDkEjSj1wQAvXBicLm92vEYrZtDypelJrpCqy5UJ0r2GK6wqHqQtJeQ==
X-Received: by 2002:adf:f64f:: with SMTP id x15mr32338154wrp.180.1597166942290; 
 Tue, 11 Aug 2020 10:29:02 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l18sm27851974wrm.52.2020.08.11.10.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 10:29:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 3/3] util/vfio-helpers: Let qemu_vfio_pci_init_irq take
 IRQ index argument
Date: Tue, 11 Aug 2020 19:28:45 +0200
Message-Id: <20200811172845.16698-4-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
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
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new 'index' argument to qemu_vfio_pci_init_irq() to be able
to initialize other IRQs than IRQ #0. Adapt the single user of this
API in nvme_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  2 +-
 block/nvme.c                |  2 +-
 util/vfio-helpers.c         | 12 +++++++++---
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 1f057c2b9e..ff63e75096 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -27,6 +27,6 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
 void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
                              uint64_t offset, uint64_t size);
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
-                           int irq_type, Error **errp);
+                           int irq_type, unsigned index, Error **errp);
 
 #endif
diff --git a/block/nvme.c b/block/nvme.c
index 374e268915..2b3986b66d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -757,7 +757,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
 
     ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
-                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
+                                 VFIO_PCI_MSIX_IRQ_INDEX, 0, errp);
     if (ret) {
         goto out;
     }
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 3ad7e6be52..ba9a869364 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -173,10 +173,11 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
 }
 
 /**
- * Initialize device IRQ with @irq_type and register an event notifier.
+ * Initialize device IRQ @index with @irq_type
+ * and register an event notifier.
  */
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
-                           int irq_type, Error **errp)
+                           int irq_type, unsigned index, Error **errp)
 {
     int r;
     struct vfio_irq_set *irq_set;
@@ -193,6 +194,11 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         return -EINVAL;
     }
     trace_qemu_vfio_pci_init_irq(irq_info.count);
+    if (index >= irq_info.count) {
+        error_setg(errp, "Device has %"PRIu32" interrupts (requested index %u)",
+                   irq_info.count, index);
+        return -EINVAL;
+    }
 
     irq_set_size = sizeof(*irq_set) + sizeof(int32_t);
     irq_set = g_malloc0(irq_set_size);
@@ -202,7 +208,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         .argsz = irq_set_size,
         .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
         .index = irq_info.index,
-        .start = 0,
+        .start = index,
         .count = 1,
     };
 
-- 
2.21.3



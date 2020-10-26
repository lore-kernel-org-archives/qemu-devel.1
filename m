Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B19C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7A52223C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="StnC6G3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7A52223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Vv-0000BY-8m
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0BA-0000U7-8c
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0B8-0000Cc-JM
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjiqDTNg6IlVQRDX7FtGh0Vb3qFf/kKU7hA/I3jkchg=;
 b=StnC6G3k3oKDoyEiERmBwd1a2fWIs19sJaZHolWAvkoR2veVgQDflhPkn6kTAV7VFG+CoB
 KvZngkgt9KkvctXjz0srT/tU4cBfqn/TPI3mf1Equc+Qv9WOmQ6Duq0jKKUtADY8GJcUOl
 HVibXKy0Wn5JCJxUpNdxUFIqB4P63Rg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-Zhda4dpxOLqySREpofiuAQ-1; Mon, 26 Oct 2020 06:56:40 -0400
X-MC-Unique: Zhda4dpxOLqySREpofiuAQ-1
Received: by mail-wr1-f69.google.com with SMTP id p6so8126966wrm.23
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tjiqDTNg6IlVQRDX7FtGh0Vb3qFf/kKU7hA/I3jkchg=;
 b=iEhsO/6fB5R4Hg+ZT7TGugaN1WqUn1GJ/L17PR7SiKk2mPacmz88qmNUv1xPWXtckS
 PQmw4J9k6/7Y1lAr2dRGmvqWGgC7P8lGBLq94cpMLrwXMaeCQFdtbUwbXch5QxnJgfOu
 W1oY9KXEIkdoqP0TOr/AaoQwZMiYNE1LHP9HcGpp5oYybIdLgTrNbg+Su/Vu02GaGbn/
 7KMs8H24Oqq0gxaNj4B6MXBqPPmMkAtizsrYbZwXWaRPHKVyVQWpz1x+CqI8qov86TwC
 ph688Daygy1ldy9+NqQRaBsb0fi2rj/9IbQctCQaCLyHE/5Hp8JpWlwsfJLWNip9k42N
 dc0w==
X-Gm-Message-State: AOAM532OBgwsQriF+r2skVc7RMVGh4jKJLKU4ZnGK1bsdqY0SS+vEZzf
 NgrSo9lOSkuwAeDCVCC+MvUQBZse8LgYQICh04dCmvhmeqyIWG1QRl+1jwZC4nqfRce/Hb8ERud
 4MVjckdcYVbV8l8w=
X-Received: by 2002:adf:df91:: with SMTP id z17mr16494475wrl.379.1603709798839; 
 Mon, 26 Oct 2020 03:56:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytN3mEF4Hc6GaEYj3Y6qef4YQsPeZ8djC15U7IdK3PastNYOq167V0jsz8okdHtd5QnArKWg==
X-Received: by 2002:adf:df91:: with SMTP id z17mr16494463wrl.379.1603709798676; 
 Mon, 26 Oct 2020 03:56:38 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x22sm23311138wmj.25.2020.10.26.03.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:56:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 19/19] util/vfio-helpers: Remove now unused
 qemu_vfio_pci_init_irq()
Date: Mon, 26 Oct 2020 11:55:04 +0100
Message-Id: <20201026105504.4023620-20-philmd@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Our only user, the NVMe block driver, switched to the MSIX API.
As this function is now unused, remove it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  2 --
 util/vfio-helpers.c         | 43 -------------------------------------
 2 files changed, 45 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 4c06694e03a..f42371d25d6 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -29,8 +29,6 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
                             Error **errp);
 void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
                              uint64_t offset, uint64_t size);
-int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
-                           int irq_type, Error **errp);
 int qemu_vfio_pci_msix_init_irqs(QEMUVFIOState *s,
                                  unsigned *irq_count, Error **errp);
 int qemu_vfio_pci_msix_set_irq(QEMUVFIOState *s, unsigned irq_index,
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 18142e6be86..83d6eef13fb 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -189,49 +189,6 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
     }
 }
 
-/**
- * Initialize device IRQ with @irq_type and register an event notifier.
- */
-int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
-                           int irq_type, Error **errp)
-{
-    int r;
-    struct vfio_irq_set *irq_set;
-    size_t irq_set_size;
-    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
-
-    irq_info.index = irq_type;
-    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
-        error_setg_errno(errp, errno, "Failed to get device interrupt info");
-        return -errno;
-    }
-    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
-        error_setg(errp, "Device interrupt doesn't support eventfd");
-        return -EINVAL;
-    }
-
-    irq_set_size = sizeof(*irq_set) + sizeof(int);
-    irq_set = g_malloc0(irq_set_size);
-
-    /* Get to a known IRQ state */
-    *irq_set = (struct vfio_irq_set) {
-        .argsz = irq_set_size,
-        .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
-        .index = irq_info.index,
-        .start = 0,
-        .count = 1,
-    };
-
-    *(int *)&irq_set->data = event_notifier_get_fd(e);
-    r = ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
-    g_free(irq_set);
-    if (r) {
-        error_setg_errno(errp, errno, "Failed to setup device interrupt");
-        return -errno;
-    }
-    return 0;
-}
-
 /**
  * Initialize a MSIX IRQ and register its event notifier.
  * @irq_index: MSIX IRQ index
-- 
2.26.2



Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C396C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07806207DE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 18:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUPm2zFJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07806207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFi0F-0007Pd-TL
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 14:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyV-0004Zi-8Z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:04:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFhyT-0004wC-Im
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 14:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599588248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+lJd8nD2jqa2o5e8EuQkrgaflOtxxur7Mk4eqGcrCy0=;
 b=DUPm2zFJ7C2aRd9J7gCwcG8u2R7FlWqiblAkkx3PaXizON5jvW6X/O312lVZuawRKkyhsx
 jnoZGvqqIIlE6PS/09bm6nMoZ8cBJZ8Hu86ofi8aZWThITa+3qE7nVqLGx2bKJpGLxd63U
 v/+FcKK/5H984Q2Uh6ABLCbpQwmaiqg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-cGj67CWbNwydFmE92ZLZiQ-1; Tue, 08 Sep 2020 14:04:03 -0400
X-MC-Unique: cGj67CWbNwydFmE92ZLZiQ-1
Received: by mail-wm1-f70.google.com with SMTP id d5so60605wmb.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 11:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+lJd8nD2jqa2o5e8EuQkrgaflOtxxur7Mk4eqGcrCy0=;
 b=P5AXlZY82/sJWvwItyZh7FvFUcdoAyPfitiHmB2JGVxnKxAZud3SURRMXHALFH8SW2
 wbPZx6mngQ0dysxtQnxVf5rb36T70by6PuSa1qCuUulSb+5n2fsOn/xddkyeVFYOopfK
 sByARPvnWNV8bm0fAyzdui2wsWqX1h8SBBbnqiLffGapRVOfh2trkwoENxjnhMbk63u1
 YP2EEfigRgECTz+z4KLuTtmWrZ0ISh4MSyzMVyxOs+CEXD+xBuxHcfEHXXEO0jvrADte
 CUmar/NmLafBByeKkOM9jPfvGFSfa0oIn1JLedHzdCSdUP3qQo8x9hXKg1HM3kGkpJKW
 kKfw==
X-Gm-Message-State: AOAM532KSRUI9FW1P0LmaQ0xyv3Z7bLGplQCtCjJBmjR/gwSxtpRXnDC
 +Mdr7+V3Hna7o6eg9hjXHqFR7+HaqPWaA1T4oHYncfMp3vT7QqNy65wWPMCyJyjFxnyXelyoLf0
 LglQjoTaH/zX1lTg=
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr819994wrs.107.1599588242060; 
 Tue, 08 Sep 2020 11:04:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1DEtUwQ4XpwBIMlfKmAWRjs0TQ0GCVM1Z0uuH4aSi6zBWfcarmj0A+YP23mfUffP+z9fo/Q==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr819971wrs.107.1599588241787; 
 Tue, 08 Sep 2020 11:04:01 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id v7sm201532wmj.28.2020.09.08.11.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 11:04:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v5 3/4] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
Date: Tue,  8 Sep 2020 20:03:41 +0200
Message-Id: <20200908180342.280749-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200908180342.280749-1-philmd@redhat.com>
References: <20200908180342.280749-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

qemu_vfio_pci_init_irq() allows us to initialize any type of IRQ,
but only one. Introduce qemu_vfio_pci_init_msix_irqs() which is
specific to MSIX IRQ type, and allow us to use multiple IRQs
(thus passing multiple eventfd notifiers).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  6 +++-
 util/vfio-helpers.c         | 65 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 1f057c2b9e4..092b7b243f9 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -1,11 +1,13 @@
 /*
  * QEMU VFIO helpers
  *
- * Copyright 2016 - 2018 Red Hat, Inc.
+ * Copyright 2016 - 2020 Red Hat, Inc.
  *
  * Authors:
  *   Fam Zheng <famz@redhat.com>
+ *   Philippe Mathieu-Daudé <philmd@redhat.com>
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
@@ -28,5 +30,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
                              uint64_t offset, uint64_t size);
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
                            int irq_type, Error **errp);
+int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *e,
+                                 unsigned *irq_count, Error **errp);
 
 #endif
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 6d9ec7d365c..a5970db8ae2 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -1,11 +1,13 @@
 /*
  * VFIO utility
  *
- * Copyright 2016 - 2018 Red Hat, Inc.
+ * Copyright 2016 - 2020 Red Hat, Inc.
  *
  * Authors:
  *   Fam Zheng <famz@redhat.com>
+ *   Philippe Mathieu-Daudé <philmd@redhat.com>
  *
+ * SPDX-License-Identifier: GPL-2.0-or-later
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
@@ -216,6 +218,67 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
     return 0;
 }
 
+/**
+ * Initialize device MSIX IRQs and register event notifiers.
+ * @irq_count: pointer to number of MSIX IRQs to initialize
+ * @notifier: Array of @irq_count notifiers (each corresponding to a MSIX IRQ)
+
+ * If the number of IRQs requested exceeds the available on the device,
+ * store the number of available IRQs in @irq_count and return -EOVERFLOW.
+ */
+int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *notifier,
+                                 unsigned *irq_count, Error **errp)
+{
+    int r;
+    size_t irq_set_size;
+    struct vfio_irq_set *irq_set;
+    struct vfio_irq_info irq_info = {
+        .argsz = sizeof(irq_info),
+        .index = VFIO_PCI_MSIX_IRQ_INDEX
+    };
+
+    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
+        error_setg_errno(errp, errno, "Failed to get device interrupt info");
+        return -errno;
+    }
+    if (irq_info.count < *irq_count) {
+        error_setg(errp, "Not enough device interrupts available");
+        *irq_count = irq_info.count;
+        return -EOVERFLOW;
+    }
+    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
+        error_setg(errp, "Device interrupt doesn't support eventfd");
+        return -EINVAL;
+    }
+
+    irq_set_size = sizeof(*irq_set) + *irq_count * sizeof(int32_t);
+    irq_set = g_malloc0(irq_set_size);
+
+    /* Get to a known IRQ state */
+    *irq_set = (struct vfio_irq_set) {
+        .argsz = irq_set_size,
+        .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
+        .index = irq_info.index,
+        .start = 0,
+        .count = *irq_count,
+    };
+
+    for (unsigned i = 0; i < *irq_count; i++) {
+        ((int32_t *)&irq_set->data)[i] = event_notifier_get_fd(&notifier[i]);
+    }
+    r = ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
+    g_free(irq_set);
+    if (r <= 0) {
+        error_setg_errno(errp, errno, "Failed to setup device interrupts");
+        return -errno;
+    } else if (r < *irq_count) {
+        error_setg(errp, "Not enough device interrupts available");
+        *irq_count = r;
+        return -EOVERFLOW;
+    }
+    return 0;
+}
+
 static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
                                      int size, int ofs)
 {
-- 
2.26.2



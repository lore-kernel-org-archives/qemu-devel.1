Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ECBC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9B19215A4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 14:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f4Fadyzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9B19215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG142-0004IV-1s
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 10:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG11H-0007zd-Vv
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kG11G-0004PM-4O
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 10:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599661457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSnNVE3NZlz5gegrFx1Hb/kijSce9zFnCVUjF03h6sQ=;
 b=f4FadyzqbuLcqAqC1V4MS93ACSsWasNqCtzAOW2dwvcoqDckBI4+N40CFAlmTQGMFoiyPt
 REhaVp8TdM7DLYlqM0P+WLy8fKvD188I6teivZVZE8+pAjoLBYaWtVkaAAnxP11m2cu7GK
 +OgP2HWjf7sKVOzA1RaXUnvI7DW09N4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121--bfcyVR6MmGTORQFC2yEWA-1; Wed, 09 Sep 2020 10:24:13 -0400
X-MC-Unique: -bfcyVR6MmGTORQFC2yEWA-1
Received: by mail-wm1-f70.google.com with SMTP id 189so893146wme.5
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 07:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PSnNVE3NZlz5gegrFx1Hb/kijSce9zFnCVUjF03h6sQ=;
 b=EJFgrYsUuMO+xdHZCDXv9hlPzo/uftpXUjQEhO9wD+DbeOg23t/hwUGuBBzG09YrCs
 Xzu1Kprtf1Z5eVR3gO8oSir/OiiOS/lnBbL9vDmOFZPikiMgkcAkub8IBArHLBECnMA6
 JXXHBhCMh/A7xfNnAfhLHecFT2U+A1QBY7pJPk8YQ9+7u91SE4KNSibIsxIF6mxh5uAw
 T5eMjpBvAAR1Su6jPZGWAwkyXQYnaAds/pULrPLyGU62VZPpkhPpQ+PL9nk+W/9rZFpr
 4SKoXjRXw7gQyFecUTDbGtoPUCKa0da+Fpn4eJLrZB38ChHHjc01bnV5fbsduHwX8t4A
 /39A==
X-Gm-Message-State: AOAM532TAkJPnGF5KEz2ZxQC4USCKrMtk3wM2UBxknfPIc80IvBc3tIb
 dn6XoeliwC6UicGd+GQ3u6gfXfUkzxGoz3VuOAem48GHbHCtPVCTyHH4OcACxoNAtc8pxj9MCcc
 X40j0IVdc63Y6PtI=
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr3838697wmt.22.1599661451559; 
 Wed, 09 Sep 2020 07:24:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKp0ifME2A9FwhcPA5Sliz011v1Vm6kGX+4Y22yWYAqMvtENk9OK3lhqZ+Thfd3z0oar9OSg==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr3838681wmt.22.1599661451303; 
 Wed, 09 Sep 2020 07:24:11 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a85sm4404267wmd.26.2020.09.09.07.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 07:24:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/4] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
Date: Wed,  9 Sep 2020 16:23:53 +0200
Message-Id: <20200909142354.334859-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909142354.334859-1-philmd@redhat.com>
References: <20200909142354.334859-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
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

Reviewed-by: Fam Zheng <fam@euphon.net>
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
index 4cc5697dcb2..3b1b81caf8b 100644
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



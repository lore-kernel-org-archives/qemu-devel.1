Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B55C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D292120888
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 16:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N65h0nKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D292120888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8QgK-0003ey-5y
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 12:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QZ6-0003jI-5k
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:03:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39579
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8QZ4-0005sU-As
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 12:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597853026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iAIS2oTaw8KHQnBQMzKd61Xt0Ca1CzJQZMv3ZWJBLc0=;
 b=N65h0nKgVPNpgayFmfGCTR5fzVmfl1+L0cg/lTtx42R+j6jnzxtk0h1yA5LQ2WwwVOOF4Z
 /bnEuyAT4yem9PXKpsb6LM2ZLNXqSslUnEQOwWSqAh2K0DDyRgUaEOCE5pTclifsRgbMTZ
 F5axHTZMxBbB6XHGOd+4iR0EMPrYnh8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-9wIy-FxiP1qi5cpWxJYUEQ-1; Wed, 19 Aug 2020 12:03:43 -0400
X-MC-Unique: 9wIy-FxiP1qi5cpWxJYUEQ-1
Received: by mail-wm1-f70.google.com with SMTP id k204so1197646wmb.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 09:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iAIS2oTaw8KHQnBQMzKd61Xt0Ca1CzJQZMv3ZWJBLc0=;
 b=JT+3v8kwoprIHPtp3oEd1CsdULYTLCwJQhMxaa6gt43ysG1e0PrdDbOy2cRvwrgDfY
 HsJoR0zJO6lrBkgEXUl07ltJbTvp/Tbq+4L//+UkjZWpQwMW8c6tMk9lnqY1Vl0UO3W7
 /DyGbCOcjoZfP5C1w1Drf03Kt1wPuTHGUzj0xVO/mkXUt9a0BIOoloUPTUJ1smZBCc+Y
 t5c4pTGmT/C2cDAcv7q1t3InMwl02KRHsxEqMrWbS7EcRksOR6xHS3a7/w4b8eLdwMqU
 ouxkSgPQWa4VcKCmKDVhBXYxNE7e5ZcdBoj4fnS1TAEARRtIjMH/+SXcxUgvRDAKrBfY
 LDuw==
X-Gm-Message-State: AOAM531qZiAW2Yq7YOUlMzMh404JZeqNV8ejEvYUfwKtGgCC+Gqu7dh3
 5+5gzk90Kumc5UZyK1oTAAOF1+qolcxhNbNgpGXBQH/UbgfLIlX3f1A0uis8BxCAykOuQorHmgk
 w0KylRtpsc8W/wzY=
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr25569728wrn.80.1597853022146; 
 Wed, 19 Aug 2020 09:03:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhy9t8bEtMPSS1J76XXdWjgSuWKev5bmIvy7wNcRq4eJjDML5X945784FWXO+Sa9JT1jWhQg==
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr25569713wrn.80.1597853021965; 
 Wed, 19 Aug 2020 09:03:41 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 126sm6646552wme.42.2020.08.19.09.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2020 09:03:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v4 4/5] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
Date: Wed, 19 Aug 2020 18:03:17 +0200
Message-Id: <20200819160318.835292-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200819160318.835292-1-philmd@redhat.com>
References: <20200819160318.835292-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
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

qemu_vfio_pci_init_irq() allows us to initialize any type of IRQ,
but only one. Introduce qemu_vfio_pci_init_msix_irqs() which is
specific to MSIX IRQ type, and allow us to use multiple IRQs
(thus passing multiple eventfd notifiers).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  2 ++
 util/vfio-helpers.c         | 57 +++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 1f057c2b9e4..8e6bd83ea41 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -28,5 +28,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
                              uint64_t offset, uint64_t size);
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
                            int irq_type, Error **errp);
+int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *e,
+                                 unsigned *irq_count, Error **errp);
 
 #endif
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 8f4a3d452ed..6f833972587 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -216,6 +216,63 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
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
+    if (r) {
+        error_setg_errno(errp, errno, "Failed to setup device interrupts");
+        return -errno;
+    }
+    return 0;
+}
+
 static int qemu_vfio_pci_read_config(QEMUVFIOState *s, void *buf,
                                      int size, int ofs)
 {
-- 
2.26.2



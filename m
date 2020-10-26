Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17830C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D60B2224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/qy+zz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D60B2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Pg-0000uP-8B
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0B4-0000DD-0S
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0B2-00009f-1I
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydqt7ygZQ+vGx48L3P+H0ZAxD/ypFxd/RVZSJiZUfNY=;
 b=i/qy+zz+F6R3hytz1qmlDMHNDjZkz+aRQHqN+9NEblGaLIIhAHN+CHClYPTH02izvQTz75
 Guk1//a46I9f3wlrngJYwf0hnEFA4rVila9Ye4WIe537y+BbFpY/OTAa7q50Z105XiJ9Mc
 K4vz3WrAoWO2ENhB0+Z7iZ5OcP7SDa4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-DUT0NfGUMbSz8Q1DmqC5xQ-1; Mon, 26 Oct 2020 06:56:33 -0400
X-MC-Unique: DUT0NfGUMbSz8Q1DmqC5xQ-1
Received: by mail-wr1-f70.google.com with SMTP id m20so8188965wrb.21
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ydqt7ygZQ+vGx48L3P+H0ZAxD/ypFxd/RVZSJiZUfNY=;
 b=DGZVhr4EewhviDszB8aZcWEN69yAogRf+Sx08xJasSUXw2QLXY/A/8OuD+aCLRO3Nb
 JE1RxE9LeyEvGHQDWArhOk4nIOdTKc8jG0SSZr6y4+jXZgH73JfREuRhcVNcledsEJEQ
 /S7Hl8WW7nO/+hp+NNUjBe77TxtH2SvpmO5m/9P6nYgMpxFa8xK+G3vMRtL+GhZspjyX
 uWShfKXeKk/TH+zLofKHEZp8YETEi6r2rFvH4T7rYIT17/4GKT65VI6YFjuJPEvqtO1K
 il2skL5ViFFxFVY4FCRfTkOF8U/nk7fKQ+Qf/7AqJMVfOTpXZJeKjV8FFFNbU+Sa6Hwl
 Mc7Q==
X-Gm-Message-State: AOAM530EOMQajAj+YDS0StIfZ0etvpjHpZlybFE7+myTf/Qu+CBb1/Zz
 ZAK6/P7S48SIZjOrsLmkt3E4ed1jZP7I6uRS0ja0soxXkZk86PD/o6wFlH7g8edNwY+txGP/Pdr
 uMOiVfYVSh4DTa0E=
X-Received: by 2002:a1c:2e0d:: with SMTP id u13mr15163900wmu.179.1603709789225; 
 Mon, 26 Oct 2020 03:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPFE5fIdETrd2j5V94vFl6M6DfV5yIMRzBqLdbfj1qvPlySncn2YE2eVEohtVt+EE23O6jNA==
X-Received: by 2002:a1c:2e0d:: with SMTP id u13mr15163877wmu.179.1603709789067; 
 Mon, 26 Oct 2020 03:56:29 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b18sm560693wmj.41.2020.10.26.03.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:56:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 17/19] util/vfio-helpers: Introduce
 qemu_vfio_pci_msix_set_irq()
Date: Mon, 26 Oct 2020 11:55:02 +0100
Message-Id: <20201026105504.4023620-18-philmd@redhat.com>
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

Introduce qemu_vfio_pci_msix_set_irq() to set the event
notifier of a specific MSIX IRQ. All other registered IRQs
are left unmodified.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  2 ++
 util/vfio-helpers.c         | 35 +++++++++++++++++++++++++++++++++++
 util/trace-events           |  1 +
 3 files changed, 38 insertions(+)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 492072cba2f..4c06694e03a 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -33,5 +33,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
                            int irq_type, Error **errp);
 int qemu_vfio_pci_msix_init_irqs(QEMUVFIOState *s,
                                  unsigned *irq_count, Error **errp);
+int qemu_vfio_pci_msix_set_irq(QEMUVFIOState *s, unsigned irq_index,
+                               EventNotifier *notifier, Error **errp);
 
 #endif
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index d88e2c7dc1f..18142e6be86 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -232,6 +232,41 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
     return 0;
 }
 
+/**
+ * Initialize a MSIX IRQ and register its event notifier.
+ * @irq_index: MSIX IRQ index
+ * @notifier: notifier for the MSIX IRQ
+ */
+int qemu_vfio_pci_msix_set_irq(QEMUVFIOState *s, unsigned irq_index,
+                               EventNotifier *notifier, Error **errp)
+{
+    int r;
+    int fd = event_notifier_get_fd(notifier);
+    size_t irq_set_size;
+    struct vfio_irq_set *irq_set;
+
+    trace_qemu_vfio_pci_msix_set_irq(irq_index, fd);
+    irq_set_size = sizeof(*irq_set) + sizeof(int32_t);
+    irq_set = g_malloc0(irq_set_size);
+    /* Get to a known IRQ state */
+    *irq_set = (struct vfio_irq_set) {
+        .argsz = irq_set_size,
+        .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
+        .index = VFIO_PCI_MSIX_IRQ_INDEX,
+        .start = irq_index,
+        .count = 1,
+    };
+    ((int32_t *)&irq_set->data)[0] = fd;
+    r = ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
+    g_free(irq_set);
+    if (r) {
+        error_setg_errno(errp, errno, "Failed to setup device interrupt #%u",
+                         irq_index);
+        return -errno;
+    }
+    return 0;
+}
+
 /**
  * Initialize device MSIX IRQs and register event notifiers.
  * @irq_count: pointer to number of MSIX IRQs to initialize
diff --git a/util/trace-events b/util/trace-events
index ec93578b125..3a56c542a94 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -88,6 +88,7 @@ qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *io
 qemu_vfio_dma_mapped(void *s, void *host, uint64_t iova, size_t size) "s %p host %p <-> iova 0x%"PRIx64" size 0x%zx"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
 qemu_vfio_msix_info_irqs(uint32_t count, unsigned asked) "msix irqs %"PRIu32" (asked: %u)"
+qemu_vfio_pci_msix_set_irq(unsigned irq_index, int fd) "msix irq %u notifier_fd %d"
 qemu_vfio_iommu_iova_pgsizes(uint64_t iova_pgsizes) "iommu page size bitmask: 0x%08"PRIx64
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
-- 
2.26.2



Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1EBC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6251521D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha+9WOqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6251521D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvg5-0006Dl-2R
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvOS-0007ex-QY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvOQ-0008Eq-0N
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5HJ76d54/0AtdtuncdqQBgCT9XMbn0n9hcSFQu6+E4Y=;
 b=Ha+9WOqp6f/WJcpa+fmKjWZ8boTWC3Ocd/vNPDPpQRG6uDrP5XqNdsE3T6slypVuim+U+q
 OT21dD1G/XHZ9HOdBAeeIcWCBEMeDk+TLmjaWT5Gi2lhQsi4qITlseyY3rvpbUjgMwu5cJ
 34Qp4wKL6eUTnje5SR70ZyD8bfHDnlo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-wRoXjro3OFyeSF8bEHGZzg-1; Tue, 20 Oct 2020 13:25:43 -0400
X-MC-Unique: wRoXjro3OFyeSF8bEHGZzg-1
Received: by mail-wr1-f72.google.com with SMTP id 91so1064641wrk.20
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5HJ76d54/0AtdtuncdqQBgCT9XMbn0n9hcSFQu6+E4Y=;
 b=FN/biRCBl22MOlZXt2WZ0NGvQ0CZvVorM33/DHPibVUMrlEpPSzdmJ9gjBB8DDUAXU
 aBLlNVI6u4rCP/qt2OgMit/WXXwumxw/gK4u3f3gJIrEIOvWV6X1m/E+aKrGv8XHPb+N
 DZqX2LHhZO4dEp7Tk8anSNfVV8lMdKXmNcPYqyviWd9S+K0aERI2UHq9axzke9ugdXLZ
 j/VW+CK6pSeP2aXfIq7QIHquiklg2vBJTNBRtk7JmG+GoRBkB38mymj54AMY4c+Hq7E8
 kpMzXshubakIBlr30JZLNeFXOz9LeF5WWMxdawOCfX+LsMDH0ik/nNDDNcecHPd1/i3s
 Cj+Q==
X-Gm-Message-State: AOAM531XE+Km2l8pAXr4bU4Tj3UNq4tzKmv2zuywRz7cAttAvd58++VQ
 HofbbUTiIzgmBlWr3L5wA4ENjlXGayVK1YcyG0e7X+C1o6VC7TaFYREvzKVnktVn6tmL0IlEbWt
 rlShba/GKQH8dXiM=
X-Received: by 2002:a5d:4141:: with SMTP id c1mr4610259wrq.113.1603214742014; 
 Tue, 20 Oct 2020 10:25:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3pj7tvpzRZVzk1YoArJIv86HBeIpS1HVT9E+PVCZPgHNJ/gM5CpjYzBYCdusHB9SskEdFiQ==
X-Received: by 2002:a5d:4141:: with SMTP id c1mr4610231wrq.113.1603214741771; 
 Tue, 20 Oct 2020 10:25:41 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id x6sm3915111wmb.17.2020.10.20.10.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:25:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/16] util/vfio-helpers: Introduce
 qemu_vfio_pci_msix_set_irq()
Date: Tue, 20 Oct 2020 19:24:26 +0200
Message-Id: <20201020172428.2220726-15-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020172428.2220726-1-philmd@redhat.com>
References: <20201020172428.2220726-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Introduce qemu_vfio_pci_msix_set_irq() to set the event
notifier of a specific MSIX IRQ. All other registered IRQs
are left unmodified.

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



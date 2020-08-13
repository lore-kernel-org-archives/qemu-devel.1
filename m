Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84892C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:33:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B9F02078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWO9kkBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9F02078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6H6T-0000Zg-IT
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3R-0004bl-3x
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35711
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3P-0008FN-8G
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597339814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sI7ab5g3rJC9GYuQRXIwek5C1g0rNSicmRi+VygEKww=;
 b=OWO9kkBVPk5uA4iQfM6flTPs/1IxLFGgX7v3az7FBLDCXu8qjkhGWQoTJgohCEKbXvn1j+
 bF2czVCRuWaFe2IOfAabgJWgK4VmnK2jtI62NLyatNvHlDxsuAbCO8dCukprRlN6nnMI8j
 LPFQ/WE5pxpSnRZOtKStze0IpJeG20g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-QWquybvlMoKOIRINhYg53w-1; Thu, 13 Aug 2020 13:30:12 -0400
X-MC-Unique: QWquybvlMoKOIRINhYg53w-1
Received: by mail-wr1-f71.google.com with SMTP id d6so2342017wrv.23
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sI7ab5g3rJC9GYuQRXIwek5C1g0rNSicmRi+VygEKww=;
 b=TqXVJUIBs4ImlKZbLCsfoopYw4dyUJooHNOzE+N9dDblfNdCHeT0QG9djnPpTmyftF
 auUqBJhbKxBaRVe5XA62vM1qOsGlCxaV03to6mgURZVnZotysN1xsfbsZ3RBmWuzsFsu
 jdUZkrGj/thwhRmaniahg1omidXechcvqqtgn1g7MFMIZN88w4LV/Rr2HCD3W3LSGuTK
 RK5otiQNQzRArjGSKgEtNZLKI4Xuyv+HObiY3LuLxOsncSeNqwjI6cYmFC1Pjq2bCWFC
 /q8rIJb/pBYDh7oGVMSjenXGGREoQlZa/Mk0AqszwZ11TjLqPBjIzHraOzTXaxlyxc50
 hFXA==
X-Gm-Message-State: AOAM532G8w4IlTZCAdh8g33zOqdBpBx+ZZt76satt8wauFZ21OR+gsaR
 m/6hIrRmxtQPBS/9j6Oz41u+TobE4OW6+HZz+tw7KHl1G267wif2nPhdyeqrAmmphkV2fGCo1WS
 2a7rJIWu+Jz6kC90=
X-Received: by 2002:adf:ca06:: with SMTP id o6mr4819417wrh.181.1597339810290; 
 Thu, 13 Aug 2020 10:30:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK+gD6chJcre2IlUAn0DzSSTrVfi3cxVrghoPQWMUDqcFh7gRULPhuJXMWI7kC99R75nKEWA==
X-Received: by 2002:adf:ca06:: with SMTP id o6mr4819390wrh.181.1597339809981; 
 Thu, 13 Aug 2020 10:30:09 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id k10sm11318261wrm.74.2020.08.13.10.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 10:30:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 2/7] util/vfio-helpers: Move IRQ 'type' from
 pci_init_irq() to open_pci()
Date: Thu, 13 Aug 2020 19:29:52 +0200
Message-Id: <20200813172957.8289-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200813172957.8289-1-philmd@redhat.com>
References: <20200813172957.8289-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 12:29:49
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

Once opened, we will used the same IRQ type for all our event
notifiers, so pass the argument when we open the PCI device,
store the IRQ type in the driver state, and directly use the
value saved in the state each time we call qemu_vfio_pci_init_irq.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  5 +++--
 block/nvme.c                |  6 +++---
 util/vfio-helpers.c         | 13 +++++++++----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 1f057c2b9e..728f40922b 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -15,7 +15,8 @@
 
 typedef struct QEMUVFIOState QEMUVFIOState;
 
-QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp);
+QEMUVFIOState *qemu_vfio_open_pci(const char *device, int irq_type,
+                                  Error **errp);
 void qemu_vfio_close(QEMUVFIOState *s);
 int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
                       bool temporary, uint64_t *iova_list);
@@ -27,6 +28,6 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
 void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
                              uint64_t offset, uint64_t size);
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
-                           int irq_type, Error **errp);
+                           Error **errp);
 
 #endif
diff --git a/block/nvme.c b/block/nvme.c
index a61e86a83e..21b0770c02 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -711,7 +711,8 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         return ret;
     }
 
-    s->vfio = qemu_vfio_open_pci(device, errp);
+    s->vfio = qemu_vfio_open_pci(device, VFIO_PCI_MSIX_IRQ_INDEX,
+                                 errp);
     if (!s->vfio) {
         ret = -EINVAL;
         goto out;
@@ -784,8 +785,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
-    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
-                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
+    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier, errp);
     if (ret) {
         goto out;
     }
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 9cb9b553a5..f1196e43dc 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -43,6 +43,8 @@ typedef struct {
 struct QEMUVFIOState {
     QemuMutex lock;
 
+    int irq_type; /* vfio index */
+
     /* These fields are protected by BQL */
     int container;
     int group;
@@ -176,14 +178,14 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
  * Initialize device IRQ with @irq_type and and register an event notifier.
  */
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
-                           int irq_type, Error **errp)
+                           Error **errp)
 {
     int r;
     struct vfio_irq_set *irq_set;
     size_t irq_set_size;
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
 
-    irq_info.index = irq_type;
+    irq_info.index = s->irq_type;
     if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
         error_setg_errno(errp, errno, "Failed to get device interrupt info");
         return -errno;
@@ -237,6 +239,7 @@ static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int
 }
 
 static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
+                              int irq_type,
                               Error **errp)
 {
     int ret;
@@ -331,6 +334,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         ret = -errno;
         goto fail;
     }
+    s->irq_type = irq_type;
 
     if (device_info.num_regions < VFIO_PCI_CONFIG_REGION_INDEX) {
         error_setg(errp, "Invalid device regions");
@@ -423,12 +427,13 @@ static void qemu_vfio_open_common(QEMUVFIOState *s)
 /**
  * Open a PCI device, e.g. "0000:00:01.0".
  */
-QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp)
+QEMUVFIOState *qemu_vfio_open_pci(const char *device, int irq_type,
+                                  Error **errp)
 {
     int r;
     QEMUVFIOState *s = g_new0(QEMUVFIOState, 1);
 
-    r = qemu_vfio_init_pci(s, device, errp);
+    r = qemu_vfio_init_pci(s, device, irq_type, errp);
     if (r) {
         g_free(s);
         return NULL;
-- 
2.21.3



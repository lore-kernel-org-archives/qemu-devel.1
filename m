Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F389C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:35:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129C72078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGLAS1oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C72078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6H8h-0003fi-9I
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3j-0005E5-Ja
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50644
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3h-0008LW-Kk
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597339833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ywqZee8nduQQdK6wqKUzzkHe/Zc1JEWxjyIJiHUdPyo=;
 b=PGLAS1oVQwDSoAaJ3ofm+Y0+ap8xVks/edV7j9DYrsFkXNxZHTIA6wA6WNnmK1fPO5G+Xn
 P04kFnnkfJXJKL+moPiLcyUd45WOxHAqHGBdXx0NB5nfc0a237BE0qPI0IJvQlHGs0Wf4/
 hHmtCE6Go5AlQBHfQcFX4QpxvD+BUcE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-4e140bhJNrqPAnhKSe0unA-1; Thu, 13 Aug 2020 13:30:31 -0400
X-MC-Unique: 4e140bhJNrqPAnhKSe0unA-1
Received: by mail-wm1-f69.google.com with SMTP id k204so2199514wmb.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ywqZee8nduQQdK6wqKUzzkHe/Zc1JEWxjyIJiHUdPyo=;
 b=DYSb3qP9OZF5IqOko/Ry0DmbUYDtF2lS+er2tgNAHJqfQ12D6LEyxerqwhYkEY9Y4e
 sv3s6sc4qRzVrILkqIp2kaFvCekKRsjcOqpuGO5oR1a0UZvM7CIWmzIhW3hKjBuUOWPq
 ePgiQYrcS2VJVQpT5h2qO1mmQ/INIUr2M45APITEdEcFoaTPZXijjLUKaKoYIW3Lh07U
 VTONF1zsM83jcVcLOie8WNPnPDdVXpuqow9irB6nJUsgqvEwQKKwoQxMrfiRzmmLgq85
 /s5uoXLLNkWWZOrtdM/uPUw5Sxdss7fkxpm4apu2169S/1mEc3cvamVEDLyr8SPyJyWW
 OQbQ==
X-Gm-Message-State: AOAM533v+80JnSHk0ug2Tnh1tCY2CxHYT77lVA6Y9l45Z92cL5vICDxa
 WntR7CAWpicyUW0z8+6pvX4ToQOuKdm39HCErNHPiiGp8OPTBdfaHA2Q3wVXlYDQxaRg997Wuhc
 0tLxrE5AXrucNw0E=
X-Received: by 2002:a05:6000:124c:: with SMTP id
 j12mr5024545wrx.83.1597339829977; 
 Thu, 13 Aug 2020 10:30:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWDrH1h28KJ5rYjBCk8PFMyT/pbZP/URUYJJzgZ8npzpzXSItWIy3h8sfW3cgFNcF47LQrfQ==
X-Received: by 2002:a05:6000:124c:: with SMTP id
 j12mr5024522wrx.83.1597339829723; 
 Thu, 13 Aug 2020 10:30:29 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id t3sm10472742wrx.5.2020.08.13.10.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 10:30:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 6/7] util/vfio-helpers: Allow to set EventNotifier to
 particular IRQ
Date: Thu, 13 Aug 2020 19:29:56 +0200
Message-Id: <20200813172957.8289-7-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200813172957.8289-1-philmd@redhat.com>
References: <20200813172957.8289-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
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

Let qemu_vfio_pci_init_irq() take an 'index' argument, so we can
set the EventNotifier to a specific IRQ.
Add a safety check. Since our helper is limited to one single IRQ
we are safe.

Our only user is the NVMe block driver, update it (also safe because
it only uses the first IRQ).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  2 +-
 block/nvme.c                |  2 +-
 util/vfio-helpers.c         | 11 +++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 728f40922b..5c2d8ee5b3 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -28,6 +28,6 @@ void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
 void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
                              uint64_t offset, uint64_t size);
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
-                           Error **errp);
+                           int irq_index, Error **errp);
 
 #endif
diff --git a/block/nvme.c b/block/nvme.c
index 21b0770c02..a5ef571492 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -785,7 +785,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
-    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier, errp);
+    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier, INDEX_ADMIN, errp);
     if (ret) {
         goto out;
     }
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 5781e4f066..7a934d1a1b 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -180,13 +180,20 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
  * Initialize device IRQ with @irq_type and and register an event notifier.
  */
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
-                           Error **errp)
+                           int irq_index, Error **errp)
 {
     int r;
     struct vfio_irq_set *irq_set;
     size_t irq_set_size;
     struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
 
+    if (irq_index >= s->irq_count) {
+        error_setg(errp,
+                   "Illegal interrupt %d (device initialized for %zu in total)",
+                   irq_index, s->irq_count);
+        return -EINVAL;
+    }
+
     irq_info.index = s->irq_type;
     if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
         error_setg_errno(errp, errno, "Failed to get device interrupt info");
@@ -196,7 +203,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         error_setg(errp, "Device interrupt doesn't support eventfd");
         return -EINVAL;
     }
-    s->eventfd[0] = event_notifier_get_fd(e);
+    s->eventfd[irq_index] = event_notifier_get_fd(e);
 
     irq_set_size = sizeof(*irq_set) + s->irq_count * sizeof(int32_t);
     irq_set = g_malloc0(irq_set_size);
-- 
2.21.3



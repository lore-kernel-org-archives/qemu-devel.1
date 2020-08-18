Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161ADC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D767C206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEsT/frj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D767C206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k84mS-0003rC-5p
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jy-000894-ON
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jw-0007JM-24
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597769135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDUa2xT6CyPSFbp3gmOWIajlvuy8ALEmH1Y6JKlFOn4=;
 b=QEsT/frjdleDo2z6jkkHj21mbKEYv5WEzCU+f4uOBUlmio2STzp+pRpoG6Tx4P/I/73gQ4
 sA9IWO/vDd0OJEMsSqVfI5c2v2D3CSjuMTZgiIZmQl66DGwepqMxLlmFmV5M/angPNBvdq
 m8GAnUY6yWJzq8Tbp42rWYe1814Xi0g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-SCjOOudMOeyQRHqDMjdbLg-1; Tue, 18 Aug 2020 12:45:33 -0400
X-MC-Unique: SCjOOudMOeyQRHqDMjdbLg-1
Received: by mail-wr1-f69.google.com with SMTP id m7so8434874wrb.20
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 09:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EDUa2xT6CyPSFbp3gmOWIajlvuy8ALEmH1Y6JKlFOn4=;
 b=JyZSFJmjxG8pdnlhogU6JesVL1tgtddt5V+H53gsBJyBTEL2KEfOl+DX9kIdTmyLlO
 Dcs78hieyRv1xY2ux9meKuRuRp0LTL3zJ4j2f1FK0tPG95zr0ewfiw0jv97QxUkT+Qdk
 p0PzgolUafL23+STyf2V0+jPVyU41zwZpyFApDFiD0zBwF9pqFyZ7CttE2oQ09pZaALg
 p3EmLrbvzqtbxvQZB3ULmUxDiK12J2/jsAZCNlAYAd6ox4J9lpAJ8VoMji037JhBNlm2
 L2wYfCwJdv8O6bcRY/i475Ciswh2SD6Ms9eDqRU9mMPu8g00NNLu+7uCfKEqzErTUki9
 gY9Q==
X-Gm-Message-State: AOAM532JGKCdfN7iBla2xZxrFmD/GF1g+17e3INGElgS9P1nS31fKQZn
 cP3wIYNtcszaXhfL6UCc1iyw1vALtO+XT5INhZ+FG7+gKqMDj3KIaRY3m2f9crIIDC2en9mkyzz
 HRbFJbOac/VA8ec0=
X-Received: by 2002:adf:b1dc:: with SMTP id r28mr121647wra.242.1597769131862; 
 Tue, 18 Aug 2020 09:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIn2qrl3iX+cB4Q+434IZczlOFkLoHvdMX1wc2QkYdFhuiYrhLgNMZ+iLsAiufRanv24hVJQ==
X-Received: by 2002:adf:b1dc:: with SMTP id r28mr121624wra.242.1597769131675; 
 Tue, 18 Aug 2020 09:45:31 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g14sm598098wmk.37.2020.08.18.09.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 09:45:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 4/5] util/vfio-helpers: Introduce
 qemu_vfio_pci_init_msix_irqs()
Date: Tue, 18 Aug 2020 18:45:08 +0200
Message-Id: <20200818164509.736367-5-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818164509.736367-1-philmd@redhat.com>
References: <20200818164509.736367-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
 util/vfio-helpers.c         | 53 +++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 1f057c2b9e4..63108ebc8da 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -28,5 +28,7 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
                              uint64_t offset, uint64_t size);
 int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
                            int irq_type, Error **errp);
+int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *e,
+                                 unsigned irq_count, Error **errp);
 
 #endif
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 696f2d51712..fb3a79a5bcb 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -215,6 +215,59 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
     return 0;
 }
 
+/**
+ * Initialize device MSIX IRQs and register event notifiers.
+ * @irq_count: number of MSIX IRQs to initialize
+ * @e: Array of @irq_count notifiers (each corresponding to a MSIX IRQ)
+ */
+int qemu_vfio_pci_init_msix_irqs(QEMUVFIOState *s, EventNotifier *e,
+                                 unsigned irq_count, Error **errp)
+{
+    int r;
+    struct vfio_irq_set *irq_set;
+    size_t irq_set_size;
+    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+
+    irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
+    if (ioctl(s->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info)) {
+        error_setg_errno(errp, errno, "Failed to get device interrupt info");
+        return -errno;
+    }
+    if (irq_info.count <= irq_count) {
+        error_setg(errp,
+                   "Not enough device interrupts available (only %" PRIu32 ")",
+                   irq_info.count);
+        return -EINVAL;
+    }
+    if (!(irq_info.flags & VFIO_IRQ_INFO_EVENTFD)) {
+        error_setg(errp, "Device interrupt doesn't support eventfd");
+        return -EINVAL;
+    }
+
+    irq_set_size = sizeof(*irq_set) + irq_count * sizeof(int32_t);
+    irq_set = g_malloc0(irq_set_size);
+
+    /* Get to a known IRQ state */
+    *irq_set = (struct vfio_irq_set) {
+        .argsz = irq_set_size,
+        .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
+        .index = irq_info.index,
+        .start = 0,
+        .count = irq_count,
+    };
+
+    for (unsigned i = 0; i < irq_count; i++) {
+        ((int32_t *)&irq_set->data)[i] = event_notifier_get_fd(&e[i]);
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



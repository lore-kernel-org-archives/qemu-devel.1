Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B7CC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFFB92078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlAswOgJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFB92078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6H4j-0006Kc-Rz
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41582)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3U-0004if-AP
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3S-0008HH-GX
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597339817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QUQtzXWUYaZwQCgRqhMZsB0lE4hy5wnmQGZtxNrd8GU=;
 b=JlAswOgJqN0i9IDrQwB6/LfX2TqE3WQHDZFlBMtoxGrtjTBbfUrgg8glOWXfBCqBT9uFuE
 Zb+xVQ2IOmd80VfuGBwl7CZZh6vRrJJNOhxQbKnuMQjf+PV+2DUJs3JJ07xhVbQOUdKcIa
 hbojO1lKH2NSeXnj3gbdXYeNJNhHnqQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-q2LFV36KNHCHcKquax0A-g-1; Thu, 13 Aug 2020 13:30:16 -0400
X-MC-Unique: q2LFV36KNHCHcKquax0A-g-1
Received: by mail-wm1-f72.google.com with SMTP id v8so2193182wma.6
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QUQtzXWUYaZwQCgRqhMZsB0lE4hy5wnmQGZtxNrd8GU=;
 b=q0QLBwzxnn/IX3Y5AnEIqXH2kgwyZFZEEtG7JDMYR7oYfPFGzPZnFCSubLRo6npSrI
 VCCdZkUK7PHNPdhSAs5xt8XALGQ8/GlWPKl7x2Wut4Ia2dMgbhxXDSp4iSwPzOabkqWq
 AzlUsaBuUydI1nou8adFwUSzE1zZRG02/Y7OWxdLU1IOAxSY5ksyhgH2+8X5lHfLxgsx
 SBfjh/iYfQlhRIw5QPmWu5cmgOa5t7rPsBOXQH4CMbZR8K8PU2BihIaCRCwP+2s+/uUJ
 Q9Ab1TWza8naZ0+IOzOcw8JhbvjPYXWC5rxFgi4q2cLusJgBqDkRqHd0Ad2jzpX9DNBX
 Xqmw==
X-Gm-Message-State: AOAM530SbfigJWJa1NaAnbjgd9gqApjZTZClhimHTjt4wa3FWfFvtclG
 ZW+gqNF6HrEjDjDLmIoJ3xqKCgfMiQBGwrScnHTPlrpuakfN+b+DfbOjSgvwTJ9sTXozBWoumI+
 bcYJEPw+k61jCoKI=
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr5422477wmc.45.1597339815035; 
 Thu, 13 Aug 2020 10:30:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyemPRGHTXhtiJtZgZpu1leEi25hip2AYfnT+wbFQ4Zg5fNr51mZR+d+STXio3EOmhMxrzkrg==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr5422466wmc.45.1597339814864; 
 Thu, 13 Aug 2020 10:30:14 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id c4sm10959456wrt.41.2020.08.13.10.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 10:30:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 3/7] util/vfio-helpers: Introduce 'irq_count' variable
Date: Thu, 13 Aug 2020 19:29:53 +0200
Message-Id: <20200813172957.8289-4-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently this helper is restricted to a single VFIO (MSIX) IRQ.
As we will slowly make it support multiple IRQs, introduce the
'irq_count' variable which contains the total number of IRQs we
initialized the device with.

Set the variable in qemu_vfio_init_pci().
Hardcode the current single IRQ used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index f1196e43dc..bad60076f3 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -44,6 +44,7 @@ struct QEMUVFIOState {
     QemuMutex lock;
 
     int irq_type; /* vfio index */
+    size_t irq_count; /* vfio subindex (vector) */
 
     /* These fields are protected by BQL */
     int container;
@@ -195,7 +196,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         return -EINVAL;
     }
 
-    irq_set_size = sizeof(*irq_set) + sizeof(int32_t);
+    irq_set_size = sizeof(*irq_set) + s->irq_count * sizeof(int32_t);
     irq_set = g_malloc0(irq_set_size);
 
     /* Get to a known IRQ state */
@@ -204,7 +205,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         .flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER,
         .index = irq_info.index,
         .start = 0,
-        .count = 1,
+        .count = s->irq_count,
     };
 
     *(int32_t *)&irq_set->data = event_notifier_get_fd(e);
@@ -239,7 +240,7 @@ static int qemu_vfio_pci_write_config(QEMUVFIOState *s, void *buf, int size, int
 }
 
 static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
-                              int irq_type,
+                              int irq_type, unsigned irq_count,
                               Error **errp)
 {
     int ret;
@@ -335,6 +336,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         goto fail;
     }
     s->irq_type = irq_type;
+    s->irq_count = irq_count;
 
     if (device_info.num_regions < VFIO_PCI_CONFIG_REGION_INDEX) {
         error_setg(errp, "Invalid device regions");
@@ -433,7 +435,7 @@ QEMUVFIOState *qemu_vfio_open_pci(const char *device, int irq_type,
     int r;
     QEMUVFIOState *s = g_new0(QEMUVFIOState, 1);
 
-    r = qemu_vfio_init_pci(s, device, irq_type, errp);
+    r = qemu_vfio_init_pci(s, device, irq_type, 1, errp);
     if (r) {
         g_free(s);
         return NULL;
-- 
2.21.3



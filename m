Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0477C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6F22078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSEa45dH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6F22078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6H6r-0001PK-Tc
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3f-00055h-O6
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31032
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3d-0008L5-I4
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597339828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PvA1qdFMQdsBLFkpZQMkY+2SEYYJPYlrU99iUSCWO6M=;
 b=MSEa45dHL6BfXbYD90iL5njhXKeUxwhsPhjoNN4oS3UsAgooG/Uv7UVJc6bYqc6xacZfXP
 Quq056oFx1bYd7ZkEzLbTXeuHi4Gt1ulGBzm03o/f0ENzjDq+5982tv1v9IrPcLTkuw67C
 kHjCh8b1ITIdWHg3g8Ge+5BHXdpUCs4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-59tzZYgAPAW3uqQfjgPMeQ-1; Thu, 13 Aug 2020 13:30:27 -0400
X-MC-Unique: 59tzZYgAPAW3uqQfjgPMeQ-1
Received: by mail-wm1-f69.google.com with SMTP id p23so2199922wmc.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PvA1qdFMQdsBLFkpZQMkY+2SEYYJPYlrU99iUSCWO6M=;
 b=dbCQLR36H0sT47fgSwDilGHXDL4YNA8jju7UA5gTqKT7EN7/kHpipLcgRnotv9cqZp
 +rs1kwPoUV40e8M2tyTOzXxgpc9mFPv6sSzUXSm7Q8aSKmgUwAztlJjOyqXa0u4CeDGm
 0hAAsjmzczG8+4VaLps8g9L6FCcM1PrCXfiQtItW253MsYZotcZiURt5IL4C1dTqRym8
 0l/OBOXqi4XmOCj9wCEXx3YOkJqJu56PbimMMPui6NCxmRKjPPYgk7HY4OGXdLBFwxT0
 MaLiW2estdIm3sC2xqJL4V7E0601L5WboDqIcEV6IU3hI+Puszh/uaHiqAeinXG/jW6I
 wYUw==
X-Gm-Message-State: AOAM5314DOKQaT/9LoFFeOIxvywuiSINBjShpjGUr+5Z0Z8I9NSTd66S
 E0eeo1Ua0tZCqza9IEVy9whiH6JDGJdpujkF0ROJNmLjTw37U6JvdglUeTv1H/pgaAIiVN5dbCR
 CM3clMHc0fsfPTKA=
X-Received: by 2002:adf:a1c6:: with SMTP id v6mr4927148wrv.197.1597339824976; 
 Thu, 13 Aug 2020 10:30:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRt4sftQhAzNPZrH9fCL4bPsOG4gqqndCuZqtbBc9mgyFEzRRgm5v0A4ofWDBMN7vi0ca8sQ==
X-Received: by 2002:adf:a1c6:: with SMTP id v6mr4927130wrv.197.1597339824828; 
 Thu, 13 Aug 2020 10:30:24 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm11257494wrn.86.2020.08.13.10.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 10:30:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 5/7] util/vfio-helpers: Support multiple eventfd
Date: Thu, 13 Aug 2020 19:29:55 +0200
Message-Id: <20200813172957.8289-6-philmd@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:44:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

When using multiple IRQs, we'll assign an eventfd to each IRQ.
Be ready by holding an array of eventfd file descriptors in the
instance state, so when we assign new IRQs we will still use the
previous eventfds for the already assigned IRQs.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index b81d4c70c2..5781e4f066 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -45,6 +45,7 @@ struct QEMUVFIOState {
 
     int irq_type; /* vfio index */
     size_t irq_count; /* vfio subindex (vector) */
+    int32_t *eventfd;
 
     /* These fields are protected by BQL */
     int container;
@@ -195,6 +196,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         error_setg(errp, "Device interrupt doesn't support eventfd");
         return -EINVAL;
     }
+    s->eventfd[0] = event_notifier_get_fd(e);
 
     irq_set_size = sizeof(*irq_set) + s->irq_count * sizeof(int32_t);
     irq_set = g_malloc0(irq_set_size);
@@ -207,8 +209,8 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         .start = 0,
         .count = s->irq_count,
     };
+    memcpy(&irq_set->data, &s->eventfd, s->irq_count * sizeof(int32_t));
 
-    *(int32_t *)&irq_set->data = event_notifier_get_fd(e);
     r = ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
     g_free(irq_set);
     if (r) {
@@ -343,6 +345,10 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     }
     s->irq_type = irq_type;
     s->irq_count = irq_count;
+    s->eventfd = g_new(int32_t, irq_count);
+    for (i = 0; i < irq_count; i++) {
+        s->eventfd[i] = -1;
+    }
 
     if (device_info.num_regions < VFIO_PCI_CONFIG_REGION_INDEX) {
         error_setg(errp, "Invalid device regions");
@@ -379,6 +385,7 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     }
     return 0;
 fail:
+    g_free(s->eventfd);
     close(s->group);
 fail_container:
     close(s->container);
@@ -730,6 +737,7 @@ void qemu_vfio_close(QEMUVFIOState *s)
     }
     ram_block_notifier_remove(&s->ram_notifier);
     qemu_vfio_reset(s);
+    g_free(s->eventfd);
     close(s->device);
     close(s->group);
     close(s->container);
-- 
2.21.3



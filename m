Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21C0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:48:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E39206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzGjjBu8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E39206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k84mJ-0003aS-PM
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jt-0007xo-KI
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30618
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jr-0007Ht-5E
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597769130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rleIQWhTOngPCq5cfqGRgdMvowv+Bx0+2loFTr63p8Y=;
 b=dzGjjBu8n2yBcJIkq4Dv9mEIHFVZoK+CNBaBKeaopduJ+sDWoIj82dutmclseT37yqRn51
 oRwEnrc1dBUupuyzSyEWT11MD8v6yPqSIsab2AiTA2le+Xeb3bFaBq05Lpmg8r5+s+48tx
 d9u5ZjjPUiyu4y9H1ZpJS6ePrLLhOJc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-bQYUgRTdM3e7bbK0sK8Zww-1; Tue, 18 Aug 2020 12:45:28 -0400
X-MC-Unique: bQYUgRTdM3e7bbK0sK8Zww-1
Received: by mail-wm1-f70.google.com with SMTP id g72so6319714wme.4
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 09:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rleIQWhTOngPCq5cfqGRgdMvowv+Bx0+2loFTr63p8Y=;
 b=qX85fcwoXwNt88UJ33O9AooxZcAq01mq2PgdNtIlyc4bFcay+To3xxI4k1xv6skQGB
 GK+WHj2FIoJC+EAFdLVSbeEqh5OEPBo4LP6WakorGYAOQdv8Nn+X8QpLjAxoGjZq/YVZ
 ClXq5irthWiFCq/yjbR4/vpmFzEiTlhrDdMA+E2deiZBTAMp1X0TPrKGSOngQNqpBlQp
 Hf7b6cTnW22CxyKfEIT+o2ZONG6BISdECaHYRP/RABe2xadv0TVM5/UEW8ZhRTTIyW9q
 WcSEHpMAMjVTTWrkZYaOjvxc0AGSW6flCh1544H/ZulGWRAep6pQVyJs0Bg4IFy+ZsH/
 Jseg==
X-Gm-Message-State: AOAM532+jg56X9XCnaoWGpO+BoBrTlX1I+bWF/7ajt36JQUivL3Lop4e
 oKS31TRXeb/M29Q1QaRNmyXbXAuB23o1RX0IDZcA6301BZlj+GbN4bG2aauD0nxk3zNrafExOTK
 l0KqXvFetkRFnqdE=
X-Received: by 2002:a1c:e912:: with SMTP id q18mr749317wmc.130.1597769126756; 
 Tue, 18 Aug 2020 09:45:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRnfGYJ2aDSXgCns+VmKpojXevW5OfKSnShuvGr8ucz3dvFmtf3YO2+rwmlQGuTUUllulhMg==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr749303wmc.130.1597769126590; 
 Tue, 18 Aug 2020 09:45:26 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g8sm630741wme.13.2020.08.18.09.45.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 09:45:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 3/5] util/vfio-helpers: Store eventfd using int32_t type
Date: Tue, 18 Aug 2020 18:45:07 +0200
Message-Id: <20200818164509.736367-4-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 06:40:33
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the documentation in linux-headers/linux/vfio.h:

 VFIO_DEVICE_SET_IRQS

 * DATA_EVENTFD binds the specified ACTION to the provided __s32 eventfd.

Replace the 'int' by an 'int32_t' to match the documentation.

Fixes: 418026ca43 ("util: Introduce vfio helpers")
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 60017936e3e..696f2d51712 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -193,7 +193,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         return -EINVAL;
     }
 
-    irq_set_size = sizeof(*irq_set) + sizeof(int);
+    irq_set_size = sizeof(*irq_set) + sizeof(int32_t);
     irq_set = g_malloc0(irq_set_size);
 
     /* Get to a known IRQ state */
@@ -205,7 +205,7 @@ int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
         .count = 1,
     };
 
-    *(int *)&irq_set->data = event_notifier_get_fd(e);
+    *(int32_t *)&irq_set->data = event_notifier_get_fd(e);
     r = ioctl(s->device, VFIO_DEVICE_SET_IRQS, irq_set);
     g_free(irq_set);
     if (r) {
-- 
2.26.2



Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905A5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E3E2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3eNAq4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E3E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6H4Z-0006B9-Eu
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3L-0004Ye-EG
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41365
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k6H3J-0008Di-7V
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597339808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l/VJPphHnQHYJp/z6UTov2I8UdZlGH9f7YiYXgJetp0=;
 b=e3eNAq4ojqcf25QDhuKnHZxNaIXRz5F2KIVHSi7XthG6N3+5fDSohBa44S8QwXVJOtmAii
 CDin5EiEfCfXca64KKVqucCKG7K47gFLIHmiUEAKggZXgEwekj07FAaBhIesawUj6ypNaS
 VyxrEv6rRqbrG5QNEdgK0YQi+3b27pg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-nQ1u_QcqObef819iJ4RbOg-1; Thu, 13 Aug 2020 13:30:06 -0400
X-MC-Unique: nQ1u_QcqObef819iJ4RbOg-1
Received: by mail-wm1-f70.google.com with SMTP id p23so2199540wmc.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l/VJPphHnQHYJp/z6UTov2I8UdZlGH9f7YiYXgJetp0=;
 b=IgtGyzvfBbYiGQln21ZEltigoKVIva16Xw71PrgOA96M+pypSiJGnMhU8O/nHWAMT+
 mmWloJzG3rRRnyw+S0i9UmrkZIg7vSvXopIpRxUZbNtPhVTiCe0zZiG2k15mmptWOcHg
 t0uAJLsHIDO3AMrZBrCt2RueOpjdK/9vGy52d5OEGFBtE1qFndLeLvwzFHB4dH+4S8z7
 hVGT4vdlerZ0ubGZvPUQf5htM4A7cHwn6ySBjbEo5VFfbRWYVdU89DwStxdqqYGV25q8
 sEMzuZ2P13f0BnBQmES5j+w2//qdpUxcixeAoaTgRfW2KsaFpwoF34mMCcsXX7TKTdnL
 jAOQ==
X-Gm-Message-State: AOAM533yVtpa2mpow8CIG7Geecwruxrt6yuyPUFJTPgIxweRqheuQrYV
 qRh2f0qper1DGnsBPbtb64t4afZ0YWYAI9IwfL2dkXii4fLxN0JFOcj+oNG45jlBMAO8zbiHn5Y
 +aOwTRnrDBxgzfJE=
X-Received: by 2002:adf:f149:: with SMTP id y9mr4810315wro.93.1597339805142;
 Thu, 13 Aug 2020 10:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDhJ8cJE3spRIsKV9BGMYioDZnVKomx4W+9h6RJ0tQjlffE9QJDV1c3yAn6ucP3k/b0FVc0w==
X-Received: by 2002:adf:f149:: with SMTP id y9mr4810295wro.93.1597339804953;
 Thu, 13 Aug 2020 10:30:04 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y203sm10942200wmc.29.2020.08.13.10.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 10:30:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 1/7] util/vfio-helpers: Store eventfd using int32_t type
Date: Thu, 13 Aug 2020 19:29:51 +0200
Message-Id: <20200813172957.8289-2-philmd@redhat.com>
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
index e399e330e2..9cb9b553a5 100644
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
2.21.3



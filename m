Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAE2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0F320771
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 17:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2mLOvRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0F320771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Y5y-00076E-Aw
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 13:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y54-00060M-J3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:28:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59088
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k5Y52-0007ry-UH
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 13:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597166936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWrrZ81ZXvAIYsTYORMXdl7eDR47AQTaD/cBRLv643Y=;
 b=V2mLOvRCnxe89QTRPDJryNRBZVuGh1MUrIGoK++C3MXv0dUh0QAK1s/GW220YG5oy4ADic
 bwU4RmgsGKfIGDlOYygdD9iE03tAFJtXtSRucEbDfF8LkCwYjoar96yilehbY5rb1J6d2a
 GINd0BOMs2pZwOk6yUTy0A7WIVZnUAs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-eQO-SAGNPyu_qnMSnFkNjQ-1; Tue, 11 Aug 2020 13:28:54 -0400
X-MC-Unique: eQO-SAGNPyu_qnMSnFkNjQ-1
Received: by mail-wm1-f71.google.com with SMTP id f74so1053618wmf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 10:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sWrrZ81ZXvAIYsTYORMXdl7eDR47AQTaD/cBRLv643Y=;
 b=Og/vEHb9kSCtVfMeM2xLjDr3bns/u65DzZVn+VVNuWk1R6NuBo6O+Hc1WhWayyIzie
 qtZiv+F4TXQ1yNO978UjtW/LqfFSBIIEVUrwyWRbDTPxDcmDcgLq9tXUDuRwoF4HLGMY
 nzAWr7HS+9w7qdVVfLZ3/TWbaSDfZ0X2f4mTRvxQNyfWFqOTi8XyVN8R2xlqJ8brNE4P
 dFWyUZMcYh4E6WVFmtnNr849LzI+c2PHaTo+OlYwSOhrKe0LsAF/jQ1JC1JrxclYnoGR
 P+wflz+4cimb+Nk5n/FK0L23/6jdOW9VSI2ewNQc30U+Y0cJunfB1MViG1G46vHAhrI9
 UZoA==
X-Gm-Message-State: AOAM531afQ5FvvPMjfJ/5Z2OGhNvJtU3rxV+te8+0QNJnOKrmhB8h/YW
 frWMHqPSyrZ7oZVRrCqT9u1ls1vcnLBbxg0oPA4spIdFhIIsZURxQkGeTWOKN6UHBsuv3o0GYDo
 YjBgvjRfiMZeWeI8=
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr4915951wmh.33.1597166932884;
 Tue, 11 Aug 2020 10:28:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0NR5gJIbKS11dFNDTOSoBfe6J9gpb9G3NcmID+QPIGejHEVMfh7dVeDWJd/be26VdZ+e9AQ==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr4915930wmh.33.1597166932621;
 Tue, 11 Aug 2020 10:28:52 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g3sm31854244wrb.59.2020.08.11.10.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 10:28:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/3] util/vfio-helpers: Store eventfd using int32_t type
Date: Tue, 11 Aug 2020 19:28:43 +0200
Message-Id: <20200811172845.16698-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200811172845.16698-1-philmd@redhat.com>
References: <20200811172845.16698-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 02:18:06
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
index 583bdfb36f..6defefcc01 100644
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



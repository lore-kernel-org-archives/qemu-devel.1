Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F731C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D2CB206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewJiuwSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2CB206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k84mP-0003kW-6X
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84k3-0008IA-21
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:43 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53695
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84k0-0007K2-K3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597769139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKLIPhy5GVdSY6QQuAlmIzHHGk29c38mSEWX/QsQYeo=;
 b=ewJiuwSu0UcOuzo44xuRwMqEFkVIMKbE1v4BFsmAU0eLtGHGYHtuQXTm3J//tzzZK7AYgs
 sJYjApnVaydceNUHNDtcJbJDPL0QN6GF7nIGRTQCnUU/yw02jrOR3ubCiMwaxN5BWHStMc
 bwCovnE/a27KBPgQ5fP83Bp5LinDhO0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-XsrezvuMM7uEK3LT1TFWYA-1; Tue, 18 Aug 2020 12:45:37 -0400
X-MC-Unique: XsrezvuMM7uEK3LT1TFWYA-1
Received: by mail-wr1-f70.google.com with SMTP id o10so8445044wrs.21
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 09:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vKLIPhy5GVdSY6QQuAlmIzHHGk29c38mSEWX/QsQYeo=;
 b=lqEhsVhcJKcVhEWeMaWKCoe9dsPoJ63+SWiGuE4fCBj4ge820qwNcZz4Rzo8PiYwWw
 guSGPR8H3CWg50Kc4Hy7erhtovbij8K4P+NCzRe8b3pXuIFfv2BwYwtCMFRS0r689UJe
 /ysxlTe9wCAdfM9s/zjclvXjqblfF+IGdgDvHwEATuzu7rZcXtlPMAi+1/TcmRynXih7
 lRgbZS5lzz7dwg8iLNMcuv2YBA2YIkhHdpITfQyRwnajSrhWnHQEyygnqIM35eYGChV5
 ptQfDqgUmH3u+L/NB7NDh9WbxdW7HGdcfmDols1aN1r4KPqp/Odw+qcWjkMJzVibVG7F
 9ZEA==
X-Gm-Message-State: AOAM531AOX+xotGHUZFQNgMPdQBfnktFOndBJKw8IcFdV4PT8hE5cb0z
 pID2H5yw5S4bziRrjJrzOovb+8X9hhKkD5QAqjoJFKjfd+GOvaiPQcMDnu52/ASglDAoQVuUKRB
 lIIgKyZWUMJcGBpE=
X-Received: by 2002:a05:600c:220b:: with SMTP id
 z11mr764381wml.48.1597769136679; 
 Tue, 18 Aug 2020 09:45:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiL5/UQH87wOP2mmlV027f3wQE8zh2zZkVvJskAzWJ3zI0jKiVpGe4Ip2julDo1gKLVxeZpQ==
X-Received: by 2002:a05:600c:220b:: with SMTP id
 z11mr764365wml.48.1597769136531; 
 Tue, 18 Aug 2020 09:45:36 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b142sm642744wmd.19.2020.08.18.09.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 09:45:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 5/5] block/nvme: Use qemu_vfio_pci_init_msix_irqs() to
 initialize our IRQ
Date: Tue, 18 Aug 2020 18:45:09 +0200
Message-Id: <20200818164509.736367-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818164509.736367-1-philmd@redhat.com>
References: <20200818164509.736367-1-philmd@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:01:06
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of initializing one MSIX IRQ with the generic
qemu_vfio_pci_init_irq() function, use the MSIX specific one which
will allow us to use multiple IRQs. For now we provide an array of
a single IRQ.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index cdd16d451e7..cb86ba2518d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -789,8 +789,8 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
-    ret = qemu_vfio_pci_init_irq(s->vfio, s->irq_notifier,
-                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
+    ret = qemu_vfio_pci_init_msix_irqs(s->vfio, s->irq_notifier,
+                                       MSIX_IRQ_COUNT, errp);
     if (ret) {
         goto out;
     }
-- 
2.26.2



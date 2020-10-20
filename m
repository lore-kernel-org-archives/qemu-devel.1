Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B087C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C547B21D6C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVhVIRYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C547B21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvhx-0001Bg-Ni
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvOT-0007fo-Ke
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvOQ-0008F6-PV
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hs3zGfCdZlBKam4T/j2OWFCOhMeEDGMYaVQGrpVc+SE=;
 b=AVhVIRYB05D/ptEWkFK64Z3i2s04TCZ1LT0kReGbUUonFl9ZfxmXFlKpTo3Kn4otwDtCTL
 pa0YTQ646IO+JnPvxWUjeo6uszDjLJwLh4+rY+AdjKRjTaDegVaMtzRe9EZd7tlwbLr0eV
 ZRe5dKV20vdF8hV2wt1oU+imu6r/5Xg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-eg6HDhJGNiKMNu6EjTQ37A-1; Tue, 20 Oct 2020 13:25:48 -0400
X-MC-Unique: eg6HDhJGNiKMNu6EjTQ37A-1
Received: by mail-wr1-f71.google.com with SMTP id f11so1068351wro.15
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hs3zGfCdZlBKam4T/j2OWFCOhMeEDGMYaVQGrpVc+SE=;
 b=CtLJSxUnqsAD7qQmd22bbSLAJ0Vxbfyczu11rWOsjW8DOx44xTgOK+9ABMtXBzigQ9
 BCOyrehK5LMBba+H4WaJWr+XdTcAez0/B8VCLZDa5BtmtPFj3eOLOV6WPqiSvOQGOiHu
 Ly9MBteiElcFNut+XHkMmqpdlZAmGY3z7qqcvpLI7m1ONUxxZ6nrr3ykXaUe1piRZKuU
 oP4avx6jB0t0bhwoAhBz3413GwaxgJot1lLxpnR3XLj28YE8JZEBfTUbWsX917LJfabd
 w99NUCpcm5Hi28SD6QR3c0My8S2zz2atJnH4j+oDAyfMcvJoo5yxgspo8GidAK1xFKyu
 V4Aw==
X-Gm-Message-State: AOAM531Cq+MCZShAwZmFydwCD4FnRAPtv+T9AGn8m2PJjN6rwNIThUrR
 Axfc3dJAcMU2oVTFm1O+RQsUVbLtGsG7Hq9cSraUIk5NmrPoroVMp1HSE++2Sksskw7i5697bhe
 bh8ubHQTTveObQCY=
X-Received: by 2002:adf:e681:: with SMTP id r1mr4520766wrm.181.1603214746949; 
 Tue, 20 Oct 2020 10:25:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMj4E/AHJERHS9kwzdxk/tKIGBO/AsaNfcJhduQIrcKzhAhfvSBA1rgRSi61/Gk/T68DYdsA==
X-Received: by 2002:adf:e681:: with SMTP id r1mr4520753wrm.181.1603214746804; 
 Tue, 20 Oct 2020 10:25:46 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id l6sm2603241wrt.7.2020.10.20.10.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:25:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/16] block/nvme: Switch to using the MSIX API
Date: Tue, 20 Oct 2020 19:24:27 +0200
Message-Id: <20201020172428.2220726-16-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In preparation of using multiple IRQs, switch to using the recently
introduced MSIX API. Instead of allocating and assigning IRQ in
a single step, we now have to use two distinct calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 428cda620df..a5518ad5bac 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -691,6 +691,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     Error *local_err = NULL;
     volatile NvmeBar *regs = NULL;
     size_t min_page_size = 4096;
+    unsigned irq_count = MSIX_IRQ_COUNT;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -784,8 +785,17 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
-    ret = qemu_vfio_pci_init_irq(s->vfio, s->irq_notifier,
-                                 VFIO_PCI_MSIX_IRQ_INDEX, errp);
+    ret = qemu_vfio_pci_msix_init_irqs(s->vfio, &irq_count, errp);
+    if (ret) {
+        if (ret == -EOVERFLOW) {
+            error_append_hint(errp, "%u IRQs requested but only %u available\n",
+                              MSIX_IRQ_COUNT, irq_count);
+        }
+        goto out;
+    }
+
+    ret = qemu_vfio_pci_msix_set_irq(s->vfio, MSIX_SHARED_IRQ_IDX,
+                                     s->irq_notifier, errp);
     if (ret) {
         goto out;
     }
-- 
2.26.2



Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA17C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8E2206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 04:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cXurNNtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8E2206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7tJs-0006s7-3t
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 00:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6F-0007gD-Hb; Tue, 18 Aug 2020 00:19:51 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k7t6D-0006Nq-NX; Tue, 18 Aug 2020 00:19:51 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BVyNd2V5Fz9sVf; Tue, 18 Aug 2020 14:19:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597724369;
 bh=z/UXBluSn5JLDvHNxBWeTr0e76wQrUJOVa1KcxqP/OI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cXurNNtHtO3QjfUyFW9FbDOgOQGlEkPGOanpN5I438XRUfQE+uGj9j2cK0wsjYJEl
 t8HqpCxdBF/zc5kM8vPBDVGzMBc9hdYM68euyO9432o8n5uzTKUksEXBjCTBLPVVFQ
 vAB6/3Poe3EY98sm4foGqc44ZDt1JtrNTMUTTdog=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org,
	groug@kaod.org
Subject: [PULL 22/40] ppc/xive: Rework setup of XiveSource::esb_mmio
Date: Tue, 18 Aug 2020 14:19:04 +1000
Message-Id: <20200818041922.251708-23-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Depending on whether XIVE is emultated or backed with a KVM XIVE device,
the ESB MMIOs of a XIVE source point to an I/O memory region or a mapped
memory region.

This is currently handled by checking kvm_irqchip_in_kernel() returns
false in xive_source_realize(). This is a bit awkward as we usually
need to do extra things when we're using the in-kernel backend, not
less. But most important, we can do better: turn the existing "xive.esb"
memory region into a plain container, introduce an "xive.esb-emulated"
I/O subregion and rename the existing "xive.esb" subregion in the KVM
code to "xive.esb-kvm". Since "xive.esb-kvm" is added with overlap
and a higher priority, it prevails over "xive.esb-emulated" (ie.
a guest using KVM XIVE will interact with "xive.esb-kvm" instead of
the default "xive.esb-emulated" region.

While here, consolidate the computation of the MMIO region size in
a common helper.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <159679992680.876294.7520540158586170894.stgit@bahia.lan>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive_kvm.c |  4 ++--
 hw/intc/xive.c           | 11 ++++++-----
 include/hw/ppc/xive.h    |  6 ++++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 893a1ee77e..6130882be6 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -742,7 +742,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
     SpaprXive *xive = SPAPR_XIVE(intc);
     XiveSource *xsrc = &xive->source;
     Error *local_err = NULL;
-    size_t esb_len = (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
+    size_t esb_len = xive_source_esb_len(xsrc);
     size_t tima_len = 4ull << TM_SHIFT;
     CPUState *cs;
     int fd;
@@ -788,7 +788,7 @@ int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_servers,
     }
 
     memory_region_init_ram_device_ptr(&xsrc->esb_mmio_kvm, OBJECT(xsrc),
-                                      "xive.esb", esb_len, xsrc->esb_mmap);
+                                      "xive.esb-kvm", esb_len, xsrc->esb_mmap);
     memory_region_add_subregion_overlap(&xsrc->esb_mmio, 0,
                                         &xsrc->esb_mmio_kvm, 1);
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 9b55e0356c..561d746cd1 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1128,6 +1128,7 @@ static void xive_source_reset(void *dev)
 static void xive_source_realize(DeviceState *dev, Error **errp)
 {
     XiveSource *xsrc = XIVE_SOURCE(dev);
+    size_t esb_len = xive_source_esb_len(xsrc);
 
     assert(xsrc->xive);
 
@@ -1147,11 +1148,11 @@ static void xive_source_realize(DeviceState *dev, Error **errp)
     xsrc->status = g_malloc0(xsrc->nr_irqs);
     xsrc->lsi_map = bitmap_new(xsrc->nr_irqs);
 
-    if (!kvm_irqchip_in_kernel()) {
-        memory_region_init_io(&xsrc->esb_mmio, OBJECT(xsrc),
-                              &xive_source_esb_ops, xsrc, "xive.esb",
-                              (1ull << xsrc->esb_shift) * xsrc->nr_irqs);
-    }
+    memory_region_init(&xsrc->esb_mmio, OBJECT(xsrc), "xive.esb", esb_len);
+    memory_region_init_io(&xsrc->esb_mmio_emulated, OBJECT(xsrc),
+                          &xive_source_esb_ops, xsrc, "xive.esb-emulated",
+                          esb_len);
+    memory_region_add_subregion(&xsrc->esb_mmio, 0, &xsrc->esb_mmio_emulated);
 
     qemu_register_reset(xive_source_reset, dev);
 }
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 705cf48176..82a61eaca7 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -191,6 +191,7 @@ typedef struct XiveSource {
     uint64_t        esb_flags;
     uint32_t        esb_shift;
     MemoryRegion    esb_mmio;
+    MemoryRegion    esb_mmio_emulated;
 
     /* KVM support */
     void            *esb_mmap;
@@ -215,6 +216,11 @@ static inline bool xive_source_esb_has_2page(XiveSource *xsrc)
         xsrc->esb_shift == XIVE_ESB_4K_2PAGE;
 }
 
+static inline size_t xive_source_esb_len(XiveSource *xsrc)
+{
+    return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
+}
+
 /* The trigger page is always the first/even page */
 static inline hwaddr xive_source_esb_page(XiveSource *xsrc, uint32_t srcno)
 {
-- 
2.26.2



Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCA1C43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 08:22:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41CBA20809
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 08:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41CBA20809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJubt-000503-6v
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 04:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kJuaN-0003Nv-52; Sun, 20 Sep 2020 04:20:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:56516
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kJuaL-0003qP-2k; Sun, 20 Sep 2020 04:20:38 -0400
Received: from host81-154-161-117.range81-154.btcentralplus.com
 ([81.154.161.117] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kJuap-0006Dn-Lv; Sun, 20 Sep 2020 09:21:12 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: armbru@redhat.com, david@gibson.dropbear.id.au, atar4qemu@gmail.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Sun, 20 Sep 2020 09:20:13 +0100
Message-Id: <20200920082018.16135-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.154.161.117
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/6] sparc32-dma: use object_initialize_child() for espdma and
 ledma child objects
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Store the child objects directly within the sparc32-dma object rather than using
link properties.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c           | 15 +++++++++------
 include/hw/sparc/sparc32_dma.h |  4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index d20a5bc065..b25a212f7a 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -379,10 +379,9 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    espdma = qdev_new(TYPE_SPARC32_ESPDMA_DEVICE);
+    espdma = DEVICE(&s->espdma);
     object_property_set_link(OBJECT(espdma), "iommu", iommu, &error_abort);
-    object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(espdma), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(espdma), &error_fatal);
 
     esp = DEVICE(object_resolve_path_component(OBJECT(espdma), "esp"));
     sbd = SYS_BUS_DEVICE(esp);
@@ -394,10 +393,9 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->dmamem, 0x0,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    ledma = qdev_new(TYPE_SPARC32_LEDMA_DEVICE);
+    ledma = DEVICE(&s->ledma);
     object_property_set_link(OBJECT(ledma), "iommu", iommu, &error_abort);
-    object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ledma), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(ledma), &error_fatal);
 
     lance = DEVICE(object_resolve_path_component(OBJECT(ledma), "lance"));
     sbd = SYS_BUS_DEVICE(lance);
@@ -421,6 +419,11 @@ static void sparc32_dma_init(Object *obj)
 
     memory_region_init(&s->dmamem, OBJECT(s), "dma", DMA_SIZE + DMA_ETH_SIZE);
     sysbus_init_mmio(sbd, &s->dmamem);
+
+    object_initialize_child(obj, "espdma", &s->espdma,
+                            TYPE_SPARC32_ESPDMA_DEVICE);
+    object_initialize_child(obj, "ledma", &s->ledma,
+                            TYPE_SPARC32_LEDMA_DEVICE);
 }
 
 static void sparc32_dma_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
index a402665a9c..a7b1dd8418 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -56,8 +56,8 @@ struct SPARC32DMAState {
 
     MemoryRegion dmamem;
     MemoryRegion ledma_alias;
-    ESPDMADeviceState *espdma;
-    LEDMADeviceState *ledma;
+    ESPDMADeviceState espdma;
+    LEDMADeviceState ledma;
 };
 
 /* sparc32_dma.c */
-- 
2.20.1



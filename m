Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF43C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58603206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wpe1eQoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58603206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnB3-0007cX-Dx
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn6x-00086u-4w
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn6v-0005oK-4a
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lI0QOKOjsBIQPb4JR9+p08dzOczCwGubAvEgxznc7/Q=;
 b=Wpe1eQoIHEu7dTKs1rcgYcJt2GJojIuGGZII551eRHkzVtoizo8FN0QusQ5ZjQsu0KhGZO
 PoSTYs3jmUM2+Ux0zHzNFq1CxE5HRr8YSBXMPy0FbzOynVwl4AVBHP2cHBe7+GoLgYhEtZ
 YjzaQb5V3H7c2io05i54N23gAiq+oAE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-EnqphyunOeWvorZhqSidlQ-1; Thu, 03 Sep 2020 07:08:54 -0400
X-MC-Unique: EnqphyunOeWvorZhqSidlQ-1
Received: by mail-wm1-f70.google.com with SMTP id b14so848214wmj.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lI0QOKOjsBIQPb4JR9+p08dzOczCwGubAvEgxznc7/Q=;
 b=Dp5QmAXqL/mc1Y9utVEoaXHCS8aPE+/qaJhyEV7s1xDBliYbJ+BdrzbcHGAifGXPpY
 13kNhevTHn2eaD4SJh89JzDOLAd5q+/kBJldH4SCqbKArYvrTc6kKNFJrlx66lImxOj2
 qwkIwVdlJ4Hvgwnp7IOzWEClwKjjnN65R+9AiFt+MjzbidvPEXRZBWmcdw5fML9LHp0Q
 xqgMFZRB+690bxzi1zTvhQXgCsYJQ6CFQxs/NXZ0WchsN6LMuW0vGBCQI1ddr1D4F6ni
 8QITvPMmSWZZRJRbc8I/WOGftW1OTIXvnDhGfvsQk7Q+ly+bFcLMLyT7sMkahKRDHYNG
 CpaQ==
X-Gm-Message-State: AOAM530ralr1NMDHE2Ncn9csKbvQmfr1bWSfcTsaIoL0PPcO+dXB5a6D
 36TwqEYr6wnL+7k8FX8Cio+DyP5MTNWrLrAtU4O7qB9aIM7U038aogibdkRsDp7vMzq5SUla+mi
 cUFQaFaAfHykVga8=
X-Received: by 2002:adf:ec45:: with SMTP id w5mr1930582wrn.357.1599131333635; 
 Thu, 03 Sep 2020 04:08:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaXFm4w5Ohr2LN1cJuuhu1+mwP3obhIRDWIm7OWCaGpOEFgAjMzMv//oNv4qxMSNAwt007WA==
X-Received: by 2002:adf:ec45:: with SMTP id w5mr1930521wrn.357.1599131333398; 
 Thu, 03 Sep 2020 04:08:53 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id t4sm3818792wre.30.2020.09.03.04.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:08:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/12] dma: Let dma_memory_set() take MemTxAttrs argument
Date: Thu,  3 Sep 2020 13:08:22 +0200
Message-Id: <20200903110831.353476-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903110831.353476-1-philmd@redhat.com>
References: <20200903110831.353476-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 Li Qiang <liq3ea@163.com>, "Emilio G . Cota" <cota@braap.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Joel Stanley <joel@jms.id.au>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Robert Foley <robert.foley@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Tony Nguyen <tony.nguyen@bt.com>,
 Prasad J Pandit <pjp@fedoraproject.org>, Alexander Bulekov <alxndr@bu.edu>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-ppc@nongnu.org,
 Klaus Jensen <k.jensen@samsung.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/ppc/spapr_vio.h | 3 ++-
 include/sysemu/dma.h       | 3 ++-
 dma-helpers.c              | 6 +++---
 hw/nvram/fw_cfg.c          | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index f134f6cf574..6e5c0840248 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -116,7 +116,8 @@ static inline int spapr_vio_dma_write(SpaprVioDevice *dev, uint64_t taddr,
 static inline int spapr_vio_dma_set(SpaprVioDevice *dev, uint64_t taddr,
                                     uint8_t c, uint32_t size)
 {
-    return (dma_memory_set(&dev->as, taddr, c, size) != 0) ?
+    return (dma_memory_set(&dev->as, taddr,
+                           c, size, MEMTXATTRS_UNSPECIFIED) != 0) ?
         H_DEST_PARM : H_SUCCESS;
 }
 
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index fe3999dba59..34f957cc278 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -123,7 +123,8 @@ static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
                          DMA_DIRECTION_FROM_DEVICE);
 }
 
-int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len);
+int dma_memory_set(AddressSpace *as, dma_addr_t addr,
+                   uint8_t c, dma_addr_t len, MemTxAttrs attrs);
 
 static inline void *dma_memory_map(AddressSpace *as,
                                    dma_addr_t addr, dma_addr_t *len,
diff --git a/dma-helpers.c b/dma-helpers.c
index 41ef24a63b6..49d66716469 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -18,7 +18,8 @@
 
 /* #define DEBUG_IOMMU */
 
-int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len)
+int dma_memory_set(AddressSpace *as, dma_addr_t addr,
+                   uint8_t c, dma_addr_t len, MemTxAttrs attrs)
 {
     dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
 
@@ -30,8 +31,7 @@ int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len)
     memset(fillbuf, c, FILLBUF_SIZE);
     while (len > 0) {
         l = len < FILLBUF_SIZE ? len : FILLBUF_SIZE;
-        error |= address_space_write(as, addr, MEMTXATTRS_UNSPECIFIED,
-                                     fillbuf, l);
+        error |= address_space_write(as, addr, attrs, fillbuf, l);
         len -= l;
         addr += l;
     }
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index f3a4728288e..a15de06a10c 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -397,7 +397,8 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
              * tested before.
              */
             if (read) {
-                if (dma_memory_set(s->dma_as, dma.address, 0, len)) {
+                if (dma_memory_set(s->dma_as, dma.address, 0, len,
+                                   MEMTXATTRS_UNSPECIFIED)) {
                     dma.control |= FW_CFG_DMA_CTL_ERROR;
                 }
             }
-- 
2.26.2



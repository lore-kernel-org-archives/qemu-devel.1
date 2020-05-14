Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AE4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DD72065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+Uk4GTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DD72065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEig-0007vn-0k
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEcp-0007VZ-LT
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:15 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a]:41682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jZEco-0003mO-O2
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:14:15 -0400
Received: by mail-lj1-x22a.google.com with SMTP id j3so3671238ljg.8
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nuSqTkHruAB6ZwGLl1uZPF5Wx8t7d9jxfBh8w6c0fhA=;
 b=k+Uk4GTqBmbJK8Px+HokUq3zcYwpbC4CZDjECYmrBYeixAIPJ+4xgeEA5Iwq2Ka5kW
 rKDT0A2OgwgVcXQGSdpsiAYarpHeMQUt5oTQUIGnjU5n+D1naxSZ+TNWzymoSMfEjubu
 MyuZMJ7vK2M48TkNMKyNHLDKubyHZEoLudAp+NGquhRPgpYA2a4L/GxbSZTnZUjLsVmk
 1RiKspZYRySXmtJfp7BkatXT/zJl24g5dTVO+hr6+zi4z62Z5+th87F+ZrMaj0P7fOet
 vfUYQ/THKMFKVRRkMDKtalZAnKDltcfFUhi2DlZlnBCCpyOrkBDxJ3NTKf9aoGj49c8k
 bW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nuSqTkHruAB6ZwGLl1uZPF5Wx8t7d9jxfBh8w6c0fhA=;
 b=IYI4Le24CKdiDM3w2XVHj7KJxrCiUIBP89vW7Di+pyyWGCuIC1NlU7LVK6qPHblwaj
 /qLadAFutBxXR0KA4nEFQGBifqarliw8BIhArId+1JKKRP9kg87pC+aFPk5cz8mCyc66
 RgFpTKISit9dt28Quhi0Tfyt6Q6M1xc2GoN2z1oAmXetyg7aP7qmsLhcjpnZL+8p7YPp
 A1BZQzN5HVBuciXVJSGo+fbkIhf68Rq/s9B/GbK6b/2q81cG8Zm9Nj/8n9cScP45v2A0
 omQ9AlfYFDURINZDKkuIsjnt3cOGRQmvcUJ4/IrlEFyoZkXIjNc80L9KRS3ckCev2CPg
 U0Nw==
X-Gm-Message-State: AOAM532XMUi82cDDm0DbUGvshBQi5CoRH8ChKKC8A1gLsk1DdsSxwTSG
 RlxlJwHl4TviJQnxvY8S75I3PiNP1qE=
X-Google-Smtp-Source: ABdhPJzvWRYgnbhK4J7x2YwMD4brBMTP3BiFqi3eB1VNZlyoiXsVgoxQ9UycvpILoH8sNkVQM/jHSQ==
X-Received: by 2002:a2e:1451:: with SMTP id 17mr178470lju.30.1589465649112;
 Thu, 14 May 2020 07:14:09 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id r2sm1602843ljm.8.2020.05.14.07.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:14:08 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 04/14] hw/dma/xilinx_axidma: Add DMA memory-region property
Date: Thu, 14 May 2020 16:13:52 +0200
Message-Id: <20200514141402.12498-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514141402.12498-1-edgar.iglesias@gmail.com>
References: <20200514141402.12498-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.399, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add DMA memory-region property to externally control what
address-space this DMA operates on.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200506082513.18751-5-edgar.iglesias@gmail.com>
---
 hw/dma/xilinx_axidma.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 018f36991b..4540051448 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -33,6 +33,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 
+#include "sysemu/dma.h"
 #include "hw/stream.h"
 
 #define D(x)
@@ -103,6 +104,7 @@ enum {
 };
 
 struct Stream {
+    struct XilinxAXIDMA *dma;
     ptimer_state *ptimer;
     qemu_irq irq;
 
@@ -125,6 +127,9 @@ struct XilinxAXIDMAStreamSlave {
 struct XilinxAXIDMA {
     SysBusDevice busdev;
     MemoryRegion iomem;
+    MemoryRegion *dma_mr;
+    AddressSpace as;
+
     uint32_t freqhz;
     StreamSlave *tx_data_dev;
     StreamSlave *tx_control_dev;
@@ -186,7 +191,7 @@ static void stream_desc_load(struct Stream *s, hwaddr addr)
 {
     struct SDesc *d = &s->desc;
 
-    cpu_physical_memory_read(addr, d, sizeof *d);
+    address_space_read(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED, d, sizeof *d);
 
     /* Convert from LE into host endianness.  */
     d->buffer_address = le64_to_cpu(d->buffer_address);
@@ -204,7 +209,8 @@ static void stream_desc_store(struct Stream *s, hwaddr addr)
     d->nxtdesc = cpu_to_le64(d->nxtdesc);
     d->control = cpu_to_le32(d->control);
     d->status = cpu_to_le32(d->status);
-    cpu_physical_memory_write(addr, d, sizeof *d);
+    address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
+                        d, sizeof *d);
 }
 
 static void stream_update_irq(struct Stream *s)
@@ -286,8 +292,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
                      txlen + s->pos);
         }
 
-        cpu_physical_memory_read(s->desc.buffer_address,
-                                 s->txbuf + s->pos, txlen);
+        address_space_read(&s->dma->as, s->desc.buffer_address,
+                           MEMTXATTRS_UNSPECIFIED,
+                           s->txbuf + s->pos, txlen);
         s->pos += txlen;
 
         if (stream_desc_eof(&s->desc)) {
@@ -336,7 +343,8 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
             rxlen = len;
         }
 
-        cpu_physical_memory_write(s->desc.buffer_address, buf + pos, rxlen);
+        address_space_write(&s->dma->as, s->desc.buffer_address,
+                            MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
         len -= rxlen;
         pos += rxlen;
 
@@ -525,6 +533,7 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
     XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
                                                             &s->rx_control_dev);
     Error *local_err = NULL;
+    int i;
 
     object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
                              (Object **)&ds->dma,
@@ -545,17 +554,19 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
         goto xilinx_axidma_realize_fail;
     }
 
-    int i;
-
     for (i = 0; i < 2; i++) {
         struct Stream *st = &s->streams[i];
 
+        st->dma = s;
         st->nr = i;
         st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
         ptimer_transaction_begin(st->ptimer);
         ptimer_set_freq(st->ptimer, s->freqhz);
         ptimer_transaction_commit(st->ptimer);
     }
+
+    address_space_init(&s->as,
+                       s->dma_mr ? s->dma_mr : get_system_memory(), "dma");
     return;
 
 xilinx_axidma_realize_fail:
@@ -575,6 +586,11 @@ static void xilinx_axidma_init(Object *obj)
                             &s->rx_control_dev, sizeof(s->rx_control_dev),
                             TYPE_XILINX_AXI_DMA_CONTROL_STREAM, &error_abort,
                             NULL);
+    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
+                             (Object **)&s->dma_mr,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG,
+                             &error_abort);
 
     sysbus_init_irq(sbd, &s->streams[0].irq);
     sysbus_init_irq(sbd, &s->streams[1].irq);
-- 
2.20.1



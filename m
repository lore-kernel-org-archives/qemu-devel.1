Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B03DC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007962054F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQQ/cbok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007962054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2ZR-0004Q2-5g
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2LV-0004bH-93
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2LT-0004PF-7y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iHoKvflLPOyGFs0hwO3aTtF1QkwEnyiuL0EYPF9JCq0=;
 b=gQQ/cbokDKSg3jW/Es2Fb3uUmTRqvotSzL1pwsP071B7DM2w96IHebbqxewaGrYXDMZ1Px
 uVmFxUn+K8KweJg+RSJRjLvtCLhA5JT5DqEH8qgK0804E9a6k3qfG24DIjZvMw3lw3dCEH
 6HjFQz18DqnjsMuNeJGEaosCqDjZMUU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-9UsJWr94ONuNnDy3RLmLrQ-1; Thu, 01 Oct 2020 13:26:17 -0400
X-MC-Unique: 9UsJWr94ONuNnDy3RLmLrQ-1
Received: by mail-wr1-f72.google.com with SMTP id v12so2324331wrm.9
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iHoKvflLPOyGFs0hwO3aTtF1QkwEnyiuL0EYPF9JCq0=;
 b=q33/T/AFfOKOP/RCeUm7cYNed/10Omx4foiV6SdxiL2b94+Ws0rQ5fo1IIwAwWXDV9
 W2rFcIRKMl9NSYsbUSeA2AkCcB8LgdOR5vCeIeYuRE6qR3roBT6VlQ8Ng6ui4XSoeWwR
 RwpifmfEGWBin5YO/ULQVPzoz70YjSRL8ASqhEBi6E9udr9q8WWdUjpSPvMP+aKrLL13
 Mk1DHxwvc2vWJlFJ1BulX+S6lMmvausc4HLKyUyEAp6+nlaJ2CZv7bRGfZEslAp5BNCU
 EmQva+Rz9aKOJ+Mt11IOUlMIRpN24JuxXNuf2HTRZsrDEILyEN4kgxLItb46hYwiF3Gy
 jCBA==
X-Gm-Message-State: AOAM532Vg8A/I+1FNppORCBkk73db7p2j8oO9XFWxiiYkIwJUMnegN1M
 sr94LBqawh1B1K9SrFzi/Qbq1eOpHMHa/K2xmCXhaubhMsBlteDGAStFxbZAEuy4c0h0FzyvE4G
 mndOeZzuEmOe1YWo=
X-Received: by 2002:a5d:4151:: with SMTP id c17mr10946445wrq.302.1601573175622; 
 Thu, 01 Oct 2020 10:26:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPuA1W5Xsqt/m9mc3n8zdA5NGpBzumdi0T7r8mX2ogfgATAiqa8xHgwOtB9XI+dqNAn4QU1Q==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr10946421wrq.302.1601573175415; 
 Thu, 01 Oct 2020 10:26:15 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id h8sm9734998wrw.68.2020.10.01.10.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:26:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 11/16] dma: Let dma_memory_rw() take MemTxAttrs
 argument
Date: Thu,  1 Oct 2020 19:25:14 +0200
Message-Id: <20201001172519.1620782-12-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001172519.1620782-1-philmd@redhat.com>
References: <20201001172519.1620782-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let devices specify transaction attributes when calling
dma_memory_rw().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h |  3 ++-
 include/sysemu/dma.h | 11 ++++++-----
 dma-helpers.c        |  3 ++-
 hw/intc/spapr_xive.c |  3 ++-
 hw/usb/hcd-ohci.c    | 10 ++++++----
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f19ffe6b4f..8f23a24cf9 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -783,7 +783,8 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir)
 {
-    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
+    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,
+                         dir, MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 936b2c902b..e5885dfc91 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -121,15 +121,15 @@ static inline MemTxResult dma_memory_write_relaxed(AddressSpace *as,
  * @buf: buffer with the data transferred
  * @len: the number of bytes to read or write
  * @dir: indicates the transfer direction
+ * @attrs: memory transaction attributes
  */
 static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t addr,
                                         void *buf, dma_addr_t len,
-                                        DMADirection dir)
+                                        DMADirection dir, MemTxAttrs attrs)
 {
     dma_barrier(as, dir);
 
-    return dma_memory_rw_relaxed(as, addr, buf, len, dir,
-                                 MEMTXATTRS_UNSPECIFIED);
+    return dma_memory_rw_relaxed(as, addr, buf, len, dir, attrs);
 }
 
 /**
@@ -147,7 +147,8 @@ static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t addr,
 static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t addr,
                                           void *buf, dma_addr_t len)
 {
-    return dma_memory_rw(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
+    return dma_memory_rw(as, addr, buf, len,
+                         DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
 }
 
 /**
@@ -166,7 +167,7 @@ static inline MemTxResult dma_memory_write(AddressSpace *as, dma_addr_t addr,
                                            const void *buf, dma_addr_t len)
 {
     return dma_memory_rw(as, addr, (void *)buf, len,
-                         DMA_DIRECTION_FROM_DEVICE);
+                         DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED);
 }
 
 /**
diff --git a/dma-helpers.c b/dma-helpers.c
index 6a9735386d..6c3b2200f1 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -305,7 +305,8 @@ static uint64_t dma_buf_rw(uint8_t *ptr, int32_t len, QEMUSGList *sg,
     while (len > 0) {
         ScatterGatherEntry entry = sg->sg[sg_cur_index++];
         int32_t xfer = MIN(len, entry.len);
-        dma_memory_rw(sg->as, entry.base, ptr, xfer, dir);
+        dma_memory_rw(sg->as, entry.base, ptr, xfer, dir,
+                      MEMTXATTRS_UNSPECIFIED);
         ptr += xfer;
         len -= xfer;
         resid -= xfer;
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 1fa09f287a..7a383c9dc4 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1661,7 +1661,8 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
         mmio_addr = xive->vc_base + xive_source_esb_mgmt(xsrc, lisn) + offset;
 
         if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
-                          (flags & SPAPR_XIVE_ESB_STORE))) {
+                          (flags & SPAPR_XIVE_ESB_STORE),
+                          MEMTXATTRS_UNSPECIFIED)) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ESB @0x%"
                           HWADDR_PRIx "\n", mmio_addr);
             return H_HARDWARE;
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 8b912e95d3..67a92153e9 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -586,7 +586,8 @@ static int ohci_copy_td(OHCIState *ohci, struct ohci_td *td,
     if (n > len)
         n = len;
 
-    if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf, n, dir)) {
+    if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf,
+                      n, dir, MEMTXATTRS_UNSPECIFIED)) {
         return -1;
     }
     if (n == len) {
@@ -595,7 +596,7 @@ static int ohci_copy_td(OHCIState *ohci, struct ohci_td *td,
     ptr = td->be & ~0xfffu;
     buf += n;
     if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf,
-                      len - n, dir)) {
+                      len - n, dir, MEMTXATTRS_UNSPECIFIED)) {
         return -1;
     }
     return 0;
@@ -613,7 +614,8 @@ static int ohci_copy_iso_td(OHCIState *ohci,
     if (n > len)
         n = len;
 
-    if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf, n, dir)) {
+    if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf,
+                      n, dir, MEMTXATTRS_UNSPECIFIED)) {
         return -1;
     }
     if (n == len) {
@@ -622,7 +624,7 @@ static int ohci_copy_iso_td(OHCIState *ohci,
     ptr = end_addr & ~0xfffu;
     buf += n;
     if (dma_memory_rw(ohci->as, ptr + ohci->localmem_base, buf,
-                      len - n, dir)) {
+                      len - n, dir, MEMTXATTRS_UNSPECIFIED)) {
         return -1;
     }
     return 0;
-- 
2.26.2



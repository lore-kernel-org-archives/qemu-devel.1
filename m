Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5A6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:12:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6522206EB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHCi00xW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6522206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDn9t-0006B1-Qk
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7A-0000E2-Qh
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn77-0005rd-Hg
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9Kq6ilZXw1SgPGwv65dwwD+++f09k8wejmCLHdwFqM=;
 b=IHCi00xWbUuMvCqwbFp4z9Vdntzjr6XL+jIHcaY1F1EHCQKwwoFaOZaZWYNY++nqzdvFsU
 Xtwy+yVXm7qkfNOUDJPsj2vYKyVb01GWhgxC0S6TW6b3t16QiHGDfnx2QDb1fZTnRNdH+Z
 yvUJZ08Kg0y5mxgG6XnIf0UyXYlhx18=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-rLtZKzKENgS995o0HE1xHg-1; Thu, 03 Sep 2020 07:09:07 -0400
X-MC-Unique: rLtZKzKENgS995o0HE1xHg-1
Received: by mail-wm1-f71.google.com with SMTP id k12so2294472wmj.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m9Kq6ilZXw1SgPGwv65dwwD+++f09k8wejmCLHdwFqM=;
 b=Nr1IpWc1vjmjE77wQBBWcGfDSrALcF/SUTnWal/xdT3h9gX7brAlFWc24xAntmlVxp
 FKM8f58FGKIuY7vmQ5lq8bK6Bomn8pAtXbeHBNglsW1gYn6/x5QQw3k0iz0tQZJPIODc
 xsneSv8nstvYOdjLxWFYg0gcu49zsdFtPHvnuxdR9ULUTia/POZVnuJSzoMMs9D1DEtG
 XQRBuM8Zf4oj527PdlzyqtezW3H3GxAnuwVDKafOiexC9CVN4EJixXkvMBiC1KlqUKtB
 EGla1+G5JG1NPM7xShoKQfhRFvHRGh6YAWOX7L2Gq54v9EfwbuQEVy1/t0cNDsYX8NTt
 3CgA==
X-Gm-Message-State: AOAM532jY8kthdI+kBfPGg6jLhKQEV3Utryx9hCVO94yACdM2k5nWSMX
 ptqvYG7Uvhu4w/HN5bgy/Rx6hOM0EFeR5WWi5Jxr5R/PpKrUU22QQ79+W/GcrkUiq51fiCImcPf
 a+OXlfsbVa6GB12s=
X-Received: by 2002:a1c:9d83:: with SMTP id g125mr1863599wme.41.1599131346008; 
 Thu, 03 Sep 2020 04:09:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRiHbWxFDviE7nR+1lhmyRzMAOuU0bX6QwqWVwsRP0tHrsP4Qu+Qmf+kIz2nRAdDXj/BgKgA==
X-Received: by 2002:a1c:9d83:: with SMTP id g125mr1863549wme.41.1599131345807; 
 Thu, 03 Sep 2020 04:09:05 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id 197sm3869799wme.10.2020.09.03.04.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:09:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/12] dma: Let dma_memory_rw() take MemTxAttrs argument
Date: Thu,  3 Sep 2020 13:08:24 +0200
Message-Id: <20200903110831.353476-6-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 include/hw/pci/pci.h |  3 ++-
 include/sysemu/dma.h | 10 +++++-----
 dma-helpers.c        |  3 ++-
 hw/intc/spapr_xive.c |  3 ++-
 hw/usb/hcd-ohci.c    | 10 ++++++----
 5 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 896cef9ad47..0c3217e019c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -788,7 +788,8 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
 static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                              void *buf, dma_addr_t len, DMADirection dir)
 {
-    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
+    return dma_memory_rw(pci_get_address_space(dev), addr, buf, len,
+                         dir, MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 6068323e48f..f03edeab173 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -106,25 +106,25 @@ static inline int dma_memory_write_relaxed(AddressSpace *as, dma_addr_t addr,
 
 static inline int dma_memory_rw(AddressSpace *as, dma_addr_t addr,
                                 void *buf, dma_addr_t len,
-                                DMADirection dir)
+                                DMADirection dir, MemTxAttrs attrs)
 {
     dma_barrier(as, dir);
 
-    return dma_memory_rw_relaxed(as, addr, buf, len, dir,
-                                 MEMTXATTRS_UNSPECIFIED);
+    return dma_memory_rw_relaxed(as, addr, buf, len, dir, attrs);
 }
 
 static inline int dma_memory_read(AddressSpace *as, dma_addr_t addr,
                                   void *buf, dma_addr_t len)
 {
-    return dma_memory_rw(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
+    return dma_memory_rw(as, addr, buf, len,
+                         DMA_DIRECTION_TO_DEVICE, MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
                                    const void *buf, dma_addr_t len)
 {
     return dma_memory_rw(as, addr, (void *)buf, len,
-                         DMA_DIRECTION_FROM_DEVICE);
+                         DMA_DIRECTION_FROM_DEVICE, MEMTXATTRS_UNSPECIFIED);
 }
 
 int dma_memory_set(AddressSpace *as, dma_addr_t addr,
diff --git a/dma-helpers.c b/dma-helpers.c
index 49d66716469..50473bb1996 100644
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
index 4bd0d606ba1..dbf73a8bf47 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -1666,7 +1666,8 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
         mmio_addr = xive->vc_base + xive_source_esb_mgmt(xsrc, lisn) + offset;
 
         if (dma_memory_rw(&address_space_memory, mmio_addr, &data, 8,
-                          (flags & SPAPR_XIVE_ESB_STORE))) {
+                          (flags & SPAPR_XIVE_ESB_STORE),
+                          MEMTXATTRS_UNSPECIFIED)) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: failed to access ESB @0x%"
                           HWADDR_PRIx "\n", mmio_addr);
             return H_HARDWARE;
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 1e6e85e86a8..bac1adf439c 100644
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



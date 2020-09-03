Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11BFC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:16:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 625AE20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AfdwSg4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 625AE20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnDr-0003RV-B8
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7b-00019E-U7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24830
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDn7Y-0005xl-Sl
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599131376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttIhFvQJ3Qx5h4aB9uiVRWifVpzA075lQL1qUnB3ii8=;
 b=AfdwSg4L9/1aZPUdLS3q2SseN7UwcmiEmAitQUv2lJvgWf7DiEcUnBw3hxNNcUzDbGJhD9
 dT2243AlxGXEbp3+DPZQixIKkPHJtglddq4UdYhpSjbFoS3JECiFZHsE6omyxL1DfA8Epd
 5ptpj3gHUpm+3mp6xU3v9kjALz4NMJI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-v1Ijf-BANZKZHxDDBlhZEA-1; Thu, 03 Sep 2020 07:09:32 -0400
X-MC-Unique: v1Ijf-BANZKZHxDDBlhZEA-1
Received: by mail-wr1-f70.google.com with SMTP id m7so935313wrb.20
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 04:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ttIhFvQJ3Qx5h4aB9uiVRWifVpzA075lQL1qUnB3ii8=;
 b=ZcK44wvIgsn2G0HHpo0V4U/WK1mtV6sQWhu3a1ljQcvf9eLbn4nbf4lPEYOkVIjKLm
 5uQgWLaeNywpDJQ+IJtLsGO7IMEtzO9kqkf6yu0ZpMyhYzwU6xaVqgMMgtIKStgyZlmF
 eNoxX9GIV1aZ1LKViLudnsfC8teL4DKtyXW0uVYCRtZXnyo4TnlAJPF+RcbgpUAt39lg
 6slGyitVpEhg3I8xjixPmjfTFGf6TmnkqY6KLJt7Eembq4wsUGxzpZ4hX4aWE5+tXxq5
 PjXraWpd3MVnRshC9u3IjToT0c0uwBwTuwp3TH9rqtMcEH+QjSvU/pGzOkGDoz9sDAxr
 1/BQ==
X-Gm-Message-State: AOAM533cuop9Orrfu/3y030Z7KIQx4VcnGky+5gQ28SPZyu4Pvz0LTqt
 OomDC2Ha6UbTk1fRA6rjvkUFvO4rnhd+OUMmZ+TsyCKcNnk9K370dDYMrI6HBG2SgApKSxxEDPa
 duBIoMJtH7p216rQ=
X-Received: by 2002:adf:9125:: with SMTP id j34mr2033735wrj.157.1599131371188; 
 Thu, 03 Sep 2020 04:09:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJe3yX5MvaWSQke6o2y/dh9IKY1D2GnYhS9htoIeRd5BMp4R28WHRNudL8Dzq7tg2W9d8KRA==
X-Received: by 2002:adf:9125:: with SMTP id j34mr2033681wrj.157.1599131370911; 
 Thu, 03 Sep 2020 04:09:30 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id n124sm3826996wmn.29.2020.09.03.04.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 04:09:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/12] dma: Let load/store DMA functions take MemTxAttrs
 argument
Date: Thu,  3 Sep 2020 13:08:28 +0200
Message-Id: <20200903110831.353476-10-philmd@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 include/hw/pci/pci.h       |  6 ++++--
 include/hw/ppc/spapr_vio.h | 15 ++++++++++-----
 include/sysemu/dma.h       | 20 ++++++++++++--------
 hw/intc/pnv_xive.c         |  7 ++++---
 hw/nvram/fw_cfg.c          |  4 ++--
 5 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a221dfb3b08..8f901e6c289 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -808,12 +808,14 @@ static inline int pci_dma_write(PCIDevice *dev, dma_addr_t addr,
     static inline uint##_bits##_t ld##_l##_pci_dma(PCIDevice *dev,      \
                                                    dma_addr_t addr)     \
     {                                                                   \
-        return ld##_l##_dma(pci_get_address_space(dev), addr);          \
+        return ld##_l##_dma(pci_get_address_space(dev), addr,           \
+                            MEMTXATTRS_UNSPECIFIED);                    \
     }                                                                   \
     static inline void st##_s##_pci_dma(PCIDevice *dev,                 \
                                         dma_addr_t addr, uint##_bits##_t val) \
     {                                                                   \
-        st##_s##_dma(pci_get_address_space(dev), addr, val);            \
+        st##_s##_dma(pci_get_address_space(dev), addr, val,             \
+                     MEMTXATTRS_UNSPECIFIED);                           \
     }
 
 PCI_DMA_DEFINE_LDST(ub, b, 8);
diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 8168f4fc5a5..e4db1aa7662 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -123,11 +123,16 @@ static inline int spapr_vio_dma_set(SpaprVioDevice *dev, uint64_t taddr,
         H_DEST_PARM : H_SUCCESS;
 }
 
-#define vio_stb(_dev, _addr, _val) (stb_dma(&(_dev)->as, (_addr), (_val)))
-#define vio_sth(_dev, _addr, _val) (stw_be_dma(&(_dev)->as, (_addr), (_val)))
-#define vio_stl(_dev, _addr, _val) (stl_be_dma(&(_dev)->as, (_addr), (_val)))
-#define vio_stq(_dev, _addr, _val) (stq_be_dma(&(_dev)->as, (_addr), (_val)))
-#define vio_ldq(_dev, _addr) (ldq_be_dma(&(_dev)->as, (_addr)))
+#define vio_stb(_dev, _addr, _val) (stb_dma(&(_dev)->as, (_addr), (_val), \
+                                            MEMTXATTRS_UNSPECIFIED))
+#define vio_sth(_dev, _addr, _val) (stw_be_dma(&(_dev)->as, (_addr), (_val), \
+                                               MEMTXATTRS_UNSPECIFIED))
+#define vio_stl(_dev, _addr, _val) (stl_be_dma(&(_dev)->as, (_addr), (_val), \
+                                               MEMTXATTRS_UNSPECIFIED))
+#define vio_stq(_dev, _addr, _val) (stq_be_dma(&(_dev)->as, (_addr), (_val), \
+                                               MEMTXATTRS_UNSPECIFIED))
+#define vio_ldq(_dev, _addr) (ldq_be_dma(&(_dev)->as, (_addr), \
+                                         MEMTXATTRS_UNSPECIFIED))
 
 int spapr_vio_send_crq(SpaprVioDevice *dev, uint8_t *crq);
 
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 9d0e145d76f..8a7dbf0b0f3 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -155,31 +155,35 @@ static inline void dma_memory_unmap(AddressSpace *as,
 
 #define DEFINE_LDST_DMA(_lname, _sname, _bits, _end) \
     static inline uint##_bits##_t ld##_lname##_##_end##_dma(AddressSpace *as, \
-                                                            dma_addr_t addr) \
+                                                            dma_addr_t addr, \
+                                                            MemTxAttrs attrs) \
     {                                                                   \
         uint##_bits##_t val;                                            \
-        dma_memory_read(as, addr, &val, (_bits) / 8, MEMTXATTRS_UNSPECIFIED); \
+        dma_memory_read(as, addr, &val, (_bits) / 8, attrs);            \
         return _end##_bits##_to_cpu(val);                               \
     }                                                                   \
     static inline void st##_sname##_##_end##_dma(AddressSpace *as,      \
                                                  dma_addr_t addr,       \
-                                                 uint##_bits##_t val)   \
+                                                 uint##_bits##_t val,   \
+                                                 MemTxAttrs attrs)      \
     {                                                                   \
         val = cpu_to_##_end##_bits(val);                                \
-        dma_memory_write(as, addr, &val, (_bits) / 8, MEMTXATTRS_UNSPECIFIED); \
+        dma_memory_write(as, addr, &val, (_bits) / 8, attrs);           \
     }
 
-static inline uint8_t ldub_dma(AddressSpace *as, dma_addr_t addr)
+static inline uint8_t ldub_dma(AddressSpace *as, dma_addr_t addr,
+                               MemTxAttrs attrs)
 {
     uint8_t val;
 
-    dma_memory_read(as, addr, &val, 1, MEMTXATTRS_UNSPECIFIED);
+    dma_memory_read(as, addr, &val, 1, attrs);
     return val;
 }
 
-static inline void stb_dma(AddressSpace *as, dma_addr_t addr, uint8_t val)
+static inline void stb_dma(AddressSpace *as, dma_addr_t addr, uint8_t val,
+                           MemTxAttrs attrs)
 {
-    dma_memory_write(as, addr, &val, 1, MEMTXATTRS_UNSPECIFIED);
+    dma_memory_write(as, addr, &val, 1, attrs);
 }
 
 DEFINE_LDST_DMA(uw, w, 16, le);
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 5f69626b3a8..3d7d6e0ca4a 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -171,7 +171,7 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *xive, uint32_t type,
 
     /* Get the page size of the indirect table. */
     vsd_addr = vsd & VSD_ADDRESS_MASK;
-    vsd = ldq_be_dma(&address_space_memory, vsd_addr);
+    vsd = ldq_be_dma(&address_space_memory, vsd_addr, MEMTXATTRS_UNSPECIFIED);
 
     if (!(vsd & VSD_ADDRESS_MASK)) {
 #ifdef XIVE_DEBUG
@@ -194,7 +194,8 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *xive, uint32_t type,
     /* Load the VSD we are looking for, if not already done */
     if (vsd_idx) {
         vsd_addr = vsd_addr + vsd_idx * XIVE_VSD_SIZE;
-        vsd = ldq_be_dma(&address_space_memory, vsd_addr);
+        vsd = ldq_be_dma(&address_space_memory, vsd_addr,
+                         MEMTXATTRS_UNSPECIFIED);
 
         if (!(vsd & VSD_ADDRESS_MASK)) {
 #ifdef XIVE_DEBUG
@@ -541,7 +542,7 @@ static uint64_t pnv_xive_vst_per_subpage(PnvXive *xive, uint32_t type)
 
     /* Get the page size of the indirect table. */
     vsd_addr = vsd & VSD_ADDRESS_MASK;
-    vsd = ldq_be_dma(&address_space_memory, vsd_addr);
+    vsd = ldq_be_dma(&address_space_memory, vsd_addr, MEMTXATTRS_UNSPECIFIED);
 
     if (!(vsd & VSD_ADDRESS_MASK)) {
 #ifdef XIVE_DEBUG
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 877df8752a0..b8a936bd04a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -358,7 +358,7 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
     if (dma_memory_read(s->dma_as, dma_addr,
                         &dma, sizeof(dma), MEMTXATTRS_UNSPECIFIED)) {
         stl_be_dma(s->dma_as, dma_addr + offsetof(FWCfgDmaAccess, control),
-                   FW_CFG_DMA_CTL_ERROR);
+                   FW_CFG_DMA_CTL_ERROR, MEMTXATTRS_UNSPECIFIED);
         return;
     }
 
@@ -444,7 +444,7 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
     }
 
     stl_be_dma(s->dma_as, dma_addr + offsetof(FWCfgDmaAccess, control),
-                dma.control);
+                dma.control, MEMTXATTRS_UNSPECIFIED);
 
     trace_fw_cfg_read(s, 0);
 }
-- 
2.26.2



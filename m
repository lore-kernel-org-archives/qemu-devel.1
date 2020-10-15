Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F373C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB29212CC
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jfjatkng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB29212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT89T-0005SX-6M
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+eb6999eca8409778b169+6262+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1kT85o-0002IC-6D
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:35:13 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1]:58744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+eb6999eca8409778b169+6262+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1kT85h-0005wX-UA
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=zpjY1YQ8eFS82vCRfvxkfW/mqXhI9zcR43eiwB7OXKc=; b=jfjatkng8pJy8BJFwbl+nKkGLf
 FfKaxtEvAYhzjm11eHjgS6I1j6NfYGYI+aM2+UbFbE+oZTZe3Not6kS+6A63WBAQM1I8E9EPNu0We
 30BzYSbCpm+YN8my7GbVRkRicEkaRbpH+nTELEAUqssRKqGoofO3RahKbuZxK7M/QsSNY67ofQZoQ
 AecXY6lieESapMDfhmqJc7sYRrEpVWcwGZ+hmbfo3EyepN9+g2VxHjY1960F1Hz1FbE6hvvihHhW6
 bvcse67rgHedHq+HW5XTTiLAAd5+RmpV/mpVu40r0BnO+Jhtf4etH6MnHgVTEQv6FeIJYbtYS1A+s
 CaNxPBVw==;
Received: from i7.infradead.org ([2001:8b0:10b:1:21e:67ff:fecb:7a92])
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kT85Z-0003E1-Pu
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 18:34:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.93 #3 (Red Hat
 Linux)) id 1kT85Z-007DDd-C3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 19:34:57 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] intel_iommu: Support IR-only mode without DMA translation
Date: Thu, 15 Oct 2020 19:34:56 +0100
Message-Id: <20201015183457.1719068-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+eb6999eca8409778b169+6262+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

By setting none of the SAGAW bits we can indicate to a guest that DMA
translation isn't supported. Tested by booting Windows 10, as well as
Linux guests with the fix at https://git.kernel.org/torvalds/c/c40aaaac10

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/intel_iommu.c         | 14 ++++++++++----
 include/hw/i386/intel_iommu.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 749eb6ad63..f49b4af931 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2189,7 +2189,7 @@ static void vtd_handle_gcmd_write(IntelIOMMUState *s)
     uint32_t changed = status ^ val;
 
     trace_vtd_reg_write_gcmd(status, val);
-    if (changed & VTD_GCMD_TE) {
+    if ((changed & VTD_GCMD_TE) && s->dma_translation) {
         /* Translation enable/disable */
         vtd_handle_gcmd_te(s, val & VTD_GCMD_TE);
     }
@@ -3086,6 +3086,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
+    DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -3607,12 +3608,17 @@ static void vtd_init(IntelIOMMUState *s)
     s->next_frcd_reg = 0;
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
-             VTD_CAP_SAGAW_39bit | VTD_CAP_MGAW(s->aw_bits);
+             VTD_CAP_MGAW(s->aw_bits);
     if (s->dma_drain) {
         s->cap |= VTD_CAP_DRAIN;
     }
-    if (s->aw_bits == VTD_HOST_AW_48BIT) {
-        s->cap |= VTD_CAP_SAGAW_48bit;
+    if (s->dma_translation) {
+            if (s->aw_bits >= VTD_HOST_AW_39BIT) {
+                    s->cap |= VTD_CAP_SAGAW_39bit;
+            }
+            if (s->aw_bits >= VTD_HOST_AW_48BIT) {
+                    s->cap |= VTD_CAP_SAGAW_48bit;
+            }
     }
     s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
 
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 41783ee46d..42d6a6a636 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -266,6 +266,7 @@ struct IntelIOMMUState {
     bool buggy_eim;                 /* Force buggy EIM unless eim=off */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
+    bool dma_translation;           /* Whether DMA translation supported */
 
     /*
      * Protects IOMMU states in general.  Currently it protects the
-- 
2.26.2



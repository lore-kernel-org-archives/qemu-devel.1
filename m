Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1CFC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5831720759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g0ksy9mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5831720759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2g1-0003Ay-PQ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Lt-0005Gy-16
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Lr-0004Sv-83
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=udJNOTd9q8GWTxGSfD4yywYFkssNr+3yEzfBj0bq7Uw=;
 b=g0ksy9mo2y7q/1ALScjEE8EdQe1fQUW2ZcTrk80QEsz1MF26v9pvbZa3Lkhr38fqR4RR+w
 BjY92Y6qv4XvB9SEeKH3763qfBBITWxEMWVBgB3hWTVaAwDljXp27/Z/CuB0eAYTahfS3M
 45kQYQhr3CZUghcUV+AlMu9EeisceXo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-XSDwcmg6PnSweRRn9hzuFQ-1; Thu, 01 Oct 2020 13:26:41 -0400
X-MC-Unique: XSDwcmg6PnSweRRn9hzuFQ-1
Received: by mail-wr1-f71.google.com with SMTP id l15so2330281wro.10
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=udJNOTd9q8GWTxGSfD4yywYFkssNr+3yEzfBj0bq7Uw=;
 b=DttYZXMz8kv57dF9YhH76557W9sIbmGqTggkaDVQBIBIASR7QbE+086I/8ORc1QGDl
 KQr3/WsYOoFyTjiplb33mnSCScHtRIeDuSJcNjiFgwrIzAKVXAB2UHI4uYNLvA5tn69m
 4/qyXoe2OBp8agaYv+agClYWK8RIj0EHzNYZbX6A0Abj0xVt0syKMQPeBPLuIyqyeX2c
 uaTkSKf6ijOd5X9fL2q+RlwA1cFwN82lgTRaHMuiMGbdsqvG+9eeBA8IBekJ8+0qtDLT
 X/KMYmvi+n0kYRGpS5LsYYA7VHq73VPNX/tyoYjYxjydZh2UlpS5x+g1UqCfWX6ip+tf
 w5+A==
X-Gm-Message-State: AOAM530/PAz2FdXACj4r7egTRPW9ExII0ZHeWKzNznLO1zq7HBWrQe0r
 0iFPS7ijNqQs3YA+JRm8IlzJIooTq56tVsI6vaZqagFvOXuhCf6GOAIOWMJvrUH9xkHdeWB++xh
 je4TvfTeD4mKbLn0=
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr10951566wrn.394.1601573199489; 
 Thu, 01 Oct 2020 10:26:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHAOFaVzMVe3u6Zt67rdUHxGDTQuwilaRI88YshzAZU0I90dK71V6KCoZrlm3vyB3o66M6xQ==
X-Received: by 2002:adf:e8ce:: with SMTP id k14mr10951545wrn.394.1601573199267; 
 Thu, 01 Oct 2020 10:26:39 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id a3sm743859wmb.46.2020.10.01.10.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:26:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 16/16] pci: Let pci_dma_write() propagate MemTxResult
Date: Thu,  1 Oct 2020 19:25:19 +0200
Message-Id: <20201001172519.1620782-17-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
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

pci_dma_rw() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 299df068c9..8114313e1e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -819,8 +819,20 @@ static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
     return pci_dma_rw(dev, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
 
-static inline int pci_dma_write(PCIDevice *dev, dma_addr_t addr,
-                                const void *buf, dma_addr_t len)
+/**
+ * pci_dma_write: Write to address space from PCI device.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @dev: #PCIDevice doing the memory access
+ * @addr: address within the #PCIDevice address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to write
+ */
+static inline MemTxResult pci_dma_write(PCIDevice *dev, dma_addr_t addr,
+                                        const void *buf, dma_addr_t len)
 {
     return pci_dma_rw(dev, addr, (void *) buf, len, DMA_DIRECTION_FROM_DEVICE);
 }
-- 
2.26.2



Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E893FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588C020E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqVHQKaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588C020E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVz4a-0002YT-0H
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyra-0001mQ-6T
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrS-0000Bi-F6
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJinNb06Gf0QcNRno4TNgRALIvb6H/vJjFM/EgfOCIw=;
 b=eqVHQKaZCXrT2G2UUJy1hNEcO2zzLfAogS4zioeKQ2wNNzjWh3gRY1CCRRjJlzDRAmnN8A
 zZ+2oDvAQOJvLi6ZuG8MXgO/piTHMzoBYVrtLdAtmayjlES+Q21KhJW/qxDtZfF7+mYE1D
 V4I5iFJM/bYrbUvA1OQwM3GqDobPeJI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-E5I4AXo5NLuC136TzQbVqA-1; Fri, 23 Oct 2020 11:20:05 -0400
X-MC-Unique: E5I4AXo5NLuC136TzQbVqA-1
Received: by mail-wr1-f69.google.com with SMTP id v5so714662wrr.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RJinNb06Gf0QcNRno4TNgRALIvb6H/vJjFM/EgfOCIw=;
 b=bfkQGQcoSXRapiom7Q9FEXlAwX8cza4QX3GR2348bktCaAIrXkBy9zv+F02gyyjUAQ
 aFix5wNlAEY9QXCK5NYSpshpRSB1yDdA69iE00lrFWV3pvSHsBkmzicPH3W7IH3INzfr
 5nxUuEyPkWa9pe1jGsgvkyfgEvyTUN2hxf5aUVECthAFtMI47lr/Xf0ZO94HwosQ0gC8
 xeDdj6QHIV5kN0jRynKqEOFGeSFRCZxUMmIRxNODILD4XFfPF2QJeM4E3k+KlMcSoKlM
 Fc+2Rq8brAWtiHhsL8bkT2gGnEG+nNKMLijNAyzpxkFR3TbFxQPbx5dHrqzX104d6ypA
 MaXQ==
X-Gm-Message-State: AOAM531VG71CVlprQ4ds8mnrkzj6eu7BnmhkLOXcdIAJbdRSmFjwiRHz
 Go5r1KevZVYnFdchwy+gzUwhVOtHEeNSt95r5noBOsAOOj0x/nnGkf3bUoqPFN03CDVdLNS8ww6
 kqSAQNF48/IKKeuM=
X-Received: by 2002:a1c:f002:: with SMTP id a2mr3025585wmb.129.1603466403590; 
 Fri, 23 Oct 2020 08:20:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxedeCEGIRMyJ+he0rOhNoWB6qoAf5QCSiSC5rcP5S4uAE2bhbhMRIAXFcF1EleEetzVNdGJQ==
X-Received: by 2002:a1c:f002:: with SMTP id a2mr3025568wmb.129.1603466403425; 
 Fri, 23 Oct 2020 08:20:03 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c15sm3622655wmb.27.2020.10.23.08.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:20:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 08/10] pci: Let pci_dma_rw() propagate MemTxResult
Date: Fri, 23 Oct 2020 17:19:21 +0200
Message-Id: <20201023151923.3243652-9-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023151923.3243652-1-philmd@redhat.com>
References: <20201023151923.3243652-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Li Qiang <liq3ea@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dma_memory_rw() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f19ffe6b4fe..b8780ea18c1 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -780,8 +780,22 @@ static inline AddressSpace *pci_get_address_space(PCIDevice *dev)
     return &dev->bus_master_as;
 }
 
-static inline int pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
-                             void *buf, dma_addr_t len, DMADirection dir)
+/**
+ * pci_dma_rw: Read from or write to an address space from PCI device.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @dev: #PCIDevice doing the memory access
+ * @addr: address within the #PCIDevice address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to read or write
+ * @dir: indicates the transfer direction
+ */
+static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
+                                     void *buf, dma_addr_t len,
+                                     DMADirection dir)
 {
     return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
 }
-- 
2.26.2



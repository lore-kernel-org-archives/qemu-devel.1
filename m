Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E109BC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5193D20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3Ucax8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5193D20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVyvF-0006XQ-2E
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyre-0001sP-Ne
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrb-0000C5-Vw
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P62uFdatfvoHDjKgezNY7D79I1KvnGcFbawzNsrJjnU=;
 b=c3Ucax8f2Qp+D3tQIMg2KfaX8f5Mn+ebUIBIw+hNh4PiiV1lgK+Nh4QvUR0YhBTcgwBfTA
 Coa8LFT78pf+e/MkaBy815y/vRfvA3rhz42yi6xvB9YvV/p8wfQwhbzoH2589NTWKEk5gL
 FBz5ojRktFH3FB5U1Af8qfLLIqAJclo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-irYCGFreNLO2ZBWQf7z_OQ-1; Fri, 23 Oct 2020 11:20:09 -0400
X-MC-Unique: irYCGFreNLO2ZBWQf7z_OQ-1
Received: by mail-wr1-f70.google.com with SMTP id b6so691981wrn.17
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P62uFdatfvoHDjKgezNY7D79I1KvnGcFbawzNsrJjnU=;
 b=W9QfZGe/AZ2n//Z1J3YtcG1rpa9jE8WoVYNn3TdA0OF0M4AROV4lSoAvTXUlwMi9Aa
 7G+oLJ19OhFY7jI5UTXFe2mxvvbsAJscH4CBNJXVxleYSE3PGkN/ZXKGosH8K15eTVKe
 Q3TygpZifdH/MlnjCYVVQ193/paH3/KxF6GX/mziPUB61gRu4ReWjXSsh4nu6KjT1Q74
 C/0utYQoBrYGjBJW95EhtyBbyE9YzT3VCEgrUZ+B6J3M3caNpOZwOOn1KEY9S5OzPpKW
 GJt9Za11ofS6iytM7x60e9vOBEqrWnnsMVlSW6Vbnr+H9s2okuT/Rn9aIlG+WqdylDHf
 Mksw==
X-Gm-Message-State: AOAM533XqNRV5YwGMo6Vs0BThgft11H7KYVZ2YzpVn1mZF6Odc8Xk9pV
 TYhxc3EsRH7gfAVVPZBmHYTjJ2KSbAVVhXEH6Xpo4kQB1umZw/oqKth1smk9gr7UuRTAnwJL/GN
 mFFkvPyH3QZUQCJM=
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr3032806wrn.186.1603466408291; 
 Fri, 23 Oct 2020 08:20:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyV+mMAAnr7Gl+DWcBdZ87I3RqG5VLZ1vzVJwsBluZe8J9BnMYzcEsD5Cob2f0tCXT+dbn0KQ==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr3032786wrn.186.1603466408104; 
 Fri, 23 Oct 2020 08:20:08 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id u5sm5127409wru.63.2020.10.23.08.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:20:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 09/10] pci: Let pci_dma_read() propagate MemTxResult
Date: Fri, 23 Oct 2020 17:19:22 +0200
Message-Id: <20201023151923.3243652-10-philmd@redhat.com>
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

pci_dma_rw() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index b8780ea18c1..85b5786a5da 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -800,8 +800,20 @@ static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
     return dma_memory_rw(pci_get_address_space(dev), addr, buf, len, dir);
 }
 
-static inline int pci_dma_read(PCIDevice *dev, dma_addr_t addr,
-                               void *buf, dma_addr_t len)
+/**
+ * pci_dma_read: Read from an address space from PCI device.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).  Called within RCU critical section.
+ *
+ * @dev: #PCIDevice doing the memory access
+ * @addr: address within the #PCIDevice address space
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
+                                       void *buf, dma_addr_t len)
 {
     return pci_dma_rw(dev, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
-- 
2.26.2



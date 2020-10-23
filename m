Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5B0C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887AD20E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ga1Zally"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887AD20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVz64-0004uq-SP
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrh-0001x3-Tu
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrd-0000Eq-Se
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/0HdXqasuvyDAja4v6/tCFJrk2r3CIc7i9rSuYrUflE=;
 b=Ga1ZallyO7YE1+ot2JGQ/pFqfIwS3bZeIIXUTQKm9+1XAnfp8zpshe1ETxGPcokgM/1OJK
 ZHnSTVsDNnE7tWtTyiOBdJa4NygF/PBZdFEWAOf9X2QIS76n5oFM/ll6uGVvYd034RAbXN
 prlIwzCDPxP/AkNnvxatVU4WCys6CMA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-fMyDinajMhSRVAsDqlWB-Q-1; Fri, 23 Oct 2020 11:20:14 -0400
X-MC-Unique: fMyDinajMhSRVAsDqlWB-Q-1
Received: by mail-wm1-f71.google.com with SMTP id g71so576087wmg.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/0HdXqasuvyDAja4v6/tCFJrk2r3CIc7i9rSuYrUflE=;
 b=asStZkl1QOSsYQSFWip0Q4gL3sho6A/x1Mjnl0ab/u5o9T5LFMTcWKNBuP0P4g/MMG
 ep4cKfhSwZNSkq9OoAqa+/5iNSvbdYnocEH3tKeU6+cgSZch2F1J8ZsU4lI8CWjd3dzA
 OOD3hwg2ijQhLveaj3pswVxgvCxIlmMp+Ihs9j2nDWGOfK7758eJIN+2qjkIZCVvPmEu
 L1DIaUE/BrXFBcf6cu31ny7C12czYFTJwvosSgGs6w0GxKXA/9vPR+MqsOd9DUn8gAcI
 1VaTJ5Bt/wY4YcZUdkVjfF/O+qJIJzK7klKU6iMliUHJq+xLDwhtm0AP4o0TxP3igB/k
 XRwQ==
X-Gm-Message-State: AOAM530YxFp+bJFFYVzK8KlCKe/AkMDsSyIPYnp7Iny9FL9QkhIByqW6
 ymnVai5FvsCAx/EC7iesredNiEfM2W/VlMyYdlmFD2Ngo234KK2kB3LJela4ivUU+OqC0XJoOLz
 YOTRzM6wEzyAAhIQ=
X-Received: by 2002:a5d:554b:: with SMTP id g11mr3203213wrw.370.1603466412958; 
 Fri, 23 Oct 2020 08:20:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIPJBT2WlqaT490gvAUxP6tkPk9PeFFqMFmnUTIRAqD96kS/GgvRZRGw68Z32jpbUhfCX+mg==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr3203195wrw.370.1603466412788; 
 Fri, 23 Oct 2020 08:20:12 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 40sm3981492wrc.46.2020.10.23.08.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:20:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 10/10] pci: Let pci_dma_write() propagate MemTxResult
Date: Fri, 23 Oct 2020 17:19:23 +0200
Message-Id: <20201023151923.3243652-11-philmd@redhat.com>
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
index 85b5786a5da..dd486cd941a 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -818,8 +818,20 @@ static inline MemTxResult pci_dma_read(PCIDevice *dev, dma_addr_t addr,
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



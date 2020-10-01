Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E841C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:44:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6E112065C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQkKIZW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6E112065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2ch-000851-KQ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Lo-00055C-3y
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Lm-0004SZ-D2
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6SBWdzgqMBgYw89U+cEUD8cCJrdzloVUjao1tlyNDc=;
 b=EQkKIZW9t+rt7Z7iY5h5Ekw9tBDcrcYxV4GqlS36Qy3QaqB75RxW0EFiMGgyIAzBp+pNXD
 XiQBVJrknq58qiPtzbg26uUTuGJH6dfvQ9R1rsXt04Vs42+V7cG+fojgzM7D/W9zkzsI9A
 LwWrqRfPYPESAe1ZkgKrT95DGtsvUAU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-vS-Q6pDsMM6vC3dixP2fzw-1; Thu, 01 Oct 2020 13:26:36 -0400
X-MC-Unique: vS-Q6pDsMM6vC3dixP2fzw-1
Received: by mail-wm1-f72.google.com with SMTP id l15so1407616wmh.9
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F6SBWdzgqMBgYw89U+cEUD8cCJrdzloVUjao1tlyNDc=;
 b=jNcaa33SYpsTkw256T9aXm3FG9z+3vcsTUhrVj5DilY+mMGmsssui1IFZENZG7yn/0
 O3HbPSfflGrh1dqeNohGxp9A2go5GqvV/QNbwzVjlOF9OFTeNJ7V2bkCXTzWl9obYEgN
 +Jf8fEbA5XWU/xuF9X8GG8lMZ4xPXDOcEO3kLMz6KaZEATG9JF94KsGA82UMis5lb2n/
 3aMAKBDORUp0bGTSV3D8cA1/RlaPwBYURXJ/UAdaWsuGueIdkV5PggqaP1sLrA7rLnVP
 a4gZTyG/rV7JovQ6eH+CdVwLd6WT0SmCWy1l4v3YkU2QWjMqWXxMKNMPVFO0zn+XYT42
 2zQw==
X-Gm-Message-State: AOAM533faPBLAf5FmZZBhQGLEIIf3/INTqJqCD17cusMjiTbTxa8uE6M
 6Hfm5rw2uicdltPqOeTDeq6cv+UWCJnl55v6t6EyVbI9OouRGgAipwg5JMnBZ2iOg8GTW9+v6VE
 S0CbTrW5Mw4S+V7c=
X-Received: by 2002:a5d:444b:: with SMTP id x11mr10198218wrr.402.1601573194746; 
 Thu, 01 Oct 2020 10:26:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8qPOM1Udi/2cBugLloC9divrpOXmVTglaNEW/vT5l+SfLuO6e76tELiU7VXg3D4iewNv2Lw==
X-Received: by 2002:a5d:444b:: with SMTP id x11mr10198199wrr.402.1601573194566; 
 Thu, 01 Oct 2020 10:26:34 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 91sm10566746wrq.9.2020.10.01.10.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:26:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 15/16] pci: Let pci_dma_read() propagate MemTxResult
Date: Thu,  1 Oct 2020 19:25:18 +0200
Message-Id: <20201001172519.1620782-16-philmd@redhat.com>
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

pci_dma_rw() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/pci/pci.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index f77f4e49e4..299df068c9 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -801,8 +801,20 @@ static inline MemTxResult pci_dma_rw(PCIDevice *dev, dma_addr_t addr,
                          dir, MEMTXATTRS_UNSPECIFIED);
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



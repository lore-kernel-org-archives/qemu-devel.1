Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E91C47423
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1B320872
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EWPDPvcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1B320872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2Pc-0001km-GX
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2L2-0004QP-FE
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Kw-0004Fo-6C
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syzgIAtLlC36RSXNl4EdRCuwS9HfcthXywFIirAhFNM=;
 b=EWPDPvczxu9GEXyhLjQFc6R/IpAJQ7wQh5XgHHf7msTdbsnqNOwBlc/ymig1HXP1nz7A2B
 KGBQXW+6Z5RMKnxf7FiZUWq0gdKLH3Z2kUWgsIO8f+C5vhGy4IYI2HxGMThXNLVeuDhb3X
 WhFNIQmVVlSUYBRPWqEeUiok2ggYEo0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-5bP5IUwyPv-mWSQHxf4ijg-1; Thu, 01 Oct 2020 13:25:43 -0400
X-MC-Unique: 5bP5IUwyPv-mWSQHxf4ijg-1
Received: by mail-wm1-f71.google.com with SMTP id d197so876771wmd.4
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=syzgIAtLlC36RSXNl4EdRCuwS9HfcthXywFIirAhFNM=;
 b=EK3qzM3rlR06Y5BzLvPZJfuPVY48LJ+0DJ9j2TOo1AdBVJQU8fgJpNW/S8GrC1KXdj
 ptEbxoAf8YeuT1IoGCWhf/AEDmMi5cxHyX3LbwzHppYuFFvrOLyGxWGf/Hi+e5kRN9Sa
 tNaTAQAjxtx+MsKcKeftT59TiplV1CQejf+6s2I6B/cy++wGhzvDEGPsL/caeCEp8nzE
 jyjdq6y+h5tU3Zhc6Is5bMw/LibB128Du8qrEeVCZFS/zyytHX4XxO3ZaZnPMOFz2u3s
 XNFug/nfOxZ6HRDdJYL1PBVDagVBFEFrhKzqJPDglnPU3w+mxI4U3/I5jmaw3XMG77B7
 s4rQ==
X-Gm-Message-State: AOAM532/c2N+qXME3N76eC23ygZDkZHDotrfPNsmVz2qBBh7bditP6fk
 FDn5PJ6xkY0GVDA+UaWuLLjiLe28WEjO3/H+LQ3c9hGmQ3+yrDT84uEP7HiykZATLjGUJhMXCnz
 TH1mE/S15GL/VvyE=
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr9970699wro.315.1601573141270; 
 Thu, 01 Oct 2020 10:25:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyORzUqm86VflKRIN/MDCkXBpeF2kgb9g6JuA9aFdZahBI9GJjEq3Qii1zONXyEFBJEarPzLQ==
X-Received: by 2002:adf:f0c7:: with SMTP id x7mr9970683wro.315.1601573141086; 
 Thu, 01 Oct 2020 10:25:41 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id b64sm945627wmh.13.2020.10.01.10.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:25:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 04/16] dma: Let dma_memory_set() propagate
 MemTxResult
Date: Thu,  1 Oct 2020 19:25:07 +0200
Message-Id: <20201001172519.1620782-5-philmd@redhat.com>
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

address_space_write() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 15 ++++++++++++++-
 dma-helpers.c        |  7 ++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index c6e12b4c24..37cd9f1121 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -123,7 +123,20 @@ static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
                          DMA_DIRECTION_FROM_DEVICE);
 }
 
-int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len);
+/**
+ * dma_memory_set: Fill memory with a constant byte from DMA controller.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @c: constant byte to fill the memory
+ * @len: the number of bytes to fill with the constant byte
+ */
+MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
+                           uint8_t c, dma_addr_t len);
 
 /**
  * address_space_map: Map a physical memory region into a host virtual address.
diff --git a/dma-helpers.c b/dma-helpers.c
index 41ef24a63b..4a9e37d6d0 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -1,7 +1,7 @@
 /*
  * DMA helper functions
  *
- * Copyright (c) 2009 Red Hat
+ * Copyright (c) 2009,2020 Red Hat
  *
  * This work is licensed under the terms of the GNU General Public License
  * (GNU GPL), version 2 or later.
@@ -18,14 +18,15 @@
 
 /* #define DEBUG_IOMMU */
 
-int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len)
+MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
+                           uint8_t c, dma_addr_t len)
 {
     dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
 
 #define FILLBUF_SIZE 512
     uint8_t fillbuf[FILLBUF_SIZE];
     int l;
-    bool error = false;
+    MemTxResult error = MEMTX_OK;
 
     memset(fillbuf, c, FILLBUF_SIZE);
     while (len > 0) {
-- 
2.26.2



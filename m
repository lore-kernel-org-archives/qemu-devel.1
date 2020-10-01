Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E96C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6C872054F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNKHYX3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C872054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2WY-0000rw-Mo
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Kz-0004PJ-Ua
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2Ks-0004Fb-Rr
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWyri9vRLYeVqvreYWHFron9sHPrhWm4LYtp0EVZkVA=;
 b=fNKHYX3KOc5oayNXOrUSxD/571FgVmkFXlVO2goooloDoGu18vhvjcQVIPl3YdvpFTMbCb
 Vk8b6AisSaomF/dPepECqNkLR1Yef60Iv0Vuqq8CprYg3hcs+O7jmQLk5FbEJntORi92L5
 YrVwEnJaGTJw0KfX5VKqbzTHxCIeWq4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-a1tF0qtONrmhPuzCsNS9OQ-1; Thu, 01 Oct 2020 13:25:40 -0400
X-MC-Unique: a1tF0qtONrmhPuzCsNS9OQ-1
Received: by mail-wr1-f69.google.com with SMTP id y3so2319987wrl.21
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pWyri9vRLYeVqvreYWHFron9sHPrhWm4LYtp0EVZkVA=;
 b=lQBW81T4Y1I8OrQH1KcoifghpYxjRWoxZpf+R7VEpmpUdEB4G3G55MKHHJ5XkhpA0V
 ZbkXW4inwateVwO659IBQ6j2BbTA7kys89Ayqy9Zwe8B19qZ2Cy1UeKosZzd7IKSCAkS
 d3Ql56Icq27RXkVHBio5caFvWiJB/KhrmHbFpZf5+Wz1Rrjq8TWR4K3rqES3Qu7NeEFf
 vz6y1AB2bnZjo5tawLelShj7physqiUQe/ticDpRaEk/gX4wBYWvhJvoGpT4ygXSIMhY
 uGME7HpyOn0ac0LGog6BEGmvOGgwqunxD2UTyhARGkatpZ15/XbbkBNsDkQfVmJUVtlf
 FQAQ==
X-Gm-Message-State: AOAM531G6mZCvKgNuxF13lMI/0+goQEgP6346ev5N6EN6p69W37gpquM
 QhLZlRCmJhVerXIe2oOaJPciLlQ1am4BkznuMv7565owa245Y/SI2fiEcmhE2a47fJwW3Pvd7k5
 VgqQ2bLVhsKrB+D8=
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr1098819wmc.100.1601573136396; 
 Thu, 01 Oct 2020 10:25:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgsQMLP8oKgBuvYpoK/ukXPuEKW1rtgM9KCvEL+VHK3idIPhPT4YLEHb2KfaY2WirmsjiRqw==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr1098811wmc.100.1601573136206; 
 Thu, 01 Oct 2020 10:25:36 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id a3sm740469wmb.46.2020.10.01.10.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:25:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 03/16] dma: Document
 address_space_map/address_space_unmap() prototypes
Date: Thu,  1 Oct 2020 19:25:06 +0200
Message-Id: <20201001172519.1620782-4-philmd@redhat.com>
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

Add documentation based on address_space_map / address_space_unmap.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 80c5bc3e02..c6e12b4c24 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -1,7 +1,7 @@
 /*
  * DMA helper functions
  *
- * Copyright (c) 2009 Red Hat
+ * Copyright (c) 2009, 2020 Red Hat
  *
  * This work is licensed under the terms of the GNU General Public License
  * (GNU GPL), version 2 or later.
@@ -125,6 +125,19 @@ static inline int dma_memory_write(AddressSpace *as, dma_addr_t addr,
 
 int dma_memory_set(AddressSpace *as, dma_addr_t addr, uint8_t c, dma_addr_t len);
 
+/**
+ * address_space_map: Map a physical memory region into a host virtual address.
+ *
+ * May map a subset of the requested range, given by and returned in @plen.
+ * May return %NULL and set *@plen to zero(0), if resources needed to perform
+ * the mapping are exhausted.
+ * Use only for reads OR writes - not for read-modify-write operations.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @len: pointer to length of buffer; updated on return
+ * @dir: indicates the transfer direction
+ */
 static inline void *dma_memory_map(AddressSpace *as,
                                    dma_addr_t addr, dma_addr_t *len,
                                    DMADirection dir)
@@ -138,6 +151,20 @@ static inline void *dma_memory_map(AddressSpace *as,
     return p;
 }
 
+/**
+ * address_space_unmap: Unmaps a memory region previously mapped
+ *                      by dma_memory_map()
+ *
+ * Will also mark the memory as dirty if @dir == %DMA_DIRECTION_FROM_DEVICE.
+ * @access_len gives the amount of memory that was actually read or written
+ * by the caller.
+ *
+ * @as: #AddressSpace used
+ * @buffer: host pointer as returned by address_space_map()
+ * @len: buffer length as returned by address_space_map()
+ * @dir: indicates the transfer direction
+ * @access_len: amount of data actually transferred
+ */
 static inline void dma_memory_unmap(AddressSpace *as,
                                     void *buffer, dma_addr_t len,
                                     DMADirection dir, dma_addr_t access_len)
-- 
2.26.2



Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A8C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C892420760
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPG0ZtrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C892420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVz3H-0001Bj-9b
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrI-0001V5-9G
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46910)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrG-0000An-FV
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vt/p2q5jWxaYevN4DyU5OYfdDbucjx1Cc7x7OfkPzDY=;
 b=MPG0ZtrKJ51RbiFXelD5W8/V6vO0HFGuGW1l23sJGtTHbGxhw1zT/U/JpmaYQZCf83N79b
 JkktLE9g3+TJ/TxPFuFBbHceLuxGw1Z0AHa7v4k/W+KvFJJfLGazhWCmeXfO11tCshnDuN
 NwgyTeyyyMAKeyBohK/bxNfHc8xN2c0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-nK0KXjOGNXK8xpETuviA5Q-1; Fri, 23 Oct 2020 11:19:55 -0400
X-MC-Unique: nK0KXjOGNXK8xpETuviA5Q-1
Received: by mail-wr1-f69.google.com with SMTP id r8so702843wrp.5
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vt/p2q5jWxaYevN4DyU5OYfdDbucjx1Cc7x7OfkPzDY=;
 b=YLoiYsm6FPSYFCWiKFg0KpDlkEiSkyDcXN0gyVIfuvoqcty1X0ITTXtG421Hs9eGso
 qcSn+RK9R1f3kp4wPrhleWttBes02wcL7h7eS3GOEXxpyuBaxAAO6qPfj1K7QmK+NULK
 8FrbhVZlS5r45vBe09+9LgA6Dcf6qrLYHlY1sF0ddq5noYYfyG77GnaOpJcZqFvjxlOE
 GM14SnWJaUZ8/N4kLZSiKU9633noWyVSSaRs9x9+lU+CUMYwUgAIMh1HBjZWAVsBpRPV
 Wo3C2pMQyrwDfVQw/ZKB3haQDjoyWS+NBvMgN9zYVF+Z7qaSjU0DmXVFueXxRz43WbeR
 Qs5g==
X-Gm-Message-State: AOAM532BV4QzwEYm/NBpTZ9C89fufSazUb8LYdgB0hJiH+lPshiHQ127
 1LShzsIRugOKR61fSUvbU2d9Y2bcgmVdGgVnx8ZiNMpmx2w63gE+hKpN9fNb7JGZx9GMV2vMnrC
 8M/Nw9txqqGZDnWI=
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr2991208wmg.38.1603466394223; 
 Fri, 23 Oct 2020 08:19:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwReI7zUQg/Ydu7TguRxjr75zgVDakszRRGDiJJXZmHAdgaafan+AFKtZDYGmqCf+ZgoEa0pQ==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr2991201wmg.38.1603466394077; 
 Fri, 23 Oct 2020 08:19:54 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id b15sm3965606wrm.65.2020.10.23.08.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:19:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 06/10] dma: Let dma_memory_read() propagate
 MemTxResult
Date: Fri, 23 Oct 2020 17:19:19 +0200
Message-Id: <20201023151923.3243652-7-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

dma_memory_rw_relaxed() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 04687d8825e..df170047eb3 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -89,8 +89,9 @@ static inline MemTxResult dma_memory_rw_relaxed(AddressSpace *as,
                             buf, len, dir == DMA_DIRECTION_FROM_DEVICE);
 }
 
-static inline int dma_memory_read_relaxed(AddressSpace *as, dma_addr_t addr,
-                                          void *buf, dma_addr_t len)
+static inline MemTxResult dma_memory_read_relaxed(AddressSpace *as,
+                                                  dma_addr_t addr,
+                                                  void *buf, dma_addr_t len)
 {
     return dma_memory_rw_relaxed(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
@@ -124,8 +125,20 @@ static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t addr,
     return dma_memory_rw_relaxed(as, addr, buf, len, dir);
 }
 
-static inline int dma_memory_read(AddressSpace *as, dma_addr_t addr,
-                                  void *buf, dma_addr_t len)
+/**
+ * dma_memory_read: Read from an address space from DMA controller.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).  Called within RCU critical section.
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @buf: buffer with the data transferred
+ * @len: length of the data transferred
+ */
+static inline MemTxResult dma_memory_read(AddressSpace *as, dma_addr_t addr,
+                                          void *buf, dma_addr_t len)
 {
     return dma_memory_rw(as, addr, buf, len, DMA_DIRECTION_TO_DEVICE);
 }
-- 
2.26.2



Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC32AC4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:34:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEEB2085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wod3zl8n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEEB2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2Ti-0005eH-1G
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2L5-0004Rs-Jo
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2L2-0004GO-6c
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7v9DMG4y2YQic36rWlYyposJbVK+Y5f+qipPBVV3YB0=;
 b=Wod3zl8nkToKe8+GHvJbLK5Rg/Wk7TuLsOs/RnmwZCRLOh2ge4d7OIOCrquKI9a8Y3Lv5z
 w2NhkVOQ9fsmXIfUMDUFU+TN1YIBz+PNMRHxOfjdBw7fJpF85QuxZZO8oG/szE7AzuIYHc
 yOxcNOvI2qI9Jb33GTfrJ+i6JE+Jdqo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-7kpzytT-MBO3Kf2o9NShUw-1; Thu, 01 Oct 2020 13:25:47 -0400
X-MC-Unique: 7kpzytT-MBO3Kf2o9NShUw-1
Received: by mail-wr1-f71.google.com with SMTP id r16so2309305wrm.18
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7v9DMG4y2YQic36rWlYyposJbVK+Y5f+qipPBVV3YB0=;
 b=LClGsBNtW7eVVdQA6xBoNM/G8Hz8W+xWJufjrLvMElF7+lalnFat6EjPjwBvYGy5W3
 A1JXvTAACynSSrwodBbGARUTrQRhqknecy8aXQtZJAz2Ja9qrLNjgsrJPECkZ1ksQAUe
 ChuG7JA2Wt875Rbc/P7yN696N4M7mp3Zdej3KK7GFpcO6nkEh6UJVc6S7TnKJX4g/Xt2
 qCx63TdlXrbfWxNuxS/kPlN6iyEwQtNMlW2Kp/S8bsRAuLnF+5akKTuaxyohinKrPFoJ
 hTKZI+zs+vBr85nB1o0ZGpD9pM7na3rt4XqhZOayAXdqvt+9A9aTlWeSRgxMF8FUXPWY
 qljQ==
X-Gm-Message-State: AOAM533G2GPzYkDfeQA1uiSdndVMINCcKqWUECqaKCSqbIiPHQuydSds
 yn+EjoixYQXbLnkN8duUpJqGIi+ecBsZnePREHNyCuzCTW47KckRY3YnKP+nlhVvHaFAGV8qqpq
 vme82n6aKX6qMWqU=
X-Received: by 2002:a1c:408a:: with SMTP id n132mr1013263wma.45.1601573146318; 
 Thu, 01 Oct 2020 10:25:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4MC9kQdd9yQsBPBSvY6hQkXKAQjPlgUSNTJfxBi1lN3ymzU7o++7Mxayaa49BcnFN50Q/tA==
X-Received: by 2002:a1c:408a:: with SMTP id n132mr1013255wma.45.1601573146153; 
 Thu, 01 Oct 2020 10:25:46 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id t202sm964651wmt.14.2020.10.01.10.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:25:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 05/16] dma: Let dma_memory_rw() propagate MemTxResult
Date: Thu,  1 Oct 2020 19:25:08 +0200
Message-Id: <20201001172519.1620782-6-philmd@redhat.com>
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

address_space_rw() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 37cd9f1121..04687d8825 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -80,12 +80,13 @@ static inline bool dma_memory_valid(AddressSpace *as,
                                       MEMTXATTRS_UNSPECIFIED);
 }
 
-static inline int dma_memory_rw_relaxed(AddressSpace *as, dma_addr_t addr,
-                                        void *buf, dma_addr_t len,
-                                        DMADirection dir)
+static inline MemTxResult dma_memory_rw_relaxed(AddressSpace *as,
+                                                dma_addr_t addr,
+                                                void *buf, dma_addr_t len,
+                                                DMADirection dir)
 {
-    return (bool)address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
-                                  buf, len, dir == DMA_DIRECTION_FROM_DEVICE);
+    return address_space_rw(as, addr, MEMTXATTRS_UNSPECIFIED,
+                            buf, len, dir == DMA_DIRECTION_FROM_DEVICE);
 }
 
 static inline int dma_memory_read_relaxed(AddressSpace *as, dma_addr_t addr,
@@ -101,9 +102,22 @@ static inline int dma_memory_write_relaxed(AddressSpace *as, dma_addr_t addr,
                                  DMA_DIRECTION_FROM_DEVICE);
 }
 
-static inline int dma_memory_rw(AddressSpace *as, dma_addr_t addr,
-                                void *buf, dma_addr_t len,
-                                DMADirection dir)
+/**
+ * dma_memory_rw: Read from or write to an address space from DMA controller.
+ *
+ * Return a MemTxResult indicating whether the operation succeeded
+ * or failed (eg unassigned memory, device rejected the transaction,
+ * IOMMU fault).
+ *
+ * @as: #AddressSpace to be accessed
+ * @addr: address within that address space
+ * @buf: buffer with the data transferred
+ * @len: the number of bytes to read or write
+ * @dir: indicates the transfer direction
+ */
+static inline MemTxResult dma_memory_rw(AddressSpace *as, dma_addr_t addr,
+                                        void *buf, dma_addr_t len,
+                                        DMADirection dir)
 {
     dma_barrier(as, dir);
 
-- 
2.26.2



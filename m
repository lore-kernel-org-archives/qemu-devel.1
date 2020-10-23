Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F082EC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDB521D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="detaxUMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDB521D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVz14-0006kM-BS
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyr9-0001Fz-LB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyr7-0000AH-Db
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rTl09xtbUfBbJCkrL3LY3kF9JffyPlmRm+1EQw48YxQ=;
 b=detaxUMK5t0d+EC2NSvwf5bnwRQ1pIprxcSozf53mjmSNrV/+kG9RvKFOVsvQebk/gP9My
 N7TNM6WpEtOk+IP9Tr5EfRbeGI2vc/gOFSvI7uZHwQH3n7Fo+Z8+WjaVrArDwm38im0GA2
 MC1KXrKravpLSNQVxmbeQJZwqG8njVs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-rT0577baP3KmugfMyvsZLA-1; Fri, 23 Oct 2020 11:19:46 -0400
X-MC-Unique: rT0577baP3KmugfMyvsZLA-1
Received: by mail-wr1-f71.google.com with SMTP id i1so692223wrb.18
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rTl09xtbUfBbJCkrL3LY3kF9JffyPlmRm+1EQw48YxQ=;
 b=iWwWbZ7Yg0LjOxbTMXc9sJRJyjSpoM2kCCQQ/AsULqcB3SpaeuDh55NC2xICPVpVZE
 Km82o5GYO0km+0E7em9KHk25XfB2wxkrzb3mwFMSK+PFyWxMKnbIsSYSldgvr5alCbh8
 GPWs1GcoxPJTwhUyeuMJg9AluupN6esBZ4GLVrdLM8FFRIZXh+5X03W//I79KMf74xE7
 K575LulKfRrPV8oud5Ua6WA3EtsoBfJl9gAX/oeUFMo/qVJeGM8kqckT+3ppp6hXR8Bd
 y0a4IbFBz9xXWlocOnftFXeLsX6aQ14RkCOAVjdrJ8Zjy0D4NhLRuyjDHrgbCMx7iTy9
 3l8Q==
X-Gm-Message-State: AOAM533jlV3RWH4zFSBuSgSAm3Hv6p9x6cL1NKj1GZX+NLreEuZWq/Yu
 Zm5gUZkGCpblobPSwqKaagBP4KyPJo3rptT03WXuGntqNyaIt7k/40AIPd6+gCmflNA3H9BT0nU
 3g5SR2SYSUhsARsA=
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr3046061wrt.137.1603466384894; 
 Fri, 23 Oct 2020 08:19:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzHQD34KWlBmSsB30Dvfl+0e1RVMdw1clEaFis9cLCUDtaH2HrgMA67xmlMXiNI9jnbxBMCw==
X-Received: by 2002:a5d:4c4f:: with SMTP id n15mr3046038wrt.137.1603466384671; 
 Fri, 23 Oct 2020 08:19:44 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 14sm4122296wmf.27.2020.10.23.08.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:19:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 04/10] dma: Let dma_memory_set() propagate
 MemTxResult
Date: Fri, 23 Oct 2020 17:19:17 +0200
Message-Id: <20201023151923.3243652-5-philmd@redhat.com>
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

address_space_write() returns a MemTxResult type.
Do not discard it, return it to the caller.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/sysemu/dma.h  | 15 ++++++++++++++-
 softmmu/dma-helpers.c |  7 ++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index c6e12b4c243..37cd9f11217 100644
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
diff --git a/softmmu/dma-helpers.c b/softmmu/dma-helpers.c
index 03c92e0cc60..29001b54595 100644
--- a/softmmu/dma-helpers.c
+++ b/softmmu/dma-helpers.c
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



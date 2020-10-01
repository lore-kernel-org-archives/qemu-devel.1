Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C3C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:44:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6602054F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ADqR7Lsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6602054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2dP-0001AA-V9
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2LN-0004Xq-6i
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2LI-0004NM-NB
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Td0iuQpd/0gjq4nbB5FibsTRyGIsuc4AdlendQEjyys=;
 b=ADqR7LsbKgpqxjBiJwjsLXuU3UOm3hhtlodrMrQJLUOZrzeyVr0DoAVsg0wkP8WSy1kpYl
 GLHpKczKtiru1HMWQLNz47EjHIgl7kw6ojYZBSOSmy6FETP9jslvL6kg/MqWfWPjibQR3x
 0REwJCZhUCva8bhucjscrLRdNCB0vqo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-2N9mK0D2MW21AXzAfuN8WQ-1; Thu, 01 Oct 2020 13:26:02 -0400
X-MC-Unique: 2N9mK0D2MW21AXzAfuN8WQ-1
Received: by mail-wr1-f71.google.com with SMTP id l15so2329532wro.10
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Td0iuQpd/0gjq4nbB5FibsTRyGIsuc4AdlendQEjyys=;
 b=jp4YJtKJ5xamAZMhi/JZPWe1XLGJ0RR+Fs5bt1QuB6lODCDiSl6puraVhbt5b9npQo
 313DgcKVNrb5Q+CD2sLL9Rj3r1EuYEWJ5hUMjMNJNKSnzpOv0YNZYnX6QbU3/QMPRcir
 WBkbax1RCslUMu4pfXMX4I7F/QFwMaRdtoBXkDuwtPBAtmLdiTDn+z6suXkr2XA7u+f7
 INZ+lC2G5/Q/13teeOurwCL0KgMWSu8HBxOCJVh15N+rg0h60/+b2WS6WYN5dezvxjEm
 jtmB1cGQzVYgVyKc5pZo4o7eaRR0CbEo9Ab7nnu8eG/9hOpM/s8m8J3udNYNFasT1Nw+
 ewtw==
X-Gm-Message-State: AOAM532p7YYAnfP3a1uISxiHsv44B1K1pJod6Cr90OzQn+jZ0/Q7ObyG
 XdKC+VIegGMU/uynwEC18QSAsEC506qijIsAieowfrBshZ46k8N9HbMUdBEnw1wh3wK0y0OZXQZ
 O9SbL3vARpOqHU+M=
X-Received: by 2002:a5d:468f:: with SMTP id u15mr10078891wrq.336.1601573161125; 
 Thu, 01 Oct 2020 10:26:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtrJe/UEvJEzIc8E+jwu+aTsJnp16PrGtTb5Rmwt9+xxJDYQBadebLBBdxSGR1JCjVpjzDjQ==
X-Received: by 2002:a5d:468f:: with SMTP id u15mr10078878wrq.336.1601573160917; 
 Thu, 01 Oct 2020 10:26:00 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id 63sm10732704wrh.71.2020.10.01.10.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:26:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 08/16] dma: Let dma_memory_valid() take MemTxAttrs
 argument
Date: Thu,  1 Oct 2020 19:25:11 +0200
Message-Id: <20201001172519.1620782-9-philmd@redhat.com>
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

Let devices specify transaction attributes when calling
dma_memory_valid().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/ppc/spapr_vio.h | 2 +-
 include/sysemu/dma.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index 356751e2d7..ed28db6604 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -91,7 +91,7 @@ static inline void spapr_vio_irq_pulse(SpaprVioDevice *dev)
 static inline bool spapr_vio_dma_valid(SpaprVioDevice *dev, uint64_t taddr,
                                        uint32_t size, DMADirection dir)
 {
-    return dma_memory_valid(&dev->as, taddr, size, dir);
+    return dma_memory_valid(&dev->as, taddr, size, dir, MEMTXATTRS_UNSPECIFIED);
 }
 
 static inline int spapr_vio_dma_read(SpaprVioDevice *dev, uint64_t taddr,
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index a052f7bca3..a5cd7a98ff 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -73,11 +73,11 @@ static inline void dma_barrier(AddressSpace *as, DMADirection dir)
  * dma_memory_{read,write}() and check for errors */
 static inline bool dma_memory_valid(AddressSpace *as,
                                     dma_addr_t addr, dma_addr_t len,
-                                    DMADirection dir)
+                                    DMADirection dir, MemTxAttrs attrs)
 {
     return address_space_access_valid(as, addr, len,
                                       dir == DMA_DIRECTION_FROM_DEVICE,
-                                      MEMTXATTRS_UNSPECIFIED);
+                                      attrs);
 }
 
 static inline MemTxResult dma_memory_rw_relaxed(AddressSpace *as,
-- 
2.26.2



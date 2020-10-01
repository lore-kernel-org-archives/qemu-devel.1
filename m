Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018A9C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D8520759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Oo4E3afO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D8520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2hU-0004aH-DB
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2LQ-0004Ya-MG
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26526)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kO2LK-0004Nq-Vo
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601573170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHD/JvXVYrPLsc/yxY4/t3jAkkzEX3PgR+IV4TUEuDY=;
 b=Oo4E3afOW8ioja5kb0p81C9LM45uIxn01ACVrEqER3wj5Cc/oaxMTqp4tlAMykSJZWZ92L
 c0XpKFDtP6ewO08WsT1R4ecKgpMrg03d8J0vKPRkoX4/IPTEIuI6QhtpDf0IVpfocFvNB+
 ImCyKZUIxVfuqkBy15R9p+J4rPR9hYQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-7AMJPAjdM8GeXXjdzwxUJw-1; Thu, 01 Oct 2020 13:26:07 -0400
X-MC-Unique: 7AMJPAjdM8GeXXjdzwxUJw-1
Received: by mail-wm1-f70.google.com with SMTP id y83so229175wmc.8
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aHD/JvXVYrPLsc/yxY4/t3jAkkzEX3PgR+IV4TUEuDY=;
 b=VJSYxNgj0jvtBkp5zY/qxinilrsWr9APvtC75+FlgrddLUL8B8731sMWF3qvfj2JQ7
 ZGB8aYg9RYwcVIfSY4iUYFtDjNbuYbQd9/Y9rYFRMHRi4rAGX6JumgbVaFOPGPOpr97Z
 LMQW7+gHZNPulVIwT87zNGNw0SSqX/D9bv/gMUO1FY0W2OhAp1dPab2cwDeqNGTlXfsL
 pjidyv2vZnK3hsXARLyfce+WM9FSbv1OLCaW7oxhOrqG2Ai9CjWrQH9Bo04tmkS9oU8J
 Kacvs0c7z357jBXOiSdYR05Uu8s5qZr5v38mNSillWprAbhSHyW6E3VARWZnnvUwK2GW
 dfgQ==
X-Gm-Message-State: AOAM5329Ar+XX/1ktuRfGbx41fGkQkh1xcv+4Q6jfdIh61zGaIwXkx/d
 VOIlgQFbDcJrUe4DQ9XZ/LxBYhuRy5Kd+gw03EzHMnHVf/nTylbTsC94wv+jadiPTHb3ezfAVV9
 DlZmJRaxTpl3ZfHw=
X-Received: by 2002:a1c:a444:: with SMTP id n65mr1086747wme.122.1601573166026; 
 Thu, 01 Oct 2020 10:26:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG03ZWCX+2RGVdAvVKNtgNRTORtKILai3qPVLS8aDuZfv5UP6Jpb73AoiO5jK0zbO+Up/kyQ==
X-Received: by 2002:a1c:a444:: with SMTP id n65mr1086726wme.122.1601573165799; 
 Thu, 01 Oct 2020 10:26:05 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id u66sm845421wmg.44.2020.10.01.10.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 10:26:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v2 09/16] dma: Let dma_memory_set() take MemTxAttrs
 argument
Date: Thu,  1 Oct 2020 19:25:12 +0200
Message-Id: <20201001172519.1620782-10-philmd@redhat.com>
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
dma_memory_set().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/ppc/spapr_vio.h | 3 ++-
 include/sysemu/dma.h       | 3 ++-
 dma-helpers.c              | 5 ++---
 hw/nvram/fw_cfg.c          | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/spapr_vio.h b/include/hw/ppc/spapr_vio.h
index ed28db6604..a8d6c55953 100644
--- a/include/hw/ppc/spapr_vio.h
+++ b/include/hw/ppc/spapr_vio.h
@@ -111,7 +111,8 @@ static inline int spapr_vio_dma_write(SpaprVioDevice *dev, uint64_t taddr,
 static inline int spapr_vio_dma_set(SpaprVioDevice *dev, uint64_t taddr,
                                     uint8_t c, uint32_t size)
 {
-    return (dma_memory_set(&dev->as, taddr, c, size) != 0) ?
+    return (dma_memory_set(&dev->as, taddr,
+                           c, size, MEMTXATTRS_UNSPECIFIED) != 0) ?
         H_DEST_PARM : H_SUCCESS;
 }
 
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index a5cd7a98ff..608393d1b6 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -175,9 +175,10 @@ static inline MemTxResult dma_memory_write(AddressSpace *as, dma_addr_t addr,
  * @addr: address within that address space
  * @c: constant byte to fill the memory
  * @len: the number of bytes to fill with the constant byte
+ * @attrs: memory transaction attributes
  */
 MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
-                           uint8_t c, dma_addr_t len);
+                           uint8_t c, dma_addr_t len, MemTxAttrs attrs);
 
 /**
  * address_space_map: Map a physical memory region into a host virtual address.
diff --git a/dma-helpers.c b/dma-helpers.c
index 4a9e37d6d0..6a9735386d 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -19,7 +19,7 @@
 /* #define DEBUG_IOMMU */
 
 MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
-                           uint8_t c, dma_addr_t len)
+                           uint8_t c, dma_addr_t len, MemTxAttrs attrs)
 {
     dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
 
@@ -31,8 +31,7 @@ MemTxResult dma_memory_set(AddressSpace *as, dma_addr_t addr,
     memset(fillbuf, c, FILLBUF_SIZE);
     while (len > 0) {
         l = len < FILLBUF_SIZE ? len : FILLBUF_SIZE;
-        error |= address_space_write(as, addr, MEMTXATTRS_UNSPECIFIED,
-                                     fillbuf, l);
+        error |= address_space_write(as, addr, attrs, fillbuf, l);
         len -= l;
         addr += l;
     }
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 0e95d057fd..b10e05f527 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -397,7 +397,8 @@ static void fw_cfg_dma_transfer(FWCfgState *s)
              * tested before.
              */
             if (read) {
-                if (dma_memory_set(s->dma_as, dma.address, 0, len)) {
+                if (dma_memory_set(s->dma_as, dma.address, 0, len,
+                                   MEMTXATTRS_UNSPECIFIED)) {
                     dma.control |= FW_CFG_DMA_CTL_ERROR;
                 }
             }
-- 
2.26.2



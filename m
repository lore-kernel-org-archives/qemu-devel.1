Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B505C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:33:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A1020E65
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLHzPQyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A1020E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVz41-00024A-Gi
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrF-0001OM-MG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kVyrC-0000AZ-Hz
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603466393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoRwInsbwjWJV4eBwvCdQEKEOGDOla1790sLaSe2DnU=;
 b=ZLHzPQyiAEBp4yJBigzEzfpZwJGOQEvaS2hl+A/yLVMYOtW7tfbyxR6qElkr3e4z3/rG7j
 cktdBDTIL+B46NkQEFqXbUaIpG1/8E+HwQdBuDP0Wk5sfkSPgi1KHDptCvvMQwqA1l/LGC
 7ayWAmxY4s5JEFjgbTZsUnUEL5xAnNE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-q0BSKhC_PVGaUxMMFt7gHg-1; Fri, 23 Oct 2020 11:19:51 -0400
X-MC-Unique: q0BSKhC_PVGaUxMMFt7gHg-1
Received: by mail-wm1-f69.google.com with SMTP id s12so638833wmj.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 08:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CoRwInsbwjWJV4eBwvCdQEKEOGDOla1790sLaSe2DnU=;
 b=kAl41rUG0ytK/gIAtFCHOioxgJFWFwN17+QlYmGQZa8xB8hG5EkuWQTjtYBqt2aJOb
 vDBcfAxsabP5BXPi45RME+qagSagfolXiRrtQQDLSnykfmSGreHHIdW8ZpJiINpGek6/
 eHWAOuKRSzM8U4RZBctXyRnu1wv4mWd/hViLAS44CeEZrWgVbF7PbPhiJAdMJkU43TZg
 ZXwr59+HvxEsS4T/eapDbq3SuV4jFmUo5vLQlmdSpFE5rBlpUYKcRJn3PMEaWEsEV0iT
 WOmgJgHXj0qIo8JlJ5WUmyYNf49QElC9J6FmQsMv8SLbEeVGXyjCH3l3EcSGQNSMDlxC
 XQKg==
X-Gm-Message-State: AOAM5317p18qgsjk3YguCkGthM5jpdwcAe7gDce3SO17xLUhrQlHUQLQ
 eBGVo+hjd9SEIcuBS+iCcvdFAp9w9Ggyuup9K3bdyJU1/AFamjNuvYj7/tIPFw24hRO46jgyddR
 Peu9pTF8cWXFITSw=
X-Received: by 2002:a1c:e244:: with SMTP id z65mr2990316wmg.40.1603466389530; 
 Fri, 23 Oct 2020 08:19:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhq5VbIMew7MLkdBI+F+y0Hi2/9dY8yxsk4JUBFRYhUOgFeOxVX/r4AcEAgekFfOeNU3DDwA==
X-Received: by 2002:a1c:e244:: with SMTP id z65mr2990288wmg.40.1603466389278; 
 Fri, 23 Oct 2020 08:19:49 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z15sm4028910wrq.24.2020.10.23.08.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 08:19:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 05/10] dma: Let dma_memory_rw() propagate MemTxResult
Date: Fri, 23 Oct 2020 17:19:18 +0200
Message-Id: <20201023151923.3243652-6-philmd@redhat.com>
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
index 37cd9f11217..04687d8825e 100644
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



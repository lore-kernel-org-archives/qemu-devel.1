Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C90CC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662EB205C9
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YvtNnQW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662EB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7ky-0005ZI-Ie
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jJ-0002VQ-E0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jH-000099-So
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:49 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:35180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jH-00008e-E7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id r26so1551180wmh.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/MnAU0cO9JgocJyxoLrzCpuFBf9q8CvPSi85jGiI5DM=;
 b=YvtNnQW4BR7HCNPgQzK/rFLYnyii5Xtrcm9qNz9eXaJbyqpcXLFqQpzJXczhpISXXO
 dmfXVsL0b6CJIyokpY8nvPDAQx+iI63HQVWBg3YYAMBjq6QiffzU7kOIegD36X2ApmXH
 dnLEhZppsD8ncVxwsfmqKwlsE1Ayzss3ZSs/8nnadO+CxMQC88ZsZ8DK86vu+IzPxhnr
 tNGyTFkTBT5b6GQfaM7kNaD2Q+8kFt73sR8NcsQZ3KJeZX5RXrxrdQoVQRTKJiIfRbcs
 i4oL8I0Vz2/zpstWU5azrf+GdZSID/WctO1fSI0tHyKPZqspfZKs8HOBX6C+wPku9Zqf
 tAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/MnAU0cO9JgocJyxoLrzCpuFBf9q8CvPSi85jGiI5DM=;
 b=OuBdxykYCZ0909rpB79vXrhR39YVFxIlx3ul0aWTT82pL/eJMDPQcglXa/+isL1NgS
 yYUA89ZIvEkZLL8xcT1i1PBidA00ishs9n9ARbvT0SweiVKOjaA8zddbrb2g36yOwqXH
 qIbDVaT3fuMeMT0+XfsrcIupttR4iIpPiEsZsfwCYPDXCWQ1i3w8sSHEkA3RjxJlyTek
 P1c5M7D1Toht4C37Snbsbv0QrG92PBkZAa9rzaIJuwOitWSvBsD0KykuTI0Fos2RBRvh
 Nb94oUFscUNJQIZK3ukRpd5nxg7U3H3pw/VVjotKhpGQJE9h1/YWUhaRTO2F/FaIjOLz
 Qagg==
X-Gm-Message-State: AGi0Puba4M3GOP8mPGwW7ZeIoZ4m8ABhexokX0GwOBlaDcTMVrixYY2e
 NusWF0Zj1SEY3dIWdUpG+siQJy2x7yblDA==
X-Google-Smtp-Source: APiQypKCFFAuR5plM3+7dCTALpj5ecz9UVzHjCF4NeRYnc+NknJxPXb44NYl0ayuG4QKYE79bhlQ7Q==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr2514194wme.38.1588247505769; 
 Thu, 30 Apr 2020 04:51:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/31] dma/xlnx-zdma: Fix descriptor loading (MEM) wrt
 endianness
Date: Thu, 30 Apr 2020 12:51:12 +0100
Message-Id: <20200430115142.13430-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32a
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Fix descriptor loading from memory wrt host endianness.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200404122718.25111-2-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zdma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
index 1c45367f3c6..5f4775f6634 100644
--- a/hw/dma/xlnx-zdma.c
+++ b/hw/dma/xlnx-zdma.c
@@ -299,19 +299,22 @@ static void zdma_put_regaddr64(XlnxZDMA *s, unsigned int basereg, uint64_t addr)
     s->regs[basereg + 1] = addr >> 32;
 }
 
-static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr, void *buf)
+static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr,
+                                 XlnxZDMADescr *descr)
 {
     /* ZDMA descriptors must be aligned to their own size.  */
     if (addr % sizeof(XlnxZDMADescr)) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "zdma: unaligned descriptor at %" PRIx64,
                       addr);
-        memset(buf, 0x0, sizeof(XlnxZDMADescr));
+        memset(descr, 0x0, sizeof(XlnxZDMADescr));
         s->error = true;
         return false;
     }
 
-    address_space_read(s->dma_as, addr, s->attr, buf, sizeof(XlnxZDMADescr));
+    descr->addr = address_space_ldq_le(s->dma_as, addr, s->attr, NULL);
+    descr->size = address_space_ldl_le(s->dma_as, addr + 8, s->attr, NULL);
+    descr->attr = address_space_ldl_le(s->dma_as, addr + 12, s->attr, NULL);
     return true;
 }
 
@@ -344,7 +347,7 @@ static void zdma_update_descr_addr(XlnxZDMA *s, bool type,
     } else {
         addr = zdma_get_regaddr64(s, basereg);
         addr += sizeof(s->dsc_dst);
-        address_space_read(s->dma_as, addr, s->attr, (void *) &next, 8);
+        next = address_space_ldq_le(s->dma_as, addr, s->attr, NULL);
     }
 
     zdma_put_regaddr64(s, basereg, next);
-- 
2.20.1



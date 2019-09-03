Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7A7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F912339D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wMxYU2TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F912339D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Bmr-0004Lb-5Y
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN2-0001NG-O7
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMx-0003nH-NK
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33807)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMx-0003mh-At
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:23 -0400
Received: by mail-pf1-x442.google.com with SMTP id b24so11104664pfp.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UDEsommlp5Tab22dPIHKjp2gMshSz3MUBWQaZCgvboo=;
 b=wMxYU2TVR+/N+cFAu+ZWfu2EiT+FNcmCP/29gZwhHxnnvJvOCLfsD14sZS1D7oSwR8
 tOpF2N/OL25vantNPfPbD/O7CwLsdAGmRpwJQwQXvF7YnzviP6OQtxNfolKhDDl3BuWZ
 +IxP3YR8lcjewgb4u4NsNnyrrRheonZJGM0NhkvLJ/BHZ7k9F/BjKT9RZu+uA+0V7/W5
 NnK+eYfsHtJI0rb2V1DFXW0FGcViDTqeQD3FPWUUdf055C+ywoCfVpmTfyci5W1g0AVl
 Invud/P0O/XLOSMSGUJ570JNDXlyEpCvOl60hF31WE98gRG11NYeZp5fvwzKCeQwXfha
 G/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UDEsommlp5Tab22dPIHKjp2gMshSz3MUBWQaZCgvboo=;
 b=YE1bQ8+aGF9ywt+L9ruPhFeuF036jzDtly9p4Z9J79T2jm8qkq9l3pVCC/XltTPpDf
 ZzyCuvS5/1aNLS+zEJLmlJ8gea0DiJJz2ChyxoCh962HJgMb9wvCjBsCU54tO+ZE6/w7
 QIpR1h1mUC9dtVCrGx7KaGU71LOv4RgaBgl666pMJSqazJozkylfz9uJaJ3SDid7/cQq
 EtbzMxzQAdHtTI5upjpeKctsPTgIzJQ+Wb1DfF5iSG3NPBtX0sbL4nv+6MAXVb2OOAq1
 +wMisJu3p9AUQKf+l2UzLeTuJ/9Ktex/36XDvJQg/rpk3etrXNyxrO8kn+uH5SiKn1dr
 Cnvg==
X-Gm-Message-State: APjAAAXHo+1pgdVqdfbuY6vTZUFTXhhVhjMwPwOtThfmx4xIicYRibkL
 UdyoNE+l12lBfVL4lnkI7sdiHd5Noak=
X-Google-Smtp-Source: APXvYqxDhWBb3a6wYia8kIh55NXgWTtM0kaS2PNGv41I0rk9iwiqv/d8uhOPjj518RZKbAv3xUCQEw==
X-Received: by 2002:aa7:98d2:: with SMTP id e18mr3764639pfm.188.1567526962121; 
 Tue, 03 Sep 2019 09:09:22 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:39 -0700
Message-Id: <20190903160858.5296-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 17/36] cputlb: Byte swap memory transaction
 attribute
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

Notice new attribute, byte swap, and force the transaction through the
memory slow path.

Required by architectures that can invert endianness of memory
transaction, e.g. SPARC64 has the Invert Endian TTE bit.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <2a10a1f1c00a894af1212c8f68ef09c2966023c1.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memattrs.h |  2 ++
 accel/tcg/cputlb.c      | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d4a3477d71..95f2d20d55 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
     unsigned int user:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+    /* Invert endianness for this page */
+    unsigned int byte_swap:1;
     /*
      * The following are target-specific page-table bits.  These are not
      * related to actual memory transactions at all.  However, this structure
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3c9e634d99..d9787cc893 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -738,6 +738,10 @@ void tlb_set_page_with_attrs(CPUState *cpu, target_ulong vaddr,
          */
         address |= TLB_RECHECK;
     }
+    if (attrs.byte_swap) {
+        /* Force the access through the I/O slow path.  */
+        address |= TLB_MMIO;
+    }
     if (!memory_region_is_ram(section->mr) &&
         !memory_region_is_romd(section->mr)) {
         /* IO memory case */
@@ -891,6 +895,10 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    if (iotlbentry->attrs.byte_swap) {
+        op ^= MO_BSWAP;
+    }
+
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
@@ -933,6 +941,10 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     bool locked = false;
     MemTxResult r;
 
+    if (iotlbentry->attrs.byte_swap) {
+        op ^= MO_BSWAP;
+    }
+
     section = iotlb_to_section(cpu, iotlbentry->addr, iotlbentry->attrs);
     mr = section->mr;
     mr_offset = (iotlbentry->addr & TARGET_PAGE_MASK) + addr;
-- 
2.17.1



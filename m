Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47306C19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168ED206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pZz+71E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168ED206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFvv-00030I-5z
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqS-0005vT-To
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqR-0002SG-8y
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33758)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htFqP-0002OE-67
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so74738591wru.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TglOXPXocmjTaXhVantu6J1HkU7rnV1Wk2+n62i4SbA=;
 b=pZz+71E91L7OFSncOpGwWS3q9r9X1jZtq+fgC1Rum5ylv5ptc1B531E2xhymgADIku
 zbb9p0GYLsUrKLqtIYi4JKAN0Mj3R2uBASsOIu5A225NZcNmyCcemznjXex2jQL00hsJ
 PwSxgLB+Q+RZhNmBy+8nXo2Jm8aSFYzeK4u1gcB/C0AxDj/pcwsIp73ZJZaS0n9+nUS4
 h8Xew0D7V1It+ZVIWk+JT//1LR4MyOkJIDmiSYA4MkYHxH3SsQfmj8e48vp2UQqTjGRN
 Lg92pW27m74hirW/QeuLm+oQfVgH5l5ocroPkvC/2WUjCfPXHDdyNzQ7GhRWa6fteN0F
 UgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TglOXPXocmjTaXhVantu6J1HkU7rnV1Wk2+n62i4SbA=;
 b=mx00ib+37hkMc0aGmRxGCNjbOXxkugrXsY0NHZPVjuzVP6+ZW5tH5s6eAwizz1/0D6
 fDsk04QEOXoIxgVZHh7SKg/RFjAWyXjAWQU8XsY+wozc0dGmuL/Z5MxqrC9zY8ASfLif
 dCm4UfOBx/Wy+ooF99lmiORFNvED7+Gl0ZC/szYxpxTYFNCragNQylAGCxTviq4+HBy6
 0a+oWtkeAHNx7YsopnxNbqkXRm94efkdjPun1VIJ63F3/wvE5uGBwseSmOpXk9zpL5u7
 3a+IWcZXa4Cxz61JLvnSkfEoWU4Cln1MgteWFrpkQtWpk51xPHgMQJVekK0ZX1stlftU
 Zykg==
X-Gm-Message-State: APjAAAVyYLYSlgJv0PvPsQ1pmaHOZyvuwgQ9Fbjj7jkG6CUVaqWFK6Ji
 0tjmytbYKEjWVXY8surGet+/OsLa+33k1g==
X-Google-Smtp-Source: APXvYqzMzeINwkONK53XjbPIhA/dw94g9J/y6W3fBIKKRHbfOkCHNcZ7L0/QYtaNfeB9HgO4aWUsmQ==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr4402169wrv.63.1564684217059; 
 Thu, 01 Aug 2019 11:30:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e6sm71702104wrw.23.2019.08.01.11.30.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 11:30:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 19:30:07 +0100
Message-Id: <20190801183012.17564-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801183012.17564-1-peter.maydell@linaro.org>
References: <20190801183012.17564-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 2/7] target/sparc: Check for transaction
 failures in MMU passthrough ASIs
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the ld/st_asi helper functions make calls to the
ld*_phys() and st*_phys() functions for those ASIs which
imply direct accesses to physical addresses. These implicitly
rely on the unassigned_access hook to cause them to generate
an MMU fault if the access fails.

Switch to using the address_space_* functions instead, which
return a MemTxResult that we can check. This means that when
we switch SPARC over to using the do_transaction_failed hook
we'll still get the same MMU faults we did before.

This commit converts the ASIs which do "MMU passthrough".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/ldst_helper.c | 49 +++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 26876e5a575..39698c58859 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -718,26 +718,36 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
     case ASI_M_DATAC_DATA: /* SparcStation 5 D-cache data */
         break;
     case 0x21 ... 0x2f: /* MMU passthrough, 0x100000000 to 0xfffffffff */
+    {
+        MemTxResult result;
+        hwaddr access_addr = (hwaddr)addr | ((hwaddr)(asi & 0xf) << 32);
+
         switch (size) {
         case 1:
-            ret = ldub_phys(cs->as, (hwaddr)addr
-                            | ((hwaddr)(asi & 0xf) << 32));
+            ret = address_space_ldub(cs->as, access_addr,
+                                     MEMTXATTRS_UNSPECIFIED, &result);
             break;
         case 2:
-            ret = lduw_phys(cs->as, (hwaddr)addr
-                            | ((hwaddr)(asi & 0xf) << 32));
+            ret = address_space_lduw(cs->as, access_addr,
+                                     MEMTXATTRS_UNSPECIFIED, &result);
             break;
         default:
         case 4:
-            ret = ldl_phys(cs->as, (hwaddr)addr
-                           | ((hwaddr)(asi & 0xf) << 32));
+            ret = address_space_ldl(cs->as, access_addr,
+                                    MEMTXATTRS_UNSPECIFIED, &result);
             break;
         case 8:
-            ret = ldq_phys(cs->as, (hwaddr)addr
-                           | ((hwaddr)(asi & 0xf) << 32));
+            ret = address_space_ldq(cs->as, access_addr,
+                                    MEMTXATTRS_UNSPECIFIED, &result);
             break;
         }
+
+        if (result != MEMTX_OK) {
+            sparc_raise_mmu_fault(cs, access_addr, false, false, false,
+                                  size, GETPC());
+        }
         break;
+    }
     case 0x30: /* Turbosparc secondary cache diagnostic */
     case 0x31: /* Turbosparc RAM snoop */
     case 0x32: /* Turbosparc page table descriptor diagnostic */
@@ -1053,25 +1063,32 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
         break;
     case 0x21 ... 0x2f: /* MMU passthrough, 0x100000000 to 0xfffffffff */
         {
+            MemTxResult result;
+            hwaddr access_addr = (hwaddr)addr | ((hwaddr)(asi & 0xf) << 32);
+
             switch (size) {
             case 1:
-                stb_phys(cs->as, (hwaddr)addr
-                         | ((hwaddr)(asi & 0xf) << 32), val);
+                address_space_stb(cs->as, access_addr, val,
+                                  MEMTXATTRS_UNSPECIFIED, &result);
                 break;
             case 2:
-                stw_phys(cs->as, (hwaddr)addr
-                         | ((hwaddr)(asi & 0xf) << 32), val);
+                address_space_stw(cs->as, access_addr, val,
+                                  MEMTXATTRS_UNSPECIFIED, &result);
                 break;
             case 4:
             default:
-                stl_phys(cs->as, (hwaddr)addr
-                         | ((hwaddr)(asi & 0xf) << 32), val);
+                address_space_stl(cs->as, access_addr, val,
+                                  MEMTXATTRS_UNSPECIFIED, &result);
                 break;
             case 8:
-                stq_phys(cs->as, (hwaddr)addr
-                         | ((hwaddr)(asi & 0xf) << 32), val);
+                address_space_stq(cs->as, access_addr, val,
+                                  MEMTXATTRS_UNSPECIFIED, &result);
                 break;
             }
+            if (result != MEMTX_OK) {
+                sparc_raise_mmu_fault(cs, access_addr, true, false, false,
+                                      size, GETPC());
+            }
         }
         break;
     case 0x30: /* store buffer tags or Turbosparc secondary cache diagnostic */
-- 
2.20.1



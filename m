Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952E3C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6092B206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 18:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0tipkqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6092B206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htFvw-00035Z-Fz
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 14:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59319)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqS-0005vP-Si
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htFqR-0002Sd-AA
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:32 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htFqP-0002Og-47
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 14:30:31 -0400
Received: by mail-wr1-x442.google.com with SMTP id x4so21465635wrt.6
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2019 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jQ2BSNZ1NixiavteNncErEBde69dl7wbZ/ajGAMjaso=;
 b=E0tipkqpTa+IkOxzA7y99ohE+vzBTGPdnccQVPwGUzZhfguWW6Ja1dUD98o7W8EqXV
 J3MCvTVTSYxIicfyyJKW7FQnR53dgfr/wwPILa4mpIuO03NC9esn7Bt1wLv/IQegqfDd
 LWg4L8WOJAnKb7PEmqblW9QcKhnjwx7++Z5JUpLhpoiYIMMz0W1JmuktB2k7KOXwkiLS
 Q17zY5cnfPhBorv5/noITShQlXAT46O6OmN89a2+uvk0sDw+1l/2VWUc/r8dK5niTfNJ
 w48X0mMAdppM69O4JGh8sbqMXYlBRWiy9REQmGXMpX3lgGcPolyNa3ZNCQK33n/JQ3J7
 WLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jQ2BSNZ1NixiavteNncErEBde69dl7wbZ/ajGAMjaso=;
 b=p8ZeNNCKJpq2ovTbMJwPYTwW+w+r/s4LVm2cMJ6qDFtovqGzSYIZB6hj8tIWJ99MKU
 1KmjQ6xxVOezfN7kFaaz9IYXD2R6YEdTjQtu/uMTfMAxH4Xc0OWjR1GXLeXOc14didPg
 j8vFyw42qGzxwHQ8JehhyiqG1mXJlllyiOcdtHcYlZpM4YIUFVDiUNC6p7WQJtlvM52l
 DLJ/0l11qfhrWQpEGk42g0gqwiu2e0RptD5wZg52d8XkDWZt0zEeEgu4pS/Z7TpFBq31
 U9Xn6IkrjAUmixbfRQiXyRBuhmfCbICo3b0Eq4i5/ugmKK2pJNoOBILd2Fz5KqTeOwf8
 JqLQ==
X-Gm-Message-State: APjAAAUqC1tbxgFS9SC4UlSVcI+4Cz1xnFuLjlMQ/yRh9ZGjothPsy/U
 bvqxJUaV7i7yVVARY8L3URpBOmvRqoXjgQ==
X-Google-Smtp-Source: APXvYqywiC2kO4QVl8gwqbYQNiwSm8T9+ne89cRcdDAAe/gh2dHnUgJxRa62E5UYmeNLe7oW84BkXQ==
X-Received: by 2002:adf:f544:: with SMTP id j4mr37489063wrp.150.1564684219284; 
 Thu, 01 Aug 2019 11:30:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e6sm71702104wrw.23.2019.08.01.11.30.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 01 Aug 2019 11:30:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  1 Aug 2019 19:30:09 +0100
Message-Id: <20190801183012.17564-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801183012.17564-1-peter.maydell@linaro.org>
References: <20190801183012.17564-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 4/7] target/sparc: Correctly handle bus errors
 in page table walks
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

Currently we use the ldl_phys() function to read page table entries.
With the unassigned_access hook in place, if these hit an unassigned
area of memory then the hook will cause us to wrongly generate
an exception with a fault address matching the address of the
page table entry.

Change to using address_space_ldl() so we can detect and correctly
handle bus errors and give them their correct behaviour of
causing a translation error with a suitable fault status register.

Note that this won't actually take effect until we switch the
over to using the do_translation_failed hook.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/sparc/mmu_helper.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index cbd1e911796..351055a09b1 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -98,6 +98,7 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
     int error_code = 0, is_dirty, is_user;
     unsigned long page_offset;
     CPUState *cs = env_cpu(env);
+    MemTxResult result;
 
     is_user = mmu_idx == MMU_USER_IDX;
 
@@ -120,7 +121,10 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
     /* SPARC reference MMU table walk: Context table->L1->L2->PTE */
     /* Context base + context number */
     pde_ptr = (env->mmuregs[1] << 4) + (env->mmuregs[2] << 2);
-    pde = ldl_phys(cs->as, pde_ptr);
+    pde = address_space_ldl(cs->as, pde_ptr, MEMTXATTRS_UNSPECIFIED, &result);
+    if (result != MEMTX_OK) {
+        return 4 << 2; /* Translation fault, L = 0 */
+    }
 
     /* Ctx pde */
     switch (pde & PTE_ENTRYTYPE_MASK) {
@@ -132,7 +136,11 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
         return 4 << 2;
     case 1: /* L0 PDE */
         pde_ptr = ((address >> 22) & ~3) + ((pde & ~3) << 4);
-        pde = ldl_phys(cs->as, pde_ptr);
+        pde = address_space_ldl(cs->as, pde_ptr,
+                                MEMTXATTRS_UNSPECIFIED, &result);
+        if (result != MEMTX_OK) {
+            return (1 << 8) | (4 << 2); /* Translation fault, L = 1 */
+        }
 
         switch (pde & PTE_ENTRYTYPE_MASK) {
         default:
@@ -142,7 +150,11 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
             return (1 << 8) | (4 << 2);
         case 1: /* L1 PDE */
             pde_ptr = ((address & 0xfc0000) >> 16) + ((pde & ~3) << 4);
-            pde = ldl_phys(cs->as, pde_ptr);
+            pde = address_space_ldl(cs->as, pde_ptr,
+                                    MEMTXATTRS_UNSPECIFIED, &result);
+            if (result != MEMTX_OK) {
+                return (2 << 8) | (4 << 2); /* Translation fault, L = 2 */
+            }
 
             switch (pde & PTE_ENTRYTYPE_MASK) {
             default:
@@ -152,7 +164,11 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
                 return (2 << 8) | (4 << 2);
             case 1: /* L2 PDE */
                 pde_ptr = ((address & 0x3f000) >> 10) + ((pde & ~3) << 4);
-                pde = ldl_phys(cs->as, pde_ptr);
+                pde = address_space_ldl(cs->as, pde_ptr,
+                                        MEMTXATTRS_UNSPECIFIED, &result);
+                if (result != MEMTX_OK) {
+                    return (3 << 8) | (4 << 2); /* Translation fault, L = 3 */
+                }
 
                 switch (pde & PTE_ENTRYTYPE_MASK) {
                 default:
-- 
2.20.1



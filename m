Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B1DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:20:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE8DE22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 15:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksUJSb4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8DE22DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0SPM-0007SZ-Ko
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 11:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SGB-00034j-3l
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen.git@gmail.com>) id 1i0SG9-0003qq-PP
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:50 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46943)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tony.nguyen.git@gmail.com>)
 id 1i0SG9-0003pt-JM
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 11:10:49 -0400
Received: by mail-pl1-x644.google.com with SMTP id c2so1477102plz.13
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oY9Kbuk4pt2Aj9npIHiGUXJM5Dr0CoLora3bbZEdlnU=;
 b=ksUJSb4OfBg9EfDATYLEyq4y1odVus5emNYpPEbGsFwOPgiIJEivJ/2rT+N5Nr19xj
 8rQlsyLDr5Ttqq+oNHi300CmhrParY7M89zXxcDejLGJugcJ9dyqyH7imjQnidwEQUeu
 pWy9IXVEQEuvWPkVEW1w0pbbhTDRUjOg8SR34ayswOWuYCxVzUB9TA18Vb+4gCUUifK3
 vYhEqsbuI00e0ks/PIBzEOs7LhyLN1KuXvnCsP8VPoj74JVWeMdwVkO7CINSu9eUwX+S
 bbhpjK3LRZqXUB263cdnFWsk2du0+wVaFVA4ZnkhyGeywuN29CJ2WTNLQEIg8CzF2fC3
 bvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oY9Kbuk4pt2Aj9npIHiGUXJM5Dr0CoLora3bbZEdlnU=;
 b=VSpHoHeq1ifw/7v23gf/2wwtDFnlZUYrk2mkwm/Le04Kh5mvZ/v9AuMFK+UBOfmFWT
 Ls/T0SwjgAyzAiXmf4vPVCI8l+dXsNUGtE7OGLJ6hWtqOHJZyEZikb3F6tHqYpnQ1O4S
 elI17tmvYogMcQ2o2lKUjQ3vH5bU+F8vQXVvAxD5sD0h7YdAz3xrxy0DX0JFtpSKIbxS
 YsdlBf8OUQGj+fDyuHnI2FzUPTu+m6ULETODFfAY7O4edO7lEzqX6HZxMj6VMbUHBHgN
 sTGAhEWzj2xfCtbpTd7AeB8sXC0V628FuAC1aCMfn633Bp44Tr5LT7twjeHQQ6WMKavz
 UJEA==
X-Gm-Message-State: APjAAAU4ms88+vYfKbSA+5swWgkVNEksjX8bGoPdkXQcNbnq8ENh9rDr
 8b3pYkj8ehVH49IXZOdu4+YSxBbnPMw=
X-Google-Smtp-Source: APXvYqzPk9fXGlYXo4+82Y5YqFti0WfUryogCBY3icdaq/Y5BIeOqjXjPyb/dlFc7NiZKtvMiXSTgQ==
X-Received: by 2002:a17:902:41:: with SMTP id
 59mr12109260pla.268.1566400248617; 
 Wed, 21 Aug 2019 08:10:48 -0700 (PDT)
Received: from localhost.localdomain ([58.173.98.68])
 by smtp.gmail.com with ESMTPSA id e19sm5887633pfh.114.2019.08.21.08.10.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 21 Aug 2019 08:10:47 -0700 (PDT)
From: Tony Nguyen <tony.nguyen.git@gmail.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:09:14 +1000
Message-Id: <9ba4b3413e6878b4a868be0dddeba8bec00a2e07.1566397711.git.tony.nguyen.git@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566397711.git.tony.nguyen.git@gmail.com>
References: <cover.1566397711.git.tony.nguyen.git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v8 20/21] target/sparc: Add TLB entry with
 attributes
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
Cc: Tony Nguyen <tony.nguyen.git@gmail.com>, Tony Nguyen <tony.nguyen@bt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Append MemTxAttrs to interfaces so we can pass along up coming Invert
Endian TTE bit on SPARC64.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/mmu_helper.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index cbd1e91179..826e14b6f0 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -88,7 +88,7 @@ static const int perm_table[2][8] = {
 };
 
 static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
-                                int *prot, int *access_index,
+                                int *prot, int *access_index, MemTxAttrs *attrs,
                                 target_ulong address, int rw, int mmu_idx,
                                 target_ulong *page_size)
 {
@@ -219,6 +219,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     target_ulong vaddr;
     target_ulong page_size;
     int error_code = 0, prot, access_index;
+    MemTxAttrs attrs = {};
 
     /*
      * TODO: If we ever need tlb_vaddr_to_host for this target,
@@ -229,7 +230,7 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     assert(!probe);
 
     address &= TARGET_PAGE_MASK;
-    error_code = get_physical_address(env, &paddr, &prot, &access_index,
+    error_code = get_physical_address(env, &paddr, &prot, &access_index, &attrs,
                                       address, access_type,
                                       mmu_idx, &page_size);
     vaddr = address;
@@ -490,8 +491,8 @@ static inline int ultrasparc_tag_match(SparcTLBEntry *tlb,
     return 0;
 }
 
-static int get_physical_address_data(CPUSPARCState *env,
-                                     hwaddr *physical, int *prot,
+static int get_physical_address_data(CPUSPARCState *env, hwaddr *physical,
+                                     int *prot, MemTxAttrs *attrs,
                                      target_ulong address, int rw, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
@@ -608,8 +609,8 @@ static int get_physical_address_data(CPUSPARCState *env,
     return 1;
 }
 
-static int get_physical_address_code(CPUSPARCState *env,
-                                     hwaddr *physical, int *prot,
+static int get_physical_address_code(CPUSPARCState *env, hwaddr *physical,
+                                     int *prot, MemTxAttrs *attrs,
                                      target_ulong address, int mmu_idx)
 {
     CPUState *cs = env_cpu(env);
@@ -686,7 +687,7 @@ static int get_physical_address_code(CPUSPARCState *env,
 }
 
 static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
-                                int *prot, int *access_index,
+                                int *prot, int *access_index, MemTxAttrs *attrs,
                                 target_ulong address, int rw, int mmu_idx,
                                 target_ulong *page_size)
 {
@@ -716,11 +717,11 @@ static int get_physical_address(CPUSPARCState *env, hwaddr *physical,
     }
 
     if (rw == 2) {
-        return get_physical_address_code(env, physical, prot, address,
+        return get_physical_address_code(env, physical, prot, attrs, address,
                                          mmu_idx);
     } else {
-        return get_physical_address_data(env, physical, prot, address, rw,
-                                         mmu_idx);
+        return get_physical_address_data(env, physical, prot, attrs, address,
+                                         rw, mmu_idx);
     }
 }
 
@@ -734,10 +735,11 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     target_ulong vaddr;
     hwaddr paddr;
     target_ulong page_size;
+    MemTxAttrs attrs = {};
     int error_code = 0, prot, access_index;
 
     address &= TARGET_PAGE_MASK;
-    error_code = get_physical_address(env, &paddr, &prot, &access_index,
+    error_code = get_physical_address(env, &paddr, &prot, &access_index, &attrs,
                                       address, access_type,
                                       mmu_idx, &page_size);
     if (likely(error_code == 0)) {
@@ -747,7 +749,8 @@ bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                                    env->dmmu.mmu_primary_context,
                                    env->dmmu.mmu_secondary_context);
 
-        tlb_set_page(cs, vaddr, paddr, prot, mmu_idx, page_size);
+        tlb_set_page_with_attrs(cs, vaddr, paddr, attrs, prot, mmu_idx,
+                                page_size);
         return true;
     }
     if (probe) {
@@ -849,9 +852,10 @@ static int cpu_sparc_get_phys_page(CPUSPARCState *env, hwaddr *phys,
 {
     target_ulong page_size;
     int prot, access_index;
+    MemTxAttrs attrs = {};
 
-    return get_physical_address(env, phys, &prot, &access_index, addr, rw,
-                                mmu_idx, &page_size);
+    return get_physical_address(env, phys, &prot, &access_index, &attrs, addr,
+                                rw, mmu_idx, &page_size);
 }
 
 #if defined(TARGET_SPARC64)
-- 
2.23.0



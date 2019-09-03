Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3103FC3A5A5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01446238CF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YPYbG/ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01446238CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BfE-0005AD-L2
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BN0-0001Jc-7w
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5BMy-0003pP-S6
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c]:34635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5BMy-0003ne-K9
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:09:24 -0400
Received: by mail-pl1-x62c.google.com with SMTP id d3so8112931plr.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pmK/xWcM59CiLHjrswu0qpYJ6H89YdF0u2aabjfZ4J8=;
 b=YPYbG/ih0pNQDHGTQg9qd3wVebnH319WU4GbIWujsrsj2rQEoIDeaa/R++WF3qZe7X
 aDlFAEa5xxRC6gRsfgP1kGGJ2Z1futisJbjDP9dazvM/QhXrcV2aS+pMEiW7QCrGF1sv
 2ouLN58xX6piLXG7FTfPp3OJ/2INFj0XCPhB+KvQpaPTTAgCPe2p+N831rutYA+6WyCD
 Vj0Y2LGb2W8t9sr4se8iV9QYvSuZOEVKXLvpCjmJG7EYoJ/zqDx6ElVvf8dP2foMvBZC
 6YHyrOeqA3xm8wDpInIJXpWkc3c8Ig+4YAqYKLUzHsiFdMA/31oaBZfiz1Y/F7e01s+J
 waeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pmK/xWcM59CiLHjrswu0qpYJ6H89YdF0u2aabjfZ4J8=;
 b=nQjzZEgTzK9cVtnm8vy8sG5h+THca9Oqb1IvgE50TsRm5iM9Rx6mabtkRpw7f/pl+2
 bII9rMwFC/GWKn3zSFagkcgfbDevuj7iBRhWhNXrdTiGvVEBlrUHflwvrhxCMiC23Hoa
 dNVYj0ULtC3kT154pp8OqwLPIQNsodZkGtka87GSSd4JIxIeYoqYLdY/qFtUNkZlNLtM
 IkzHdmixljnfLXkR4yy8nsgRfPE17C3ndtQNQqH2ASYl7m5U/rH7IFVTQrB5fpfiJ1WK
 dfx2lETSV7WJ4an/a630uUjMgWQiMnpKHQl91SmgsOzPF7FDlLRJ6Ub7FF/QSBO1YfiI
 qW7Q==
X-Gm-Message-State: APjAAAUePlatxPAzlEdFPh5VowogGhuSCBOpN2IUJ5ggW1rarwGP7nym
 Su1UhtlNF947QbZoTzabkx/DhFbR+w0=
X-Google-Smtp-Source: APXvYqzW6nPADjMzpLOfrWk52cI4VPUheYI+iSOXGX/DcvZyf905PRbn7PShyMhK+o5rRaSXrxWx4Q==
X-Received: by 2002:a17:902:9b86:: with SMTP id
 y6mr36109791plp.217.1567526963207; 
 Tue, 03 Sep 2019 09:09:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 127sm28089711pfy.56.2019.09.03.09.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 09:09:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 09:08:40 -0700
Message-Id: <20190903160858.5296-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903160858.5296-1-richard.henderson@linaro.org>
References: <20190903160858.5296-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62c
Subject: [Qemu-devel] [PATCH 18/36] target/sparc: Add TLB entry with
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
Cc: peter.maydell@linaro.org, Tony Nguyen <tony.nguyen@bt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tony Nguyen <tony.nguyen@bt.com>

Append MemTxAttrs to interfaces so we can pass along up coming Invert
Endian TTE bit on SPARC64.

Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <f8fcc3138570c460ef289a6b34ba7715ba36f99e.1566466906.git.tony.nguyen@bt.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.1



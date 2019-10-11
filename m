Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D19ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 058DD21D7D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBIDAX+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 058DD21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvcM-00058w-PQ
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJP-0006BZ-SI
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvJO-0004F1-J8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:31 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:46088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvJO-0004Dn-FI
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:30 -0400
Received: by mail-yb1-xb44.google.com with SMTP id h202so3098746ybg.13
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gTZdg6dNMnBI75tFG4b9WmQnPaXz16dMYJhebtyMXpQ=;
 b=wBIDAX+asObKfjuVDEL2xU9FHSH3yeVhyyRRVY5ytktNnKxy9YeVaI37JIbBPV8u2E
 v9RWXNv3Dxi9rKk4iAa7iSCpf7B+5R/r4/xJbcoINYl+rIPvQuUba7pq3P7P7uE6OsyC
 SbBwwQsMv6rj9pVqt3m1GkFrZ50cABXZ8G2zu7dK+O13ppOrQ/09abTB+uF6oKzJ8tLL
 ZlFIGQf2642s0+02HSA8OdvH23HoddRgaeTdrtf1GG6DHB5U4MxTntoUiwsXVXXGBXMc
 IfUhkN5eFcdn4TPt6eTsmyMoDQkxGLQm7al3eLhRNZYLIJmqL/75HzXBCb/tz1atclgn
 WrJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gTZdg6dNMnBI75tFG4b9WmQnPaXz16dMYJhebtyMXpQ=;
 b=gTiN0gmITkS1/eUbrt1wlavMMXIaEY09ADq4WQUgWSIb7QX70jpdt6J00Un/QI5sr8
 KqQoTcauix1ZRrlXlCL8w5m+69RN492bBjO1uWsm0q+DOPLzjYXCzSgjZqm25KdE8WYT
 ofzVA0ASR4RW92YZjeb3G5xTE1XFS8Om+9nUQX021tbWz/xpEgbqGjlkuRCdJrdWyKEO
 6ALH/Rl1RCSR6+gtRuACqGNKot2PLWzM6UtXFb7wbgVd9mgofi0gmEJ1VoyRKrEDllrO
 /eH4xpiTpO3TeUIy/33vL9osoJS1yNtP8BTn4OxoVA+wxNeq9mblYbbJnECuW+P9bkJD
 fvhw==
X-Gm-Message-State: APjAAAVduXfl0ky7HZc7RwbKlD97vlTHBboC75MOTBpAjOW4yl2oIBgh
 EXUnR+m1A1+QShSEP50Qinz04r3b4mM=
X-Google-Smtp-Source: APXvYqxvVovCzb8ouoi3UF9fqsLW3poCqVrKtAZSjsgChmqZk9pUgwDyOeszuR9B2JX7Q4c8CQBbCQ==
X-Received: by 2002:a5b:349:: with SMTP id q9mr10120579ybp.39.1570801829449;
 Fri, 11 Oct 2019 06:50:29 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 21/22] target/arm: Add mmu indexes for tag memory
Date: Fri, 11 Oct 2019 09:47:43 -0400
Message-Id: <20191011134744.2477-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The process by which one goes from an address space plus physical
address to a host pointer is complex.  It is easiest to reuse the
mechanism already present within cputlb, and letting that cache
the results.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-param.h |  2 +-
 target/arm/cpu.h       | 12 +++++++++---
 target/arm/internals.h |  2 ++
 target/arm/helper.c    | 25 +++++++++++++++++++++++--
 4 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu-param.h b/target/arm/cpu-param.h
index 6e6948e960..18ac562346 100644
--- a/target/arm/cpu-param.h
+++ b/target/arm/cpu-param.h
@@ -29,6 +29,6 @@
 # define TARGET_PAGE_BITS_MIN  10
 #endif
 
-#define NB_MMU_MODES 8
+#define NB_MMU_MODES 9
 
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index faca43ea78..c3609ef9d5 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2854,8 +2854,8 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 #define ARM_MMU_IDX_M_NEGPRI 0x2
 #define ARM_MMU_IDX_M_S 0x4
 
-#define ARM_MMU_IDX_TYPE_MASK (~0x7)
-#define ARM_MMU_IDX_COREIDX_MASK 0x7
+#define ARM_MMU_IDX_TYPE_MASK (~0xf)
+#define ARM_MMU_IDX_COREIDX_MASK 0xf
 
 typedef enum ARMMMUIdx {
     ARMMMUIdx_S12NSE0 = 0 | ARM_MMU_IDX_A,
@@ -2865,6 +2865,9 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_S1SE0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_S1SE1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_S2NS = 6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_TagNS = 7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_TagS = 8 | ARM_MMU_IDX_A,
+
     ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
     ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
     ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
@@ -2891,6 +2894,8 @@ typedef enum ARMMMUIdxBit {
     ARMMMUIdxBit_S1SE0 = 1 << 4,
     ARMMMUIdxBit_S1SE1 = 1 << 5,
     ARMMMUIdxBit_S2NS = 1 << 6,
+    ARMMMUIdxBit_TagNS = 1 << 7,
+    ARMMMUIdxBit_TagS = 1 << 8,
     ARMMMUIdxBit_MUser = 1 << 0,
     ARMMMUIdxBit_MPriv = 1 << 1,
     ARMMMUIdxBit_MUserNegPri = 1 << 2,
@@ -3254,7 +3259,8 @@ enum {
 /* Return the address space index to use for a memory access */
 static inline int arm_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
-    return attrs.secure ? ARMASIdx_S : ARMASIdx_NS;
+    return ((attrs.target_tlb_bit2 ? ARMASIdx_TagNS : ARMASIdx_NS)
+            + attrs.secure);
 }
 
 /* Return the AddressSpace to use for a memory access
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a434743b15..dfa395eb35 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -828,6 +828,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1NSE1:
     case ARMMMUIdx_S1E2:
     case ARMMMUIdx_S2NS:
+    case ARMMMUIdx_TagNS:
     case ARMMMUIdx_MPrivNegPri:
     case ARMMMUIdx_MUserNegPri:
     case ARMMMUIdx_MPriv:
@@ -836,6 +837,7 @@ static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
     case ARMMMUIdx_S1E3:
     case ARMMMUIdx_S1SE0:
     case ARMMMUIdx_S1SE1:
+    case ARMMMUIdx_TagS:
     case ARMMMUIdx_MSPrivNegPri:
     case ARMMMUIdx_MSUserNegPri:
     case ARMMMUIdx_MSPriv:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 17981d7c48..3147469899 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8658,9 +8658,18 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if (mmu_idx == ARMMMUIdx_S2NS) {
+    switch (mmu_idx) {
+    case ARMMMUIdx_S2NS:
         /* HCR.DC means HCR.VM behaves as 1 */
         return (env->cp15.hcr_el2 & (HCR_DC | HCR_VM)) == 0;
+
+    case ARMMMUIdx_TagS:
+    case ARMMMUIdx_TagNS:
+        /* These indexes are qemu internal, and are physically mapped.  */
+        return true;
+
+    default:
+        break;
     }
 
     if (env->cp15.hcr_el2 & HCR_TGE) {
@@ -10662,7 +10671,9 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
                    target_ulong *page_size,
                    ARMMMUFaultInfo *fi, ARMCacheAttrs *cacheattrs)
 {
-    if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
+    switch (mmu_idx) {
+    case ARMMMUIdx_S12NSE0:
+    case ARMMMUIdx_S12NSE1:
         /* Call ourselves recursively to do the stage 1 and then stage 2
          * translations.
          */
@@ -10713,6 +10724,16 @@ bool get_phys_addr(CPUARMState *env, target_ulong address,
              */
             mmu_idx = stage_1_mmu_idx(mmu_idx);
         }
+        break;
+
+    case ARMMMUIdx_TagS:
+    case ARMMMUIdx_TagNS:
+        /* Indicate tag memory to arm_asidx_from_attrs.  */
+        attrs->target_tlb_bit2 = true;
+        break;
+
+    default:
+        break;
     }
 
     /* The page table entries may downgrade secure to non-secure, but
-- 
2.17.1



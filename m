Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDEAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:23:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF8C206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF8C206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc85I-0002BA-DA
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kc7sN-00035W-4A; Mon, 09 Nov 2020 09:10:31 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:60184
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kc7sK-0002ow-WF; Mon, 09 Nov 2020 09:10:30 -0500
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id C70F560143;
 Mon,  9 Nov 2020 15:10:22 +0100 (CET)
From: remi.denis.courmont@huawei.com
To: qemu-arm@nongnu.org
Subject: [PATCH 08/17] target/arm: return the stage 2 index for stage 1
Date: Mon,  9 Nov 2020 16:10:11 +0200
Message-Id: <20201109141020.27234-8-remi.denis.courmont@huawei.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <5554493.MhkbZ0Pkbq@basile.remlab.net>
References: <5554493.MhkbZ0Pkbq@basile.remlab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:41d0:2:5a1a::; envelope-from=remi@remlab.net;
 helo=ns207790.ip-94-23-215.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 08:56:07
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>

This makes arm_mmu_idx_is_stage1_of_2() optionally return the stage 2
MMU index. With Secure EL2, there are more than one stage 2 regimes, so
we can no longer hard-code a constant index for it.

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c    | 13 +++++++------
 target/arm/internals.h | 16 +++++++++++-----
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 5c6b22c757..14eb0b4719 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3424,7 +3424,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
         bool take_exc = false;
 
         if (fi.s1ptw && current_el == 1 && !arm_is_secure(env)
-            && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
+            && arm_mmu_idx_is_stage1_of_2(mmu_idx, NULL)) {
             /*
              * Synchronous stage 2 fault on an access made as part of the
              * translation table walk for AT S1E0* or AT S1E1* insn
@@ -10008,7 +10008,7 @@ static inline bool regime_translation_disabled(CPUARMState *env,
         }
     }
 
-    if ((hcr_el2 & HCR_DC) && arm_mmu_idx_is_stage1_of_2(mmu_idx)) {
+    if ((hcr_el2 & HCR_DC) && arm_mmu_idx_is_stage1_of_2(mmu_idx, NULL)) {
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         return true;
     }
@@ -10340,16 +10340,17 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
                                hwaddr addr, MemTxAttrs txattrs,
                                ARMMMUFaultInfo *fi)
 {
-    if (arm_mmu_idx_is_stage1_of_2(mmu_idx) &&
-        !regime_translation_disabled(env, ARMMMUIdx_Stage2)) {
+    ARMMMUIdx s2_mmu_idx;
+
+    if (arm_mmu_idx_is_stage1_of_2(mmu_idx, &s2_mmu_idx) &&
+        !regime_translation_disabled(env, s2_mmu_idx)) {
         target_ulong s2size;
         hwaddr s2pa;
         int s2prot;
         int ret;
         ARMCacheAttrs cacheattrs = {};
 
-        ret = get_phys_addr_lpae(env, addr, MMU_DATA_LOAD, ARMMMUIdx_Stage2,
-                                 false,
+        ret = get_phys_addr_lpae(env, addr, MMU_DATA_LOAD, s2_mmu_idx, false,
                                  &s2pa, &txattrs, &s2prot, &s2size, fi,
                                  &cacheattrs);
         if (ret) {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 5460678756..4e4798574b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1146,17 +1146,23 @@ ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env);
 
 /**
  * arm_mmu_idx_is_stage1_of_2:
- * @mmu_idx: The ARMMMUIdx to test
+ * @s1_mmu_idx: The ARMMMUIdx to test
+ * @s2_mmu_idx: Storage space for the stage 2 ARMMMUIdx
  *
- * Return true if @mmu_idx is a NOTLB mmu_idx that is the
- * first stage of a two stage regime.
+ * Return true if @mmu_idx is a NOTLB mmu_idx that is the first stage
+ * of a two stage regime. The corresponding second stage will be
+ * stored in @s2_mmu_idx.
  */
-static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
+static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx s1_mmu_idx,
+                                              ARMMMUIdx *s2_mmu_idx)
 {
-    switch (mmu_idx) {
+    switch (s1_mmu_idx) {
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
+        if (s2_mmu_idx != NULL) {
+            *s2_mmu_idx = ARMMMUIdx_Stage2;
+        }
         return true;
     default:
         return false;
-- 
2.29.2



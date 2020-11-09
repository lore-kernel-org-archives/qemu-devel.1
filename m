Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBFAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815B5206ED
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815B5206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc80v-0004Ow-E4
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:19:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kc7sh-0003KO-F1; Mon, 09 Nov 2020 09:10:51 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:60196
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kc7sf-0002qS-GQ; Mon, 09 Nov 2020 09:10:51 -0500
Received: from basile.remlab.net (ip6-localhost [IPv6:::1])
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTP id 5BE32605D7;
 Mon,  9 Nov 2020 15:10:24 +0100 (CET)
From: remi.denis.courmont@huawei.com
To: qemu-arm@nongnu.org
Subject: [PATCH 14/17] target/arm: set HPFAR_EL2.NS on secure stage 2 faults
Date: Mon,  9 Nov 2020 16:10:17 +0200
Message-Id: <20201109141020.27234-14-remi.denis.courmont@huawei.com>
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

Signed-off-by: Rémi Denis-Courmont <remi.denis.courmont@huawei.com>
---
 target/arm/cpu.h        | 2 ++
 target/arm/helper.c     | 6 ++++++
 target/arm/internals.h  | 2 ++
 target/arm/tlb_helper.c | 3 +++
 4 files changed, 13 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c5535716c6..cc22693626 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1482,6 +1482,8 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_TWEDEN    (1ULL << 59)
 #define HCR_TWEDEL    MAKE_64BIT_MASK(60, 4)
 
+#define HPFAR_NS      (1ULL << 63)
+
 #define SCR_NS                (1U << 0)
 #define SCR_IRQ               (1U << 1)
 #define SCR_FIQ               (1U << 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 314366a71f..8a2e759ee6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3444,6 +3444,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                 target_el = 3;
             } else {
                 env->cp15.hpfar_el2 = extract64(fi.s2addr, 12, 47) << 4;
+                if (fi.s1ns) {
+                    env->cp15.hpfar_el2 |= HPFAR_NS;
+                }
                 target_el = 2;
             }
             take_exc = true;
@@ -10446,6 +10449,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
             fi->s2addr = addr;
             fi->stage2 = true;
             fi->s1ptw = true;
+            fi->s1ns = !*is_secure;
             return ~0;
         }
         if ((arm_hcr_el2_eff(env) & HCR_PTW) && (cacheattrs.attrs & 0xf0) == 0) {
@@ -10457,6 +10461,7 @@ static hwaddr S1_ptw_translate(CPUARMState *env, ARMMMUIdx mmu_idx,
             fi->s2addr = addr;
             fi->stage2 = true;
             fi->s1ptw = true;
+            fi->s1ns = !*is_secure;
             return ~0;
         }
         addr = s2pa;
@@ -11353,6 +11358,7 @@ do_fault:
     /* Tag the error as S2 for failed S1 PTW at S2 or ordinary S2.  */
     fi->stage2 = fi->s1ptw || (mmu_idx == ARMMMUIdx_Stage2 ||
                                mmu_idx == ARMMMUIdx_Stage2_S);
+    fi->s1ns = mmu_idx == ARMMMUIdx_Stage2;
     return true;
 }
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 04f71e0601..db6a7b8341 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -593,6 +593,7 @@ typedef enum ARMFaultType {
  * @s2addr: Address that caused a fault at stage 2
  * @stage2: True if we faulted at stage 2
  * @s1ptw: True if we faulted at stage 2 while doing a stage 1 page-table walk
+ * @s1ns: True if we faulted on a non-secure IPA while in secure state
  * @ea: True if we should set the EA (external abort type) bit in syndrome
  */
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
@@ -603,6 +604,7 @@ struct ARMMMUFaultInfo {
     int domain;
     bool stage2;
     bool s1ptw;
+    bool s1ns;
     bool ea;
 };
 
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index b35dc8a011..df85079d9f 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -63,6 +63,9 @@ static void QEMU_NORETURN arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     if (fi->stage2) {
         target_el = 2;
         env->cp15.hpfar_el2 = extract64(fi->s2addr, 12, 47) << 4;
+        if (arm_is_secure_below_el3(env) && fi->s1ns) {
+            env->cp15.hpfar_el2 |= HPFAR_NS;
+        }
     }
     same_el = (arm_current_el(env) == target_el);
 
-- 
2.29.2



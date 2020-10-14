Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3BFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C6E20723
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C6E20723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSdrz-0002Zs-86
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 06:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kSdr2-00025X-Bx; Wed, 14 Oct 2020 06:17:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5233 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kSdr0-0005J8-8l; Wed, 14 Oct 2020 06:17:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 5E7D6C1697A3FCB22667;
 Wed, 14 Oct 2020 18:17:48 +0800 (CST)
Received: from huawei.com (10.174.185.47) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 14 Oct 2020
 18:17:37 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH V3] target/riscv: raise exception to HS-mode at
 get_physical_address
Date: Wed, 14 Oct 2020 18:17:28 +0800
Message-ID: <20201014101728.848-1-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.47]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=jiangyifei@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 06:17:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, victor.zhangxiaofeng@huawei.com,
 richard.henderson@linaro.org, Yifei Jiang <jiangyifei@huawei.com>,
 Alistair.Francis@wdc.com, yinyipeng1@huawei.com, palmer@dabbelt.com,
 wu.wubin@huawei.com, dengkai1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VS-stage translation at get_physical_address needs to translate pte
address by G-stage translation. But the G-stage translation error
can not be distinguished from VS-stage translation error in
riscv_cpu_tlb_fill. On migration, destination needs to rebuild pte,
and this G-stage translation error must be handled by HS-mode. So
introduce TRANSLATE_STAGE2_FAIL so that riscv_cpu_tlb_fill could
distinguish and raise it to HS-mode.

Signed-off-by: Yifei Jiang <jiangyifei@huawei.com>
Signed-off-by: Yipeng Yin <yinyipeng1@huawei.com>
---
 target/riscv/cpu.h        | 10 +++++++---
 target/riscv/cpu_helper.c | 35 ++++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de275782e6..de4705bb57 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -82,9 +82,13 @@ enum {
 
 #define VEXT_VERSION_0_07_1 0x00000701
 
-#define TRANSLATE_PMP_FAIL 2
-#define TRANSLATE_FAIL 1
-#define TRANSLATE_SUCCESS 0
+enum {
+    TRANSLATE_SUCCESS,
+    TRANSLATE_FAIL,
+    TRANSLATE_PMP_FAIL,
+    TRANSLATE_G_STAGE_FAIL
+};
+
 #define MMU_USER_IDX 3
 
 #define MAX_RISCV_PMPS (16)
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 904899054d..ae66722d32 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -316,6 +316,8 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
  * @physical: This will be set to the calculated physical address
  * @prot: The returned protection attributes
  * @addr: The virtual address to be translated
+ * @fault_pte_addr: If not NULL, this will be set to fault pte address
+ *                  when a error occurs on pte address translation.
  * @access_type: The type of MMU access
  * @mmu_idx: Indicates current privilege level
  * @first_stage: Are we in first stage translation?
@@ -324,6 +326,7 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
  */
 static int get_physical_address(CPURISCVState *env, hwaddr *physical,
                                 int *prot, target_ulong addr,
+                                target_ulong *fault_pte_addr,
                                 int access_type, int mmu_idx,
                                 bool first_stage, bool two_stage)
 {
@@ -447,11 +450,14 @@ restart:
 
             /* Do the second stage translation on the base PTE address. */
             int vbase_ret = get_physical_address(env, &vbase, &vbase_prot,
-                                                 base, MMU_DATA_LOAD,
+                                                 base, NULL, MMU_DATA_LOAD,
                                                  mmu_idx, false, true);
 
             if (vbase_ret != TRANSLATE_SUCCESS) {
-                return vbase_ret;
+                if (fault_pte_addr) {
+                    *fault_pte_addr = (base + idx * ptesize) >> 2;
+                }
+                return TRANSLATE_G_STAGE_FAIL;
             }
 
             pte_addr = vbase + idx * ptesize;
@@ -632,13 +638,13 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot;
     int mmu_idx = cpu_mmu_index(&cpu->env, false);
 
-    if (get_physical_address(env, &phys_addr, &prot, addr, 0, mmu_idx,
+    if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_idx,
                              true, riscv_cpu_virt_enabled(env))) {
         return -1;
     }
 
     if (riscv_cpu_virt_enabled(env)) {
-        if (get_physical_address(env, &phys_addr, &prot, phys_addr,
+        if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL,
                                  0, mmu_idx, false, true)) {
             return -1;
         }
@@ -727,19 +733,30 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     if (riscv_cpu_virt_enabled(env) ||
         (riscv_cpu_two_stage_lookup(env) && access_type != MMU_INST_FETCH)) {
         /* Two stage lookup */
-        ret = get_physical_address(env, &pa, &prot, address, access_type,
+        ret = get_physical_address(env, &pa, &prot, address,
+                                   &env->guest_phys_fault_addr, access_type,
                                    mmu_idx, true, true);
 
+        /*
+         * A G-stage exception may be triggered during two state lookup.
+         * And the env->guest_phys_fault_addr has already been set in
+         * get_physical_address().
+         */
+        if (ret == TRANSLATE_G_STAGE_FAIL) {
+            first_stage_error = false;
+            access_type = MMU_DATA_LOAD;
+        }
+
         qemu_log_mask(CPU_LOG_MMU,
                       "%s 1st-stage address=%" VADDR_PRIx " ret %d physical "
                       TARGET_FMT_plx " prot %d\n",
                       __func__, address, ret, pa, prot);
 
-        if (ret != TRANSLATE_FAIL) {
+        if (ret == TRANSLATE_SUCCESS) {
             /* Second stage lookup */
             im_address = pa;
 
-            ret = get_physical_address(env, &pa, &prot2, im_address,
+            ret = get_physical_address(env, &pa, &prot2, im_address, NULL,
                                        access_type, mmu_idx, false, true);
 
             qemu_log_mask(CPU_LOG_MMU,
@@ -768,8 +785,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         }
     } else {
         /* Single stage lookup */
-        ret = get_physical_address(env, &pa, &prot, address, access_type,
-                                   mmu_idx, true, false);
+        ret = get_physical_address(env, &pa, &prot, address, NULL,
+                                   access_type, mmu_idx, true, false);
 
         qemu_log_mask(CPU_LOG_MMU,
                       "%s address=%" VADDR_PRIx " ret %d physical "
-- 
2.19.1



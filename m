Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376E3C4363A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C348E22275
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C348E22275
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQnIv-0007VQ-J1
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kQnI8-0006xj-3a; Fri, 09 Oct 2020 03:58:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40920 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiangyifei@huawei.com>)
 id 1kQnI5-00012V-JT; Fri, 09 Oct 2020 03:58:15 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 441313AAF4FEEA558ADA;
 Fri,  9 Oct 2020 15:57:58 +0800 (CST)
Received: from huawei.com (10.174.185.47) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 15:57:49 +0800
From: Yifei Jiang <jiangyifei@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>
Subject: [PATCH V2] target/riscv: raise exception to HS-mode at
 get_physical_address
Date: Fri, 9 Oct 2020 15:57:40 +0800
Message-ID: <20201009075740.688-1-jiangyifei@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.47]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=jiangyifei@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:46:07
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
 Yifei Jiang <jiangyifei@huawei.com>, Alistair.Francis@wdc.com,
 yinyipeng1@huawei.com, palmer@dabbelt.com, wu.wubin@huawei.com,
 dengkai1@huawei.com
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
 target/riscv/cpu.h        |  1 +
 target/riscv/cpu_helper.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de275782e6..8b856d518e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -86,6 +86,7 @@ enum {
 #define TRANSLATE_FAIL 1
 #define TRANSLATE_SUCCESS 0
 #define MMU_USER_IDX 3
+#define TRANSLATE_G_STAGE_FAIL 4
 
 #define MAX_RISCV_PMPS (16)
 
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 904899054d..096006dc00 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -451,7 +451,10 @@ restart:
                                                  mmu_idx, false, true);
 
             if (vbase_ret != TRANSLATE_SUCCESS) {
-                return vbase_ret;
+                env->guest_phys_fault_addr = (base |
+                                              (addr &
+                                               (TARGET_PAGE_SIZE - 1))) >> 2;
+                return TRANSLATE_G_STAGE_FAIL;
             }
 
             pte_addr = vbase + idx * ptesize;
@@ -730,12 +733,22 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         ret = get_physical_address(env, &pa, &prot, address, access_type,
                                    mmu_idx, true, true);
 
+        /*
+         * A G-stage exception may be triggered during VS-stage translation.
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
+        if (ret != TRANSLATE_FAIL && ret != TRANSLATE_G_STAGE_FAIL) {
             /* Second stage lookup */
             im_address = pa;
 
-- 
2.19.1



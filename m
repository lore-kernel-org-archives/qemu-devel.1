Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE011C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96933206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96933206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6AYb-0002Md-Qd
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k6AXC-0008V6-0E; Thu, 13 Aug 2020 06:32:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4184 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k6AX8-0006p2-PZ; Thu, 13 Aug 2020 06:32:33 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 24EFB428727448D1A081;
 Thu, 13 Aug 2020 18:32:27 +0800 (CST)
Received: from localhost.localdomain (10.175.104.175) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 13 Aug 2020 18:32:20 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC 4/9] target/arm: Allow ID registers to synchronize to KVM
Date: Thu, 13 Aug 2020 18:26:52 +0800
Message-ID: <20200813102657.2588720-5-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200813102657.2588720-1-liangpeng10@huawei.com>
References: <20200813102657.2588720-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:32:27
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, cohuck@redhat.com,
 xiexiangyou@huawei.com, Peng Liang <liangpeng10@huawei.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are 2 steps to synchronize the values of system registers from
CPU state to KVM:
1. write to the values of system registers from CPU state to
   (index,value) list by write_cpustate_to_list;
2. write the values in (index,value) list to KVM by
   write_list_to_kvmstate;

In step 1, the values of constant system registers are not allowed to
write to (index,value) list.  However, a constant system register is
CONSTANT for guest but not for QEMU, which means, QEMU can set/modify
the value of constant system registers that is different from phsical
registers when startup.  But if KVM is enabled, guest can not read the
values of the system registers which QEMU set unless they can be written
to (index,value) list.  And why not try to write to KVM if kvm_sync is
true?

At the moment we call write_cpustate_to_list, all ID registers are
contant, including ID_PFR1_EL1 and ID_AA64PFR0_EL1 because GIC has been
initialized.  Hence, let's give all ID registers a chance to write to
KVM.  If the write is successful, then write to (index,value) list.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 target/arm/helper.c  | 31 ++++++++++++++++++++-----------
 target/arm/kvm.c     | 38 ++++++++++++++++++++++++++++++++++++++
 target/arm/kvm_arm.h |  3 +++
 3 files changed, 61 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 9208ec046c..1cac269ef1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -34,6 +34,7 @@
 #include "arm_ldst.h"
 #include "exec/cpu_ldst.h"
 #endif
+#include "kvm_arm.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
@@ -369,30 +370,38 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
             ok = false;
             continue;
         }
-        if (ri->type & ARM_CP_NO_RAW) {
+        /*
+         * (Op0, Op1, CRn, CRm, Op2) of ID registers is (3, 0, 0, crm, op2),
+         * where 1<=crm<8, 0<=op2<8.  Let's give ID registers a chance to
+         * synchronize to kvm.
+         */
+        if ((ri->type & ARM_CP_NO_RAW) && !(kvm_sync &&
+            ri->opc0 == 3 && ri->opc1 == 0 && ri->crn == 0 && ri->crm > 0)) {
             continue;
         }
 
         newval = read_raw_cp_reg(&cpu->env, ri);
         if (kvm_sync) {
-            /*
-             * Only sync if the previous list->cpustate sync succeeded.
-             * Rather than tracking the success/failure state for every
-             * item in the list, we just recheck "does the raw write we must
-             * have made in write_list_to_cpustate() read back OK" here.
-             */
-            uint64_t oldval = cpu->cpreg_values[i];
+            /* Only sync if we can sync to KVM successfully. */
+            uint64_t oldval;
+            uint64_t kvmval;
 
+            if (kvm_arm_get_one_reg(cpu, cpu->cpreg_indexes[i], &oldval)) {
+                continue;
+            }
             if (oldval == newval) {
                 continue;
             }
 
-            write_raw_cp_reg(&cpu->env, ri, oldval);
-            if (read_raw_cp_reg(&cpu->env, ri) != oldval) {
+            if (kvm_arm_set_one_reg(cpu, cpu->cpreg_indexes[i], &newval)) {
+                continue;
+            }
+            if (kvm_arm_get_one_reg(cpu, cpu->cpreg_indexes[i], &kvmval) ||
+                kvmval != newval) {
                 continue;
             }
 
-            write_raw_cp_reg(&cpu->env, ri, newval);
+            kvm_arm_set_one_reg(cpu, cpu->cpreg_indexes[i], &oldval);
         }
         cpu->cpreg_values[i] = newval;
     }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8bb7318378..6a40e7da61 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -490,6 +490,44 @@ out:
     return ret;
 }
 
+int kvm_arm_get_one_reg(ARMCPU *cpu, uint64_t regidx, uint64_t *target)
+{
+    uint32_t v32;
+    int ret;
+
+    switch (regidx & KVM_REG_SIZE_MASK) {
+    case KVM_REG_SIZE_U32:
+        ret = kvm_get_one_reg(CPU(cpu), regidx, &v32);
+        if (ret == 0) {
+            *target = v32;
+        }
+        return ret;
+    case KVM_REG_SIZE_U64:
+        return kvm_get_one_reg(CPU(cpu), regidx, target);
+    default:
+        return -1;
+    }
+}
+
+int kvm_arm_set_one_reg(ARMCPU *cpu, uint64_t regidx, uint64_t *source)
+{
+    uint32_t v32;
+
+    switch (regidx & KVM_REG_SIZE_MASK) {
+    case KVM_REG_SIZE_U32:
+        v32 = *source;
+        if (v32 != *source) {
+            error_report("the value of source is too large");
+            return -1;
+        }
+        return kvm_set_one_reg(CPU(cpu), regidx, &v32);
+    case KVM_REG_SIZE_U64:
+        return kvm_set_one_reg(CPU(cpu), regidx, source);
+    default:
+        return -1;
+    }
+}
+
 bool write_kvmstate_to_list(ARMCPU *cpu)
 {
     CPUState *cs = CPU(cpu);
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index adb38514bf..99035494ae 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -478,4 +478,7 @@ static inline const char *its_class_name(void)
     }
 }
 
+int kvm_arm_get_one_reg(ARMCPU *cpu, uint64_t regidx, uint64_t *target);
+int kvm_arm_set_one_reg(ARMCPU *cpu, uint64_t regidx, uint64_t *source);
+
 #endif
-- 
2.18.4



Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2EAC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C052087D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C052087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIt0N-0003Q6-GB
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kIswq-0008Vl-Ak; Thu, 17 Sep 2020 08:23:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4763 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kIswm-0003Q6-O9; Thu, 17 Sep 2020 08:23:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9F85A6E678F74860A763;
 Thu, 17 Sep 2020 20:23:26 +0800 (CST)
Received: from localhost.localdomain (10.175.104.175) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 20:23:17 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 07/10] target/arm: Allow ID registers to synchronize to KVM
Date: Thu, 17 Sep 2020 20:14:46 +0800
Message-ID: <20200917121449.3442059-8-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917121449.3442059-1-liangpeng10@huawei.com>
References: <20200917121449.3442059-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:23:14
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
 target/arm/kvm_arm.h |  3 +++
 target/arm/helper.c  | 46 +++++++++++++++++++++++++++++++++-----------
 target/arm/kvm.c     | 38 ++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 33b3f107b47d..cf1c9c9cdb4c 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -479,4 +479,7 @@ static inline const char *its_class_name(void)
     }
 }
 
+int kvm_arm_get_one_reg(ARMCPU *cpu, uint64_t regidx, uint64_t *target);
+int kvm_arm_set_one_reg(ARMCPU *cpu, uint64_t regidx, uint64_t *source);
+
 #endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 26fef7424904..e489d744f15a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -34,6 +34,7 @@
 #include "arm_ldst.h"
 #include "exec/cpu_ldst.h"
 #endif
+#include "kvm_arm.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
@@ -353,6 +354,16 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
     return true;
 }
 
+static inline bool is_id_register(const ARMCPRegInfo *ri)
+{
+    /*
+     * (Op0, Op1, CRn, CRm, Op2) of ID registers is (3, 0, 0, crm, op2),
+     * where 1<=crm<8, 0<=op2<8.
+     */
+    return ri->opc0 == 3 && ri->opc1 == 0 && ri->crn == 0 &&
+        ri->crm > 0 && ri->crm < 8;
+}
+
 bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
 {
     /* Write the coprocessor state from cpu->env to the (index,value) list. */
@@ -369,30 +380,43 @@ bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
             ok = false;
             continue;
         }
-        if (ri->type & ARM_CP_NO_RAW) {
+        /* Let's give ID registers a chance to synchronize to kvm. */
+        if ((ri->type & ARM_CP_NO_RAW) && !(kvm_sync && is_id_register(ri))) {
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
+                if (is_id_register(ri)) {
+                    ok = false;
+                    error_report("Cannot set ID regsiter %s: %s", ri->name,
+                                 strerror(errno));
+                }
+                continue;
+            }
+            if (kvm_arm_get_one_reg(cpu, cpu->cpreg_indexes[i], &kvmval) ||
+                kvmval != newval) {
+                if (is_id_register(ri)) {
+                    ok = false;
+                    error_report("Setting ID register %s doesn't effect",
+                                 ri->name);
+                }
                 continue;
             }
 
-            write_raw_cp_reg(&cpu->env, ri, newval);
+            kvm_arm_set_one_reg(cpu, cpu->cpreg_indexes[i], &oldval);
         }
         cpu->cpreg_values[i] = newval;
     }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 2eae73315d6e..5b5cde5e821e 100644
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
-- 
2.26.2



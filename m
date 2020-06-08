Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304B9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01923206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01923206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiGez-0002Dt-8n
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jiGeE-0001gD-Fx; Mon, 08 Jun 2020 08:13:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49182 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jiGeC-00004s-KS; Mon, 08 Jun 2020 08:13:01 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id D2D89A3EF5C59D08A87C;
 Mon,  8 Jun 2020 20:12:53 +0800 (CST)
Received: from localhost (10.173.222.233) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 20:12:45 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>
Subject: [PATCH v3] target/arm/cpu: adjust virtual time for arm cpu
Date: Mon, 8 Jun 2020 20:12:43 +0800
Message-ID: <20200608121243.2076-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.173.222.233]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 08:12:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: drjones@redhat.com, zhang.zhanghailiang@huawei.com, wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fangying <fangying1@huawei.com>

Virtual time adjustment was implemented for virt-5.0 machine type,
but the cpu property was enabled only for host-passthrough and
max cpu model. Let's add it for arm cpu which has the generic timer
feature enabled.

Suggested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>

---
v3:
- set kvm-no-adjvtime property in kvm_arm_add_vcpu_properties

v2:
- move kvm_arm_add_vcpu_properties into arm_cpu_post_init

v1:
- initial commit
- https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08518.html

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 32bec156f2..5b7a36b5d7 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1245,6 +1245,10 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
         qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
     }
+
+    if (kvm_enabled()) {
+        kvm_arm_add_vcpu_properties(obj);
+    }
 }
 
 static void arm_cpu_finalizefn(Object *obj)
@@ -2029,7 +2033,6 @@ static void arm_max_initfn(Object *obj)
 
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
-        kvm_arm_add_vcpu_properties(obj);
     } else {
         cortex_a15_initfn(obj);
 
@@ -2183,7 +2186,6 @@ static void arm_host_initfn(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
         aarch64_add_sve_properties(obj);
     }
-    kvm_arm_add_vcpu_properties(obj);
     arm_cpu_post_init(obj);
 }
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index cbc5c3868f..778cecc2e6 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -592,7 +592,6 @@ static void aarch64_max_initfn(Object *obj)
 
     if (kvm_enabled()) {
         kvm_arm_set_cpu_features_from_host(cpu);
-        kvm_arm_add_vcpu_properties(obj);
     } else {
         uint64_t t;
         uint32_t u;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 4bdbe6dcac..eef3bbd1cc 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -194,17 +194,18 @@ static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(Object *obj)
 {
-    if (!kvm_enabled()) {
-        return;
-    }
+    ARMCPU *cpu = ARM_CPU(obj);
+    CPUARMState *env = &cpu->env;
 
-    ARM_CPU(obj)->kvm_adjvtime = true;
-    object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
-                             kvm_no_adjvtime_set);
-    object_property_set_description(obj, "kvm-no-adjvtime",
-                                    "Set on to disable the adjustment of "
-                                    "the virtual counter. VM stopped time "
-                                    "will be counted.");
+    if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
+        cpu->kvm_adjvtime = true;
+        object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
+                                 kvm_no_adjvtime_set);
+        object_property_set_description(obj, "kvm-no-adjvtime",
+                                        "Set on to disable the adjustment of "
+                                        "the virtual counter. VM stopped time "
+                                        "will be counted.");
+    }
 }
 
 bool kvm_arm_pmu_supported(CPUState *cpu)
-- 
2.23.0



Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80939C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E97206C3
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 09:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E97206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jexhy-0001cp-EI
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 05:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jexhN-0000Kx-TT; Sat, 30 May 2020 05:22:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3769 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1jexhM-0006yP-J7; Sat, 30 May 2020 05:22:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A31619B39CB490453C06;
 Sat, 30 May 2020 17:22:29 +0800 (CST)
Received: from localhost (10.173.222.233) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sat, 30 May 2020
 17:22:22 +0800
From: Ying Fang <fangying1@huawei.com>
To: <drjones@redhat.com>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH] target/arm/cpu: adjust virtual time for cortex series cpu
Date: Sat, 30 May 2020 17:22:04 +0800
Message-ID: <20200530092204.1746-1-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.173.222.233]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 05:22:30
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 wu.wubin@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Virtual time adjustment was implemented for virt-5.0 machine type,
but the cpu property was enabled only for host-passthrough and
max cpu model. Let's add it for arm cortex series cpu which has
the gernic timer feature enabled.

Signed-off-by: Ying Fang <fangying1@huawei.com>
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 32bec156f2..a564141b22 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1973,6 +1973,9 @@ static void cortex_a7_initfn(Object *obj)
     cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
     cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo); /* Same as A15 */
+    if (kvm_enabled()) {
+        kvm_arm_add_vcpu_properties(obj);
+    }
 }
 
 static void cortex_a15_initfn(Object *obj)
@@ -2015,6 +2018,9 @@ static void cortex_a15_initfn(Object *obj)
     cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
     cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
     define_arm_cp_regs(cpu, cortexa15_cp_reginfo);
+    if (kvm_enabled()) {
+        kvm_arm_add_vcpu_properties(obj);
+    }
 }
 
 #ifndef TARGET_AARCH64
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index cbc5c3868f..3922347b83 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -137,6 +137,9 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
     define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
+    if (kvm_enabled()) {
+        kvm_arm_add_vcpu_properties(obj);
+    }
 }
 
 static void aarch64_a53_initfn(Object *obj)
@@ -190,6 +193,9 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
     define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
+    if (kvm_enabled()) {
+        kvm_arm_add_vcpu_properties(obj);
+    }
 }
 
 static void aarch64_a72_initfn(Object *obj)
@@ -241,6 +247,9 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
     define_arm_cp_regs(cpu, cortex_a72_a57_a53_cp_reginfo);
+    if (kvm_enabled()) {
+        kvm_arm_add_vcpu_properties(obj);
+    }
 }
 
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
-- 
2.23.0




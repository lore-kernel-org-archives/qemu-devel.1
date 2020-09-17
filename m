Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD7AC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC825208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 12:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC825208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIt6c-00028C-31
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 08:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kIsww-0000Kc-6K; Thu, 17 Sep 2020 08:23:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51596 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1kIswr-0003R8-FK; Thu, 17 Sep 2020 08:23:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5FACB1A9EBC2C0236BA8;
 Thu, 17 Sep 2020 20:23:32 +0800 (CST)
Received: from localhost.localdomain (10.175.104.175) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 20:23:21 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC v2 09/10] target/arm: introduce CPU feature dependency mechanism
Date: Thu, 17 Sep 2020 20:14:48 +0800
Message-ID: <20200917121449.3442059-10-liangpeng10@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917121449.3442059-1-liangpeng10@huawei.com>
References: <20200917121449.3442059-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=liangpeng10@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:23:09
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

Some CPU features are dependent on other CPU features.  For example,
ID_AA64PFR0_EL1.FP field and ID_AA64PFR0_EL1.AdvSIMD must have the same
value, which means FP and ADVSIMD are dependent on each other, FPHP and
ADVSIMDHP are dependent on each other.

This commit introduces a mechanism for CPU feature dependency in
AArch64.  We build a directed graph from the CPU feature dependency
relationship, each edge from->to means the `to` CPU feature is dependent
on the `from` CPU feature.  And we will automatically enable/disable CPU
feature according to the directed graph.

For example, a and b CPU features are in relationship a->b, which means
b is dependent on a.  If b is enabled by user, then a is enabled
automatically.  And if a is disabled by user, then b is disabled
automatically.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 target/arm/cpu.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 36375807e19d..4bb8587e9c53 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1257,6 +1257,107 @@ static struct CPUFeatureInfo cpu_features[] = {
     },
 };
 
+typedef struct CPUFeatureDep {
+    CPUFeatureInfo from, to;
+} CPUFeatureDep;
+
+static const CPUFeatureDep feature_dependencies[] = {
+    {
+        .from = FIELD_INFO("fp", ID_AA64PFR0, FP, true, 0, 0xf, false),
+        .to = FIELD_INFO("asimd", ID_AA64PFR0, ADVSIMD, true, 0, 0xf, false),
+    },
+    {
+        .from = FIELD_INFO("asimd", ID_AA64PFR0, ADVSIMD, true, 0, 0xf, false),
+        .to = FIELD_INFO("fp", ID_AA64PFR0, FP, true, 0, 0xf, false),
+    },
+    {
+        .from = {
+            .reg = ID_AA64PFR0, .length = R_ID_AA64PFR0_FP_LENGTH,
+            .shift = R_ID_AA64PFR0_FP_SHIFT, .sign = true, .min_value = 1,
+            .ni_value = 0, .name = "fphp", .is_32bit = false,
+        },
+        .to = {
+            .reg = ID_AA64PFR0, .length = R_ID_AA64PFR0_ADVSIMD_LENGTH,
+            .shift = R_ID_AA64PFR0_ADVSIMD_SHIFT, .sign = true, .min_value = 1,
+            .ni_value = 0, .name = "asimdhp", .is_32bit = false,
+        },
+    },
+    {
+        .from = {
+            .reg = ID_AA64PFR0, .length = R_ID_AA64PFR0_ADVSIMD_LENGTH,
+            .shift = R_ID_AA64PFR0_ADVSIMD_SHIFT, .sign = true, .min_value = 1,
+            .ni_value = 0, .name = "asimdhp", .is_32bit = false,
+        },
+        .to = {
+            .reg = ID_AA64PFR0, .length = R_ID_AA64PFR0_FP_LENGTH,
+            .shift = R_ID_AA64PFR0_FP_SHIFT, .sign = true, .min_value = 1,
+            .ni_value = 0, .name = "fphp", .is_32bit = false,
+        },
+    },
+    {
+
+        .from = FIELD_INFO("aes", ID_AA64ISAR0, AES, false, 1, 0, false),
+        .to = {
+            .reg = ID_AA64ISAR0, .length = R_ID_AA64ISAR0_AES_LENGTH,
+            .shift = R_ID_AA64ISAR0_AES_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "pmull", .is_32bit = false,
+        },
+    },
+    {
+
+        .from = FIELD_INFO("sha2", ID_AA64ISAR0, SHA2, false, 1, 0, false),
+        .to = {
+            .reg = ID_AA64ISAR0, .length = R_ID_AA64ISAR0_SHA2_LENGTH,
+            .shift = R_ID_AA64ISAR0_SHA2_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "sha512", .is_32bit = false,
+        },
+    },
+    {
+        .from = FIELD_INFO("lrcpc", ID_AA64ISAR1, LRCPC, false, 1, 0, false),
+        .to = {
+            .reg = ID_AA64ISAR1, .length = R_ID_AA64ISAR1_LRCPC_LENGTH,
+            .shift = R_ID_AA64ISAR1_LRCPC_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "ilrcpc", .is_32bit = false,
+        },
+    },
+    {
+        .from = FIELD_INFO("sm3", ID_AA64ISAR0, SM3, false, 1, 0, false),
+        .to = FIELD_INFO("sm4", ID_AA64ISAR0, SM4, false, 1, 0, false),
+    },
+    {
+        .from = FIELD_INFO("sm4", ID_AA64ISAR0, SM4, false, 1, 0, false),
+        .to = FIELD_INFO("sm3", ID_AA64ISAR0, SM3, false, 1, 0, false),
+    },
+    {
+        .from = FIELD_INFO("sha1", ID_AA64ISAR0, SHA1, false, 1, 0, false),
+        .to = FIELD_INFO("sha2", ID_AA64ISAR0, SHA2, false, 1, 0, false),
+    },
+    {
+        .from = FIELD_INFO("sha2", ID_AA64ISAR0, SHA2, false, 1, 0, false),
+        .to = FIELD_INFO("sha1", ID_AA64ISAR0, SHA1, false, 1, 0, false),
+    },
+    {
+        .from = FIELD_INFO("sha1", ID_AA64ISAR0, SHA1, false, 1, 0, false),
+        .to = FIELD_INFO("sha3", ID_AA64ISAR0, SHA3, false, 1, 0, false),
+    },
+    {
+        .from = FIELD_INFO("sha3", ID_AA64ISAR0, SHA3, false, 1, 0, false),
+        .to = {
+            .reg = ID_AA64ISAR0, .length = R_ID_AA64ISAR0_SHA2_LENGTH,
+            .shift = R_ID_AA64ISAR0_SHA2_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "sha512", .is_32bit = false,
+        },
+    },
+    {
+        .from = {
+            .reg = ID_AA64ISAR0, .length = R_ID_AA64ISAR0_SHA2_LENGTH,
+            .shift = R_ID_AA64ISAR0_SHA2_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "sha512", .is_32bit = false,
+        },
+        .to = FIELD_INFO("sha3", ID_AA64ISAR0, SHA3, false, 1, 0, false),
+    },
+};
+
 static void arm_cpu_get_feature_prop(Object *obj, Visitor *v, const char *name,
                                      void *opaque, Error **errp)
 {
@@ -1491,6 +1592,8 @@ static void arm_cpu_finalizefn(Object *obj)
 
 void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
 {
+    int i;
+    ARMISARegisters *isar = &cpu->isar;
     Error *local_err = NULL;
 
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
@@ -1500,6 +1603,37 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
             return;
         }
     }
+
+    if (!kvm_enabled() || !kvm_arm_cpu_feature_supported()) {
+        return;
+    }
+
+    for (i = 0; i < ARRAY_SIZE(feature_dependencies); ++i) {
+        const CPUFeatureDep *d = &feature_dependencies[i];
+        bool from_explicit = !!(isar->user_mask[d->from.reg] &
+                                MAKE_64BIT_MASK(d->from.shift, d->from.length));
+        bool to_explicit = !!(isar->user_mask[d->to.reg] &
+                              MAKE_64BIT_MASK(d->to.shift, d->to.length));
+        bool from_enabled = object_property_get_bool(OBJECT(cpu), d->from.name,
+                                                     &error_abort);
+        bool to_enabled = object_property_get_bool(OBJECT(cpu), d->to.name,
+                                                   &error_abort);
+
+        if (!from_enabled && to_enabled) {
+            if (from_explicit && to_explicit) {
+                error_setg(errp, "The CPU feature '%s' dependes on CPU feature "
+                           "'%s' that is disabled explicitly",
+                           d->to.name, d->from.name);
+                return;
+            } else if (from_explicit) {
+                isar->regs[d->to.reg] = deposit64(isar->regs[d->to.reg],
+                        d->to.shift, d->to.length, d->to.ni_value);
+            } else if (to_explicit) {
+                isar->regs[d->from.reg] = deposit64(isar->regs[d->from.reg],
+                        d->from.shift, d->from.length, d->from.min_value);
+            }
+        }
+    }
 }
 
 static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.26.2



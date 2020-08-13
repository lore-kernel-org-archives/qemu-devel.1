Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87624C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:34:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A641206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A641206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6AYu-0002vg-HE
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k6AXE-00008M-3Y; Thu, 13 Aug 2020 06:32:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4181 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liangpeng10@huawei.com>)
 id 1k6AXA-0006oz-Ef; Thu, 13 Aug 2020 06:32:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 10802DDD0521AA55BFD7;
 Thu, 13 Aug 2020 18:32:27 +0800 (CST)
Received: from localhost.localdomain (10.175.104.175) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 13 Aug 2020 18:32:20 +0800
From: Peng Liang <liangpeng10@huawei.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: [RFC 5/9] target/arm: introduce CPU feature dependency mechanism
Date: Thu, 13 Aug 2020 18:26:53 +0800
Message-ID: <20200813102657.2588720-6-liangpeng10@huawei.com>
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

Some CPU features are dependent on other CPU features.  For example,
ID_AA64PFR0_EL1.FP field and ID_AA64PFR0_EL1.AdvSIMD must have the same
value, which means FP and ADVSIMD are dependent on each other, FPHP and
ADVSIMDHP are dependent on each other.

This commit introduces a mechanism for CPU feature dependency in
AArch64.  We build a directed graph from the CPU feature dependency
relationship, each edge from->to means the `to` CPU feature is dependent
on the `from` CPU feature.  And we will automatically enable/disable CPU
feature according to the directed graph.

For example, a, b, and c CPU features are in relationship a->b->c, which
means c is dependent on b and b is dependent on a.  If c is enabled by
user, then a and b is enabled automatically.  And if a is disabled by
user, then b and c is disabled automatically.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Peng Liang <liangpeng10@huawei.com>
---
 target/arm/cpu.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 113cf4a9e7..4e67b8f22c 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1418,6 +1418,103 @@ static struct CPUFeatureInfo cpu_features[] = {
     },
 };
 
+typedef struct CPUFeatureDep {
+    CPUFeatureInfo from, to;
+} CPUFeatureDep;
+
+static const CPUFeatureDep feature_dependencies[] = {
+    {
+        .from = FIELD_INFO(ID_AA64PFR0, FP, true, 0, 0xf, false),
+        .to = FIELD_INFO(ID_AA64PFR0, ADVSIMD, true, 0, 0xf, false),
+    },
+    {
+        .from = FIELD_INFO(ID_AA64PFR0, ADVSIMD, true, 0, 0xf, false),
+        .to = FIELD_INFO(ID_AA64PFR0, FP, true, 0, 0xf, false),
+    },
+    {
+        .from = {
+            .reg = ID_AA64PFR0, .length = R_ID_AA64PFR0_FP_LENGTH,
+            .shift = R_ID_AA64PFR0_FP_SHIFT, .sign = true, .min_value = 1,
+            .ni_value = 0, .name = "FPHP", .is_32bit = false,
+        },
+        .to = {
+            .reg = ID_AA64PFR0, .length = R_ID_AA64PFR0_ADVSIMD_LENGTH,
+            .shift = R_ID_AA64PFR0_ADVSIMD_SHIFT, .sign = true, .min_value = 1,
+            .ni_value = 0, .name = "ADVSIMDHP", .is_32bit = false,
+        },
+    },
+    {
+        .from = {
+            .reg = ID_AA64PFR0, .length = R_ID_AA64PFR0_ADVSIMD_LENGTH,
+            .shift = R_ID_AA64PFR0_ADVSIMD_SHIFT, .sign = true, .min_value = 1,
+            .ni_value = 0, .name = "ADVSIMDHP", .is_32bit = false,
+        },
+        .to = {
+            .reg = ID_AA64PFR0, .length = R_ID_AA64PFR0_FP_LENGTH,
+            .shift = R_ID_AA64PFR0_FP_SHIFT, .sign = true, .min_value = 1,
+            .ni_value = 0, .name = "FPHP", .is_32bit = false,
+        },
+    },
+    {
+
+        .from = FIELD_INFO(ID_AA64ISAR0, AES, false, 1, 0, false),
+        .to = {
+            .reg = ID_AA64ISAR0, .length = R_ID_AA64ISAR0_AES_LENGTH,
+            .shift = R_ID_AA64ISAR0_AES_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "PMULL", .is_32bit = false,
+        },
+    },
+    {
+
+        .from = FIELD_INFO(ID_AA64ISAR0, SHA2, false, 1, 0, false),
+        .to = {
+            .reg = ID_AA64ISAR0, .length = R_ID_AA64ISAR0_SHA2_LENGTH,
+            .shift = R_ID_AA64ISAR0_SHA2_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "SHA512", .is_32bit = false,
+        },
+    },
+    {
+        .from = FIELD_INFO(ID_AA64ISAR1, LRCPC, false, 1, 0, false),
+        .to = {
+            .reg = ID_AA64ISAR1, .length = R_ID_AA64ISAR1_LRCPC_LENGTH,
+            .shift = R_ID_AA64ISAR1_LRCPC_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "ILRCPC", .is_32bit = false,
+        },
+    },
+    {
+        .from = FIELD_INFO(ID_AA64ISAR0, SM3, false, 1, 0, false),
+        .to = FIELD_INFO(ID_AA64ISAR0, SM4, false, 1, 0, false),
+    },
+    {
+        .from = FIELD_INFO(ID_AA64ISAR0, SM4, false, 1, 0, false),
+        .to = FIELD_INFO(ID_AA64ISAR0, SM3, false, 1, 0, false),
+    },
+    {
+        .from = FIELD_INFO(ID_AA64ISAR0, SHA1, false, 1, 0, false),
+        .to = FIELD_INFO(ID_AA64ISAR0, SHA2, false, 1, 0, false),
+    },
+    {
+        .from = FIELD_INFO(ID_AA64ISAR0, SHA1, false, 1, 0, false),
+        .to = FIELD_INFO(ID_AA64ISAR0, SHA3, false, 1, 0, false),
+    },
+    {
+        .from = FIELD_INFO(ID_AA64ISAR0, SHA3, false, 1, 0, false),
+        .to = {
+            .reg = ID_AA64ISAR0, .length = R_ID_AA64ISAR0_SHA2_LENGTH,
+            .shift = R_ID_AA64ISAR0_SHA2_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "SHA512", .is_32bit = false,
+        },
+    },
+    {
+        .from = {
+            .reg = ID_AA64ISAR0, .length = R_ID_AA64ISAR0_SHA2_LENGTH,
+            .shift = R_ID_AA64ISAR0_SHA2_SHIFT, .sign = false, .min_value = 2,
+            .ni_value = 1, .name = "SHA512", .is_32bit = false,
+        },
+        .to = FIELD_INFO(ID_AA64ISAR0, SHA3, false, 1, 0, false),
+    },
+};
+
 static void arm_cpu_get_bit_prop(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
@@ -1454,13 +1551,45 @@ static void arm_cpu_set_bit_prop(Object *obj, Visitor *v, const char *name,
     }
 
     if (value) {
+        if (object_property_get_bool(obj, feat->name, NULL)) {
+            return;
+        }
         isar->regs[feat->reg] = deposit64(isar->regs[feat->reg],
                                           feat->shift, feat->length,
                                           feat->min_value);
+        /* Auto enable the features which current feature is dependent on. */
+        for (int i = 0; i < ARRAY_SIZE(feature_dependencies); ++i) {
+            const CPUFeatureDep *d = &feature_dependencies[i];
+            if (strcmp(d->to.name, feat->name) != 0) {
+                continue;
+            }
+
+            object_property_set_bool(obj, d->from.name, true, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        }
     } else {
+        if (!object_property_get_bool(obj, feat->name, NULL)) {
+            return;
+        }
         isar->regs[feat->reg] = deposit64(isar->regs[feat->reg],
                                           feat->shift, feat->length,
                                           feat->ni_value);
+        /* Auto disable the features which are dependent on current feature. */
+        for (int i = 0; i < ARRAY_SIZE(feature_dependencies); ++i) {
+            const CPUFeatureDep *d = &feature_dependencies[i];
+            if (strcmp(d->from.name, feat->name) != 0) {
+                continue;
+            }
+
+            object_property_set_bool(obj, d->to.name, false, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+        }
     }
 }
 
-- 
2.18.4



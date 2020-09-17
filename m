Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A6CC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA30206B5
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 03:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA30206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIkY4-0002FS-Tm
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 23:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIkUP-0004zU-9w; Wed, 16 Sep 2020 23:21:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4748 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fangying1@huawei.com>)
 id 1kIkUM-0004RS-J7; Wed, 16 Sep 2020 23:21:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id F287774951387E5CE419;
 Thu, 17 Sep 2020 11:21:13 +0800 (CST)
Received: from localhost (10.174.185.104) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:21:04 +0800
From: Ying Fang <fangying1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH 09/12] target/arm/cpu: Add CPU cache description for arm
Date: Thu, 17 Sep 2020 11:20:30 +0800
Message-ID: <20200917032033.2020-10-fangying1@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200917032033.2020-1-fangying1@huawei.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.185.104]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=fangying1@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 23:21:09
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
 zhang.zhanghailiang@huawei.com, alex.chen@huawei.com, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, alistair.francis@wdc.com,
 Ying Fang <fangying1@huawei.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the CPUCacheInfo structure to hold CPU cache information for ARM cpus.
A classic three level cache topology is used here. The default cache
capacity is given and userspace can overwrite these values.

Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 target/arm/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h | 27 +++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c179e0752d..efa8e1974a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -27,6 +27,7 @@
 #include "qapi/visitor.h"
 #include "cpu.h"
 #include "internals.h"
+#include "qemu/units.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #if !defined(CONFIG_USER_ONLY)
@@ -998,6 +999,45 @@ uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz)
     return (Aff1 << ARM_AFF1_SHIFT) | Aff0;
 }
 
+static CPUCaches default_cache_info = {
+    .l1d_cache = &(CPUCacheInfo) {
+    .type = DATA_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .sets = 256,
+        .attributes = 0x02,
+    },
+    .l1i_cache = &(CPUCacheInfo) {
+        .type = INSTRUCTION_CACHE,
+        .level = 1,
+        .size = 64 * KiB,
+        .line_size = 64,
+        .associativity = 4,
+        .sets = 256,
+        .attributes = 0x04,
+    },
+    .l2_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 2,
+        .size = 512 * KiB,
+        .line_size = 64,
+        .associativity = 8,
+        .sets = 1024,
+        .attributes = 0x0a,
+    },
+    .l3_cache = &(CPUCacheInfo) {
+        .type = UNIFIED_CACHE,
+        .level = 3,
+        .size = 65536 * KiB,
+        .line_size = 64,
+        .associativity = 15,
+        .sets = 2048,
+        .attributes = 0x0a,
+    },
+};
+
 static void cpreg_hashtable_data_destroy(gpointer data)
 {
     /*
@@ -1835,6 +1875,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
+    cpu->caches = default_cache_info;
+
     qemu_init_vcpu(cs);
     cpu_reset(cs);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a1c7d8ebae..e9e3817e20 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -745,6 +745,30 @@ typedef enum ARMPSCIState {
 
 typedef struct ARMISARegisters ARMISARegisters;
 
+/* Cache information type */
+enum CacheType {
+    DATA_CACHE,
+    INSTRUCTION_CACHE,
+    UNIFIED_CACHE
+};
+
+typedef struct CPUCacheInfo {
+    enum CacheType type;      /* Cache Type*/
+    uint8_t level;
+    uint32_t size;            /* Size in bytes */
+    uint16_t line_size;       /* Line size in bytes */
+    uint8_t associativity;    /* Cache associativity */
+    uint32_t sets;            /* Number of sets */
+    uint8_t attributes;       /* Cache attributest  */
+} CPUCacheInfo;
+
+typedef struct CPUCaches {
+        CPUCacheInfo *l1d_cache;
+        CPUCacheInfo *l1i_cache;
+        CPUCacheInfo *l2_cache;
+        CPUCacheInfo *l3_cache;
+} CPUCaches;
+
 /**
  * ARMCPU:
  * @env: #CPUARMState
@@ -986,6 +1010,9 @@ struct ARMCPU {
 
     /* Generic timer counter frequency, in Hz */
     uint64_t gt_cntfrq_hz;
+
+    /* CPU cache information */
+    CPUCaches caches;
 };
 
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
-- 
2.23.0



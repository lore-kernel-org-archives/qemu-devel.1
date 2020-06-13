Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB80C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F173C20789
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F173C20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkDzN-0000H2-7t
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDxA-0005IW-Fe; Sat, 13 Jun 2020 17:44:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3774 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDx8-00036Y-LS; Sat, 13 Jun 2020 17:44:40 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3F683E6CF56D9F5BF53F;
 Sun, 14 Jun 2020 05:44:35 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:44:29 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 03/22] arm/cpuhp: Add common cpu utility for possible vcpus
Date: Sat, 13 Jun 2020 22:36:10 +0100
Message-ID: <20200613213629.21984-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.30.60]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 17:44:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, drjones@redhat.com, sudeep.holla@arm.com,
 gshan@redhat.com, mst@redhat.com, jiakernel2@gmail.com, maz@kernel.org,
 zhukeqian1@huawei.com, david@redhat.com, richard.henderson@linaro.org,
 linuxarm@huawei.com, eric.auger@redhat.com, james.morse@arm.com,
 catalin.marinas@arm.com, imammedo@redhat.com,
 Salil Mehta <salil.mehta@huawei.com>, pbonzini@redhat.com,
 mehta.salil.lnk@gmail.com, maran.wilson@oracle.com, will@kernel.org,
 wangxiongfeng2@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adds various utility functions which might be required to fetch or check the
state of the possible vcpus. This also introduces concept of *disabled* vcpus,
which are part of the *possible* vcpus but are not part of the *present* vcpu.
This state shall be used during machine init time to check the presence of
vcpus.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 cpus-common.c         | 20 ++++++++++++++++++++
 include/hw/core/cpu.h | 21 +++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/cpus-common.c b/cpus-common.c
index 70a9d12981..7cf900289b 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -23,6 +23,7 @@
 #include "hw/core/cpu.h"
 #include "sysemu/cpus.h"
 #include "qemu/lockable.h"
+#include "hw/boards.h"
 
 static QemuMutex qemu_cpu_list_lock;
 static QemuCond exclusive_cond;
@@ -82,6 +83,25 @@ void cpu_list_add(CPUState *cpu)
         assert(!cpu_index_auto_assigned);
     }
     QTAILQ_INSERT_TAIL_RCU(&cpus, cpu, node);
+    qemu_mutex_unlock(&qemu_cpu_list_lock);
+}
+
+CPUState *qemu_get_possible_cpu(int index)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const CPUArchIdList *possible_cpus = ms->possible_cpus;
+    CPUState *cpu;
+
+    assert((index >= 0) && (index < possible_cpus->len));
+
+    cpu = CPU(possible_cpus->cpus[index].cpu);
+
+    return cpu;
+}
+
+bool qemu_present_cpu(CPUState *cpu)
+{
+    return (cpu && !cpu->disabled);
 }
 
 void cpu_list_remove(CPUState *cpu)
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 497600c49e..d9cae71ea5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -419,6 +419,7 @@ struct CPUState {
 
     GArray *plugin_mem_cbs;
 
+    bool disabled;
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
     int cluster_index;
@@ -802,6 +803,26 @@ static inline bool cpu_in_exclusive_context(const CPUState *cpu)
  */
 CPUState *qemu_get_cpu(int index);
 
+/**
+ * qemu_get_possible_cpu:
+ * @index: The CPUState@cpu_index value of the CPU to obtain.
+ *
+ * Gets a CPU matching @index.
+ *
+ * Returns: The possible CPU or %NULL if there is no matching CPU.
+ */
+CPUState *qemu_get_possible_cpu(int index);
+
+/**
+ * qemu_present_cpu:
+ * @cpu: The vCPU to check
+ *
+ * Checks if the vcpu is amongst the present possible vcpus.
+ *
+ * Returns: True if it is present possible vcpu else false
+ */
+bool qemu_present_cpu(CPUState *cpu);
+
 /**
  * cpu_exists:
  * @id: Guest-exposed CPU ID to lookup.
-- 
2.17.1




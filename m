Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E054AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:48:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF4C20789
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF4C20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkE0h-0001w9-Q9
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDx5-00058v-LT; Sat, 13 Jun 2020 17:44:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60464 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDx3-00035a-Qu; Sat, 13 Jun 2020 17:44:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 2414FF40CEBE9F8A1DDE;
 Sun, 14 Jun 2020 05:44:25 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:44:17 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 01/22] arm/cpuhp: Add QMP vcpu params validation support
Date: Sat, 13 Jun 2020 22:36:08 +0100
Message-ID: <20200613213629.21984-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20200613213629.21984-1-salil.mehta@huawei.com>
References: <20200613213629.21984-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.30.60]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=salil.mehta@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/13 17:44:26
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

For now, vcpu hotplug is only supported with single socket single thread,
single die. NUMA is not supported either and everthing falls into single
node. Work to properly support these could be taken later once community
agrees with the base framework changes being presented to support ARM vcpu
hotplug in QEMU. Hence, these checks.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 37462a6f78..5d1afdd031 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2201,6 +2201,46 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static void virt_smp_parse(MachineState *ms, QemuOpts *opts)
+{
+    if (opts) {
+        unsigned cpus    = qemu_opt_get_number(opts, "cpus", 1);
+        unsigned sockets = qemu_opt_get_number(opts, "sockets", 1);
+        unsigned cores   = qemu_opt_get_number(opts, "cores", cpus);
+        unsigned threads = qemu_opt_get_number(opts, "threads", 1);
+        unsigned int max_cpus;
+
+        if (sockets > 1 || threads > 1) {
+            error_report("does not support more than one socket or thread");
+            exit(1);
+        }
+
+        if (cores != cpus) {
+            error_report("cpu topology: "
+                         "sockets (%u) * cores (%u) * threads (%u) < "
+                         "smp_cpus (%u)",
+                         sockets, cores, threads, cpus);
+            exit(1);
+        }
+
+        max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
+        if (sockets * cores * threads > max_cpus) {
+            error_report("cpu topology: "
+                         "sockets (%u) * cores (%u) * threads (%u) > "
+                         "maxcpus (%u)",
+                         sockets, cores, threads,
+                         max_cpus);
+            exit(1);
+        }
+
+        ms->smp.max_cpus = max_cpus;
+        ms->smp.sockets = sockets;
+        ms->smp.cpus = cpus;
+        ms->smp.cores = cores;
+        ms->smp.threads = threads;
+    }
+}
+
 /*
  * for arm64 kvm_type [7-0] encodes the requested number of bits
  * in the IPA address space
@@ -2266,6 +2306,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     mc->nvdimm_supported = true;
     mc->auto_enable_numa_with_memhp = true;
     mc->default_ram_id = "mach-virt.ram";
+    mc->smp_parse = virt_smp_parse;
 
     object_class_property_add(oc, "acpi", "OnOffAuto",
         virt_get_acpi, virt_set_acpi,
-- 
2.17.1




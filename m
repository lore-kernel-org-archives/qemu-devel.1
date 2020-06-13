Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3D7C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBD120792
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 21:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBD120792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkE8i-0000FI-Rw
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 17:56:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDyF-0007EN-71; Sat, 13 Jun 2020 17:45:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3777 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1jkDyD-0003Lc-39; Sat, 13 Jun 2020 17:45:46 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3739E75CD75FBCF2EC6D;
 Sun, 14 Jun 2020 05:45:41 +0800 (CST)
Received: from A190218597.china.huawei.com (10.47.30.60) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Sun, 14 Jun 2020 05:45:34 +0800
From: Salil Mehta <salil.mehta@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: [PATCH RFC 14/22] arm/cpuhp: Release objects for *disabled* possible
 vcpus after init
Date: Sat, 13 Jun 2020 22:36:21 +0100
Message-ID: <20200613213629.21984-15-salil.mehta@huawei.com>
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

During machvirt_init(), ARMCPU objects are pre-created along with the
corresponding KVM vcpus in the host. Disabled possible KVM vcpus are then
parked at the per-virt-machine list "kvm_parked_vcpus".

Prime purpose to pre-create ARMCPU objects for the disabled vcpus is to
facilitate the GIC initialization (pre-sized with possible vcpus). GIC
requires all vcpus corresponding to its GICC(GIC CPU Interface) to be
initialized and present during its own initialization.

After initialization of the machine is complete we release the ARMCPU objects
for the disabled vcpus(which shall be re-created at the time when vcpu is hot
plugged again. This newly created ARMCPU object is then attached with
corresponding parked KVM VCPU).

We have few options after the machine init where the disabled ARMCPU object
could be released:
1. Release in context to the virt_machine_done() notifier.(This is also our
   current approach)
2. Defer the release till a new vcpu object is hot plugged. Then release the
   object in context to the pre_plug() phase.
3. Never release and keep on reusing them and release once at VM exit. This
   will require some modifications within the interface of qdevice_add() to
   get old ARMCPU object instead of creating a new one for the hotplug request.

Each of the above approaches come with their own pros and cons. This prototype
uses the 1st approach.(suggestions are welcome!)

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e9ead0e2dd..0faf54aa8f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1403,6 +1403,28 @@ static void create_secure_ram(VirtMachineState *vms,
     g_free(nodename);
 }
 
+static void virt_remove_disabled_cpus(VirtMachineState *vms)
+{
+    MachineState *ms = MACHINE(vms);
+    int n;
+
+    /*
+     * RFC: Question: Other approach could have been to keep them forever
+     * and release it only once when qemu exits as part o finalize or when
+     * new vcpu is hotplugged. In the later old could be released for the
+     * newly created object for the same vcpu?
+     */
+    for (n = vms->smp_cpus; n < vms->max_cpus; n++) {
+        CPUState *cs = qemu_get_possible_cpu(n);
+        if (!qemu_present_cpu(cs)) {
+            CPUArchId *cpu_slot;
+            cpu_slot = virt_find_cpu_slot(ms, cs->cpu_index);
+            cpu_slot->cpu = NULL;
+            object_unref(OBJECT(cs));
+        }
+    }
+}
+
 static bool virt_pmu_init(VirtMachineState *vms)
 {
     CPUArchIdList *possible_cpus = vms->parent.possible_cpus;
@@ -1500,6 +1522,9 @@ void virt_machine_done(Notifier *notifier, void *data)
 
     virt_acpi_setup(vms);
     virt_build_smbios(vms);
+
+    /* release the disabled ARMCPU objects used during init for pre-sizing */
+     virt_remove_disabled_cpus(vms);
 }
 
 static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
-- 
2.17.1




Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AF7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D873A221ED
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 12:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wz/CvopY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D873A221ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFcny-0002q3-P1
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 08:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFcTW-0001lr-FS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:11:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34127
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kFcT0-0005iO-Np
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 08:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599567078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qV4OpkwjvjtFbYGKtwH9bvK7lpdb5UZTtRBiWyT+H8g=;
 b=Wz/CvopY6Bu7LGop4ARZrXgt6BZ9g7q9dIiRZL+5xsRRG/DhPQSsLYsTcP/ye+cUrYIOqS
 POE+4xYLpw+kXQsgMRe1/mhUffNlFDZlrag4qT1KL/1iBif0lLvtR/TmCwVKqIutswGUSj
 GWtvq67OjCVdVHpTIFiT2pdqLNT8k8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-JQrus-5UPCmn1R8yh-0dBw-1; Tue, 08 Sep 2020 08:11:14 -0400
X-MC-Unique: JQrus-5UPCmn1R8yh-0dBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08B98800466;
 Tue,  8 Sep 2020 12:11:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34E54811B8;
 Tue,  8 Sep 2020 12:11:04 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2FD1531F73; Tue,  8 Sep 2020 14:10:51 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 15/21] x86: move cpu hotplug from pc to x86
Date: Tue,  8 Sep 2020 14:10:44 +0200
Message-Id: <20200908121050.1162-16-kraxel@redhat.com>
In-Reply-To: <20200908121050.1162-1-kraxel@redhat.com>
References: <20200908121050.1162-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The cpu hotplug code handles the initialization of coldplugged cpus
too, so it is needed even in case cpu hotplug is not supported.

Move the code from pc to x86, so microvm can use it.

Move both plug and unplug to keep everything in one place, even
though microvm needs plug only.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
---
 include/hw/i386/x86.h |  10 ++
 hw/i386/pc.c          | 281 +-----------------------------------------
 hw/i386/x86.c         | 271 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+), 276 deletions(-)

diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index 9d6effc48971..07c466c8e4b4 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -93,6 +93,16 @@ CpuInstanceProperties x86_cpu_index_to_props(MachineState *ms,
                                              unsigned cpu_index);
 int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
 const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms);
+CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx);
+void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
+void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
+                      DeviceState *dev, Error **errp);
+void x86_cpu_plug(HotplugHandler *hotplug_dev,
+                  DeviceState *dev, Error **errp);
+void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp);
+void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
+                       DeviceState *dev, Error **errp);
 
 void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index a18140421e92..b55369357e5d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -803,19 +803,6 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
     }
 }
 
-static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
-{
-    if (cpus_count > 0xff) {
-        /* If the number of CPUs can't be represented in 8 bits, the
-         * BIOS must use "FW_CFG_NB_CPUS". Set RTC field to 0 just
-         * to make old BIOSes fail more predictably.
-         */
-        rtc_set_memory(rtc, 0x5f, 0);
-    } else {
-        rtc_set_memory(rtc, 0x5f, cpus_count - 1);
-    }
-}
-
 static
 void pc_machine_done(Notifier *notifier, void *data)
 {
@@ -825,7 +812,7 @@ void pc_machine_done(Notifier *notifier, void *data)
     PCIBus *bus = pcms->bus;
 
     /* set the number of CPUs */
-    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
+    x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
 
     if (bus) {
         int extra_hosts = 0;
@@ -1373,264 +1360,6 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
     error_propagate(errp, local_err);
 }
 
-static int pc_apic_cmp(const void *a, const void *b)
-{
-   CPUArchId *apic_a = (CPUArchId *)a;
-   CPUArchId *apic_b = (CPUArchId *)b;
-
-   return apic_a->arch_id - apic_b->arch_id;
-}
-
-/* returns pointer to CPUArchId descriptor that matches CPU's apic_id
- * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
- * entry corresponding to CPU's apic_id returns NULL.
- */
-static CPUArchId *pc_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
-{
-    CPUArchId apic_id, *found_cpu;
-
-    apic_id.arch_id = id;
-    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
-        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
-        pc_apic_cmp);
-    if (found_cpu && idx) {
-        *idx = found_cpu - ms->possible_cpus->cpus;
-    }
-    return found_cpu;
-}
-
-static void pc_cpu_plug(HotplugHandler *hotplug_dev,
-                        DeviceState *dev, Error **errp)
-{
-    CPUArchId *found_cpu;
-    Error *local_err = NULL;
-    X86CPU *cpu = X86_CPU(dev);
-    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-
-    if (x86ms->acpi_dev) {
-        hotplug_handler_plug(x86ms->acpi_dev, dev, &local_err);
-        if (local_err) {
-            goto out;
-        }
-    }
-
-    /* increment the number of CPUs */
-    x86ms->boot_cpus++;
-    if (x86ms->rtc) {
-        rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
-    }
-    if (x86ms->fw_cfg) {
-        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
-    }
-
-    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
-    found_cpu->cpu = OBJECT(dev);
-out:
-    error_propagate(errp, local_err);
-}
-static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
-                                     DeviceState *dev, Error **errp)
-{
-    int idx = -1;
-    X86CPU *cpu = X86_CPU(dev);
-    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-
-    if (!x86ms->acpi_dev) {
-        error_setg(errp, "CPU hot unplug not supported without ACPI");
-        return;
-    }
-
-    pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
-    assert(idx != -1);
-    if (idx == 0) {
-        error_setg(errp, "Boot CPU is unpluggable");
-        return;
-    }
-
-    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
-                                   errp);
-}
-
-static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
-                             DeviceState *dev, Error **errp)
-{
-    CPUArchId *found_cpu;
-    Error *local_err = NULL;
-    X86CPU *cpu = X86_CPU(dev);
-    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-
-    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
-    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
-    found_cpu->cpu = NULL;
-    qdev_unrealize(dev);
-
-    /* decrement the number of CPUs */
-    x86ms->boot_cpus--;
-    /* Update the number of CPUs in CMOS */
-    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
-    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
- out:
-    error_propagate(errp, local_err);
-}
-
-static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
-                            DeviceState *dev, Error **errp)
-{
-    int idx;
-    CPUState *cs;
-    CPUArchId *cpu_slot;
-    X86CPUTopoIDs topo_ids;
-    X86CPU *cpu = X86_CPU(dev);
-    CPUX86State *env = &cpu->env;
-    MachineState *ms = MACHINE(hotplug_dev);
-    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
-    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
-    unsigned int smp_cores = ms->smp.cores;
-    unsigned int smp_threads = ms->smp.threads;
-    X86CPUTopoInfo topo_info;
-
-    if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
-        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
-                   ms->cpu_type);
-        return;
-    }
-
-    init_topo_info(&topo_info, x86ms);
-
-    env->nr_dies = x86ms->smp_dies;
-
-    /*
-     * If APIC ID is not set,
-     * set it based on socket/die/core/thread properties.
-     */
-    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
-        int max_socket = (ms->smp.max_cpus - 1) /
-                                smp_threads / smp_cores / x86ms->smp_dies;
-
-        /*
-         * die-id was optional in QEMU 4.0 and older, so keep it optional
-         * if there's only one die per socket.
-         */
-        if (cpu->die_id < 0 && x86ms->smp_dies == 1) {
-            cpu->die_id = 0;
-        }
-
-        if (cpu->socket_id < 0) {
-            error_setg(errp, "CPU socket-id is not set");
-            return;
-        } else if (cpu->socket_id > max_socket) {
-            error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
-                       cpu->socket_id, max_socket);
-            return;
-        }
-        if (cpu->die_id < 0) {
-            error_setg(errp, "CPU die-id is not set");
-            return;
-        } else if (cpu->die_id > x86ms->smp_dies - 1) {
-            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
-                       cpu->die_id, x86ms->smp_dies - 1);
-            return;
-        }
-        if (cpu->core_id < 0) {
-            error_setg(errp, "CPU core-id is not set");
-            return;
-        } else if (cpu->core_id > (smp_cores - 1)) {
-            error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
-                       cpu->core_id, smp_cores - 1);
-            return;
-        }
-        if (cpu->thread_id < 0) {
-            error_setg(errp, "CPU thread-id is not set");
-            return;
-        } else if (cpu->thread_id > (smp_threads - 1)) {
-            error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
-                       cpu->thread_id, smp_threads - 1);
-            return;
-        }
-
-        topo_ids.pkg_id = cpu->socket_id;
-        topo_ids.die_id = cpu->die_id;
-        topo_ids.core_id = cpu->core_id;
-        topo_ids.smt_id = cpu->thread_id;
-        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
-    }
-
-    cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
-    if (!cpu_slot) {
-        MachineState *ms = MACHINE(pcms);
-
-        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
-        error_setg(errp,
-            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
-            " APIC ID %" PRIu32 ", valid index range 0:%d",
-            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
-            cpu->apic_id, ms->possible_cpus->len - 1);
-        return;
-    }
-
-    if (cpu_slot->cpu) {
-        error_setg(errp, "CPU[%d] with APIC ID %" PRIu32 " exists",
-                   idx, cpu->apic_id);
-        return;
-    }
-
-    /* if 'address' properties socket-id/core-id/thread-id are not set, set them
-     * so that machine_query_hotpluggable_cpus would show correct values
-     */
-    /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
-     * once -smp refactoring is complete and there will be CPU private
-     * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
-    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
-    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
-        error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
-            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
-            topo_ids.pkg_id);
-        return;
-    }
-    cpu->socket_id = topo_ids.pkg_id;
-
-    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
-        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
-            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
-        return;
-    }
-    cpu->die_id = topo_ids.die_id;
-
-    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
-        error_setg(errp, "property core-id: %u doesn't match set apic-id:"
-            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
-            topo_ids.core_id);
-        return;
-    }
-    cpu->core_id = topo_ids.core_id;
-
-    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
-        error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
-            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
-            topo_ids.smt_id);
-        return;
-    }
-    cpu->thread_id = topo_ids.smt_id;
-
-    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
-        !kvm_hv_vpindex_settable()) {
-        error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
-        return;
-    }
-
-    cs = CPU(cpu);
-    cs->cpu_index = idx;
-
-    numa_cpu_pre_plug(cpu_slot, dev, errp);
-}
-
 static void pc_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
@@ -1699,7 +1428,7 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_pre_plug(hotplug_dev, dev, errp);
+        x86_cpu_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
                object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
         pc_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
@@ -1712,7 +1441,7 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_plug(hotplug_dev, dev, errp);
+        x86_cpu_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
                object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
         pc_virtio_md_pci_plug(hotplug_dev, dev, errp);
@@ -1725,7 +1454,7 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_unplug_request(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
+        x86_cpu_unplug_request_cb(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
                object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
         pc_virtio_md_pci_unplug_request(hotplug_dev, dev, errp);
@@ -1741,7 +1470,7 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_unplug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
-        pc_cpu_unplug_cb(hotplug_dev, dev, errp);
+        x86_cpu_unplug_cb(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
                object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
         pc_virtio_md_pci_unplug(hotplug_dev, dev, errp);
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index e2a5005f389c..c2ea989579c9 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -41,6 +41,7 @@
 #include "hw/i386/topology.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/intc/i8259.h"
+#include "hw/rtc/mc146818rtc.h"
 
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/irq.h"
@@ -137,6 +138,276 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
     }
 }
 
+void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
+{
+    if (cpus_count > 0xff) {
+        /*
+         * If the number of CPUs can't be represented in 8 bits, the
+         * BIOS must use "FW_CFG_NB_CPUS". Set RTC field to 0 just
+         * to make old BIOSes fail more predictably.
+         */
+        rtc_set_memory(rtc, 0x5f, 0);
+    } else {
+        rtc_set_memory(rtc, 0x5f, cpus_count - 1);
+    }
+}
+
+static int x86_apic_cmp(const void *a, const void *b)
+{
+   CPUArchId *apic_a = (CPUArchId *)a;
+   CPUArchId *apic_b = (CPUArchId *)b;
+
+   return apic_a->arch_id - apic_b->arch_id;
+}
+
+/*
+ * returns pointer to CPUArchId descriptor that matches CPU's apic_id
+ * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
+ * entry corresponding to CPU's apic_id returns NULL.
+ */
+CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
+{
+    CPUArchId apic_id, *found_cpu;
+
+    apic_id.arch_id = id;
+    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
+        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
+        x86_apic_cmp);
+    if (found_cpu && idx) {
+        *idx = found_cpu - ms->possible_cpus->cpus;
+    }
+    return found_cpu;
+}
+
+void x86_cpu_plug(HotplugHandler *hotplug_dev,
+                  DeviceState *dev, Error **errp)
+{
+    CPUArchId *found_cpu;
+    Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
+
+    if (x86ms->acpi_dev) {
+        hotplug_handler_plug(x86ms->acpi_dev, dev, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
+    /* increment the number of CPUs */
+    x86ms->boot_cpus++;
+    if (x86ms->rtc) {
+        x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
+    }
+    if (x86ms->fw_cfg) {
+        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
+    }
+
+    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
+    found_cpu->cpu = OBJECT(dev);
+out:
+    error_propagate(errp, local_err);
+}
+
+void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    int idx = -1;
+    X86CPU *cpu = X86_CPU(dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
+
+    if (!x86ms->acpi_dev) {
+        error_setg(errp, "CPU hot unplug not supported without ACPI");
+        return;
+    }
+
+    x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
+    assert(idx != -1);
+    if (idx == 0) {
+        error_setg(errp, "Boot CPU is unpluggable");
+        return;
+    }
+
+    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
+                                   errp);
+}
+
+void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
+                       DeviceState *dev, Error **errp)
+{
+    CPUArchId *found_cpu;
+    Error *local_err = NULL;
+    X86CPU *cpu = X86_CPU(dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
+
+    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
+    found_cpu->cpu = NULL;
+    qdev_unrealize(dev);
+
+    /* decrement the number of CPUs */
+    x86ms->boot_cpus--;
+    /* Update the number of CPUs in CMOS */
+    x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
+    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
+ out:
+    error_propagate(errp, local_err);
+}
+
+void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
+                      DeviceState *dev, Error **errp)
+{
+    int idx;
+    CPUState *cs;
+    CPUArchId *cpu_slot;
+    X86CPUTopoIDs topo_ids;
+    X86CPU *cpu = X86_CPU(dev);
+    CPUX86State *env = &cpu->env;
+    MachineState *ms = MACHINE(hotplug_dev);
+    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
+    unsigned int smp_cores = ms->smp.cores;
+    unsigned int smp_threads = ms->smp.threads;
+    X86CPUTopoInfo topo_info;
+
+    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
+        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
+                   ms->cpu_type);
+        return;
+    }
+
+    init_topo_info(&topo_info, x86ms);
+
+    env->nr_dies = x86ms->smp_dies;
+
+    /*
+     * If APIC ID is not set,
+     * set it based on socket/die/core/thread properties.
+     */
+    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
+        int max_socket = (ms->smp.max_cpus - 1) /
+                                smp_threads / smp_cores / x86ms->smp_dies;
+
+        /*
+         * die-id was optional in QEMU 4.0 and older, so keep it optional
+         * if there's only one die per socket.
+         */
+        if (cpu->die_id < 0 && x86ms->smp_dies == 1) {
+            cpu->die_id = 0;
+        }
+
+        if (cpu->socket_id < 0) {
+            error_setg(errp, "CPU socket-id is not set");
+            return;
+        } else if (cpu->socket_id > max_socket) {
+            error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
+                       cpu->socket_id, max_socket);
+            return;
+        }
+        if (cpu->die_id < 0) {
+            error_setg(errp, "CPU die-id is not set");
+            return;
+        } else if (cpu->die_id > x86ms->smp_dies - 1) {
+            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
+                       cpu->die_id, x86ms->smp_dies - 1);
+            return;
+        }
+        if (cpu->core_id < 0) {
+            error_setg(errp, "CPU core-id is not set");
+            return;
+        } else if (cpu->core_id > (smp_cores - 1)) {
+            error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
+                       cpu->core_id, smp_cores - 1);
+            return;
+        }
+        if (cpu->thread_id < 0) {
+            error_setg(errp, "CPU thread-id is not set");
+            return;
+        } else if (cpu->thread_id > (smp_threads - 1)) {
+            error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
+                       cpu->thread_id, smp_threads - 1);
+            return;
+        }
+
+        topo_ids.pkg_id = cpu->socket_id;
+        topo_ids.die_id = cpu->die_id;
+        topo_ids.core_id = cpu->core_id;
+        topo_ids.smt_id = cpu->thread_id;
+        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
+    }
+
+    cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
+    if (!cpu_slot) {
+        MachineState *ms = MACHINE(x86ms);
+
+        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+        error_setg(errp,
+            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
+            " APIC ID %" PRIu32 ", valid index range 0:%d",
+            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
+            cpu->apic_id, ms->possible_cpus->len - 1);
+        return;
+    }
+
+    if (cpu_slot->cpu) {
+        error_setg(errp, "CPU[%d] with APIC ID %" PRIu32 " exists",
+                   idx, cpu->apic_id);
+        return;
+    }
+
+    /* if 'address' properties socket-id/core-id/thread-id are not set, set them
+     * so that machine_query_hotpluggable_cpus would show correct values
+     */
+    /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
+     * once -smp refactoring is complete and there will be CPU private
+     * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
+    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
+        error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
+            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
+            topo_ids.pkg_id);
+        return;
+    }
+    cpu->socket_id = topo_ids.pkg_id;
+
+    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
+        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
+            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
+        return;
+    }
+    cpu->die_id = topo_ids.die_id;
+
+    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
+        error_setg(errp, "property core-id: %u doesn't match set apic-id:"
+            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
+            topo_ids.core_id);
+        return;
+    }
+    cpu->core_id = topo_ids.core_id;
+
+    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
+        error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
+            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
+            topo_ids.smt_id);
+        return;
+    }
+    cpu->thread_id = topo_ids.smt_id;
+
+    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
+        !kvm_hv_vpindex_settable()) {
+        error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
+        return;
+    }
+
+    cs = CPU(cpu);
+    cs->cpu_index = idx;
+
+    numa_cpu_pre_plug(cpu_slot, dev, errp);
+}
+
 CpuInstanceProperties
 x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
 {
-- 
2.27.0



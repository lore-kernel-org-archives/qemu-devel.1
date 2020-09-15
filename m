Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5743CC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73CCB20829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHSOTQ5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CCB20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAcf-0002JE-Be
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIAVR-0002jS-4x
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:56:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39999
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kIAVL-0005I1-Ic
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600174574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfVq4fVryddyA9qXrrnlHXWZCtP8+jGyF9qDy+6QR7E=;
 b=cHSOTQ5wnpqeiEPj547+1i2lXT+oPTMnGt9bHX2nO13YH/qSTsvuI3QQngWX1y6HHvl+22
 36QTx0cqahL993NKPtc+j0VKSzCCzr7DCjw8pyCYYX5hINFY6AddlZmKg+NAI7YYo45snf
 A7IuKel+wJLYGp2LrM45HjrD3xlV+1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-t-hPWSa_Pp2Ae_snZeTlQw-1; Tue, 15 Sep 2020 08:56:13 -0400
X-MC-Unique: t-hPWSa_Pp2Ae_snZeTlQw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 933EE81F00A;
 Tue, 15 Sep 2020 12:56:11 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D73561982;
 Tue, 15 Sep 2020 12:56:00 +0000 (UTC)
Date: Tue, 15 Sep 2020 14:55:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v8 15/21] x86: move cpu hotplug from pc to x86
Message-ID: <20200915145559.73a86b08@redhat.com>
In-Reply-To: <20200915120909.20838-16-kraxel@redhat.com>
References: <20200915120909.20838-1-kraxel@redhat.com>
 <20200915120909.20838-16-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 05:35:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Sep 2020 14:09:03 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> The cpu hotplug code handles the initialization of coldplugged cpus
> too, so it is needed even in case cpu hotplug is not supported.
> 
> Move the code from pc to x86, so microvm can use it.
> 
> Move both plug and unplug to keep everything in one place, even
> though microvm needs plug only.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/x86.h |  10 ++
>  hw/i386/pc.c          | 281 +-----------------------------------------
>  hw/i386/x86.c         | 271 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+), 276 deletions(-)
> 
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index f540e801a837..0eef9fb0c0d7 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -92,6 +92,16 @@ CpuInstanceProperties x86_cpu_index_to_props(MachineState *ms,
>                                               unsigned cpu_index);
>  int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx);
>  const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms);
> +CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx);
> +void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count);
> +void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> +                      DeviceState *dev, Error **errp);
> +void x86_cpu_plug(HotplugHandler *hotplug_dev,
> +                  DeviceState *dev, Error **errp);
> +void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                               DeviceState *dev, Error **errp);
> +void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
> +                       DeviceState *dev, Error **errp);
>  
>  void x86_bios_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw);
>  
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index a18140421e92..b55369357e5d 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -803,19 +803,6 @@ void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
>      }
>  }
>  
> -static void rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
> -{
> -    if (cpus_count > 0xff) {
> -        /* If the number of CPUs can't be represented in 8 bits, the
> -         * BIOS must use "FW_CFG_NB_CPUS". Set RTC field to 0 just
> -         * to make old BIOSes fail more predictably.
> -         */
> -        rtc_set_memory(rtc, 0x5f, 0);
> -    } else {
> -        rtc_set_memory(rtc, 0x5f, cpus_count - 1);
> -    }
> -}
> -
>  static
>  void pc_machine_done(Notifier *notifier, void *data)
>  {
> @@ -825,7 +812,7 @@ void pc_machine_done(Notifier *notifier, void *data)
>      PCIBus *bus = pcms->bus;
>  
>      /* set the number of CPUs */
> -    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> +    x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
>  
>      if (bus) {
>          int extra_hosts = 0;
> @@ -1373,264 +1360,6 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
>      error_propagate(errp, local_err);
>  }
>  
> -static int pc_apic_cmp(const void *a, const void *b)
> -{
> -   CPUArchId *apic_a = (CPUArchId *)a;
> -   CPUArchId *apic_b = (CPUArchId *)b;
> -
> -   return apic_a->arch_id - apic_b->arch_id;
> -}
> -
> -/* returns pointer to CPUArchId descriptor that matches CPU's apic_id
> - * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
> - * entry corresponding to CPU's apic_id returns NULL.
> - */
> -static CPUArchId *pc_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
> -{
> -    CPUArchId apic_id, *found_cpu;
> -
> -    apic_id.arch_id = id;
> -    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
> -        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
> -        pc_apic_cmp);
> -    if (found_cpu && idx) {
> -        *idx = found_cpu - ms->possible_cpus->cpus;
> -    }
> -    return found_cpu;
> -}
> -
> -static void pc_cpu_plug(HotplugHandler *hotplug_dev,
> -                        DeviceState *dev, Error **errp)
> -{
> -    CPUArchId *found_cpu;
> -    Error *local_err = NULL;
> -    X86CPU *cpu = X86_CPU(dev);
> -    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> -    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> -
> -    if (x86ms->acpi_dev) {
> -        hotplug_handler_plug(x86ms->acpi_dev, dev, &local_err);
> -        if (local_err) {
> -            goto out;
> -        }
> -    }
> -
> -    /* increment the number of CPUs */
> -    x86ms->boot_cpus++;
> -    if (x86ms->rtc) {
> -        rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> -    }
> -    if (x86ms->fw_cfg) {
> -        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
> -    }
> -
> -    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
> -    found_cpu->cpu = OBJECT(dev);
> -out:
> -    error_propagate(errp, local_err);
> -}
> -static void pc_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
> -                                     DeviceState *dev, Error **errp)
> -{
> -    int idx = -1;
> -    X86CPU *cpu = X86_CPU(dev);
> -    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> -    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> -
> -    if (!x86ms->acpi_dev) {
> -        error_setg(errp, "CPU hot unplug not supported without ACPI");
> -        return;
> -    }
> -
> -    pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> -    assert(idx != -1);
> -    if (idx == 0) {
> -        error_setg(errp, "Boot CPU is unpluggable");
> -        return;
> -    }
> -
> -    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
> -                                   errp);
> -}
> -
> -static void pc_cpu_unplug_cb(HotplugHandler *hotplug_dev,
> -                             DeviceState *dev, Error **errp)
> -{
> -    CPUArchId *found_cpu;
> -    Error *local_err = NULL;
> -    X86CPU *cpu = X86_CPU(dev);
> -    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> -    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> -
> -    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
> -    found_cpu = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, NULL);
> -    found_cpu->cpu = NULL;
> -    qdev_unrealize(dev);
> -
> -    /* decrement the number of CPUs */
> -    x86ms->boot_cpus--;
> -    /* Update the number of CPUs in CMOS */
> -    rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> -    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
> - out:
> -    error_propagate(errp, local_err);
> -}
> -
> -static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> -                            DeviceState *dev, Error **errp)
> -{
> -    int idx;
> -    CPUState *cs;
> -    CPUArchId *cpu_slot;
> -    X86CPUTopoIDs topo_ids;
> -    X86CPU *cpu = X86_CPU(dev);
> -    CPUX86State *env = &cpu->env;
> -    MachineState *ms = MACHINE(hotplug_dev);
> -    PCMachineState *pcms = PC_MACHINE(hotplug_dev);
> -    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> -    unsigned int smp_cores = ms->smp.cores;
> -    unsigned int smp_threads = ms->smp.threads;
> -    X86CPUTopoInfo topo_info;
> -
> -    if(!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> -        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> -                   ms->cpu_type);
> -        return;
> -    }
> -
> -    init_topo_info(&topo_info, x86ms);
> -
> -    env->nr_dies = x86ms->smp_dies;
> -
> -    /*
> -     * If APIC ID is not set,
> -     * set it based on socket/die/core/thread properties.
> -     */
> -    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> -        int max_socket = (ms->smp.max_cpus - 1) /
> -                                smp_threads / smp_cores / x86ms->smp_dies;
> -
> -        /*
> -         * die-id was optional in QEMU 4.0 and older, so keep it optional
> -         * if there's only one die per socket.
> -         */
> -        if (cpu->die_id < 0 && x86ms->smp_dies == 1) {
> -            cpu->die_id = 0;
> -        }
> -
> -        if (cpu->socket_id < 0) {
> -            error_setg(errp, "CPU socket-id is not set");
> -            return;
> -        } else if (cpu->socket_id > max_socket) {
> -            error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
> -                       cpu->socket_id, max_socket);
> -            return;
> -        }
> -        if (cpu->die_id < 0) {
> -            error_setg(errp, "CPU die-id is not set");
> -            return;
> -        } else if (cpu->die_id > x86ms->smp_dies - 1) {
> -            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
> -                       cpu->die_id, x86ms->smp_dies - 1);
> -            return;
> -        }
> -        if (cpu->core_id < 0) {
> -            error_setg(errp, "CPU core-id is not set");
> -            return;
> -        } else if (cpu->core_id > (smp_cores - 1)) {
> -            error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
> -                       cpu->core_id, smp_cores - 1);
> -            return;
> -        }
> -        if (cpu->thread_id < 0) {
> -            error_setg(errp, "CPU thread-id is not set");
> -            return;
> -        } else if (cpu->thread_id > (smp_threads - 1)) {
> -            error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
> -                       cpu->thread_id, smp_threads - 1);
> -            return;
> -        }
> -
> -        topo_ids.pkg_id = cpu->socket_id;
> -        topo_ids.die_id = cpu->die_id;
> -        topo_ids.core_id = cpu->core_id;
> -        topo_ids.smt_id = cpu->thread_id;
> -        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
> -    }
> -
> -    cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> -    if (!cpu_slot) {
> -        MachineState *ms = MACHINE(pcms);
> -
> -        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> -        error_setg(errp,
> -            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
> -            " APIC ID %" PRIu32 ", valid index range 0:%d",
> -            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
> -            cpu->apic_id, ms->possible_cpus->len - 1);
> -        return;
> -    }
> -
> -    if (cpu_slot->cpu) {
> -        error_setg(errp, "CPU[%d] with APIC ID %" PRIu32 " exists",
> -                   idx, cpu->apic_id);
> -        return;
> -    }
> -
> -    /* if 'address' properties socket-id/core-id/thread-id are not set, set them
> -     * so that machine_query_hotpluggable_cpus would show correct values
> -     */
> -    /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
> -     * once -smp refactoring is complete and there will be CPU private
> -     * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
> -    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> -    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
> -        error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
> -            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
> -            topo_ids.pkg_id);
> -        return;
> -    }
> -    cpu->socket_id = topo_ids.pkg_id;
> -
> -    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
> -        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
> -            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
> -        return;
> -    }
> -    cpu->die_id = topo_ids.die_id;
> -
> -    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
> -        error_setg(errp, "property core-id: %u doesn't match set apic-id:"
> -            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
> -            topo_ids.core_id);
> -        return;
> -    }
> -    cpu->core_id = topo_ids.core_id;
> -
> -    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
> -        error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
> -            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
> -            topo_ids.smt_id);
> -        return;
> -    }
> -    cpu->thread_id = topo_ids.smt_id;
> -
> -    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
> -        !kvm_hv_vpindex_settable()) {
> -        error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
> -        return;
> -    }
> -
> -    cs = CPU(cpu);
> -    cs->cpu_index = idx;
> -
> -    numa_cpu_pre_plug(cpu_slot, dev, errp);
> -}
> -
>  static void pc_virtio_md_pci_pre_plug(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
> @@ -1699,7 +1428,7 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          pc_memory_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> -        pc_cpu_pre_plug(hotplug_dev, dev, errp);
> +        x86_cpu_pre_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
>                 object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>          pc_virtio_md_pci_pre_plug(hotplug_dev, dev, errp);
> @@ -1712,7 +1441,7 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          pc_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> -        pc_cpu_plug(hotplug_dev, dev, errp);
> +        x86_cpu_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
>                 object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>          pc_virtio_md_pci_plug(hotplug_dev, dev, errp);
> @@ -1725,7 +1454,7 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          pc_memory_unplug_request(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> -        pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
> +        x86_cpu_unplug_request_cb(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
>                 object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>          pc_virtio_md_pci_unplug_request(hotplug_dev, dev, errp);
> @@ -1741,7 +1470,7 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          pc_memory_unplug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> -        pc_cpu_unplug_cb(hotplug_dev, dev, errp);
> +        x86_cpu_unplug_cb(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_PMEM_PCI) ||
>                 object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
>          pc_virtio_md_pci_unplug(hotplug_dev, dev, errp);
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index e2a5005f389c..c2ea989579c9 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -41,6 +41,7 @@
>  #include "hw/i386/topology.h"
>  #include "hw/i386/fw_cfg.h"
>  #include "hw/intc/i8259.h"
> +#include "hw/rtc/mc146818rtc.h"
>  
>  #include "hw/acpi/cpu_hotplug.h"
>  #include "hw/irq.h"
> @@ -137,6 +138,276 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>      }
>  }
>  
> +void x86_rtc_set_cpus_count(ISADevice *rtc, uint16_t cpus_count)
> +{
> +    if (cpus_count > 0xff) {
> +        /*
> +         * If the number of CPUs can't be represented in 8 bits, the
> +         * BIOS must use "FW_CFG_NB_CPUS". Set RTC field to 0 just
> +         * to make old BIOSes fail more predictably.
> +         */
> +        rtc_set_memory(rtc, 0x5f, 0);
> +    } else {
> +        rtc_set_memory(rtc, 0x5f, cpus_count - 1);
> +    }
> +}
> +
> +static int x86_apic_cmp(const void *a, const void *b)
> +{
> +   CPUArchId *apic_a = (CPUArchId *)a;
> +   CPUArchId *apic_b = (CPUArchId *)b;
> +
> +   return apic_a->arch_id - apic_b->arch_id;
> +}
> +
> +/*
> + * returns pointer to CPUArchId descriptor that matches CPU's apic_id
> + * in ms->possible_cpus->cpus, if ms->possible_cpus->cpus has no
> + * entry corresponding to CPU's apic_id returns NULL.
> + */
> +CPUArchId *x86_find_cpu_slot(MachineState *ms, uint32_t id, int *idx)
> +{
> +    CPUArchId apic_id, *found_cpu;
> +
> +    apic_id.arch_id = id;
> +    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
> +        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
> +        x86_apic_cmp);
> +    if (found_cpu && idx) {
> +        *idx = found_cpu - ms->possible_cpus->cpus;
> +    }
> +    return found_cpu;
> +}
> +
> +void x86_cpu_plug(HotplugHandler *hotplug_dev,
> +                  DeviceState *dev, Error **errp)
> +{
> +    CPUArchId *found_cpu;
> +    Error *local_err = NULL;
> +    X86CPU *cpu = X86_CPU(dev);
> +    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> +
> +    if (x86ms->acpi_dev) {
> +        hotplug_handler_plug(x86ms->acpi_dev, dev, &local_err);
> +        if (local_err) {
> +            goto out;
> +        }
> +    }
> +
> +    /* increment the number of CPUs */
> +    x86ms->boot_cpus++;
> +    if (x86ms->rtc) {
> +        x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> +    }
> +    if (x86ms->fw_cfg) {
> +        fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
> +    }
> +
> +    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
> +    found_cpu->cpu = OBJECT(dev);
> +out:
> +    error_propagate(errp, local_err);
> +}
> +
> +void x86_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
> +                               DeviceState *dev, Error **errp)
> +{
> +    int idx = -1;
> +    X86CPU *cpu = X86_CPU(dev);
> +    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> +
> +    if (!x86ms->acpi_dev) {
> +        error_setg(errp, "CPU hot unplug not supported without ACPI");
> +        return;
> +    }
> +
> +    x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
> +    assert(idx != -1);
> +    if (idx == 0) {
> +        error_setg(errp, "Boot CPU is unpluggable");
> +        return;
> +    }
> +
> +    hotplug_handler_unplug_request(x86ms->acpi_dev, dev,
> +                                   errp);
> +}
> +
> +void x86_cpu_unplug_cb(HotplugHandler *hotplug_dev,
> +                       DeviceState *dev, Error **errp)
> +{
> +    CPUArchId *found_cpu;
> +    Error *local_err = NULL;
> +    X86CPU *cpu = X86_CPU(dev);
> +    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> +
> +    hotplug_handler_unplug(x86ms->acpi_dev, dev, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
> +    found_cpu->cpu = NULL;
> +    qdev_unrealize(dev);
> +
> +    /* decrement the number of CPUs */
> +    x86ms->boot_cpus--;
> +    /* Update the number of CPUs in CMOS */
> +    x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
> +    fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
> + out:
> +    error_propagate(errp, local_err);
> +}
> +
> +void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
> +                      DeviceState *dev, Error **errp)
> +{
> +    int idx;
> +    CPUState *cs;
> +    CPUArchId *cpu_slot;
> +    X86CPUTopoIDs topo_ids;
> +    X86CPU *cpu = X86_CPU(dev);
> +    CPUX86State *env = &cpu->env;
> +    MachineState *ms = MACHINE(hotplug_dev);
> +    X86MachineState *x86ms = X86_MACHINE(hotplug_dev);
> +    unsigned int smp_cores = ms->smp.cores;
> +    unsigned int smp_threads = ms->smp.threads;
> +    X86CPUTopoInfo topo_info;
> +
> +    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
> +        error_setg(errp, "Invalid CPU type, expected cpu type: '%s'",
> +                   ms->cpu_type);
> +        return;
> +    }
> +
> +    init_topo_info(&topo_info, x86ms);
> +
> +    env->nr_dies = x86ms->smp_dies;
> +
> +    /*
> +     * If APIC ID is not set,
> +     * set it based on socket/die/core/thread properties.
> +     */
> +    if (cpu->apic_id == UNASSIGNED_APIC_ID) {
> +        int max_socket = (ms->smp.max_cpus - 1) /
> +                                smp_threads / smp_cores / x86ms->smp_dies;
> +
> +        /*
> +         * die-id was optional in QEMU 4.0 and older, so keep it optional
> +         * if there's only one die per socket.
> +         */
> +        if (cpu->die_id < 0 && x86ms->smp_dies == 1) {
> +            cpu->die_id = 0;
> +        }
> +
> +        if (cpu->socket_id < 0) {
> +            error_setg(errp, "CPU socket-id is not set");
> +            return;
> +        } else if (cpu->socket_id > max_socket) {
> +            error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
> +                       cpu->socket_id, max_socket);
> +            return;
> +        }
> +        if (cpu->die_id < 0) {
> +            error_setg(errp, "CPU die-id is not set");
> +            return;
> +        } else if (cpu->die_id > x86ms->smp_dies - 1) {
> +            error_setg(errp, "Invalid CPU die-id: %u must be in range 0:%u",
> +                       cpu->die_id, x86ms->smp_dies - 1);
> +            return;
> +        }
> +        if (cpu->core_id < 0) {
> +            error_setg(errp, "CPU core-id is not set");
> +            return;
> +        } else if (cpu->core_id > (smp_cores - 1)) {
> +            error_setg(errp, "Invalid CPU core-id: %u must be in range 0:%u",
> +                       cpu->core_id, smp_cores - 1);
> +            return;
> +        }
> +        if (cpu->thread_id < 0) {
> +            error_setg(errp, "CPU thread-id is not set");
> +            return;
> +        } else if (cpu->thread_id > (smp_threads - 1)) {
> +            error_setg(errp, "Invalid CPU thread-id: %u must be in range 0:%u",
> +                       cpu->thread_id, smp_threads - 1);
> +            return;
> +        }
> +
> +        topo_ids.pkg_id = cpu->socket_id;
> +        topo_ids.die_id = cpu->die_id;
> +        topo_ids.core_id = cpu->core_id;
> +        topo_ids.smt_id = cpu->thread_id;
> +        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
> +    }
> +
> +    cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
> +    if (!cpu_slot) {
> +        MachineState *ms = MACHINE(x86ms);
> +
> +        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> +        error_setg(errp,
> +            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
> +            " APIC ID %" PRIu32 ", valid index range 0:%d",
> +            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
> +            cpu->apic_id, ms->possible_cpus->len - 1);
> +        return;
> +    }
> +
> +    if (cpu_slot->cpu) {
> +        error_setg(errp, "CPU[%d] with APIC ID %" PRIu32 " exists",
> +                   idx, cpu->apic_id);
> +        return;
> +    }
> +
> +    /* if 'address' properties socket-id/core-id/thread-id are not set, set them
> +     * so that machine_query_hotpluggable_cpus would show correct values
> +     */
> +    /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
> +     * once -smp refactoring is complete and there will be CPU private
> +     * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
> +    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> +    if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
> +        error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
> +            " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
> +            topo_ids.pkg_id);
> +        return;
> +    }
> +    cpu->socket_id = topo_ids.pkg_id;
> +
> +    if (cpu->die_id != -1 && cpu->die_id != topo_ids.die_id) {
> +        error_setg(errp, "property die-id: %u doesn't match set apic-id:"
> +            " 0x%x (die-id: %u)", cpu->die_id, cpu->apic_id, topo_ids.die_id);
> +        return;
> +    }
> +    cpu->die_id = topo_ids.die_id;
> +
> +    if (cpu->core_id != -1 && cpu->core_id != topo_ids.core_id) {
> +        error_setg(errp, "property core-id: %u doesn't match set apic-id:"
> +            " 0x%x (core-id: %u)", cpu->core_id, cpu->apic_id,
> +            topo_ids.core_id);
> +        return;
> +    }
> +    cpu->core_id = topo_ids.core_id;
> +
> +    if (cpu->thread_id != -1 && cpu->thread_id != topo_ids.smt_id) {
> +        error_setg(errp, "property thread-id: %u doesn't match set apic-id:"
> +            " 0x%x (thread-id: %u)", cpu->thread_id, cpu->apic_id,
> +            topo_ids.smt_id);
> +        return;
> +    }
> +    cpu->thread_id = topo_ids.smt_id;
> +
> +    if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
> +        !kvm_hv_vpindex_settable()) {
> +        error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
> +        return;
> +    }
> +
> +    cs = CPU(cpu);
> +    cs->cpu_index = idx;
> +
> +    numa_cpu_pre_plug(cpu_slot, dev, errp);
> +}
> +
>  CpuInstanceProperties
>  x86_cpu_index_to_props(MachineState *ms, unsigned cpu_index)
>  {



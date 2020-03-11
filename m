Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5761AC3F2D0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2215A21D56
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9MHBLow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2215A21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0K1-0001Ak-9n
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40803)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jC0Ik-00009N-0f
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jC0Ii-0004gL-GM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:17:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26710
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jC0Ig-0004fH-7Q
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583929045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8kutPPdDnhdpZuhIIjwUMGj7E3GL18AEkDmzlpfOVk=;
 b=N9MHBLowjt63qyD2RC6gAxkrnOyrg/bQzVIRz9J2f45YWNiA8JxRyx3Tz0Pma61orHlwsd
 t8JR5pikoRw4/jj3FXAvb3p1hFMo+EfJL1TcNtF0wUJAfqCpMOB+ZM/IIDSFViHghWAjIL
 s6y4Nlb8ggWTk2aXk0IV65dAReGzMcc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-5_vO6EoQN5mhId8IwyfHsA-1; Wed, 11 Mar 2020 08:17:22 -0400
X-MC-Unique: 5_vO6EoQN5mhId8IwyfHsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69290100550D;
 Wed, 11 Mar 2020 12:17:20 +0000 (UTC)
Received: from localhost (ovpn-200-57.brq.redhat.com [10.40.200.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7379760E3E;
 Wed, 11 Mar 2020 12:17:15 +0000 (UTC)
Date: Wed, 11 Mar 2020 13:17:12 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 10/13] i386: Check for apic id encoding
Message-ID: <20200311131712.35ac421b@redhat.com>
In-Reply-To: <158389406581.22020.12203992175835061363.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
 <158389406581.22020.12203992175835061363.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020 21:34:25 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Check X86CPUDefinition if use_epyc_apic_id_encoding is enabled. If enabled
> update X86MachineState with EPYC mode apic_id encoding handlers.
> 
> Also update the calling convention to use apic_id handlers from X86MachineState.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
usually tags are not retained in case patch is changed significantly

see more below

> ---
>  hw/i386/pc.c      |    6 +++---
>  hw/i386/x86.c     |   32 +++++++++++++++++++++++++++-----
>  target/i386/cpu.c |   11 +++++++++++
>  target/i386/cpu.h |    1 +
>  4 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 98ee763f68..2d7d611184 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1580,14 +1580,14 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          topo_ids.die_id = cpu->die_id;
>          topo_ids.core_id = cpu->core_id;
>          topo_ids.smt_id = cpu->thread_id;
> -        cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
> +        cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info, &topo_ids);
>      }
>  
>      cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
>      if (!cpu_slot) {
>          MachineState *ms = MACHINE(pcms);
>  
> -        x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> +        x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>          error_setg(errp,
>              "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
>              " APIC ID %" PRIu32 ", valid index range 0:%d",
> @@ -1608,7 +1608,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>      /* TODO: move socket_id/core_id/thread_id checks into x86_cpu_realizefn()
>       * once -smp refactoring is complete and there will be CPU private
>       * CPUState::nr_cores and CPUState::nr_threads fields instead of globals */
> -    x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> +    x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
>      if (cpu->socket_id != -1 && cpu->socket_id != topo_ids.pkg_id) {
>          error_setg(errp, "property socket-id: %u doesn't match set apic-id:"
>              " 0x%x (socket-id: %u)", cpu->socket_id, cpu->apic_id,
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 7dc237c014..ad85347142 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -68,6 +68,25 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
>      topo_info->threads_per_core = ms->smp.threads;
>  }
>  
> +/*
> + * Check for APIC ID encoding
> + *
> + * AMD uses different apic id encoding for their EPYC based cpus.
> + * Check if we need to use different handlers than the default.
comment is not valid, cpu_x86_use_epyc_apic_id_encoding() does the checking
but this function actually overrides it.

it would be better to name it properly and amend comment, something like

if (cpu_x86_use_epyc_apic_id_encoding(machine->cpu_type)) {
   set_epyc_topo_handlers()
}

> + */
> +static void x86_check_apic_id_encoding(MachineState *machine)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(machine);
> +
> +    if (cpu_x86_use_epyc_apic_id_encoding(machine->cpu_type)) {
> +        x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
> +        x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
> +        x86ms->topo_ids_from_idx = x86_topo_ids_from_idx_epyc;
> +        x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
> +        x86ms->apicid_pkg_offset = apicid_pkg_offset_epyc;
> +    }
> +}
> +
>  /*
>   * Calculates initial APIC ID for a specific CPU index
>   *
> @@ -86,7 +105,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>  
>      init_topo_info(&topo_info, x86ms);
>  
> -    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
> +    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
>      if (x86mc->compat_apic_id_mode) {
>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>              error_report("APIC IDs set in compatibility mode, "
> @@ -158,8 +177,8 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>     init_topo_info(&topo_info, x86ms);
>  
>     assert(idx < ms->possible_cpus->len);
> -   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> -                            &topo_info, &topo_ids);
> +   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> +                               &topo_info, &topo_ids);
>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>  }
>  
> @@ -179,6 +198,9 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>          return ms->possible_cpus;
>      }
>  
> +    /* Check for apicid encoding */
> +    x86_check_apic_id_encoding(ms);

that might crash if user used legacy -numa node,cpus= option
option parser would call reach here before machine->cpu_type is set

it's better to put this call into x86_cpus_init() like it was done
in previous versions

>      ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
>                                    sizeof(CPUArchId) * max_cpus);
>      ms->possible_cpus->len = max_cpus;
> @@ -192,8 +214,8 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>          ms->possible_cpus->cpus[i].vcpus_count = 1;
>          ms->possible_cpus->cpus[i].arch_id =
>              x86_cpu_apic_id_from_index(x86ms, i);
> -        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> -                                 &topo_info, &topo_ids);
> +        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> +                                    &topo_info, &topo_ids);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>          if (x86ms->smp_dies > 1) {
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a3051524a2..19de79d01c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1615,6 +1615,10 @@ typedef struct X86CPUDefinition {
>      FeatureWordArray features;
>      const char *model_id;
>      CPUCaches *cache_info;
> +
> +    /* Use AMD EPYC encoding for apic id */
> +    bool use_epyc_apic_id_encoding;
> +
>      /*
>       * Definitions for alternative versions of CPU model.
>       * List is terminated by item with version == 0.
> @@ -1656,6 +1660,13 @@ static const X86CPUVersionDefinition *x86_cpu_def_get_versions(X86CPUDefinition
>      return def->versions ?: default_version_list;
>  }
>  
> +bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type)
> +{
> +    X86CPUClass *xcc = X86_CPU_CLASS(object_class_by_name(cpu_type));

assert(xcc)

> +
> +    return xcc->model->cpudef->use_epyc_apic_id_encoding;
> +}
> +
>  static CPUCaches epyc_cache_info = {
>      .l1d_cache = &(CPUCacheInfo) {
>          .type = DATA_CACHE,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 7e9e963d78..6e522fcd34 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1897,6 +1897,7 @@ void cpu_clear_apic_feature(CPUX86State *env);
>  void host_cpuid(uint32_t function, uint32_t count,
>                  uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx);
>  void host_vendor_fms(char *vendor, int *family, int *model, int *stepping);
> +bool cpu_x86_use_epyc_apic_id_encoding(const char *cpu_type);
>  
>  /* helper.c */
>  bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> 



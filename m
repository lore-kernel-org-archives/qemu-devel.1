Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C364C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A172206B1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpQe1Pzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A172206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCN0n-0003vz-7q
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jCMzi-0003VD-T0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jCMzh-0001PW-HT
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:31:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jCMzf-0001Og-SD
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584016279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dg9rMbiI9zfHIRDNy2o7XogkMlo6CVtc9p4Ofkg1Kg=;
 b=bpQe1Pznb+qmg1Ek5X+Kn1iKHReASAen3JyEHCsSk3D5guplElGZ6bB3YAszKegoJopW/M
 5eIxv6SuiIAxAUDYbo6ddLtMUw2O9RAV5Z2Bqv85sjWBwK9bGk6TACMUPzJIavkxV7HDyr
 1JkLb36zEWBkMB17j2O72l+KhyWKWlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-SaeBANIHOhaCUhI7oWxbPA-1; Thu, 12 Mar 2020 08:31:13 -0400
X-MC-Unique: SaeBANIHOhaCUhI7oWxbPA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9153C100550D;
 Thu, 12 Mar 2020 12:31:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C30719C6A;
 Thu, 12 Mar 2020 12:31:08 +0000 (UTC)
Date: Thu, 12 Mar 2020 13:31:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v7 11/13] hw/i386: Move arch_id decode inside x86_cpus_init
Message-ID: <20200312133107.2048675d@redhat.com>
In-Reply-To: <158396724217.58170.12256158354204870716.stgit@naples-babu.amd.com>
References: <158396702138.58170.7920458595372792959.stgit@naples-babu.amd.com>
 <158396724217.58170.12256158354204870716.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Wed, 11 Mar 2020 17:54:02 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Apicid calculation depends on knowing the total number of numa nodes
> for EPYC cpu models. Right now, we are calculating the arch_id while
> parsing the numa(parse_numa). At this time, it is not known how many
> total numa nodes are configured in the system.
> 
> Move the arch_id calculation inside x86_cpus_init. At this time, smp
> parse is already completed and numa node information is available.
> 
> Override the handlers if use_epyc_apic_id_encoding is enabled in
> cpu model definition.
> 
> Also replace the calling convention to use handlers from
> X86MachineState.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc.c  |    6 +++---
>  hw/i386/x86.c |   37 ++++++++++++++++++++++++++++++-------
>  2 files changed, 33 insertions(+), 10 deletions(-)
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
> index 0a81ab5151..023dce1dbd 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -68,6 +68,22 @@ inline void init_topo_info(X86CPUTopoInfo *topo_info,
>      topo_info->threads_per_core = ms->smp.threads;
>  }
>  
> +/*
> + * Set up with the new EPYC topology handlers
> + *
> + * AMD uses different apic id encoding for EPYC based cpus. Override
> + * the default topo handlers with EPYC encoding handlers.
> + */
> +static void x86_set_epyc_topo_handlers(MachineState *machine)
> +{
> +    X86MachineState *x86ms = X86_MACHINE(machine);
> +
> +    x86ms->apicid_from_cpu_idx = x86_apicid_from_cpu_idx_epyc;
> +    x86ms->topo_ids_from_apicid = x86_topo_ids_from_apicid_epyc;
> +    x86ms->apicid_from_topo_ids = x86_apicid_from_topo_ids_epyc;
> +    x86ms->apicid_pkg_offset = apicid_pkg_offset_epyc;
> +}
> +
>  /*
>   * Calculates initial APIC ID for a specific CPU index
>   *
> @@ -86,7 +102,7 @@ uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>  
>      init_topo_info(&topo_info, x86ms);
>  
> -    correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
> +    correct_id = x86ms->apicid_from_cpu_idx(&topo_info, cpu_index);
>      if (x86mc->compat_apic_id_mode) {
>          if (cpu_index != correct_id && !warned && !qtest_enabled()) {
>              error_report("APIC IDs set in compatibility mode, "
> @@ -121,6 +137,11 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>      MachineState *ms = MACHINE(x86ms);
>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>  
> +    /* Check for apicid encoding */
> +    if (cpu_x86_use_epyc_apic_id_encoding(ms->cpu_type)) {
> +        x86_set_epyc_topo_handlers(ms);
> +    }
> +
>      x86_cpu_set_default_version(default_cpu_version);
>  
>      /*
> @@ -134,6 +155,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>      x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
>                                                        ms->smp.max_cpus - 1) + 1;
>      possible_cpus = mc->possible_cpu_arch_ids(ms);
> +
> +    for (i = 0; i < ms->smp.cpus; i++) {
> +        ms->possible_cpus->cpus[i].arch_id =
> +            x86_cpu_apic_id_from_index(x86ms, i);
> +    }
> +
>      for (i = 0; i < ms->smp.cpus; i++) {
>          x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
>      }
> @@ -158,8 +185,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>     init_topo_info(&topo_info, x86ms);
>  
>     assert(idx < ms->possible_cpus->len);
> -   x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> -                            &topo_info, &topo_ids);
> +   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);
>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>  }
>  
> @@ -190,10 +216,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>  
>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>          ms->possible_cpus->cpus[i].vcpus_count = 1;
> -        ms->possible_cpus->cpus[i].arch_id =
> -            x86_cpu_apic_id_from_index(x86ms, i);
> -        x86_topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> -                                 &topo_info, &topo_ids);
> +        x86_topo_ids_from_idx(&topo_info, i, &topo_ids);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>          if (x86ms->smp_dies > 1) {
> 



Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0B0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB9F2073A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 15:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtH9Ksn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB9F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwT58-0002pW-Vh
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 10:47:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iwT4D-0002E7-BG
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:46:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iwT4B-0007Np-T1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:46:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29668
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iwT4B-0007NV-Nq
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 10:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580226375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6riT6Tq1roFxdjwSv0OKQOyIUTSpgVUeCH/rm4/BvyA=;
 b=FtH9Ksn3Gq14CBFawWwEMBcKQ+GU3IKDxCkpapNIDjIQJOwT43u2AefLnZD3UmmwTZTOQN
 8c2vv834UYjTnWr8zTjA6aZuizpsHVkDkFeGE3/Q8BAbmRSe3VY8Sy8qB+r0gcWDlxH4or
 KNyzFjVyvNePmu9Vg4XhzScvksU4z+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-VMmEuE7BOweupsnqRkYuEA-1; Tue, 28 Jan 2020 10:46:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 797D1800D41;
 Tue, 28 Jan 2020 15:46:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C85219C58;
 Tue, 28 Jan 2020 15:46:08 +0000 (UTC)
Date: Tue, 28 Jan 2020 16:46:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v3 03/18] hw/i386: Consolidate topology functions
Message-ID: <20200128164607.7611ad5f@redhat.com>
In-Reply-To: <157541983500.46157.10867081966222391072.stgit@naples-babu.amd.com>
References: <157541968844.46157.17994918142533791313.stgit@naples-babu.amd.com>
 <157541983500.46157.10867081966222391072.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: VMmEuE7BOweupsnqRkYuEA-1
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
Cc: ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 03 Dec 2019 18:37:15 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Now that we have all the parameters in X86CPUTopoInfo, we can just pass the
> structure to calculate the offsets and width.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/i386/topology.h |   64 ++++++++++++++------------------------------
>  target/i386/cpu.c          |   23 ++++++++--------
>  2 files changed, 32 insertions(+), 55 deletions(-)
> 
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index cf1935d548..ba52d49079 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -69,56 +69,42 @@ static unsigned apicid_bitwidth_for_count(unsigned count)
>  
>  /* Bit width of the SMT_ID (thread ID) field on the APIC ID
>   */
> -static inline unsigned apicid_smt_width(unsigned nr_dies,
> -                                        unsigned nr_cores,
> -                                        unsigned nr_threads)
> +static inline unsigned apicid_smt_width(X86CPUTopoInfo *topo_info)
>  {
> -    return apicid_bitwidth_for_count(nr_threads);
> +    return apicid_bitwidth_for_count(topo_info->threads_per_core);
>  }
>  
>  /* Bit width of the Core_ID field
>   */
> -static inline unsigned apicid_core_width(unsigned nr_dies,
> -                                         unsigned nr_cores,
> -                                         unsigned nr_threads)
> +static inline unsigned apicid_core_width(X86CPUTopoInfo *topo_info)
>  {
> -    return apicid_bitwidth_for_count(nr_cores);
> +    return apicid_bitwidth_for_count(topo_info->cores_per_die);
>  }
>  
>  /* Bit width of the Die_ID field */
> -static inline unsigned apicid_die_width(unsigned nr_dies,
> -                                        unsigned nr_cores,
> -                                        unsigned nr_threads)
> +static inline unsigned apicid_die_width(X86CPUTopoInfo *topo_info)
>  {
> -    return apicid_bitwidth_for_count(nr_dies);
> +    return apicid_bitwidth_for_count(topo_info->dies_per_pkg);
>  }
>  
>  /* Bit offset of the Core_ID field
>   */
> -static inline unsigned apicid_core_offset(unsigned nr_dies,
> -                                          unsigned nr_cores,
> -                                          unsigned nr_threads)
> +static inline unsigned apicid_core_offset(X86CPUTopoInfo *topo_info)
>  {
> -    return apicid_smt_width(nr_dies, nr_cores, nr_threads);
> +    return apicid_smt_width(topo_info);
>  }
>  
>  /* Bit offset of the Die_ID field */
> -static inline unsigned apicid_die_offset(unsigned nr_dies,
> -                                          unsigned nr_cores,
> -                                           unsigned nr_threads)
> +static inline unsigned apicid_die_offset(X86CPUTopoInfo *topo_info)
>  {
> -    return apicid_core_offset(nr_dies, nr_cores, nr_threads) +
> -           apicid_core_width(nr_dies, nr_cores, nr_threads);
> +    return apicid_core_offset(topo_info) + apicid_core_width(topo_info);
>  }
>  
>  /* Bit offset of the Pkg_ID (socket ID) field
>   */
> -static inline unsigned apicid_pkg_offset(unsigned nr_dies,
> -                                         unsigned nr_cores,
> -                                         unsigned nr_threads)
> +static inline unsigned apicid_pkg_offset(X86CPUTopoInfo *topo_info)
>  {
> -    return apicid_die_offset(nr_dies, nr_cores, nr_threads) +
> -           apicid_die_width(nr_dies, nr_cores, nr_threads);
> +    return apicid_die_offset(topo_info) + apicid_die_width(topo_info);
>  }
>  
>  /* Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> @@ -128,13 +114,9 @@ static inline unsigned apicid_pkg_offset(unsigned nr_dies,
>  static inline apic_id_t apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
>                                               const X86CPUTopoIDs *topo_ids)
>  {
> -    unsigned nr_dies = topo_info->dies_per_pkg;
> -    unsigned nr_cores = topo_info->cores_per_die;
> -    unsigned nr_threads = topo_info->threads_per_core;
> -
> -    return (topo_ids->pkg_id  << apicid_pkg_offset(nr_dies, nr_cores, nr_threads)) |
> -           (topo_ids->die_id  << apicid_die_offset(nr_dies, nr_cores, nr_threads)) |
> -           (topo_ids->core_id << apicid_core_offset(nr_dies, nr_cores, nr_threads)) |
> +    return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
> +           (topo_ids->die_id  << apicid_die_offset(topo_info)) |
> +           (topo_ids->core_id << apicid_core_offset(topo_info)) |
>             topo_ids->smt_id;
>  }
>  
> @@ -162,19 +144,15 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
>                                              X86CPUTopoInfo *topo_info,
>                                              X86CPUTopoIDs *topo_ids)
>  {
> -    unsigned nr_dies = topo_info->dies_per_pkg;
> -    unsigned nr_cores = topo_info->cores_per_die;
> -    unsigned nr_threads = topo_info->threads_per_core;
> -
>      topo_ids->smt_id = apicid &
> -            ~(0xFFFFFFFFUL << apicid_smt_width(nr_dies, nr_cores, nr_threads));
> +            ~(0xFFFFFFFFUL << apicid_smt_width(topo_info));
>      topo_ids->core_id =
> -            (apicid >> apicid_core_offset(nr_dies, nr_cores, nr_threads)) &
> -            ~(0xFFFFFFFFUL << apicid_core_width(nr_dies, nr_cores, nr_threads));
> +            (apicid >> apicid_core_offset(topo_info)) &
> +            ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
>      topo_ids->die_id =
> -            (apicid >> apicid_die_offset(nr_dies, nr_cores, nr_threads)) &
> -            ~(0xFFFFFFFFUL << apicid_die_width(nr_dies, nr_cores, nr_threads));
> -    topo_ids->pkg_id = apicid >> apicid_pkg_offset(nr_dies, nr_cores, nr_threads);
> +            (apicid >> apicid_die_offset(topo_info)) &
> +            ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
> +    topo_ids->pkg_id = apicid >> apicid_pkg_offset(topo_info);
>  }
>  
>  /* Make APIC ID for the CPU 'cpu_index'
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 07cf562d89..bc9b491557 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -4551,6 +4551,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>      uint32_t die_offset;
>      uint32_t limit;
>      uint32_t signature[3];
> +    X86CPUTopoInfo topo_info;
> +
> +    topo_info.dies_per_pkg = env->nr_dies;
> +    topo_info.cores_per_die = cs->nr_cores;
> +    topo_info.threads_per_core = cs->nr_threads;
>  
>      /* Calculate & apply limits for different index ranges */
>      if (index >= 0xC0000000) {
> @@ -4637,8 +4642,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                                      eax, ebx, ecx, edx);
>                  break;
>              case 3: /* L3 cache info */
> -                die_offset = apicid_die_offset(env->nr_dies,
> -                                        cs->nr_cores, cs->nr_threads);
> +                die_offset = apicid_die_offset(&topo_info);
>                  if (cpu->enable_l3_cache) {
>                      encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
>                                          (1 << die_offset), cs->nr_cores,
> @@ -4729,14 +4733,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>  
>          switch (count) {
>          case 0:
> -            *eax = apicid_core_offset(env->nr_dies,
> -                                      cs->nr_cores, cs->nr_threads);
> +            *eax = apicid_core_offset(&topo_info);
>              *ebx = cs->nr_threads;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
>              break;
>          case 1:
> -            *eax = apicid_pkg_offset(env->nr_dies,
> -                                     cs->nr_cores, cs->nr_threads);
> +            *eax = apicid_pkg_offset(&topo_info);
>              *ebx = cs->nr_cores * cs->nr_threads;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>              break;
> @@ -4760,20 +4762,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          *edx = cpu->apic_id;
>          switch (count) {
>          case 0:
> -            *eax = apicid_core_offset(env->nr_dies, cs->nr_cores,
> -                                                    cs->nr_threads);
> +            *eax = apicid_core_offset(&topo_info);
>              *ebx = cs->nr_threads;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
>              break;
>          case 1:
> -            *eax = apicid_die_offset(env->nr_dies, cs->nr_cores,
> -                                                   cs->nr_threads);
> +            *eax = apicid_die_offset(&topo_info);
>              *ebx = cs->nr_cores * cs->nr_threads;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
>              break;
>          case 2:
> -            *eax = apicid_pkg_offset(env->nr_dies, cs->nr_cores,
> -                                                   cs->nr_threads);
> +            *eax = apicid_pkg_offset(&topo_info);
>              *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
>              *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
>              break;
> 



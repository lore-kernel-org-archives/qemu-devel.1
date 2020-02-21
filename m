Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DD9C35657
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:06:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC4C206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uk2hEvjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC4C206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5Bkj-0005xA-2R
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j5Bjn-0004zE-0Z
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j5Bjl-0004jo-M8
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:05:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58139
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j5Bjl-0004hd-E7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582304712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cWWyeF4XreQDR9uANNZqjV/RwgPb075+ipXOMt5cCGw=;
 b=Uk2hEvjNu772P17DltwNRTOnmeBgNCcnSaArdx3bOPmTdNBQm2VLWYb8MSnwatdTUhgR6/
 NnSs/8QaMUa6kKWHLunCAVrvqV6pPrUwpUXm3HoYhlFAdLDg6xJynLQOyQpFrzn0DCnQ4I
 05fRjOlENoPI0uKMey4Fre8zaJ+Wd8s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-xxGyBvdeOOOoTocB7Y6jpw-1; Fri, 21 Feb 2020 12:05:11 -0500
X-MC-Unique: xxGyBvdeOOOoTocB7Y6jpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0724F800D4E;
 Fri, 21 Feb 2020 17:05:10 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09BC090F7C;
 Fri, 21 Feb 2020 17:05:02 +0000 (UTC)
Date: Fri, 21 Feb 2020 18:05:01 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 04/16] hw/i386: Introduce init_topo_info to
 initialize X86CPUTopoInfo
Message-ID: <20200221180501.72e4ff3c@redhat.com>
In-Reply-To: <158161781120.48948.3568234592332597800.stgit@naples-babu.amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161781120.48948.3568234592332597800.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Thu, 13 Feb 2020 12:16:51 -0600
Babu Moger <babu.moger@amd.com> wrote:

> Initialize all the parameters in one function init_topo_info.

is it possible to squash it in 2/16


> 
> Move the data structure X86CPUTopoIDs and X86CPUTopoInfo into
> x86.h.
A reason why it's moved should be here.

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/i386/pc.c               |    4 +---
>  hw/i386/x86.c              |   14 +++-----------
>  include/hw/i386/topology.h |   26 ++++++++++----------------
>  include/hw/i386/x86.h      |   17 +++++++++++++++++
>  4 files changed, 31 insertions(+), 30 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2adf7f6afa..9803413dd9 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1749,9 +1749,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
>          return;
>      }
>  
> -    topo_info.dies_per_pkg = x86ms->smp_dies;
> -    topo_info.cores_per_die = smp_cores;
> -    topo_info.threads_per_core = smp_threads;
> +    init_topo_info(&topo_info, x86ms);
>  
>      env->nr_dies = x86ms->smp_dies;
>  
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index f18cab8e5c..083effb2f5 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -63,15 +63,12 @@ static size_t pvh_start_addr;
>  uint32_t x86_cpu_apic_id_from_index(X86MachineState *x86ms,
>                                      unsigned int cpu_index)
>  {
> -    MachineState *ms = MACHINE(x86ms);
>      X86MachineClass *x86mc = X86_MACHINE_GET_CLASS(x86ms);
>      X86CPUTopoInfo topo_info;
>      uint32_t correct_id;
>      static bool warned;
>  
> -    topo_info.dies_per_pkg = x86ms->smp_dies;
> -    topo_info.cores_per_die = ms->smp.cores;
> -    topo_info.threads_per_core = ms->smp.threads;
> +    init_topo_info(&topo_info, x86ms);
>  
>      correct_id = x86_apicid_from_cpu_idx(&topo_info, cpu_index);
>      if (x86mc->compat_apic_id_mode) {
> @@ -146,10 +143,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>     X86MachineState *x86ms = X86_MACHINE(ms);
>     X86CPUTopoInfo topo_info;
>  
> -   topo_info.dies_per_pkg = x86ms->smp_dies;
> -   topo_info.cores_per_die = ms->smp.cores;
> -   topo_info.threads_per_core = ms->smp.threads;
> -
> +   init_topo_info(&topo_info, x86ms);
>  
>     assert(idx < ms->possible_cpus->len);
>     x86_topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> @@ -177,9 +171,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>                                    sizeof(CPUArchId) * max_cpus);
>      ms->possible_cpus->len = max_cpus;
>  
> -    topo_info.dies_per_pkg = x86ms->smp_dies;
> -    topo_info.cores_per_die = ms->smp.cores;
> -    topo_info.threads_per_core = ms->smp.threads;
> +    init_topo_info(&topo_info, x86ms);
>  
>      for (i = 0; i < ms->possible_cpus->len; i++) {
>          X86CPUTopoIDs topo_ids;
> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> index ba52d49079..ef0ab0b6a3 100644
> --- a/include/hw/i386/topology.h
> +++ b/include/hw/i386/topology.h
> @@ -40,23 +40,17 @@
>  
>  
>  #include "qemu/bitops.h"
> +#include "hw/i386/x86.h"
>  
> -/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
> - */
> -typedef uint32_t apic_id_t;
> -
> -typedef struct X86CPUTopoIDs {
> -    unsigned pkg_id;
> -    unsigned die_id;
> -    unsigned core_id;
> -    unsigned smt_id;
> -} X86CPUTopoIDs;
> -
> -typedef struct X86CPUTopoInfo {
> -    unsigned dies_per_pkg;
> -    unsigned cores_per_die;
> -    unsigned threads_per_core;
> -} X86CPUTopoInfo;
> +static inline void init_topo_info(X86CPUTopoInfo *topo_info,
> +                                  const X86MachineState *x86ms)
> +{
> +    MachineState *ms = MACHINE(x86ms);
> +
> +    topo_info->dies_per_pkg = x86ms->smp_dies;
> +    topo_info->cores_per_die = ms->smp.cores;
> +    topo_info->threads_per_core = ms->smp.threads;
> +}
>  
>  /* Return the bit width needed for 'count' IDs
>   */
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 4b84917885..ad62b01cf2 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -36,6 +36,23 @@ typedef struct {
>      bool compat_apic_id_mode;
>  } X86MachineClass;
>  
> +/* APIC IDs can be 32-bit, but beware: APIC IDs > 255 require x2APIC support
> + */
> +typedef uint32_t apic_id_t;
> +
> +typedef struct X86CPUTopoIDs {
> +    unsigned pkg_id;
> +    unsigned die_id;
> +    unsigned core_id;
> +    unsigned smt_id;
> +} X86CPUTopoIDs;
> +
> +typedef struct X86CPUTopoInfo {
> +    unsigned dies_per_pkg;
> +    unsigned cores_per_die;
> +    unsigned threads_per_core;
> +} X86CPUTopoInfo;
> +
>  typedef struct {
>      /*< private >*/
>      MachineState parent;
> 



Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D85EC10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:30:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFF920873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="huvyBkIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFF920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0Vc-00034c-AN
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jC0Ub-00029j-Rf
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jC0UZ-0006df-FI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:29:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52732
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jC0UZ-0006dP-BS
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583929783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btSb1bRjJ2pnmUrltp1fqX7XizZLQNQub/QFmae3dlw=;
 b=huvyBkIH9umxDfa/hseG9+czKfX2rrXqIxcHp/fKKk3WYUaRCwwWOZEKRuTSj14sb+ms+D
 QP0Oh7gnk32teixNVr/8mHbY0DYYpQQh6B+13FRT/dnRkiboP/wtFIIOZisgGffUeq9/U7
 9zyyv5Z9+bIuB0+73wOElhROZdQvmJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-mwKsnSWqN4SmY9--w5cugQ-1; Wed, 11 Mar 2020 08:29:39 -0400
X-MC-Unique: mwKsnSWqN4SmY9--w5cugQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 278178010EA;
 Wed, 11 Mar 2020 12:29:38 +0000 (UTC)
Received: from localhost (ovpn-200-57.brq.redhat.com [10.40.200.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C0AB5D9C9;
 Wed, 11 Mar 2020 12:29:32 +0000 (UTC)
Date: Wed, 11 Mar 2020 13:29:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v6 12/13] hw/i386: Move arch_id decode inside x86_cpus_init
Message-ID: <20200311132930.6408bccc@redhat.com>
In-Reply-To: <158389407977.22020.8482854741622304295.stgit@naples-babu.amd.com>
References: <158389385028.22020.7608244627303132902.stgit@naples-babu.amd.com>
 <158389407977.22020.8482854741622304295.stgit@naples-babu.amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

On Tue, 10 Mar 2020 21:34:39 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Apicid calculation depends on knowing the total number of numa nodes
> for EPYC cpu models. Right now, we are calculating the arch_id while
> parsing the numa(parse_numa). At this time, it is not known how many
> total numa nodes are configured in the system.
> 
> Move the arch_id inside x86_cpus_init. At this time smp parse is already
> completed and numa node information is available.

now it's correcting bug introduced by 10/13,
which is fine but it leaves bisection broken

perhaps squash this patch in 10/13?

> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/i386/x86.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index ad85347142..be93c1fd1b 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -140,6 +140,9 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
>      MachineState *ms = MACHINE(x86ms);
>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
>  
> +    /* Check for apicid encoding */
> +    x86_check_apic_id_encoding(ms);
> +
>      x86_cpu_set_default_version(default_cpu_version);
>  
>      /*
> @@ -153,6 +156,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
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
> @@ -177,8 +186,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
>     init_topo_info(&topo_info, x86ms);
>  
>     assert(idx < ms->possible_cpus->len);
> -   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> -                               &topo_info, &topo_ids);
> +   x86ms->topo_ids_from_idx(&topo_info, idx, &topo_ids);
>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
>  }
>  
> @@ -212,10 +220,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
>  
>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
>          ms->possible_cpus->cpus[i].vcpus_count = 1;
> -        ms->possible_cpus->cpus[i].arch_id =
> -            x86_cpu_apic_id_from_index(x86ms, i);
> -        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> -                                    &topo_info, &topo_ids);
> +        x86ms->topo_ids_from_idx(&topo_info, i, &topo_ids);
>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
>          if (x86ms->smp_dies > 1) {
> 



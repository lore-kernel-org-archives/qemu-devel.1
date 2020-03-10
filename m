Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B81C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C82A2465A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 08:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aonYkJ5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C82A2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBaOU-0004Cv-Cu
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 04:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45024)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jBaMe-0001Jg-LB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jBaMd-0001uP-84
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:35:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36589
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jBaMd-0001so-2y
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 04:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583829346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XQNY5tMmeuKY+b0M87+IciUh/b+Bg8PYBEMffitrExs=;
 b=aonYkJ5xod3FfwddThcIEhEY9K0mvSuuW8YdvEJH0/9MVuVWuhzJw7BoMgl51aDM+2GzYf
 pUmqH01XrUvf+Jec58nhfGbQsLfa0Gz7GxixIKHLYDpjLAPVkhNmrSQpuLfmXigm2XBE6a
 tnSwvxNF+7WMGqpFJFyZ9782ZGFSz2I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-pUVN8yFjMI2Zg3GK0i_7Iw-1; Tue, 10 Mar 2020 04:35:44 -0400
X-MC-Unique: pUVN8yFjMI2Zg3GK0i_7Iw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97B4D189F760;
 Tue, 10 Mar 2020 08:35:43 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A7BCC5C1D4;
 Tue, 10 Mar 2020 08:35:39 +0000 (UTC)
Date: Tue, 10 Mar 2020 09:35:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v5 14/16] hw/i386: Move arch_id decode inside x86_cpus_init
Message-ID: <20200310093537.192f855f@redhat.com>
In-Reply-To: <b008461c-d7c0-58f2-1c77-69a2fb5dae3e@amd.com>
References: <158326531474.40452.11433722850425537745.stgit@naples-babu.amd.com>
 <158326550403.40452.15934956681175349815.stgit@naples-babu.amd.com>
 <20200309162123.5ab6a750@Igors-MacBook-Pro>
 <b008461c-d7c0-58f2-1c77-69a2fb5dae3e@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

On Mon, 9 Mar 2020 14:31:31 -0500
Babu Moger <babu.moger@amd.com> wrote:

> On 3/9/20 10:21 AM, Igor Mammedov wrote:
> > On Tue, 03 Mar 2020 13:58:24 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> >> Apicid calculation depends on knowing the total number of numa nodes
> >> for EPYC cpu models. Right now, we are calculating the arch_id while
> >> parsing the numa(parse_numa). At this time, it is not known how many
> >> total numa nodes are configured in the system.
> >>
> >> Move the arch_id inside x86_cpus_init. At this time smp parameter is already
> >> completed and numa node information is available.
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> >>  hw/i386/x86.c |   17 +++++++++++------
> >>  1 file changed, 11 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> >> index d46dd4ad9e..66998b065c 100644
> >> --- a/hw/i386/x86.c
> >> +++ b/hw/i386/x86.c
> >> @@ -121,6 +121,9 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> >>      MachineState *ms = MACHINE(x86ms);
> >>      MachineClass *mc = MACHINE_GET_CLASS(x86ms);
> >>  
> >> +    /* Initialize apicid handlers first */
> >> +    cpu_x86_init_apicid_fns(ms);
> >> +
> >>      x86_cpu_set_default_version(default_cpu_version);
> >>  
> >>      /*
> >> @@ -134,6 +137,12 @@ void x86_cpus_init(X86MachineState *x86ms, int default_cpu_version)
> >>      x86ms->apic_id_limit = x86_cpu_apic_id_from_index(x86ms,
> >>                                                        ms->smp.max_cpus - 1) + 1;
> >>      possible_cpus = mc->possible_cpu_arch_ids(ms);
> >> +
> >> +    for (i = 0; i < ms->smp.cpus; i++) {
> >> +        ms->possible_cpus->cpus[i].arch_id =
> >> +            x86_cpu_apic_id_from_index(x86ms, i);
> >> +    }
> >> +
> >>      for (i = 0; i < ms->smp.cpus; i++) {
> >>          x86_cpu_new(x86ms, possible_cpus->cpus[i].arch_id, &error_fatal);
> >>      }
> >> @@ -158,8 +167,7 @@ int64_t x86_get_default_cpu_node_id(const MachineState *ms, int idx)
> >>     init_topo_info(&topo_info, x86ms);
> >>  
> >>     assert(idx < ms->possible_cpus->len);
> >> -   x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[idx].arch_id,
> >> -                               &topo_info, &topo_ids);
> >> +   x86_topo_ids_from_idx(&topo_info, idx, &topo_ids);  
> > not necessary if default x86ms->topo_ids_from_apicid were initialized from x86 machine class
> > 
> > I also wonder if this default contraption we have is going to work
> > in case of EPYC cpu (i.e. is would generate valid nodeids).  
> 
> From what I understand, we call this x86_get_default_cpu_node_id only when
> the user does not specify the numa binding requirements. We tried to
> generate the default node it for a given config. This works fine for EPYC
> also. I am not sure about changing this right now. what do you think?

if it work for EPYC with default x86_topo_ids_from_idx() then it's fine.

Just keep callback here, given that callback is always initialized early (class_init)
there is no point to create mix of callback/non-callback usage.
 
> > 
> > Bot instead of than trying to fix it if it's broken,
> > I'd rather deprecate and drop get_default_cpu_node_id() requiring users
> > to explicitly define CPU mapping to numa nodes.
> > That would be consistent with req for explicit RAM for numa nodes
> > (postponed till 5.1 due to libvirt not being ready),
> > i.e if one wants numa, one should explicitly provide necessary mapping
> > or machine won't start.
> > 
> >   
> >>     return topo_ids.pkg_id % ms->numa_state->num_nodes;
> >>  }
> >>  
> >> @@ -193,10 +201,7 @@ const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
> >>  
> >>          ms->possible_cpus->cpus[i].type = ms->cpu_type;
> >>          ms->possible_cpus->cpus[i].vcpus_count = 1;
> >> -        ms->possible_cpus->cpus[i].arch_id =
> >> -            x86_cpu_apic_id_from_index(x86ms, i);
> >> -        x86ms->topo_ids_from_apicid(ms->possible_cpus->cpus[i].arch_id,
> >> -                                 &topo_info, &topo_ids);
> >> +        x86_topo_ids_from_idx(&topo_info, i, &topo_ids);  
> > ditto
> >   
> >>          ms->possible_cpus->cpus[i].props.has_socket_id = true;
> >>          ms->possible_cpus->cpus[i].props.socket_id = topo_ids.pkg_id;
> >>          if (x86ms->smp_dies > 1) {
> >>  
> >   
> 



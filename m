Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ACBC35DF8
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C7021744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 07:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdVYGJvb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C7021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Us0-0004KT-35
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 02:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41211)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j6UrF-0003Fy-LF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j6UrE-0004Dm-72
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:42:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54490
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j6UrE-0004D6-21
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 02:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582616539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/eLbxVlDqq/VWQY05x0D25ujU/Uk5ZGhORESjCtob2I=;
 b=NdVYGJvbci5djCou1Zx8zQ1Fbnv2ETAcQoDx+SFUUpcfw1MPOAqi1BNn/++0+lWIMwH/xU
 GUFgROSMz1QP143k/H0CYST0Y2MVNAbFMBCJc6PK+qTKDpmW7PWpGknmkfDY5HFj7u+ODS
 iRwRjNElu5fAg+ImmexcHSwk0sV49Zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-Og_r7jjrPrqJ8qf3HnSnqw-1; Tue, 25 Feb 2020 02:42:15 -0500
X-MC-Unique: Og_r7jjrPrqJ8qf3HnSnqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CD0E18A550B;
 Tue, 25 Feb 2020 07:42:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B4A45C105;
 Tue, 25 Feb 2020 07:42:10 +0000 (UTC)
Date: Tue, 25 Feb 2020 08:42:08 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v4 06/16] hw/i386: Update structures for nodes_per_pkg
Message-ID: <20200225084208.59a08d51@redhat.com>
In-Reply-To: <cdc8255e-b5ef-1635-b59f-44f371569865@amd.com>
References: <158161767653.48948.10578064482878399556.stgit@naples-babu.amd.com>
 <158161782489.48948.9328710425201785950.stgit@naples-babu.amd.com>
 <20200224093439.5fda5656@redhat.com>
 <cdc8255e-b5ef-1635-b59f-44f371569865@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Mon, 24 Feb 2020 11:12:41 -0600
Babu Moger <babu.moger@amd.com> wrote:

> On 2/24/20 2:34 AM, Igor Mammedov wrote:
> > On Thu, 13 Feb 2020 12:17:04 -0600
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> >> Update structures X86CPUTopoIDs and CPUX86State to hold the nodes_per_pkg.
> >> This is required to build EPYC mode topology.
> >>
> >> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >> ---
> >>  hw/i386/pc.c               |    1 +
> >>  hw/i386/x86.c              |    2 ++
> >>  include/hw/i386/topology.h |    2 ++
> >>  include/hw/i386/x86.h      |    1 +
> >>  target/i386/cpu.c          |    1 +
> >>  target/i386/cpu.h          |    1 +
> >>  6 files changed, 8 insertions(+)
> >>
> >> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> >> index f13721ac43..02fdb3d506 100644
> >> --- a/hw/i386/pc.c
> >> +++ b/hw/i386/pc.c
> >> @@ -1753,6 +1753,7 @@ static void pc_cpu_pre_plug(HotplugHandler *hotplug_dev,
> >>      init_topo_info(&topo_info, x86ms);
> >>  
> >>      env->nr_dies = x86ms->smp_dies;
> >> +    env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;  
> > 
> > it would be better if calculation would result in valid result
> > so you won't have to later scatter MAX(env->nr_nodes, 1) everywhere.  
> 
> Ok. Sure.
> > 
> > also I'd use earlier intialized:
> >   env->nr_nodes = topo_info->nodes_per_pkg
> > to avoid repeating calculation  
> 
> yes. Will do it.
> 
> >   
> >>      /*
> >>       * If APIC ID is not set,
> >> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> >> index 083effb2f5..3d944f68e6 100644
> >> --- a/hw/i386/x86.c
> >> +++ b/hw/i386/x86.c
> >> @@ -89,11 +89,13 @@ void x86_cpu_new(X86MachineState *x86ms, int64_t apic_id, Error **errp)
> >>      Object *cpu = NULL;
> >>      Error *local_err = NULL;
> >>      CPUX86State *env = NULL;
> >> +    MachineState *ms = MACHINE(x86ms);
> >>  
> >>      cpu = object_new(MACHINE(x86ms)->cpu_type);
> >>  
> >>      env = &X86_CPU(cpu)->env;
> >>      env->nr_dies = x86ms->smp_dies;
> >> +    env->nr_nodes = ms->numa_state->num_nodes / ms->smp.sockets;  
> > 
> > Is this really necessary?  (I think pc_cpu_pre_plug should take care of setting it)  
> 
> This does not seem necessary. I can add as a separate patch to remove env
> initialization from x86_cpu_new.

it doesn't have to be part of this series, but it's up to you
how to send it

> 
> >   
> >>      object_property_set_uint(cpu, apic_id, "apic-id", &local_err);
> >>      object_property_set_bool(cpu, true, "realized", &local_err);
> >> diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> >> index ef0ab0b6a3..522c77e6a9 100644
> >> --- a/include/hw/i386/topology.h
> >> +++ b/include/hw/i386/topology.h
> >> @@ -41,12 +41,14 @@
> >>  
> >>  #include "qemu/bitops.h"
> >>  #include "hw/i386/x86.h"
> >> +#include "sysemu/numa.h"
> >>  
> >>  static inline void init_topo_info(X86CPUTopoInfo *topo_info,
> >>                                    const X86MachineState *x86ms)
> >>  {
> >>      MachineState *ms = MACHINE(x86ms);
> >>  
> >> +    topo_info->nodes_per_pkg = ms->numa_state->num_nodes / ms->smp.sockets;
> >>      topo_info->dies_per_pkg = x86ms->smp_dies;
> >>      topo_info->cores_per_die = ms->smp.cores;
> >>      topo_info->threads_per_core = ms->smp.threads;
> >> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> >> index ad62b01cf2..d76fd0bbb1 100644
> >> --- a/include/hw/i386/x86.h
> >> +++ b/include/hw/i386/x86.h
> >> @@ -48,6 +48,7 @@ typedef struct X86CPUTopoIDs {
> >>  } X86CPUTopoIDs;
> >>  
> >>  typedef struct X86CPUTopoInfo {
> >> +    unsigned nodes_per_pkg;
> >>      unsigned dies_per_pkg;
> >>      unsigned cores_per_die;
> >>      unsigned threads_per_core;
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index 7e630f47ac..5d6edfd09b 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -6761,6 +6761,7 @@ static void x86_cpu_initfn(Object *obj)
> >>      FeatureWord w;
> >>  
> >>      env->nr_dies = 1;
> >> +    env->nr_nodes = 1;
> >>      cpu_set_cpustate_pointers(cpu);
> >>  
> >>      object_property_add(obj, "family", "int",
> >> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> >> index af282936a7..627a8cb9be 100644
> >> --- a/target/i386/cpu.h
> >> +++ b/target/i386/cpu.h
> >> @@ -1603,6 +1603,7 @@ typedef struct CPUX86State {
> >>      TPRAccess tpr_access_type;
> >>  
> >>      unsigned nr_dies;
> >> +    unsigned nr_nodes;
> >>  } CPUX86State;
> >>  
> >>  struct kvm_msrs;
> >>  
> >   
> 



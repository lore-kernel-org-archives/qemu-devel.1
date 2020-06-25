Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3031FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAB12065F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yspdjnss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAB12065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTfm-0003Oz-2R
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joTeW-0001rt-QB
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:19:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44051
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joTeU-0006lb-F1
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P800gKPAvwiBqlRWLgdM11SNgoulb3wHqeJfSHUplkA=;
 b=YspdjnssrIlINsG8I7Yv7Ehf6nRs09i0f7cSn+D9cii72dxN/6cExuji4yy8/8n6PQx8Ij
 E4oS6oUBnUFqFWK3MTliTej+OzUBWayGYeAQuiKYkMfkviFp3IchwrlN9bQUsFSC5dNF+x
 wU4LucZEvcYXRsAd1AFQzhRerdRFujc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-cUlZnhtVOSyQ6xvlssdiYA-1; Thu, 25 Jun 2020 11:18:39 -0400
X-MC-Unique: cUlZnhtVOSyQ6xvlssdiYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 158DF107ACCD;
 Thu, 25 Jun 2020 15:18:38 +0000 (UTC)
Received: from localhost (unknown [10.40.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1ED27FEA0;
 Thu, 25 Jun 2020 15:18:33 +0000 (UTC)
Date: Thu, 25 Jun 2020 17:18:31 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and
 CPU hotplug
Message-ID: <20200625171831.6decaec9@redhat.com>
In-Reply-To: <512e7103-2c20-da48-93e6-4f67e2eac166@amd.com>
References: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
 <159164753015.20543.7987300339811704895.stgit@naples-babu.amd.com>
 <20200616125901.772229a6@redhat.com>
 <4810d5cd-9409-d2c5-0f0f-1845891c9aad@amd.com>
 <20200624154735.1c104fd8@redhat.com>
 <512e7103-2c20-da48-93e6-4f67e2eac166@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 12:35:59 -0500
Babu Moger <babu.moger@amd.com> wrote:

> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Wednesday, June 24, 2020 8:48 AM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: ehabkost@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> > pbonzini@redhat.com; rth@twiddle.net
> > Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and CPU
> > hotplug
> > 
> > On Tue, 16 Jun 2020 12:18:56 -0500
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > Sent: Tuesday, June 16, 2020 5:59 AM
> > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > > > mst@redhat.com; marcel.apfelbaum@gmail.com; qemu-devel@nongnu.org
> > > > Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and  
> > CPU  
> > > > hotplug
> > > >
> > > > On Mon, 08 Jun 2020 15:18:50 -0500
> > > > Babu Moger <babu.moger@amd.com> wrote:
> > > >  
> > > > > Noticed the following command failure while testing CPU hotplug.
> > > > >
> > > > > $ qemu-system-x86_64 -machine q35,accel=kvm -smp 1,maxcpus=2,
> > > > >   cores=1, threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
> > > > >   cpu,core-id=0,socket-id=1,thread-id=0
> > > > >
> > > > >   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-id=1,
> > > > >   thread-id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0]
> > > > >   with APIC ID 21855, valid index range 0:1
> > > > >
> > > > > This happens because APIC ID is calculated using uninitialized memory.
> > > > > This is happening after the addition of new field node_id in  
> > X86CPUTopoIDs  
> > > > > structure. The node_id field is uninitialized while calling
> > > > > apicid_from_topo_ids. The problem is discussed in the thread below.
> > > > >  
> > > >  
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ker  
> > > > nel.org%2Fqemu-
> > > >  
> > devel%2F20200602171838.GG577771%40habkost.net%2F&amp;data=02%7C01  
> > > >  
> > %7Cbabu.moger%40amd.com%7C02200d75fd8b48d1955608d811e44f5b%7C3d  
> > > >  
> > d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637279019564311233&amp  
> > > >  
> > ;sdata=ry3QO0Z5dxLPoRxkYVkOsVm3nl%2BxfCGv8be%2BMHdoUPY%3D&amp;r  
> > > > eserved=0  
> > > > >
> > > > > Fix the problem by initializing the node_id properly.
> > > > >
> > > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > > ---
> > > > >  hw/i386/pc.c               |    2 ++
> > > > >  include/hw/i386/topology.h |   11 +++++++++++
> > > > >  2 files changed, 13 insertions(+)
> > > > >
> > > > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > > index 2128f3d6fe..974cc30891 100644
> > > > > --- a/hw/i386/pc.c
> > > > > +++ b/hw/i386/pc.c
> > > > > @@ -1585,6 +1585,8 @@ static void pc_cpu_pre_plug(HotplugHandler  
> > > > *hotplug_dev,  
> > > > >          topo_ids.die_id = cpu->die_id;
> > > > >          topo_ids.core_id = cpu->core_id;
> > > > >          topo_ids.smt_id = cpu->thread_id;
> > > > > +        topo_ids.node_id = cpu_x86_use_epyc_apic_id_encoding(ms-  
> > >cpu_type)  
> > > > ?  
> > > > > +                           x86_node_id_for_epyc(&topo_info, &topo_ids) : 0;  
> > > >
> > > > I'd rather not calculate some default value here,
> > > > this is the branch where we check user provided topology info and error out
> > > > asking
> > > > to provide missing bits.  
> > > Noticed that cpu->node_id is initialized to 0xFF(NUMA_NODE_UNASSIGNED).
> > > We can initialize cpu->node_id to default node like how we do it in
> > > x86_get_default_cpu_node_id.  We can use it to initialize topo_ids.node_id.
> > > This is consistent with other fields core_id, die_id etc..
> > >  
> > > >
> > > > I also wonder if we should force user to specify numa nodes on CLI if EPYC  
> > cpu is  
> > > > used.
> > > > (i.e. I'm assuming that EPYC always requires numa)  
> > >
> > > That is not true. Without numa all the cpus will be configured under one
> > > default numa node 0. Like we do it using x86_get_default_cpu_node_id.  
> > 
> > get_default_cpu_node_id() which is making things up, is going to be removed
> > eventually in favor of asking user to provide numa mapping explicitly on CLI.  
> 
> That will be good going forward.
> 
> > 
> > now if it's always only node 0, why do we need to calculate it then,
> > why not just assing 0 directly?
> > 
> > what if we have several sockets, would all vCPUs still have node-id = 0?  
> 
> If there are several nodes then socket id becomes node id.
I wonder if node id == socket id then why bother with node_id at all,
probably node id is there to allow for design where several sockets are on
the same node


> > Another question is if we have CPUs with only 1 numa node set on all of them,
> > does it require all other machinery like ACPI SRAT table defined or it's just
> > internal CPU impl. detail?  
> 
> I am not very sure about it. To me it looks like it is just internal cpu
> implementation detail.
I'd think it might confuse guest OS, when it decodes more than 1 numa node
for APIC ID/CPUID but then there are no such nodes described in ACPI.
While it might work for caches, it would miss any relation of memory mapping
to nodes or get it wrong if one doesn't match another.


> I think we have two options here.
> 
> 1. Update the patch to initialize the node_id the way it is done
> get_default_cpu_node_id.

if it were only one node for every CPU (incl. multisocket), I'd go with enabling
autonuma assigning all CPUs to default 0 node-id, since there is no ambiguity where
CPUs and RAM are mapped to.
Is it possible to use node-id=0 for all EPYC CPUs even in multisocket config?
(it seems spec allows only one node per socket, but doesn't say that node ids must
be different.)
If not, then making up node-id is not an option. 

> 2. Ask the user to pass the node_id while hot plugging the device. This is
> a clean solution. Will require some data structure changes.

Here is my brain dump of current very non obvious flow:

  1. x86_possible_cpu_arch_ids()
         ms->possible_cpus->cpus[i].props.* = x86_topo_ids_from_idx()

  2. possible numa_cpu_set()
         ms->possible_cpus->cpus[i].props.node_id = user input|0 -in autonuma case

  3. x86_cpus_init()
         // generate apic_id AND makeup node_id embedded into it
         ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(x86ms, i);
                        -> x86_apicid_from_cpu_idx_epyc() -> x86_topo_ids_from_idx_epyc()
                                                                 same as x86_topo_ids_from_idx() + node_id
                     or
                        -> x86_apicid_from_cpu_idx() -> x86_topo_ids_from_idx() 

  4. pc_cpu_pre_plug()
         // basically topo ids module node-id is not set or user provided
         cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);

  5.
         // do it again with diff that in EPYC case it my have different node-id than cpu_slot
         x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);

         //i.e. user input of node-id is ignored
         set socket-id/core-id/... (but not node-id) from topo_info

         numa_cpu_pre_plug(cpu_slot)
                           ^^^^^^
              if (node_id == CPU_UNSET_NUMA_NODE_ID) {
                   if (slot->props.has_node_id)
                       object_property_set_int(... slot->props.node_id, "node-id",...);
              // this applies to hotplugged without node-id and to initial CPUs (-smp X)
              // so we may end up with "node-id" being set to user defined value
              // or left unset (no numa enabled)
              // while APIC ID will have some node-id encoded in it.


that's quite a mess, maybe we should unify both
amd make x86_apicid_from_cpu_idx_epyc()/x86_apicid_from_cpu_idx() use
ms->possible_cpus->cpus[i].props instead of x86_topo_ids_from_idx()
i.e

       x86_apicid_from_cpu_idx_epyc() {
           topoids = x86_apicid_from_cpu_idx() {
                          return ms->possible_cpus->cpus[i].props
                      }
           if (ms->possible_cpus->cpus[i].props.has_node_id)
               topoids.node_id = ms->possible_cpus->cpus[i].props.node_id
           else
               error_fatal("EPYC requires use of -numa to define topology if using more than 1 socket")
       }

that way QEMU makes up only node[0] by enabling autonuma or whatever
user privided explicitly is encoded into APIC ID and it will be always consistent with cpu
*-id properties in possible_cpus and SRAT table QEMU generates.

as cleanup we can get rid of back and forth conversion [5] and use cpu_slot to set
the same ids.

Also maybe we should have a check that node-id is the same within socket in case of EPYC
if it's guarantied that EPYC won't support multiple nodes per socket.

hope it makes at least some sense.


> Let me know if you see any other option.
> 
> > 
> >   
> > > >  
> > > > >          cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info,  
> > &topo_ids);  
> > > > >      }
> > > > >
> > > > > diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> > > > > index 07239f95f4..ee4deb84c4 100644
> > > > > --- a/include/hw/i386/topology.h
> > > > > +++ b/include/hw/i386/topology.h
> > > > > @@ -140,6 +140,17 @@ static inline unsigned  
> > > > apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)  
> > > > >             apicid_node_width_epyc(topo_info);
> > > > >  }
> > > > >
> > > > > +static inline unsigned x86_node_id_for_epyc(X86CPUTopoInfo  
> > *topo_info,  
> > > > > +                                            const X86CPUTopoIDs *topo_ids)
> > > > > +{
> > > > > +    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
> > > > > +    unsigned cores_per_node = DIV_ROUND_UP((topo_info->dies_per_pkg  
> > *  
> > > > > +                                            topo_info->cores_per_die *
> > > > > +                                            topo_info->threads_per_core),
> > > > > +                                            nr_nodes);
> > > > > +
> > > > > +    return (topo_ids->core_id / cores_per_node) % nr_nodes;  
> > > > what if nr_nodes == 0?
> > > >  
> > > > > +}
> > > > >  /*
> > > > >   * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> > > > >   *
> > > > >
> > > > >  
> > >
> > >  
> 



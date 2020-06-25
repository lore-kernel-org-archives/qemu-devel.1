Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0DDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A322B20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL55lp6F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A322B20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWgz-0005Vp-UV
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joWfl-0004cG-UG
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:32:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1joWfi-00049X-8w
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593109944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wgv9h/D92S5BZfGcbm/xX19JaDUjJ+eN0CYc8yRKFow=;
 b=OL55lp6F4pKQ2eB77W8iw1A2FKbRXxyGwJ150csKZT/MiQcSuCQg6hGZqXT+aIh+gRKqr4
 q2C5xBmjHC58OgT4SXLBSmKxHMrF7hlH6T0EEY3XnSiXFTnP7yM9DbB1n9X2pxYVIMGVC/
 w+h5hwJzHJhKXfG+hPSxc0pAOi+LiYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-a823XSsKNoy13MCIt6IQNg-1; Thu, 25 Jun 2020 14:32:20 -0400
X-MC-Unique: a823XSsKNoy13MCIt6IQNg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCBF4107ACCA;
 Thu, 25 Jun 2020 18:32:19 +0000 (UTC)
Received: from localhost (unknown [10.40.208.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C023D5C6BD;
 Thu, 25 Jun 2020 18:32:14 +0000 (UTC)
Date: Thu, 25 Jun 2020 20:32:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and
 CPU hotplug
Message-ID: <20200625202844.07915ed2@redhat.com>
In-Reply-To: <7620a42f-204c-29ac-5a9a-e8c6e2f75ace@amd.com>
References: <159164739269.20543.3074052993891532749.stgit@naples-babu.amd.com>
 <159164753015.20543.7987300339811704895.stgit@naples-babu.amd.com>
 <20200616125901.772229a6@redhat.com>
 <4810d5cd-9409-d2c5-0f0f-1845891c9aad@amd.com>
 <20200624154735.1c104fd8@redhat.com>
 <512e7103-2c20-da48-93e6-4f67e2eac166@amd.com>
 <20200625171831.6decaec9@redhat.com>
 <7620a42f-204c-29ac-5a9a-e8c6e2f75ace@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 02:30:11
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

On Thu, 25 Jun 2020 11:41:25 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Igor,
> 
> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Thursday, June 25, 2020 10:19 AM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: ehabkost@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> > pbonzini@redhat.com; rth@twiddle.net
> > Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and CPU
> > hotplug
> > 
> > On Wed, 24 Jun 2020 12:35:59 -0500
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > Sent: Wednesday, June 24, 2020 8:48 AM
> > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > Cc: ehabkost@redhat.com; mst@redhat.com; qemu-devel@nongnu.org;
> > > > pbonzini@redhat.com; rth@twiddle.net
> > > > Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device and  
> > CPU  
> > > > hotplug
> > > >
> > > > On Tue, 16 Jun 2020 12:18:56 -0500
> > > > Babu Moger <babu.moger@amd.com> wrote:
> > > >  
> > > > > > -----Original Message-----
> > > > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > > > Sent: Tuesday, June 16, 2020 5:59 AM
> > > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > > Cc: pbonzini@redhat.com; rth@twiddle.net; ehabkost@redhat.com;
> > > > > > mst@redhat.com; marcel.apfelbaum@gmail.com; qemu-  
> > devel@nongnu.org  
> > > > > > Subject: Re: [PATCH 1/2] hw/386: Fix uninitialized memory with -device  
> > and  
> > > > CPU  
> > > > > > hotplug
> > > > > >
> > > > > > On Mon, 08 Jun 2020 15:18:50 -0500
> > > > > > Babu Moger <babu.moger@amd.com> wrote:
> > > > > >  
> > > > > > > Noticed the following command failure while testing CPU hotplug.
> > > > > > >
> > > > > > > $ qemu-system-x86_64 -machine q35,accel=kvm -smp 1,maxcpus=2,
> > > > > > >   cores=1, threads=1,sockets=2 -cpu EPYC -device EPYC-x86_64-
> > > > > > >   cpu,core-id=0,socket-id=1,thread-id=0
> > > > > > >
> > > > > > >   qemu-system-x86_64: -device EPYC-x86_64-cpu,core-id=0,socket-  
> > id=1,  
> > > > > > >   thread-id=0: Invalid CPU [socket: 21855, die: 0, core: 0, thread: 0]
> > > > > > >   with APIC ID 21855, valid index range 0:1
> > > > > > >
> > > > > > > This happens because APIC ID is calculated using uninitialized memory.
> > > > > > > This is happening after the addition of new field node_id in  
> > > > X86CPUTopoIDs  
> > > > > > > structure. The node_id field is uninitialized while calling
> > > > > > > apicid_from_topo_ids. The problem is discussed in the thread below.
> > > > > > >  
> > > > > >  
> > > >  
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ker  
> > > > > > nel.org%2Fqemu-
> > > > > >  
> > > >  
> > devel%2F20200602171838.GG577771%40habkost.net%2F&amp;data=02%7C01  
> > > > > >  
> > > >  
> > %7Cbabu.moger%40amd.com%7C02200d75fd8b48d1955608d811e44f5b%7C3d  
> > > > > >  
> > > >  
> > d8961fe4884e608e11a82d994e183d%7C0%7C0%7C637279019564311233&amp  
> > > > > >  
> > > >  
> > ;sdata=ry3QO0Z5dxLPoRxkYVkOsVm3nl%2BxfCGv8be%2BMHdoUPY%3D&amp;r  
> > > > > > eserved=0  
> > > > > > >
> > > > > > > Fix the problem by initializing the node_id properly.
> > > > > > >
> > > > > > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > > > > > ---
> > > > > > >  hw/i386/pc.c               |    2 ++
> > > > > > >  include/hw/i386/topology.h |   11 +++++++++++
> > > > > > >  2 files changed, 13 insertions(+)
> > > > > > >
> > > > > > > diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> > > > > > > index 2128f3d6fe..974cc30891 100644
> > > > > > > --- a/hw/i386/pc.c
> > > > > > > +++ b/hw/i386/pc.c
> > > > > > > @@ -1585,6 +1585,8 @@ static void pc_cpu_pre_plug(HotplugHandler  
> > > > > > *hotplug_dev,  
> > > > > > >          topo_ids.die_id = cpu->die_id;
> > > > > > >          topo_ids.core_id = cpu->core_id;
> > > > > > >          topo_ids.smt_id = cpu->thread_id;
> > > > > > > +        topo_ids.node_id = cpu_x86_use_epyc_apic_id_encoding(ms-  
> > > > >cpu_type)  
> > > > > > ?  
> > > > > > > +                           x86_node_id_for_epyc(&topo_info, &topo_ids) : 0;  
> > > > > >
> > > > > > I'd rather not calculate some default value here,
> > > > > > this is the branch where we check user provided topology info and error  
> > out  
> > > > > > asking
> > > > > > to provide missing bits.  
> > > > > Noticed that cpu->node_id is initialized to  
> > 0xFF(NUMA_NODE_UNASSIGNED).  
> > > > > We can initialize cpu->node_id to default node like how we do it in
> > > > > x86_get_default_cpu_node_id.  We can use it to initialize  
> > topo_ids.node_id.  
> > > > > This is consistent with other fields core_id, die_id etc..
> > > > >  
> > > > > >
> > > > > > I also wonder if we should force user to specify numa nodes on CLI if  
> > EPYC  
> > > > cpu is  
> > > > > > used.
> > > > > > (i.e. I'm assuming that EPYC always requires numa)  
> > > > >
> > > > > That is not true. Without numa all the cpus will be configured under one
> > > > > default numa node 0. Like we do it using x86_get_default_cpu_node_id.  
> > > >
> > > > get_default_cpu_node_id() which is making things up, is going to be  
> > removed  
> > > > eventually in favor of asking user to provide numa mapping explicitly on CLI.  
> > >
> > > That will be good going forward.
> > >  
> > > >
> > > > now if it's always only node 0, why do we need to calculate it then,
> > > > why not just assing 0 directly?
> > > >
> > > > what if we have several sockets, would all vCPUs still have node-id = 0?  
> > >
> > > If there are several nodes then socket id becomes node id.  
> > I wonder if node id == socket id then why bother with node_id at all,
> > probably node id is there to allow for design where several sockets are on
> > the same node
> > 
> >   
> > > > Another question is if we have CPUs with only 1 numa node set on all of  
> > them,  
> > > > does it require all other machinery like ACPI SRAT table defined or it's just
> > > > internal CPU impl. detail?  
> > >
> > > I am not very sure about it. To me it looks like it is just internal cpu
> > > implementation detail.  
> > I'd think it might confuse guest OS, when it decodes more than 1 numa node
> > for APIC ID/CPUID but then there are no such nodes described in ACPI.
> > While it might work for caches, it would miss any relation of memory mapping
> > to nodes or get it wrong if one doesn't match another.
> > 
> >   
> > > I think we have two options here.
> > >
> > > 1. Update the patch to initialize the node_id the way it is done
> > > get_default_cpu_node_id.  
> > 
> > if it were only one node for every CPU (incl. multisocket), I'd go with enabling
> > autonuma assigning all CPUs to default 0 node-id, since there is no ambiguity
> > where
> > CPUs and RAM are mapped to.
> > Is it possible to use node-id=0 for all EPYC CPUs even in multisocket config?
> > (it seems spec allows only one node per socket, but doesn't say that node ids
> > must
> > be different.)
> > If not, then making up node-id is not an option.
> >   
> > > 2. Ask the user to pass the node_id while hot plugging the device. This is
> > > a clean solution. Will require some data structure changes.  
> > 
> > Here is my brain dump of current very non obvious flow:
> > 
> >   1. x86_possible_cpu_arch_ids()
> >          ms->possible_cpus->cpus[i].props.* = x86_topo_ids_from_idx()
> > 
> >   2. possible numa_cpu_set()
> >          ms->possible_cpus->cpus[i].props.node_id = user input|0 -in autonuma
> > case
> > 
> >   3. x86_cpus_init()
> >          // generate apic_id AND makeup node_id embedded into it
> >          ms->possible_cpus->cpus[i].arch_id = x86_cpu_apic_id_from_index(x86ms,
> > i);  
> >                         -> x86_apicid_from_cpu_idx_epyc() ->  
> > x86_topo_ids_from_idx_epyc()
> >                                                                  same as x86_topo_ids_from_idx() + node_id
> >                      or  
> >                         -> x86_apicid_from_cpu_idx() -> x86_topo_ids_from_idx()  
> > 
> >   4. pc_cpu_pre_plug()
> >          // basically topo ids module node-id is not set or user provided
> >          cpu_slot = pc_find_cpu_slot(MACHINE(pcms), cpu->apic_id, &idx);
> > 
> >   5.
> >          // do it again with diff that in EPYC case it my have different node-id than
> > cpu_slot
> >          x86ms->topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
> > 
> >          //i.e. user input of node-id is ignored
> >          set socket-id/core-id/... (but not node-id) from topo_info
> > 
> >          numa_cpu_pre_plug(cpu_slot)
> >                            ^^^^^^
> >               if (node_id == CPU_UNSET_NUMA_NODE_ID) {
> >                    if (slot->props.has_node_id)
> >                        object_property_set_int(... slot->props.node_id, "node-id",...);
> >               // this applies to hotplugged without node-id and to initial CPUs (-smp X)
> >               // so we may end up with "node-id" being set to user defined value
> >               // or left unset (no numa enabled)
> >               // while APIC ID will have some node-id encoded in it.
> > 
> > 
> > that's quite a mess, maybe we should unify both
> > amd make x86_apicid_from_cpu_idx_epyc()/x86_apicid_from_cpu_idx() use
> > ms->possible_cpus->cpus[i].props instead of x86_topo_ids_from_idx()
> > i.e
> > 
> >        x86_apicid_from_cpu_idx_epyc() {
> >            topoids = x86_apicid_from_cpu_idx() {
> >                           return ms->possible_cpus->cpus[i].props
> >                       }
> >            if (ms->possible_cpus->cpus[i].props.has_node_id)
> >                topoids.node_id = ms->possible_cpus->cpus[i].props.node_id
> >            else
> >                error_fatal("EPYC requires use of -numa to define topology if using
> > more than 1 socket")
> >        }
> > 
> > that way QEMU makes up only node[0] by enabling autonuma or whatever
> > user privided explicitly is encoded into APIC ID and it will be always consistent
> > with cpu
> > *-id properties in possible_cpus and SRAT table QEMU generates.
> > 
> > as cleanup we can get rid of back and forth conversion [5] and use cpu_slot to
> > set
> > the same ids.
> > 
> > Also maybe we should have a check that node-id is the same within socket in
> > case of EPYC
> > if it's guarantied that EPYC won't support multiple nodes per socket.
> > 
> > hope it makes at least some sense.  
> 
> To make things clear, in case of autonuma we don't have to worry about
> node_id. We just have to set it topo_ids.node_id to 0 in pc_cpu_pre_plug,
> Everything will work as expected. This will solve our current problem of
> uninitialized variable.

I'm proposing to enable autonuma, which in its turn will assign all CPUs to
node-id=0 in possible_cpus. And once this information is in possible_cpus,
numa_cpu_pre_plug() should take care of setting correct node-id on CPU for
the case of initial CPUs (node_id == CPU_UNSET_NUMA_NODE_ID), and in case
of hotplug numa_cpu_pre_plug() will complaing if user suppled nonsense on
with device_add.

> Problem here is, when user has configured the numa, then setting the
> topo_ids.node_id to 0 might not work because it might create duplicate
> apicids and device_add will be rejected.  As per the comments in
I don't see how such duplicate could be made, even if all CPUs have 0
node-id, there are pkg_id/core_id/thread_id wich are encoded in APIC ID,
where pkg_id is unique across machine (at least in QEMU), so I don't see
how duplicate is possible.

> numa_cpu_pre_plug, this is already broken. Look at the comments below.
> Looks like node_id cannot be passed down.
> ============================================
> if (node_id == CPU_UNSET_NUMA_NODE_ID) {
>         /* due to bug in libvirt, it doesn't pass node-id from props on
>          * device_add as expected, so we have to fix it up here */
>         if (slot->props.has_node_id) {
>             object_property_set_int(OBJECT(dev), slot->props.node_id,
>                                     "node-id", errp);
>         }
          else if (epyc)
             error("incomplete EPYC topology use -numa cpu,node-id=some-id,socket-id=%d  to configure numa node for socket",
                    cpu_socket_id)

>     } else if (node_id != slot->props.node_id) {
> ============================================
> 
> I was trying to solve this problem setting the node_id correctly for EPYC
> at least.  If you think, this is not important we can ignore it (by
> setting topo_ids.node_id to 0) and move forward.  I don't see the need for
> changing other topology specific code as we have already made very generic.

node-id - can be passed down (problem was that libvird didn't do it back then
for -device/device_add, hence above hack).

But that's not a problem, the problem is that x86_apicid_from_cpu_idx_epyc() makes
up node-id on its own, which is not big deal in case of autonuma since they happen
to match and there aren't any ambiguity, but with more numa nodes, numa config should
be defined by user explicitly and current code may end up with incoherent config,
where some parts of QEMU think CPU has one node-id while APIC ID is encoded with another. 

So after some pondering on a subject, to make sure it will look correct from all angles,
we need to:
 
 1: use single source for topo ids, i.e. pull user provided node-id from possible_cpus
    for both cpu.node-id property and for APIC ID. Hence my suggestion to change
    x86_apicid_from_cpu_idx_epyc() as described above.

 2: verify that user provided id's make sense in EPYC case. (pre_plug)

> > > Let me know if you see any other option.
> > >  
> > > >
> > > >  
> > > > > >  
> > > > > > >          cpu->apic_id = x86ms->apicid_from_topo_ids(&topo_info,  
> > > > &topo_ids);  
> > > > > > >      }
> > > > > > >
> > > > > > > diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
> > > > > > > index 07239f95f4..ee4deb84c4 100644
> > > > > > > --- a/include/hw/i386/topology.h
> > > > > > > +++ b/include/hw/i386/topology.h
> > > > > > > @@ -140,6 +140,17 @@ static inline unsigned  
> > > > > > apicid_pkg_offset_epyc(X86CPUTopoInfo *topo_info)  
> > > > > > >             apicid_node_width_epyc(topo_info);
> > > > > > >  }
> > > > > > >
> > > > > > > +static inline unsigned x86_node_id_for_epyc(X86CPUTopoInfo  
> > > > *topo_info,  
> > > > > > > +                                            const X86CPUTopoIDs *topo_ids)
> > > > > > > +{
> > > > > > > +    unsigned nr_nodes = MAX(topo_info->nodes_per_pkg, 1);
> > > > > > > +    unsigned cores_per_node = DIV_ROUND_UP((topo_info-  
> > >dies_per_pkg  
> > > > *  
> > > > > > > +                                            topo_info->cores_per_die *
> > > > > > > +                                            topo_info->threads_per_core),
> > > > > > > +                                            nr_nodes);
> > > > > > > +
> > > > > > > +    return (topo_ids->core_id / cores_per_node) % nr_nodes;  
> > > > > > what if nr_nodes == 0?
> > > > > >  
> > > > > > > +}
> > > > > > >  /*
> > > > > > >   * Make APIC ID for the CPU based on Pkg_ID, Core_ID, SMT_ID
> > > > > > >   *
> > > > > > >
> > > > > > >  
> > > > >
> > > > >  
> > >  
> 



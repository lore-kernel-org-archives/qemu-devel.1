Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9ACC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5672074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJ/aD/3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5672074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16m4-0001Dg-G3
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k16ii-0005W0-Ua
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:27:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52173
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k16id-0005F2-SD
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596108446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vHT6pWEf8wNB0CuahHgBy1K/auSOt5XaDh5WKFta4+k=;
 b=dJ/aD/3rD7xEhOzxkHcuNCiKB3nJk+8IFLulrlo2gyD1Oe9+BO7tTGw/Kgthc6cjGyvt7X
 65kYzfYyonLvHP3K2R01d8txRd7M3kKPnNAuqrsTRi8cUrt6RRq8Mjuvul7BLMbjAHZiRp
 1LDs9/ZFbeEGh9xKEFtvB4DYQ8HoHYE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-XYmF6pxtNrONbVXsZdLuuA-1; Thu, 30 Jul 2020 07:27:24 -0400
X-MC-Unique: XYmF6pxtNrONbVXsZdLuuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74CFE1DF3;
 Thu, 30 Jul 2020 11:27:23 +0000 (UTC)
Received: from localhost (unknown [10.40.208.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B87B619C4;
 Thu, 30 Jul 2020 11:27:21 +0000 (UTC)
Date: Thu, 30 Jul 2020 13:27:20 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
 CpuInstanceProperties
Message-ID: <20200730132720.49206d44@redhat.com>
In-Reply-To: <e0b8086f-3678-37ea-aab8-ca5163ecee07@amd.com>
References: <159362436285.36204.986406297373871949.stgit@naples-babu.amd.com>
 <159362466108.36204.3751851750959980962.stgit@naples-babu.amd.com>
 <20200713110822.5495e1c6@redhat.com>
 <78809d9f-a491-8c99-3f35-7f012c7d75bf@amd.com>
 <20200713181740.16a357a6@redhat.com>
 <47dc6238-bb71-d679-f58a-f574eb36d572@amd.com>
 <20200713193221.27674630@redhat.com>
 <4003b476-afdb-74a1-4f9f-1387aae6c4e8@amd.com>
 <20200724190518.0f7a2b6b@redhat.com>
 <5b32c961-4fd0-8b8c-4475-eafff2ae48a9@amd.com>
 <20200727191416.2bf6e34a@redhat.com>
 <5df170bd-ea91-8347-a2cf-7ac234248197@amd.com>
 <20200729161213.3daa3933@redhat.com>
 <e0b8086f-3678-37ea-aab8-ca5163ecee07@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Jul 2020 16:22:32 -0500
Babu Moger <babu.moger@amd.com> wrote:

> Igor,
> Sorry. Few more questions.
> 
> > -----Original Message-----
> > From: Igor Mammedov <imammedo@redhat.com>
> > Sent: Wednesday, July 29, 2020 9:12 AM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: pbonzini@redhat.com; rth@twiddle.net; qemu-devel@nongnu.org;
> > ehabkost@redhat.com
> > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > CpuInstanceProperties
> > 
> > On Mon, 27 Jul 2020 18:59:42 -0500
> > Babu Moger <babu.moger@amd.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > Sent: Monday, July 27, 2020 12:14 PM
> > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com;  
> > ehabkost@redhat.com;  
> > > > rth@twiddle.net
> > > > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > > CpuInstanceProperties
> > > >
> > > > On Mon, 27 Jul 2020 10:49:08 -0500
> > > > Babu Moger <babu.moger@amd.com> wrote:
> > > >  
> > > > > > -----Original Message-----
> > > > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > > > Sent: Friday, July 24, 2020 12:05 PM
> > > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > > Cc: qemu-devel@nongnu.org; pbonzini@redhat.com;  
> > > > ehabkost@redhat.com;  
> > > > > > rth@twiddle.net
> > > > > > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids from
> > > > > > CpuInstanceProperties
> > > > > >
> > > > > > On Mon, 13 Jul 2020 14:30:29 -0500 Babu Moger
> > > > > > <babu.moger@amd.com> wrote:
> > > > > >  
> > > > > > > > -----Original Message-----
> > > > > > > > From: Igor Mammedov <imammedo@redhat.com>
> > > > > > > > Sent: Monday, July 13, 2020 12:32 PM
> > > > > > > > To: Moger, Babu <Babu.Moger@amd.com>
> > > > > > > > Cc: pbonzini@redhat.com; rth@twiddle.net;
> > > > > > > > ehabkost@redhat.com;
> > > > > > > > qemu- devel@nongnu.org
> > > > > > > > Subject: Re: [PATCH v2 1/3] hw/i386: Initialize topo_ids
> > > > > > > > from CpuInstanceProperties
> > > > > > > >
> > > > > > > > On Mon, 13 Jul 2020 11:43:33 -0500 Babu Moger
> > > > > > > > <babu.moger@amd.com> wrote:
> > > > > > > >  
> > > > > > > > > On 7/13/20 11:17 AM, Igor Mammedov wrote:  
> > > > > > > > > > On Mon, 13 Jul 2020 10:02:22 -0500 Babu Moger
> > > > > > > > > > <babu.moger@amd.com> wrote:
> > > > > > > > > >  
> > > > > > > > > >>> -----Original Message-----
> > > > > > > > > >>> From: Igor Mammedov <imammedo@redhat.com>
> > > > > > > > > >>> Sent: Monday, July 13, 2020 4:08 AM
> > > > > > > > > >>> To: Moger, Babu <Babu.Moger@amd.com>
> > > > > > > > > >>> Cc: pbonzini@redhat.com; rth@twiddle.net;
> > > > > > > > > >>> ehabkost@redhat.com;
> > > > > > > > > >>> qemu- devel@nongnu.org
> > > > > > > > > >>> Subject: Re: [PATCH v2 1/3] hw/i386: Initialize
> > > > > > > > > >>> topo_ids from CpuInstanceProperties  
[...]

> > > > > There will be complications when user configures with both die_id
> > > > > and numa_id. It will complicate things further. I will have to
> > > > > look closely at the code if it is feasible.  
> > > >
> > > > it's worth a try.
> > > > conseptionally die_id in intel/amd is the same. Most likely intel
> > > > has a dedicated memory controller on each die so it still should
> > > > form a NUMA node. But that aspect probably was ignored while
> > > > implementing it in QEMU so ping of configuring QEMU right is on
> > > > user's shoulders (there is no checks whatsoever if cpu belonging to specific  
> > die is on right NUMA node).  
> > >
> > > So you are suggesting to use die_id to build the topology for EPYC.
> > > Also initialize die_id based on the numa information. Re-arrange the
> > > numa code to make sure we have all the information before we build the
> > > topology. And then remove the node_id inside X86CPUTopoIDs. Is that the  
> > plan?
> > reusing die_id might simplify logic and at very least we won't have 2 very similar
> > fields to deal with. With die_id it should be conditional on EPYC.  
> 
> Not convinced if the using the die_id will solve the problem here. But
> going to investigate this little bit.
it allows  us to drop nodes_per_pkg calculation with its dependency on numa,
since it's provided by user with -smp dies=

We might need a sanity check that user provided value is valid in case on EPYC though.

> > > Regardless of using die_id, we should  
> > 
> > (1) error out if tolopolgy will require more than 1 numa node and no numa
> > config was provided.  
> 
> We already have node_id check in numa_cpu_pre_plug. Do you want me to
> bring this check in pc_cpu_pre_plug?

There are several checks there and that includes validating per CPU node-id
values and workarounds for broken libvirt.

Where I'm talking more about number of numa nodes required f(-smp dies,-cpu EPYC),
like:
  if (dies>1 && epyc && nb_numa_nodes != sockets * dies)
     error_steg("chosen cpu model ... and -smp ... parameters require X numa nodes being configured")
     error_append_hint("use -numa options to create requred number of numa nodes")

I'm not sure where put it in for now, we can try to put it into x86_cpus_init()
for starters and later see if there is more sutable place for it.


> > (2) for 1 NUMA node use autonuma to create 1 node implicitly, that requres
> > converting static MachineClass::auto_enable_numa into an instance specific
> > value, i.e. moving it into MachineState, so that we can change it at runtime
> > depending on CPU type.  
> 
> Isn't it already taken care in numa_complete_configuration when num_nodes
> = 0? Where does this change go if at all required?
numa_complete_configuration()
...
    if (ms->numa_state->num_nodes == 0 &&                                        
        ((ms->ram_slots && mc->auto_enable_numa_with_memhp) ||                   
         (ms->maxram_size > ms->ram_size && mc->auto_enable_numa_with_memdev) || 
         mc->auto_enable_numa)) {                                                
            NumaNodeOptions node = { };                                          
            parse_numa_node(ms, &node, &error_abort);                            
            numa_info[0].node_mem = ram_size;                                    
    }

that is a fragment that takes care of implict creation of the single numa node.
lets ignore *numa_with_* cases and look into mc->auto_enable_numa.
It is MachineClass field and we are not supposed to change it at runtime,
but we need to enable it in case options specify 1 node config, i.e.

  "-cpu epyc -smp x,sockets=1,dies=1"

so we need to trigger auto_enable_numa depending on above condition.
Looking at the current code there is no good place to put it in.

we can try to replace MachineClass::auto_enable_numa with callback
  bool MachineClass::auto_enable_numa_cb(MachineState *ms)
so we can change logic at runtime where it's needed.

> 
> > (3) use NUMA id from CPU::node-id for CPUID_8000001E and have a checks that
> > will ensure
> >     that used value is possible to fit in CPUID leaf.  
> 
> Node_id is already part of apic_id. We can easily extract it from apic_id.
> I have already sent the patch to simplify CPUID_8000001E. I will make it
> part of this series.
> https://lore.kernel.org/qemu-devel/159164753686.20543.4158548114186964547.stgit@naples-babu.amd.com/
that's where confusion in naming gets in a way:
let's set following difinitions for purpose of this discussion/QEMU
   node_id = system wide NUMA node id  
   AMD's ApicId[5:4] = die_id

what AMD encodes in APIC ID is not a node_id but reather an index of a node within package.
Even in spec in one place it's called "Node ID" but in another place it's reffered as DIE_ID.

Whith that cleared up, following CPUID defined as
CPUID_Fn8000001E_ECX[7:0] = NodeId
but it's not the same as ApicId[5:4], description says it's {5'b00000,1'b[SOCKET_ID],2'b[DIE_ID]}.
and CPUID dump from EPYC machine confirms that. It also matches with system wide NUMA node ids
encoded in SRAT table.
So above pointed patch is incorrect wrt CPUID_Fn8000001E_ECX.

Considering we allow for more nodes than existing EPYCs can have,
I'd rather it would take value of NUMA node id from CPU's "node-id" property
with a check that it fits within CPUID_Fn8000001E_ECX[7:0] space at realize time,
to ensure that NUMA node ids are consistent with what user provides and ACPI tables.

   
> > 
> > 
> > 
> >   
> > > > What AMD has implemented on top of that in CPU hw, is to expose NUMA
> > > > node id in CPUID_8000001E. I don't know why it was done as usually
> > > > it's ACPI tables that describe relations between nodes so for OS
> > > > this info almost useless (I'd guess it's faster to use CPUID instead
> > > > of fetching pre-cpu variable but that's pretty much it from OS point
> > > > of view)
> > > >  
> > > > >  
> > > > > >
> > > > > >
> > > > > >  
> > > > > > > > > >>>> +    topo_ids->pkg_id = props.has_socket_id ? props.socket_id  
> > :  
> > > > > > > > > >>>> +0; }
> > > > > > > > > >>>>  /*
> > > > > > > > > >>>>   * Make APIC ID for the CPU 'cpu_index'
> > > > > > > > > >>>>   *
> > > > > > > > > >>>>  
> > > > > > > > > >>  
> > > > > > > > > >  
> > > > > > > > >  
> > > > > > >
> > > > > > >  
> > > > >  
> > >
> > >  
> 



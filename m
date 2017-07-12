Received: from eggs.gnu.org ([2001:4830:134:3::10]:46946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1dVG0W-0005fp-RM
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbhat@linux.vnet.ibm.com>) id 1dVG0T-0007QA-HV
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:40:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbhat@linux.vnet.ibm.com>)
	id 1dVG0S-0007Lf-NI
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:40:37 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6CBd5aa082637
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:40:34 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bncj4xx27-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 07:40:34 -0400
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sbhat@linux.vnet.ibm.com>;
	Wed, 12 Jul 2017 21:40:31 +1000
References: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
	<20170704072901.GA2180@umbus.fritz.box>
	<20170704104722.499d4e86@bahia.lan>
	<1499856934.13989.38.camel@redhat.com>
From: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 17:09:37 +0530
MIME-Version: 1.0
In-Reply-To: <1499856934.13989.38.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <68cfb52b-d4cc-1980-e6f5-a454baf4e2e5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: make default PHB optionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, libvir-list@redhat.com



On 07/12/2017 04:25 PM, Andrea Bolognani wrote:
> [libvir-list added to the loop]
>
> On Tue, 2017-07-04 at 10:47 +0200, Greg Kurz wrote:
>> On Tue, 4 Jul 2017 17:29:01 +1000 David Gibson <david@gibson.dropbear.id.au> wrote:
>>> On Mon, Jul 03, 2017 at 06:48:25PM +0200, Greg Kurz wrote:
>>>>   
>>>> The sPAPR machine always create a default PHB during initialization, even
>>>> if -nodefaults was passed on the command line. This forces the user to
>>>> rely on -global if she wants to set properties of the default PHB, such
>>>> as numa_node.
>>>>   
>>>> This patch introduces a new machine create-default-phb property to control
>>>> whether the default PHB must be created or not. It defaults to on in order
>>>> to preserve old setups (which is also the motivation to not alter the
>>>> current behavior of -nodefaults).
>>>>   
>>>> If create-default-phb is set to off, the default PHB isn't created, nor
>>>> any other device usually created with it. It is mandatory to provide
>>>> a PHB on the command line to be able to use PCI devices (otherwise QEMU
>>>> won't start). For example, the following creates a PHB with the same
>>>> mappings as the default PHB and also sets the NUMA affinity:
>>>>   
>>>>       -machine type=pseries,create-default-phb=off \
>>>>       -numa node,nodeid=0 -device spapr-pci-host-bridge,index=0,numa_node=0
>>>   
>>> So, I agree that the distinction between default devices that are
>>> disabled with -nodefaults and default devices that aren't is a big
>>> mess in qemu configuration.  But on the other hand this only addresses
>>> one tiny aspect of that, and in the meantime means we will silently
>>> ignore some other configuration options in some conditions.
>>>   
>>> So, what's the immediate benefit / use case for this?

Setting numa_node for emulated devices is the benefit for now. On x86, I 
figured there is
no way to set the numa_node for the root controller and the emulated 
devices sitting there
all have numa_node set to -1. Only the devices on the pxb can have a 
sensible value specified.
Does it mean, the emulated devices/drivers don't care about the 
numa_node they are on?

Would it be fine on PPC to disallow setting the NUMA node for the 
default PHB because that is where
all the emulated devices sit ?

>>   
>> With the current code base, the only way to set properties of the default
>> PHB, is to pass -global spapr-pci-host-bridge.prop=value for each property.
>> The immediate benefit of this patch is to unify the way libvirt passes
>> PHB description to the command line:
>>   
>> ie, do:
>>   
>>       -machine type=pseries,create-default-phb=off \
>>       -device spapr-pci-host-bridge,prop1=a,prop2=b,prop3=c \
>>       -device spapr-pci-host-bridge,prop1=d,prop2=e,prop3=f
>>   
>> instead of:
>>   
>>       -machine type=pseries \
>>       -global spapr-pci-host-bridge.prop1=a \
>>       -global spapr-pci-host-bridge.prop2=b \
>>       -global spapr-pci-host-bridge.prop3=c \
>>       -device spapr-pci-host-bridge,prop1=d,prop2=e,prop3=f
> So, I'm thinking about this mostly in terms of NUMA nodes
> because that's the use case I'm aware of.
>
> The problem with using -global is not that it requires using
> a different syntax to set properties for the default PHB,
> but rather that such properties are then inherited by all
> other PHBs unless explicitly overridden. Not creating the
> default PHB at all would solve the issue.
>
> On the other hand, libvirt would then need to either
>
>    1) only allow setting NUMA nodes for PHBs if QEMU supports
>       the new option, leaving QEMU < 2.10 users behind; or
>
>    2) implement handling for both the new and old behavior.
>
> I'm not sure we could get away with 1), and going for 2)
> means more work both for QEMU and libvirt developers for
> very little actual gain, so I'd be inclined to scrap this
> and just build the libvirt glue on top of the existing
> interface.
>
> That is, of course, unless
>
>    1) having a random selection of PHBs not assigned to any
>       NUMA node is a sensible use case. This is something
>       we just can't do reliably with the current interface:
>       we can decide to set the NUMA node only for say, PHBs
>       1 and 3 leaving 0 and 2 alone, but once we set it for
>       the default PHB we *have* to set it for all remaining
>       ones as well. libvirt will by default assign emulated
>       devices to the default PHB, so I would rather expect
>       users to leave that one alone and set a NUMA node for
>       all other PHBs; or
>
>    2) there are other properties outside of numa_node we
>       might want to deal with; or
>
>    3) it turns out it's okay to require a recent QEMU :)
>
> -- 
> Andrea Bolognani / Red Hat / Virtualization
>

Received: from eggs.gnu.org ([2001:4830:134:3::10]:53666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1diSOD-0004xk-K6
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 17:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1diSOB-0002MV-2K
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 17:31:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46520
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1diSOA-0002Lr-TQ
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 17:31:38 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7HLSkMr026678
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 17:31:36 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cdg4qsbrf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 17:31:36 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Thu, 17 Aug 2017 17:31:35 -0400
References: <20170815202846.24749-1-danielhb@linux.vnet.ibm.com>
	<20170817075236.GI5509@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Thu, 17 Aug 2017 18:31:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170817075236.GI5509@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <bfc6e0bb-af59-f5b4-f50b-66feab7dc301@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc: disable hotplug before
 CAS is completed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com



On 08/17/2017 04:52 AM, David Gibson wrote:
> On Tue, Aug 15, 2017 at 05:28:46PM -0300, Daniel Henrique Barboza wrote:
>> This patch is a follow up on the discussions that started with
>> Laurent's patch series "spapr: disable hotplugging without OS" [1]
>> and discussions made at patch "spapr: reset DRCs on migration
>> pre_load" [2].
>>
>> At this moment, we do not support CPU/memory hotplug in early
>> boot stages, before CAS. The reason is that the hotplug event
>> can't be handled at SLOF level (or even in PRELAUNCH runstate) and
>> at the same time can't be canceled. This leads to devices being
>> unable to be hot unplugged and, in some cases, guest kernel Ooops.
>> After CAS, with the FDT in place, the guest can handle the hotplug
>> events and everything works as usual.
>>
>> An attempt to try to support hotplug before CAS was made, but not
>> successful. The key difference in the current code flow between a
>> coldplugged and a hotplugged device, in the PRELAUNCH state, is that
>> the coldplugged device is registered at the base FDT, allowing its
>> DRC to go straight to CONFIGURED state. In theory, this can also be
>> done with a hotplugged device if we can add it to the base of the
>> existing FDT. However, tampering with the FDT after writing in the
>> guest memory, besides being a dubitable idea, is also not
>> possible. The FDT is written in ppc_spapr_reset and there is no
>> way to retrieve it - we can calculate the fdt_address but the
>> fdt_size isn't stored. Storing the fdt_size to allow for
>> later retrieval is yet another state that would need to be
>> migrated. In short, it is not worth the trouble.
>>
>> All this said, this patch opted to disable CPU/mem hotplug at early
>> boot stages. CAS detection is made by checking if there are
>> any bits set in ov5_cas to avoid adding an extra state that
>> would need tracking/migration. The patch also makes sure that
>> it doesn't interfere with hotplug in the INMIGRATE state.
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05226.html
>> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01989.html
>>
>> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> I don't think this is a good idea.
>
> 1) After my DRC cleanups, early hotplug works just fine for me.  I'm
> not sure why it isn't for you: we need to understand that before
> proceeding.
>
> 2) libvirt actually uses early hotplug fairly often (before even
> starting the firmware).  At the moment this works - at least in some
> cases (see above), though there are some wrinkles to work out.  This
> will break it completely and require an entirely different approach to
> fix again.

Now that you mentioned I remember having this same discussion with you,
about the same topic. Back then we decided to leave it alone, since you 
couldn't
reproduce the behavior but I could.

I still can reproduce this bug and ended up investigating a bit more today:


- one difference in QEMU between hotplugging before and after CAS is here:

hw/ppc/spapr_events.c - rtas_event_log_to_source

     switch (log_type) {
     case RTAS_LOG_TYPE_HOTPLUG:
         source = spapr_event_sources_get_source(spapr->event_sources,
EVENT_CLASS_HOT_PLUG);
         if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
             g_assert(source->enabled);
             break;
         }
         /* fall back to epow for legacy hotplug interrupt source */
     case RTAS_LOG_TYPE_EPOW:
         source = spapr_event_sources_get_source(spapr->event_sources,
                                                 EVENT_CLASS_EPOW);
         break;
     default:


Note the ovec_test for OV5_HP_EVT. When hotplugging a CPU In early boot, 
ov5_cas
doesn't have anything set, making this check fails and due to the 
'break' position there
(that I believe it is intended), it falls back to log the event as EPOW 
instead of HOT_PLUG.

I tried to hack this code by adding another break and ensure that the 
event got logged
as HOT_PLUG (like it happens in the post-CAS) but then I got a kernel 
panic at boot. So
I am not sure if this code needs any change or afterthought.

- hotplugging the CPU at early stage gives me a warning message in SLOF:

--------------

Calling ibm,client-architecture-support...Node not supported
Node not supported
  not implemented
memory layout at init:
---------------

The code that gives the 'Node not supported' message is related to the 
fdt-create-cas-node
function of board-qemu/slof/fdt.fs . The code is looking for either 
"memory@" or
"ibm,dynamic-reconfiguration-memory" nodes, giving this error when finding a
CPU node.


- if I hotplug another CPU after the guest completes the boot, the 
previously added
CPU suddenly turns online too:

[ started VM with -S ]

(qemu) device_add host-spapr-cpu-core,id=core1,core-id=1
(qemu) cont

[ guest finishes boot ]

danielhb@ubuntu1710:~$ lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              1
On-line CPU(s) list: 0
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           1
NUMA node(s):        1
Model:               2.1 (pvr 004b 0201)
Model name:          POWER8E (raw), altivec supported
Hypervisor vendor:   KVM
Virtualization type: para
L1d cache:           64K
L1i cache:           32K
NUMA node0 CPU(s):   0
danielhb@ubuntu1710:~$
danielhb@ubuntu1710:~$
danielhb@ubuntu1710:~$ (qemu)
(qemu) info cpus
* CPU #0: nip=0xc0000000000a464c thread_id=131946
   CPU #1: nip=0x0000000000000000 (halted) thread_id=131954
(qemu)
(qemu) device_add host-spapr-cpu-core,id=core2,core-id=2
(qemu)
(qemu) info cpus
* CPU #0: nip=0xc0000000000a464c thread_id=131946
   CPU #1: nip=0xc0000000000a464c thread_id=131954
   CPU #2: nip=0xc0000000000a464c thread_id=132144
(qemu)

danielhb@ubuntu1710:~$ lscpu
Architecture:        ppc64le
Byte Order:          Little Endian
CPU(s):              3
On-line CPU(s) list: 0-2
Thread(s) per core:  1
Core(s) per socket:  3
Socket(s):           1
NUMA node(s):        1
Model:               2.1 (pvr 004b 0201)
Model name:          POWER8E (raw), altivec supported
Hypervisor vendor:   KVM
Virtualization type: para
L1d cache:           64K
L1i cache:           32K
NUMA node0 CPU(s):   0-2
danielhb@ubuntu1710:~$


This makes me believe that the issue is that the guest isn't aware of 
the CPU
presence, making me wonder whether this has something to do with the 
qemu_irq_pulse
in the end of spapr_hotplug_req_event being lost. In the second hotplug, we
re-assert the IRQ in the end of check-exception and the guest is made 
aware of
the queued hotplug event that was ignored at first.



Daniel
>
> 3) There's no fundamental reason early hotplug shouldn't work - the
> event will just be queued until the OS boots and processes it.
>
> I know I suggested disabling early hotplug earlier, but that was
> before I'd dug into the DRC layer and properly understood what was
> going on here.
>

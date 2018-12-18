Received: from eggs.gnu.org ([2001:4830:134:3::10]:37841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gZCxK-0006QL-Qz
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gZCxG-0002c5-Do
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:50:30 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:32859)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gZCxG-0002aZ-5X
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:50:26 -0500
Received: from player792.ha.ovh.net (unknown [10.109.159.136])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 88BF6E6FE1
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 11:50:24 +0100 (CET)
Date: Tue, 18 Dec 2018 11:50:15 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181218115015.1564d0a2@bahia.lan>
In-Reply-To: <639bdcc3-3974-b762-2089-808fd55d9226@redhat.com>
References: <20181217140055.8545-1-lvivier@redhat.com>
	<20181218042938.GI23604@umbus.fritz.box>
	<8cf7e664-27e6-d4f4-ea71-29a61a3122e6@redhat.com>
	<20181218102311.68400aa5@bahia.lan>
	<639bdcc3-3974-b762-2089-808fd55d9226@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr: Add H-Call
 H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 18 Dec 2018 11:00:01 +0100
Laurent Vivier <lvivier@redhat.com> wrote:

> On 18/12/2018 10:23, Greg Kurz wrote:
> > On Tue, 18 Dec 2018 08:50:00 +0100
> > Laurent Vivier <lvivier@redhat.com> wrote:
> >   
> >> On 18/12/2018 05:29, David Gibson wrote:  
> >>> On Mon, Dec 17, 2018 at 03:00:55PM +0100, Laurent Vivier wrote:    
> >>>> H_HOME_NODE_ASSOCIATIVITY H-Call returns the associativity domain
> >>>> designation associated with the identifier input parameter.
> >>>>
> >>>> Remove the warning message from the kernel:
> >>>>   VPHN is not supported. Disabling polling..
> >>>>
> >>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>    
> >>>
> >>> From the looks of PAPR, I suspect this call isn't of much use outside
> >>> PowerVM guests, though it probably wouldn't do any harm.    
> >>
> >> This call is used by the kernel to get the node id of a CPU on hotplug
> >> and fixes a crash when we hotplug a CPU in a memory-less/CPU-less node
> >> where this information is missing (not initialized from the device-tree).
> >>  
> > 
> > So this patch isn't just about removing the warning message from the kernel
> > but about fixing an actual crash ?  
> 
> Yes, I updated the message but sent the wrong e-mail.
> 
> > I ask because if it's only about the warning, why does the kernel call
> > H_HOME_NODE_ASSOCIATIVITY when hcall-vphn isn't advertised ? Especially,
> > the polling for topology changes is only started if hcall-vphn is present:
> > 
> > 	if (firmware_has_feature(FW_FEATURE_VPHN) &&
> > 		   lppaca_shared_proc(get_lppaca())) {
> > 		if (!vphn_enabled) {
> > 			vphn_enabled = 1;
> > 			setup_cpu_associativity_change_counters();
> > 			timer_setup(&topology_timer, topology_timer_fn,
> > 				    TIMER_DEFERRABLE);
> > 			reset_topology_timer();
> > 		}
> > 	}
> > 
> > It thus seems wrong to emit the "Disable polling.." warning for something
> > that was never enabled in the first place, doesn't it ?  
> 
> It's unconditionally called from find_and_online_cpu_nid() that is used
> to plug a CPU in a node that is not already online.
> 
> > On the other hand, if this really needed to avoid a crash, I guess you
> > should provide some more details.  
> 
> I agree.
> 
> >>> BenH, Paulus, any thoughts?
> >>>
> >>> One nit in implementation: if you implement this hcall, it's supposed
> >>> to be advertised by adding hcall-vphn to ibm,hypertas-functions.    
> >> ok  in v2.
> >>
> >> Thanks,
> >> Laurent
> >>  
> >>>> ---
> >>>> Based-on: <20181213040126.6768-1-david@gibson.dropbear.id.au>
> >>>>           "[PULL 00/27] ppc-for-4.0 queue 20181213"
> >>>>
> >>>>  hw/ppc/spapr_hcall.c   | 39 +++++++++++++++++++++++++++++++++++++++
> >>>>  include/hw/ppc/spapr.h |  1 +
> >>>>  2 files changed, 40 insertions(+)
> >>>>
> >>>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >>>> index 78fecc8fe9..454ec594fd 100644
> >>>> --- a/hw/ppc/spapr_hcall.c
> >>>> +++ b/hw/ppc/spapr_hcall.c
> >>>> @@ -1663,6 +1663,41 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> >>>>      return H_SUCCESS;
> >>>>  }
> >>>>  
> >>>> +static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> >>>> +                                              sPAPRMachineState *spapr,
> >>>> +                                              target_ulong opcode,
> >>>> +                                              target_ulong *args)
> >>>> +{
> >>>> +    target_ulong flags = args[0];
> >>>> +    target_ulong procno = args[1];
> >>>> +    PowerPCCPU *tcpu;
> >>>> +    int idx;
> >>>> +
> >>>> +    /* only support procno from H_REGISTER_VPA */
> >>>> +    if ((flags & 0x1) == 0) {
> >>>> +        return H_PARAMETER;
> >>>> +    }  
> > 
> > LoPAPR says that the guest can pass exactly 0x1 or 0x2 in flags. The
> > above check should then rather be flags == 0x1.
> >  
> 
> ok
> 
> > Also, even if linux only seems to call this with 0x1, this is a
> > limitation from a LoPAPR standpoint. Not sure H_PARAMETER is the
> > appropriate return value if flags is 0x2 since the guest did
> > nothing wrong... I'd rather return H_FUNCTION in this case.  
> 
> The doc says:
> 
>   H_Function:  The function is not supported
>   H_Parameter: Unsupported flag parameter value
> 
> in that case function is supported but not the flag, so I think
> H_PARAMETER is a better choice.
> 

Well... neither LoPAPR, nor IBM confidential PAPR+ do say anything
about partial support for this hcall. If the guest was to use the
flags == 0x2 variant, eg, some closed-source OS supporting PAPR,
it could be legitimately confused to get an H_PARAMETER error when
passing supposedly valid parameters... how to cope with that ?
On the other hand, if QEMU cannot honor the flags == 0x2 variant
and returns H_FUNCTION then the OS can recover since it is
required by the specification.

But I don't really care for now, and we can talk about this later
if I'm assigned a BZ from the people who run such OS in KVM guests ;)

> Thanks,
> Laurent
> 

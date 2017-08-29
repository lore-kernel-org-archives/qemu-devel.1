Received: from eggs.gnu.org ([2001:4830:134:3::10]:51343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dmnWz-000865-3b
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dmnWw-0004RL-1W
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:54:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32798
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dmnWv-0004PH-Rr
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 16:54:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7TKsH4c146894
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 16:54:34 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cnenpjp49-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 16:54:34 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 29 Aug 2017 14:54:34 -0600
References: <20170825211119.474-1-danielhb@linux.vnet.ibm.com>
	<20170829072310.GJ2578@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 17:54:28 -0300
MIME-Version: 1.0
In-Reply-To: <20170829072310.GJ2578@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <df49df06-caaf-81f5-7c24-f4324654a262@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.11 v2] hw/ppc: CAS reset
 on early device hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com



On 08/29/2017 04:23 AM, David Gibson wrote:
> On Fri, Aug 25, 2017 at 06:11:18PM -0300, Daniel Henrique Barboza wrote:
>> v2:
>> - rebased with ppc-for-2.11
>> - function 'spapr_cas_completed' dropped
>> - function 'spapr_drc_needed' made public and it's now used inside
>>    'spapr_hotplugged_dev_before_cas'
>> - 'spapr_drc_needed' was changed to support the migration of logical
>>    DRCs with devs attached in UNUSED state
>> - new function: 'spapr_clear_pending_events'. This function is used
>>    inside ppc_spapr_reset to reset the pending_events QTAILQ
> Thanks for the followup, unfortunately there is still an important bug
> left, see comments on the patch itself.
>
> At a higher level, though, looking at the event reset code made me
> think of a possible even simpler solution to this problem.
>
> The queue of events (both hotplug and epow) is already in a simple
> internal form that's independent of the two delivery mechanisms.  The
> only difference is what event source triggers the interrupt.  This
> explains why an extra hotplug event after the CAS "unstuck" the queue.
>
> AFAICT, a spurious interrupts here should be harmless - the kernel
> will just check the queue and find nothing there.
>
> So, it should be sufficient to, after CAS, pulse the hotplug queue
> interrupt if the hotplug queue is negotiated.
>
This is something I've tried in my first attempts at this problem, before
sending the first patch in which I blocked hotplug before CAS. Back then,
the problem was that the kernel panics with sig 11 (acess of bad area) when
receiving the pulse after CAS.

I've investigated it a bit today and it seems that it still the case. 
Firing an IRQ right
after CAS breaks the kernel. In fact, if you time a regular CPU hotplug 
right after
CAS you'll get the same sig 11 kernel ooops. It looks like there is a 
time window after
CAS that the kernel can't handle the hotplug process and pulsing the hotplug
queue in this window breaks the guest. I've tried some hacks such as 
pulsing the queue
in the first 'event_scan' call made by the guest, but apparently it is 
still too early.

I've sent an email to the linuxppc-dev mailing list talking about this 
behavior
and asking if there is a reliable way to know when  we can safely pulse 
the hotplug
queue. Meanwhile, I'll keep working in the v3 respin of this patch in 
case this
solution of pulsing the hotplug queue ends up being not feasible.


Thanks,


Daniel

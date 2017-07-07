Received: from eggs.gnu.org ([2001:4830:134:3::10]:35399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dTQTv-0002a1-E3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:27:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dTQQ7-0000qt-OW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:23:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46287
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dTQQ7-0000qU-I0
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 06:23:31 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v67AIjG9039132
	for <qemu-devel@nongnu.org>; Fri, 7 Jul 2017 06:23:30 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bj3v6sxqj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 06:23:29 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Fri, 7 Jul 2017 07:23:27 -0300
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
	<f89c6897-9555-100a-7252-a705fcbc8ee6@linux.vnet.ibm.com>
	<20170705110414.GN2180@umbus.fritz.box>
	<0e4deabe-58e9-6c15-5910-cda9f8e63f9b@linux.vnet.ibm.com>
	<89240dbb-56b7-e540-8981-b6af20eb0d8c@linux.vnet.ibm.com>
	<20170707071409.GF24325@umbus.fritz.box>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Fri, 7 Jul 2017 07:23:18 -0300
MIME-Version: 1.0
In-Reply-To: <20170707071409.GF24325@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <0a4bc3ed-530f-ba4a-44af-37781ea41ad5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/5] spapr: DRC cleanups (part
 VI)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: lvivier@redhat.com, sursingh@redhat.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com



On 07/07/2017 04:14 AM, David Gibson wrote:
> On Thu, Jul 06, 2017 at 11:31:35AM -0300, Daniel Henrique Barboza wrote:
>>
>> On 07/05/2017 06:53 PM, Daniel Henrique Barboza wrote:
>>> Worth a try. I'll see if I can make a POC of this DRC reset at incoming
>>> migration time.
>>
>> Just played a little with the idea of manual reset during migration. I've
>> created a
>> POC that resets the CPU DRCs in a pre_load hook.
> Ok.  I'm not sure does the pre_load hook get called for objects where
> nothing ends up being sent in the migration stream?

In this POC I've added a pre_load hook in the machine state to ensure
that it will be called.  I saw that we already had a post_load hook in there
that does adjustments in the CPU and RADIX state, so adding a pre_load hook
sounded viable too. I am not sure if we can add some form of hook for
the DRCs that won't be migrated in the DRC state or if there is a better
VMSD to do the reset of the DRCs.

Anyway, this was more of an experiment than a serious fix proposal.
I believe the general idea is solid but it'll get a couple of spins to get a
good patch for pushing. I'll send the POC as a RFC to get things started and
we'll see what happens.


Daniel

>> Then I've done the same
>> experiment - device_add on both source and target before the migration,
>> hot unplug the device after migration is completed. The hot unplug worked as
>> expected in both QEMU and guest.
> That's encouraging.
>
>> To minimize the impact I am resetting only the DRCs of the CPUs that were
>> hotplugged
>> in the target instead of resetting everybody.
> That sounds like more trouble than it's worth, I think it'll be easier
> and safer to reset all DRCs.
>
>> I'll see if this solution works for LMBs and PCI devices. In case
>> affirmative, and
>> if we are fine with this solution of resetting the DRCs in pre_load (not
>> sure if pre_load is
>> the right place for doing it - suggestions welcome), I can send a patch to
>> be applied on top
>> of this series.
>>
>>
>>
>> Thanks,
>>
>> Daniel
>>

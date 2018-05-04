Received: from eggs.gnu.org ([2001:4830:134:3::10]:59629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEbeI-0002Vi-Kr
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fEbeF-00077d-Cg
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:25:26 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:57397)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fEbeF-00076u-61
	for qemu-devel@nongnu.org; Fri, 04 May 2018 10:25:23 -0400
Received: from player714.ha.ovh.net (unknown [10.109.122.16])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7CCB1C0C20
	for <qemu-devel@nongnu.org>; Fri,  4 May 2018 16:25:21 +0200 (CEST)
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-3-clg@kaod.org>
	<20180423064408.GF19804@umbus.fritz.box>
	<ac69df02-8ee8-0506-36ac-83fdaccdca77@kaod.org>
	<20180424064119.GO19804@umbus.fritz.box>
	<0fb72eb1-d9b5-968b-137a-7d44af116530@kaod.org>
	<20180426032812.GD8800@umbus.fritz.box>
	<9c1bbe54-bdbf-ba1b-29b9-bd5df31b0f07@kaod.org>
	<20180427024347.GM8800@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <71ed1a12-efc8-0834-547a-5b7d39c96831@kaod.org>
Date: Fri, 4 May 2018 16:25:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180427024347.GM8800@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 02/35] ppc/xive: add support for the LSI
 interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 04/27/2018 04:43 AM, David Gibson wrote:
>>>> I did some work on that topic a while ago :
>>>>
>>>> 	https://patchwork.ozlabs.org/cover/836782/
>>>>
>>>> But we stopped exploring the idea. May be it was not the good approach.
>>>> The PHBs LSIs would benefit from such a split though.
>>> So, no, I don't think that was a good approach, but that doesn't mean
>>> other ways of rearranging the irq numbers aren't ok.  The thing here
>>> is that we don't want to think of an "irq allocator" - there are some
>>> bits like that in there already, but they were always a mistake.
>>>
>>> We have lots of irq space (both XICS and XIVE) so instead we should
>>> come up with a static mapping of irqs to devices.
>> yes. I would prefer that also. 
>>
>> We could change the spapr_irq_alloc() routine to get a block of 
>> IRQs in the range defined for a device family, and use a device 
>> id to offset in that family range ? Here are some figures :
>>
>> device family        block size  max devices  
>>
>> EVENT_CLASS_EPOW              1           1  
>> EVENT_CLASS_HOT_PLUG          1           1   
>> VIO_VSCSI                     1          10  
>> VIO_LLAN                      1          10  
>> VIO_VTY                       1           5  
>>                       
>> PCI/PHB                    1024           5  
> No, I'm thinking we should eliminate spapr_irq_alloc() entirely.
> Well, ok, not entirely, we'll still need it for the old machine
> types.  But remove it's use for the current machine type completely.
> 
> Instead we have an explicit map of ranges for various purposes.  The
> one-off things like EPOW and HOTPLUG can have plain constant values.
> PCI LSIs will be calculated as something like PCI_IRQ_BASE + <phb
> index>*4 + <irq pin>.  The VIO devices we handle as VIO_BASE + <reg
> value> or something.
> 
> MSIs will still need some sort of allocation, but we can do that
> within a range set aside for them.

Should we address the static mapping of irqs before introducing XIVE ? 

I don't think it changes much of the architecture now that the allocator
is under the machine. However, I wonder what would be the impact of 
PHB hotplug. 

C. 

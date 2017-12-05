Received: from eggs.gnu.org ([2001:4830:134:3::10]:55775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eMFpb-0008ST-Hj
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eMFpY-0006uP-B2
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:12:27 -0500
Received: from 6.mo69.mail-out.ovh.net ([46.105.50.107]:47248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eMFpY-0006tm-3k
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:12:24 -0500
Received: from player699.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 8FFD84CD17
	for <qemu-devel@nongnu.org>; Tue,  5 Dec 2017 17:12:20 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-20-clg@kaod.org>
	<20171201040115.GC30161@umbus.fritz.box>
	<02120b7e-cd8b-af61-7d35-8289253828f6@kaod.org>
	<20171205070004.GL3057@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c62c6198-28bb-c11c-d9d1-d8a27e28515f@kaod.org>
Date: Tue, 5 Dec 2017 16:12:14 +0000
MIME-Version: 1.0
In-Reply-To: <20171205070004.GL3057@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/25] spapr: add hcalls support for the
 XIVE interrupt mode
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

[ ... ] 

>>>> +static bool priority_is_valid(uint32_t priority)
>>>> +{
>>>> +    int i;
>>>> +
>>>> +    for (i = 0; i < ARRAY_SIZE(reserved_priorities) / 2; i++) {
>>>> +        uint32_t base  = reserved_priorities[2 * i];
>>>> +        uint32_t count = reserved_priorities[2 * i + 1];
>>>> +
>>>> +        if (priority >= base && priority < base + count) {
>>>> +            qemu_log_mask(LOG_GUEST_ERROR, "%s: priority %d is reserved\n",
>>>> +                          __func__, priority);
>>>> +            return false;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return true;
>>>> +}
>>>
>>> This seems like overkill.  Aren't there only 0..7 levels supported in
>>> hardware, in which case a one byte bitmap will suffice to store the
>>> reserved levels.
>>
>> I was trying the use the same array that will be exposed in the device
>> tree in the "ibm,plat-res-int-priorities" property, defined as 
>> follow in PAPR:
>>
>> 	property name that designates to the client program that the
>> 	platform has reserved one or more interrupt priorities for its
>> 	own use.
>> 	
>> 	prop-encoded-value: one or more (interrupt priority, range)
>> 	pairs, where interrupt priority is a single cell hexidec- imal
>> 	number between 0x00 and 0xFF, and range is an integer encoded as
>> 	with encode-int that represents the number of contiguous
>> 	interrupt priorities that have been reserved by the platform for
>> 	its internal use.
>>
>>
>> But I agree, it's a bit overkill to check for 0..7 levels ...
> 
> Ok, I do see the point here.  Hmm.. not sure where best to go with
> this.  One source of data is always good, and this is probably less
> complex than deriving the DT list from a bitmap.
> 
> On the other hand I am wary these days of over-generalizing, since it
> can lead to nightmares for migration consistency.

I should be able to simplify by using one array of valid priorities
for the guest, and from that build the array of reserved priorities 
for the platform. 
 
[ ... ]

>>>> +    mmio_base = (uint64_t)xive->esb_base + (1ull << xive->esb_shift) * lisn;
>>>
>>> Hrm.. why was xive->esb_base not already a u64?
>>
>> its an 'hwaddr'. Yes I can remove it.
> 
> Right.  mmio_base should be a hwaddr too, so you shouldn't need a cast.

yes.

[ ... ]

>>> What does the availability of SRC_TRIGGER (and INT_ESB) depend on? 
>>
>> The CPU revision. But we won't introduce XIVE exploitation mode on 
>> anything else than DD2.0 which has full XIVE support. Even STORE_EOI 
>> that we should be adding.
> 
> Hrm.  Host CPU?  That's a problem - if guest visible properties like
> this vary with the host CPU, migration breaks.
> 
>>
>>> If it varies with host capabilities, that's going to be real pain for
>>> migration.
>>
>> Yes. I am not aware of any future extension but I agree this is
>> something we need to keep an eye on.
> 
> I'm not talking about future extension, I'm meaning right now.

I think Ben has answered these questions.

[ ... ] 

>> On that topic, could we include the PPC_BIT* macros somewhere under ppc ? 
> 
> Uh, sure, why not. target/ppc/cpu.h seems the logical place.

I will send a preliminary patch for 2.12 then.


Thanks,


C.

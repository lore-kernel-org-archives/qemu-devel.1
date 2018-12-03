Received: from eggs.gnu.org ([2001:4830:134:3::10]:50228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gTrPo-0005up-Pe
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gTrPk-0008VF-Nq
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:49:48 -0500
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:57315)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gTrPk-0008UN-Gy
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 11:49:44 -0500
Received: from player698.ha.ovh.net (unknown [10.109.159.20])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9F53E207B1F
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 17:49:42 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-17-clg@kaod.org>
	<20181128042547.GZ2251@umbus.fritz.box>
	<a57f6b4b-414e-efe7-475d-e6cbb87f61a8@kaod.org>
	<20181129012355.GP2251@umbus.fritz.box>
	<898d49bd-e430-fd07-e1ee-10d5822e3757@kaod.org>
	<20181130012315.GH30479@umbus.fritz.box>
	<35df014a-1876-1fa2-291c-880d15222a58@kaod.org>
	<20181203013640.GR30479@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bdc46ea5-aea5-566d-5262-95d84857e2c4@kaod.org>
Date: Mon, 3 Dec 2018 17:49:37 +0100
MIME-Version: 1.0
In-Reply-To: <20181203013640.GR30479@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 16/36] spapr: add hcalls support for the
 XIVE exploitation interrupt mode
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

>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    switch (qsize) {
>>>>>>>> +    case 12:
>>>>>>>> +    case 16:
>>>>>>>> +    case 21:
>>>>>>>> +    case 24:
>>>>>>>> +        end.w3 = ((uint64_t)qpage) & 0xffffffff;
>>>>>>>
>>>>>>> It just occurred to me that I haven't been looking for this across any
>>>>>>> of these reviews.  Don't you need byteswaps when accessing these
>>>>>>> in-memory structures?
>>>>>>
>>>>>> yes this is done when some event data is enqueued in the EQ.
>>>>>
>>>>> I'm not talking about the data in the EQ itself, but the fields in the
>>>>> END (and the NVT).
>>>>
>>>> XIVE is all BE.
>>>
>>> Yes... the qemu host might not be, which is why you need byteswaps.
>>
>> ok. I understand.
>>
>>> I realized eventually you have the swaps in your pnv get/set
>>> accessors.  
>>
>> Yes. because skiboot is BE, like the XIVE structures.
> 
> skiboot's endiannness isn't really relevant, because we're modelling
> below that level.
> 
>>> I don't like that at all for a couple of reasons:
>>>
>>> 1) Although the END structure is made up of word-sized fields because
>>> that's convenient, the END really is made of a bunch of subfields of
>>> different sizes.  Knowing that it wouldn't be unreasonable for people
>>> to expect they can look into the XIVE by byte offsets; 
>>
>> These structures should be accessed with GETFIELD and SETFIELD macros
>> using the XIVE definitions in the xive_regs.h header file. I would want 
>> to keep that common with skiboot  for sure.
> 
> Right.  It might make sense to make some helper macros or inlines that
> include both the GETFIELD/SETFIELD and the byteswap.

ah. I have to evaluate the added complexity, because we don't really
have a struct. it's just an array of BE words. 

So for each field or bit we are interested in, we would have an helper 
routine picking the correct word from the XIVE structure, doing the 
byteswap and extracting the value ?  

sigh. 

C.

>> Are you suggesting we should define each field of the XIVE structures 
>> with C attributes ? That would be very unfortunate.
> 
> Oh no, bitfields are a complete mess.
>
>>> that will break
>>> if you're working with a copy that has already been byte-swapped on
>>> word-sized units.
>>
>> I am not sure I understand the last sentence.
> 
> I mean that GETFIELD/SETFIELD only work on values that are already
> native endian, but using byte offsets would only work on values that
> are still in BE.
> 
>> the code working with a copy would necessarily know that the structure 
>> has been byteswapped and use correct offsets for the expected endianess. 
>> no ? why would it break ?  
>>
>>> 2) At different points in the code you're storing both BE and
>>> native-endian data in the same struct. 
>>
>> on sPAPR, it's all native (which is a violation I agree).
> 
> Don't do that.  Having the same structure be BE in some situations and
> native endian in other situations is a sure path to madness.
> 
>> TIMA is BE.
>>
>>> That's both confusing to
>>> someone reading the code (if they see that struct they don't know if
>>> it's byteswapped already) and also means you can't use sparse
>>> annotations to make sure you have it right.
>>
>> XIVE structures are architected to be BE. That's immutable.
> 
> Yes, absolutely.  So don't represent them in C structs that are in
> native endian.  Ever, even temporarily.
> 
>> It's a not problem for skiboot which is BE. The PnvXIVE model for the 
>> QEMU PowerNV machine reads these VSTs (Virtual Structure Tables) from 
>> the guest RAM and byteswaps the structure before using it. I think
>> that's fine. Isn't it ?
> 
> Byteswapping structures - rather than individual fields as you use
> them - is almost always a bad idea.  It's insanely easy to lose track
> of whether this particular instance of the structure is swapped yet or
> not, and you can't use sparse (or whatever) to check it for you.
> 
> Stick to one endianness for a struct, and do the byteswaps when you
> access the fields (using helpers if that's, well, helpful).
> 
>> It becomes a problem with the sPAPR model which is using the XIVE structures 
>> in native endianess and not BE anymore. But the guest OS never manipulates 
>> these structures, so under the hood, I think we are free to use them in 
>> native and keep the common definitions.
> 
> Free to in the sense that it can theoretically work, yes.  But there's
> no upside (byteswaps are essentially free on POWER, and of trivial
> cost compared to memory access basically everywhere).  The downside is
> that having the same variables / structures have data in different
> endianness in different situations makes it exceedingly easy to forget
> which one you're dealing with right now and therefore forget some
> swaps or put in extra ones.
> 
>> Except that the event data entries in the OS EQs are BE. So the only place 
>> where we convert is when an event data is enqueued. 
>>
>> What would you put in place if you think this is a too strong violation 
>> of the architecture ? I am afraid of something too complex to manipulate
>> to be honest. May be we can drop the map/unmap access methods only keep 
>> the very basic ones.
> 
> THe complexity of having extra swaps is almost always less than having
> the complexity of having those swaps not be in a consistent place.
> Especially if you use helpers (including the swaps) to access your
> structure.
> 

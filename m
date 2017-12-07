Received: from eggs.gnu.org ([2001:4830:134:3::10]:47559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eMumE-0005Tm-Qz
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:55:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eMum9-0003mW-TM
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:55:42 -0500
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:41673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eMum9-0003cY-MN
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:55:37 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id A6E851270F0
	for <qemu-devel@nongnu.org>; Thu,  7 Dec 2017 12:55:27 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-16-clg@kaod.org>
	<20171130050049.GD3023@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <07ba163b-6434-db2b-847c-3a8aac069439@kaod.org>
Date: Thu, 7 Dec 2017 12:55:20 +0100
MIME-Version: 1.0
In-Reply-To: <20171130050049.GD3023@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/25] spapr: notify the CPU when the XIVE
 interrupt priority is more privileged
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

>> +/* Convert a priority number to an Interrupt Pending Buffer (IPB)
>> + * register, which indicates a pending interrupt at the priority
>> + * corresponding to the bit number
>> + */
>> +static uint8_t priority_to_ipb(uint8_t priority)
>> +{
>> +    return priority > XIVE_PRIORITY_MAX ?
>> +        0 : 1 << (XIVE_PRIORITY_MAX - priority);
> 
> Does handling out of bounds values here make sense, or should you just
> assert() they're not passed in?

The priority can be above in the TM_SPC_SET_OS_PENDING command. 

>> +}
>> +
>> +/* Convert an Interrupt Pending Buffer (IPB) register to a Pending
>> + * Interrupt Priority Register (PIPR), which contains the priority of
>> + * the most favored pending notification.
>> + *
>> + * TODO:
>> + *
>> + *   PIPR is clamped to CPPR. So the value in the PIPR is:
>> + *
>> + *     v = leftmost_bit_of(ipb) (or 0xff);
>> + *     pipr = v < cppr ? v : cppr;
>> + *
>> + * Ben says: "which means it's never actually 0xff ... surprise !".
>> + * But, the CPPR can be set to 0xFF ... I am confused ...
> 
> A resolution to this would be nice..

The 'accept' sequence does :

  - store the PIPR in the CPPR
  - reset the pending buffer bit in the IPB
  - recompute the PIPR value from the new IPB
  - drop the exception bit for OS

Typical values are : 

  before  IBP=02 PIPR=06 CPPR=ff NSR=80
   after  IBP=00 PIPR=ff CPPR=06 NSR=00

So today, if the IPB becomes zero, the PIPR is adjusted to 0xFF.

But, if the PIPR is clamped to the CPPR (6), there is a disconnect
between the IBP and the PIPR values. Is that OK ? 

Then, the second effect is that as soon as the OS sets back the CPPR 
to 0xFF, we notify the CPU again and enter a loop. 

I think this is because a test on the EO bit of the NSR is missing 
in the routine setting the CPPR. this bit notifies the presence of 
an exception for the O/S. I will add that. I misunderstood the specs 
on the topic.

C. 
 

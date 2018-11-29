Received: from eggs.gnu.org ([2001:4830:134:3::10]:56509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSNRc-0004Lc-Mm
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSNRY-0008Dj-7P
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:37:32 -0500
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:57457)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gSNRX-00089C-EA
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:37:28 -0500
Received: from player691.ha.ovh.net (unknown [10.109.143.216])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id C8E4AEC830
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 15:37:18 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-11-clg@kaod.org>
	<20181128005255.GT2251@umbus.fritz.box>
	<64aef78f-e374-9c6d-1a1f-892c4e3b0677@kaod.org>
	<20181129005402.GL2251@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a34655d5-0850-13f7-9407-a5c09f15341c@kaod.org>
Date: Thu, 29 Nov 2018 15:37:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181129005402.GL2251@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 10/36] spapr/xive: introduce a XIVE
 interrupt controller
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
 
>>> With that approach it might make sense to embed it
>>> here, rather than subclassing it 
>>
>> ah. why not indeed. I have to think about it. 
>>
>>> (the old composition vs. inheritance debate).
>>
>> he. but then the XiveRouter needs to become a QOM interface if we 
>> want to be able to define XIVE table accessors for sPAPRXive. See
>> the  spapr_xive_class_init() routine.
> 
> Erm.. I'm not really sure what you're getting at here.

if we compose a sPAPRXive object with a XiveSource object and a XiveRouter 
object, how will the  XiveRouter object access the XIVE internal tables 
which are in the sPAPRXive object ? 

Thinking of it, I am not sure a QOM interface would solve the problem now. 
So we are stuck with inheritance.

[ ... ]

>>>> +qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn)
>>>> +{
>>>> +    XiveSource *xsrc = &xive->source;
>>>> +
>>>> +    if (lisn >= xive->nr_irqs) {
>>>> +        return NULL;
>>>> +    }
>>>> +
>>>> +    if (!(xive->eat[lisn].w & EAS_VALID)) {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", lisn);
>>>
>>> I don't think this is a guest error - gettint the qirq by number
>>> should generally be something qemu code does.
>>
>> Even if the IRQ was not defined by the machine ? The EAS_VALID bit is
>> raised when the IRQ is enabled at the XIVE level, which means that the
>> IRQ number has been claimed by some device of the machine. You cannot
>> get a qirq by number for  some random IRQ number. Can you ?
> 
> Well, you shouldn't.  The point is that it is qemu code (specifically
> the machine setup stuff) that will be calling this, and it shouldn't
> be calling it with irq numbers that haven't been
> enabled/claimed/whatever.

so it should be an assert ? 

Thanks,

C. 

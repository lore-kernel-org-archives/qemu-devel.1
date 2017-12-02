Received: from eggs.gnu.org ([2001:4830:134:3::10]:42410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eL8wS-00079m-M6
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eL8wO-0006ca-PR
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:38:56 -0500
Received: from 7.mo3.mail-out.ovh.net ([46.105.57.200]:34779)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eL8wO-0006bS-Iw
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:38:52 -0500
Received: from player732.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id F2D97175BA0
	for <qemu-devel@nongnu.org>; Sat,  2 Dec 2017 15:38:50 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-12-clg@kaod.org>
	<20171128064034.GQ11775@umbus.fritz.box>
	<1512224666.2224.52.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ed946d89-61a0-7ef7-29a1-105a64a8e3f2@kaod.org>
Date: Sat, 2 Dec 2017 15:38:44 +0100
MIME-Version: 1.0
In-Reply-To: <1512224666.2224.52.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/25] spapr: describe the XIVE interrupt
 source flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 12/02/2017 03:24 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2017-11-28 at 17:40 +1100, David Gibson wrote:
>>> @@ -368,6 +368,10 @@ static void spapr_xive_realize(DeviceState *dev, Error **errp)
>>>      /* Allocate the IVT (Interrupt Virtualization Table) */
>>>      xive->ivt = g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
>>>  
>>> +    /* All sources are emulated under the XIVE object and share the
>>> +     * same characteristic */
>>> +    xive->flags = XIVE_SRC_TRIGGER;
>>
>> You never actually use this field.  And since it always has the same
>> value, is there a point to storing it?
> 
> Some HW sources don't have it, so with pass-through maybe...

Hmm, yes. So, the current design for sPAPR handles all sources 
under the same XIVE object with a global memory region for all 
the ESBs. 

The first RFC had a mechanism to register source objects into 
the XIVE main one, allocating the IRQs per source and mapping 
the ESBs in the overall region. A bit like OPAL does. I then 
simplified for the sake of clarity and merged everything under 
the same XIVE object. 

Shall I reintroduce multiples sources support ? and provide a 
default one for IPIs and virtual devices of the machine. 

Thanks,

C. 

 

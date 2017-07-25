Received: from eggs.gnu.org ([2001:4830:134:3::10]:56479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1da0dc-0006dM-LE
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1da0dZ-0005Bg-IZ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:16:40 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1da0dZ-0005Ah-D2
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:16:37 -0400
Received: by mail-pf0-x243.google.com with SMTP id 1so4937083pfi.3
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:16:35 -0700 (PDT)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-20-git-send-email-clg@kaod.org>
	<6e9f8817-2ecc-4ea3-8f22-17496b520bb4@ozlabs.ru>
	<d0e51819-6ee3-67ca-d736-fe7f37ef84c8@kaod.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <d1f565d9-9c2f-3081-be42-e9d01b89f25f@ozlabs.ru>
Date: Wed, 26 Jul 2017 00:16:29 +1000
MIME-Version: 1.0
In-Reply-To: <d0e51819-6ee3-67ca-d736-fe7f37ef84c8@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-AU
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 19/26] ppc/xive: introduce a
 helper to map the XIVE memory regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 25/07/17 19:18, Cédric Le Goater wrote:
> On 07/25/2017 04:54 AM, Alexey Kardashevskiy wrote:
>> On 06/07/17 03:13, Cédric Le Goater wrote:
>>> It will be used when the guest chooses the XIVE exploitation mode in
>>> CAS.
>>>
>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>> ---
>>>  hw/intc/xive.c        | 11 +++++++++++
>>>  include/hw/ppc/xive.h |  2 ++
>>>  2 files changed, 13 insertions(+)
>>>
>>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>>> index cda1fa18e44d..895dd2b2f61b 100644
>>> --- a/hw/intc/xive.c
>>> +++ b/hw/intc/xive.c
>>> @@ -915,3 +915,14 @@ bool xive_eq_for_target(XIVE *x, uint32_t target, uint8_t priority,
>>>  
>>>      return true;
>>>  }
>>> +
>>> +void xive_mmio_map(XIVE *x)
>>> +{
>>> +    /* ESBs */
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(x), 0, x->vc_base);
>>> +
>>> +    /* Thread Management Interrupt Areas */
>>> +    /* TODO: Only map the OS TIMA for the moment. Mapping the whole
>>> +     * region needs some rework in the handlers */
>>> +    sysbus_mmio_map(SYS_BUS_DEVICE(x), 1, x->tm_base + (1 << x->tm_shift));
>>> +}
>>
>>
>> imho it makes more sense to squash such small patches (this one and 20/26,
>> 21/26) into those which actually make use of the new helpers - easier to
>> review, better for bisectability.
> 
> ok. I am also realizing we should unmap.


I could not find a helper to do unmapping for sysbus regions so I suppose
it has to be memory_region_set_enabled() or (imho better)
memory_region_set_size() which would take zero size for the XICS emulation
case.


> 
> Thanks,
> 
> C.
>  
>>
>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>> index 288116aeb8f4..560f6ab66f73 100644
>>> --- a/include/hw/ppc/xive.h
>>> +++ b/include/hw/ppc/xive.h
>>> @@ -68,4 +68,6 @@ typedef struct sPAPRMachineState sPAPRMachineState;
>>>  void xive_spapr_init(sPAPRMachineState *spapr);
>>>  void xive_spapr_populate(XIVE *x, void *fdt);
>>>  
>>> +void xive_mmio_map(XIVE *x);
>>> +
>>>  #endif /* PPC_XIVE_H */
>>>
>>
>>
> 


-- 
Alexey

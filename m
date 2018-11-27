Received: from eggs.gnu.org ([2001:4830:134:3::10]:54304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRcmU-0007VG-Lx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:48:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRcmR-0006yL-B9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:47:58 -0500
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:47357)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gRcmR-0006xf-4t
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:47:55 -0500
Received: from player738.ha.ovh.net (unknown [10.109.160.76])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id A620E1469C7
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 13:47:53 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-8-clg@kaod.org>
	<20181123050858.GA10448@umbus.fritz.box>
	<8f6de3b8-b1df-f5e6-cfd8-aeca93a521b6@kaod.org>
	<20181127050736.GN2251@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4a060507-35d4-c83d-1c11-b4f220d9fae9@kaod.org>
Date: Tue, 27 Nov 2018 13:47:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181127050736.GN2251@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 07/36] ppc/xive: introduce the XIVE
 interrupt thread context
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

On 11/27/18 6:07 AM, David Gibson wrote:
> On Sun, Nov 25, 2018 at 09:35:08PM +0100, C=E9dric Le Goater wrote:
>> On 11/23/18 6:08 AM, David Gibson wrote:
>>> On Fri, Nov 16, 2018 at 11:57:00AM +0100, C=E9dric Le Goater wrote:
>>>> Each POWER9 processor chip has a XIVE presenter that can generate fo=
ur
>>>> different exceptions to its threads:
>>>>
>>>>   - hypervisor exception,
>>>>   - O/S exception
>>>>   - Event-Based Branch (EBB)
>>>>   - msgsnd (doorbell).
>>>>
>>>> Each exception has a state independent from the others called a Thre=
ad
>>>> Interrupt Management context. This context is a set of registers whi=
ch
>>>> lets the thread handle priority management and interrupt acknowledgm=
ent
>>>> among other things. The most important ones being :
>>>>
>>>>   - Interrupt Priority Register  (PIPR)
>>>>   - Interrupt Pending Buffer     (IPB)
>>>>   - Current Processor Priority   (CPPR)
>>>>   - Notification Source Register (NSR)
>>>>
>>>> These registers are accessible through a specific MMIO region, calle=
d
>>>> the Thread Interrupt Management Area (TIMA), four aligned pages, eac=
h
>>>> exposing a different view of the registers. First page (page address
>>>> ending in 0b00) gives access to the entire context and is reserved f=
or
>>>> the ring 0 security monitor. The second (page address ending in 0b01=
)
>>>> is for the hypervisor, ring 1. The third (page address ending in 0b1=
0)
>>>> is for the operating system, ring 2. The fourth (page address ending
>>>> in 0b11) is for user level, ring 3.
>>>>
>>>> The thread interrupt context is modeled with a XiveTCTX object
>>>> containing the values of the different exception registers. The TIMA
>>>> region is mapped at the same address for each CPU.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  include/hw/ppc/xive.h      |  36 +++
>>>>  include/hw/ppc/xive_regs.h |  82 +++++++
>>>>  hw/intc/xive.c             | 443 ++++++++++++++++++++++++++++++++++=
+++
>>>>  3 files changed, 561 insertions(+)
>>>>
>>>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>>>> index 24301bf2076d..5987f26ddb98 100644
>>>> --- a/include/hw/ppc/xive.h
>>>> +++ b/include/hw/ppc/xive.h
>>>> @@ -238,4 +238,40 @@ typedef struct XiveENDSource {
>>>>  void xive_end_reset(XiveEND *end);
>>>>  void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monito=
r *mon);
>>>> =20
>>>> +/*
>>>> + * XIVE Thread interrupt Management (TM) context
>>>> + */
>>>> +
>>>> +#define TYPE_XIVE_TCTX "xive-tctx"
>>>> +#define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX=
)
>>>> +
>>>> +/*
>>>> + * XIVE Thread interrupt Management register rings :
>>>> + *
>>>> + *   QW-0  User       event-based exception state
>>>> + *   QW-1  O/S        OS context for priority management, interrupt=
 acks
>>>> + *   QW-2  Pool       hypervisor context for virtual processor bein=
g dispatched
>>>> + *   QW-3  Physical   for the security monitor to manage the entire=
 context
>>>
>>> That last description is misleading, AIUI the hypervisor can and does
>>> make use of the physical ring as well as the pool ring.
>>
>> yes. The description is from the spec. I will rephrase.=20
>>
>>>
>>>> + */
>>>> +#define TM_RING_COUNT           4
>>>> +#define TM_RING_SIZE            0x10
>>>> +
>>>> +typedef struct XiveTCTX {
>>>> +    DeviceState parent_obj;
>>>> +
>>>> +    CPUState    *cs;
>>>> +    qemu_irq    output;
>>>> +
>>>> +    uint8_t     regs[TM_RING_COUNT * TM_RING_SIZE];
>>>
>>> I'm a bit dubious about representing the state with a full buffer lik=
e
>>> this.  Isn't a fair bit of this space reserved or derived values whic=
h
>>> aren't backed by real state?
>>
>> Under sPAPR only the TM_QW1_OS ring is accessed but the TM_QW0_USER=20
>> will also be when we support EBB.
>>
>> When running under the PowerNV machine, all rings could be accessed.
>> Today only 2 and 3 are.
>=20
> It's not the fact that all rings are exposed that I'm talking about.
> What I mean is that some of the logical register address space isn't
> actually by actually modifiable registers.  For example the HW CAM
> bits are hardwired to a value which can be derived from elsewhere.

yes indeed.

> Likewise the "highest pending priority" register or whatever it's
> called is AFAICT calculated on read from the CPPR and IPB.

yes. the PIPR is computed from the IPB. (patch 10)

> So the thing I'm questioning is having actual storage bytes associated
> with logical registers which are actually derived from other state.

having storage for word2 and word3 on all rings is questionable I agree,
but I think the eight (NSR CPPR IPB LSMFB ACK# INC AGE PIPR) registers=20
are good to have explicitly for the model. =20

It fits well the HW and all the TIMA accessors which would be much
more complex if we only represented the interesting bits we need
to transfer.=20

We also use the word0 and word1 to store the KVM state (os ring, maybe=20
user one day) directly pulled from the KVM VCPU structure. word2 is also=20
collected to print out the KVM VP identifier in the QEMU monitor. =20

So, I think these four quad-words are useful and their storage is=20
relatively small compared to the EAT (8bytes * nr_irqs) and ENDT=20
(32bytes * 8 * nr_cpus).

Thanks,

C.=20

>> It seemed correct to expose all registers under the thread interrupt
>> context model and filter the accesses with the TIMA. It fits the HW
>> well.
>=20
>>>> +
>>>> +    XiveRouter  *xrtr;
>>>
>>> What's this for?  AFAIK a TCTX isn't associated with a particular
>>> routing unit.
>>
>> I should have added the pointer in patch 11 where it is used. This is=20
>> to let the sPAPR XIVE controller model reset the OS CAM line with the=20
>> VP identifier.
>=20
>> The TCTX belong to the IVPE XIVE subengine and as the IVRE and IVPE ar=
e=20
>> modeled under the XiveRouter, it's not suprising to see this '*xrtr'=20
>> back pointer. But I agree we might not need.  Let's talk about it when=
=20
>> you reach patch 11.
>=20
> Ok.
>=20

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eFMZK-0002oT-Lr
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eFMZG-0001n5-Mk
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:59:10 -0500
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:50422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eFMZG-0001jq-FM
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 10:59:06 -0500
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 439899D3EA
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 16:59:03 +0100 (CET)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-2-clg@kaod.org> <20170919022719.GH27153@umbus>
	<d3ee87a7-208e-a172-094b-6aeedf8c5840@kaod.org>
	<20170922110040.GP4998@umbus.fritz.box>
	<fc6b85f6-fa5b-7ed2-2635-72aceda74305@kaod.org>
	<20170926035423.GH12504@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <be891296-6179-ad69-8c3b-a36b5908ca0e@kaod.org>
Date: Thu, 16 Nov 2017 16:58:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170926035423.GH12504@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/21] ppc/xive: introduce a
 skeleton for the sPAPR XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/26/2017 05:54 AM, David Gibson wrote:
> On Fri, Sep 22, 2017 at 02:42:07PM +0200, C=E9dric Le Goater wrote:
>> On 09/22/2017 01:00 PM, David Gibson wrote:
>>> On Tue, Sep 19, 2017 at 03:15:44PM +0200, C=E9dric Le Goater wrote:
>>>> On 09/19/2017 04:27 AM, David Gibson wrote:
>>>>> On Mon, Sep 11, 2017 at 07:12:15PM +0200, C=E9dric Le Goater wrote:
>>>>>> Start with a couple of attributes for the XIVE sPAPR controller
>>>>>> model. The number of provisionned IRQ is necessary to size the
>>>>>> different internal XIVE tables, the number of CPUs is also.
>>>>>>
>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>>>
>>>>> [snip]
>>>>>
>>>>>> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
>>>>>> +{
>>>>>> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
>>>>>> +
>>>>>> +    if (!xive->nr_targets) {
>>>>>> +        error_setg(errp, "Number of interrupt targets needs to be=
 greater 0");
>>>>>> +        return;
>>>>>> +    }
>>>>>> +    /* We need to be able to allocate at least the IPIs */
>>>>>> +    if (!xive->nr_irqs || xive->nr_irqs < xive->nr_targets) {
>>>>>> +        error_setg(errp, "Number of interrupts too small");
>>>>>> +        return;
>>>>>> +    }
>>>>>> +}
>>>>>> +
>>>>>> +static Property spapr_xive_properties[] =3D {
>>>>>> +    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
>>>>>> +    DEFINE_PROP_UINT32("nr-targets", sPAPRXive, nr_targets, 0),
>>>>>
>>>>> I'm a bit uneasy about the number of targets having to be set in
>>>>> advance: this can make life awkward when CPUs are hotplugged.  I kn=
ow
>>>>> there's something similar in xics, but it has caused some hassles, =
and
>>>>> we're starting to move away from it.
>>>>>
>>>>> Do you really need this?
>>>>>
>>>>
>>>> Some of the internal table size depend on the number of cpus=20
>>>> defined for the machine.
>>>
>>> Which ones?  My impression was that there needed to be at least #cpus
>>> * #priority-levels EQs, but there could be more than that,=20
>>
>> euh no, not in spapr mode at least. There are 8 queues per cpu.
>=20
> Ok.
>=20
>>> so it was no longer as tightly bound to the number if "interrupt serv=
ers"> as xics.
>>
>> ah. I think I see what you mean, that we could allocate them on the=20
>> fly when needed by some hcalls ?
>=20
> Not at hcall time, no, but at cpu hot(un)plug time I was wondering if w=
e
> could (de)allocate them then.

Yes. I am currently reshuffling the ppc/xive patchset on top of the=20
sPAPR allocator, also trying to take into account your comments and=20
Ben's. And I think we can do that.=20

I have introduced a specific XiveICPState (stored under the ->intc
pointer of the CPUState) but I think we can go a little further and
also store the XiveEQ array there. So that all the state related to=20
a CPU would be allocated at init time or hot(un)plug time hot time.

We could call the resulting compound object (ICP + EQs) a sPAPRXiveCore=20
or something like that. And we won't need to keep 'nr_targets' around=20
the sPAPR Xive object anymore *if* we do one more thing. See below.=20

>> The other place where I use the nr_targets is to provision the=20
>> IRQ numbers for the IPIs but that could probably be done in some=20
>> other way, specially it there is a IRQ allocator at the machine
>> level.
>=20
> Hm, ok.

The sPAPRXiveCore object above could also allocate the IPI for XIVE=20
when it is created. But, the resulting IRQ number should be in a range=20
not overlapping with the other devices' IRQs.=20

That means that we should probably introduce the BUID concept in the=20
IRQ allocator. This concept was left out from the original design of=20
XICS as it was using a single ICS but it would be useful to define=20
ranges for devices now. for PHBs for instance.

We could start with 2K or 4K ranges. The first one would be for IPIs.

Dave, could you please take a quick look at the allocator patchset=20
when you have some time. I don't think there is much to do in the API=20
to introduce ranges. It is just a question of defining a 'start' value=20
when looking for an empty slot. =20

Thanks,

C.=20

>>
>> C. =20
>>>> When the sPAPRXive object is instantiated,=20
>>>> we use xics_max_server_number() to get the max number of cpus
>>>> provisioned.
>>>>
>>>> C.
>>>>
>>>
>>
>=20

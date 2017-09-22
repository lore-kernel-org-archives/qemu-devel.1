Received: from eggs.gnu.org ([2001:4830:134:3::10]:59881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvNHg-0000RZ-Dq
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvNHb-0003lu-Fz
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:42:20 -0400
Received: from 1.mo179.mail-out.ovh.net ([178.33.111.220]:56710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dvNHb-0003jm-9a
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:42:15 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 9D037629F6
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 14:42:13 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-2-clg@kaod.org> <20170919022719.GH27153@umbus>
	<d3ee87a7-208e-a172-094b-6aeedf8c5840@kaod.org>
	<20170922110040.GP4998@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fc6b85f6-fa5b-7ed2-2635-72aceda74305@kaod.org>
Date: Fri, 22 Sep 2017 14:42:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170922110040.GP4998@umbus.fritz.box>
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

On 09/22/2017 01:00 PM, David Gibson wrote:
> On Tue, Sep 19, 2017 at 03:15:44PM +0200, C=E9dric Le Goater wrote:
>> On 09/19/2017 04:27 AM, David Gibson wrote:
>>> On Mon, Sep 11, 2017 at 07:12:15PM +0200, C=E9dric Le Goater wrote:
>>>> Start with a couple of attributes for the XIVE sPAPR controller
>>>> model. The number of provisionned IRQ is necessary to size the
>>>> different internal XIVE tables, the number of CPUs is also.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> [snip]
>>>
>>>> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
>>>> +
>>>> +    if (!xive->nr_targets) {
>>>> +        error_setg(errp, "Number of interrupt targets needs to be g=
reater 0");
>>>> +        return;
>>>> +    }
>>>> +    /* We need to be able to allocate at least the IPIs */
>>>> +    if (!xive->nr_irqs || xive->nr_irqs < xive->nr_targets) {
>>>> +        error_setg(errp, "Number of interrupts too small");
>>>> +        return;
>>>> +    }
>>>> +}
>>>> +
>>>> +static Property spapr_xive_properties[] =3D {
>>>> +    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
>>>> +    DEFINE_PROP_UINT32("nr-targets", sPAPRXive, nr_targets, 0),
>>>
>>> I'm a bit uneasy about the number of targets having to be set in
>>> advance: this can make life awkward when CPUs are hotplugged.  I know
>>> there's something similar in xics, but it has caused some hassles, an=
d
>>> we're starting to move away from it.
>>>
>>> Do you really need this?
>>>
>>
>> Some of the internal table size depend on the number of cpus=20
>> defined for the machine.
>=20
> Which ones?  My impression was that there needed to be at least #cpus
> * #priority-levels EQs, but there could be more than that,=20

euh no, not in spapr mode at least. There are 8 queues per cpu.

> so it was no longer as tightly bound to the number if "interrupt server=
s"> as xics.

ah. I think I see what you mean, that we could allocate them on the=20
fly when needed by some hcalls ?=20

The other place where I use the nr_targets is to provision the=20
IRQ numbers for the IPIs but that could probably be done in some=20
other way, specially it there is a IRQ allocator at the machine level.

C. =20
>> When the sPAPRXive object is instantiated,=20
>> we use xics_max_server_number() to get the max number of cpus
>> provisioned.
>>
>> C.
>>
>=20

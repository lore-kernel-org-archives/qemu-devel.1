Received: from eggs.gnu.org ([2001:4830:134:3::10]:56368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvN8V-0000Z6-5j
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvN8R-0005og-1j
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:51 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:54850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dvN8Q-0005nr-PR
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:46 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6321964E06
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 14:32:45 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170919082020.GT27153@umbus> <20170919084618.GY27153@umbus>
	<98b6f737-a554-1c83-79f9-2c8021e1cf69@kaod.org>
	<20170921012508.GA4998@umbus.fritz.box>
	<53b4c971-920f-816b-59fb-f77a03663d81@kaod.org>
	<20170922103350.GL4998@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <77052464-e455-757e-c2a7-e55bb7d26d14@kaod.org>
Date: Fri, 22 Sep 2017 14:32:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170922103350.GL4998@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/21] Guest exploitation of the
 XIVE interrupt controller (POWER9)
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

On 09/22/2017 12:33 PM, David Gibson wrote:
> On Thu, Sep 21, 2017 at 04:18:33PM +0200, C=E9dric Le Goater wrote:
>> On 09/21/2017 03:25 AM, David Gibson wrote:
>>> On Wed, Sep 20, 2017 at 02:33:37PM +0200, C=E9dric Le Goater wrote:
>>>> On 09/19/2017 10:46 AM, David Gibson wrote:
>>>>> On Tue, Sep 19, 2017 at 06:20:20PM +1000, David Gibson wrote:
>>>>>> On Mon, Sep 11, 2017 at 07:12:14PM +0200, C=E9dric Le Goater wrote=
:
>>>>>>> On a POWER9 sPAPR machine, the Client Architecture Support (CAS)
>>>>>>> negotiation process determines whether the guest operates with an
>>>>>>> interrupt controller using the XICS legacy model, as found on POW=
ER8,
>>>>>>> or in XIVE exploitation mode, the newer POWER9 interrupt model. T=
his
>>>>>>> patchset is a proposal to add XIVE support in POWER9 sPAPR machin=
e.
>>>>>>>
>>>>>>> Follows a model for the XIVE interrupt controller and support for=
 the
>>>>>>> Hypervisor's calls which are used to configure the interrupt sour=
ces
>>>>>>> and the event/notification queues of the guest. The last patch
>>>>>>> integrates XIVE in the sPAPR machine.
>>>>>>>
>>>>>>> Code is here:
>>>>>>
>>>>>>
>>>>>> An overall comment:
>>>>>>
>>>>>> I note in several replies here that I think the way XICS objects a=
re
>>>>>> re-used for XIVE is really ugly, and I think it will make future
>>>>>> maintenance pretty painful.
>>>>
>>>> I agree. That was one way to identify what we need for migration=20
>>>> compatibility and CAS reset.  =20
>>>>
>>>>>> I'm thinking maybe trying to support the CAS negotiation of interr=
upt
>>>>>> controller from day 1 is warping the design.  A better approach mi=
ght
>>>>>> be first to implement XIVE only when given a specific machine opti=
on -
>>>>>> guest gets one or the other and can't negotiate.
>>>>
>>>> ok.=20
>>>>
>>>> CAS is not the most complex problem, we mostly need to share=20
>>>> the ICSIRQState array and the source offset. migration from older
>>>> machine is a problem.
>>>
>>> Uh.. what?  Migration from an older machine isn't a thing.  We can
>>> migrate from an older qemu, but the machine type (and version) has to
>>> be identical at each end.  That's *why* we keep around the older
>>> machine types on newer qemus.
>>
>> yes. I am just wondering how I am going to handle a xics-only=20
>> machine migrating to a xics/xive machine.=20
>=20
> Won't ever happen.  Older machine types will always be xics, newer
> machine type will always be xive (at least with POWER9).
>=20
>> The xive machine option we are talking about will activate=20
>> the xive interrupt mode and instantiate the objects behind it.=20
>> So when we migrate from an older machine we will need to start=20
>> the target machine with xive=3Doff. I guess that is OK.
>=20
> Again, we *don't* migrate from an older machine.  Ever.  We only ever
> migrate from an older qemu version to a newer qemu using the older
> machine type.

Sorry I was talking about QEMU version, and not machine version.
I still have to look at how both machines will cohabitate in the=20
newer QEMU.=20

Thanks,

C.=20


>>
>> Thanks for the insights and the time to review the code,
>>
>> C.=20
>>
>>>> We are doomed to keep the existing XICS
>>>> framework available.
>>>>
>>>>>> That should allow a more natural XIVE design to emerge, *then* we =
can
>>>>>> look at what's necessary to make boot-time negotiation possible.
>>>>>
>>>>> Actually, it just occurred to me that we might be making life hard =
for
>>>>> ourselves by trying to actually switch between full XICS and XIVE
>>>>> models.  Coudln't we have new machine types always construct the XI=
VE
>>>>> infrastructure,=20
>>>>
>>>> yes.
>>>>
>>>>> but then implement the XICS RTAS and hcalls in terms of the XIVE vi=
rtual=20
>>>>> hardware.
>>>>
>>>> ok but migration will not be supported.
>>>
>>> Right, this would only be for newer machine types, and you can never
>>> migrate between different machine types.
>>>
>>>>> Since something more or less equivalent
>>>>> has already been done in both OPAL and the host kernel, I'm guessin=
g
>>>>> this shouldn't be too hard at this point.
>>>>
>>>> Indeed that is how it is working currently on P9 kvm guests. hcalls =
are
>>>> implemented on top of XIVE native.
>>>>
>>>> Thanks,
>>>>
>>>>
>>>> C.
>>>>
>>>
>>
>=20

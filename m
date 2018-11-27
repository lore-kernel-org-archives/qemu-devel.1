Received: from eggs.gnu.org ([2001:4830:134:3::10]:46910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRXpM-0002hy-9p
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gRXpI-0002KN-A3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:30:36 -0500
Received: from 2.mo6.mail-out.ovh.net ([46.105.76.65]:42723)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gRXpI-0002HV-2n
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:30:32 -0500
Received: from player756.ha.ovh.net (unknown [10.109.143.145])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id F30DC19BB00
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 08:30:21 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122044450.GF10448@umbus.fritz.box>
	<121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
	<20181123011005.GU10448@umbus.fritz.box>
	<12f3da3b-3761-a26f-4460-65d3c978f52d@kaod.org>
	<20181126054429.GH2251@umbus.fritz.box>
	<81ec65f1-f524-10af-8729-9abf890b4ee4@kaod.org>
	<20181127001118.GL2251@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e76b169e-eb36-e9c3-46a3-666f9de612e3@kaod.org>
Date: Tue, 27 Nov 2018 08:30:15 +0100
MIME-Version: 1.0
In-Reply-To: <20181127001118.GL2251@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 11/27/18 1:11 AM, David Gibson wrote:
> On Mon, Nov 26, 2018 at 10:39:44AM +0100, C=E9dric Le Goater wrote:
>> On 11/26/18 6:44 AM, David Gibson wrote:
>>> On Fri, Nov 23, 2018 at 11:28:24AM +0100, C=E9dric Le Goater wrote:
>>>> On 11/23/18 2:10 AM, David Gibson wrote:
>>>>> On Thu, Nov 22, 2018 at 05:50:07PM +1100, Benjamin Herrenschmidt wr=
ote:
>>>>>> On Thu, 2018-11-22 at 15:44 +1100, David Gibson wrote:
>>>>>>>
>>>>>>> Sorry, didn't think of this in my first reply.
>>>>>>>
>>>>>>> 1) Does the hardware ever actually write back to the EAS?  I know=
 it
>>>>>>> does for the END, but it's not clear why it would need to for the
>>>>>>> EAS.  If not, we don't need the setter.
>>>>>>
>>>>>> Nope, though the PAPR model will via hcalls
>>>>>
>>>>> Right, bit AIUI the set_eas hook is about abstracting PAPR vs bare
>>>>> metal details.  Since the hcall knows it's PAPR it can just update =
the
>>>>> backing information for the EAS directly, and no need for an
>>>>> abstracted hook.
>>>>
>>>> Indeed, the first versions of the XIVE patchset did not use such hoo=
ks,=20
>>>> but when discussed we said we wanted abstract methods for the router=
=20
>>>> to validate the overall XIVE model, which is useful for PowerNV.=20
>>>>
>>>> We can change again and have the hcalls get/set directly in the EAT
>>>> and ENDT. It would certainly simplify the sPAPR model.
>>>
>>> I think that's the better approach.
>>
>> ok. let's keep that in mind for  :=20
>>
>>  [PATCH v5 11/36] spapr/xive: use the VCPU id as a NVT identifier
>>  [PATCH v5 16/36] spapr: add hcalls support for the XIVE exploitation
>>
>> which are using the XiveRouter methods to access the controller EAT=20
>> and ENDT. I thought that was good practice to validate the model but=20
>> we can use direct sPAPR table accessors or none at all.
>=20
> Ok.  Consistency is good as a general rule, but I don't think it makes
> sense to force the EAT and the ENDT into the same model. =20

What do you mean by model ? the QEMU machine IC model ?

> The EAT is
> pure configuration, whereas the the ENDT has both configuration and
> status.  Or to look at it another way, the EAT is purely software
> controlled, whereas the ENDT is at least partially hardware
> controlled.

yes but the EAT and the ENDT are XIVE internal tables of the same XIVE=20
sub-engine, the IVRE, Interrupt Virtualization Routing Engine, formely=20
known as VC, for Virtualization Controller. the EAS is just an entry=20
point to the ENDT. I don't see why we would use different models for=20
them.

> (I realize that gets a bit fuzzy when considering PAPR, but I think
> from the point of view of the XIVE model it makes sense to treat the
> PAPR hypervisor logic as "software", even though it's "hardware" from t=
he
> guest point of view).

That I agree but the resulting code is too ugly in the hcalls. Tell me=20
when you reach patch 11, which links the machine IC model sPAPRXive to=20
the generic XiveRouter and also check patch 16 introducing the hcalls,=20
which update the XIVE internal tables.

Thanks,

C.=20

=20
>>
>>
>> I think these prereq patches could be merged now :
>>
>>  [PATCH v5 12/36] spapr: initialize VSMT before initializing the IRQ
>>  [PATCH v5 13/36] spapr: introduce a spapr_irq_init() routine
>>  [PATCH v5 14/36] spapr: modify the irq backend 'init' method
>>
>> This one also :
>>
>>  [PATCH v5 21/36] spapr: extend the sPAPR IRQ backend for XICS
>>
>> Thanks,
>>
>> C.=20
>>
>=20

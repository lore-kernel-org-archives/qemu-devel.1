Received: from eggs.gnu.org ([209.51.188.92]:47985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gudgF-0001wb-BB
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gudgE-0001gt-Hs
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:37:27 -0500
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:41448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gudgC-0001aG-15
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 08:37:24 -0500
Received: from player796.ha.ovh.net (unknown [10.109.160.153])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id CDBC420E6C3
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 14:37:21 +0100 (CET)
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023083585.1011724.2868047424353921455.stgit@bahia.lan>
	<57083069-924d-ddc5-2132-2e3b9588e968@kaod.org>
	<20190215143218.7342ceb2@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2052a2bc-49d0-d98b-dcd0-f01562811bcf@kaod.org>
Date: Fri, 15 Feb 2019 14:37:17 +0100
MIME-Version: 1.0
In-Reply-To: <20190215143218.7342ceb2@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/10] spapr/irq: Use the "simple" ICS
 class for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 2/15/19 2:32 PM, Greg Kurz wrote:
> On Fri, 15 Feb 2019 14:02:16 +0100
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> On 2/15/19 12:40 PM, Greg Kurz wrote:
>>> The "simple" ICS class knows how to interract with KVM. Adapt sPAPR t=
o use
>>> it instead of the ICS KVM class. =20
>>
>> You are changing the type name. What about migration ?=20
>>
>=20
> Huh ?!? I don't see how the type name would relate to migration. AFAICT=
 they
> aren't being referred to in the vmstate descriptors in xics.c.

In that case all is fine.

C.=20
>> Can't we move the xics_kvm_init() and xics_spapr_init() call under=20
>> spapr_ics_create() ? It would simplify a lot the routine I think
>> if these were done before creating the ICSState.=20
>>
>=20
> I'll look into that if there's a v2 or else in a followup patch.
>=20
>> C.
>>
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>  hw/ppc/spapr_irq.c |   15 +++++++--------
>>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
>>> index 9f43b7b3bf16..4aa8165307c7 100644
>>> --- a/hw/ppc/spapr_irq.c
>>> +++ b/hw/ppc/spapr_irq.c
>>> @@ -67,13 +67,12 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr=
)
>>>   */
>>> =20
>>>  static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
>>> -                                  const char *type_ics,
>>>                                    int nr_irqs, Error **errp)
>>>  {
>>>      Error *local_err =3D NULL;
>>>      Object *obj;
>>> =20
>>> -    obj =3D object_new(type_ics);
>>> +    obj =3D object_new(TYPE_ICS_SIMPLE);
>>>      object_property_add_child(OBJECT(spapr), "ics", obj, &error_abor=
t);
>>>      object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr)=
,
>>>                                     &error_abort);
>>> @@ -98,14 +97,14 @@ static void spapr_irq_init_xics(sPAPRMachineState=
 *spapr, int nr_irqs,
>>>  {
>>>      MachineState *machine =3D MACHINE(spapr);
>>>      Error *local_err =3D NULL;
>>> +    bool xics_kvm =3D false;
>>> =20
>>>      if (kvm_enabled()) {
>>>          if (machine_kernel_irqchip_allowed(machine) &&
>>>              !xics_kvm_init(spapr, &local_err)) {
>>> -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_=
irqs,
>>> -                                          &local_err);
>>> +            xics_kvm =3D true;
>>>          }
>>> -        if (machine_kernel_irqchip_required(machine) && !spapr->ics)=
 {
>>> +        if (machine_kernel_irqchip_required(machine) && !xics_kvm) {
>>>              error_prepend(&local_err,
>>>                            "kernel_irqchip requested but unavailable:=
 ");
>>>              goto error;
>>> @@ -114,12 +113,12 @@ static void spapr_irq_init_xics(sPAPRMachineSta=
te *spapr, int nr_irqs,
>>>          local_err =3D NULL;
>>>      }
>>> =20
>>> -    if (!spapr->ics) {
>>> +    if (!xics_kvm) {
>>>          xics_spapr_init(spapr);
>>> -        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_i=
rqs,
>>> -                                      &local_err);
>>>      }
>>> =20
>>> +    spapr->ics =3D spapr_ics_create(spapr, nr_irqs, &local_err);
>>> +
>>>  error:
>>>      error_propagate(errp, local_err);
>>>  }
>>>  =20
>>
>=20

Received: from eggs.gnu.org ([209.51.188.92]:43757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxA4g-0000NE-7W
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gxA4e-0003hq-BX
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:37:06 -0500
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:48644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gxA4d-0002pD-UH
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:37:04 -0500
Received: from player694.ha.ovh.net (unknown [10.109.146.50])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6281115D9B2
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 13:36:24 +0100 (CET)
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-14-clg@kaod.org>
	<20190212011153.GH1884@umbus.fritz.box>
	<d6dc35c6-4987-3fcc-de81-f2aff865cad1@kaod.org>
	<20190213013219.GU1884@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b2678261-7028-8d73-fc4a-473a4d1b2d1c@kaod.org>
Date: Fri, 22 Feb 2019 13:36:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190213013219.GU1884@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/13] spapr: add KVM support to the 'dual'
 machine
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

On 2/13/19 2:32 AM, David Gibson wrote:
> On Tue, Feb 12, 2019 at 08:18:19AM +0100, C=E9dric Le Goater wrote:
>> On 2/12/19 2:11 AM, David Gibson wrote:
>>> On Mon, Jan 07, 2019 at 07:39:46PM +0100, C=E9dric Le Goater wrote:
>>>> The interrupt mode is chosen by the CAS negotiation process and
>>>> activated after a reset to take into account the required changes in
>>>> the machine. This brings new constraints on how the associated KVM I=
RQ
>>>> device is initialized.
>>>>
>>>> Currently, each model takes care of the initialization of the KVM
>>>> device in their realize method but this is not possible anymore as t=
he
>>>> initialization needs to be done globaly when the interrupt mode is
>>>> known, i.e. when machine is reseted. It also means that we need a wa=
y
>>>> to delete a KVM device when another mode is chosen.
>>>>
>>>> Also, to support migration, the QEMU objects holding the state to
>>>> transfer should always be available but not necessarily activated.
>>>>
>>>> The overall approach of this proposal is to initialize both interrup=
t
>>>> mode at the QEMU level and keep the IRQ number space in sync to allo=
w
>>>> switching from one mode to another. For the KVM side of things, the
>>>> whole initialization of the KVM device, sources and presenters, is
>>>> grouped in a single routine. The XICS and XIVE sPAPR IRQ reset
>>>> handlers are modified accordingly to handle the init and the delete
>>>> sequences of the KVM device.
>>>>
>>>> As KVM is now initialized at reset, we loose the possiblity to
>>>> fallback to the QEMU emulated mode in case of failure and failures
>>>> become fatal to the machine.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/intc/spapr_xive.c     |  8 +---
>>>>  hw/intc/spapr_xive_kvm.c | 27 ++++++++++++++
>>>>  hw/intc/xics_kvm.c       | 25 +++++++++++++
>>>>  hw/intc/xive.c           |  4 --
>>>>  hw/ppc/spapr_irq.c       | 79 ++++++++++++++++++++++++++++---------=
---
>>>>  5 files changed, 109 insertions(+), 34 deletions(-)
>>>>
>>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>>>> index 21f3c1ef0901..0661aca35900 100644
>>>> --- a/hw/intc/spapr_xive.c
>>>> +++ b/hw/intc/spapr_xive.c
>>>> @@ -330,13 +330,7 @@ static void spapr_xive_realize(DeviceState *dev=
, Error **errp)
>>>>      xive->eat =3D g_new0(XiveEAS, xive->nr_irqs);
>>>>      xive->endt =3D g_new0(XiveEND, xive->nr_ends);
>>>> =20
>>>> -    if (kvmppc_xive_enabled()) {
>>>> -        kvmppc_xive_connect(xive, &local_err);
>>>> -        if (local_err) {
>>>> -            error_propagate(errp, local_err);
>>>> -            return;
>>>> -        }
>>>> -    } else {
>>>> +    if (!kvmppc_xive_enabled()) {
>>>>          /* TIMA initialization */
>>>>          memory_region_init_io(&xive->tm_mmio, OBJECT(xive), &xive_t=
m_ops, xive,
>>>>                                "xive.tima", 4ull << TM_SHIFT);
>>>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>>>> index d35814c1992e..3ebc947f2be7 100644
>>>> --- a/hw/intc/spapr_xive_kvm.c
>>>> +++ b/hw/intc/spapr_xive_kvm.c
>>>> @@ -737,6 +737,15 @@ void kvmppc_xive_connect(sPAPRXive *xive, Error=
 **errp)
>>>>      Error *local_err =3D NULL;
>>>>      size_t esb_len;
>>>>      size_t tima_len;
>>>> +    CPUState *cs;
>>>> +
>>>> +    /*
>>>> +     * The KVM XIVE device already in use. This is the case when
>>>> +     * rebooting XIVE -> XIVE
>>>
>>> Can this case actually occur?  Further down you appear to
>>> unconditionally destroy both KVM devices at reset time.
>>
>> I guess you are right. I will check.

So we have to keep it for ic-mode=3Dxive.

The number of test combinations is exploding. We now have :

3 hypervisors              KVM, KVM nested, QEMU TCG
3 Interrupt modes          xics, xive, dual (xics+xive)
3 kernel irqchip modes     off, allow, required.


C.
 =20

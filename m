Received: from eggs.gnu.org ([209.51.188.92]:55643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtshq-0005Xv-9c
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gtsho-00009H-Po
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:27:58 -0500
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:48406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gtshm-0008Cq-OQ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 06:27:54 -0500
Received: from player755.ha.ovh.net (unknown [10.109.146.19])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 267694451F
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 12:27:18 +0100 (CET)
Date: Wed, 13 Feb 2019 12:27:13 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190213122713.7ea8698b@bahia.lan>
In-Reply-To: <0ff3b713-7211-662e-8a16-96cfae840d4d@kaod.org>
References: <20190107183946.7230-1-clg@kaod.org>
	<20190107183946.7230-13-clg@kaod.org>
	<20190212010643.GG1884@umbus.fritz.box>
	<adcd2479-7a31-ba7d-50c6-cfa9af909f2e@kaod.org>
	<20190213013321.GV1884@umbus.fritz.box>
	<0ff3b713-7211-662e-8a16-96cfae840d4d@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 12/13] spapr/xics: ignore the
 lower 4K in the IRQ number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Wed, 13 Feb 2019 09:03:33 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 2/13/19 2:33 AM, David Gibson wrote:
> > On Tue, Feb 12, 2019 at 08:05:53AM +0100, C=C3=A9dric Le Goater wrote: =
=20
> >> On 2/12/19 2:06 AM, David Gibson wrote: =20
> >>> On Mon, Jan 07, 2019 at 07:39:45PM +0100, C=C3=A9dric Le Goater wrote=
: =20
> >>>> The IRQ number space of the XIVE and XICS interrupt mode are aligned
> >>>> when using the dual interrupt mode for the machine. This means that
> >>>> the ICS offset is set to zero in QEMU and that the KVM XICS device
> >>>> should be informed of this new value. Unfortunately, there is now way
> >>>> to do so and KVM still maintains the XICS_IRQ_BASE (0x1000) offset.
> >>>>
> >>>> Ignore the lower 4K which are not used under the XICS interrupt
> >>>> mode. These IRQ numbers are only claimed by XIVE for the CPU IPIs.
> >>>>
> >>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  hw/intc/xics_kvm.c | 18 ++++++++++++++++++
> >>>>  1 file changed, 18 insertions(+)
> >>>>
> >>>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> >>>> index 651bbfdf6966..1d21ff217b82 100644
> >>>> --- a/hw/intc/xics_kvm.c
> >>>> +++ b/hw/intc/xics_kvm.c
> >>>> @@ -238,6 +238,15 @@ static void ics_get_kvm_state(ICSState *ics)
> >>>>      for (i =3D 0; i < ics->nr_irqs; i++) {
> >>>>          ICSIRQState *irq =3D &ics->irqs[i];
> >>>> =20
> >>>> +        /*
> >>>> +         * The KVM XICS device considers that the IRQ numbers should
> >>>> +         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
> >>>> +         * numbers (only claimed by XIVE for the CPU IPIs).
> >>>> +         */
> >>>> +        if (i + ics->offset < XICS_IRQ_BASE) {
> >>>> +            continue;
> >>>> +        }
> >>>> + =20
> >>>
> >>> This seems bogus to me.  The guest-visible irq numbers need to line up
> >>> between xics and xive mode, yes, but that doesn't mean we need to keep
> >>> around a great big array of unused array of ICS irq states, even in
> >>> TCG mode. =20
> >>
> >> This is because the qirqs[] array is under the machine and shared betw=
een=20
> >> both interrupt modes, xics and xive. =20
> >=20
> > I don't see how that follows.  ICSIRQState is indexed in terms of the
> > ICS source number, not the global irq number, so I don't see why it
> > has to match up with the qirq array. =20
>=20
> The root cause is the use of spapr->irq->nr_irqs to initialize the ICS=20
> and sPAPRXive object. In case of the 'dual' backend, it covers the full=20
> XIVE IRQ number space (0x2000 today) but XICS only needs 0x1000.
>=20
> I think we can fix the offset issue by using the appropriate nr_irqs=20
> which should be for the XICS backend : spapr->irq->nr_irqs - ics->offset
>=20

Since the root cause is that the value of spapr->irq->nr_irqs should
be different in XIVE and XICS, what about fixing it during reset ?

Something like:

static void spapr_irq_reset_dual(sPAPRMachineState *spapr, Error **errp)
{
    [...]

    spapr->irq->nr_irqs =3D spapr_irq_current(spapr)->nr_irqs;

    spapr_irq_current(spapr)->reset(spapr, errp);
}

>=20
> I keep in mind the XIVE support for nested guests and I think we will
> need to extend the IRQ number space in L1 and have the L2 use a portion
> of it (using an offset).    =20
>=20
> C.
> =20
> >>> =20
> >>>>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
> >>>>                            i + ics->offset, &state, false, &error_fa=
tal);
> >>>> =20
> >>>> @@ -303,6 +312,15 @@ static int ics_set_kvm_state(ICSState *ics, int=
 version_id)
> >>>>          ICSIRQState *irq =3D &ics->irqs[i];
> >>>>          int ret;
> >>>> =20
> >>>> +        /*
> >>>> +         * The KVM XICS device considers that the IRQ numbers should
> >>>> +         * start at XICS_IRQ_BASE (0x1000). Ignore the lower 4K
> >>>> +         * numbers (only claimed by XIVE for the CPU IPIs).
> >>>> +         */
> >>>> +        if (i + ics->offset < XICS_IRQ_BASE) {
> >>>> +            continue;
> >>>> +        }
> >>>> +
> >>>>          state =3D irq->server;
> >>>>          state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORI=
TY_MASK)
> >>>>              << KVM_XICS_PRIORITY_SHIFT; =20
> >>> =20
> >> =20
> >  =20
>=20
>=20

Received: from eggs.gnu.org ([2001:4830:134:3::10]:45254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUqsF-0008Ke-Ug
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:55:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fUqsC-0001mJ-SD
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:55:00 -0400
Received: from 14.mo6.mail-out.ovh.net ([46.105.56.113]:40470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fUqsC-0001lR-Ly
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 05:54:56 -0400
Received: from player691.ha.ovh.net (unknown [10.109.108.78])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 4212D165091
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:54:54 +0200 (CEST)
Date: Mon, 18 Jun 2018 11:54:44 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180618115444.094d4b1c@bahia.lan>
In-Reply-To: <26b2695c-8b7e-d5f7-7069-cb234aaf5a2e@kaod.org>
References: <20180615115303.31125-1-clg@kaod.org>
	<20180615115303.31125-4-clg@kaod.org>
	<20180615180311.6d16e506@bahia.lan>
	<c5182296-b9f5-0072-8d13-551d71560394@kaod.org>
	<20180618104208.66a9f09e@bahia.lan>
	<26b2695c-8b7e-d5f7-7069-cb234aaf5a2e@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/3] spapr: introduce a fixed
 IRQ number space
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

On Mon, 18 Jun 2018 10:56:55 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> [ ... ]
>=20
> >>> This is 4 irqs per PHB, hence up to 32 PHBs. Cool, we're currently
> >>> limited to 31 PHBs.
> >>>    =20
> >>>> +#define SPAPR_IRQ_MSI        0x1100  /* Offset of the dynamic range=
 covered   =20
> >>>
> >>> We only support dynamic MSIs with PCI, maybe rename to SPAPR_IRQ_PCI_=
MSI ?   =20
> >>
> >> hmm, no. We could have CAPI devices there. remember ? ;)
> >> =20
> >=20
> > Well... OpenCAPI devices are exposed to the OS as PCI devices, so I'm n=
ot
> > sure we need a CAPI specific range. =20
>=20
> yes. so this range is common to all devices doing dynamic allocation
> of IRQs. How should we call it ?=20
>=20
> >>>> +                                      * by the bitmap allocator */ =
  =20
> >>>
> >>> The range size is hence 1k (XICS_IRQS_SPAPR) for the time being.   =20
> >>
> >> in fact we could this bogus limit and use spapr->irq_map_nr now.
> >> =20
> >=20
> > "we could *missing verb* this bogus limit"... so I'm not sure to
> > understand... =20
>=20
> oups. We could use spapr->irq_map_nr instead of XICS_IRQS_SPAPR when
> defining :=20
>=20
>     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS_SP=
APR));
>=20
> in spapr_pci.c
>=20

Ah... yeah, I've always found weird that all PHBs advertise the same number
of available MSIs as the total number of irqs for the whole machine. And
putting spapr->irq_map_nr looks weird all the same if all PHBs rely on the
same bitmap actually.

I'm thinking of doing the other way around: keep XICS_IRQS_SPAPR in
"ibm,pe-total-#msi" and have one XICS_IRQS_SPAPR sized bitmap per PHB.

> [ ... ]
>=20
> >>>> +        if (spapr->xics_legacy) {
> >>>> +            dev->irq =3D spapr_irq_findone(spapr, &local_err);
> >>>> +            if (local_err) {
> >>>> +                error_propagate(errp, local_err);
> >>>> +                return;
> >>>> +            }
> >>>> +        } else {
> >>>> +            dev->irq =3D SPAPR_IRQ_VIO + vio_index++;   =20
> >>>
> >>> This can overlap the next range if we have more than 64 VIO devices..=
.   =20
> >>
> >> yes. but claim() should fail.
> >> =20
> >=20
> > Hmm... I have the impression claim() only fails if:
> > - irq < ics->offset (ie, XICS_IRQ_BASE =3D=3D 4096)
> > - or irq >=3D ics->offset + ics->nr_irqs (ie, XICS_IRQS_SPAPR =3D=3D 10=
24)
> > - or irq is already in use
> >=20
> > I can't find code that would prevent dev->irq to reach SPAPR_IRQ_MSI. =
=20
>=20
> Ah yes. It can overlap.=20
>=20
> My previous proposal took care of overlaps but something simpler was=20
> requested. That's how I understand it at least. We can introduce=20
> a maximum for the VIO range or live with it.=20

Hmm... I'm not very comfortable with the VIO range silently stealing an
irq number from the bitmap allocator. This would cause spapr_irq_msi_alloc()
to return a value that causes spapr_irq_claim() to fail, which looks buggy.

>=20
> C.

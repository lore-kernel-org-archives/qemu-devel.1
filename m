Received: from eggs.gnu.org ([2001:4830:134:3::10]:54187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eF0nC-0007k2-Oy
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 11:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eF0n8-0007V0-Qk
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 11:44:02 -0500
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:47624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eF0n8-0007TG-K0
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 11:43:58 -0500
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 969A611F824
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 17:43:56 +0100 (CET)
Date: Wed, 15 Nov 2017 17:43:50 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171115174350.7be03806@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <b0f4ee84-4d95-7c35-a9bd-b34cd8fa725a@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-8-clg@kaod.org>
	<20171114164516.635c3a14@bahia.lab.toulouse-stg.fr.ibm.com>
	<b0f4ee84-4d95-7c35-a9bd-b34cd8fa725a@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 07/11] spapr: introduce an
 'irq_base' number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Wed, 15 Nov 2017 15:24:08 +0000
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 11/14/2017 03:45 PM, Greg Kurz wrote:
> > On Fri, 10 Nov 2017 15:20:13 +0000
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> >> 'irq_base' is a base IRQ number which lets us allocate only the subset
> >> of the IRQ numbers used on the sPAPR platform. It is sync with the
> >> ICSState 'offset' attribute and this is slightly redundant. We could
> >> also choose to waste some extra bytes (512) and allocate the whole
> >> number space. To be discussed.
> >>
> >> But more important, it removes a dependency on the ICSState object of
> >> the sPAPR machine which is required for XIVE.
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/ppc/spapr.c         | 7 ++++---
> >>  include/hw/ppc/spapr.h | 1 +
> >>  2 files changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index bf0e5b4f815b..1cbbd7715a85 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -2362,6 +2362,7 @@ static void ppc_spapr_init(MachineState *machine)
> >>      /* Initialize the IRQ allocator */
> >>      spapr->nr_irqs  =3D XICS_IRQS_SPAPR;
> >>      spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
> >> +    spapr->irq_base =3D XICS_IRQ_BASE;
> >> =20
> >=20
> > Since this is a constant value, do we really need a machine-level value=
 ? =20
>=20
> no. I don't think either.  =20
>=20
> But I would like to know why we are starting to allocate IRQ numbers=20
> at 4096 ? Only 2 is reserved fo IPIs. So that seems a little large.=20
> I have not found the reason though.
>=20

Same here... I've tried to git blame/log and google qemu-devel archives
and couldn't find anything either.

>=20
> Also I am starting to think that we should probably segment the allocatio=
n=20
> per device like this is specified in the PAPR specs. Each device has one=
=20
> or more Bus Unit IDentifier (BUID) which acts as a prefix for the IRQ=20
> number. That would facilitate the IRQ numbering and fix some issues=20
> in migration when devices are hotplugged. I am thinking about phbs
> mostly.

Makes sense. Also there's something we should clarify: we create one ICS for
the entire machine, able to handle XICS_IRQS_SPAPR (=3D=3D 1024) irqs. But =
each PHB
advertises it can provide XICS_IRQS_SPAPR MSIs through the =E2=80=9Cibm,pe-=
total-#msi=E2=80=9D
DT prop... this looks wrong.

>=20
> C.
>=20
>=20
> > Especially now that all the code that needs it is in spapr.c, I guess it
> > can directly use the macro, no ?
> >  =20
> >>      /* Set up Interrupt Controller before we create the VCPUs */
> >>      xics_system_init(machine, spapr->nr_irqs, &error_fatal);
> >> @@ -3630,7 +3631,7 @@ static void spapr_irq_free_block_2_11(XICSFabric=
 *xi, int irq, int num)
> >>  static bool spapr_irq_test(XICSFabric *xi, int irq)
> >>  {
> >>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> >> -    int srcno =3D irq - spapr->ics->offset;
> >> +    int srcno =3D irq - spapr->irq_base;
> >> =20
> >>      return test_bit(srcno, spapr->irq_map);
> >>  }
> >> @@ -3656,13 +3657,13 @@ static int spapr_irq_alloc_block(XICSFabric *x=
i, int count, int align)
> >>      }
> >> =20
> >>      bitmap_set(spapr->irq_map, srcno, count);
> >> -    return srcno + spapr->ics->offset;
> >> +    return srcno + spapr->irq_base;
> >>  }
> >> =20
> >>  static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
> >>  {
> >>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> >> -    int srcno =3D irq - spapr->ics->offset;
> >> +    int srcno =3D irq - spapr->irq_base;
> >> =20
> >>      bitmap_clear(spapr->irq_map, srcno, num);
> >>  }
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 023436c32b2a..200667dcff9d 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -82,6 +82,7 @@ struct sPAPRMachineState {
> >>      int32_t nr_irqs;
> >>      unsigned long *irq_map;
> >>      unsigned long *irq_map_ref;
> >> +    uint32_t irq_base;
> >>      ICSState *ics;
> >>      sPAPRRTCState rtc;
> >>   =20
> >  =20
>=20

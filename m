Received: from eggs.gnu.org ([2001:4830:134:3::10]:53611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eGkrq-0005rU-Rd
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eGkrn-0008GI-HS
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:08:02 -0500
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:48094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eGkrn-0008Fa-75
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 07:07:59 -0500
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id C3B1F7C939
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 13:07:56 +0100 (CET)
Date: Mon, 20 Nov 2017 13:07:42 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171120130742.7410a80b@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20171117045053.GB26448@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-6-clg@kaod.org>
	<20171114104224.63ed5e87@bahia.lan>
	<20171117045053.GB26448@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/QVgYRzzPIiZt4M_y7Edlc2E";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 05/11] spapr: introduce an IRQ
 allocator using a bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

--Sig_/QVgYRzzPIiZt4M_y7Edlc2E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Nov 2017 15:50:53 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Nov 14, 2017 at 10:42:24AM +0100, Greg Kurz wrote:
> > On Fri, 10 Nov 2017 15:20:11 +0000
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >  =20
> > > Let's define a new set of XICSFabric IRQ operations for the latest
> > > pseries machine. These simply use a a bitmap 'irq_map' as a IRQ number
> > > allocator.
> > >=20
> > > The previous pseries machines keep the old set of IRQ operations using
> > > the ICSIRQState array.
> > >=20
> > > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > > ---
> > >=20
> > >  Changes since v2 :
> > >=20
> > >  - introduced a second set of XICSFabric IRQ operations for older
> > >    pseries machines
> > >=20
> > >  hw/ppc/spapr.c         | 76 ++++++++++++++++++++++++++++++++++++++++=
++++++----
> > >  include/hw/ppc/spapr.h |  3 ++
> > >  2 files changed, 74 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 4bdceb45a14f..4ef0b73559ca 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1681,6 +1681,22 @@ static const VMStateDescription vmstate_spapr_=
patb_entry =3D {
> > >      },
> > >  };
> > > =20
> > > +static bool spapr_irq_map_needed(void *opaque)
> > > +{
> > > +    return true; =20
> >=20
> > I see that the next patch adds some code to avoid sending the
> > bitmap if it doesn't contain state, but I guess you should also
> > explicitly have this function to return false for older machine
> > types (see remark below). =20
>=20
> I don't see that you should need to migrate this at all.  The machine
> needs to reliably allocate the same interrupts each time, and that
> means source and dest should have the same allocations without
> migrating data.
>=20

Is this true for MSIs ? With the current code, the guest can change
the allocation of such interrupts with the ibm,rtas-change-msi RTAS
call. How can the dest know about that ?

> >  =20
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_spapr_irq_map =3D {
> > > +    .name =3D "spapr_irq_map",
> > > +    .version_id =3D 0,
> > > +    .minimum_version_id =3D 0,
> > > +    .needed =3D spapr_irq_map_needed,
> > > +    .fields =3D (VMStateField[]) {
> > > +        VMSTATE_BITMAP(irq_map, sPAPRMachineState, 0, nr_irqs),
> > > +        VMSTATE_END_OF_LIST()
> > > +    },
> > > +};
> > > +
> > >  static const VMStateDescription vmstate_spapr =3D {
> > >      .name =3D "spapr",
> > >      .version_id =3D 3,
> > > @@ -1700,6 +1716,7 @@ static const VMStateDescription vmstate_spapr =
=3D {
> > >          &vmstate_spapr_ov5_cas,
> > >          &vmstate_spapr_patb_entry,
> > >          &vmstate_spapr_pending_events,
> > > +        &vmstate_spapr_irq_map,
> > >          NULL
> > >      }
> > >  };
> > > @@ -2337,8 +2354,12 @@ static void ppc_spapr_init(MachineState *machi=
ne)
> > >      /* Setup a load limit for the ramdisk leaving room for SLOF and =
FDT */
> > >      load_limit =3D MIN(spapr->rma_size, RTAS_MAX_ADDR) - FW_OVERHEAD;
> > > =20
> > > +    /* Initialize the IRQ allocator */
> > > +    spapr->nr_irqs  =3D XICS_IRQS_SPAPR;
> > > +    spapr->irq_map  =3D bitmap_new(spapr->nr_irqs);
> > > + =20
> >=20
> > I think you should introduce a sPAPRMachineClass::has_irq_bitmap boolean
> > so that the bitmap is only allocated for newer machine types. And you s=
hould
> > then use this flag in spapr_irq_map_needed() above.
> >=20
> > Apart from that, the rest of the patch looks good.
> >  =20
> > >      /* Set up Interrupt Controller before we create the VCPUs */
> > > -    xics_system_init(machine, XICS_IRQS_SPAPR, &error_fatal);
> > > +    xics_system_init(machine, spapr->nr_irqs, &error_fatal);
> > > =20
> > >      /* Set up containers for ibm,client-architecture-support negotia=
ted options
> > >       */
> > > @@ -3560,7 +3581,7 @@ static int ics_find_free_block(ICSState *ics, i=
nt num, int alignnum)
> > >      return -1;
> > >  }
> > > =20
> > > -static bool spapr_irq_test(XICSFabric *xi, int irq)
> > > +static bool spapr_irq_test_2_11(XICSFabric *xi, int irq)
> > >  {
> > >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> > >      ICSState *ics =3D spapr->ics;
> > > @@ -3569,7 +3590,7 @@ static bool spapr_irq_test(XICSFabric *xi, int =
irq)
> > >      return !ICS_IRQ_FREE(ics, srcno);
> > >  }
> > > =20
> > > -static int spapr_irq_alloc_block(XICSFabric *xi, int count, int alig=
n)
> > > +static int spapr_irq_alloc_block_2_11(XICSFabric *xi, int count, int=
 align)
> > >  {
> > >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> > >      ICSState *ics =3D spapr->ics;
> > > @@ -3583,7 +3604,7 @@ static int spapr_irq_alloc_block(XICSFabric *xi=
, int count, int align)
> > >      return srcno + ics->offset;
> > >  }
> > > =20
> > > -static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
> > > +static void spapr_irq_free_block_2_11(XICSFabric *xi, int irq, int n=
um)
> > >  {
> > >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> > >      ICSState *ics =3D spapr->ics;
> > > @@ -3601,6 +3622,46 @@ static void spapr_irq_free_block(XICSFabric *x=
i, int irq, int num)
> > >      }
> > >  }
> > > =20
> > > +static bool spapr_irq_test(XICSFabric *xi, int irq)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> > > +    int srcno =3D irq - spapr->ics->offset;
> > > +
> > > +    return test_bit(srcno, spapr->irq_map);
> > > +}
> > > +
> > > +static int spapr_irq_alloc_block(XICSFabric *xi, int count, int alig=
n)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> > > +    int start =3D 0;
> > > +    int srcno;
> > > +
> > > +    /*
> > > +     * The 'align_mask' parameter of bitmap_find_next_zero_area()
> > > +     * should be one less than a power of 2; 0 means no
> > > +     * alignment. Adapt the 'align' value of the former allocator to
> > > +     * fit the requirements of bitmap_find_next_zero_area()
> > > +     */
> > > +    align -=3D 1;
> > > +
> > > +    srcno =3D bitmap_find_next_zero_area(spapr->irq_map, spapr->nr_i=
rqs, start,
> > > +                                       count, align);
> > > +    if (srcno =3D=3D spapr->nr_irqs) {
> > > +        return -1;
> > > +    }
> > > +
> > > +    bitmap_set(spapr->irq_map, srcno, count);
> > > +    return srcno + spapr->ics->offset;
> > > +}
> > > +
> > > +static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> > > +    int srcno =3D irq - spapr->ics->offset;
> > > +
> > > +    bitmap_clear(spapr->irq_map, srcno, num);
> > > +}
> > > +
> > >  static void spapr_pic_print_info(InterruptStatsProvider *obj,
> > >                                   Monitor *mon)
> > >  {
> > > @@ -3778,7 +3839,12 @@ static void spapr_machine_2_11_instance_option=
s(MachineState *machine)
> > > =20
> > >  static void spapr_machine_2_11_class_options(MachineClass *mc)
> > >  {
> > > -    /* Defaults for the latest behaviour inherited from the base cla=
ss */
> > > +    XICSFabricClass *xic =3D XICS_FABRIC_CLASS(mc);
> > > +
> > > +    spapr_machine_2_12_class_options(mc);
> > > +    xic->irq_test =3D spapr_irq_test_2_11;
> > > +    xic->irq_alloc_block =3D spapr_irq_alloc_block_2_11;
> > > +    xic->irq_free_block =3D spapr_irq_free_block_2_11;
> > >  }
> > > =20
> > >  DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index 9d21ca9bde3a..5835c694caff 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -7,6 +7,7 @@
> > >  #include "hw/ppc/spapr_drc.h"
> > >  #include "hw/mem/pc-dimm.h"
> > >  #include "hw/ppc/spapr_ovec.h"
> > > +#include "qemu/bitmap.h"
> > > =20
> > >  struct VIOsPAPRBus;
> > >  struct sPAPRPHBState;
> > > @@ -78,6 +79,8 @@ struct sPAPRMachineState {
> > >      struct VIOsPAPRBus *vio_bus;
> > >      QLIST_HEAD(, sPAPRPHBState) phbs;
> > >      struct sPAPRNVRAM *nvram;
> > > +    int32_t nr_irqs;
> > > +    unsigned long *irq_map;
> > >      ICSState *ics;
> > >      sPAPRRTCState rtc;
> > >   =20
> >  =20
>=20


--Sig_/QVgYRzzPIiZt4M_y7Edlc2E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAloSxY4ACgkQcdTV5YIv
c9Zy5hAAxm0NNlkdPfXR6Y27PB8Y9DZp3jj5+NRW9vsErOn1pLDWzrp8MhpFEkpP
PZVr60YwuKxVZKQ42yfcYga338PekDW5Wh7tPyMzgyxqgF0Emed7IvSg9y6a4/Sc
bLSAz0Xiu+qSHCQhssJQCuW5b4SmK/MAsslclLPFcN5JE5cnkBiQmJIUwkEi+XvI
+LktymON29DxT8fqxbMrf4VudaoutFqiMpK5eS5/giAyftNKuihh9HPjJ6eC6LqK
f/VfiD5IDtWfhjow9J3QaAkXoRu0jWOylZ9GDAKRAqsR360tM418rYTMfjsR/ChI
Z6sGxh4MZ018EAwhMgLjvbVx7sb6GTHi594vVxRWexK40j8714ZLgzn8oFQE4JMh
cPzgyPemcXyWuEpSju55bvCFdrJ5KDoU1SFMuYIW2bLUn3wIQqFJTbunpuOP3bk7
uy6dL0dshl88ovHy+z/IhwXZPFuO6psJRoFoBPJtiRFapveBkPhfhO//AGQAYuI0
TNIQzX6aLlId7h89AZl20Z4cOa3fk99vkJcLDH3k2METxHM4dBHD+mzOKxrXGpgA
D7qIuuuqe0khAF3D0Xqw+zeRTgxnVxZCiF0MHBifaB8qGWqXx3/3ucmrpJ4OiSQN
VXWl+0I6GyjzXczH/J3lwzPGZ0YkZLxPPdq8Dq37ZA6RIk7aKOI=
=LuC6
-----END PGP SIGNATURE-----

--Sig_/QVgYRzzPIiZt4M_y7Edlc2E--

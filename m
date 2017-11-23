Received: from eggs.gnu.org ([2001:4830:134:3::10]:54792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHpSA-0005CS-T9
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:14:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHpS4-0005QG-Mf
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:13:58 -0500
Date: Thu, 23 Nov 2017 22:07:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171123110701.GB22454@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-4-clg@kaod.org>
	<20171117044825.GA26448@umbus.fritz.box>
	<ef798010-c69f-2a7c-c083-7f6d227e4836@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <ef798010-c69f-2a7c-c083-7f6d227e4836@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 03/11] spapr: introduce new
 XICSFabric operations for an IRQ allocator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2017 at 08:16:47AM +0100, C=E9dric Le Goater wrote:
> On 11/17/2017 05:48 AM, David Gibson wrote:
> > On Fri, Nov 10, 2017 at 03:20:09PM +0000, C=E9dric Le Goater wrote:
> >> Currently, the ICSState 'ics' object of the sPAPR machine acts as the
> >> global interrupt source handler and also as the IRQ number allocator
> >> for the machine. Some IRQ numbers are allocated very early in the
> >> machine initialization sequence to populate the device tree, and this
> >> is a problem to introduce the new POWER XIVE interrupt model, as it
> >> needs to share the IRQ numbers with the older model.
> >>
> >> To prepare ground for XIVE, here is a set of new XICSFabric operations
> >> to let the machine handle directly the IRQ number allocation and to
> >> decorrelate the allocation from the interrupt source object :
> >>
> >>     bool (*irq_test)(XICSFabric *xi, int irq);
> >>     int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
> >>     void (*irq_free_block)(XICSFabric *xi, int irq, int num);
> >>
> >> In these prototypes, the 'irq' parameter refers to a number in the
> >> global IRQ number space. Indexes for arrays storing different state
> >> informations on the interrupts, like the ICSIRQState, are usually
> >> named 'srcno'.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > This doesn't seem sensible to me.  When I said you should move irq
> > allocation to the machine, I mean actually move the code.  The only
> > user of irq allocation should be in the machine, so we shouldn't need
> > to indirect via the XICSFabric interface to do that.
>=20
> OK. so we can probably do the same with machine class handlers because=20
> we do need an indirection to handle the way older pseries machines=20
> allocate IRQs that will change with newer machines  supporting XIVE.

Right.  You could do it either with a MachineClass callback (similar
to the phb placement one), or with just a flag in the MachineClass
that's checked explicitly.  I'd be ok with either approach.

> > And, we shouldn't be using XICSFabric things for XIVE.
>=20
> ok. The spapr machine should be enough.=20
>=20
> Thanks,
>=20
> C.
> =20
> >> ---
> >>  hw/ppc/spapr.c        | 19 +++++++++++++++++++
> >>  include/hw/ppc/xics.h |  4 ++++
> >>  2 files changed, 23 insertions(+)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index a2dcbee07214..84d68f2fdbae 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -3536,6 +3536,21 @@ static ICPState *spapr_icp_get(XICSFabric *xi, =
int vcpu_id)
> >>      return cpu ? ICP(cpu->intc) : NULL;
> >>  }
> >> =20
> >> +static bool spapr_irq_test(XICSFabric *xi, int irq)
> >> +{
> >> +    return false;
> >> +}
> >> +
> >> +static int spapr_irq_alloc_block(XICSFabric *xi, int count, int align)
> >> +{
> >> +    return -1;
> >> +}
> >> +
> >> +static void spapr_irq_free_block(XICSFabric *xi, int irq, int num)
> >> +{
> >> +    ;
> >> +}
> >> +
> >>  static void spapr_pic_print_info(InterruptStatsProvider *obj,
> >>                                   Monitor *mon)
> >>  {
> >> @@ -3630,6 +3645,10 @@ static void spapr_machine_class_init(ObjectClas=
s *oc, void *data)
> >>      xic->ics_get =3D spapr_ics_get;
> >>      xic->ics_resend =3D spapr_ics_resend;
> >>      xic->icp_get =3D spapr_icp_get;
> >> +    xic->irq_test =3D spapr_irq_test;
> >> +    xic->irq_alloc_block =3D spapr_irq_alloc_block;
> >> +    xic->irq_free_block =3D spapr_irq_free_block;
> >> +
> >>      ispc->print_info =3D spapr_pic_print_info;
> >>      /* Force NUMA node memory size to be a multiple of
> >>       * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
> >> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> >> index 28d248abad61..30e7f2e0a7dd 100644
> >> --- a/include/hw/ppc/xics.h
> >> +++ b/include/hw/ppc/xics.h
> >> @@ -175,6 +175,10 @@ typedef struct XICSFabricClass {
> >>      ICSState *(*ics_get)(XICSFabric *xi, int irq);
> >>      void (*ics_resend)(XICSFabric *xi);
> >>      ICPState *(*icp_get)(XICSFabric *xi, int server);
> >> +    /* IRQ allocator helpers */
> >> +    bool (*irq_test)(XICSFabric *xi, int irq);
> >> +    int (*irq_alloc_block)(XICSFabric *xi, int count, int align);
> >> +    void (*irq_free_block)(XICSFabric *xi, int irq, int num);
> >>  } XICSFabricClass;
> >> =20
> >>  #define XICS_IRQS_SPAPR               1024
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloWq9IACgkQbDjKyiDZ
s5KtOw/+IM5KvjaLnMiYa/q7TXyWrPPZWyqWvu/wBqUFSAuNGvZN0uwfxdQqYBeo
vKqVhshAQgQE50wkUH/HG1ZHGs+QtcIf//PMicWl6johWwot68qgz5lhHUDiTavE
2JgLTIXUO1rJNVG5TStYKfuEYgLhOTDe8jfMJUGELVvdVx5ym2UvtL5gG/mP7kdQ
8uLhqVhzVYefgD6jSPHzooyf4KW80yFIOFFQeNmBd2N9E0V+Eqe5t50TXDsujArR
dxB2KrRpKe/yDP4ZytrYORBmQhq4dK4EE7sOKAWt0RIuRdIqcDB4lJbyEjJMMAlI
vzO2snQ81Jzqc0VHgZPwkRINDNW8+Ls7LVM4S1MwYHAZwhsW2rRAX+IYvDtfc7f2
TL7og6KdHzaOu+JDNE6I6cFTU+GUuwJL5kSdNAUePzcBhykxot7bvuc5dF/UmF8b
bJUVyic+457+cI8BQm7kH98WRxQhtzr3QGf4hkRj9oVDm2tPM74dHbeaeNlpOzpc
KzydbF/vYQVXH19R3uUx0hGXSjDSzsUeB0wNy8lyvx7BZUrlBFTUmsdPw71+Ji9r
U4J0e4En9t6tN2MaPba+GtaEZsRE+fJ5tBkB9d42Za/k9dXVc+W2tJilBZgMj8uG
E2AARHyMiVJkuMe/urv3D6KyWXa1E7MaXD3d0JbPGXEkJQoqM10=
=KV6S
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--

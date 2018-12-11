Received: from eggs.gnu.org ([2001:4830:134:3::10]:35574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWUx-0001TM-B3
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWWUv-0004Tg-MD
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 20:06:07 -0500
Date: Tue, 11 Dec 2018 11:38:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181211003857.GY4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-10-clg@kaod.org>
	<20181210063919.GU4261@umbus.fritz.box>
	<dc1104f1-0809-e7df-b145-e7faa2255fe6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bW7Nw90iaNQhVLQB"
Content-Disposition: inline
In-Reply-To: <dc1104f1-0809-e7df-b145-e7faa2255fe6@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 09/19] spapr: add device tree support
 for the XIVE exploitation mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--bW7Nw90iaNQhVLQB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 08:53:17AM +0100, C=E9dric Le Goater wrote:
> On 12/10/18 7:39 AM, David Gibson wrote:
> > On Sun, Dec 09, 2018 at 08:46:00PM +0100, C=E9dric Le Goater wrote:
> >> The XIVE interface for the guest is described in the device tree under
> >> the "interrupt-controller" node. A couple of new properties are
> >> specific to XIVE :
> >>
> >>  - "reg"
> >>
> >>    contains the base address and size of the thread interrupt
> >>    managnement areas (TIMA), for the User level and for the Guest OS
> >>    level. Only the Guest OS level is taken into account today.
> >>
> >>  - "ibm,xive-eq-sizes"
> >>
> >>    the size of the event queues. One cell per size supported, contains
> >>    log2 of size, in ascending order.
> >>
> >>  - "ibm,xive-lisn-ranges"
> >>
> >>    the IRQ interrupt number ranges assigned to the guest for the IPIs.
> >>
> >> and also under the root node :
> >>
> >>  - "ibm,plat-res-int-priorities"
> >>
> >>    contains a list of priorities that the hypervisor has reserved for
> >>    its own use. OPAL uses the priority 7 queue to automatically
> >>    escalate interrupts for all other queues (DD2.X POWER9). So only
> >>    priorities [0..6] are allowed for the guest.
> >>
> >> Extend the sPAPR IRQ backend with a new handler to populate the DT
> >> with the appropriate "interrupt-controller" node.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/spapr_irq.h  |  2 ++
> >>  include/hw/ppc/spapr_xive.h |  2 ++
> >>  include/hw/ppc/xics.h       |  4 +--
> >>  hw/intc/spapr_xive.c        | 64 +++++++++++++++++++++++++++++++++++++
> >>  hw/intc/xics_spapr.c        |  3 +-
> >>  hw/ppc/spapr.c              |  3 +-
> >>  hw/ppc/spapr_irq.c          |  3 ++
> >>  7 files changed, 77 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> >> index 23cdb51b879e..e51e9f052f63 100644
> >> --- a/include/hw/ppc/spapr_irq.h
> >> +++ b/include/hw/ppc/spapr_irq.h
> >> @@ -39,6 +39,8 @@ typedef struct sPAPRIrq {
> >>      void (*free)(sPAPRMachineState *spapr, int irq, int num);
> >>      qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
> >>      void (*print_info)(sPAPRMachineState *spapr, Monitor *mon);
> >> +    void (*dt_populate)(sPAPRMachineState *spapr, uint32_t nr_servers,
> >> +                        void *fdt, uint32_t phandle);
> >>  } sPAPRIrq;
> >> =20
> >>  extern sPAPRIrq spapr_irq_xics;
> >> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> >> index 9506a8f4d10a..728a5e8dc163 100644
> >> --- a/include/hw/ppc/spapr_xive.h
> >> +++ b/include/hw/ppc/spapr_xive.h
> >> @@ -45,5 +45,7 @@ qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t l=
isn);
> >>  typedef struct sPAPRMachineState sPAPRMachineState;
> >> =20
> >>  void spapr_xive_hcall_init(sPAPRMachineState *spapr);
> >> +void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, voi=
d *fdt,
> >> +                   uint32_t phandle);
> >> =20
> >>  #endif /* PPC_SPAPR_XIVE_H */
> >> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> >> index 9958443d1984..14afda198cdb 100644
> >> --- a/include/hw/ppc/xics.h
> >> +++ b/include/hw/ppc/xics.h
> >> @@ -181,8 +181,6 @@ typedef struct XICSFabricClass {
> >>      ICPState *(*icp_get)(XICSFabric *xi, int server);
> >>  } XICSFabricClass;
> >> =20
> >> -void spapr_dt_xics(int nr_servers, void *fdt, uint32_t phandle);
> >> -
> >>  ICPState *xics_icp_get(XICSFabric *xi, int server);
> >> =20
> >>  /* Internal XICS interfaces */
> >> @@ -204,6 +202,8 @@ void icp_resend(ICPState *ss);
> >> =20
> >>  typedef struct sPAPRMachineState sPAPRMachineState;
> >> =20
> >> +void spapr_dt_xics(sPAPRMachineState *spapr, uint32_t nr_servers, voi=
d *fdt,
> >> +                   uint32_t phandle);
> >>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
> >>  void xics_spapr_init(sPAPRMachineState *spapr);
> >> =20
> >> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >> index 982ac6e17051..a6d854b07690 100644
> >> --- a/hw/intc/spapr_xive.c
> >> +++ b/hw/intc/spapr_xive.c
> >> @@ -14,6 +14,7 @@
> >>  #include "target/ppc/cpu.h"
> >>  #include "sysemu/cpus.h"
> >>  #include "monitor/monitor.h"
> >> +#include "hw/ppc/fdt.h"
> >>  #include "hw/ppc/spapr.h"
> >>  #include "hw/ppc/spapr_xive.h"
> >>  #include "hw/ppc/xive.h"
> >> @@ -1381,3 +1382,66 @@ void spapr_xive_hcall_init(sPAPRMachineState *s=
papr)
> >>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
> >>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
> >>  }
> >> +
> >> +void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, voi=
d *fdt,
> >> +                   uint32_t phandle)
> >> +{
> >> +    sPAPRXive *xive =3D spapr->xive;
> >> +    int node;
> >> +    uint64_t timas[2 * 2];
> >> +    /* Interrupt number ranges for the IPIs */
> >> +    uint32_t lisn_ranges[] =3D {
> >> +        cpu_to_be32(0),
> >> +        cpu_to_be32(nr_servers),
> >> +    };
> >> +    uint32_t eq_sizes[] =3D {
> >> +        cpu_to_be32(12), /* 4K */
> >> +        cpu_to_be32(16), /* 64K */
> >> +        cpu_to_be32(21), /* 2M */
> >> +        cpu_to_be32(24), /* 16M */
> >=20
> > For KVM, are we going to need to clamp this list based on the
> > pagesizes the guest can use?
>=20
> I would say so. Is there a KVM service for that ?

I'm not sure what you mean by a KVM service here.

> Today, the OS scans the list and picks the size fitting its current=20
> PAGE_SIZE/SHIFT. But I suppose it would be better to advertise=20
> only the page sizes that QEMU/KVM supports. Or should we play safe=20
> and only export : 4K, 64K ?=20

So, I'm guessing the limitation here is that when we use the KVM XIVE
acceleration, the EQ will need to be host-contiguous?  So, we can't
have EQs larger than the backing pagesize for guest memory.

We try to avoid having guest visible differences based on whether
we're using KVM or not, so we don't want to change this list depending
on whether KVM is active etc. - or on whether we're backing the guest
with hugepages.

We could reuse the cap-hpt-max-page-size machine parameter which also
relates to backing page size, but that might be confusing since it's
explicitly about HPT only whereas this limitation would apply to RPT
guests too, IIUC.

I think our best bet is probably to limit to 64kiB queues
unconditionally.  AIUI, that still gives us 8192 slots in the queue,
which is enough to store one of every possible irq, which should be
enough.

There's still an issue if we have a 4kiB pagesize host kernel, but we
could just disable kernel_irqchip in that situation, since we don't
expect people to be using that much in practice.

> >> +    };
> >> +    /* The following array is in sync with the reserved priorities
> >> +     * defined by the 'spapr_xive_priority_is_reserved' routine.
> >> +     */
> >> +    uint32_t plat_res_int_priorities[] =3D {
> >> +        cpu_to_be32(7),    /* start */
> >> +        cpu_to_be32(0xf8), /* count */
> >> +    };
> >> +    gchar *nodename;
> >> +
> >> +    /* Thread Interrupt Management Area : User (ring 3) and OS (ring =
2) */
> >> +    timas[0] =3D cpu_to_be64(xive->tm_base +
> >> +                           XIVE_TM_USER_PAGE * (1ull << TM_SHIFT));
> >> +    timas[1] =3D cpu_to_be64(1ull << TM_SHIFT);
> >> +    timas[2] =3D cpu_to_be64(xive->tm_base +
> >> +                           XIVE_TM_OS_PAGE * (1ull << TM_SHIFT));
> >> +    timas[3] =3D cpu_to_be64(1ull << TM_SHIFT);
> >=20
> > So this gives the MMIO address of the TIMA. =20
>=20
> Yes. It is considered to be a fixed "address"=20
>=20
> > Where does the guest get the MMIO address for the ESB pages from?
>=20
> with the hcall H_INT_GET_SOURCE_INFO.

Ah, right.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--bW7Nw90iaNQhVLQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPBx4ACgkQbDjKyiDZ
s5IPOw/7BiFaM7KuIbvM/hHkm31hRHlWZMmhX69SkLmEs0hibq4nfkiQolGod0n9
wYTtRbsuwDp+w7AjsMJbEWu/mj/xWwz8rCqxQ3Zy0SlhhrjXkwsCukQdFEWJ7cUv
5t79BkSHqHoU+zjV99yW+u1u74FU+SO28ZhSPXtbsocx35bApMJVn4drGSujJ2jb
qIml4bNoSy1eratiIlX54jWaOLpK3fIufe1lGye2S+A9qPbRdtfSzP3ivLWbIE2g
j3jbX4VCA0N0GR8uvJ83SThjLxa3M7+iPM6AivUNho427jMfUQgcQy9glSOF/p5z
LX0zZ/h9purOMmYFc1e3/shikNWYEItbAtcte7tKIoaYnSyQgbMmzwZJ7MTwL012
r7RLkebOWWQZWTOj/A1vxxgH4zkKpOkIR0xscFm6NJdizC7iNXpUN+nWvZdXCpOK
l3aEJG9An4ApXrT50FTeiHD+tbHzDfszk5Sz51i/cbJv3xAAxhdd0zmbfLBNF1tB
+Fx0br4HQQAORMkwWcz/QadMhxrM0TVR+sSMPpy41p2BIiZNHW21+1sbhEKdHt3u
k66Tfjw4Vmzul5s9FWX1S+IT9XUPI/u7Hv+dtjwwGU9Tv+AM81SB4TcY4bTi/vxH
Bm2+Hxi/8zq5MqGuLhkgm9XcWblKCa4iRlxrzOSvdknnfhMwwlg=
=d8yf
-----END PGP SIGNATURE-----

--bW7Nw90iaNQhVLQB--

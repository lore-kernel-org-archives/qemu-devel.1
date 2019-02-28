Received: from eggs.gnu.org ([209.51.188.92]:46529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnj-0003x3-Mj
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:56:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzCnU-0005FE-Bz
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 22:55:54 -0500
Date: Thu, 28 Feb 2019 14:49:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190228034950.GB27799@umbus.fritz.box>
References: <20190227085149.38596-1-aik@ozlabs.ru>
	<20190227085149.38596-5-aik@ozlabs.ru>
	<20190227153303.7b890f19@bahia.lan>
	<a31bddd9-dfaf-1a4c-e04b-5f863218c87a@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <a31bddd9-dfaf-1a4c-e04b-5f863218c87a@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH qemu v3 4/6] spapr_iommu: Do not
 replay mappings from just created DMA window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, qemu-ppc@nongnu.org, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 10:59:56AM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 28/02/2019 01:33, Greg Kurz wrote:
> > On Wed, 27 Feb 2019 19:51:47 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >=20
> >> On sPAPR vfio_listener_region_add() is called in 2 situations:
> >> 1. a new listener is registered from vfio_connect_container();
> >> 2. a new IOMMU Memory Region is added from rtas_ibm_create_pe_dma_wind=
ow().
> >>
> >> In both cases vfio_listener_region_add() calls
> >> memory_region_iommu_replay() to notify newly registered IOMMU notifiers
> >> about existing mappings which is totally desirable for case 1.
> >>
> >> However for case 2 it is nothing but noop as the window has just been
> >> created and has no valid mappings so replaying those does not do anyth=
ing.
> >> It is barely noticeable with usual guests but if the window happens to=
 be
> >> really big, such no-op replay might take minutes and trigger RCU stall
> >> warnings in the guest.
> >>
> >> For example, a upcoming GPU RAM memory region mapped at 64TiB (right
> >> after SPAPR_PCI_LIMIT) causes a 64bit DMA window to be at least 128TiB
> >> which is (128<<40)/0x10000=3D2.147.483.648 TCEs to replay.
> >>
> >> This mitigates the problem by adding an "skipping_replay" flag to
> >> sPAPRTCETable and defining sPAPR own IOMMU MR replay() hook which does
> >> exactly the same thing as the generic one except it returns early if
> >> @skipping_replay=3D=3Dtrue.
> >>
> >> When "ibm,create-pe-dma-window" is complete, the guest will map only
> >> required regions of the huge DMA window.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  include/hw/ppc/spapr.h  |  1 +
> >>  hw/ppc/spapr_iommu.c    | 31 +++++++++++++++++++++++++++++++
> >>  hw/ppc/spapr_rtas_ddw.c |  7 +++++++
> >>  3 files changed, 39 insertions(+)
> >>
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index 86b0488..358bb38 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -727,6 +727,7 @@ struct sPAPRTCETable {
> >>      uint64_t *mig_table;
> >>      bool bypass;
> >>      bool need_vfio;
> >> +    bool skipping_replay;
> >>      int fd;
> >>      MemoryRegion root;
> >>      IOMMUMemoryRegion iommu;
> >> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> >> index 37e98f9..8f23179 100644
> >> --- a/hw/ppc/spapr_iommu.c
> >> +++ b/hw/ppc/spapr_iommu.c
> >> @@ -141,6 +141,36 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IO=
MMUMemoryRegion *iommu,
> >>      return ret;
> >>  }
> >> =20
> >> +static void spapr_tce_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifi=
er *n)
> >> +{
> >> +    MemoryRegion *mr =3D MEMORY_REGION(iommu_mr);
> >> +    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_GET_CLASS(io=
mmu_mr);
> >> +    hwaddr addr, granularity;
> >> +    IOMMUTLBEntry iotlb;
> >> +    sPAPRTCETable *tcet =3D container_of(iommu_mr, sPAPRTCETable, iom=
mu);
> >> +
> >> +    if (tcet->skipping_replay) {
> >> +        return;
> >> +    }
> >> +
> >> +    granularity =3D memory_region_iommu_get_min_page_size(iommu_mr);
> >> +
> >> +    for (addr =3D 0; addr < memory_region_size(mr); addr +=3D granula=
rity) {
> >> +        iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE, n->iomm=
u_idx);
> >> +        if (iotlb.perm !=3D IOMMU_NONE) {
> >> +            n->notify(n, &iotlb);
> >> +        }
> >> +
> >> +        /*
> >> +         * if (2^64 - MR size) < granularity, it's possible to get an
> >> +         * infinite loop here.  This should catch such a wraparound.
> >> +         */
> >> +        if ((addr + granularity) < addr) {
> >> +            break;
> >> +        }
> >> +    }
> >> +}
> >=20
> > It is a bit unfortunate to duplicate all that code. What about making
> > a memory_region_iommu_replay_generic() helper out of it and call it
> > from spapr_tce_replay() and memory_region_iommu_replay() ?
>=20
>=20
> I really do not want to mess with generic code to solve our local sPAPR
> problem, especially when there is a way not to do so.

Well, the thing is, I think we're actually the only user of the
current generic replay - everything else has more efficient structure
aware replay hooks AFAIK.  Which makes this hack even hackier.

> And as a next step, I was thinking of removing (i.e. making this replay
> a no-op) from QEMU later and do replay in KVM instead when an IOMMU
> group is attaching to KVM as this is the only case when we need replay
> and KVM has a lot better idea what TCEs are actually valid and can skip
> most of them. This is a bit bigger thing as it requires a KVM capability
> "KVM replays mappings" but when we get it, spapr_tce_replay() will
> become no-op.

That's a good idea longer term.

> > Apart from that, LGTM.
>=20
> Well. It is a hack, I just do not have taste to tell how nasty it is
> :)

As an interim step until the kernel change, I think we can do a bit
better than this.  First, as Greg suggests we should have the
"generic" replay be a helper and have the spapr one call that with a
little in the way of extra checking.

Second, rather than having an explicit "skip_replay" flag, what we
really want here is to have the replay be a fast no-op if there are no
existing mappings rather than a slow no-op.  So instead I think we
should have a flag which records if any mappings have been made in the
region yet, initialized to false.  The new replay would do nothing if
it's still false.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3WlsACgkQbDjKyiDZ
s5J04w/+IvggU26tdfuu6zDFbV4VPKlzPeyf60xWtZT9nV6Kep+yt47jeSZutIMa
O+6r30JOBUl7wKubbPLtfQ+a0Jqz3zSeb8GCCQnXWJtxNSnpXdVIt6nD5esrcTKZ
RUcgdLhiavnKKmcxXjslZNEU7k8nmWbIbH9ovGziZny1fSliz97p92ORQRY2qxVv
+cpsMX2KIghpfhOYcADcTeCOYekuFpupynN1T4L2e2qHVDrJW1LzOm7UZdqFKmCz
pWmuc009cS8oPmv+ehqD6BpU6oEXriCd3Is0Jsh6IzMSMDqZ0niUXQXItTo3a0Bv
pQCABh6PeAVIwLmyJzOBS5lIjUklw9U7m66nkbgjbko0Rd/BvO4ZBjBeZ86CVZgw
oISfnZfEfOXTSQJyXHHpbx/PZBfGP+e7PZ8UicWg3ZZVpGJZMoHJQzHEobxPSp54
ONyTuItgTzq8c1XWZU2P0l3fTbNG5QqAqHIltKaPw9xrTVzWG0WrMenUbZmUCuej
5SGOfBvLKxos9oD3NpeYXmEEA9DxTBKm5sbPfZMzZ1FlatEhLbFmYNhD0wZgLMJB
mGSV2y4dU8yLXasP1VRL4oJ3Im+3Hv67x95+89pj5VbdDSNEEKfuHAs6f54tQVdG
rHbEN/DIaEUXORpAZdbeiNyjvuY3xQUzJKw1tSjL7SzsTUV+Mak=
=18Y1
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

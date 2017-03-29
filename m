Received: from eggs.gnu.org ([2001:4830:134:3::10]:39814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct4YE-0002M4-4s
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 23:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct4YD-0000mx-6x
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 23:45:38 -0400
Date: Wed, 29 Mar 2017 14:35:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329033542.GP21068@umbus.fritz.box>
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-2-aik@ozlabs.ru>
	<20170328114829.25656146@t450s.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4IFtMBbmeqbTM/ox"
Content-Disposition: inline
In-Reply-To: <20170328114829.25656146@t450s.home>
Subject: Re: [Qemu-devel] [RFC PATCH qemu 1/3] memory: Add get_fd() hook for
 IOMMU MR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--4IFtMBbmeqbTM/ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 11:48:29AM -0600, Alex Williamson wrote:
> On Tue, 28 Mar 2017 20:05:28 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  include/exec/memory.h | 2 ++
> >  hw/ppc/spapr_iommu.c  | 8 ++++++++
> >  2 files changed, 10 insertions(+)
> >=20
> > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > index e39256ad03..925c10b35b 100644
> > --- a/include/exec/memory.h
> > +++ b/include/exec/memory.h
> > @@ -174,6 +174,8 @@ struct MemoryRegionIOMMUOps {
> >      void (*notify_flag_changed)(MemoryRegion *iommu,
> >                                  IOMMUNotifierFlag old_flags,
> >                                  IOMMUNotifierFlag new_flags);
> > +    /* Returns a kernel fd for IOMMU */
> > +    int (*get_fd)(MemoryRegion *iommu);
>=20
> What if we used this as a prototype:
>=20
> int (*get_fd)(IOMMUFdType type, MemoryRegion *iommu);
>=20
> And then we defined:
>=20
> typedef enum {
>     SPAPR_IOMMU_TABLE_FD =3D 0,
> } IOMMUFdType;

Are we expecting any new types of fd?  Maybe it would be simpler just
to name this spapr_tce_fd() or something more specific, and only
generalize if we really need it for another fd type.

>=20
> Such that you're actually asking the IOMMUOps for a specific type of FD
> and it either has it or not, so the caller doesn't need to assume what
> it is they get back.
>=20
> Furthermore, add:
>=20
> int memory_region_iommu_get_fd(IOMMUFdType type, MemoryRegion *mr)
> {
>     assert(memory_region_is_iommu(mr));
>=20
>     if (mr->iommu_ops && mr->iommu_ops->get_fd) {
>         return mr->iommu_ops->get_fd(type, mr);
>     }
>=20
>     return -1;
> }
>=20
> >  };
> >
>=20
> This should be two patches, patch 1 above, patch 2 below
>  =20
> >  typedef struct CoalescedMemoryRange CoalescedMemoryRange;
> > diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> > index 9e30e148d6..b61c8f053e 100644
> > --- a/hw/ppc/spapr_iommu.c
> > +++ b/hw/ppc/spapr_iommu.c
> > @@ -170,6 +170,13 @@ static void spapr_tce_notify_flag_changed(MemoryRe=
gion *iommu,
> >      }
> >  }
> > =20
> > +static int spapr_tce_get_fd(MemoryRegion *iommu)
> > +{
> > +    sPAPRTCETable *tcet =3D container_of(iommu, sPAPRTCETable, iommu);
> > +
> > +    return tcet->fd;
>=20
>=20
> This would then be:
>=20
>     return type =3D=3D SPAPR_IOMMU_TABLE_FD ? tcet->fd : -1;
>=20
> > +}
> > +
> >  static int spapr_tce_table_post_load(void *opaque, int version_id)
> >  {
> >      sPAPRTCETable *tcet =3D SPAPR_TCE_TABLE(opaque);
> > @@ -251,6 +258,7 @@ static MemoryRegionIOMMUOps spapr_iommu_ops =3D {
> >      .translate =3D spapr_tce_translate_iommu,
> >      .get_min_page_size =3D spapr_tce_get_min_page_size,
> >      .notify_flag_changed =3D spapr_tce_notify_flag_changed,
> > +    .get_fd =3D spapr_tce_get_fd,
> >  };
> > =20
> >  static int spapr_tce_table_realize(DeviceState *dev)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4IFtMBbmeqbTM/ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2yuOAAoJEGw4ysog2bOSxXUQAMfg9f/Ffhbu27gO2o3WUM3t
JHfMCjoq5hsuC8aian3JXo+cnF0/bi24p468gqCmBi4oCfCfUag/q0Fc9N8QX86T
U/IW8BPMdMmS+OYavhwdxBVyeUwVJtUr01Jxut2yMKRRhIEzxvkH3awKsLd4q+Ay
TgrIJEGUarGmqSeGnE0uSQid7PHZeanpK5DBCPtCHhFGh/XAQ2DxjAp8pOYBb2a3
I/4IzvEPQ8VGKN7OWnmok195S1jhdMkTs2NL0Tlb1cRBQ2M5o0waZU4qGIU6t4kq
kJdZEjD2DdEsnMd9xutDeayMAgPOjCFhcqknTzNL+9RX6gtd6ZlOqtGZKim7+6ri
RsExWOPUWv4PnDgBP3l1xbOPGdFEe21/VqX8p2cMhG/rqYnt6H5oq71xJ3xGuHIJ
uq0qHqjPPw5CTRVEJr6XVRlNVz9ArQZaQ+6i0eZz71ly3mCWL0VI52PTVjLBqXwE
yFihQnx3Y1EI6UgCIplZsPPyBGWVCOH4ty4wdIFVf8F/A3lUOjWleuRzTuP34Fq0
F1c4FitQeC8Qbio360qnRfJUwGZq3AiyGMlsueXaPvERET/JdTsIhOELGZaYQJuC
1feb3batkCxyLpB+kMQad8BCb9IlgaaDQE0vd6ut7n7rpZN//8lAtscChVT7tOOT
JRHqWrkbAMJZYUty6bz3
=nlDk
-----END PGP SIGNATURE-----

--4IFtMBbmeqbTM/ox--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVGRE-0005n1-Qq
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVGRA-0006dD-WA
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:08:16 -0400
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:38463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVGRA-0006cW-Ms
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:08:12 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 5AA326C1A3
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:08:10 +0200 (CEST)
Date: Wed, 12 Jul 2017 14:07:57 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170712140757.092ad2f9@bahia.lan>
In-Reply-To: <20170712122217.607aa3f8@dhcp-192-215.str.redhat.com>
References: <20170711035620.4232-1-aik@ozlabs.ru>
	<20170711035620.4232-2-aik@ozlabs.ru>
	<20170712122217.607aa3f8@dhcp-192-215.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/FiF_A7H1ku+C6sRkQRV9.By";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH qemu v9 1/2] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Philippe =?UTF-8?B?TWF0aGlldS1E?= =?UTF-8?B?YXVkw6k=?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/FiF_A7H1ku+C6sRkQRV9.By
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2017 12:22:17 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 11 Jul 2017 13:56:19 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > This defines new QOM object - IOMMUMemoryRegion - with MemoryRegion
> > as a parent.
> >=20
> > This moves IOMMU-related fields from MR to IOMMU MR. However to avoid
> > dymanic QOM casting in fast path (address_space_translate, etc),
> > this adds an @is_iommu boolean flag to MR and provides new helper to
> > do simple cast to IOMMU MR - memory_region_get_iommu. The flag
> > is set in the instance init callback. This defines
> > memory_region_is_iommu as memory_region_get_iommu()!=3DNULL.
> >=20
> > This switches MemoryRegion to IOMMUMemoryRegion in most places except
> > the ones where MemoryRegion may be an alias.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > Changes:
> > v9:
> > * added rb:David
> >=20
> > v8:
> > * moved is_iommu flag closer to the beginning of the MemoryRegion struct
> > * removed memory_region_init_iommu_type()
> >=20
> > v7:
> > * rebased on top of the current upstream
> >=20
> > v6:
> > * s/\<iommumr\>/iommu_mr/g
> >=20
> > v5:
> > * fixed sparc64, first time in many years did run "./configure" without
> > --target-list :-D Sorry for the noise though :(
> >=20
> > v4:
> > * fixed alpha, mips64el and sparc
> >=20
> > v3:
> > * rebased on sha1 81b2d5ceb0
> >=20
> > v2:
> > * added mr->is_iommu
> > * updated i386/x86_64/s390/sun
> > ---
> >  hw/s390x/s390-pci-bus.h       |   2 +-
> >  include/exec/memory.h         |  55 ++++++++++++++--------
> >  include/hw/i386/intel_iommu.h |   2 +-
> >  include/hw/mips/mips.h        |   2 +-
> >  include/hw/ppc/spapr.h        |   3 +-
> >  include/hw/vfio/vfio-common.h |   2 +-
> >  include/qemu/typedefs.h       |   1 +
> >  exec.c                        |  12 ++---
> >  hw/alpha/typhoon.c            |   8 ++--
> >  hw/dma/rc4030.c               |   8 ++--
> >  hw/i386/amd_iommu.c           |   9 ++--
> >  hw/i386/intel_iommu.c         |  17 +++----
> >  hw/mips/mips_jazz.c           |   2 +-
> >  hw/pci-host/apb.c             |   6 +--
> >  hw/ppc/spapr_iommu.c          |  16 ++++---
> >  hw/s390x/s390-pci-bus.c       |   6 +--
> >  hw/s390x/s390-pci-inst.c      |   8 ++--
> >  hw/vfio/common.c              |  12 +++--
> >  hw/vfio/spapr.c               |   3 +-
> >  memory.c                      | 105 ++++++++++++++++++++++++++++------=
--------
> >  20 files changed, 170 insertions(+), 109 deletions(-)
> >  =20
>=20
> > @@ -1491,17 +1506,22 @@ void memory_region_init_rom_device(MemoryRegion=
 *mr,
> >      mr->ram_block =3D qemu_ram_alloc(size, mr, errp);
> >  }
> > =20
> > -void memory_region_init_iommu(MemoryRegion *mr,
> > +void memory_region_init_iommu(IOMMUMemoryRegion *iommu_mr,
> >                                Object *owner,
> >                                const MemoryRegionIOMMUOps *ops,
> >                                const char *name,
> >                                uint64_t size)
> >  {
> > -    memory_region_init(mr, owner, name, size);
> > -    mr->iommu_ops =3D ops,
> > +    struct MemoryRegion *mr;
> > +
> > +    object_initialize(iommu_mr, sizeof(*iommu_mr), TYPE_IOMMU_MEMORY_R=
EGION);
> > +    mr =3D MEMORY_REGION(iommu_mr);
> > +    memory_region_do_init(mr, owner, name, size);
> > +    iommu_mr =3D IOMMU_MEMORY_REGION(mr);
> > +    iommu_mr->iommu_ops =3D ops, =20
>=20
> I'd finish with a semicolon instead.
>=20

Heh, this nit has been there since:

commit 30951157441aed950ad8ca326500b4986d431c7a
Author: Avi Kivity <avi.kivity@gmail.com>
Date:   Tue Oct 30 13:47:46 2012 +0200

    memory: iommu support

> Should this require ops !=3D NULL? There are a number of places where
> ->iommu_ops is dereferenced unconditionally. =20
>=20
> >      mr->terminates =3D true;  /* then re-forwards */
> > -    QLIST_INIT(&mr->iommu_notify);
> > -    mr->iommu_notify_flags =3D IOMMU_NOTIFIER_NONE;
> > +    QLIST_INIT(&iommu_mr->iommu_notify);
> > +    iommu_mr->iommu_notify_flags =3D IOMMU_NOTIFIER_NONE;
> >  }
> > =20
> >  static void memory_region_finalize(Object *obj) =20
>=20
> (...)
>=20
> > -uint64_t memory_region_iommu_get_min_page_size(MemoryRegion *mr)
> > +uint64_t memory_region_iommu_get_min_page_size(IOMMUMemoryRegion *iomm=
u_mr)
> >  {
> > -    assert(memory_region_is_iommu(mr));
> > -    if (mr->iommu_ops && mr->iommu_ops->get_min_page_size) {
> > -        return mr->iommu_ops->get_min_page_size(mr);
> > +    if (iommu_mr->iommu_ops && iommu_mr->iommu_ops->get_min_page_size)=
 { =20
>=20
> I think this is the only place that actually checks for iommu_ops.
>=20
> > +        return iommu_mr->iommu_ops->get_min_page_size(iommu_mr);
> >      }
> >      return TARGET_PAGE_SIZE;
> >  } =20
>=20
> The s390 conversions look fine.
>=20


--Sig_/FiF_A7H1ku+C6sRkQRV9.By
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllmER0ACgkQAvw66wEB28K69QCfcJGQdLYZA1pH6bUX2ObFPa3l
Cg4An1lKdZfykfdlEZsZR9P7RZ+8CmoJ
=KZab
-----END PGP SIGNATURE-----

--Sig_/FiF_A7H1ku+C6sRkQRV9.By--

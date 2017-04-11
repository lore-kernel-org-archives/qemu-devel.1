Received: from eggs.gnu.org ([2001:4830:134:3::10]:58455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxlIG-0003l2-5m
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:12:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cxlIE-00056A-2h
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:12:32 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41677)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cxlID-00053e-3G
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:12:30 -0400
Date: Tue, 11 Apr 2017 11:56:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170411015654.GU27571@umbus>
References: <1491562755-23867-1-git-send-email-peterx@redhat.com>
	<1491562755-23867-2-git-send-email-peterx@redhat.com>
	<20170410043922.GI27571@umbus>
	<20170410070950.GK3981@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FoibaoN3dya3u5fy"
Content-Disposition: inline
In-Reply-To: <20170410070950.GK3981@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v9 1/9] memory: add section range info for
 IOMMU notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, alex.williamson@redhat.com, bd.aviv@gmail.com


--FoibaoN3dya3u5fy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 03:09:50PM +0800, Peter Xu wrote:
> On Mon, Apr 10, 2017 at 02:39:22PM +1000, David Gibson wrote:
> > On Fri, Apr 07, 2017 at 06:59:07PM +0800, Peter Xu wrote:
> > > In this patch, IOMMUNotifier.{start|end} are introduced to store sect=
ion
> > > information for a specific notifier. When notification occurs, we not
> > > only check the notification type (MAP|UNMAP), but also check whether =
the
> > > notified iova range overlaps with the range of specific IOMMU notifie=
r,
> > > and skip those notifiers if not in the listened range.
> > >=20
> > > When removing an region, we need to make sure we removed the correct
> > > VFIOGuestIOMMU by checking the IOMMUNotifier.start address as well.
> > >=20
> > > This patch is solving the problem that vfio-pci devices receive
> > > duplicated UNMAP notification on x86 platform when vIOMMU is there. T=
he
> > > issue is that x86 IOMMU has a (0, 2^64-1) IOMMU region, which is
> > > splitted by the (0xfee00000, 0xfeefffff) IRQ region. AFAIK
> > > this (splitted IOMMU region) is only happening on x86.
> > >=20
> > > This patch also helps vhost to leverage the new interface as well, so
> > > that vhost won't get duplicated cache flushes. In that sense, it's an
> > > slight performance improvement.
> > >=20
> > > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  hw/vfio/common.c      | 12 +++++++++---
> > >  hw/virtio/vhost.c     | 10 ++++++++--
> > >  include/exec/memory.h | 19 ++++++++++++++++++-
> > >  memory.c              |  9 +++++++++
> > >  4 files changed, 44 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > index f3ba9b9..6b33b9f 100644
> > > --- a/hw/vfio/common.c
> > > +++ b/hw/vfio/common.c
> > > @@ -478,8 +478,13 @@ static void vfio_listener_region_add(MemoryListe=
ner *listener,
> > >          giommu->iommu_offset =3D section->offset_within_address_spac=
e -
> > >                                 section->offset_within_region;
> > >          giommu->container =3D container;
> > > -        giommu->n.notify =3D vfio_iommu_map_notify;
> > > -        giommu->n.notifier_flags =3D IOMMU_NOTIFIER_ALL;
> > > +        llend =3D int128_add(int128_make64(section->offset_within_re=
gion),
> > > +                           section->size);
> > > +        llend =3D int128_sub(llend, int128_one());
> > > +        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
> > > +                            IOMMU_NOTIFIER_ALL,
> > > +                            section->offset_within_region,
> > > +                            int128_get64(llend));
> >=20
> > Seems to me it would make sense to put the fiddling around to convert
> > the MemoryRegionSection into the necessary values would make sense to
> > go inside iommu_notifier_init().
>=20
> But will we always get one MemoryRegionSection if we are not in any of
> the region_{add|del} callback? E.g., what if we want to init an IOMMU
> notifier that covers just the whole IOMMU region range?

I suppose so.  It's just the only likely users of the interface I can
see will be always doing this from region_{add,del}.

> Considering above, I would still slightly prefer current interface.

Ok, well my opinion on the matter isn't terribly strong.

>=20
> >=20
> > >          QLIST_INSERT_HEAD(&container->giommu_list, giommu, giommu_ne=
xt);
> > > =20
> > >          memory_region_register_iommu_notifier(giommu->iommu, &giommu=
->n);
> > > @@ -550,7 +555,8 @@ static void vfio_listener_region_del(MemoryListen=
er *listener,
> > >          VFIOGuestIOMMU *giommu;
> > > =20
> > >          QLIST_FOREACH(giommu, &container->giommu_list, giommu_next) {
> > > -            if (giommu->iommu =3D=3D section->mr) {
> > > +            if (giommu->iommu =3D=3D section->mr &&
> > > +                giommu->n.start =3D=3D section->offset_within_region=
) {
> >=20
> > This test should be sufficient, but I'd be a bit more comfortable if
> > there was a test and assert() that the end matches as well.  I also
> > wonder if remove-matching-notifier helper would be useful here.
> > Although vhost doesn't appear to ever remove, so maybe it's premature.
>=20
> Oh... vhost does remove it, but I just forgot to touch it up :( ...
> Thanks for pointing out.
>=20
> Marcel, if this is the only comment, would you mind squash below
> change into current patch? Thanks,
>=20
> ----8<----
>=20
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 185b95b..0001e60 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -771,7 +771,8 @@ static void vhost_iommu_region_del(MemoryListener *li=
stener,
>      }
> =20
>      QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
> -        if (iommu->mr =3D=3D section->mr) {
> +        if (iommu->mr =3D=3D section->mr &&
> +            iommu->n.start =3D=3D section->offset_within_region) {
>              memory_region_unregister_iommu_notifier(iommu->mr,
>                                                      &iommu->n);
>              QLIST_REMOVE(iommu, iommu_next);
>=20
> ---->8----
>=20
> >=20
> > >                  memory_region_unregister_iommu_notifier(giommu->iomm=
u,
> > >                                                          &giommu->n);
> > >                  QLIST_REMOVE(giommu, giommu_next);
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 613494d..185b95b 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -736,14 +736,20 @@ static void vhost_iommu_region_add(MemoryListen=
er *listener,
> > >      struct vhost_dev *dev =3D container_of(listener, struct vhost_de=
v,
> > >                                           iommu_listener);
> > >      struct vhost_iommu *iommu;
> > > +    Int128 end;
> > > =20
> > >      if (!memory_region_is_iommu(section->mr)) {
> > >          return;
> > >      }
> > > =20
> > >      iommu =3D g_malloc0(sizeof(*iommu));
> > > -    iommu->n.notify =3D vhost_iommu_unmap_notify;
> > > -    iommu->n.notifier_flags =3D IOMMU_NOTIFIER_UNMAP;
> > > +    end =3D int128_add(int128_make64(section->offset_within_region),
> > > +                     section->size);
> > > +    end =3D int128_sub(end, int128_one());
> > > +    iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> > > +                        IOMMU_NOTIFIER_UNMAP,
> > > +                        section->offset_within_region,
> > > +                        int128_get64(end));
> > >      iommu->mr =3D section->mr;
> > >      iommu->iommu_offset =3D section->offset_within_address_space -
> > >                            section->offset_within_region;
> > > diff --git a/include/exec/memory.h b/include/exec/memory.h
> > > index f20b191..0840c89 100644
> > > --- a/include/exec/memory.h
> > > +++ b/include/exec/memory.h
> > > @@ -77,13 +77,30 @@ typedef enum {
> > > =20
> > >  #define IOMMU_NOTIFIER_ALL (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMA=
P)
> > > =20
> > > +struct IOMMUNotifier;
> > > +typedef void (*IOMMUNotify)(struct IOMMUNotifier *notifier,
> > > +                            IOMMUTLBEntry *data);
> > > +
> > >  struct IOMMUNotifier {
> > > -    void (*notify)(struct IOMMUNotifier *notifier, IOMMUTLBEntry *da=
ta);
> > > +    IOMMUNotify notify;
> > >      IOMMUNotifierFlag notifier_flags;
> > > +    /* Notify for address space range start <=3D addr <=3D end */
> > > +    hwaddr start;
> > > +    hwaddr end;
> > >      QLIST_ENTRY(IOMMUNotifier) node;
> > >  };
> > >  typedef struct IOMMUNotifier IOMMUNotifier;
> > > =20
> > > +static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify=
 fn,
> > > +                                       IOMMUNotifierFlag flags,
> > > +                                       hwaddr start, hwaddr end)
> > > +{
> > > +    n->notify =3D fn;
> > > +    n->notifier_flags =3D flags;
> > > +    n->start =3D start;
> > > +    n->end =3D end;
> > > +}
> > > +
> > >  /* New-style MMIO accessors can indicate that the transaction failed.
> > >   * A zero (MEMTX_OK) response means success; anything else is a fail=
ure
> > >   * of some kind. The memory subsystem will bitwise-OR together resul=
ts
> > > diff --git a/memory.c b/memory.c
> > > index 4c95aaf..75ac595 100644
> > > --- a/memory.c
> > > +++ b/memory.c
> > > @@ -1606,6 +1606,7 @@ void memory_region_register_iommu_notifier(Memo=
ryRegion *mr,
> > > =20
> > >      /* We need to register for at least one bitfield */
> > >      assert(n->notifier_flags !=3D IOMMU_NOTIFIER_NONE);
> > > +    assert(n->start <=3D n->end);
> > >      QLIST_INSERT_HEAD(&mr->iommu_notify, n, node);
> > >      memory_region_update_iommu_notify_flags(mr);
> > >  }
> > > @@ -1667,6 +1668,14 @@ void memory_region_notify_iommu(MemoryRegion *=
mr,
> > >      }
> > > =20
> > >      QLIST_FOREACH(iommu_notifier, &mr->iommu_notify, node) {
> > > +        /*
> > > +         * Skip the notification if the notification does not overlap
> > > +         * with registered range.
> > > +         */
> > > +        if (iommu_notifier->start > entry.iova + entry.addr_mask + 1=
 ||
> > > +            iommu_notifier->end < entry.iova) {
> > > +            continue;
> > > +        }
> > >          if (iommu_notifier->notifier_flags & request_flags) {
> > >              iommu_notifier->notify(iommu_notifier, &entry);
> > >          }
> >=20
>=20
> -- peterx
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FoibaoN3dya3u5fy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY7DfhAAoJEGw4ysog2bOSuAYP/j8sVE+GIznwTsrGithHfDTn
CyuVNUsSLpEvKlHbLmWn6KNJQC6q+lVRg6l17k4zcNe/oa6mB9yj6H7P4uIonVNA
2WIH/flr+Z3Vp7EBjQiNzwTnC4qw7C1VSv+9YKMfW4qzy/95yS6vmsi1aicog/ZE
MT0e6AwlYMdcnokYivGUN4FrXuD77u9XLjcnxky2alZ01m/fQSexiDS4DiVX/Ywq
qQ5um9yjJDsaeqrISFNmuJIr4jYjsOz4cZHLIOSSVIq22otm21YdNmfHAACgMWlX
MtRR7sNdGXD1dEgO0CHENY82kPHsfQQhjKul71X89vYtvF83IB32T52RT4xIxS5r
GiQsh9aNCqvrUFwl0WoGrDlQkMy5kjBk7N7n+aUc6KhqnsKKLrSHlclnt6+dtPeX
V+OmqId5rpf2aqFKADNXjskWAlZGCvPxtXRHUzmcNkej/oWTzl9Fbg6tWlAi5Ue1
VsdoibHp3wQSYkyjKn0DypilCTsakQY0+na00wV6NGncnKQz8my5CZecHsFPlDp+
PUC/NQRlkU0zLATr60PG6WcBgdeY9r9wME4+eqVdPmJAJlV2pIR1bbEIltEAEJbV
IkBmfCaJMeuP7MEXdPt/mYEIcR7k1nAuLtMcIUrUGhyzZK9XRwXHTCRxZHco3i+B
viUPUtv/GnGFivfyrKX4
=kVD5
-----END PGP SIGNATURE-----

--FoibaoN3dya3u5fy--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0TlN-0001n2-EU
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d0TlI-0002vb-2K
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:05:49 -0400
Received: from ozlabs.org ([103.22.144.67]:51195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d0TlH-0002uQ-7F
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:05:43 -0400
Date: Tue, 18 Apr 2017 21:55:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170418115511.GA12450@umbus.fritz.box>
References: <1491562755-23867-1-git-send-email-peterx@redhat.com>
	<1491562755-23867-2-git-send-email-peterx@redhat.com>
	<20170410043922.GI27571@umbus>
	<20170410070950.GK3981@pxdev.xzpeter.org>
	<20170411015654.GU27571@umbus>
	<20170418095637.GE22226@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20170418095637.GE22226@pxdev.xzpeter.org>
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


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2017 at 05:56:37PM +0800, Peter Xu wrote:
> On Tue, Apr 11, 2017 at 11:56:54AM +1000, David Gibson wrote:
> > On Mon, Apr 10, 2017 at 03:09:50PM +0800, Peter Xu wrote:
> > > On Mon, Apr 10, 2017 at 02:39:22PM +1000, David Gibson wrote:
> > > > On Fri, Apr 07, 2017 at 06:59:07PM +0800, Peter Xu wrote:
> > > > > In this patch, IOMMUNotifier.{start|end} are introduced to store =
section
> > > > > information for a specific notifier. When notification occurs, we=
 not
> > > > > only check the notification type (MAP|UNMAP), but also check whet=
her the
> > > > > notified iova range overlaps with the range of specific IOMMU not=
ifier,
> > > > > and skip those notifiers if not in the listened range.
> > > > >=20
> > > > > When removing an region, we need to make sure we removed the corr=
ect
> > > > > VFIOGuestIOMMU by checking the IOMMUNotifier.start address as wel=
l.
> > > > >=20
> > > > > This patch is solving the problem that vfio-pci devices receive
> > > > > duplicated UNMAP notification on x86 platform when vIOMMU is ther=
e. The
> > > > > issue is that x86 IOMMU has a (0, 2^64-1) IOMMU region, which is
> > > > > splitted by the (0xfee00000, 0xfeefffff) IRQ region. AFAIK
> > > > > this (splitted IOMMU region) is only happening on x86.
> > > > >=20
> > > > > This patch also helps vhost to leverage the new interface as well=
, so
> > > > > that vhost won't get duplicated cache flushes. In that sense, it'=
s an
> > > > > slight performance improvement.
> > > > >=20
> > > > > Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> > > > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > > > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >  hw/vfio/common.c      | 12 +++++++++---
> > > > >  hw/virtio/vhost.c     | 10 ++++++++--
> > > > >  include/exec/memory.h | 19 ++++++++++++++++++-
> > > > >  memory.c              |  9 +++++++++
> > > > >  4 files changed, 44 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > > > > index f3ba9b9..6b33b9f 100644
> > > > > --- a/hw/vfio/common.c
> > > > > +++ b/hw/vfio/common.c
> > > > > @@ -478,8 +478,13 @@ static void vfio_listener_region_add(MemoryL=
istener *listener,
> > > > >          giommu->iommu_offset =3D section->offset_within_address_=
space -
> > > > >                                 section->offset_within_region;
> > > > >          giommu->container =3D container;
> > > > > -        giommu->n.notify =3D vfio_iommu_map_notify;
> > > > > -        giommu->n.notifier_flags =3D IOMMU_NOTIFIER_ALL;
> > > > > +        llend =3D int128_add(int128_make64(section->offset_withi=
n_region),
> > > > > +                           section->size);
> > > > > +        llend =3D int128_sub(llend, int128_one());
> > > > > +        iommu_notifier_init(&giommu->n, vfio_iommu_map_notify,
> > > > > +                            IOMMU_NOTIFIER_ALL,
> > > > > +                            section->offset_within_region,
> > > > > +                            int128_get64(llend));
> > > >=20
> > > > Seems to me it would make sense to put the fiddling around to conve=
rt
> > > > the MemoryRegionSection into the necessary values would make sense =
to
> > > > go inside iommu_notifier_init().
> > >=20
> > > But will we always get one MemoryRegionSection if we are not in any of
> > > the region_{add|del} callback? E.g., what if we want to init an IOMMU
> > > notifier that covers just the whole IOMMU region range?
> >=20
> > I suppose so.  It's just the only likely users of the interface I can
> > see will be always doing this from region_{add,del}.
> >=20
> > > Considering above, I would still slightly prefer current interface.
> >=20
> > Ok, well my opinion on the matter isn't terribly strong.
>=20
> Hi, David,
>=20
> Sorry to respond late (so that context might be lost). Just want to
> make sure that you are okay with current patch and interface, right?
>=20
> I think Marcel is going to merge it if np, and I would like to have
> your confirmation on this before the merge. Thanks!

Yes, that's fine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY9f6cAAoJEGw4ysog2bOSA5IQAJbChmGcFZi/lHxnjvaseGYo
8BBIoAcyta8DY+r2OqKlHYuWqO6ceca1nvSjiquoP7VXj4Z8ZSFMa7+RyhexuQ21
rdFSdM/S7gJFysnGndFVCk8o0Tt3zwpeDtpcLi7LiMlDhzwvnY27JkTDMpsFHD2I
zTJGzu8M0NJ4nkFNROtRjGPSLxTNSymNIASvWhnUGX9io2yAWW+RpiPYQRGdaUcY
K+FX4yRHd0s+BhneWIf/37AN8kFfjC8rhrFV/Lx5GV6YdKoEzCBF8Zm7ontzkQnq
WXU2rYREI8Njo+ee8m4szEMptHOoxDIJ3q8a4japlkbO2S1CAQVdK+dJzuaAdVs3
blWDJOgm0cJe/KBGhhIFhCmjFlTevwZLnWFxWUw14wTOon1Levp7Xb+2Tud0qTT1
PazPWIKLF/VsZEbGGv9X5QqC3nTUiiH5r8dgF/qoCdP83adKyCqJEz5mTRFnwLBt
8w6GGIx36wHhkPSwfSNNF5SRyUFmYtN60MFDlX6lhmHzexSACRVKLgRaeoWY8sm2
3XdfhkqGvAl6D2JvBKE2T8sEaqtQfrD1VKGb71sHgjuoXHAFOi2hgzL38IHmmVsM
BOi4k1gNheila8dSIFn2adPKnuToORyeVTjNjmJ6x7E/t2pZaoq5KK26x7sulDr7
K0AGQS15fW7Se9hZYGQb
=i5bO
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--

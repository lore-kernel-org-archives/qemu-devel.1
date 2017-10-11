Received: from eggs.gnu.org ([2001:4830:134:3::10]:36107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1e2KIO-0001Ds-8D
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1e2KIL-00040d-2Z
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:55:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1e2KIK-0003zt-PW
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 12:55:44 -0400
Date: Wed, 11 Oct 2017 10:55:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20171011105539.7a5346ae@t450s.home>
In-Reply-To: <1507718840.31518.9.camel@redhat.com>
References: <20171010140334.8231-1-kraxel@redhat.com>
	<20171010140334.8231-6-kraxel@redhat.com>
	<20171010142703.19e50e0d@t450s.home>
	<1507718840.31518.9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RfC PATCH 5/6] vfio/display: adding region support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>

On Wed, 11 Oct 2017 12:47:20 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

>   Hi,
>=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE=
_QUERY_GFX_PLANE,
> > > &plane);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fprintf(stderr, "ioc=
tl VFIO_DEVICE_QUERY_GFX_PLANE: %s\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strerror(errno)); =20
> >=20
> > %m? =20
>=20
> Oh, neat, didn't know this even exists.
>=20
> man page says it is a glibc extension though.  So do we really want use
> it in a portable code base?  In this specific case it would probably
> not cause any trouble though as vfio is linux-only anyway.

Right, vfio is linux only, so I haven't really hesitated to use it.

> > > +=C2=A0=C2=A0=C2=A0=C2=A0if (vdev->region_mmap =3D=3D NULL) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* mmap region */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D vfio_get_reg=
ion_info(&vdev->vbasedev,
> > > plane.region_index,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&regio=
n);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret !=3D 0) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fprintf(stderr, "%s: vfio_get_region_info(%d): %s\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__func__, plane.regio=
n_index, strerror(-ret));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vdev->region_size =
=3D region->size;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vdev->region_mmap =
=3D mmap(NULL, region->size,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PROT_READ, MAP_SHA=
RED,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vdev->vbasedev.fd,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0region->offset);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (vdev->region_mma=
p =3D=3D MAP_FAILED) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0fprintf(stderr, "%s: mmap region %d: %s\n", __func__,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0plane.region_index, s=
trerror(errno));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0vdev->region_mmap =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0g_free(region);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0return;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} =20
> >=20
> > Seems like we should really try to use a VFIORegion for this. =20
>=20
> IIRC I checked this, but it didn't look straight forward as VFIORegion
> is designed for guest access not host access.

The overhead of a VFIORegion seems to be that we setup a MemoryRegion
for r/w access to the vfio region and overlap that with one or more
MemoryRegions for the mmap(s).  That's a bit of structural overhead,
but we'd simply never map those into a guest visible address space.
OTOH, it saves you from dealing with the region info, and potentially
sparse mmap (you could call vfio_region_setup() and check nr_mmaps =3D 1,
mmaps[0].offset/size, then call vfio_region_mmap() if it checks out,
otherwise error).  Just seems like duplicate code here even if the
VFIORegion includes some things we don't need.  Thanks,

Alex

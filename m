Received: from eggs.gnu.org ([2001:4830:134:3::10]:39825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct4YF-0002M9-Kv
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 23:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct4YC-0000mj-Ii
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 23:45:39 -0400
Date: Wed, 29 Mar 2017 14:42:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329034202.GQ21068@umbus.fritz.box>
References: <20170328090530.20052-1-aik@ozlabs.ru>
	<20170328090530.20052-3-aik@ozlabs.ru>
	<20170328114836.63dcde23@t450s.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zywvytGCXzdVpkje"
Content-Disposition: inline
In-Reply-To: <20170328114836.63dcde23@t450s.home>
Subject: Re: [Qemu-devel] [RFC PATCH qemu 2/3] vfio-pci: Reorder
 group-to-container attaching
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


--zywvytGCXzdVpkje
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 11:48:36AM -0600, Alex Williamson wrote:
> On Tue, 28 Mar 2017 20:05:29 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > At the moment VFIO PCI device initialization works as follows:
> > vfio_realize
> > 	vfio_get_group
> > 		vfio_connect_container
> > 			register memory listeners (1)
> > 			update QEMU groups lists
> > 		vfio_kvm_device_add_group
> >=20
> > Then (example for pseries) the machine reset hook triggers region_add()
> > for all regions where listeners from (1) are listening:
> >=20
> > ppc_spapr_reset
> > 	spapr_phb_reset
> > 		spapr_tce_table_enable
> > 			memory_region_add_subregion
> > 				vfio_listener_region_add
> > 					vfio_spapr_create_window
> >=20
> > This scheme works fine until we need to handle VFIO PCI device hotplug
> > _and_ we want to enable in-kernel acceleration on, i.e. after PCI hotpl=
ug
> > we need a place to call
> > ioctl(vfio_kvm_device_fd, KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE).
> > Since the ioctl needs a LIOBN fd (from sPAPRTCETable) and a IOMMU group=
 fd
> > (from VFIOGroup), vfio_listener_region_add() seems to be the only place
> > for this ioctl().
> >=20
> > However this only works during boot time because the machine reset
> > happens strictly after all devices are finalized. When hotplug happens,
> > vfio_listener_region_add() is called when a memory listener is register=
ed
> > but when this happens:
> > 1. new group is not added to the container->group_list yet;
> > 2. VFIO KVM device is unaware of the new IOMMU group.
> >=20
> > This moves bits around to have all necessary VFIO infrastructure
> > in place for both initial startup and hotplug cases.
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> >  hw/vfio/common.c | 21 +++++++++++----------
> >  1 file changed, 11 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> > index f3ba9b9007..c75c7594d5 100644
> > --- a/hw/vfio/common.c
> > +++ b/hw/vfio/common.c
> > @@ -1086,6 +1086,16 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
> >          goto free_container_exit;
> >      }
> > =20
> > +    container->initialized =3D true;
>=20
> This ignores the purpose of this variable, which is to make runtime
> mapping faults fatal, but device realize time faults simply cause the
> device to be rejected.  This cannot be moved above
> memory_listener_register().

Apart from that, the rest of the code motion looks ok, though.  Even
if it weren't for the hotplug case, have the container/group
more-or-less initialized before registering the listener makes more
logical sense to me.

>=20
> > +
> > +    vfio_kvm_device_add_group(group);
> > +
> > +    QLIST_INIT(&container->group_list);
> > +    QLIST_INSERT_HEAD(&space->containers, container, next);
> > +
> > +    group->container =3D container;
> > +    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> > +
> >      container->listener =3D vfio_memory_listener;
> > =20
> >      memory_listener_register(&container->listener, container->space->a=
s);
> > @@ -1097,16 +1107,9 @@ static int vfio_connect_container(VFIOGroup *gro=
up, AddressSpace *as,
> >          goto listener_release_exit;
> >      }
> > =20
> > -    container->initialized =3D true;
> > -
> > -    QLIST_INIT(&container->group_list);
> > -    QLIST_INSERT_HEAD(&space->containers, container, next);
> > -
> > -    group->container =3D container;
> > -    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> > -
> >      return 0;
> >  listener_release_exit:
> > +    vfio_kvm_device_del_group(group);
>=20
>=20
> Where's the QLIST cleanup?

Moving it does introduce more intermediate cleanup cases which need to
be handled, though..

>=20
>=20
> >      vfio_listener_release(container);
> > =20
> >  free_container_exit:
> > @@ -1210,8 +1213,6 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpa=
ce *as, Error **errp)
> > =20
> >      QLIST_INSERT_HEAD(&vfio_group_list, group, next);
> > =20
> > -    vfio_kvm_device_add_group(group);
> > -
> >      return group;
> > =20
> >  close_fd_exit:
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zywvytGCXzdVpkje
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2y0KAAoJEGw4ysog2bOSMAUP/i3S77Z+Z7/6s3nNA6Sodd0J
83rYKZyd7HVc80zCR0J1Y39NTRwk2u20nNYG8/VjIKiJMv2bA+GYJ9CGEp3SYx6N
20WZGrQRdvF4CGBBzEnpwXf5nk1ObjbsX8nDfBvl2vJeUAIku7krgopyNuWxTT2t
duBhQzQ3gn8jCeUDgGdQJZeTNPFDECTwGQU7pk21rAqSHLINW2ub8GGv2bkJnLlY
uYjWwK268qVwrjqshbgKGlLLDsXCsGXqDqI5IleOXgve6MN8F/6QcdRnjLEGrMmU
tY9trVQp/lpIrsSi71u1Hv8wYNhPz/Z6xC2cph0mUJ1YxN2uhAJcFe2qyJYACu4l
KO6vxtqqfRDW2VWegNfF5sCX0Og48oOC2GyNpRlGrckj1wY05FxS4FMW5kPmq+zv
Q/JxCS0KuoB9Ea2uAw58QX16VfUYpHNdyKCQraInWzYzCbSHaBjPWPYlbX1Zf2cV
i5Ex+hL2flzIDLw9YkUTIaKcQRkxhtiuIEajBWz4/stUr93v8OwOWS+NmkQLscl6
jYtDd0hbV6VPrtIcWG3jEGHyspaVDb7xVxJLGOTxPSTngrBnAZNzWNqBxhkSx/sL
ceBI9/YT/PktU9pntKEnWXWu9cqerQ2Rq6T6fCn7Nd2X0cpersOMDSHaZz6osNm1
1mgZsN4940USNyfzrvd8
=Ncl+
-----END PGP SIGNATURE-----

--zywvytGCXzdVpkje--

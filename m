Received: from eggs.gnu.org ([2001:4830:134:3::10]:52547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1curxV-0004dI-2R
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 22:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1curxR-0005ji-Sm
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 22:43:09 -0400
Date: Mon, 3 Apr 2017 12:27:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170403022758.GA10997@umbus.fritz.box>
References: <20170401123741.38469-1-aik@ozlabs.ru>
	<20170401123741.38469-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20170401123741.38469-3-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu v3 2/4] vfio-pci: Reorder
 group-to-container attaching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 01, 2017 at 11:37:39PM +1100, Alexey Kardashevskiy wrote:
> At the moment VFIO PCI device initialization works as follows:
> vfio_realize
> 	vfio_get_group
> 		vfio_connect_container
> 			register memory listeners (1)
> 			update QEMU groups lists
> 		vfio_kvm_device_add_group
>=20
> Then (example for pseries) the machine reset hook triggers region_add()
> for all regions where listeners from (1) are listening:
>=20
> ppc_spapr_reset
> 	spapr_phb_reset
> 		spapr_tce_table_enable
> 			memory_region_add_subregion
> 				vfio_listener_region_add
> 					vfio_spapr_create_window
>=20
> This scheme works fine until we need to handle VFIO PCI device hotplug
> _and_ we want to enable in-kernel acceleration on, i.e. after PCI hotplug
> we need a place to call
> ioctl(vfio_kvm_device_fd, KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE).
> Since the ioctl needs a LIOBN fd (from sPAPRTCETable) and a IOMMU group fd
> (from VFIOGroup), vfio_listener_region_add() seems to be the only place
> for this ioctl().
>=20
> However this only works during boot time because the machine reset
> happens strictly after all devices are finalized. When hotplug happens,
> vfio_listener_region_add() is called when a memory listener is registered
> but when this happens:
> 1. new group is not added to the container->group_list yet;
> 2. VFIO KVM device is unaware of the new IOMMU group.
>=20
> This moves bits around to have all necessary VFIO infrastructure
> in place for both initial startup and hotplug cases.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v2:
> * moved container->initialized back to its correct location
> * added missing QLIST_REMOVE()
> ---
>  hw/vfio/common.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index ab95db689c..e8188eb3d5 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1087,6 +1087,14 @@ static int vfio_connect_container(VFIOGroup *group=
, AddressSpace *as,
>          goto free_container_exit;
>      }
> =20
> +    vfio_kvm_device_add_group(group);
> +
> +    QLIST_INIT(&container->group_list);
> +    QLIST_INSERT_HEAD(&space->containers, container, next);
> +
> +    group->container =3D container;
> +    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> +
>      container->listener =3D vfio_memory_listener;
> =20
>      memory_listener_register(&container->listener, container->space->as);
> @@ -1100,14 +1108,11 @@ static int vfio_connect_container(VFIOGroup *grou=
p, AddressSpace *as,
> =20
>      container->initialized =3D true;
> =20
> -    QLIST_INIT(&container->group_list);
> -    QLIST_INSERT_HEAD(&space->containers, container, next);
> -
> -    group->container =3D container;
> -    QLIST_INSERT_HEAD(&container->group_list, group, container_next);
> -
>      return 0;
>  listener_release_exit:
> +    QLIST_REMOVE(group, container_next);
> +    QLIST_REMOVE(container, next);
> +    vfio_kvm_device_del_group(group);
>      vfio_listener_release(container);
> =20
>  free_container_exit:
> @@ -1212,8 +1217,6 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace=
 *as, Error **errp)
> =20
>      QLIST_INSERT_HEAD(&vfio_group_list, group, next);
> =20
> -    vfio_kvm_device_add_group(group);
> -
>      return group;
> =20
>  close_fd_exit:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY4bMuAAoJEGw4ysog2bOSrAsQAOXOjkOQgX9tlDv8Q84M2Fvd
w7zXVb3fNUJ0txQufJJmIrOB23UEs1PtwgF30ZgOh9n1uPSzrK+dwpC2hr9ZGXvz
RapHUVb3tuzxpdTsDn89Jt/KM77OtBrJaGhN8d89HP9ki99RSdXcP5MLV9WPmat6
f4V6KHx4V+/uCOze8JEJB66mKb06q2KyQMFNYI212KGGs1y11xtcnqQovXRb5K0O
wjbhDO+BJA5ivGOlEnbFnXgw7yhwzrpDRKi8+ExbEGgSk3a5TAyRC8/jGMRW+0UD
HHRbG5KqUsheU7JMki3i6AaRJeWZIFbMkmfq4hBt6ihdDJ9uR2pqjkpmPt/MKiVQ
iwfQ/X1lrAlWps5r1AdiuTF0v+e6k3qtGxFtYGy9v/SQgo5aQuhZ2kkUcMU21hSt
1r/lTn+xfZ5k0M+TIiJVJ+BrLHIZLdxtU5rSuPj+8AbhnsHsLaWndmyLgZKIv6Ih
tXMR4Q8orqznVR+HBiFKfluIWPj94rFA7LmdcyGEGsik+8PMOrbgtUyJKJxSkrMG
95OEy7v73cumf3YvXAvtpIxKDCWntmmfhBK1J+a1IOs9jEuQ/lvdsptfrkiFiVcw
4+cOKI1dSDfGeHBop5bGtqOpwEWUsPaIE6I/ZzDtqsLt52CEHK+MdvOdCG9ul109
X8WWX0DhYuXRQAO8WpRd
=jabP
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

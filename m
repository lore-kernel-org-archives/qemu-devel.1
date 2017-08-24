Received: from eggs.gnu.org ([2001:4830:134:3::10]:56239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkrHE-0005aM-BV
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkrH7-0000Ha-IC
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:30:24 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40097)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dkrH6-0000Gc-5u
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:30:17 -0400
Date: Thu, 24 Aug 2017 22:30:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170824123006.GK5379@umbus.fritz.box>
References: <283a2a27-7fb5-5fa7-4921-60ba91f13666@ozlabs.ru>
	<20170818131853.GB17654@stefanha-x1.localdomain>
	<20170821043125.GH12356@umbus.fritz.box>
	<6e2ae379-9cff-9615-c19f-747867328cb5@ozlabs.ru>
	<acb8a5b9-559f-665c-9072-582f3ddc593b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rxd0khGtqYUbFQFd"
Content-Disposition: inline
In-Reply-To: <acb8a5b9-559f-665c-9072-582f3ddc593b@ozlabs.ru>
Subject: Re: [Qemu-devel] Memory use with >100 virtio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>


--rxd0khGtqYUbFQFd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2017 at 07:48:57PM +1000, Alexey Kardashevskiy wrote:
> On 21/08/17 15:50, Alexey Kardashevskiy wrote:
> > On 21/08/17 14:31, David Gibson wrote:
> >> On Fri, Aug 18, 2017 at 02:18:53PM +0100, Stefan Hajnoczi wrote:
> >>> On Fri, Aug 18, 2017 at 03:39:20PM +1000, Alexey Kardashevskiy wrote:
> >>>> =3D=3D94451=3D=3D -------------------- 4 of 10 --------------------
> >>>> =3D=3D94451=3D=3D max-live:    314,649,600 in 150 blocks
> >>>> =3D=3D94451=3D=3D tot-alloc:   314,649,600 in 150 blocks (avg size 2=
097664.00)
> >>>> =3D=3D94451=3D=3D deaths:      none (none of these blocks were freed)
> >>>> =3D=3D94451=3D=3D acc-ratios:  0.00 rd, 0.00 wr  (0 b-read, 0 b-writ=
ten)
> >>>> =3D=3D94451=3D=3D    at 0x4895600: memalign (in
> >>>> /usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
> >>>> =3D=3D94451=3D=3D    by 0x48957E7: posix_memalign (in
> >>>> /usr/lib/valgrind/vgpreload_exp-dhat-ppc64le-linux.so)
> >>>> =3D=3D94451=3D=3D    by 0xB744AB: qemu_try_memalign (oslib-posix.c:1=
06)
> >>>> =3D=3D94451=3D=3D    by 0xA92053: qemu_try_blockalign (io.c:2493)
> >>>> =3D=3D94451=3D=3D    by 0xA34DDF: qcow2_do_open (qcow2.c:1365)
> >>>> =3D=3D94451=3D=3D    by 0xA35627: qcow2_open (qcow2.c:1526)
> >>>> =3D=3D94451=3D=3D    by 0x9FB94F: bdrv_open_driver (block.c:1109)
> >>>> =3D=3D94451=3D=3D    by 0x9FC413: bdrv_open_common (block.c:1365)
> >>>> =3D=3D94451=3D=3D    by 0x9FF823: bdrv_open_inherit (block.c:2542)
> >>>> =3D=3D94451=3D=3D    by 0x9FFC17: bdrv_open (block.c:2626)
> >>>> =3D=3D94451=3D=3D    by 0xA71027: blk_new_open (block-backend.c:267)
> >>>> =3D=3D94451=3D=3D    by 0x6D3E6B: blockdev_init (blockdev.c:588)
> >>>
> >>> This allocation is unnecessary.  Most qcow2 files are not encrypted so
> >>> s->cluster_data does not need to be allocated upfront.
> >>>
> >>> I'll send a patch.
> >>
> >> Is that sufficient to explain the problem, I can't quickly see how big
> >> that unnecessary allocation is - but would it account for the 10s of
> >> gigabytes usage we're seeing here?
> >>
> >> I'm suspecting we accidentally have a O(n^2) or worse space complexity
> >> going on here.
> >>
> >=20
> > No, it is a small fraction only. See "[PATCH] qcow2: allocate
> > cluster_cache/cluster_data on demand" thread for more details.
>=20
>=20
> The information was lost there so I'll continue in this thread.
>=20
> I run QEMU again, with 2GB of RAM, -initrd+-kernel, pseries, 64 PCI
> bridges, -S, no KVM, some virtio-block devices; I run it under "valgrind
> --tool=3Dexp-dhat" and exited via "c-a x" as soon as possible.
>=20
> The summary of each run is:
>=20
> 50 virtio-block devices:
> guest_insns:  2,728,740,444
> max_live:     1,214,121,770 in 226,958 blocks
> tot_alloc:    1,384,726,690 in 310,930 blocks
>=20
>=20
> 150 virtio-block devices:
> guest_insns:  17,576,279,582
> max_live:     7,454,182,031 in 1,286,128 blocks
> tot_alloc:    7,958,747,994 in 1,469,719 blocks
>=20
> 250 virtio-block devices:
> guest_insns:  46,100,928,249
> max_live:     19,423,868,479 in 3,264,833 blocks
> tot_alloc:    20,262,409,839 in 3,548,220 blocks
>=20
> 350 virtio-block devices:
> guest_insns:  88,046,403,555
> max_live:     36,994,652,991 in 6,140,203 blocks
> tot_alloc:    38,167,153,779 in 6,523,206 blocks
>=20
>=20
> Memory usage 1) grows a lot 2) grows out of proportion

Yup, looks to be growing O(n^2) as I suspected.

> 3) QEMU becomes incredibly slow.

Not surprising.  If memory is growing as O(n^2) chances are good we're
also traversing some structure that is growing as O(n^2) which would
certainly be slow.

> With the hack (below) and 350 virtio-block devices, the summary is:
> guest_insns:  7,873,805,573
> max_live:     2,577,738,019 in 2,567,682 blocks
> tot_alloc:    3,750,238,807 in 2,950,685 blocks
> insns per allocated byte: 2
>=20
>=20
> I am also attaching 2 snapshots from the valgrind's "massif" tool, with a=
nd
> without the hack.
>=20
> Ideas what to tweak or what valgrind tool to try?

valgrind probably isn't that useful at this point.  I think we need to
instrument bits of the code to find what the O(n^2) algo is and fix it.

Seems to me checking if the address_spaces list is growing to O(n^2)
entries would be a good place to start.
>=20
>=20
>=20
> The hack is basically excluding virtio-pci-cfg-as from the address_spaces
> list (yeah, it breaks QEMU, this is just a hint):
>=20
> diff --git a/memory.c b/memory.c
> index 02c95d1..118ac7f 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -2589,6 +2589,7 @@ void address_space_init(AddressSpace *as,
> MemoryRegion *root, const char *name)
>      as->ioeventfd_nb =3D 0;
>      as->ioeventfds =3D NULL;
>      QTAILQ_INIT(&as->listeners);
> +    if (strcmp(name, "virtio-pci-cfg-as"))
>      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
>      as->name =3D g_strdup(name ? name : "anonymous");
>      address_space_init_dispatch(as);
>=20
>=20
>=20
>=20

>  57 85,481,838,874   37,075,366,088   36,993,595,913    81,770,175       =
     0
> 99.78% (36,993,595,913B) (heap allocation functions) malloc/new/new[], --=
alloc-fns, etc.
> ->95.82% (35,527,301,159B) 0x59E7392: g_realloc (in /lib/powerpc64le-linu=
x-gnu/libglib-2.0.so.0.5000.2)
> | ->94.64% (35,089,885,088B) 0x59E7756: g_realloc_n (in /lib/powerpc64le-=
linux-gnu/libglib-2.0.so.0.5000.2)
> | | ->90.60% (33,590,452,224B) 0x3A785A: phys_map_node_reserve (exec.c:25=
1)
> | | | ->90.60% (33,590,452,224B) 0x3A7CE2: phys_page_set (exec.c:307)
> | | |   ->90.60% (33,590,452,224B) 0x3AAF26: register_multipage (exec.c:1=
345)
> | | |     ->90.60% (33,590,452,224B) 0x3AB31E: mem_add (exec.c:1376)
> | | |       ->90.55% (33,573,015,552B) 0x437F52: address_space_update_top=
ology_pass (memory.c:855)
> | | |       | ->90.55% (33,573,015,552B) 0x4382C2: address_space_update_t=
opology (memory.c:889)
> | | |       |   ->90.55% (33,573,015,552B) 0x438502: memory_region_transa=
ction_commit (memory.c:925)
> | | |       |     ->54.09% (20,055,085,056B) 0x43D07E: memory_region_upda=
te_container_subregions (memory.c:2136)
> | | |       |     | ->54.09% (20,055,085,056B) 0x43D11E: memory_region_ad=
d_subregion_common (memory.c:2146)
> | | |       |     |   ->51.00% (18,909,941,760B) 0x43D186: memory_region_=
add_subregion (memory.c:2154)
> | | |       |     |   | ->33.27% (12,334,546,944B) 0x92D67E: virtio_pci_m=
odern_region_map (virtio-pci.c:1526)
> | | |       |     |   | | ->33.27% (12,334,546,944B) 0x92D766: virtio_pci=
_modern_mem_region_map (virtio-pci.c:1540)
> | | |       |     |   | |   ->08.33% (3,087,974,400B) 0x92DD32: virtio_pc=
i_device_plugged (virtio-pci.c:1659)
> | | |       |     |   | |   | ->08.33% (3,087,974,400B) 0x931A76: virtio_=
bus_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |   |   ->08.33% (3,087,974,400B) 0x4F36EE: virti=
o_device_realize (virtio.c:2492)
> | | |       |     |   | |   |     ->08.33% (3,087,974,400B) 0x78A4DA: dev=
ice_set_realized (qdev.c:914)
> | | |       |     |   | |   |       ->08.33% (3,087,974,400B) 0x9F5A16: p=
roperty_set_bool (object.c:1886)
> | | |       |     |   | |   |         ->08.33% (3,087,974,400B) 0x9F31BA:=
 object_property_set (object.c:1093)
> | | |       |     |   | |   |           ->08.33% (3,087,974,400B) 0x9F775=
6: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |             ->08.33% (3,087,974,400B) 0x9F3=
566: object_property_set_bool (object.c:1162)
> | | |       |     |   | |   |               ->08.33% (3,087,974,400B) 0x9=
2EE3E: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |   |                 ->08.33% (3,087,974,400B) 0=
x92E6EA: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |   |                   ->08.33% (3,087,974,400B)=
 0x85C472: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |   |                     ->08.33% (3,087,974,400=
B) 0x92EBDE: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |   |                       ->08.33% (3,087,974,4=
00B) 0x78A4DA: device_set_realized (qdev.c:914)
> | | |       |     |   | |   |                         ->08.33% (3,087,974=
,400B) 0x9F5A16: property_set_bool (object.c:1886)
> | | |       |     |   | |   |                           ->08.33% (3,087,9=
74,400B) 0x9F31BA: object_property_set (object.c:1093)
> | | |       |     |   | |   |                             ->08.33% (3,087=
,974,400B) 0x9F7756: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |                              =20
> | | |       |     |   | |   ->08.33% (3,087,974,400B) 0x92DD4E: virtio_pc=
i_device_plugged (virtio-pci.c:1660)
> | | |       |     |   | |   | ->08.33% (3,087,974,400B) 0x931A76: virtio_=
bus_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |   |   ->08.33% (3,087,974,400B) 0x4F36EE: virti=
o_device_realize (virtio.c:2492)
> | | |       |     |   | |   |     ->08.33% (3,087,974,400B) 0x78A4DA: dev=
ice_set_realized (qdev.c:914)
> | | |       |     |   | |   |       ->08.33% (3,087,974,400B) 0x9F5A16: p=
roperty_set_bool (object.c:1886)
> | | |       |     |   | |   |         ->08.33% (3,087,974,400B) 0x9F31BA:=
 object_property_set (object.c:1093)
> | | |       |     |   | |   |           ->08.33% (3,087,974,400B) 0x9F775=
6: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |             ->08.33% (3,087,974,400B) 0x9F3=
566: object_property_set_bool (object.c:1162)
> | | |       |     |   | |   |               ->08.33% (3,087,974,400B) 0x9=
2EE3E: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |   |                 ->08.33% (3,087,974,400B) 0=
x92E6EA: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |   |                   ->08.33% (3,087,974,400B)=
 0x85C472: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |   |                     ->08.33% (3,087,974,400=
B) 0x92EBDE: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |   |                       ->08.33% (3,087,974,4=
00B) 0x78A4DA: device_set_realized (qdev.c:914)
> | | |       |     |   | |   |                         ->08.33% (3,087,974=
,400B) 0x9F5A16: property_set_bool (object.c:1886)
> | | |       |     |   | |   |                           ->08.33% (3,087,9=
74,400B) 0x9F31BA: object_property_set (object.c:1093)
> | | |       |     |   | |   |                             ->08.33% (3,087=
,974,400B) 0x9F7756: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |                              =20
> | | |       |     |   | |   ->08.33% (3,087,876,096B) 0x92DD16: virtio_pc=
i_device_plugged (virtio-pci.c:1658)
> | | |       |     |   | |   | ->08.33% (3,087,876,096B) 0x931A76: virtio_=
bus_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |   |   ->08.33% (3,087,876,096B) 0x4F36EE: virti=
o_device_realize (virtio.c:2492)
> | | |       |     |   | |   |     ->08.33% (3,087,876,096B) 0x78A4DA: dev=
ice_set_realized (qdev.c:914)
> | | |       |     |   | |   |       ->08.33% (3,087,876,096B) 0x9F5A16: p=
roperty_set_bool (object.c:1886)
> | | |       |     |   | |   |         ->08.33% (3,087,876,096B) 0x9F31BA:=
 object_property_set (object.c:1093)
> | | |       |     |   | |   |           ->08.33% (3,087,876,096B) 0x9F775=
6: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |             ->08.33% (3,087,876,096B) 0x9F3=
566: object_property_set_bool (object.c:1162)
> | | |       |     |   | |   |               ->08.33% (3,087,876,096B) 0x9=
2EE3E: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |   |                 ->08.33% (3,087,876,096B) 0=
x92E6EA: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |   |                   ->08.33% (3,087,876,096B)=
 0x85C472: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |   |                     ->08.33% (3,087,876,096=
B) 0x92EBDE: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |   |                       ->08.33% (3,087,876,0=
96B) 0x78A4DA: device_set_realized (qdev.c:914)
> | | |       |     |   | |   |                         ->08.33% (3,087,876=
,096B) 0x9F5A16: property_set_bool (object.c:1886)
> | | |       |     |   | |   |                           ->08.33% (3,087,8=
76,096B) 0x9F31BA: object_property_set (object.c:1093)
> | | |       |     |   | |   |                             ->08.33% (3,087=
,876,096B) 0x9F7756: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |                              =20
> | | |       |     |   | |   ->08.28% (3,070,722,048B) 0x92DCFA: virtio_pc=
i_device_plugged (virtio-pci.c:1657)
> | | |       |     |   | |     ->08.28% (3,070,722,048B) 0x931A76: virtio_=
bus_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |       ->08.28% (3,070,722,048B) 0x4F36EE: virti=
o_device_realize (virtio.c:2492)
> | | |       |     |   | |         ->08.28% (3,070,722,048B) 0x78A4DA: dev=
ice_set_realized (qdev.c:914)
> | | |       |     |   | |           ->08.28% (3,070,722,048B) 0x9F5A16: p=
roperty_set_bool (object.c:1886)
> | | |       |     |   | |             ->08.28% (3,070,722,048B) 0x9F31BA:=
 object_property_set (object.c:1093)
> | | |       |     |   | |               ->08.28% (3,070,722,048B) 0x9F775=
6: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                 ->08.28% (3,070,722,048B) 0x9F3=
566: object_property_set_bool (object.c:1162)
> | | |       |     |   | |                   ->08.28% (3,070,722,048B) 0x9=
2EE3E: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |                     ->08.28% (3,070,722,048B) 0=
x92E6EA: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |                       ->08.28% (3,070,722,048B)=
 0x85C472: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |                         ->08.28% (3,070,722,048=
B) 0x92EBDE: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |                           ->08.28% (3,070,722,0=
48B) 0x78A4DA: device_set_realized (qdev.c:914)
> | | |       |     |   | |                             ->08.28% (3,070,722=
,048B) 0x9F5A16: property_set_bool (object.c:1886)
> | | |       |     |   | |                               ->08.28% (3,070,7=
22,048B) 0x9F31BA: object_property_set (object.c:1093)
> | | |       |     |   | |                                 ->08.28% (3,070=
,722,048B) 0x9F7756: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                                  =20
> | | |       |     |   | ->08.33% (3,087,974,400B) 0x86234E: msix_init (ms=
ix.c:333)
> | | |       |     |   | | ->08.33% (3,087,974,400B) 0x862542: msix_init_e=
xclusive_bar (msix.c:371)
> | | |       |     |   | |   ->08.33% (3,087,974,400B) 0x92DECE: virtio_pc=
i_device_plugged (virtio-pci.c:1688)
> | | |       |     |   | |     ->08.33% (3,087,974,400B) 0x931A76: virtio_=
bus_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |       ->08.33% (3,087,974,400B) 0x4F36EE: virti=
o_device_realize (virtio.c:2492)
> | | |       |     |   | |         ->08.33% (3,087,974,400B) 0x78A4DA: dev=
ice_set_realized (qdev.c:914)
> | | |       |     |   | |           ->08.33% (3,087,974,400B) 0x9F5A16: p=
roperty_set_bool (object.c:1886)
> | | |       |     |   | |             ->08.33% (3,087,974,400B) 0x9F31BA:=
 object_property_set (object.c:1093)
> | | |       |     |   | |               ->08.33% (3,087,974,400B) 0x9F775=
6: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                 ->08.33% (3,087,974,400B) 0x9F3=
566: object_property_set_bool (object.c:1162)
> | | |       |     |   | |                   ->08.33% (3,087,974,400B) 0x9=
2EE3E: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |                     ->08.33% (3,087,974,400B) 0=
x92E6EA: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |                       ->08.33% (3,087,974,400B)=
 0x85C472: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |                         ->08.33% (3,087,974,400=
B) 0x92EBDE: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |                           ->08.33% (3,087,974,4=
00B) 0x78A4DA: device_set_realized (qdev.c:914)
> | | |       |     |   | |                             ->08.33% (3,087,974=
,400B) 0x9F5A16: property_set_bool (object.c:1886)
> | | |       |     |   | |                               ->08.33% (3,087,9=
74,400B) 0x9F31BA: object_property_set (object.c:1093)
> | | |       |     |   | |                                 ->08.33% (3,087=
,974,400B) 0x9F7756: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                                  =20
> | | |       |     |   | ->08.33% (3,087,974,400B) 0x8623A2: msix_init (ms=
ix.c:336)
> | | |       |     |   | | ->08.33% (3,087,974,400B) 0x862542: msix_init_e=
xclusive_bar (msix.c:371)
> | | |       |     |   | |   ->08.33% (3,087,974,400B) 0x92DECE: virtio_pc=
i_device_plugged (virtio-pci.c:1688)
> | | |       |     |   | |     ->08.33% (3,087,974,400B) 0x931A76: virtio_=
bus_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |       ->08.33% (3,087,974,400B) 0x4F36EE: virti=
o_device_realize (virtio.c:2492)
> | | |       |     |   | |         ->08.33% (3,087,974,400B) 0x78A4DA: dev=
ice_set_realized (qdev.c:914)
> | | |       |     |   | |           ->08.33% (3,087,974,400B) 0x9F5A16: p=
roperty_set_bool (object.c:1886)
> | | |       |     |   | |             ->08.33% (3,087,974,400B) 0x9F31BA:=
 object_property_set (object.c:1093)
> | | |       |     |   | |               ->08.33% (3,087,974,400B) 0x9F775=
6: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                 ->08.33% (3,087,974,400B) 0x9F3=
566: object_property_set_bool (object.c:1162)
> | | |       |     |   | |                   ->08.33% (3,087,974,400B) 0x9=
2EE3E: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |                     ->08.33% (3,087,974,400B) 0=
x92E6EA: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |                       ->08.33% (3,087,974,400B)=
 0x85C472: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |                         ->08.33% (3,087,974,400=
B) 0x92EBDE: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |                           ->08.33% (3,087,974,4=
00B) 0x78A4DA: device_set_realized (qdev.c:914)
> | | |       |     |   | |                             ->08.33% (3,087,974=
,400B) 0x9F5A16: property_set_bool (object.c:1886)
> | | |       |     |   | |                               ->08.33% (3,087,9=
74,400B) 0x9F31BA: object_property_set (object.c:1093)
> | | |       |     |   | |                                 ->08.33% (3,087=
,974,400B) 0x9F7756: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                                  =20
> | | |       |     |   | ->01.03% (381,616,128B) 0x8679FA: shpc_init (shpc=
=2Ec:649)
> | | |       |     |   | | ->01.03% (381,616,128B) 0x84E942: pci_bridge_de=
v_realize (pci_bridge_dev.c:65)
> | | |       |     |   | |   ->01.03% (381,616,128B) 0x85C472: pci_qdev_re=
alize (pci.c:2002)
> | | |       |     |   | |     ->01.03% (381,616,128B) 0x78A4DA: device_se=
t_realized (qdev.c:914)
> | | |       |     |   | |       ->01.03% (381,616,128B) 0x9F5A16: propert=
y_set_bool (object.c:1886)
> | | |       |     |   | |         ->01.03% (381,616,128B) 0x9F31BA: objec=
t_property_set (object.c:1093)
> | | |       |     |   | |           ->01.03% (381,616,128B) 0x9F7756: obj=
ect_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |             ->01.03% (381,616,128B) 0x9F3566: o=
bject_property_set_bool (object.c:1162)
> | | |       |     |   | |               ->01.03% (381,616,128B) 0x6E2266:=
 qdev_device_add (qdev-monitor.c:652)
> | | |       |     |   | |                 ->01.03% (381,616,128B) 0x6EEE7=
E: device_init_func (vl.c:2336)
> | | |       |     |   | |                   ->01.03% (381,616,128B) 0xB92=
506: qemu_opts_foreach (qemu-option.c:1104)
> | | |       |     |   | |                     ->01.03% (381,616,128B) 0x6=
F5C02: main (vl.c:4656)
> | | |       |     |   | |                      =20
> | | |       |     |   | ->00.05% (17,829,888B) in 1+ places, all below ms=
_print's threshold (01.00%)
> | | |       |     |   |=20
> | | |       |     |   ->03.09% (1,145,143,296B) 0x43D1F6: memory_region_a=
dd_subregion_overlap (memory.c:2163)
> | | |       |     |     ->03.09% (1,144,848,384B) 0x85F98A: pci_bridge_in=
it_alias (pci_bridge.c:157)
> | | |       |     |     | ->01.03% (381,616,128B) 0x85FBF2: pci_bridge_re=
gion_init (pci_bridge.c:190)
> | | |       |     |     | | ->01.03% (381,616,128B) 0x860586: pci_bridge_=
initfn (pci_bridge.c:383)
> | | |       |     |     | |   ->01.03% (381,616,128B) 0x84E8B6: pci_bridg=
e_dev_realize (pci_bridge_dev.c:59)
> | | |       |     |     | |     ->01.03% (381,616,128B) 0x85C472: pci_qde=
v_realize (pci.c:2002)
> | | |       |     |     | |       ->01.03% (381,616,128B) 0x78A4DA: devic=
e_set_realized (qdev.c:914)
> | | |       |     |     | |         ->01.03% (381,616,128B) 0x9F5A16: pro=
perty_set_bool (object.c:1886)
> | | |       |     |     | |           ->01.03% (381,616,128B) 0x9F31BA: o=
bject_property_set (object.c:1093)
> | | |       |     |     | |             ->01.03% (381,616,128B) 0x9F7756:=
 object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |     | |               ->01.03% (381,616,128B) 0x9F356=
6: object_property_set_bool (object.c:1162)
> | | |       |     |     | |                 ->01.03% (381,616,128B) 0x6E2=
266: qdev_device_add (qdev-monitor.c:652)
> | | |       |     |     | |                   ->01.03% (381,616,128B) 0x6=
EEE7E: device_init_func (vl.c:2336)
> | | |       |     |     | |                     ->01.03% (381,616,128B) 0=
xB92506: qemu_opts_foreach (qemu-option.c:1104)
> | | |       |     |     | |                       ->01.03% (381,616,128B)=
 0x6F5C02: main (vl.c:4656)
> | | |       |     |     | |                        =20
> | | |       |     |     | ->01.03% (381,616,128B) 0x85FC42: pci_bridge_re=
gion_init (pci_bridge.c:196)
> | | |       |     |     | | ->01.03% (381,616,128B) 0x860586: pci_bridge_=
initfn (pci_bridge.c:383)
> | | |       |     |     | |   ->01.03% (381,616,128B) 0x84E8B6: pci_bridg=
e_dev_realize (pci_bridge_dev.c:59)
> | | |       |     |     | |     ->01.03% (381,616,128B) 0x85C472: pci_qde=
v_realize (pci.c:2002)
> | | |       |     |     | |       ->01.03% (381,616,128B) 0x78A4DA: devic=
e_set_realized (qdev.c:914)
> | | |       |     |     | |         ->01.03% (381,616,128B) 0x9F5A16: pro=
perty_set_bool (object.c:1886)
> | | |       |     |     | |           ->01.03% (381,616,128B) 0x9F31BA: o=
bject_property_set (object.c:1093)
> | | |       |     |     | |             ->01.03% (381,616,128B) 0x9F7756:=
 object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |     | |               ->01.03% (381,616,128B) 0x9F356=
6: object_property_set_bool (object.c:1162)
> | | |       |     |     | |                 ->01.03% (381,616,128B) 0x6E2=
266: qdev_device_add (qdev-monitor.c:652)
> | | |       |     |     | |                   ->01.03% (381,616,128B) 0x6=
EEE7E: device_init_func (vl.c:2336)
> | | |       |     |     | |                     ->01.03% (381,616,128B) 0=
xB92506: qemu_opts_foreach (qemu-option.c:1104)
> | | |       |     |     | |                       ->01.03% (381,616,128B)=
 0x6F5C02: main (vl.c:4656)
> | | |       |     |     | |                        =20
> | | |       |     |     | ->01.03% (381,616,128B) 0x85FC92: pci_bridge_re=
gion_init (pci_bridge.c:202)
> | | |       |     |     |   ->01.03% (381,616,128B) 0x860586: pci_bridge_=
initfn (pci_bridge.c:383)
> | | |       |     |     |     ->01.03% (381,616,128B) 0x84E8B6: pci_bridg=
e_dev_realize (pci_bridge_dev.c:59)
> | | |       |     |     |       ->01.03% (381,616,128B) 0x85C472: pci_qde=
v_realize (pci.c:2002)
> | | |       |     |     |         ->01.03% (381,616,128B) 0x78A4DA: devic=
e_set_realized (qdev.c:914)
> | | |       |     |     |           ->01.03% (381,616,128B) 0x9F5A16: pro=
perty_set_bool (object.c:1886)
> | | |       |     |     |             ->01.03% (381,616,128B) 0x9F31BA: o=
bject_property_set (object.c:1093)
> | | |       |     |     |               ->01.03% (381,616,128B) 0x9F7756:=
 object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |     |                 ->01.03% (381,616,128B) 0x9F356=
6: object_property_set_bool (object.c:1162)
> | | |       |     |     |                   ->01.03% (381,616,128B) 0x6E2=
266: qdev_device_add (qdev-monitor.c:652)
> | | |       |     |     |                     ->01.03% (381,616,128B) 0x6=
EEE7E: device_init_func (vl.c:2336)
> | | |       |     |     |                       ->01.03% (381,616,128B) 0=
xB92506: qemu_opts_foreach (qemu-option.c:1104)
> | | |       |     |     |                         ->01.03% (381,616,128B)=
 0x6F5C02: main (vl.c:4656)
> | | |       |     |     |                          =20
> | | |       |     |     ->00.00% (294,912B) in 1+ places, all below ms_pr=
int's threshold (01.00%)
> | | |       |     |    =20
> | | |       |     ->18.82% (6,977,323,008B) 0x43D3CE: memory_region_set_e=
nabled (memory.c:2186)
> | | |       |     | ->18.82% (6,977,323,008B) 0x855E76: pci_init_bus_mast=
er (pci.c:92)
> | | |       |     |   ->18.82% (6,977,323,008B) 0x855F4E: pcibus_machine_=
done (pci.c:104)
> | | |       |     |     ->18.82% (6,977,323,008B) 0xB8E7E6: notifier_list=
_notify (notify.c:40)
> | | |       |     |       ->18.82% (6,977,323,008B) 0x6F03B2: qemu_run_ma=
chine_init_done_notifiers (vl.c:2701)
> | | |       |     |         ->18.82% (6,977,323,008B) 0x6F5E0E: main (vl.=
c:4743)
> | | |       |     |          =20
> | | |       |     ->17.59% (6,523,207,680B) 0x43F016: address_space_init =
(memory.c:2598)
> | | |       |     | ->09.31% (3,452,338,176B) 0x85910E: do_pci_register_d=
evice (pci.c:1006)
> | | |       |     | | ->09.31% (3,452,338,176B) 0x85C42E: pci_qdev_realiz=
e (pci.c:1995)
> | | |       |     | |   ->08.28% (3,070,722,048B) 0x92EBDE: virtio_pci_dc=
_realize (virtio-pci.c:1934)
> | | |       |     | |   | ->08.28% (3,070,722,048B) 0x78A4DA: device_set_=
realized (qdev.c:914)
> | | |       |     | |   |   ->08.28% (3,070,722,048B) 0x9F5A16: property_=
set_bool (object.c:1886)
> | | |       |     | |   |     ->08.28% (3,070,722,048B) 0x9F31BA: object_=
property_set (object.c:1093)
> | | |       |     | |   |       ->08.28% (3,070,722,048B) 0x9F7756: objec=
t_property_set_qobject (qom-qobject.c:27)
> | | |       |     | |   |         ->08.28% (3,070,722,048B) 0x9F3566: obj=
ect_property_set_bool (object.c:1162)
> | | |       |     | |   |           ->08.28% (3,070,722,048B) 0x6E2266: q=
dev_device_add (qdev-monitor.c:652)
> | | |       |     | |   |             ->08.28% (3,070,722,048B) 0x6EEE7E:=
 device_init_func (vl.c:2336)
> | | |       |     | |   |               ->08.28% (3,070,722,048B) 0xB9250=
6: qemu_opts_foreach (qemu-option.c:1104)
> | | |       |     | |   |                 ->08.28% (3,070,722,048B) 0x6F5=
C02: main (vl.c:4656)
> | | |       |     | |   |                  =20
> | | |       |     | |   ->01.03% (381,616,128B) 0x78A4DA: device_set_real=
ized (qdev.c:914)
> | | |       |     | |     ->01.03% (381,616,128B) 0x9F5A16: property_set_=
bool (object.c:1886)
> | | |       |     | |       ->01.03% (381,616,128B) 0x9F31BA: object_prop=
erty_set (object.c:1093)
> | | |       |     | |         ->01.03% (381,616,128B) 0x9F7756: object_pr=
operty_set_qobject (qom-qobject.c:27)
> | | |       |     | |           ->01.03% (381,616,128B) 0x9F3566: object_=
property_set_bool (object.c:1162)
> | | |       |     | |             ->01.03% (381,616,128B) 0x6E2266: qdev_=
device_add (qdev-monitor.c:652)
> | | |       |     | |               ->01.03% (381,616,128B) 0x6EEE7E: dev=
ice_init_func (vl.c:2336)
> | | |       |     | |                 ->01.03% (381,616,128B) 0xB92506: q=
emu_opts_foreach (qemu-option.c:1104)
> | | |       |     | |                   ->01.03% (381,616,128B) 0x6F5C02:=
 main (vl.c:4656)
> | | |       |     | |                    =20
> | | |       |     | ->08.28% (3,070,722,048B) 0x92E45A: virtio_pci_realiz=
e (virtio-pci.c:1793)
> | | |       |     | | ->08.28% (3,070,722,048B) 0x85C472: pci_qdev_realiz=
e (pci.c:2002)
> | | |       |     | |   ->08.28% (3,070,722,048B) 0x92EBDE: virtio_pci_dc=
_realize (virtio-pci.c:1934)
> | | |       |     | |     ->08.28% (3,070,722,048B) 0x78A4DA: device_set_=
realized (qdev.c:914)
> | | |       |     | |       ->08.28% (3,070,722,048B) 0x9F5A16: property_=
set_bool (object.c:1886)
> | | |       |     | |         ->08.28% (3,070,722,048B) 0x9F31BA: object_=
property_set (object.c:1093)
> | | |       |     | |           ->08.28% (3,070,722,048B) 0x9F7756: objec=
t_property_set_qobject (qom-qobject.c:27)
> | | |       |     | |             ->08.28% (3,070,722,048B) 0x9F3566: obj=
ect_property_set_bool (object.c:1162)
> | | |       |     | |               ->08.28% (3,070,722,048B) 0x6E2266: q=
dev_device_add (qdev-monitor.c:652)
> | | |       |     | |                 ->08.28% (3,070,722,048B) 0x6EEE7E:=
 device_init_func (vl.c:2336)
> | | |       |     | |                   ->08.28% (3,070,722,048B) 0xB9250=
6: qemu_opts_foreach (qemu-option.c:1104)
> | | |       |     | |                     ->08.28% (3,070,722,048B) 0x6F5=
C02: main (vl.c:4656)
> | | |       |     | |                      =20
> | | |       |     | ->00.00% (147,456B) in 1+ places, all below ms_print'=
s threshold (01.00%)
> | | |       |     |=20
> | | |       |     ->00.05% (17,399,808B) in 1+ places, all below ms_print=
's threshold (01.00%)
> | | |       |    =20
> | | |       ->00.05% (17,436,672B) in 1+ places, all below ms_print's thr=
eshold (01.00%)
> | | |      =20
> | | ->04.04% (1,499,429,888B) 0x3AA99E: phys_section_add (exec.c:1275)
> | | | ->04.04% (1,499,429,888B) 0x3AF086: dummy_section (exec.c:2644)
> | | |   ->04.04% (1,499,429,888B) 0x3AF306: mem_begin (exec.c:2680)
> | | |     ->04.04% (1,498,658,816B) 0x4384C6: memory_region_transaction_c=
ommit (memory.c:922)
> | | |     | ->02.42% (895,626,240B) 0x43D07E: memory_region_update_contai=
ner_subregions (memory.c:2136)
> | | |     | | ->02.42% (895,626,240B) 0x43D11E: memory_region_add_subregi=
on_common (memory.c:2146)
> | | |     | |   ->02.28% (844,420,096B) 0x43D186: memory_region_add_subre=
gion (memory.c:2154)
> | | |     | |   | ->01.49% (551,043,072B) 0x92D67E: virtio_pci_modern_reg=
ion_map (virtio-pci.c:1526)
> | | |     | |   | | ->01.49% (551,043,072B) 0x92D766: virtio_pci_modern_m=
em_region_map (virtio-pci.c:1540)
> | | |     | |   | |   ->01.49% (551,043,072B) in 4 places, all below mass=
if's threshold (1.00%)
> | | |     | |   | |    =20
> | | |     | |   | ->00.79% (293,377,024B) in 1+ places, all below ms_prin=
t's threshold (01.00%)
> | | |     | |   |=20
> | | |     | |   ->00.14% (51,206,144B) in 1+ places, all below ms_print's=
 threshold (01.00%)
> | | |     | |  =20
> | | |     | ->01.63% (603,032,576B) in 3 places, all below massif's thres=
hold (1.00%)
> | | |     |  =20
> | | |     ->00.00% (771,072B) in 1+ places, all below ms_print's threshol=
d (01.00%)
> | | |    =20
> | | ->00.00% (2,976B) in 1+ places, all below ms_print's threshold (01.00=
%)
> | |=20
> | ->01.18% (437,408,640B) 0x43566A: flatview_insert (memory.c:276)
> | | ->01.18% (437,408,640B) 0x43721E: render_memory_region (memory.c:700)
> | |   ->01.17% (435,189,120B) 0x436D46: render_memory_region (memory.c:65=
8)
> | |   | ->01.16% (428,537,600B) 0x436D02: render_memory_region (memory.c:=
652)
> | |   | | ->01.16% (428,537,600B) 0x437352: generate_memory_topology (mem=
ory.c:713)
> | |   | |   ->01.16% (428,537,600B) 0x438296: address_space_update_topolo=
gy (memory.c:886)
> | |   | |     ->01.16% (428,537,600B) 0x438502: memory_region_transaction=
_commit (memory.c:925)
> | |   | |       ->01.16% (428,537,600B) in 4 places, all below massif's t=
hreshold (1.00%)
> | |   | |        =20
> | |   | ->00.02% (6,651,520B) in 1+ places, all below ms_print's threshol=
d (01.00%)
> | |   |=20
> | |   ->00.01% (2,219,520B) in 1+ places, all below ms_print's threshold =
(01.00%)
> | |  =20
> | ->00.00% (7,431B) in 1+ places, all below ms_print's threshold (01.00%)
> |=20
> ->02.52% (935,163,904B) 0xB744BA: qemu_try_memalign (oslib-posix.c:106)
> | ->02.48% (917,862,400B) 0xA92062: qemu_try_blockalign (io.c:2493)
> | | ->02.47% (917,504,000B) 0xA50402: qcow2_cache_create (qcow2-cache.c:1=
24)
> | | | ->01.98% (734,003,200B) 0xA3355E: qcow2_update_options_prepare (qco=
w2.c:878)
> | | | | ->01.98% (734,003,200B) 0xA33FF2: qcow2_update_options (qcow2.c:1=
077)
> | | | |   ->01.98% (734,003,200B) 0xA34DBA: qcow2_do_open (qcow2.c:1358)
> | | | |     ->01.98% (734,003,200B) 0xA3559A: qcow2_open (qcow2.c:1514)
> | | | |       ->01.98% (734,003,200B) 0x9FB992: bdrv_open_driver (block.c=
:1109)
> | | | |         ->01.98% (734,003,200B) 0x9FC456: bdrv_open_common (block=
=2Ec:1365)
> | | | |           ->01.98% (734,003,200B) 0x9FF866: bdrv_open_inherit (bl=
ock.c:2542)
> | | | |             ->01.98% (734,003,200B) 0x9FFC5A: bdrv_open (block.c:=
2626)
> | | | |               ->01.98% (734,003,200B) in 2 places, all below mass=
if's threshold (1.00%)
> | | | |                =20
> | | | ->00.49% (183,500,800B) in 1+ places, all below ms_print's threshol=
d (01.00%)
> | | |=20
> | | ->00.00% (358,400B) in 1+ places, all below ms_print's threshold (01.=
00%)
> | |=20
> | ->00.05% (17,301,504B) in 1+ places, all below ms_print's threshold (01=
=2E00%)
> |=20
> ->01.10% (407,116,949B) 0x59E72DE: g_malloc0 (in /lib/powerpc64le-linux-g=
nu/libglib-2.0.so.0.5000.2)
> | ->01.10% (407,116,949B) in 92 places, all below massif's threshold (1.0=
0%)
> |  =20
> ->00.33% (124,013,901B) in 1+ places, all below ms_print's threshold (01.=
00%)

>  44  6,960,203,871    2,623,230,816    2,577,729,454    45,501,362       =
     0
> 98.27% (2,577,729,454B) (heap allocation functions) malloc/new/new[], --a=
lloc-fns, etc.
> ->45.96% (1,205,547,303B) 0x59E7392: g_realloc (in /lib/powerpc64le-linux=
-gnu/libglib-2.0.so.0.5000.2)
> | ->45.65% (1,197,564,832B) 0x59E7756: g_realloc_n (in /lib/powerpc64le-l=
inux-gnu/libglib-2.0.so.0.5000.2)
> | | ->28.14% (738,191,360B) 0x3AA99E: phys_section_add (exec.c:1275)
> | | | ->28.14% (738,191,360B) 0x3AF086: dummy_section (exec.c:2644)
> | | |   ->28.14% (738,191,360B) 0x3AF306: mem_begin (exec.c:2680)
> | | |     ->28.12% (737,778,688B) 0x4384C6: memory_region_transaction_com=
mit (memory.c:922)
> | | |     | ->18.56% (486,874,112B) 0x43D07E: memory_region_update_contai=
ner_subregions (memory.c:2136)
> | | |     | | ->18.56% (486,874,112B) 0x43D11E: memory_region_add_subregi=
on_common (memory.c:2146)
> | | |     | |   ->17.49% (458,916,864B) 0x43D186: memory_region_add_subre=
gion (memory.c:2154)
> | | |     | |   | ->11.42% (299,446,272B) 0x92D63A: virtio_pci_modern_reg=
ion_map (virtio-pci.c:1526)
> | | |     | |   | | ->11.42% (299,446,272B) 0x92D722: virtio_pci_modern_m=
em_region_map (virtio-pci.c:1540)
> | | |     | |   | |   ->02.85% (74,861,568B) 0x92DCB6: virtio_pci_device_=
plugged (virtio-pci.c:1657)
> | | |     | |   | |   | ->02.85% (74,861,568B) 0x931A0A: virtio_bus_devic=
e_plugged (virtio-bus.c:74)
> | | |     | |   | |   |   ->02.85% (74,861,568B) 0x4F36AA: virtio_device_=
realize (virtio.c:2492)
> | | |     | |   | |   |     ->02.85% (74,861,568B) 0x78A496: device_set_r=
ealized (qdev.c:914)
> | | |     | |   | |   |       ->02.85% (74,861,568B) 0x9F59AA: property_s=
et_bool (object.c:1886)
> | | |     | |   | |   |         ->02.85% (74,861,568B) 0x9F314E: object_p=
roperty_set (object.c:1093)
> | | |     | |   | |   |           ->02.85% (74,861,568B) 0x9F76EA: object=
_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |   |             ->02.85% (74,861,568B) 0x9F34FA: obje=
ct_property_set_bool (object.c:1162)
> | | |     | |   | |   |               ->02.85% (74,861,568B) 0x92EDD2: vi=
rtio_blk_pci_realize (virtio-pci.c:1979)
> | | |     | |   | |   |                 ->02.85% (74,861,568B) 0x92E67E: =
virtio_pci_realize (virtio-pci.c:1857)
> | | |     | |   | |   |                   ->02.85% (74,861,568B) 0x85C42E=
: pci_qdev_realize (pci.c:2002)
> | | |     | |   | |   |                     ->02.85% (74,861,568B) 0x92EB=
72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |     | |   | |   |                       ->02.85% (74,861,568B) 0x78=
A496: device_set_realized (qdev.c:914)
> | | |     | |   | |   |                         ->02.85% (74,861,568B) 0x=
9F59AA: property_set_bool (object.c:1886)
> | | |     | |   | |   |                           ->02.85% (74,861,568B) =
0x9F314E: object_property_set (object.c:1093)
> | | |     | |   | |   |                             ->02.85% (74,861,568B=
) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |   |                               ->02.85% (74,861,56=
8B) 0x9F34FA: object_property_set_bool (object.c:1162)
> | | |     | |   | |   |                                 ->02.85% (74,861,=
568B) 0x6E2222: qdev_device_add (qdev-monitor.c:652)
> | | |     | |   | |   |                                   ->02.85% (74,86=
1,568B) 0x6EEE3A: device_init_func (vl.c:2336)
> | | |     | |   | |   |                                    =20
> | | |     | |   | |   ->02.85% (74,861,568B) 0x92DCD2: virtio_pci_device_=
plugged (virtio-pci.c:1658)
> | | |     | |   | |   | ->02.85% (74,861,568B) 0x931A0A: virtio_bus_devic=
e_plugged (virtio-bus.c:74)
> | | |     | |   | |   |   ->02.85% (74,861,568B) 0x4F36AA: virtio_device_=
realize (virtio.c:2492)
> | | |     | |   | |   |     ->02.85% (74,861,568B) 0x78A496: device_set_r=
ealized (qdev.c:914)
> | | |     | |   | |   |       ->02.85% (74,861,568B) 0x9F59AA: property_s=
et_bool (object.c:1886)
> | | |     | |   | |   |         ->02.85% (74,861,568B) 0x9F314E: object_p=
roperty_set (object.c:1093)
> | | |     | |   | |   |           ->02.85% (74,861,568B) 0x9F76EA: object=
_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |   |             ->02.85% (74,861,568B) 0x9F34FA: obje=
ct_property_set_bool (object.c:1162)
> | | |     | |   | |   |               ->02.85% (74,861,568B) 0x92EDD2: vi=
rtio_blk_pci_realize (virtio-pci.c:1979)
> | | |     | |   | |   |                 ->02.85% (74,861,568B) 0x92E67E: =
virtio_pci_realize (virtio-pci.c:1857)
> | | |     | |   | |   |                   ->02.85% (74,861,568B) 0x85C42E=
: pci_qdev_realize (pci.c:2002)
> | | |     | |   | |   |                     ->02.85% (74,861,568B) 0x92EB=
72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |     | |   | |   |                       ->02.85% (74,861,568B) 0x78=
A496: device_set_realized (qdev.c:914)
> | | |     | |   | |   |                         ->02.85% (74,861,568B) 0x=
9F59AA: property_set_bool (object.c:1886)
> | | |     | |   | |   |                           ->02.85% (74,861,568B) =
0x9F314E: object_property_set (object.c:1093)
> | | |     | |   | |   |                             ->02.85% (74,861,568B=
) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |   |                               ->02.85% (74,861,56=
8B) 0x9F34FA: object_property_set_bool (object.c:1162)
> | | |     | |   | |   |                                 ->02.85% (74,861,=
568B) 0x6E2222: qdev_device_add (qdev-monitor.c:652)
> | | |     | |   | |   |                                   ->02.85% (74,86=
1,568B) 0x6EEE3A: device_init_func (vl.c:2336)
> | | |     | |   | |   |                                    =20
> | | |     | |   | |   ->02.85% (74,861,568B) 0x92DCEE: virtio_pci_device_=
plugged (virtio-pci.c:1659)
> | | |     | |   | |   | ->02.85% (74,861,568B) 0x931A0A: virtio_bus_devic=
e_plugged (virtio-bus.c:74)
> | | |     | |   | |   |   ->02.85% (74,861,568B) 0x4F36AA: virtio_device_=
realize (virtio.c:2492)
> | | |     | |   | |   |     ->02.85% (74,861,568B) 0x78A496: device_set_r=
ealized (qdev.c:914)
> | | |     | |   | |   |       ->02.85% (74,861,568B) 0x9F59AA: property_s=
et_bool (object.c:1886)
> | | |     | |   | |   |         ->02.85% (74,861,568B) 0x9F314E: object_p=
roperty_set (object.c:1093)
> | | |     | |   | |   |           ->02.85% (74,861,568B) 0x9F76EA: object=
_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |   |             ->02.85% (74,861,568B) 0x9F34FA: obje=
ct_property_set_bool (object.c:1162)
> | | |     | |   | |   |               ->02.85% (74,861,568B) 0x92EDD2: vi=
rtio_blk_pci_realize (virtio-pci.c:1979)
> | | |     | |   | |   |                 ->02.85% (74,861,568B) 0x92E67E: =
virtio_pci_realize (virtio-pci.c:1857)
> | | |     | |   | |   |                   ->02.85% (74,861,568B) 0x85C42E=
: pci_qdev_realize (pci.c:2002)
> | | |     | |   | |   |                     ->02.85% (74,861,568B) 0x92EB=
72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |     | |   | |   |                       ->02.85% (74,861,568B) 0x78=
A496: device_set_realized (qdev.c:914)
> | | |     | |   | |   |                         ->02.85% (74,861,568B) 0x=
9F59AA: property_set_bool (object.c:1886)
> | | |     | |   | |   |                           ->02.85% (74,861,568B) =
0x9F314E: object_property_set (object.c:1093)
> | | |     | |   | |   |                             ->02.85% (74,861,568B=
) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |   |                               ->02.85% (74,861,56=
8B) 0x9F34FA: object_property_set_bool (object.c:1162)
> | | |     | |   | |   |                                 ->02.85% (74,861,=
568B) 0x6E2222: qdev_device_add (qdev-monitor.c:652)
> | | |     | |   | |   |                                   ->02.85% (74,86=
1,568B) 0x6EEE3A: device_init_func (vl.c:2336)
> | | |     | |   | |   |                                    =20
> | | |     | |   | |   ->02.85% (74,861,568B) 0x92DD0A: virtio_pci_device_=
plugged (virtio-pci.c:1660)
> | | |     | |   | |     ->02.85% (74,861,568B) 0x931A0A: virtio_bus_devic=
e_plugged (virtio-bus.c:74)
> | | |     | |   | |       ->02.85% (74,861,568B) 0x4F36AA: virtio_device_=
realize (virtio.c:2492)
> | | |     | |   | |         ->02.85% (74,861,568B) 0x78A496: device_set_r=
ealized (qdev.c:914)
> | | |     | |   | |           ->02.85% (74,861,568B) 0x9F59AA: property_s=
et_bool (object.c:1886)
> | | |     | |   | |             ->02.85% (74,861,568B) 0x9F314E: object_p=
roperty_set (object.c:1093)
> | | |     | |   | |               ->02.85% (74,861,568B) 0x9F76EA: object=
_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |                 ->02.85% (74,861,568B) 0x9F34FA: obje=
ct_property_set_bool (object.c:1162)
> | | |     | |   | |                   ->02.85% (74,861,568B) 0x92EDD2: vi=
rtio_blk_pci_realize (virtio-pci.c:1979)
> | | |     | |   | |                     ->02.85% (74,861,568B) 0x92E67E: =
virtio_pci_realize (virtio-pci.c:1857)
> | | |     | |   | |                       ->02.85% (74,861,568B) 0x85C42E=
: pci_qdev_realize (pci.c:2002)
> | | |     | |   | |                         ->02.85% (74,861,568B) 0x92EB=
72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |     | |   | |                           ->02.85% (74,861,568B) 0x78=
A496: device_set_realized (qdev.c:914)
> | | |     | |   | |                             ->02.85% (74,861,568B) 0x=
9F59AA: property_set_bool (object.c:1886)
> | | |     | |   | |                               ->02.85% (74,861,568B) =
0x9F314E: object_property_set (object.c:1093)
> | | |     | |   | |                                 ->02.85% (74,861,568B=
) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |                                   ->02.85% (74,861,56=
8B) 0x9F34FA: object_property_set_bool (object.c:1162)
> | | |     | |   | |                                     ->02.85% (74,861,=
568B) 0x6E2222: qdev_device_add (qdev-monitor.c:652)
> | | |     | |   | |                                       ->02.85% (74,86=
1,568B) 0x6EEE3A: device_init_func (vl.c:2336)
> | | |     | |   | |                                        =20
> | | |     | |   | ->02.85% (74,861,568B) 0x86230A: msix_init (msix.c:333)
> | | |     | |   | | ->02.85% (74,861,568B) 0x8624FE: msix_init_exclusive_=
bar (msix.c:371)
> | | |     | |   | |   ->02.85% (74,861,568B) 0x92DE8A: virtio_pci_device_=
plugged (virtio-pci.c:1688)
> | | |     | |   | |     ->02.85% (74,861,568B) 0x931A0A: virtio_bus_devic=
e_plugged (virtio-bus.c:74)
> | | |     | |   | |       ->02.85% (74,861,568B) 0x4F36AA: virtio_device_=
realize (virtio.c:2492)
> | | |     | |   | |         ->02.85% (74,861,568B) 0x78A496: device_set_r=
ealized (qdev.c:914)
> | | |     | |   | |           ->02.85% (74,861,568B) 0x9F59AA: property_s=
et_bool (object.c:1886)
> | | |     | |   | |             ->02.85% (74,861,568B) 0x9F314E: object_p=
roperty_set (object.c:1093)
> | | |     | |   | |               ->02.85% (74,861,568B) 0x9F76EA: object=
_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |                 ->02.85% (74,861,568B) 0x9F34FA: obje=
ct_property_set_bool (object.c:1162)
> | | |     | |   | |                   ->02.85% (74,861,568B) 0x92EDD2: vi=
rtio_blk_pci_realize (virtio-pci.c:1979)
> | | |     | |   | |                     ->02.85% (74,861,568B) 0x92E67E: =
virtio_pci_realize (virtio-pci.c:1857)
> | | |     | |   | |                       ->02.85% (74,861,568B) 0x85C42E=
: pci_qdev_realize (pci.c:2002)
> | | |     | |   | |                         ->02.85% (74,861,568B) 0x92EB=
72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |     | |   | |                           ->02.85% (74,861,568B) 0x78=
A496: device_set_realized (qdev.c:914)
> | | |     | |   | |                             ->02.85% (74,861,568B) 0x=
9F59AA: property_set_bool (object.c:1886)
> | | |     | |   | |                               ->02.85% (74,861,568B) =
0x9F314E: object_property_set (object.c:1093)
> | | |     | |   | |                                 ->02.85% (74,861,568B=
) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |                                   ->02.85% (74,861,56=
8B) 0x9F34FA: object_property_set_bool (object.c:1162)
> | | |     | |   | |                                     ->02.85% (74,861,=
568B) 0x6E2222: qdev_device_add (qdev-monitor.c:652)
> | | |     | |   | |                                       ->02.85% (74,86=
1,568B) 0x6EEE3A: device_init_func (vl.c:2336)
> | | |     | |   | |                                        =20
> | | |     | |   | ->02.85% (74,861,568B) 0x86235E: msix_init (msix.c:336)
> | | |     | |   | | ->02.85% (74,861,568B) 0x8624FE: msix_init_exclusive_=
bar (msix.c:371)
> | | |     | |   | |   ->02.85% (74,861,568B) 0x92DE8A: virtio_pci_device_=
plugged (virtio-pci.c:1688)
> | | |     | |   | |     ->02.85% (74,861,568B) 0x931A0A: virtio_bus_devic=
e_plugged (virtio-bus.c:74)
> | | |     | |   | |       ->02.85% (74,861,568B) 0x4F36AA: virtio_device_=
realize (virtio.c:2492)
> | | |     | |   | |         ->02.85% (74,861,568B) 0x78A496: device_set_r=
ealized (qdev.c:914)
> | | |     | |   | |           ->02.85% (74,861,568B) 0x9F59AA: property_s=
et_bool (object.c:1886)
> | | |     | |   | |             ->02.85% (74,861,568B) 0x9F314E: object_p=
roperty_set (object.c:1093)
> | | |     | |   | |               ->02.85% (74,861,568B) 0x9F76EA: object=
_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |                 ->02.85% (74,861,568B) 0x9F34FA: obje=
ct_property_set_bool (object.c:1162)
> | | |     | |   | |                   ->02.85% (74,861,568B) 0x92EDD2: vi=
rtio_blk_pci_realize (virtio-pci.c:1979)
> | | |     | |   | |                     ->02.85% (74,861,568B) 0x92E67E: =
virtio_pci_realize (virtio-pci.c:1857)
> | | |     | |   | |                       ->02.85% (74,861,568B) 0x85C42E=
: pci_qdev_realize (pci.c:2002)
> | | |     | |   | |                         ->02.85% (74,861,568B) 0x92EB=
72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |     | |   | |                           ->02.85% (74,861,568B) 0x78=
A496: device_set_realized (qdev.c:914)
> | | |     | |   | |                             ->02.85% (74,861,568B) 0x=
9F59AA: property_set_bool (object.c:1886)
> | | |     | |   | |                               ->02.85% (74,861,568B) =
0x9F314E: object_property_set (object.c:1093)
> | | |     | |   | |                                 ->02.85% (74,861,568B=
) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |     | |   | |                                   ->02.85% (74,861,56=
8B) 0x9F34FA: object_property_set_bool (object.c:1162)
> | | |     | |   | |                                     ->02.85% (74,861,=
568B) 0x6E2222: qdev_device_add (qdev-monitor.c:652)
> | | |     | |   | |                                       ->02.85% (74,86=
1,568B) 0x6EEE3A: device_init_func (vl.c:2336)
> | | |     | |   | |                                        =20
> | | |     | |   | ->00.37% (9,747,456B) in 1+ places, all below ms_print'=
s threshold (01.00%)
> | | |     | |   |=20
> | | |     | |   ->01.07% (27,957,248B) 0x43D1F6: memory_region_add_subreg=
ion_overlap (memory.c:2163)
> | | |     | |     ->01.07% (27,949,056B) 0x85F946: pci_bridge_init_alias =
(pci_bridge.c:157)
> | | |     | |     | ->01.07% (27,949,056B) in 3 places, all below massif'=
s threshold (1.00%)
> | | |     | |     |  =20
> | | |     | |     ->00.00% (8,192B) in 1+ places, all below ms_print's th=
reshold (01.00%)
> | | |     | |    =20
> | | |     | ->06.34% (166,302,720B) 0x43D3CE: memory_region_set_enabled (=
memory.c:2186)
> | | |     | | ->06.34% (166,302,720B) 0x855E32: pci_init_bus_master (pci.=
c:92)
> | | |     | |   ->06.34% (166,302,720B) 0x855F0A: pcibus_machine_done (pc=
i.c:104)
> | | |     | |     ->06.34% (166,302,720B) 0xB8E77A: notifier_list_notify =
(notify.c:40)
> | | |     | |       ->06.34% (166,302,720B) 0x6F036E: qemu_run_machine_in=
it_done_notifiers (vl.c:2701)
> | | |     | |         ->06.34% (166,302,720B) 0x6F5DCA: main (vl.c:4743)
> | | |     | |          =20
> | | |     | ->03.21% (84,187,136B) 0x43F016: address_space_init (memory.c=
:2596)
> | | |     | | ->03.21% (84,177,920B) 0x8590CA: do_pci_register_device (pc=
i.c:1006)
> | | |     | | | ->03.21% (84,177,920B) 0x85C3EA: pci_qdev_realize (pci.c:=
1995)
> | | |     | | |   ->02.85% (74,861,568B) 0x92EB72: virtio_pci_dc_realize =
(virtio-pci.c:1934)
> | | |     | | |   | ->02.85% (74,861,568B) 0x78A496: device_set_realized =
(qdev.c:914)
> | | |     | | |   |   ->02.85% (74,861,568B) 0x9F59AA: property_set_bool =
(object.c:1886)
> | | |     | | |   |     ->02.85% (74,861,568B) 0x9F314E: object_property_=
set (object.c:1093)
> | | |     | | |   |       ->02.85% (74,861,568B) 0x9F76EA: object_propert=
y_set_qobject (qom-qobject.c:27)
> | | |     | | |   |         ->02.85% (74,861,568B) 0x9F34FA: object_prope=
rty_set_bool (object.c:1162)
> | | |     | | |   |           ->02.85% (74,861,568B) 0x6E2222: qdev_devic=
e_add (qdev-monitor.c:652)
> | | |     | | |   |             ->02.85% (74,861,568B) 0x6EEE3A: device_i=
nit_func (vl.c:2336)
> | | |     | | |   |               ->02.85% (74,861,568B) 0xB9249A: qemu_o=
pts_foreach (qemu-option.c:1104)
> | | |     | | |   |                 ->02.85% (74,861,568B) 0x6F5BBE: main=
 (vl.c:4656)
> | | |     | | |   |                  =20
> | | |     | | |   ->00.36% (9,316,352B) in 1+ places, all below ms_print'=
s threshold (01.00%)
> | | |     | | |  =20
> | | |     | | ->00.00% (9,216B) in 1+ places, all below ms_print's thresh=
old (01.00%)
> | | |     | |=20
> | | |     | ->00.02% (414,720B) in 1+ places, all below ms_print's thresh=
old (01.00%)
> | | |     |=20
> | | |     ->00.02% (412,672B) in 1+ places, all below ms_print's threshol=
d (01.00%)
> | | |    =20
> | | ->17.51% (459,370,496B) 0x3A785A: phys_map_node_reserve (exec.c:251)
> | | | ->17.51% (459,370,496B) 0x3A7CE2: phys_page_set (exec.c:307)
> | | |   ->17.51% (459,370,496B) 0x3AAF26: register_multipage (exec.c:1345)
> | | |     ->17.51% (459,370,496B) 0x3AB31E: mem_add (exec.c:1376)
> | | |       ->17.51% (459,223,040B) 0x437F52: address_space_update_topolo=
gy_pass (memory.c:855)
> | | |       | ->17.51% (459,223,040B) 0x4382C2: address_space_update_topo=
logy (memory.c:889)
> | | |       |   ->17.51% (459,223,040B) 0x438502: memory_region_transacti=
on_commit (memory.c:925)
> | | |       |     ->12.99% (340,668,416B) 0x43D07E: memory_region_update_=
container_subregions (memory.c:2136)
> | | |       |     | ->12.99% (340,668,416B) 0x43D11E: memory_region_add_s=
ubregion_common (memory.c:2146)
> | | |       |     |   ->12.12% (317,812,736B) 0x43D186: memory_region_add=
_subregion (memory.c:2154)
> | | |       |     |   | ->07.87% (206,438,400B) 0x92D63A: virtio_pci_mode=
rn_region_map (virtio-pci.c:1526)
> | | |       |     |   | | ->07.87% (206,438,400B) 0x92D722: virtio_pci_mo=
dern_mem_region_map (virtio-pci.c:1540)
> | | |       |     |   | |   ->01.97% (51,609,600B) 0x92DCB6: virtio_pci_d=
evice_plugged (virtio-pci.c:1657)
> | | |       |     |   | |   | ->01.97% (51,609,600B) 0x931A0A: virtio_bus=
_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |   |   ->01.97% (51,609,600B) 0x4F36AA: virtio_d=
evice_realize (virtio.c:2492)
> | | |       |     |   | |   |     ->01.97% (51,609,600B) 0x78A496: device=
_set_realized (qdev.c:914)
> | | |       |     |   | |   |       ->01.97% (51,609,600B) 0x9F59AA: prop=
erty_set_bool (object.c:1886)
> | | |       |     |   | |   |         ->01.97% (51,609,600B) 0x9F314E: ob=
ject_property_set (object.c:1093)
> | | |       |     |   | |   |           ->01.97% (51,609,600B) 0x9F76EA: =
object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |             ->01.97% (51,609,600B) 0x9F34FA=
: object_property_set_bool (object.c:1162)
> | | |       |     |   | |   |               ->01.97% (51,609,600B) 0x92ED=
D2: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |   |                 ->01.97% (51,609,600B) 0x92=
E67E: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |   |                   ->01.97% (51,609,600B) 0x=
85C42E: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |   |                     ->01.97% (51,609,600B) =
0x92EB72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |   |                       ->01.97% (51,609,600B=
) 0x78A496: device_set_realized (qdev.c:914)
> | | |       |     |   | |   |                         ->01.97% (51,609,60=
0B) 0x9F59AA: property_set_bool (object.c:1886)
> | | |       |     |   | |   |                           ->01.97% (51,609,=
600B) 0x9F314E: object_property_set (object.c:1093)
> | | |       |     |   | |   |                             ->01.97% (51,60=
9,600B) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |                              =20
> | | |       |     |   | |   ->01.97% (51,609,600B) 0x92DCD2: virtio_pci_d=
evice_plugged (virtio-pci.c:1658)
> | | |       |     |   | |   | ->01.97% (51,609,600B) 0x931A0A: virtio_bus=
_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |   |   ->01.97% (51,609,600B) 0x4F36AA: virtio_d=
evice_realize (virtio.c:2492)
> | | |       |     |   | |   |     ->01.97% (51,609,600B) 0x78A496: device=
_set_realized (qdev.c:914)
> | | |       |     |   | |   |       ->01.97% (51,609,600B) 0x9F59AA: prop=
erty_set_bool (object.c:1886)
> | | |       |     |   | |   |         ->01.97% (51,609,600B) 0x9F314E: ob=
ject_property_set (object.c:1093)
> | | |       |     |   | |   |           ->01.97% (51,609,600B) 0x9F76EA: =
object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |             ->01.97% (51,609,600B) 0x9F34FA=
: object_property_set_bool (object.c:1162)
> | | |       |     |   | |   |               ->01.97% (51,609,600B) 0x92ED=
D2: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |   |                 ->01.97% (51,609,600B) 0x92=
E67E: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |   |                   ->01.97% (51,609,600B) 0x=
85C42E: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |   |                     ->01.97% (51,609,600B) =
0x92EB72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |   |                       ->01.97% (51,609,600B=
) 0x78A496: device_set_realized (qdev.c:914)
> | | |       |     |   | |   |                         ->01.97% (51,609,60=
0B) 0x9F59AA: property_set_bool (object.c:1886)
> | | |       |     |   | |   |                           ->01.97% (51,609,=
600B) 0x9F314E: object_property_set (object.c:1093)
> | | |       |     |   | |   |                             ->01.97% (51,60=
9,600B) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |                              =20
> | | |       |     |   | |   ->01.97% (51,609,600B) 0x92DCEE: virtio_pci_d=
evice_plugged (virtio-pci.c:1659)
> | | |       |     |   | |   | ->01.97% (51,609,600B) 0x931A0A: virtio_bus=
_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |   |   ->01.97% (51,609,600B) 0x4F36AA: virtio_d=
evice_realize (virtio.c:2492)
> | | |       |     |   | |   |     ->01.97% (51,609,600B) 0x78A496: device=
_set_realized (qdev.c:914)
> | | |       |     |   | |   |       ->01.97% (51,609,600B) 0x9F59AA: prop=
erty_set_bool (object.c:1886)
> | | |       |     |   | |   |         ->01.97% (51,609,600B) 0x9F314E: ob=
ject_property_set (object.c:1093)
> | | |       |     |   | |   |           ->01.97% (51,609,600B) 0x9F76EA: =
object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |             ->01.97% (51,609,600B) 0x9F34FA=
: object_property_set_bool (object.c:1162)
> | | |       |     |   | |   |               ->01.97% (51,609,600B) 0x92ED=
D2: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |   |                 ->01.97% (51,609,600B) 0x92=
E67E: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |   |                   ->01.97% (51,609,600B) 0x=
85C42E: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |   |                     ->01.97% (51,609,600B) =
0x92EB72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |   |                       ->01.97% (51,609,600B=
) 0x78A496: device_set_realized (qdev.c:914)
> | | |       |     |   | |   |                         ->01.97% (51,609,60=
0B) 0x9F59AA: property_set_bool (object.c:1886)
> | | |       |     |   | |   |                           ->01.97% (51,609,=
600B) 0x9F314E: object_property_set (object.c:1093)
> | | |       |     |   | |   |                             ->01.97% (51,60=
9,600B) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |   |                              =20
> | | |       |     |   | |   ->01.97% (51,609,600B) 0x92DD0A: virtio_pci_d=
evice_plugged (virtio-pci.c:1660)
> | | |       |     |   | |     ->01.97% (51,609,600B) 0x931A0A: virtio_bus=
_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |       ->01.97% (51,609,600B) 0x4F36AA: virtio_d=
evice_realize (virtio.c:2492)
> | | |       |     |   | |         ->01.97% (51,609,600B) 0x78A496: device=
_set_realized (qdev.c:914)
> | | |       |     |   | |           ->01.97% (51,609,600B) 0x9F59AA: prop=
erty_set_bool (object.c:1886)
> | | |       |     |   | |             ->01.97% (51,609,600B) 0x9F314E: ob=
ject_property_set (object.c:1093)
> | | |       |     |   | |               ->01.97% (51,609,600B) 0x9F76EA: =
object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                 ->01.97% (51,609,600B) 0x9F34FA=
: object_property_set_bool (object.c:1162)
> | | |       |     |   | |                   ->01.97% (51,609,600B) 0x92ED=
D2: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |                     ->01.97% (51,609,600B) 0x92=
E67E: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |                       ->01.97% (51,609,600B) 0x=
85C42E: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |                         ->01.97% (51,609,600B) =
0x92EB72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |                           ->01.97% (51,609,600B=
) 0x78A496: device_set_realized (qdev.c:914)
> | | |       |     |   | |                             ->01.97% (51,609,60=
0B) 0x9F59AA: property_set_bool (object.c:1886)
> | | |       |     |   | |                               ->01.97% (51,609,=
600B) 0x9F314E: object_property_set (object.c:1093)
> | | |       |     |   | |                                 ->01.97% (51,60=
9,600B) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                                  =20
> | | |       |     |   | ->01.97% (51,609,600B) 0x86230A: msix_init (msix.=
c:333)
> | | |       |     |   | | ->01.97% (51,609,600B) 0x8624FE: msix_init_excl=
usive_bar (msix.c:371)
> | | |       |     |   | |   ->01.97% (51,609,600B) 0x92DE8A: virtio_pci_d=
evice_plugged (virtio-pci.c:1688)
> | | |       |     |   | |     ->01.97% (51,609,600B) 0x931A0A: virtio_bus=
_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |       ->01.97% (51,609,600B) 0x4F36AA: virtio_d=
evice_realize (virtio.c:2492)
> | | |       |     |   | |         ->01.97% (51,609,600B) 0x78A496: device=
_set_realized (qdev.c:914)
> | | |       |     |   | |           ->01.97% (51,609,600B) 0x9F59AA: prop=
erty_set_bool (object.c:1886)
> | | |       |     |   | |             ->01.97% (51,609,600B) 0x9F314E: ob=
ject_property_set (object.c:1093)
> | | |       |     |   | |               ->01.97% (51,609,600B) 0x9F76EA: =
object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                 ->01.97% (51,609,600B) 0x9F34FA=
: object_property_set_bool (object.c:1162)
> | | |       |     |   | |                   ->01.97% (51,609,600B) 0x92ED=
D2: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |                     ->01.97% (51,609,600B) 0x92=
E67E: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |                       ->01.97% (51,609,600B) 0x=
85C42E: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |                         ->01.97% (51,609,600B) =
0x92EB72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |                           ->01.97% (51,609,600B=
) 0x78A496: device_set_realized (qdev.c:914)
> | | |       |     |   | |                             ->01.97% (51,609,60=
0B) 0x9F59AA: property_set_bool (object.c:1886)
> | | |       |     |   | |                               ->01.97% (51,609,=
600B) 0x9F314E: object_property_set (object.c:1093)
> | | |       |     |   | |                                 ->01.97% (51,60=
9,600B) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                                  =20
> | | |       |     |   | ->01.97% (51,609,600B) 0x86235E: msix_init (msix.=
c:336)
> | | |       |     |   | | ->01.97% (51,609,600B) 0x8624FE: msix_init_excl=
usive_bar (msix.c:371)
> | | |       |     |   | |   ->01.97% (51,609,600B) 0x92DE8A: virtio_pci_d=
evice_plugged (virtio-pci.c:1688)
> | | |       |     |   | |     ->01.97% (51,609,600B) 0x931A0A: virtio_bus=
_device_plugged (virtio-bus.c:74)
> | | |       |     |   | |       ->01.97% (51,609,600B) 0x4F36AA: virtio_d=
evice_realize (virtio.c:2492)
> | | |       |     |   | |         ->01.97% (51,609,600B) 0x78A496: device=
_set_realized (qdev.c:914)
> | | |       |     |   | |           ->01.97% (51,609,600B) 0x9F59AA: prop=
erty_set_bool (object.c:1886)
> | | |       |     |   | |             ->01.97% (51,609,600B) 0x9F314E: ob=
ject_property_set (object.c:1093)
> | | |       |     |   | |               ->01.97% (51,609,600B) 0x9F76EA: =
object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                 ->01.97% (51,609,600B) 0x9F34FA=
: object_property_set_bool (object.c:1162)
> | | |       |     |   | |                   ->01.97% (51,609,600B) 0x92ED=
D2: virtio_blk_pci_realize (virtio-pci.c:1979)
> | | |       |     |   | |                     ->01.97% (51,609,600B) 0x92=
E67E: virtio_pci_realize (virtio-pci.c:1857)
> | | |       |     |   | |                       ->01.97% (51,609,600B) 0x=
85C42E: pci_qdev_realize (pci.c:2002)
> | | |       |     |   | |                         ->01.97% (51,609,600B) =
0x92EB72: virtio_pci_dc_realize (virtio-pci.c:1934)
> | | |       |     |   | |                           ->01.97% (51,609,600B=
) 0x78A496: device_set_realized (qdev.c:914)
> | | |       |     |   | |                             ->01.97% (51,609,60=
0B) 0x9F59AA: property_set_bool (object.c:1886)
> | | |       |     |   | |                               ->01.97% (51,609,=
600B) 0x9F314E: object_property_set (object.c:1093)
> | | |       |     |   | |                                 ->01.97% (51,60=
9,600B) 0x9F76EA: object_property_set_qobject (qom-qobject.c:27)
> | | |       |     |   | |                                  =20
> | | |       |     |   | ->00.31% (8,155,136B) in 1+ places, all below ms_=
print's threshold (01.00%)
> | | |       |     |   |=20
> | | |       |     |   ->00.87% (22,855,680B) in 1+ places, all below ms_p=
rint's threshold (01.00%)
> | | |       |     |  =20
> | | |       |     ->02.26% (59,277,312B) 0x43F016: address_space_init (me=
mory.c:2596)
> | | |       |     | ->02.25% (59,129,856B) 0x8590CA: do_pci_register_devi=
ce (pci.c:1006)
> | | |       |     | | ->02.25% (59,129,856B) 0x85C3EA: pci_qdev_realize (=
pci.c:1995)
> | | |       |     | |   ->01.97% (51,609,600B) 0x92EB72: virtio_pci_dc_re=
alize (virtio-pci.c:1934)
> | | |       |     | |   | ->01.97% (51,609,600B) 0x78A496: device_set_rea=
lized (qdev.c:914)
> | | |       |     | |   |   ->01.97% (51,609,600B) 0x9F59AA: property_set=
_bool (object.c:1886)
> | | |       |     | |   |     ->01.97% (51,609,600B) 0x9F314E: object_pro=
perty_set (object.c:1093)
> | | |       |     | |   |       ->01.97% (51,609,600B) 0x9F76EA: object_p=
roperty_set_qobject (qom-qobject.c:27)
> | | |       |     | |   |         ->01.97% (51,609,600B) 0x9F34FA: object=
_property_set_bool (object.c:1162)
> | | |       |     | |   |           ->01.97% (51,609,600B) 0x6E2222: qdev=
_device_add (qdev-monitor.c:652)
> | | |       |     | |   |             ->01.97% (51,609,600B) 0x6EEE3A: de=
vice_init_func (vl.c:2336)
> | | |       |     | |   |               ->01.97% (51,609,600B) 0xB9249A: =
qemu_opts_foreach (qemu-option.c:1104)
> | | |       |     | |   |                 ->01.97% (51,609,600B) 0x6F5BBE=
: main (vl.c:4656)
> | | |       |     | |   |                  =20
> | | |       |     | |   ->00.29% (7,520,256B) in 1+ places, all below ms_=
print's threshold (01.00%)
> | | |       |     | |  =20
> | | |       |     | ->00.01% (147,456B) in 1+ places, all below ms_print'=
s threshold (01.00%)
> | | |       |     |=20
> | | |       |     ->02.25% (59,129,856B) 0x43D3CE: memory_region_set_enab=
led (memory.c:2186)
> | | |       |     | ->02.25% (59,129,856B) 0x855E32: pci_init_bus_master =
(pci.c:92)
> | | |       |     |   ->02.25% (59,129,856B) 0x855F0A: pcibus_machine_don=
e (pci.c:104)
> | | |       |     |     ->02.25% (59,129,856B) 0xB8E77A: notifier_list_no=
tify (notify.c:40)
> | | |       |     |       ->02.25% (59,129,856B) 0x6F036E: qemu_run_machi=
ne_init_done_notifiers (vl.c:2701)
> | | |       |     |         ->02.25% (59,129,856B) 0x6F5DCA: main (vl.c:4=
743)
> | | |       |     |          =20
> | | |       |     ->00.01% (147,456B) in 1+ places, all below ms_print's =
threshold (01.00%)
> | | |       |    =20
> | | |       ->00.01% (147,456B) in 1+ places, all below ms_print's thresh=
old (01.00%)
> | | |      =20
> | | ->00.00% (2,976B) in 1+ places, all below ms_print's threshold (01.00=
%)
> | |=20
> | ->00.30% (7,982,471B) in 1+ places, all below ms_print's threshold (01.=
00%)
> |=20
> ->35.65% (935,163,904B) 0xB7444E: qemu_try_memalign (oslib-posix.c:106)
> | ->34.99% (917,862,400B) 0xA91FF6: qemu_try_blockalign (io.c:2493)
> | | ->34.98% (917,504,000B) 0xA50396: qcow2_cache_create (qcow2-cache.c:1=
24)
> | | | ->27.98% (734,003,200B) 0xA334F2: qcow2_update_options_prepare (qco=
w2.c:878)
> | | | | ->27.98% (734,003,200B) 0xA33F86: qcow2_update_options (qcow2.c:1=
077)
> | | | |   ->27.98% (734,003,200B) 0xA34D4E: qcow2_do_open (qcow2.c:1358)
> | | | |     ->27.98% (734,003,200B) 0xA3552E: qcow2_open (qcow2.c:1514)
> | | | |       ->27.98% (734,003,200B) 0x9FB926: bdrv_open_driver (block.c=
:1109)
> | | | |         ->27.98% (734,003,200B) 0x9FC3EA: bdrv_open_common (block=
=2Ec:1365)
> | | | |           ->27.98% (734,003,200B) 0x9FF7FA: bdrv_open_inherit (bl=
ock.c:2542)
> | | | |             ->27.98% (734,003,200B) 0x9FFBEE: bdrv_open (block.c:=
2626)
> | | | |               ->13.99% (367,001,600B) 0xA70FCA: blk_new_open (blo=
ck-backend.c:267)
> | | | |               | ->13.99% (367,001,600B) 0x6D3E6A: blockdev_init (=
blockdev.c:588)
> | | | |               | | ->13.99% (367,001,600B) 0x6D52EA: drive_new (bl=
ockdev.c:1093)
> | | | |               | |   ->13.99% (367,001,600B) 0x6E98DA: drive_init_=
func (vl.c:1157)
> | | | |               | |     ->13.99% (367,001,600B) 0xB9249A: qemu_opts=
_foreach (qemu-option.c:1104)
> | | | |               | |       ->13.99% (367,001,600B) 0x6F577E: main (v=
l.c:4569)
> | | | |               | |        =20
> | | | |               | ->00.00% (0B) in 1+ places, all below ms_print's =
threshold (01.00%)
> | | | |               |=20
> | | | |               ->13.99% (367,001,600B) 0x9FEF4A: bdrv_append_temp_=
snapshot (block.c:2336)
> | | | |                 ->13.99% (367,001,600B) 0x9FF996: bdrv_open_inher=
it (block.c:2585)
> | | | |                   ->13.99% (367,001,600B) 0x9FFBEE: bdrv_open (bl=
ock.c:2626)
> | | | |                     ->13.99% (367,001,600B) 0xA70FCA: blk_new_ope=
n (block-backend.c:267)
> | | | |                       ->13.99% (367,001,600B) 0x6D3E6A: blockdev_=
init (blockdev.c:588)
> | | | |                         ->13.99% (367,001,600B) 0x6D52EA: drive_n=
ew (blockdev.c:1093)
> | | | |                           ->13.99% (367,001,600B) 0x6E98DA: drive=
_init_func (vl.c:1157)
> | | | |                             ->13.99% (367,001,600B) 0xB9249A: qem=
u_opts_foreach (qemu-option.c:1104)
> | | | |                               ->13.99% (367,001,600B) 0x6F577E: m=
ain (vl.c:4569)
> | | | |                                =20
> | | | ->07.00% (183,500,800B) 0xA33516: qcow2_update_options_prepare (qco=
w2.c:879)
> | | |   ->07.00% (183,500,800B) 0xA33F86: qcow2_update_options (qcow2.c:1=
077)
> | | |     ->07.00% (183,500,800B) 0xA34D4E: qcow2_do_open (qcow2.c:1358)
> | | |       ->07.00% (183,500,800B) 0xA3552E: qcow2_open (qcow2.c:1514)
> | | |         ->07.00% (183,500,800B) 0x9FB926: bdrv_open_driver (block.c=
:1109)
> | | |           ->07.00% (183,500,800B) 0x9FC3EA: bdrv_open_common (block=
=2Ec:1365)
> | | |             ->07.00% (183,500,800B) 0x9FF7FA: bdrv_open_inherit (bl=
ock.c:2542)
> | | |               ->07.00% (183,500,800B) 0x9FFBEE: bdrv_open (block.c:=
2626)
> | | |                 ->03.50% (91,750,400B) 0xA70FCA: blk_new_open (bloc=
k-backend.c:267)
> | | |                 | ->03.50% (91,750,400B) 0x6D3E6A: blockdev_init (b=
lockdev.c:588)
> | | |                 | | ->03.50% (91,750,400B) 0x6D52EA: drive_new (blo=
ckdev.c:1093)
> | | |                 | |   ->03.50% (91,750,400B) 0x6E98DA: drive_init_f=
unc (vl.c:1157)
> | | |                 | |     ->03.50% (91,750,400B) 0xB9249A: qemu_opts_=
foreach (qemu-option.c:1104)
> | | |                 | |       ->03.50% (91,750,400B) 0x6F577E: main (vl=
=2Ec:4569)
> | | |                 | |        =20
> | | |                 | ->00.00% (0B) in 1+ places, all below ms_print's =
threshold (01.00%)
> | | |                 |=20
> | | |                 ->03.50% (91,750,400B) 0x9FEF4A: bdrv_append_temp_s=
napshot (block.c:2336)
> | | |                   ->03.50% (91,750,400B) 0x9FF996: bdrv_open_inheri=
t (block.c:2585)
> | | |                     ->03.50% (91,750,400B) 0x9FFBEE: bdrv_open (blo=
ck.c:2626)
> | | |                       ->03.50% (91,750,400B) 0xA70FCA: blk_new_open=
 (block-backend.c:267)
> | | |                         ->03.50% (91,750,400B) 0x6D3E6A: blockdev_i=
nit (blockdev.c:588)
> | | |                           ->03.50% (91,750,400B) 0x6D52EA: drive_ne=
w (blockdev.c:1093)
> | | |                             ->03.50% (91,750,400B) 0x6E98DA: drive_=
init_func (vl.c:1157)
> | | |                               ->03.50% (91,750,400B) 0xB9249A: qemu=
_opts_foreach (qemu-option.c:1104)
> | | |                                 ->03.50% (91,750,400B) 0x6F577E: ma=
in (vl.c:4569)
> | | |                                  =20
> | | ->00.01% (358,400B) in 1+ places, all below ms_print's threshold (01.=
00%)
> | |=20
> | ->00.66% (17,301,504B) in 1+ places, all below ms_print's threshold (01=
=2E00%)
> |=20
> ->13.07% (342,746,525B) 0x59E72DE: g_malloc0 (in /lib/powerpc64le-linux-g=
nu/libglib-2.0.so.0.5000.2)
> | ->05.97% (156,494,936B) 0x79C4D2: rom_add_file (loader.c:930)
> | | ->05.97% (156,494,936B) 0x797306: load_image_targphys_as (loader.c:15=
3)
> | |   ->05.97% (156,494,936B) 0x79725E: load_image_targphys (loader.c:139)
> | |     ->05.93% (155,589,632B) 0x515706: ppc_spapr_init (spapr.c:2451)
> | |     | ->05.93% (155,589,632B) 0x79669A: machine_run_board_init (machi=
ne.c:760)
> | |     |   ->05.93% (155,589,632B) 0x6F5AD2: main (vl.c:4630)
> | |     |    =20
> | |     ->00.03% (905,304B) in 1+ places, all below ms_print's threshold =
(01.00%)
> | |    =20
> | ->03.20% (84,050,584B) 0x59E76C6: g_malloc0_n (in /lib/powerpc64le-linu=
x-gnu/libglib-2.0.so.0.5000.2)
> | | ->02.42% (63,438,320B) 0x3AF2DE: mem_begin (exec.c:2677)
> | | | ->02.42% (63,402,856B) 0x4384C6: memory_region_transaction_commit (=
memory.c:922)
> | | | | ->01.60% (41,840,744B) 0x43D07E: memory_region_update_container_s=
ubregions (memory.c:2136)
> | | | | | ->01.60% (41,840,744B) 0x43D11E: memory_region_add_subregion_co=
mmon (memory.c:2146)
> | | | | |   ->01.50% (39,438,168B) 0x43D186: memory_region_add_subregion =
(memory.c:2154)
> | | | | |   | ->01.50% (39,438,168B) in 10 places, all below massif's thr=
eshold (1.00%)
> | | | | |   |  =20
> | | | | |   ->00.09% (2,402,576B) in 1+ places, all below ms_print's thre=
shold (01.00%)
> | | | | |  =20
> | | | | ->00.82% (21,562,112B) in 1+ places, all below ms_print's thresho=
ld (01.00%)
> | | | |=20
> | | | ->00.00% (35,464B) in 1+ places, all below ms_print's threshold (01=
=2E00%)
> | | |=20
> | | ->00.79% (20,612,264B) in 1+ places, all below ms_print's threshold (=
01.00%)
> | |=20
> | ->02.15% (56,325,805B) in 90 places, all below massif's threshold (1.00=
%)
> | |=20
> | ->01.75% (45,875,200B) 0x4F289A: virtio_init (virtio.c:2249)
> |   ->01.75% (45,875,200B) 0x4759E2: virtio_blk_device_realize (virtio-bl=
k.c:946)
> |     ->01.75% (45,875,200B) 0x4F3672: virtio_device_realize (virtio.c:24=
85)
> |       ->01.75% (45,875,200B) 0x78A496: device_set_realized (qdev.c:914)
> |         ->01.75% (45,875,200B) 0x9F59AA: property_set_bool (object.c:18=
86)
> |           ->01.75% (45,875,200B) 0x9F314E: object_property_set (object.=
c:1093)
> |             ->01.75% (45,875,200B) 0x9F76EA: object_property_set_qobjec=
t (qom-qobject.c:27)
> |               ->01.75% (45,875,200B) 0x9F34FA: object_property_set_bool=
 (object.c:1162)
> |                 ->01.75% (45,875,200B) 0x92EDD2: virtio_blk_pci_realize=
 (virtio-pci.c:1979)
> |                   ->01.75% (45,875,200B) 0x92E67E: virtio_pci_realize (=
virtio-pci.c:1857)
> |                     ->01.75% (45,875,200B) 0x85C42E: pci_qdev_realize (=
pci.c:2002)
> |                       ->01.75% (45,875,200B) 0x92EB72: virtio_pci_dc_re=
alize (virtio-pci.c:1934)
> |                         ->01.75% (45,875,200B) 0x78A496: device_set_rea=
lized (qdev.c:914)
> |                           ->01.75% (45,875,200B) 0x9F59AA: property_set=
_bool (object.c:1886)
> |                             ->01.75% (45,875,200B) 0x9F314E: object_pro=
perty_set (object.c:1093)
> |                               ->01.75% (45,875,200B) 0x9F76EA: object_p=
roperty_set_qobject (qom-qobject.c:27)
> |                                 ->01.75% (45,875,200B) 0x9F34FA: object=
_property_set_bool (object.c:1162)
> |                                   ->01.75% (45,875,200B) 0x6E2222: qdev=
_device_add (qdev-monitor.c:652)
> |                                     ->01.75% (45,875,200B) 0x6EEE3A: de=
vice_init_func (vl.c:2336)
> |                                       ->01.75% (45,875,200B) 0xB9249A: =
qemu_opts_foreach (qemu-option.c:1104)
> |                                         ->01.75% (45,875,200B) 0x6F5BBE=
: main (vl.c:4656)
> |                                          =20
> ->01.78% (46,585,929B) 0x59E7236: g_malloc (in /lib/powerpc64le-linux-gnu=
/libglib-2.0.so.0.5000.2)
> | ->01.16% (30,407,584B) 0x59E7636: g_malloc_n (in /lib/powerpc64le-linux=
-gnu/libglib-2.0.so.0.5000.2)
> | | ->01.10% (28,819,480B) 0x4372C6: generate_memory_topology (memory.c:7=
09)
> | | | ->01.10% (28,819,480B) 0x438296: address_space_update_topology (mem=
ory.c:886)
> | | |   ->01.10% (28,819,480B) 0x438502: memory_region_transaction_commit=
 (memory.c:925)
> | | |     ->01.10% (28,819,480B) in 4 places, all below massif's threshol=
d (1.00%)
> | | |      =20
> | | ->00.06% (1,588,104B) in 1+ places, all below ms_print's threshold (0=
1.00%)
> | |=20
> | ->00.62% (16,178,345B) in 1+ places, all below ms_print's threshold (01=
=2E00%)
> |=20
> ->01.75% (45,875,200B) 0x59E74DE: g_try_malloc (in /lib/powerpc64le-linux=
-gnu/libglib-2.0.so.0.5000.2)
> | ->01.75% (45,875,200B) 0xA3D99A: qcow2_refcount_init (qcow2-refcount.c:=
109)
> | | ->01.75% (45,875,200B) 0xA34D82: qcow2_do_open (qcow2.c:1366)
> | |   ->01.75% (45,875,200B) 0xA3552E: qcow2_open (qcow2.c:1514)
> | |     ->01.75% (45,875,200B) 0x9FB926: bdrv_open_driver (block.c:1109)
> | |       ->01.75% (45,875,200B) 0x9FC3EA: bdrv_open_common (block.c:1365)
> | |         ->01.75% (45,875,200B) 0x9FF7FA: bdrv_open_inherit (block.c:2=
542)
> | |           ->01.75% (45,875,200B) 0x9FFBEE: bdrv_open (block.c:2626)
> | |             ->01.75% (45,875,200B) in 2 places, all below massif's th=
reshold (1.00%)
> | |              =20
> | ->00.00% (0B) in 1+ places, all below ms_print's threshold (01.00%)
> |=20
> ->00.07% (1,810,593B) in 1+ places, all below ms_print's threshold (01.00=
%)





--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rxd0khGtqYUbFQFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmexswACgkQbDjKyiDZ
s5IMKA/7B/qHlDZlkz5dTpQSc5+lpp7zoxtURfebHiIY1Hiam0vwONTUnnNYE7W3
KvXmhMH7kDPW1q870aXtqlbhiWxfyu1B79W8vhJfmTvhN8ULI48E9mFECEqAlvOt
N4qkTJw60c+pWg4p6kcNqvRuxkheg509j2kxeRJh8obKj+vv1Fz/oSShoaCjr31s
g6W0RopakB2dqOlqsroUlC6PXk8rMvg9lymMTWcQ8rmDAtu+++cZQ4Ukkp1Y+wJ7
JJBafyTjui/lQnNwfK2pv8IK7lhk1iONR6fsv4ENBNEIrahBcdVoWEauoNuvWF/p
UsWYQ8RI5FI+3VKtzQe0EEzfKKNArlxhUHd3Oz2ZXDsp4eipJn6RPzP7wiSkbC9p
JUvjpMmzKKdwPYsLqXClbG7p7+T0JgBDFSqMMmEMEHIk7XE6CHS5n4A72Zz+m8AP
TT6HYMXJGjTGoYXYzsvywaEQc9aUTw0OKk+Hp9MMuVooxqQGQSxFlYzS7bJv8yuA
tVOACVwN/5xbaQZcCmHRQKn74qFaQ0JF7Osj+8v78v6rCwCzKNVXnmyRqIclATS9
PgH/m5ObOx/GY1Rla9f+SutiYLZFkrycVemf+sqdCwTJntfo/zFTNpVmoucHDdZJ
UtNZJUciSIxmgCiKidYfg3KycdtbM1g55D6CcxOahLNgtt9UXfQ=
=vTvE
-----END PGP SIGNATURE-----

--rxd0khGtqYUbFQFd--

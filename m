Received: from eggs.gnu.org ([2001:4830:134:3::10]:57399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRVHw-0003fr-Gx
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 22:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eRVHu-0004On-8d
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 22:43:24 -0500
Date: Wed, 20 Dec 2017 14:24:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171220032439.GA5981@umbus.fritz.box>
References: <20171215062914.27927-1-aik@ozlabs.ru>
	<20171219045202.GK4786@umbus.fritz.box>
	<20171219102609.02f22c9d@t450s.home>
	<14df94b1-7edc-5fa4-864c-eacafcfa438e@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <14df94b1-7edc-5fa4-864c-eacafcfa438e@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v2] RFC: vfio-pci: Allow mmap of MSIX
 BAR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2017 at 12:13:04PM +1100, Alexey Kardashevskiy wrote:
> On 20/12/17 04:26, Alex Williamson wrote:
> > On Tue, 19 Dec 2017 15:52:02 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> >> On Fri, Dec 15, 2017 at 05:29:14PM +1100, Alexey Kardashevskiy wrote:
> >>> This makes use of a new VFIO_REGION_INFO_CAP_MSIX_MAPPABLE capability
> >>> which tells that a region with MSIX data can be mapped entirely, i.e.
> >>> the VFIO PCI driver won't prevent MSIX vectors area from being mapped.
> >>>
> >>> With this change, all BARs are mapped in a single chunk and MSIX vect=
ors
> >>> are emulated on top unless the machine requests not to by defining and
> >>> enabling a new "vfio-no-msix-emulation" property. At the moment only
> >>> sPAPR machine does so - it prohibits MSIX emulation and does not allow
> >>> enabling it as it does not define the "set" callback for the new prop=
erty;
> >>> the new property also does not appear in "-machine pseries,help".
> >>>
> >>> If the new capability is present, this puts MSIX IO memory region und=
er
> >>> mapped memory region. If the capability is not there, it falls back to
> >>> the old behaviour with the sparse capability.
> >>>
> >>> In MSIX vectors section is not aligned to the page size, the KVM memo=
ry
> >>> listener does not register it with the KVM as a memory slot and MSIX =
is
> >>> emulated by QEMU as before.
> >>>
> >>> This requires the kernel change - "vfio-pci: Allow mapping MSIX BAR" -
> >>> for the new capability: https://www.spinics.net/lists/kvm/msg160282.h=
tml
> >>>
> >>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>> ---
> >>>
> >>> This is mtree and flatview BEFORE this patch:
> >>>
> >>> "info mtree":
> >>> memory-region: pci@800000020000000.mmio
> >>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@80000002000000=
0.mmio
> >>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR=
 1
> >>>       000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
> >>>       000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [disa=
bled]
> >>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 BAR=
 3
> >>>       0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 =
BAR 3 mmaps[0]
> >>>
> >>> "info mtree -f":
> >>> FlatView #0
> >>>  AS "memory", root: system
> >>>  AS "cpu-memory", root: system
> >>>  Root memory region: system
> >>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
> >>>   0000210000000000-000021000000dfff (prio 1, i/o): 0001:03:00.0 BAR 1
> >>>   000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
> >>>   000021000000e600-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR 1=
 @000000000000e600
> >>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR =
3 mmaps[0]
> >>>
> >>>
> >>>
> >>> This is AFTER this patch applied:
> >>>
> >>> "info mtree":
> >>> memory-region: pci@800000020000000.mmio
> >>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@80000002000000=
0.mmio
> >>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR=
 1
> >>>       0000210000000000-000021000000ffff (prio 0, ramd): 0001:03:00.0 =
BAR 1 mmaps[0]
> >>>         000021000000e000-000021000000e5ff (prio 0, i/o): msix-table [=
disabled]
> >>>         000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [di=
sabled]
> >>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 BAR=
 3
> >>>       0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 =
BAR 3 mmaps[0]
> >>>
> >>>
> >>> "info mtree -f":
> >>> FlatView #2
> >>>  AS "memory", root: system
> >>>  AS "cpu-memory", root: system
> >>>  Root memory region: system
> >>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
> >>>   0000210000000000-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR =
1 mmaps[0]
> >>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR =
3 mmaps[0]
> >>>
> >>>
> >>>
> >>> This is AFTER this patch applied AND spapr_get_msix_emulation() patch=
ed
> >>> to enable emulation:
> >>>
> >>> "info mtree":
> >>> memory-region: pci@800000020000000.mmio
> >>>   0000000000000000-ffffffffffffffff (prio 0, i/o): pci@80000002000000=
0.mmio
> >>>     0000210000000000-000021000000ffff (prio 1, i/o): 0001:03:00.0 BAR=
 1
> >>>       0000210000000000-000021000000ffff (prio 0, ramd): 0001:03:00.0 =
BAR 1 mmaps[0]
> >>>         000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
> >>>         000021000000f000-000021000000f00f (prio 0, i/o): msix-pba [di=
sabled]
> >>>     0000210000040000-000021000007ffff (prio 1, i/o): 0001:03:00.0 BAR=
 3
> >>>       0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 =
BAR 3 mmaps[0]
> >>>
> >>> "info mtree -f":
> >>> FlatView #1
> >>>  AS "memory", root: system
> >>>  AS "cpu-memory", root: system
> >>>  Root memory region: system
> >>>   0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
> >>>   0000210000000000-000021000000dfff (prio 0, ramd): 0001:03:00.0 BAR =
1 mmaps[0]
> >>>   000021000000e000-000021000000e5ff (prio 0, i/o): msix-table
> >>>   000021000000e600-000021000000ffff (prio 0, ramd): 0001:03:00.0 BAR =
1 mmaps[0] @000000000000e600
> >>>   0000210000040000-000021000007ffff (prio 0, ramd): 0001:03:00.0 BAR =
3 mmaps[0]
> >>> ---
> >>>  include/hw/vfio/vfio-common.h |  1 +
> >>>  linux-headers/linux/vfio.h    |  5 +++++
> >>>  hw/ppc/spapr.c                |  8 ++++++++
> >>>  hw/vfio/common.c              | 15 +++++++++++++++
> >>>  hw/vfio/pci.c                 | 23 +++++++++++++++++++++--
> >>>  5 files changed, 50 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-com=
mon.h
> >>> index f3a2ac9..927d600 100644
> >>> --- a/include/hw/vfio/vfio-common.h
> >>> +++ b/include/hw/vfio/vfio-common.h
> >>> @@ -171,6 +171,7 @@ int vfio_get_region_info(VFIODevice *vbasedev, in=
t index,
> >>>                           struct vfio_region_info **info);
> >>>  int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
> >>>                               uint32_t subtype, struct vfio_region_in=
fo **info);
> >>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, in=
t region);
> >>>  #endif
> >>>  extern const MemoryListener vfio_prereg_listener;
> >>> =20
> >>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> >>> index 4312e96..b45182e 100644
> >>> --- a/linux-headers/linux/vfio.h
> >>> +++ b/linux-headers/linux/vfio.h
> >>> @@ -301,6 +301,11 @@ struct vfio_region_info_cap_type {
> >>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> >>>  #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> >>> =20
> >>> +/*
> >>> + * The MSIX mappable capability informs that MSIX data of a BAR can =
be mmapped.
> >>> + */
> >>> +#define VFIO_REGION_INFO_CAP_MSIX_MAPPABLE	3
> >>> +
> >>>  /**
> >>>   * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
> >>>   *				    struct vfio_irq_info)
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index 9de63f0..693394a 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -2772,6 +2772,11 @@ static void spapr_set_modern_hotplug_events(Ob=
ject *obj, bool value,
> >>>      spapr->use_hotplug_event_source =3D value;
> >>>  }
> >>> =20
> >>> +static bool spapr_get_msix_emulation(Object *obj, Error **errp)
> >>> +{
> >>> +    return true;
> >>> +}
> >>> +
> >>>  static char *spapr_get_resize_hpt(Object *obj, Error **errp)
> >>>  {
> >>>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> >>> @@ -2853,6 +2858,8 @@ static void spapr_machine_initfn(Object *obj)
> >>>      object_property_set_description(obj, "vsmt",
> >>>                                      "Virtual SMT: KVM behaves as if =
this were"
> >>>                                      " the host's SMT mode", &error_a=
bort);
> >>> +    object_property_add_bool(obj, "vfio-no-msix-emulation",
> >>> +                             spapr_get_msix_emulation, NULL, NULL); =
=20
> >>
> >> I prefer the approach where the property is in the PCI device, set by
> >> the machine defaults mechanism, rather than the property being in the
> >> machine and the device having to look it up.
> >>
> >> If Alex prefers the latter though, I'm ok with that way around.
> >=20
> > I prefer anything that doesn't result in a user visible option.
>=20
>=20
> The only way to have this is an interface implemented by a machine. I can
> do that, call it "TYPE_MSIX_MMIO" or "TYPE_CONFIG_VFIO".

I new interface seems overkill.  You could just add a
"needs_msix_emulation" method to MachineClass.  It will return true by
default, but pseries will override it. (or invert the sense, I don't care)

> >>>  }
> >>> =20
> >>>  static void spapr_machine_finalizefn(Object *obj)
> >>> @@ -3742,6 +3749,7 @@ static const TypeInfo spapr_machine_info =3D {
> >>>  /*
> >>>   * pseries-2.11
> >>>   */
> >>> +
> >>>  static void spapr_machine_2_11_instance_options(MachineState *machin=
e)
> >>>  {
> >>>  }
> >>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> >>> index 1fb8a8e..da5f182 100644
> >>> --- a/hw/vfio/common.c
> >>> +++ b/hw/vfio/common.c
> >>> @@ -1411,6 +1411,21 @@ int vfio_get_dev_region_info(VFIODevice *vbase=
dev, uint32_t type,
> >>>      return -ENODEV;
> >>>  }
> >>> =20
> >>> +bool vfio_is_cap_present(VFIODevice *vbasedev, uint16_t cap_type, in=
t region)
> >>> +{
> >>> +    struct vfio_region_info *info =3D NULL;
> >>> +    bool ret =3D false;
> >>> +
> >>> +    if (!vfio_get_region_info(vbasedev, region, &info)) {
> >>> +        if (vfio_get_region_info_cap(info, cap_type)) {
> >>> +            ret =3D true;
> >>> +        }
> >>> +        g_free(info);
> >>> +    }
> >>> +
> >>> +    return ret;
> >>> +}
> >>> +
> >>>  /*
> >>>   * Interfaces for IBM EEH (Enhanced Error Handling)
> >>>   */
> >>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >>> index c977ee3..27a3706 100644
> >>> --- a/hw/vfio/pci.c
> >>> +++ b/hw/vfio/pci.c
> >>> @@ -1289,6 +1289,11 @@ static void vfio_pci_fixup_msix_region(VFIOPCI=
Device *vdev)
> >>>      off_t start, end;
> >>>      VFIORegion *region =3D &vdev->bars[vdev->msix->table_bar].region;
> >>> =20
> >>> +    if (vfio_is_cap_present(&vdev->vbasedev, VFIO_REGION_INFO_CAP_MS=
IX_MAPPABLE,
> >>> +                            vdev->msix->table_bar)) {
> >>> +        return;
> >>> +    }
> >>> +
> >>>      /*
> >>>       * We expect to find a single mmap covering the whole BAR, anyth=
ing else
> >>>       * means it's either unsupported or already setup.
> >>> @@ -1432,6 +1437,15 @@ static void vfio_msix_early_setup(VFIOPCIDevic=
e *vdev, Error **errp)
> >>>      vfio_pci_fixup_msix_region(vdev);
> >>>  }
> >>> =20
> >>> +static MemoryRegion *vfio_msix_parent(VFIORegion *region)
> >>> +{
> >>> +    if (region->nr_mmaps =3D=3D 1 && region->mmaps[0].size =3D=3D re=
gion->size) {
> >>> +        return &region->mmaps[0].mem;
> >>> +    }
> >>> +
> >>> +    return region->mem;
> >>> +}
> >>> +
> >>>  static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **err=
p)
> >>>  {
> >>>      int ret;
> >>> @@ -1440,9 +1454,9 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev,=
 int pos, Error **errp)
> >>>      vdev->msix->pending =3D g_malloc0(BITS_TO_LONGS(vdev->msix->entr=
ies) *
> >>>                                      sizeof(unsigned long));
> >>>      ret =3D msix_init(&vdev->pdev, vdev->msix->entries,
> >>> -                    vdev->bars[vdev->msix->table_bar].region.mem,
> >>> +                    vfio_msix_parent(&vdev->bars[vdev->msix->table_b=
ar].region),
> >>>                      vdev->msix->table_bar, vdev->msix->table_offset,
> >>> -                    vdev->bars[vdev->msix->pba_bar].region.mem,
> >>> +                    vfio_msix_parent(&vdev->bars[vdev->msix->pba_bar=
].region),
> >>>                      vdev->msix->pba_bar, vdev->msix->pba_offset, pos,
> >>>                      &err);
> >>>      if (ret < 0) {
> >>> @@ -1473,6 +1487,11 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev=
, int pos, Error **errp)
> >>>       */
> >>>      memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
> >>> =20
> >>> +    if (object_property_get_bool(OBJECT(qdev_get_machine()),
> >>> +                                 "vfio-no-msix-emulation", NULL)) {
> >>> +        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false=
);
> >>> +    }
> >>> + =20
> >>
> >> As Alex pointed out elsewhere, the need for the MSI-X emulation isn't
> >> really VFIO specific.  It would make more sense to have the test
> >> directly in msix_init(), and have it skip adding the msix region to
> >> the BAR if the machine has said it's not necessary.
> >=20
> > How much of the MSI-X capability do SPAPR guests make use of?=20
>=20
> Presence of the capability seems to be just enough.
>=20
> I disabled the sanity test in msix_init(), hardcoded:
> vdev->msix->table_offset =3D 0xff0000;
> vdev->msix->pba_offset =3D 0xfff000;
> in vfio_msix_setup() and got it up and running:
>=20
> 00:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic SAS3008
> PCI-Express Fusion-MPT SAS-3 (rev 02)
>=20
> Region 1: Memory at 210000000000 (64-bit, non-prefetchable) [size=3D64K]
> Region 3: Memory at 210000040000 (64-bit, non-prefetchable) [size=3D256K]
> Expansion ROM at 2000c0000000 [disabled] [size=3D1M]
>=20
> Capabilities: [c0] MSI-X: Enable+ Count=3D96 Masked-
>         Vector table: BAR=3D1 offset=3D00ff0000
>         PBA: BAR=3D1 offset=3D00fff000
>=20
>=20
> > Asking
> > msix_init() to manage an MSI-X capability that references MMIO regions
> > on a BAR that aren't implemented is a bit incongruous.  Is there some
> > way that the MSI-X capability can make it clear that MSI-X MMIO isn't
> > implemented?  Offsets past the end of the BAR?=20
>=20
> This works.

Sounds ok.

> > Reserved BIR values?
>=20
> This does not - the only reserved value is 7 and it crashes as the device
> does not implement BAR7 (ROM).
>=20
>=20
> > You're basically asking msix_init() to create either an incomplete or
> > invalid configuration.  Thanks,

I guess.  I mean this is a platform specific performance hack, I feel
as though hackiness is to be expected.

> I still like "vfio-no-msix-emulation" better.
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlo51/QACgkQbDjKyiDZ
s5J5XBAAs72jd04+YMUfjNYLDnlNEJLZ9hEAYtmsjgFhVAw+IJeJHXqemj0ZDdjK
BBpyA6+qc4CpkhQNX/sONSil0f1473EUDvqwAb21vO+cOaF5snxP3jdk/w9/n12F
jjnQjfIl1Kif21oiIS7PU88acNAayztdz8gq0ROtiwN4ozIiR8jtAqNMKgQeqCxs
TPde17cDzCUmmQKcqNvbGbLgPhvi9NdSIGOLFEza3kS8zgik8kRdGUzdEWspmD+s
Vv2bxFfZqW5UCVZRossAyfPZ74QQdKZqjJIyive8/PhHt1IyzXNCqMHiM9KpPCP2
ZH+3WiJHnl3sI2PrE4SRG//+EGOjt0UGJ2Cq0jTWY7KN2VeNERAESgahsl7jx9/Z
DYUKk5q+WsJYnosSPltAqSMqPz4jeYtK2nEGEGV6Ld5ThqgNxOTsAer7ras8ov5s
kQLuDyuM+Vds159UHCTwxEUdStSykTWpSB5d0eovM4WleDDwSPQG1EqEowFM8VBX
Y+41PZ5lTwTBP0jI1ZIrH35PYoMktPSPrxVMt6bCH3ttnwwa8aCdBAVlVdrBTmjq
YRJ0rPYi3YwNDWbINk0NXV32muLYPwJ+dQDvDWyfoMlv1WBy3H8UyjZ5r6fdGY/S
h1rNmT8tdFHnm/twglq5f6zLiEmcYcFW+v63XwvyUXTAAIhnZTA=
=kjbM
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--

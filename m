Received: from eggs.gnu.org ([2001:4830:134:3::10]:38796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cIwWz-0006u6-GP
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@intel.com>) id 1cIwWv-0007TQ-DK
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:55:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:12071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1cIwWv-0007Ss-2K
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 06:54:57 -0500
From: "Liu, Yi L" <yi.l.liu@intel.com>
Date: Mon, 19 Dec 2016 11:54:52 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257438FD9150@shsmsx102.ccr.corp.intel.com>
References: <A2975661238FB949B60364EF0F2C257438FD8042@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <A2975661238FB949B60364EF0F2C257438FD8042@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v7 3/5] IOMMU: enable intel_iommu map and
 unmap notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>
Cc: "'Michael S. Tsirkin'" <mst@redhat.com>, "', Jan Kiszka'" <jan.kiszka@siemens.com>, "', Peter Xu'" <peterx@redhat.com>, "', Alex
	Williamson'" <alex.williamson@redhat.com>, "', Jason Wang'" <jasowang@redhat.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>

> -----Original Message-----
> From: Liu, Yi L
> Sent: Friday, December 16, 2016 5:12 PM
> To: bd.aviv@gmail.com; qemu-devel@nongnu.org
> Cc: Michael S. Tsirkin <mst@redhat.com>; , Jan Kiszka
> <jan.kiszka@siemens.com>; , Peter Xu <peterx@redhat.com>; , Alex Williams=
on
> <alex.williamson@redhat.com>; , Jason Wang <jasowang@redhat.com>; Lan,
> Tianyu <tianyu.lan@intel.com>; Tian, Kevin <kevin.tian@intel.com>; Liu, Y=
i L
> <yi.l.liu@intel.com>
> Subject: RE: [Qemu-devel] [PATCH v7 3/5] IOMMU: enable intel_iommu map
> and unmap notifiers
>=20
> > From: "Aviv Ben-David" <address@hidden>
> >
> > Adds a list of registered vtd_as's to intel iommu state to save
> > iteration over each PCI device in a search of the corrosponding domain.
> >
> > Signed-off-by: Aviv Ben-David <address@hidden>
> > ---
> >  hw/i386/intel_iommu.c          | 94
> ++++++++++++++++++++++++++++++++++++++----
> >  hw/i386/intel_iommu_internal.h |  2 +
> >  include/hw/i386/intel_iommu.h  |  9 ++++
> >  3 files changed, 98 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 05973b9..d872969 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -679,7 +679,7 @@ static int vtd_gpa_to_slpte(VTDContextEntry *ce,
> uint64_t
> > gpa,
> >          }
> >          *reads =3D (*reads) && (slpte & VTD_SL_R);
> >          *writes =3D (*writes) && (slpte & VTD_SL_W);
> > -        if (!(slpte & access_right_check)) {
> > +        if (!(slpte & access_right_check) && !(flags & IOMMU_NO_FAIL))=
 {
> >              VTD_DPRINTF(GENERAL, "error: lack of %s permission for "
> >                          "gpa 0x%"PRIx64 " slpte 0x%"PRIx64,
> >                          (flags & IOMMU_WO ? "write" : "read"), gpa, sl=
pte);
> > @@ -978,6 +978,23 @@ static VTDBus
> *vtd_find_as_from_bus_num(IntelIOMMUState
> > *s, uint8_t bus_num)
> >      return vtd_bus;
> >  }
> >
> > +static int vtd_get_did_dev(IntelIOMMUState *s, uint8_t bus_num, uint8_=
t
> devfn,
> > +                           uint16_t *domain_id)
> > +{
> > +    VTDContextEntry ce;
> > +    int ret_fr;
> > +
> > +    assert(domain_id);
> > +
> > +    ret_fr =3D vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
> > +    if (ret_fr) {
> > +        return -1;
> > +    }
> > +
> > +    *domain_id =3D  VTD_CONTEXT_ENTRY_DID(ce.hi);
> > +    return 0;
> > +}
> > +
> >  /* Do a context-cache device-selective invalidation.
> >   * @func_mask: FM field after shifting
> >   */
> > @@ -1064,6 +1081,45 @@ static void
> vtd_iotlb_domain_invalidate(IntelIOMMUState
> > *s, uint16_t domain_id)
> >                                  &domain_id);
> >  }
> >
> > +static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
> > +                                           uint16_t domain_id, hwaddr =
addr,
> > +                                           uint8_t am)
> > +{
> > +    IntelIOMMUNotifierNode *node;
> > +
> > +    QLIST_FOREACH(node, &(s->notifiers_list), next) {
> Aviv,
>=20
> Regards to the s->notifiers_list, I didn't see the init op to it. Does it=
 happen
> in another patch? If so, it may be better to move it in this patch since =
this
> patch introduces both the definition and usage of notifiers_list.
>=20
> If it is already clarified, then ignore it.
>=20
> Thanks,
> Yi L
> > +        VTDAddressSpace *vtd_as =3D node->vtd_as;
> > +        uint16_t vfio_domain_id;
> > +        int ret =3D vtd_get_did_dev(s, pci_bus_num(vtd_as->bus), vtd_a=
s->devfn,
> > +                                  &vfio_domain_id);
> > +
> > +        if (!ret && domain_id =3D=3D vfio_domain_id) {
> > +            hwaddr original_addr =3D addr;
> > +
> > +            while (addr < original_addr + (1 << am) * VTD_PAGE_SIZE) {
> > +                IOMMUTLBEntry entry =3D s->iommu_ops.translate(
> > +                                                         &node->vtd_as=
->iommu,
> > +                                                         addr,
> > +                                                         IOMMU_NO_FAIL=
);
> > +
> > +                if (entry.perm =3D=3D IOMMU_NONE &&
> > +                        node->notifier_flag & IOMMU_NOTIFIER_UNMAP) {
> > +                    entry.target_as =3D &address_space_memory;
> > +                    entry.iova =3D addr & VTD_PAGE_MASK_4K;
> > +                    entry.translated_addr =3D 0;
> > +                    entry.addr_mask =3D ~VTD_PAGE_MASK(VTD_PAGE_SHIFT)=
;
> > +                    memory_region_notify_iommu(&node->vtd_as->iommu, e=
ntry);
> > +                    addr +=3D VTD_PAGE_SIZE;
> > +                } else if (node->notifier_flag & IOMMU_NOTIFIER_MAP) {
> > +                        memory_region_notify_iommu(&node->vtd_as->iomm=
u,
> > entry);
> > +                        addr +=3D entry.addr_mask + 1;
> > +                }
> > +            }
> > +        }
> > +    }
> > +}
> > +
> >  static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t
> domain_id,
> >                                        hwaddr addr, uint8_t am)
> >  {
> > @@ -1074,6 +1130,8 @@ static void
> vtd_iotlb_page_invalidate(IntelIOMMUState *s,
> > uint16_t domain_id,
> >      info.addr =3D addr;
> >      info.mask =3D ~((1 << am) - 1);
> >      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_page,
> &info);
> > +
> > +    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
> >  }
> >
> >  /* Flush IOTLB
> > @@ -1999,15 +2057,37 @@ static void
> vtd_iommu_notify_flag_changed(MemoryRegion
> > *iommu,
> >                                            IOMMUNotifierFlag new)
> >  {
> >      VTDAddressSpace *vtd_as =3D container_of(iommu, VTDAddressSpace,
> iommu);
> > +    IntelIOMMUState *s =3D vtd_as->iommu_state;
> > +    IntelIOMMUNotifierNode *node =3D NULL;
> > +    IntelIOMMUNotifierNode *next_node =3D NULL;
> >
> > -    if (new & IOMMU_NOTIFIER_MAP) {
> > -        error_report("Device at bus %s addr %02x.%d requires iommu "
> > -                     "notifier which is currently not supported by "
> > -                     "intel-iommu emulation",
> > -                     vtd_as->bus->qbus.name, PCI_SLOT(vtd_as->devfn),
> > -                     PCI_FUNC(vtd_as->devfn));
> > +    if (!s->cache_mode_enabled && new & IOMMU_NOTIFIER_MAP) {
> > +        error_report("We need to set cache_mode=3D1 for intel-iommu to=
 enable
> "
> > +                     "device assignment with IOMMU protection.");
> >          exit(1);
> >      }
> > +
> > +    /* Add new ndoe if no mapping was exising before this call */

a typo needed. "/* Add new node if no mapping was existing before this call=
 */"

Regards,
Yi L

> > +    if (old =3D=3D IOMMU_NOTIFIER_NONE) {
> > +        node =3D g_malloc0(sizeof(*node));
> > +        node->vtd_as =3D vtd_as;
> > +        node->notifier_flag =3D new;
> > +        QLIST_INSERT_HEAD(&s->notifiers_list, node, next);
> > +        return;
> > +    }
> > +
> > +    /* update notifier node with new flags */
> > +    QLIST_FOREACH_SAFE(node, &s->notifiers_list, next, next_node) {
> > +        if (node->vtd_as =3D=3D vtd_as) {
> > +            if (new =3D=3D IOMMU_NOTIFIER_NONE) {
> > +                QLIST_REMOVE(node, next);
> > +                g_free(node);
> > +            } else {
> > +                node->notifier_flag =3D new;
> > +            }
> > +            return;
> > +        }
> > +    }
> >  }
> >
> >

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBwxt-00062J-Qc
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fBwxo-0008Qc-SU
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:34:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fBwxo-0008QQ-NC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 02:34:36 -0400
Date: Fri, 27 Apr 2018 14:34:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180427063426.GA9036@xz-mi>
References: <20180425045129.17449-1-peterx@redhat.com>
	<20180425045129.17449-9-peterx@redhat.com>
	<2b05e076-0af9-0ee9-c076-7acc29714913@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b05e076-0af9-0ee9-c076-7acc29714913@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/10] intel-iommu: maintain per-device
 iova ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>, "Tian, Kevin" <kevin.tian@intel.com>

On Fri, Apr 27, 2018 at 02:07:46PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B404=E6=9C=8825=E6=97=A5 12:51, Peter Xu wrote:
> > For each VTDAddressSpace, now we maintain what IOVA ranges we have
> > mapped and what we have not.  With that information, now we only send
> > MAP or UNMAP when necessary.  Say, we don't send MAP notifies if we k=
now
> > we have already mapped the range, meanwhile we don't send UNMAP notif=
ies
> > if we know we never mapped the range at all.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/hw/i386/intel_iommu.h |  2 ++
> >   hw/i386/intel_iommu.c         | 28 ++++++++++++++++++++++++++++
> >   hw/i386/trace-events          |  2 ++
> >   3 files changed, 32 insertions(+)
> >=20
> > diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_io=
mmu.h
> > index 486e205e79..09a2e94404 100644
> > --- a/include/hw/i386/intel_iommu.h
> > +++ b/include/hw/i386/intel_iommu.h
> > @@ -27,6 +27,7 @@
> >   #include "hw/i386/ioapic.h"
> >   #include "hw/pci/msi.h"
> >   #include "hw/sysbus.h"
> > +#include "qemu/interval-tree.h"
> >   #define TYPE_INTEL_IOMMU_DEVICE "intel-iommu"
> >   #define INTEL_IOMMU_DEVICE(obj) \
> > @@ -95,6 +96,7 @@ struct VTDAddressSpace {
> >       QLIST_ENTRY(VTDAddressSpace) next;
> >       /* Superset of notifier flags that this address space has */
> >       IOMMUNotifierFlag notifier_flags;
> > +    ITTree *iova_tree;          /* Traces mapped IOVA ranges */
> >   };
> >   struct VTDBus {
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index a19c18b8d4..8f396a5d13 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -768,12 +768,37 @@ typedef struct {
> >   static int vtd_page_walk_one(IOMMUTLBEntry *entry, int level,
> >                                vtd_page_walk_info *info)
> >   {
> > +    VTDAddressSpace *as =3D info->as;
> >       vtd_page_walk_hook hook_fn =3D info->hook_fn;
> >       void *private =3D info->private;
> > +    ITRange *mapped =3D it_tree_find(as->iova_tree, entry->iova,
> > +                                   entry->iova + entry->addr_mask);
> >       assert(hook_fn);
> > +
> > +    /* Update local IOVA mapped ranges */
> > +    if (entry->perm) {
> > +        if (mapped) {
> > +            /* Skip since we have already mapped this range */
> > +            trace_vtd_page_walk_one_skip_map(entry->iova, entry->add=
r_mask,
> > +                                             mapped->start, mapped->=
end);
> > +            return 0;
> > +        }
> > +        it_tree_insert(as->iova_tree, entry->iova,
> > +                       entry->iova + entry->addr_mask);
>=20
> I was consider a case e.g:
>=20
> 1) map A (iova) to B (pa)
> 2) invalidate A

Here to be more explicit you mean guest sends a PSI, not really
invalidation of the mapping.

> 3) map A (iova) to C (pa)
> 4) invalidate A

Here too.

>=20
> In this case, we will probably miss a walk here. But I'm not sure it wa=
s
> allowed by the spec (though I think so).

IMHO IOMMU page tables should not be modified by guest directly.  It
can be mapped, unmapped, but should not be modified directly.  I
suppose that's why Linux IOMMU API won't provide iommu_modify() but
only iommu_[un]map(), etc.. I don't know whether there is anything in
the spec, but AFAIU this can cause coherence issue on device side
since after step (1) device should be able to know the mapping
already, then modifying that mapping without UNMAP that on device side
will cause undefined behaviors.

Thanks,

--=20
Peter Xu

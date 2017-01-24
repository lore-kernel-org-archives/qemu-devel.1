Received: from eggs.gnu.org ([2001:4830:134:3::10]:41803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cW3tc-0000SN-NW
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:24:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cW3tX-0003QQ-P0
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:24:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cW3tX-0003QM-GA
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:24:31 -0500
Date: Tue, 24 Jan 2017 09:24:29 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170124092429.241a4eaf@t450s.home>
In-Reply-To: <20170124072215.GN26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-19-git-send-email-peterx@redhat.com>
	<490bbb84-213b-1b2a-5a1b-fa42a5c6a359@redhat.com>
	<20170122090425.GB26526@pxdev.xzpeter.org>
	<1dd223d1-dc02-bddc-02ea-78d267dd40a4@redhat.com>
	<20170123033429.GF26526@pxdev.xzpeter.org>
	<20170123110308.5d36ce87@t450s.home>
	<20170124072215.GN26526@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v4 18/20] intel_iommu: enable vfio
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org

On Tue, 24 Jan 2017 15:22:15 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Mon, Jan 23, 2017 at 11:03:08AM -0700, Alex Williamson wrote:
> > On Mon, 23 Jan 2017 11:34:29 +0800
> > Peter Xu <peterx@redhat.com> wrote:
> >  =20
> > > On Mon, Jan 23, 2017 at 09:55:39AM +0800, Jason Wang wrote: =20
> > > >=20
> > > >=20
> > > > On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 17:04, Peter Xu wrote:   =20
> > > > >On Sun, Jan 22, 2017 at 04:08:04PM +0800, Jason Wang wrote:
> > > > >
> > > > >[...]
> > > > >   =20
> > > > >>>+static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
> > > > >>>+                                           uint16_t domain_id, =
hwaddr addr,
> > > > >>>+                                           uint8_t am)
> > > > >>>+{
> > > > >>>+    IntelIOMMUNotifierNode *node;
> > > > >>>+    VTDContextEntry ce;
> > > > >>>+    int ret;
> > > > >>>+
> > > > >>>+    QLIST_FOREACH(node, &(s->notifiers_list), next) {
> > > > >>>+        VTDAddressSpace *vtd_as =3D node->vtd_as;
> > > > >>>+        ret =3D vtd_dev_to_context_entry(s, pci_bus_num(vtd_as-=
>bus),
> > > > >>>+                                       vtd_as->devfn, &ce);
> > > > >>>+        if (!ret && domain_id =3D=3D VTD_CONTEXT_ENTRY_DID(ce.h=
i)) {
> > > > >>>+            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAG=
E_SIZE,
> > > > >>>+                          vtd_page_invalidate_notify_hook,
> > > > >>>+                          (void *)&vtd_as->iommu, true);   =20
> > > > >>Why not simply trigger the notifier here? (or is this vfio requir=
ed?)   =20
> > > > >Because we may only want to notify part of the region - we are with
> > > > >mask here, but not exact size.
> > > > >
> > > > >Consider this: guest (with caching mode) maps 12K memory (4K*3 pag=
es),
> > > > >the mask will be extended to 16K in the guest. In that case, we ne=
ed
> > > > >to explicitly go over the page entry to know that the 4th page sho=
uld
> > > > >not be notified.   =20
> > > >=20
> > > > I see. Then it was required by vfio only, I think we can add a fast=
 path for
> > > > !CM in this case by triggering the notifier directly.   =20
> > >=20
> > > I noted this down (to be further investigated in my todo), but I don't
> > > know whether this can work, due to the fact that I think it is still
> > > legal that guest merge more than one PSIs into one. For example, I
> > > don't know whether below is legal:
> > >=20
> > > - guest invalidate page (0, 4k)
> > > - guest map new page (4k, 8k)
> > > - guest send single PSI of (0, 8k)
> > >=20
> > > In that case, it contains both map/unmap, and looks like it didn't
> > > disobay the spec as well? =20
> >=20
> > The topic of mapping and invalidation granularity also makes me
> > slightly concerned with the abstraction we use for the type1 IOMMU
> > backend.  With the "v2" type1 configuration we currently use in QEMU,
> > the user may only unmap with the same minimum granularity with which
> > the original mapping was created.  For instance if an iommu notifier
> > map request gets to vfio with an 8k range, the resulting mapping can
> > only be removed by an invalidation covering the full range.  Trying to
> > bisect that original mapping by only invalidating 4k of the range will
> > generate an error. =20
>=20
> I see. Then this will be an strict requirement that we cannot do
> coalescing during page walk, at least for mappings.
>=20
> I didn't notice this before, but luckily current series is following
> the rule above - we are basically doing the mapping in the unit of
> pages. Normally, we should always be mapping with 4K pages, only if
> guest provides huge pages in the VT-d page table, would we notify map
> with >4K, though of course it can be either 2M/1G but never other
> values.
>=20
> The point is, guest should be aware of the existance of the above huge
> pages, so it won't unmap (for example) a single 4k region within a 2M
> huge page range. It'll either keep the huge page, or unmap the whole
> huge page. In that sense, we are quite safe.
>=20
> (for my own curiousity and out of topic: could I ask why we can't do
>  that? e.g., we map 4K*2 pages, then we unmap the first 4K page?)

You understand why we can't do this in the hugepage case, right?  A
hugepage means that at least one entire level of the page table is
missing and that in order to unmap a subsection of it, we actually need
to replace it with a new page table level, which cannot be done
atomically relative to the rest of the PTEs in that entry.  Now what if
we don't assume that hugepages are only the Intel defined 2MB & 1GB?
AMD-Vi supports effectively arbitrary power of two page table entries.
So what if we've passed a 2x 4K mapping where the physical pages were
contiguous and vfio passed it as a direct 8K mapping to the IOMMU and
the IOMMU has native support for 8K mappings.  We're in a similar
scenario as the 2MB page, different page table layout though.

> > I would think (but please confirm), that when we're only tracking
> > mappings generated by the guest OS that this works.  If the guest OS
> > maps with 4k pages, we get map notifies for each of those 4k pages.  If
> > they use 2MB pages, we get 2MB ranges and invalidations will come in
> > the same granularity. =20
>=20
> I would agree (I haven't thought of a case that this might be a
> problem).
>=20
> >=20
> > An area of concern though is the replay mechanism in QEMU, I'll need to
> > look for it in the code, but replaying an IOMMU domain into a new
> > container *cannot* coalesce mappings or else it limits the granularity
> > with which we can later accept unmaps. Take for instance a guest that
> > has mapped a contiguous 2MB range with 4K pages.  They can unmap any 4K
> > page within that range.  However if vfio gets a single 2MB mapping
> > rather than 512 4K mappings, then the host IOMMU may use a hugepage
> > mapping where our granularity is now 2MB.  Thanks, =20
>=20
> Is this the answer of my above question (which is for my own
> curiosity)? If so, that'll kind of explain.
>=20
> If it's just because vfio is smart enough on automatically using huge
> pages when applicable (I believe it's for performance's sake), not
> sure whether we can introduce a ioctl() to setup the iova_pgsizes
> bitmap, as long as it is a subset of supported iova_pgsizes (from
> VFIO_IOMMU_GET_INFO) - then when people wants to get rid of above
> limitation, they can explicitly set the iova_pgsizes to only allow 4K
> pages.
>=20
> But, of course, this series can live well without it at least for now.

Yes, this is part of how vfio transparently makes use of hugepages in
the IOMMU, we effectively disregard the supported page sizes bitmap
(it's useless for anything other than determining the minimum page size
anyway), and instead pass through the largest range of iovas which are
physically contiguous.  The IOMMU driver can then make use of hugepages
where available.  The VFIO_IOMMU_MAP_DMA ioctl does include a flags
field where we could appropriate a bit to indicate map with minimum
granularity, but that would not be as simple as triggering the
disable_hugepages mapping path because the type1 driver would also need
to flag the internal vfio_dma as being bisectable, if not simply
converted to multiple vfio_dma structs internally.  Thanks,

Alex

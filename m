Received: from eggs.gnu.org ([2001:4830:134:3::10]:40531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVswa-0001a1-Cw
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cVswX-0001hI-8O
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:42:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cVswW-0001hC-WB
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 23:42:53 -0500
Date: Tue, 24 Jan 2017 12:42:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170124044248.GL26526@pxdev.xzpeter.org>
References: <1484917736-32056-1-git-send-email-peterx@redhat.com>
	<1484917736-32056-19-git-send-email-peterx@redhat.com>
	<490bbb84-213b-1b2a-5a1b-fa42a5c6a359@redhat.com>
	<20170122090425.GB26526@pxdev.xzpeter.org>
	<1dd223d1-dc02-bddc-02ea-78d267dd40a4@redhat.com>
	<20170123033429.GF26526@pxdev.xzpeter.org>
	<c3ec8e80-2d47-82c4-b38b-3cc487ea37c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3ec8e80-2d47-82c4-b38b-3cc487ea37c0@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, qemu-devel@nongnu.org, alex.williamson@redhat.com

On Mon, Jan 23, 2017 at 06:23:44PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8823=E6=97=A5 11:34, Peter Xu wrote:
> >On Mon, Jan 23, 2017 at 09:55:39AM +0800, Jason Wang wrote:
> >>
> >>On 2017=E5=B9=B401=E6=9C=8822=E6=97=A5 17:04, Peter Xu wrote:
> >>>On Sun, Jan 22, 2017 at 04:08:04PM +0800, Jason Wang wrote:
> >>>
> >>>[...]
> >>>
> >>>>>+static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
> >>>>>+                                           uint16_t domain_id, hw=
addr addr,
> >>>>>+                                           uint8_t am)
> >>>>>+{
> >>>>>+    IntelIOMMUNotifierNode *node;
> >>>>>+    VTDContextEntry ce;
> >>>>>+    int ret;
> >>>>>+
> >>>>>+    QLIST_FOREACH(node, &(s->notifiers_list), next) {
> >>>>>+        VTDAddressSpace *vtd_as =3D node->vtd_as;
> >>>>>+        ret =3D vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->b=
us),
> >>>>>+                                       vtd_as->devfn, &ce);
> >>>>>+        if (!ret && domain_id =3D=3D VTD_CONTEXT_ENTRY_DID(ce.hi)=
) {
> >>>>>+            vtd_page_walk(&ce, addr, addr + (1 << am) * VTD_PAGE_=
SIZE,
> >>>>>+                          vtd_page_invalidate_notify_hook,
> >>>>>+                          (void *)&vtd_as->iommu, true);
> >>>>Why not simply trigger the notifier here? (or is this vfio required=
?)
> >>>Because we may only want to notify part of the region - we are with
> >>>mask here, but not exact size.
> >>>
> >>>Consider this: guest (with caching mode) maps 12K memory (4K*3 pages=
),
> >>>the mask will be extended to 16K in the guest. In that case, we need
> >>>to explicitly go over the page entry to know that the 4th page shoul=
d
> >>>not be notified.
> >>I see. Then it was required by vfio only, I think we can add a fast p=
ath for
> >>!CM in this case by triggering the notifier directly.
> >I noted this down (to be further investigated in my todo), but I don't
> >know whether this can work, due to the fact that I think it is still
> >legal that guest merge more than one PSIs into one. For example, I
> >don't know whether below is legal:
> >
> >- guest invalidate page (0, 4k)
> >- guest map new page (4k, 8k)
> >- guest send single PSI of (0, 8k)
> >
> >In that case, it contains both map/unmap, and looks like it didn't
> >disobay the spec as well?
>=20
> Not sure I get your meaning, you mean just send single PSI instead of t=
wo?

Yes, and looks like that still doesn't violate the spec?

Actually for now, I think the best way to do with this series is that,
we can first let it in (so that advanced users can start to use it and
play with it). Then, we can get more feedback and solve critical
issues that may matter to customers and users.

For the above, I think per-page walk is the safest one for now. And I
can do investigate (as I mentioned) in the future to see whether we
can make it faster, according to your suggestion. However that'll be
nice we do it after we have some real use cases for this series, then
we can make sure the enhancement won't break anything besides boosting
the performance.

But of course I would like to listen to the maintainer's opinion on
this...

>=20
> >
> >>Another possible issue is, consider (with CM) a 16K contiguous iova w=
ith the
> >>last page has already been mapped. In this case, if we want to map fi=
rst
> >>three pages, when handling IOTLB invalidation, am would be 16K, then =
the
> >>last page will be mapped twice. Can this lead some issue?
> >I don't know whether guest has special handling of this kind of
> >request.
>=20
> This seems quite usual I think? E.g iommu_flush_iotlb_psi() did:
>=20
> static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>                   struct dmar_domain *domain,
>                   unsigned long pfn, unsigned int pages,
>                   int ih, int map)
> {
>     unsigned int mask =3D ilog2(__roundup_pow_of_two(pages));
>     uint64_t addr =3D (uint64_t)pfn << VTD_PAGE_SHIFT;
>     u16 did =3D domain->iommu_did[iommu->seq_id];
> ...

Yes, do rounding up should be the only thing to do when we have
unaligned size.

>=20
>=20
> >
> >Besides, imho to completely solve this problem, we still need that
> >per-domain tree. Considering that currently the tree is inside vfio, I
> >see this not a big issue as well.
>=20
> Another issue I found is: with this series, VFIO_IOMMU_MAP_DMA seems be=
come
> guest trigger-able. And since VFIO allocate its own structure to record=
 dma
> mapping, this seems open a window for evil guest to exhaust host memory
> which is even worse.

(I see Alex replied in another email, so will skip this one)

>=20
> >  In that case, the last page mapping
> >request will fail (we might see one error line from QEMU stderr),
> >however that'll not affect too much since currently vfio allows that
> >failure to happen (ioctl fail, but that page is still mapped, which is
> >what we wanted).
>=20
> Works but sub-optimal or maybe even buggy.

Again, to finally solve this, I think we need a tree. But I don't
think that's a good idea for this series, considering that we have
already had one in the kernel. But I see this issue not a critical
blocker (if you won't disagree) since it should work for our goal,
which is either nested device assignment, or dpdk applications in
general.

I think users' feedback is really important for this series. So again,
I'll request that we postpone some issues as todo, rather than solving
all of them in this series before merge.

>=20
> >
> >(But of course above error message can be used by an in-guest attacker
> >  as well just like general error_report() issues reported before,
> >  though again I will appreciate if we can have this series
> >  functionally work first :)
> >
> >And, I should be able to emulate this behavior in guest with a tiny C
> >program to make sure of it, possibly after this series if allowed.
>=20
> Or through your vtd unittest :) ?

Yes, or easier, just write a program in guest running Linux, sends
VFIO_IOMMU_DMA_MAP ioctl()s correspondingly.

Thanks,

-- peterx

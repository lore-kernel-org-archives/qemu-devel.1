Received: from eggs.gnu.org ([2001:4830:134:3::10]:46586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cTlt5-000237-DW
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cTlt3-0005pa-0D
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:46:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cTlt2-0005oV-Nf
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 03:46:32 -0500
Date: Wed, 18 Jan 2017 16:46:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170118084627.GT30108@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-15-git-send-email-peterx@redhat.com>
	<fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
	<20170116091801.GL30108@pxdev.xzpeter.org>
	<0eedf780-16b2-ca5c-8eea-5d41e6837f23@redhat.com>
	<20170117144514.GO30108@pxdev.xzpeter.org>
	<99e185dc-e3c9-678f-7a69-fc006658d07f@redhat.com>
	<20170118081137.GS30108@pxdev.xzpeter.org>
	<f89c8ad4-a95d-bf66-33c6-f151531c2174@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f89c8ad4-a95d-bf66-33c6-f151531c2174@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vfio
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
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, alex.williamson@redhat.com, bd.aviv@gmail.com

On Wed, Jan 18, 2017 at 04:36:05PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B401=E6=9C=8818=E6=97=A5 16:11, Peter Xu wrote:
> >On Wed, Jan 18, 2017 at 11:10:53AM +0800, Jason Wang wrote:
> >>
> >>On 2017=E5=B9=B401=E6=9C=8817=E6=97=A5 22:45, Peter Xu wrote:
> >>>On Mon, Jan 16, 2017 at 05:54:55PM +0800, Jason Wang wrote:
> >>>>On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 17:18, Peter Xu wrote:
> >>>>>>>  static void vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint=
16_t domain_id,
> >>>>>>>                                        hwaddr addr, uint8_t am)
> >>>>>>>  {
> >>>>>>>@@ -1222,6 +1251,7 @@ static void vtd_iotlb_page_invalidate(Inte=
lIOMMUState *s, uint16_t domain_id,
> >>>>>>>      info.addr =3D addr;
> >>>>>>>      info.mask =3D ~((1 << am) - 1);
> >>>>>>>      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_p=
age, &info);
> >>>>>>>+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am);
> >>>>>>Is the case of GLOBAL or DSI flush missed, or we don't care it at=
 all?
> >>>>>IMHO we don't. For device assignment, since we are having CM=3D1 h=
ere,
> >>>>>we should have explicit page invalidations even if guest sends
> >>>>>global/domain invalidations.
> >>>>>
> >>>>>Thanks,
> >>>>>
> >>>>>-- peterx
> >>>>Is this spec required?
> >>>I think not. IMO the spec is very coarse grained on describing cache
> >>>mode...
> >>>
> >>>>Btw, it looks to me that both DSI and GLOBAL are
> >>>>indeed explicit flush.
> >>>Actually when cache mode is on, it is unclear to me on how we should
> >>>treat domain/global invalidations, at least from the spec (as
> >>>mentioned earlier). My understanding is that they are not "explicit
> >>>flushes", which IMHO should only mean page selective IOTLB
> >>>invalidations.
> >>Probably not, at least from the view of performance. DSI and global s=
hould
> >>be more efficient in some cases.
> >I agree with you that DSI/GLOBAL flushes are more efficient in some
> >way. But IMHO that does not mean these invalidations are "explicit
> >invalidations", and I suspect whether cache mode has to coop with it.
>=20
> Well, the spec does not forbid DSI/GLOBAL with CM and the driver codes =
had
> used them for almost ten years. I can hardly believe it's wrong.

I think we have misunderstanding here. :)

I never thought we should not send DSI/GLOBAL invalidations with cache
mode. I just think we should not do anything special even if we have
cache mode on when we receive these signals.

In the spec, "explicit invalidation" is mentioned in the cache mode
chapter:

    The Caching Mode (CM) field in Capability Register indicates if
    the hardware implementation caches not-present or erroneous
    translation-structure entries. When the CM field is reported as
    Set, any software updates to any remapping structures (including
    updates to not-present entries or present entries whose
    programming resulted in translation faults) requires explicit
    invalidation of the caches.

And I thought we were discussion about "what is explicit invalidation"
mentioned above.

>=20
> >
> >But here I should add one more thing besides PSI - context entry
> >invalidation should be one of "the explicit invalidations" as well,
> >which we need to handle just like PSI when cache mode is on.
> >
> >>>>Just have a quick go through on driver codes and find this somethin=
g
> >>>>interesting in intel_iommu_flush_iotlb_psi():
> >>>>
> >>>>...
> >>>>     /*
> >>>>      * Fallback to domain selective flush if no PSI support or the=
 size is
> >>>>      * too big.
> >>>>      * PSI requires page size to be 2 ^ x, and the base address is=
 naturally
> >>>>      * aligned to the size
> >>>>      */
> >>>>     if (!cap_pgsel_inv(iommu->cap) || mask > cap_max_amask_val(iom=
mu->cap))
> >>>>         iommu->flush.flush_iotlb(iommu, did, 0, 0,
> >>>>                         DMA_TLB_DSI_FLUSH);
> >>>>     else
> >>>>         iommu->flush.flush_iotlb(iommu, did, addr | ih, mask,
> >>>>                         DMA_TLB_PSI_FLUSH);
> >>>>...
> >>>I think this is interesting... and I doubt its correctness while wit=
h
> >>>cache mode enabled.
> >>>
> >>>If so (sending domain invalidation instead of a big range of page
> >>>invalidations), how should we capture which pages are unmapped in
> >>>emulated IOMMU?
> >>We don't need to track individual pages here, since all pages for a s=
pecific
> >>domain were unmapped I believe?
> >IMHO this might not be the correct behavior.
> >
> >If we receive one domain specific invalidation, I agree that we should
> >invalidate the IOTLB cache for all the devices inside the domain.
> >However, when cache mode is on, we should be depending on the PSIs to
> >unmap each page (unless we want to unmap the whole address space, in
> >this case it's very possible that the guest is just unmapping a range,
> >not the entire space). If we convert several PSIs into one big DSI,
> >IMHO we will leave those pages mapped/unmapped while we should
> >unmap/map them.
>=20
> Confused, do you have an example for this? (I fail to understand why DS=
I
> can't work, at least implementation can convert DSI to several PSIs
> internally).

That's how I understand it. It might be wrong. Btw, could you
elaborate a bit on how can we convert a DSI into several PSIs?

Thanks,

-- peterx

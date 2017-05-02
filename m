Received: from eggs.gnu.org ([2001:4830:134:3::10]:55096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d5aXw-0002n7-Fv
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1d5aXv-0008Uv-Dj
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:21:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1d5aXv-0008U4-3b
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:21:03 -0400
Date: Tue, 2 May 2017 19:20:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170502191711-mutt-send-email-mst@kernel.org>
References: <52559520-f311-71de-a849-cac83d0c0e81@redhat.com>
	<CAMJs5B_LjRzvGrHGGUVtdGurjKPgg7_KOrvYAwmgpYXh2Qab8w@mail.gmail.com>
	<04a1dd2e-737c-3cb0-6cd8-71a783f463c8@redhat.com>
	<CAMJs5B-jdS+pWO+BEBAoprB+yRuRiWJWDewA96caniXXVK22kQ@mail.gmail.com>
	<20170502181234-mutt-send-email-mst@kernel.org>
	<0d310113-af68-2154-8dd3-a00b0c9a76ed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d310113-af68-2154-8dd3-a00b0c9a76ed@arm.com>
Subject: Re: [Qemu-devel] userspace emulated smmu/vfio integration: how to
 trap updates to the table structures?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Auger Eric <eric.auger@redhat.com>, Christoffer Dall <cdall@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Jean-Philippe Brucker <Jean-Philippe.Brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org

On Tue, May 02, 2017 at 04:42:56PM +0100, Robin Murphy wrote:
> On 02/05/17 16:22, Michael S. Tsirkin wrote:
> > On Tue, May 02, 2017 at 10:17:26AM +0200, Christoffer Dall wrote:
> >> On Tue, May 2, 2017 at 10:13 AM, Auger Eric <eric.auger@redhat.com> wrote:
> >>> Hi Christoffer,
> >>>
> >>> On 02/05/2017 09:53, Christoffer Dall wrote:
> >>>> On Tue, May 2, 2017 at 9:30 AM, Auger Eric <eric.auger@redhat.com> wrote:
> >>>>> Hi Will, Robin, Jean-Philippe,
> >>>>>
> >>>>> I have been working on the integration between user-space emulated
> >>>>> SMMU-v3 and VFIO in QEMU. At the moment I fail identifying a proper easy
> >>>>> way to trap page table updates. This is requested to keep the host
> >>>>> translation structures consistent to guest translation structures.
> >>>>>
> >>>>> On Intel VTD there is a so-called "caching mode" (CM, see VTD spec
> >>>>> paragraph 6.1) that forces the OS to explicitly invalidate caches
> >>>>> whenever it updates any remapping structure (updates to not-present or
> >>>>> present entries). Those invalidation commands are used to trap and
> >>>>> update host structures. This mode was devised for virtualization. I was
> >>>>> not able to find such "caching mode" on ARM SMMU. Is there any?
> >>>>>
> >>>>> If not, do you have any other suggestion, I mean, besides the
> >>>>> virtio-based solution.
> >>>>>
> >>>>>
> >>>> Worst case, can you make the guest page tables read-only and catch the
> >>>> faults and propagate changes to SMMU translations?
> >>>
> >>> The issue I foresee is there are up to 4 level of page tables to trap.
> >>> This would lead to plenty of regions to "translate" on qemu side. Also,
> >>> besides the 1st level pointed by TTBR found in stage 1 context
> >>> descriptor, other page regions would be discovered dynamically as
> >>> mapping are built. To me this is the last resort solution if confirmed
> >>> feasible.
> >>>
> >> Completely agree, it would be a terrible solution.
> >>
> >> Thanks,
> >> -Christoffer
> > 
> > All "caching mode" is is simple a bit that the IOMMU device uses to tell
> > the OS "I might cache non-present/invalid entries, please use
> > invalidation even if you make non-present entries present".
> > 
> > So all we need from ARM is bit somewhere in one of MMU registers
> > and a promise not to use it for any other purpose preferably
> > by documenting it as caching mode bit in the next manual version.
> > 
> > Any chance of this happening?
> 
> It's unlikely as such, since the VMSAv8 translation formats which the
> SMMU architecture specifies explicitly forbid such "negative caching",
> so having an architected bit to say "I don't comply with the
> architecture" comes out looking a little nonsensical.

Same's true for AMD/intel IOMMUs FWIW.

> However, doing the same via a firmware quirk would seem a lot more
> reasonable. The io-pgtable code already has the IO_PGTABLE_TLBI_ON_MAP
> quirk to cope with other not-quite-VMSA IOMMU implementations which do
> cache invalid entries - supporting that in the io-pgtable-arm backend
> (currently only the v7s backend implements it), then having the SMMUv3
> driver detect the QEMU implementation and set that quirk on pagetables
> accordingly would end up achieving the same thing.
> 
> Robin.

Without a spec specifying it, it does however mean that non-Linux
guests aren't likely to implement this in the same way.

-- 
MST

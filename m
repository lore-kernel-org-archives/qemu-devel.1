Received: from eggs.gnu.org ([2001:4830:134:3::10]:41132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fk9dQ-0006RG-I3
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fk9dM-0003jy-FW
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:58:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36008 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fk9dM-0003jr-7u
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:58:52 -0400
Date: Mon, 30 Jul 2018 17:58:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180730175154-mutt-send-email-mst@kernel.org>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180730163123-mutt-send-email-mst@kernel.org>
	<57aca548-b6f3-eae3-3b2e-a25523294a7d@redhat.com>
	<20180730165720-mutt-send-email-mst@kernel.org>
	<9700e54a-14c2-4051-b54e-d9580df2c854@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9700e54a-14c2-4051-b54e-d9580df2c854@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Mon, Jul 30, 2018 at 04:46:25PM +0200, David Hildenbrand wrote:
> On 30.07.2018 15:59, Michael S. Tsirkin wrote:
> > On Mon, Jul 30, 2018 at 03:54:04PM +0200, David Hildenbrand wrote:
> >> On 30.07.2018 15:34, Michael S. Tsirkin wrote:
> >>> On Tue, Jul 17, 2018 at 04:47:31PM -0600, Alex Williamson wrote:
> >>>> Directly assigned vfio devices have never been compatible with
> >>>> ballooning.  Zapping MADV_DONTNEED pages happens completely
> >>>> independent of vfio page pinning and IOMMU mapping, leaving us with
> >>>> inconsistent GPA to HPA mapping between vCPUs and assigned devices
> >>>> when the balloon deflates.  Mediated devices can theoretically do
> >>>> better, if we make the assumption that the mdev vendor driver is fully
> >>>> synchronized to the actual working set of the guest driver.  In that
> >>>> case the guest balloon driver should never be able to allocate an mdev
> >>>> pinned page for balloon inflation.  Unfortunately, QEMU can't know the
> >>>> workings of the vendor driver pinning, and doesn't actually know the
> >>>> difference between mdev devices and directly assigned devices.  Until
> >>>> we can sort out how the vfio IOMMU backend can tell us if ballooning
> >>>> is safe, the best approach is to disabling ballooning any time a vfio
> >>>> devices is attached.
> >>>>
> >>>> To do that, simply make the balloon inhibitor a counter rather than a
> >>>> boolean, fixup a case where KVM can then simply use the inhibit
> >>>> interface, and inhibit ballooning any time a vfio device is attached.
> >>>> I'm expecting we'll expose some sort of flag similar to
> >>>> KVM_CAP_SYNC_MMU from the vfio IOMMU for cases where we can resolve
> >>>> this.  An addition we could consider here would be yet another device
> >>>> option for vfio, such as x-disable-balloon-inhibit, in case there are
> >>>> mdev devices that behave in a manner compatible with ballooning.
> >>>>
> >>>> Please let me know if this looks like a good idea.  Thanks,
> >>>>
> >>>> Alex
> >>>
> >>> It's probably the only a reasonable thing to do for this release.
> >>>
> >>> Long term however, why can't balloon notify vfio as pages are
> >>> added and removed? VFIO could update its mappings then.
> >>
> >> What if the guest is rebooted and pages are silently getting reused
> >> without getting a deflation request first?
> > 
> > Good point. To handle we'd need to deflate fully on
> > on device reset, allowing access to all memory again.
> 
> 1. Doing it from the guest: not reliable. E.g. think about crashes +
> reboots, or a plain "system_reset" in QEMU. Deflation is definetly not
> reliably possible.
> 
> 2. Doing it in QEMU balloon implementation. Not possible. We don't track
> the memory that has been inflated (and also should not do it).
>
> So the only thing we could do is "deflate all guest memory" which
> implies a madvise WILLNEED on all guest memory. We definitely don't want
> this. We could inform vfio about all guest memory.

Exactly. No need to track anything we just need QEMU to allow access to
all guest memory.

> Everything sounds like a big hack that should be handled internally in
> the kernel.

What exactly do you want the kernel to do?

> -- 
> 
> Thanks,
> 
> David / dhildenb

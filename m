Received: from eggs.gnu.org ([2001:4830:134:3::10]:36179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fk9L8-0006hS-MU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fk9L5-0004Qk-GD
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:40:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fk9L5-0004QO-6x
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 10:39:59 -0400
Date: Mon, 30 Jul 2018 08:39:39 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180730083939.23f3b9cc@t450s.home>
In-Reply-To: <20180730163123-mutt-send-email-mst@kernel.org>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180730163123-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Mon, 30 Jul 2018 16:34:09 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jul 17, 2018 at 04:47:31PM -0600, Alex Williamson wrote:
> > Directly assigned vfio devices have never been compatible with
> > ballooning.  Zapping MADV_DONTNEED pages happens completely
> > independent of vfio page pinning and IOMMU mapping, leaving us with
> > inconsistent GPA to HPA mapping between vCPUs and assigned devices
> > when the balloon deflates.  Mediated devices can theoretically do
> > better, if we make the assumption that the mdev vendor driver is fully
> > synchronized to the actual working set of the guest driver.  In that
> > case the guest balloon driver should never be able to allocate an mdev
> > pinned page for balloon inflation.  Unfortunately, QEMU can't know the
> > workings of the vendor driver pinning, and doesn't actually know the
> > difference between mdev devices and directly assigned devices.  Until
> > we can sort out how the vfio IOMMU backend can tell us if ballooning
> > is safe, the best approach is to disabling ballooning any time a vfio
> > devices is attached.
> > 
> > To do that, simply make the balloon inhibitor a counter rather than a
> > boolean, fixup a case where KVM can then simply use the inhibit
> > interface, and inhibit ballooning any time a vfio device is attached.
> > I'm expecting we'll expose some sort of flag similar to
> > KVM_CAP_SYNC_MMU from the vfio IOMMU for cases where we can resolve
> > this.  An addition we could consider here would be yet another device
> > option for vfio, such as x-disable-balloon-inhibit, in case there are
> > mdev devices that behave in a manner compatible with ballooning.
> > 
> > Please let me know if this looks like a good idea.  Thanks,
> > 
> > Alex  
> 
> It's probably the only a reasonable thing to do for this release.
> 
> Long term however, why can't balloon notify vfio as pages are
> added and removed? VFIO could update its mappings then.

Are you thinking of a notifier outside of the memory API or updating
the memory API to reflect the current ballooning state?  In the former
case, we don't have page level granularity for mapping and un-mapping.
We could invent a mechanism for userspace to specify page granularity
mapping to the vfio kernel module, but that incurs a cost at the
hardware and host level with poor IOTLB efficiency and excessive page
tables.  Additionally, how would a notifier approach handle hot-added
devices, is the notifier replayed for each added device?  This starts
to sound more like the existing functionality of the memory API.

If we go through the memory API then we also don't really have page
level granularity, removing a page from a SubRegion will remove the
entire region and add back the remaining SubRegion(s).  This is more
compatible with the IOMMU mappings, but I don't think it can be done
atomically with respect to inflight DMA of a physical device where we
cannot halt the device without interfering with its state.  Thanks,

Alex

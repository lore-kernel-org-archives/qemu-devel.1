Received: from eggs.gnu.org ([2001:4830:134:3::10]:45248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffgG1-0002iY-3B
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 02:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ffgFx-0001Dd-W8
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 02:48:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ffgFx-0001CM-PI
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 02:48:13 -0400
Date: Wed, 18 Jul 2018 14:48:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180718064803.GA6197@xz-mi>
References: <20180717222721.14019.27548.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717222721.14019.27548.stgit@gimli.home>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org

On Tue, Jul 17, 2018 at 04:47:31PM -0600, Alex Williamson wrote:
> Directly assigned vfio devices have never been compatible with
> ballooning.  Zapping MADV_DONTNEED pages happens completely
> independent of vfio page pinning and IOMMU mapping, leaving us with
> inconsistent GPA to HPA mapping between vCPUs and assigned devices
> when the balloon deflates.  Mediated devices can theoretically do
> better, if we make the assumption that the mdev vendor driver is fully
> synchronized to the actual working set of the guest driver.  In that
> case the guest balloon driver should never be able to allocate an mdev
> pinned page for balloon inflation.  Unfortunately, QEMU can't know the
> workings of the vendor driver pinning, and doesn't actually know the
> difference between mdev devices and directly assigned devices.  Until
> we can sort out how the vfio IOMMU backend can tell us if ballooning
> is safe, the best approach is to disabling ballooning any time a vfio
> devices is attached.
> 
> To do that, simply make the balloon inhibitor a counter rather than a
> boolean, fixup a case where KVM can then simply use the inhibit
> interface, and inhibit ballooning any time a vfio device is attached.
> I'm expecting we'll expose some sort of flag similar to
> KVM_CAP_SYNC_MMU from the vfio IOMMU for cases where we can resolve
> this.  An addition we could consider here would be yet another device
> option for vfio, such as x-disable-balloon-inhibit, in case there are
> mdev devices that behave in a manner compatible with ballooning.
> 
> Please let me know if this looks like a good idea.  Thanks,

IMHO patches 1-2 are good cleanup as standalone patches...

I totally have no idea on whether people would like to use vfio-pci
and the balloon device at the same time.  After all vfio-pci are
majorly for performance players, then I would vaguely guess that they
don't really care thin provisioning of memory at all, hence the usage
scenario might not exist much.  Is that the major reason that we'd
just like to disable it (which makes sense to me)?

I'm wondering what if want to do that somehow some day... Whether
it'll work if we just let vfio-pci devices to register some guest
memory invalidation hook (just like the iommu notifiers, but for guest
memory address space instead), then we map/unmap the IOMMU pages there
for vfio-pci device to make sure the inflated balloon pages are not
mapped and also make sure new pages are remapped with correct HPA
after deflated.  This is a pure question out of my curiosity, and for
sure it makes little sense if the answer of the first question above
is positive.

Thanks,

-- 
Peter Xu

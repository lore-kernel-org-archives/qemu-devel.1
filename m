Received: from eggs.gnu.org ([2001:4830:134:3::10]:33960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnFJ6-0000zB-FI
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 23:38:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnFJ1-00033I-H1
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 23:38:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fnFJ1-000330-A9
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 23:38:39 -0400
Date: Wed, 8 Aug 2018 11:38:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180808033828.GB24415@xz-mi>
References: <20180807193125.30378-1-alex.williamson@redhat.com>
	<20180807193125.30378-4-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180807193125.30378-4-alex.williamson@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/4] vfio: Inhibit ballooning based on
 group attachment to a container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, david@redhat.com

On Tue, Aug 07, 2018 at 01:31:24PM -0600, Alex Williamson wrote:
> We use a VFIOContainer to associate an AddressSpace to one or more
> VFIOGroups.  The VFIOContainer represents the DMA context for that
> AdressSpace for those VFIOGroups and is synchronized to changes in
> that AddressSpace via a MemoryListener.  For IOMMU backed devices,
> maintaining the DMA context for a VFIOGroup generally involves
> pinning a host virtual address in order to create a stable host
> physical address and then mapping a translation from the associated
> guest physical address to that host physical address into the IOMMU.
> 
> While the above maintains the VFIOContainer synchronized to the QEMU
> memory API of the VM, memory ballooning occurs outside of that API.
> Inflating the memory balloon (ie. cooperatively capturing pages from
> the guest for use by the host) simply uses MADV_DONTNEED to "zap"
> pages from QEMU's host virtual address space.  The page pinning and
> IOMMU mapping above remains in place, negating the host's ability to
> reuse the page, but the host virtual to host physical mapping of the
> page is invalidated outside of QEMU's memory API.
> 
> When the balloon is later deflated, attempting to cooperatively
> return pages to the guest, the page is simply freed by the guest
> balloon driver, allowing it to be used in the guest and incurring a
> page fault when that occurs.  The page fault maps a new host physical
> page backing the existing host virtual address, meanwhile the
> VFIOContainer still maintains the translation to the original host
> physical address.  At this point the guest vCPU and any assigned
> devices will map different host physical addresses to the same guest
> physical address.  Badness.
> 
> The IOMMU typically does not have page level granularity with which
> it can track this mapping without also incurring inefficiencies in
> using page size mappings throughout.  MMU notifiers in the host
> kernel also provide indicators for invalidating the mapping on
> balloon inflation, not for updating the mapping when the balloon is
> deflated.  For these reasons we assume a default behavior that the
> mapping of each VFIOGroup into the VFIOContainer is incompatible
> with memory ballooning and increment the balloon inhibitor to match
> the attached VFIOGroups.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

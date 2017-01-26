Received: from eggs.gnu.org ([2001:4830:134:3::10]:38045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cWeEr-00089s-2X
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 02:12:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cWeEn-0005mi-Tj
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 02:12:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cWeEn-0005lA-Nm
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 02:12:53 -0500
Date: Thu, 26 Jan 2017 15:12:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170126071244.GJ5151@pxdev.xzpeter.org>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-3-git-send-email-peterx@redhat.com>
	<20170124092905.41832531@t450s.home>
	<9ef03816-0bef-f54b-63fe-daf27eab4a40@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ef03816-0bef-f54b-63fe-daf27eab4a40@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/18] vfio: introduce vfio_get_vaddr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, qemu-devel@nongnu.org, bd.aviv@gmail.com

On Wed, Jan 25, 2017 at 06:11:37PM +0100, Paolo Bonzini wrote:

[...]

> > The comment from v4 still needs input from Paolo, is it valid to make
> > use of vaddr (based on address_space_translate ->
> > memory_region_get_ram_ptr) outside of the rcu read lock or could future
> > BQL reduction efforts allow this to race?
> 
> You need to keep a reference to the MemoryRegion if you do
> rcu_read_unlock.  But it's simpler to call vfio_get_vaddr within
> rcu_read_lock, and keep the lock/unlock in vfio_iommu_map_notify.
> 
> You probably should also put a comment about why VFIO does *not* need to
> keep a reference between vfio_dma_map and vfio_dma_unmap (which doesn't
> sound easy to do either).

How about this one?

    /*
     * Here, we need to have the lock not only for vfio_get_vaddr(),
     * but also needs to make sure that the vaddr will be valid for
     * further operations.
     *
     * When we map new pages, we need the lock to make sure that vaddr
     * is valid along the way we build up the IO page table (via
     * vfio_dma_map()). Then, as long as the mapping is set up, we can
     * unlock since those pages will be pinned in kernel (which makes
     * sure that the RAM backend of vaddr will always be there, even
     * if the memory object is destroyed and RAM released).
     *
     * For unmapping case, we don't really need the protection since
     * the pages are in all cases locked in kernel, so we'll probably
     * be safe even without the lock. However, it won't hurt we have
     * the lock as well here.
     */

Thanks,

-- peterx

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cWdWS-00042J-9v
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 01:27:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cWdWN-0002rr-CK
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 01:27:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cWdWN-0002ra-6W
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 01:26:59 -0500
Date: Thu, 26 Jan 2017 14:26:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170126062648.GH5151@pxdev.xzpeter.org>
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-3-git-send-email-peterx@redhat.com>
	<20170124092905.41832531@t450s.home>
	<20170125043221.GD5151@pxdev.xzpeter.org>
	<20170125094317.4298966e@t450s.home>
	<5eb1e617-5dec-0826-e683-fd4a6c03af03@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5eb1e617-5dec-0826-e683-fd4a6c03af03@redhat.com>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com

On Wed, Jan 25, 2017 at 06:16:44PM +0100, Paolo Bonzini wrote:
> 
> 
> On 25/01/2017 17:43, Alex Williamson wrote:
> > On Wed, 25 Jan 2017 12:32:21 +0800
> > Peter Xu <peterx@redhat.com> wrote:
> >> I have similar question as well above - IIUC the RCU read lock
> >> protects us from not losing the references of memory objects, however
> >> in our case even after we release the lock, we are still using the
> >> backend ram (vaddr) since we have set it up inside kernel to build up
> >> the IO page table. After that, the kernel/device should be able to
> >> write to addresses of that backend ram any time.
> 
> I don't think that's what happens.  As far as I understand, VFIO pins
> the pages corresponding to vaddr, not vaddr itself.  The memory backend
> is mmap-ed memory; when you hot-unplug it the munmap releases the VMA
> and loses the connection between QEMU's virtual address space and the
> pages.  However, the pages stay pinned and stay mapped into VFIO's own
> IOMMU page tables.
> 
> So if a guest does a memory hot-unplug without IOMMU unmap, it would
> keep on seeing the content of the hot-unplugged memory, and the host
> could not release the pages, but the guest cannot overwrite QEMU data
> structures.

Sounds reasonable. I forgot that these pages are pinned if without an
explicit unmap.

Thanks Paolo. :)

-- peterx

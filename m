Received: from eggs.gnu.org ([2001:4830:134:3::10]:53034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWhiF-0000FU-LV
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:55:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWhiC-0000gZ-IN
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:55:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWhiC-0000fC-Ct
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:55:28 -0500
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-3-git-send-email-peterx@redhat.com>
	<20170124092905.41832531@t450s.home>
	<9ef03816-0bef-f54b-63fe-daf27eab4a40@redhat.com>
	<20170126071244.GJ5151@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11032fa7-1e5f-dac6-f0d8-56b41121361b@redhat.com>
Date: Thu, 26 Jan 2017 11:55:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170126071244.GJ5151@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 02/18] vfio: introduce vfio_get_vaddr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, qemu-devel@nongnu.org, bd.aviv@gmail.com



On 26/01/2017 08:12, Peter Xu wrote:
> 
>     /*
>      * Here, we need to have the lock not only for vfio_get_vaddr(),
>      * but also needs to make sure that the vaddr will be valid for
>      * further operations.
>      *
>      * When we map new pages, we need the lock to make sure that vaddr
>      * is valid along the way we build up the IO page table (via
>      * vfio_dma_map()). Then, as long as the mapping is set up, we can
>      * unlock since those pages will be pinned in kernel (which makes
>      * sure that the RAM backend of vaddr will always be there, even
>      * if the memory object is destroyed and RAM released).
>      *
>      * For unmapping case, we don't really need the protection since
>      * the pages are in all cases locked in kernel, so we'll probably
>      * be safe even without the lock. However, it won't hurt we have
>      * the lock as well here.
>      */

Even simpler, just before the definition of vfio_get_vaddr:

/* Called with rcu_read_lock held.  */

and just before the vfio_dma_map call:

    /* vaddr is only valid until rcu_read_unlock().  But after
     * vfio_dma_map has set up the mapping the pages will be pinned
     * by the kernel.  This makes sure that the RAM backend of vaddr
     * will always be there, even if the memory object is destroyed
     * and its backing memory munmap-ed.
     */

I'm not sure that you can get rid of the lock for the unmapping case.
Better remove that part of the comment.

Thanks,

Paolo

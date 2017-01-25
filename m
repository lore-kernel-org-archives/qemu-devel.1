Received: from eggs.gnu.org ([2001:4830:134:3::10]:49620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWTSe-0003CK-KK
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:42:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cWTSb-0002WM-Ff
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:42:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cWTSb-0002W8-9f
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 14:42:25 -0500
References: <1485253571-19058-1-git-send-email-peterx@redhat.com>
	<1485253571-19058-3-git-send-email-peterx@redhat.com>
	<20170124092905.41832531@t450s.home>
	<9ef03816-0bef-f54b-63fe-daf27eab4a40@redhat.com>
	<20170125103642.5f4232a9@t450s.home>
	<1ae1a5a1-2617-1862-ea1d-53f1383516d8@redhat.com>
	<20170125113602.1ee76196@t450s.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <da6d0ae9-a26b-a568-209b-fa2c94c62563@redhat.com>
Date: Wed, 25 Jan 2017 20:42:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170125113602.1ee76196@t450s.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, qemu-devel@nongnu.org, bd.aviv@gmail.com



On 25/01/2017 19:36, Alex Williamson wrote:
>> It depends of what happens if they aren't.  I think it's fine (see other
>> message), but taking a reference for each mapping entry isn't so easy
>> because the unmap case doesn't know the old memory region.
> If we held a reference to the memory region from the mapping path and
> walk the IOMMU page table to generate the unmap, then we really should
> get to the same original memory region, right?  The vfio iommu notifier
> should only be mapping native page sizes of the IOMMU, 4k/2M/1G.  The
> problem is that it's a lot of overhead to flush the entire address
> space that way vs the single invalidation Peter is trying to enable
> here.  It's actually similar to how the type1 iommu works in the kernel
> though, we can unmap by iova because we ask the iommu for the iova->pfn
> translation in order to unpin the page.

But in the kernel you can trust the IOMMU page tables because you build
them, here instead it's the guest's page tables that you'd walk, right?
You cannot trust the guest.

Paolo

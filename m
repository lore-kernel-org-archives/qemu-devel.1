Received: from eggs.gnu.org ([2001:4830:134:3::10]:44848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8feA-00070g-DR
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f8fe5-0007Hh-Ge
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:28:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f8fe5-0007HM-Ca
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 01:28:41 -0400
Date: Wed, 18 Apr 2018 13:28:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180418052822.GA14841@xz-mi>
References: <20180418045121.14233-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180418045121.14233-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] intel-iommu: send PSI always when
 notify_unmap set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Alexander Witte <alexander.witte@baicanada.com>, Jintack Lim <jintack@cs.columbia.edu>

On Wed, Apr 18, 2018 at 12:51:21PM +0800, Peter Xu wrote:
> During IOVA page table walk, there is a special case when:
> 
> - notify_unmap is set, meanwhile
> - entry is invalid
> 
> In the past, we skip the entry always.  This is not correct.  We should
> send UNMAP notification to registered notifiers in this case.  Otherwise
> some stall pages will still be mapped in the host even if L1 guest
> unmapped them already.
> 
> Without this patch, nested device assignment to L2 guests might dump
> some errors like:
> 
> qemu-system-x86_64: VFIO_MAP_DMA: -17
> qemu-system-x86_64: vfio_dma_map(0x557305420c30, 0xad000, 0x1000,
>                     0x7f89a920d000) = -17 (File exists)
> 
> To fix this, we need to apply this patch to L1 QEMU (L2 QEMU is not
> affected by this problem).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

This should really be 2.12 material, it fixes a real bug, but not sure
whether it's too late already.  Michael, what do you think?

Thanks,

-- 
Peter Xu

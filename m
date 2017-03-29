Received: from eggs.gnu.org ([2001:4830:134:3::10]:48993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ct7hZ-0008NB-IE
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 03:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ct7hW-0001KV-1E
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 03:07:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ct7hV-0001Jv-Qw
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 03:07:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12AB676F4
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 07:07:24 +0000 (UTC)
References: <1490760604-9756-1-git-send-email-jasowang@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <e238cbe4-a626-02be-1601-fde20285453f@redhat.com>
Date: Wed, 29 Mar 2017 09:07:18 +0200
MIME-Version: 1.0
In-Reply-To: <1490760604-9756-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.9] vhost: generalize iommu memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>



On 03/29/2017 06:10 AM, Jason Wang wrote:
> We assumes the iommu_ops were attached to the root region of address
> space. This may not be true for all kinds of IOMMU implementation and
> especially after commit 3716d5902d74 ("pci: introduce a bus master
> container"). So fix this by not assuming as->root has iommu_ops,
> instead depending on the regions reported by memory listener through:
>
> - register a memory listener to dma_as
> - during region_add, if it's a region of IOMMU, register a specific
>   IOMMU notifier, and store all notifiers in a list.
> - during region_del, compare and delete the IOMMU notifier from the list
>
> This is also a must for making vhost device IOTLB works for all types
> of IOMMUs. Note, since we register one notifier during each
> .region_add, the IOTLB may be flushed more than one times, this is
> suboptimal and could be optimized in the future.
>
> Reported-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> Fixes: 3716d5902d74 ("pci: introduce a bus master container")
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/virtio/vhost.c         | 84 ++++++++++++++++++++++++++++++++++++-----------
>  include/hw/virtio/vhost.h | 11 +++++++
>  2 files changed, 75 insertions(+), 20 deletions(-)

Tested-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks!
Maxime

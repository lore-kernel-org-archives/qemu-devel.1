Received: from eggs.gnu.org ([2001:4830:134:3::10]:34910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct8XF-0000Z4-0Z
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1ct8XB-0007xX-1l
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1ct8XA-0007xH-Ro
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:00:48 -0400
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
Date: Wed, 29 Mar 2017 16:00:37 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] issues of region cache and iommu reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>

Hi:

I meet an issue when doing reboot for a guest with two virtio-net-pci 
cards when iommu is enabled. What happens is:


1) vtd was reset first

2) during the reset of virtio-net-pci #1, deletion of msix subregion 
will cause a commit of all memory listeners

3) virito-net-pci #2's region cache will be update, but since vtd has 
already been reset, it can't get a valid mappings here


Any ideas on how to fix this? Need region cache be aware of IOMMU/IOTLB 
state in this case? Or can we simply reset IOMMU as the last one?

Thanks

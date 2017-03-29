Received: from eggs.gnu.org ([2001:4830:134:3::10]:37458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct8fO-0003Hk-NZ
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ct8fL-00039d-G2
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:09:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ct8fL-00039E-Aa
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 04:09:15 -0400
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
Date: Wed, 29 Mar 2017 10:09:10 +0200
MIME-Version: 1.0
In-Reply-To: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] issues of region cache and iommu reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 29/03/2017 10:00, Jason Wang wrote:
> 
> 
> 1) vtd was reset first
> 
> 2) during the reset of virtio-net-pci #1, deletion of msix subregion
> will cause a commit of all memory listeners
> 
> 3) virito-net-pci #2's region cache will be update, but since vtd has
> already been reset, it can't get a valid mappings here
>
> Any ideas on how to fix this? Need region cache be aware of IOMMU/IOTLB
> state in this case? Or can we simply reset IOMMU as the last one?

Something like this?

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 03592c5..73e69ac 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -176,6 +176,10 @@ err_used:
     address_space_cache_destroy(&new->desc);
 err_desc:
     g_free(new);
+    atomic_rcu_set(&vq->vring.caches, NULL);
+    if (old) {
+        call_rcu(old, virtio_free_region_cache, rcu);
+    }
 }

 /* virt queue functions */

Paolo

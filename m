Received: from eggs.gnu.org ([2001:4830:134:3::10]:33713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSdmy-0005Ws-9Q
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:27:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSdmt-00063n-Dx
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 02:27:52 -0400
References: <1499170866-9068-1-git-send-email-jasowang@redhat.com>
	<20170705062359.GC29382@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c6808be-64ee-ac82-0d03-15017baf7917@redhat.com>
Date: Wed, 5 Jul 2017 08:27:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170705062359.GC29382@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: finalize IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, mst@redhat.com, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org



On 05/07/2017 08:23, Fam Zheng wrote:
>>      req->vq = vq;
>>      req->dev = s;
>> -    qemu_sglist_init(&req->qsgl, DEVICE(s), 8, &address_space_memory);
>> +    qemu_sglist_init(&req->qsgl, DEVICE(s), 8, vdev->dma_as);
> Not related to this patch, but is our vIOMMU iotlb implementation safe for data
> plane (both virtio-blk and virtio-scsi)? There we don't have BQL to synchronize
> between IOVA lookup and update, which means threads can race when accessing the
> iotlb GHashTable.
> 
> Did I overlook a synchronization mechanism? Or is it missing? Paolo, MST?

I think it's missing.  One way to fix it could be to finish the
MemoryRegionCache work and have an IOMMU->virtio notifier, similar to
how vhost works.

Paolo

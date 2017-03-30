Received: from eggs.gnu.org ([2001:4830:134:3::10]:48809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctVy9-0006Qe-6M
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:02:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctVy4-0000Gg-85
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:02:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ctVy4-0000Ga-25
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:02:08 -0400
References: <93cb45b7-feca-9340-5fbe-3cc1e60d9e7e@redhat.com>
	<aa8f8830-9426-7cf5-ec99-363035315aa3@redhat.com>
	<20170330002755-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7e37593-93ed-23c2-7b68-240b46aef9c0@redhat.com>
Date: Thu, 30 Mar 2017 11:02:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170330002755-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>



On 29/03/2017 23:28, Michael S. Tsirkin wrote:
>> Something like this?
>>
>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>> index 03592c5..73e69ac 100644
>> --- a/hw/virtio/virtio.c
>> +++ b/hw/virtio/virtio.c
>> @@ -176,6 +176,10 @@ err_used:
>>      address_space_cache_destroy(&new->desc);
>>  err_desc:
>>      g_free(new);
>> +    atomic_rcu_set(&vq->vring.caches, NULL);
>> +    if (old) {
>> +        call_rcu(old, virtio_free_region_cache, rcu);
>> +    }
>>  }
>>
>>  /* virt queue functions */
> I would be worried about call_rcu here - this means
> something can hang on to and use the old cache,
> and reset really must act as a sync/flush point.

The flush is done later in virtio_reset.  Here it's just reacting
asynchronously to the IOMMU reset.

I'm thinking of adding a global generation count for IOMMU mappings, and
forcing an update when the IOMMU mappings have changed.

Paolo

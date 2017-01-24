Received: from eggs.gnu.org ([2001:4830:134:3::10]:37089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW3cd-0001Lu-DX
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cW3ca-0005Yt-8h
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:07:03 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cW3ca-0005YM-1G
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 11:07:00 -0500
Received: by mail-wm0-x243.google.com with SMTP id c85so35557305wmi.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 08:06:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170120170757.30308-1-pbonzini@redhat.com>
	<20170120170757.30308-4-pbonzini@redhat.com>
	<20170124123031.GC17221@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b7fe6d3-f9f5-641c-706a-b7f782c5b213@redhat.com>
Date: Tue, 24 Jan 2017 17:06:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170124123031.GC17221@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/7] virtio: use address_space_map/unmap to
 access descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com



On 24/01/2017 13:30, Stefan Hajnoczi wrote:
> On Fri, Jan 20, 2017 at 06:07:53PM +0100, Paolo Bonzini wrote:
>> @@ -455,10 +455,18 @@ void virtqueue_get_avail_bytes(VirtQueue *vq, unsigned int *in_bytes,
>>              goto err;
>>          }
>>  
>> -        desc_pa = vq->vring.desc;
>> -        vring_desc_read(vdev, &desc, desc_pa, i);
>> +        len = max * sizeof(VRingDesc);
>> +        desc_ptr = address_space_map(vdev->dma_as, vq->vring.desc, &len, false);
>> +        if (len < max * sizeof(VRingDesc)) {
>> +            virtio_error(vdev, "Cannot map descriptor ring");
>> +            goto err;
>> +        }
>> +
>> +        vring_desc_read(vdev, &desc, desc_ptr, i);
>>  
>>          if (desc.flags & VRING_DESC_F_INDIRECT) {
>> +            address_space_unmap(vdev->dma_as, desc_ptr, len, false, 0);
> 
> Missing "dest_ptr = NULL" to prevent double unmap if the next goto err
> is taken.
> 
>> @@ -689,18 +706,33 @@ void *virtqueue_pop(VirtQueue *vq, size_t sz)
>>      }
>>  
>>      i = head;
>> -    vring_desc_read(vdev, &desc, desc_pa, i);
>> +
>> +    len = max * sizeof(VRingDesc);
>> +    desc_ptr = address_space_map(vdev->dma_as, vq->vring.desc, &len, false);
>> +    if (len < max * sizeof(VRingDesc)) {
>> +        virtio_error(vdev, "Cannot map descriptor ring");
>> +        return NULL;
> 
> desc_ptr still needs to be unmapped if non-NULL.  The same applies
> below in virtqueue_pop().
> 

I'll redo this patch to look a lot more like 4/7.

Paolo

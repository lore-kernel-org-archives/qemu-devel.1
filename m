Received: from eggs.gnu.org ([2001:4830:134:3::10]:54919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVHf1-0006eR-3h
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dVHex-0005y0-Sl
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:26:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:55187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dVHex-0005wd-EE
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:26:31 -0400
Message-ID: <5966241C.9060503@intel.com>
Date: Wed, 12 Jul 2017 21:29:00 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-6-git-send-email-wei.w.wang@intel.com>
	<20170712160129-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170712160129-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v12 5/8] virtio-balloon: VIRTIO_BALLOON_F_SG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On 07/12/2017 09:06 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 12, 2017 at 08:40:18PM +0800, Wei Wang wrote:
>> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>> index 28b0e96..9f27101 100644
>> --- a/include/linux/virtio.h
>> +++ b/include/linux/virtio.h
>> @@ -57,8 +57,28 @@ int virtqueue_add_sgs(struct virtqueue *vq,
>>   		      void *data,
>>   		      gfp_t gfp);
>>   
>> +/* A desc with this init id is treated as an invalid desc */
>> +#define VIRTQUEUE_DESC_ID_INIT UINT_MAX
>> +int virtqueue_add_chain_desc(struct virtqueue *_vq,
>> +			     uint64_t addr,
>> +			     uint32_t len,
>> +			     unsigned int *head_id,
>> +			     unsigned int *prev_id,
>> +			     bool in);
>> +
>> +int virtqueue_add_chain(struct virtqueue *_vq,
>> +			unsigned int head,
>> +			bool indirect,
>> +			struct vring_desc *indirect_desc,
>> +			void *data,
>> +			void *ctx);
>> +
>>   bool virtqueue_kick(struct virtqueue *vq);
>>   
>> +bool virtqueue_kick_sync(struct virtqueue *vq);
>> +
>> +bool virtqueue_kick_async(struct virtqueue *vq, wait_queue_head_t wq);
>> +
>>   bool virtqueue_kick_prepare(struct virtqueue *vq);
>>   
>>   bool virtqueue_notify(struct virtqueue *vq);
> I don't much care for this API. It does exactly what balloon needs,
> but at cost of e.g. transparently busy-waiting. Unlikely to be
> a good fit for anything else.

If you were referring to this API - virtqueue_add_chain_desc():

Busy waiting only happens when the vq is full (i.e. no desc left). If
necessary, I think we can add an input parameter like
"bool busywaiting", then the caller can decide to simply get a -ENOSPC
or busy wait to add when no desc is available.

>
> If you don't like my original _first/_next/_last, you will
> need to come up with something else.

I thought the above virtqueue_add_chain_des() performs the same
functionality as _first/next/last, which are used to grab descs from the
vq and chain them together. If not, could you please elaborate the
usage of the original proposal?

Best,
Wei

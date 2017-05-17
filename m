Received: from eggs.gnu.org ([2001:4830:134:3::10]:34455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dB0rv-0005q2-Hk
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:28:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dB0rs-0001wo-Ab
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:28:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dB0rs-0001wj-4N
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:28:04 -0400
References: <20170511123246.31308-1-maxime.coquelin@redhat.com>
	<20170511123246.31308-7-maxime.coquelin@redhat.com>
	<20170511203345-mutt-send-email-mst@kernel.org>
	<62516ce5-9d4c-d021-c4ab-a767c7f07b31@redhat.com>
	<20170513025938-mutt-send-email-mst@kernel.org>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <f6b666ca-594c-e5ef-2b62-d88a10fab066@redhat.com>
Date: Wed, 17 May 2017 17:27:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170513025938-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] spec/vhost-user spec: Add IOMMU support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com



On 05/13/2017 02:02 AM, Michael S. Tsirkin wrote:
>>>> @@ -253,6 +271,31 @@ Once the source has finished migration, rings will be stopped by
>>>>    the source. No further update must be done before rings are
>>>>    restarted.
>>>> +IOMMU support
>>>> +-------------
>>>> +
>>>> +When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated, the master has
>>>> +to send IOTLB entries update & invalidation by sending VHOST_USER_IOTLB_MSG
>>>> +requests to the slave with a struct vhost_iotlb_msg payload.
>>> Always? This seems a bit strange since iommu can be enabled/disabled
>>> dynamically.
>> Ok, what about:
>>
>> When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated and iommu
>> is enbaled, the master sends IOTLB entries update & invalidation via
>> VHOST_USER_IOTLB_MSG requests to the slave with a struct vhost_iotlb_msg
>> payload.
>>
>>
>>> Closing channel seems like a wrong thing to do for this.
>> Sorry, I'm not sure to get your comment.
> What happens when guest disables the IOMMU?

I think you mean for example when rebooting the guest with IOMMU
disabled. In this case, I think that the user backend should clean its
IOTLB cache on the next SET_FEATURE call, as the kernel backend does.

Note that I was wrong when stating:
"When the VIRTIO_F_IOMMU_PLATFORM feature has been negotiated and iommu
is enabled..."

Actually, VIRTIO_F_IOMMU_PLATFORM is negotiated if both supported by the
backend and the guest, and if an iommu device is attached. If the guest
kernel doesn't enable the IOMMU (e.g. intel_iommu=off in kernel
cmdline), the master replies to IOTLB misses with identity IOTLB
entries updates (Passthrough) (it requires recent fixes from Peter to
work[0]).

Maxime

[0]: http://patchwork.ozlabs.org/patch/763379/

Received: from eggs.gnu.org ([2001:4830:134:3::10]:47984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1fo2zG-0002Ep-N5
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1fo2zB-00024r-O9
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:41:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1fo2zB-00022u-69
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 04:41:29 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20180810084126euoutp02e6181421284cf25e037823c01e327297~JeUVAv_5x2353823538euoutp02-
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 08:41:26 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Fri, 10 Aug 2018 11:42:17 +0300
MIME-Version: 1.0
In-Reply-To: <4430a308-a225-bebb-6039-287c4f96cf91@samsung.com>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <20180810084124eucas1p161107231ee9c04370a1c366a7e2b4461~JeUTaVtE92747027470eucas1p1C@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20180809165352eucas1p2359a46f1beb147fdcbd035c28bbd48d9@eucas1p2.samsung.com>
	<1533833677-27512-1-git-send-email-i.maximets@samsung.com>
	<20180810015124-mutt-send-email-mst@kernel.org>
	<4430a308-a225-bebb-6039-287c4f96cf91@samsung.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: add support for in-order feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On 10.08.2018 11:28, Ilya Maximets wrote:
> On 10.08.2018 01:51, Michael S. Tsirkin wrote:
>> On Thu, Aug 09, 2018 at 07:54:37PM +0300, Ilya Maximets wrote:
>>> New feature bit for in-order feature of the upcoming
>>> virtio 1.1. It's already supported by DPDK vhost-user
>>> and virtio implementations. These changes required to
>>> allow feature negotiation.
>>>
>>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
>>> ---
>>>
>>> I just wanted to test this new feature in DPDK but failed
>>> to found required patch for QEMU side. So, I implemented it.
>>> At least it will be helpful for someone like me, who wants
>>> to evaluate VIRTIO_F_IN_ORDER with DPDK.
>>>
>>>  hw/net/vhost_net.c                             |  1 +
>>>  include/hw/virtio/virtio.h                     | 12 +++++++-----
>>>  include/standard-headers/linux/virtio_config.h |  7 +++++++
>>>  3 files changed, 15 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>>> index e037db6..86879c5 100644
>>> --- a/hw/net/vhost_net.c
>>> +++ b/hw/net/vhost_net.c
>>> @@ -78,6 +78,7 @@ static const int user_feature_bits[] = {
>>>      VIRTIO_NET_F_MRG_RXBUF,
>>>      VIRTIO_NET_F_MTU,
>>>      VIRTIO_F_IOMMU_PLATFORM,
>>> +    VIRTIO_F_IN_ORDER,
>>>  
>>>      /* This bit implies RARP isn't sent by QEMU out of band */
>>>      VIRTIO_NET_F_GUEST_ANNOUNCE,
>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>> index 9c1fa07..a422025 100644
>>> --- a/include/hw/virtio/virtio.h
>>> +++ b/include/hw/virtio/virtio.h
>>> @@ -254,16 +254,18 @@ typedef struct virtio_input_conf virtio_input_conf;
>>>  typedef struct VirtIOSCSIConf VirtIOSCSIConf;
>>>  typedef struct VirtIORNGConf VirtIORNGConf;
>>>  
>>> -#define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
>>> +#define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field)     \
>>>      DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
>>>                        VIRTIO_RING_F_INDIRECT_DESC, true), \
>>>      DEFINE_PROP_BIT64("event_idx", _state, _field,        \
>>>                        VIRTIO_RING_F_EVENT_IDX, true),     \
>>>      DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
>>> -                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
>>> -    DEFINE_PROP_BIT64("any_layout", _state, _field, \
>>> -                      VIRTIO_F_ANY_LAYOUT, true), \
>>> -    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
>>> +                      VIRTIO_F_NOTIFY_ON_EMPTY, true),    \
>>> +    DEFINE_PROP_BIT64("any_layout", _state, _field,       \
>>> +                      VIRTIO_F_ANY_LAYOUT, true),         \
>>> +    DEFINE_PROP_BIT64("in_order", _state, _field,         \
>>> +                      VIRTIO_F_IN_ORDER, true),           \
>>> +    DEFINE_PROP_BIT64("iommu_platform", _state, _field,   \
>>>                        VIRTIO_F_IOMMU_PLATFORM, false)
>>
>> Is in_order really right for all virtio devices?
> 
> I see nothing device specific in this feature. It just specifies
> some restrictions on the descriptors handling. All virtio devices
> could use it to have performance benefits. Also, upcoming packed
> rings should give a good performance boost in case of enabled
> in-order feature. And packed rings RFC [1] implements
> VIRTIO_F_RING_PACKED for all virtio devices. So, I see no issues
> in enabling in-order negotiation for all of them.
> 

Correction:
RFC [1] does not enable VIRTIO_F_RING_PACKED by default, but
VIRTIO_F_IN_ORDER makes no harm if packed rings disabled (actually, could
give some performance improvement) and should give a good performance
boost if packed rings enabled. Every user of packed rings will likely
want to have in-order feature.
So, IMHO, VIRTIO_F_IN_ORDER should be available by default. This will
save the cmdline length.

> What do you think?
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01028.html
> 
> Best regards, Ilya Maximets.
> 
>>
>>>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>>> diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
>>> index b777069..d20398c 100644
>>> --- a/include/standard-headers/linux/virtio_config.h
>>> +++ b/include/standard-headers/linux/virtio_config.h
>>> @@ -71,4 +71,11 @@
>>>   * this is for compatibility with legacy systems.
>>>   */
>>>  #define VIRTIO_F_IOMMU_PLATFORM		33
>>> +
>>> +/*
>>> + * Inorder feature indicates that all buffers are used by the device
>>> + * in the same order in which they have been made available.
>>> + */
>>> +#define VIRTIO_F_IN_ORDER 35
>>> +
>>>  #endif /* _LINUX_VIRTIO_CONFIG_H */
>>> -- 
>>> 2.7.4
>>
>>

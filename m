Received: from eggs.gnu.org ([2001:4830:134:3::10]:49179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1fpV8c-0004Lo-8q
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1fpV8Y-0005iY-8i
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:57:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <i.maximets@samsung.com>)
	id 1fpV8X-0005hY-MR
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 04:57:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
	20180814085705euoutp02ca615eec5f6badcc8a7c7b55e523625a~KtHI5VIGo0389103891euoutp02R
	for <qemu-devel@nongnu.org>; Tue, 14 Aug 2018 08:57:05 +0000 (GMT)
From: Ilya Maximets <i.maximets@samsung.com>
Date: Tue, 14 Aug 2018 11:58:02 +0300
MIME-Version: 1.0
In-Reply-To: <20180813183134-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <20180814085704eucas1p1d5934341b25470eff8c2985117680d52~KtHHYU31A2532225322eucas1p1t@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20180809165352eucas1p2359a46f1beb147fdcbd035c28bbd48d9@eucas1p2.samsung.com>
	<1533833677-27512-1-git-send-email-i.maximets@samsung.com>
	<20180810015124-mutt-send-email-mst@kernel.org>
	<20180810082754eucas1p2c5833c9292851a7009d348b00bbe811e~JeIgqEodG2498924989eucas1p2Z@eucas1p2.samsung.com>
	<20180810123104-mutt-send-email-mst@kernel.org>
	<20180810110354eucas1p10de168e685bd2e78406713f3650772b6~JgQuPiMgX3216532165eucas1p1q@eucas1p1.samsung.com>
	<20180810221826-mutt-send-email-mst@kernel.org>
	<20180813075427eucas1p21adcf34bd0197e9296394bc5932ae922~KYnKH281R0783607836eucas1p2t@eucas1p2.samsung.com>
	<20180813124349-mutt-send-email-mst@kernel.org>
	<20180813152709eucas1p169b563dc5dffed5af51a592fc0d2a889~Keybd7Z0i1370413704eucas1p1Y@eucas1p1.samsung.com>
	<20180813183134-mutt-send-email-mst@kernel.org>
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

On 13.08.2018 18:35, Michael S. Tsirkin wrote:
> On Mon, Aug 13, 2018 at 06:28:06PM +0300, Ilya Maximets wrote:
>> On 13.08.2018 12:56, Michael S. Tsirkin wrote:
>>> On Mon, Aug 13, 2018 at 10:55:23AM +0300, Ilya Maximets wrote:
>>>> On 10.08.2018 22:19, Michael S. Tsirkin wrote:
>>>>> On Fri, Aug 10, 2018 at 02:04:47PM +0300, Ilya Maximets wrote:
>>>>>> On 10.08.2018 12:34, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Aug 10, 2018 at 11:28:47AM +0300, Ilya Maximets wrote:
>>>>>>>> On 10.08.2018 01:51, Michael S. Tsirkin wrote:
>>>>>>>>> On Thu, Aug 09, 2018 at 07:54:37PM +0300, Ilya Maximets wrote:
>>>>>>>>>> New feature bit for in-order feature of the upcoming
>>>>>>>>>> virtio 1.1. It's already supported by DPDK vhost-user
>>>>>>>>>> and virtio implementations. These changes required to
>>>>>>>>>> allow feature negotiation.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> I just wanted to test this new feature in DPDK but failed
>>>>>>>>>> to found required patch for QEMU side. So, I implemented it.
>>>>>>>>>> At least it will be helpful for someone like me, who wants
>>>>>>>>>> to evaluate VIRTIO_F_IN_ORDER with DPDK.
>>>>>>>>>>
>>>>>>>>>>  hw/net/vhost_net.c                             |  1 +
>>>>>>>>>>  include/hw/virtio/virtio.h                     | 12 +++++++-----
>>>>>>>>>>  include/standard-headers/linux/virtio_config.h |  7 +++++++
>>>>>>>>>>  3 files changed, 15 insertions(+), 5 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>>>>>>>>>> index e037db6..86879c5 100644
>>>>>>>>>> --- a/hw/net/vhost_net.c
>>>>>>>>>> +++ b/hw/net/vhost_net.c
>>>>>>>>>> @@ -78,6 +78,7 @@ static const int user_feature_bits[] = {
>>>>>>>>>>      VIRTIO_NET_F_MRG_RXBUF,
>>>>>>>>>>      VIRTIO_NET_F_MTU,
>>>>>>>>>>      VIRTIO_F_IOMMU_PLATFORM,
>>>>>>>>>> +    VIRTIO_F_IN_ORDER,
>>>>>>>>>>  
>>>>>>>>>>      /* This bit implies RARP isn't sent by QEMU out of band */
>>>>>>>>>>      VIRTIO_NET_F_GUEST_ANNOUNCE,
>>>>>>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>>>>>>>>>> index 9c1fa07..a422025 100644
>>>>>>>>>> --- a/include/hw/virtio/virtio.h
>>>>>>>>>> +++ b/include/hw/virtio/virtio.h
>>>>>>>>>> @@ -254,16 +254,18 @@ typedef struct virtio_input_conf virtio_input_conf;
>>>>>>>>>>  typedef struct VirtIOSCSIConf VirtIOSCSIConf;
>>>>>>>>>>  typedef struct VirtIORNGConf VirtIORNGConf;
>>>>>>>>>>  
>>>>>>>>>> -#define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
>>>>>>>>>> +#define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field)     \
>>>>>>>>>>      DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
>>>>>>>>>>                        VIRTIO_RING_F_INDIRECT_DESC, true), \
>>>>>>>>>>      DEFINE_PROP_BIT64("event_idx", _state, _field,        \
>>>>>>>>>>                        VIRTIO_RING_F_EVENT_IDX, true),     \
>>>>>>>>>>      DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
>>>>>>>>>> -                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
>>>>>>>>>> -    DEFINE_PROP_BIT64("any_layout", _state, _field, \
>>>>>>>>>> -                      VIRTIO_F_ANY_LAYOUT, true), \
>>>>>>>>>> -    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
>>>>>>>>>> +                      VIRTIO_F_NOTIFY_ON_EMPTY, true),    \
>>>>>>>>>> +    DEFINE_PROP_BIT64("any_layout", _state, _field,       \
>>>>>>>>>> +                      VIRTIO_F_ANY_LAYOUT, true),         \
>>>>>>>>>> +    DEFINE_PROP_BIT64("in_order", _state, _field,         \
>>>>>>>>>> +                      VIRTIO_F_IN_ORDER, true),           \
>>>>>>>>>> +    DEFINE_PROP_BIT64("iommu_platform", _state, _field,   \
>>>>>>>>>>                        VIRTIO_F_IOMMU_PLATFORM, false)
>>>>>>>>>
>>>>>>>>> Is in_order really right for all virtio devices?
>>>>>>>>
>>>>>>>> I see nothing device specific in this feature. It just specifies
>>>>>>>> some restrictions on the descriptors handling. All virtio devices
>>>>>>>> could use it to have performance benefits. Also, upcoming packed
>>>>>>>> rings should give a good performance boost in case of enabled
>>>>>>>> in-order feature. And packed rings RFC [1] implements
>>>>>>>> VIRTIO_F_RING_PACKED for all virtio devices. So, I see no issues
>>>>>>>> in enabling in-order negotiation for all of them.
>>>>>>>>
>>>>>>>> What do you think?
>>>>>>>>
>>>>>>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01028.html
>>>>>>>>
>>>>>>>> Best regards, Ilya Maximets.
>>>>>>>
>>>>>>> If guest assumes in-order use of buffers but device uses them out of
>>>>>>> order then guest will crash. So there's a missing piece where
>>>>>>> you actually make devices use buffers in order when the flag is set.
>>>>>>
>>>>>> I thought that feature negotiation is the mechanism that should
>>>>>> protect us from situations like that. Isn't it?
>>>>>> If device negotiates in-order feature, when it MUST (as described
>>>>>> in spec) use buffers in the same order in which they have been
>>>>>> available.
>>>>>
>>>>> Exactly. And your patch does nothing to ensure that,
>>>
>>> Let me elaborate. Your patch adds an in order property to
>>> all virtio devices. When set, guests will assume that
>>> all buffers are used in the order they have been made
>>> available. However, IIUC current virtio code in qemu
>>> sometimes uses buffers out of order. Therefore
>>> with your patch applied devices behave out of spec.
>>>
>>> You need to either make sure the flag forces in-order
>>> behaviour, or limit the flag to devices which are
>>> in-order.
>>>
>>
>> OK. Finally, I got your point. Thanks for explanation.
>> So, we have a bunch of qemu virtio devices that doesn't
>> support this option.
>>
>> I see 2 options that could be not so hard to implement:
>>
>> 1. Set the default value of 'in_order' property to 'false'.
>>    In this case, It'll be the users responsibility to ensure
>>    that device that he wants to use supports this feature.
> 
> I don't much like this option, I don't see how is the user
> supposed to know.

Sure. This is not obvious. At least user could know that if
some specific vhost backend will be used.
But yes, this is not a good option.

> 
>> 2. Remove the "in_order" property bit and enable the feature
>>    for now only for virtio-net device
> 
> I suspect at least serial, balloon, rng can all support this.

Hmm. I'll try to check, but this could take some time.

> 
> BTW you also need to disable for compat machine types.

OK. This will require some internal config option?

> 
>> somewhere in
>>    "virtio_net_get_features".
> 
> Is there something that guarantees this for virtio-net (without vhost)?

I'm not sure. Need to check.

> 
>> Probably, only for vhost enabled
>>    devices, i.e. just before "vhost_net_get_features".
> 
> vhost should probably expose this feature from the backend,
> should it not?

Yes. You're right. But there is an issue here. That is the most
confusing part. vhost is not able to expose any new feature that
wasn't already set in "host_features". That's why we need to
add this flag to "features" before calling "vhost_net_get_features".
This comes from the implementation of "vhost_get_features" in vhost.c.

The origin of this is that "host_features" used in a two ways:
1. as a set of features supported by internal device implementation.
   (without vhost)
2. as a set of features available for negotiation with vhost.

I want to enable vhost negotiation with in-order feature, but I can't
add the property flag to "host_features", because internal
implementation may not support it.

Thinking about how to solve this situation, maybe it's better to
make the "vhost-internal" backend with its own set of supported
features? In this case we'll be able to use "host_features" in
a second way (as a set of features available for negotiation) and
every backend (including "internal" one) will negotiate features
that it supports.

What do you think?

> 
>> What do you think ?
> 
> BTW there's also another option 3. queue buffers somewhere and mark them
> used in order.

I'll look at this option.

> 
>>>
>>>> Are you requesting to validate every single ring operation?
>>>>
>>>> Anyway,
>>>> Buggy/malicious device is able to crash guest in a variety of ways.
>>>> Device that flags support of the feature, but breaks this promise,
>>>> IMHO, is buggy or malicious. So, why we need to protect from these
>>>> devices only for this particular feature flag?
>>>>
>>>> If your HW is broken, you're replacing it with a better one.
>>>
>>>
>>> This isn't what I was trying to say but in any case I'd like to point
>>> out that generally we would prefer guests to be able to validate device
>>> input at least optionally. It's useful for use-cases such as SEV.
>>>
>>> Besides, a guest crashing in the field isn't necessarily user or
>>> developer friendly.
>>>
>>> However it's a separate discussion about guest behaviours that
>>> would refer to a guest not host change.
>>>
>>>> Do you have an example where both (device and driver) are compliant
>>>> to virtio spec and something goes wrong?
>>>
>>> My point was that with your patch qemu isn't compliant.
>>>
>>>>> or limit to devices which use buffers in order.
>>>> Do you have a full list?
>>>>
>>>> Negotiation works well with current patch applied.
>>>
>>> I think that's only true because guests ignore the in-order
>>> flag even if negotiated. Once guests start relying on the
>>> in-order flag.
>>>
>>>> If device doesn't
>>>> support feature, the driver is not able to negotiate it. If device
>>>> supports it, the driver is able to use this feature.
>>>> So, what is the point?
>>>
>>> The point is that the feature implies a new promise about
>>> device behaviour. You set the flag but don't change qemu
>>> so it does not fulfill the promise.
>>>
>>>> The feature flag VIRTIO_F_IN_ORDER is a common flag for all the
>>>> devices. If not, maybe you need to fix the virtio spec?
>>>
>>> Any device can make the promise. The point is that current qemu
>>> code doesn't fulfill it for all device.
>>>
>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>>>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>>>>>>>>>> diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
>>>>>>>>>> index b777069..d20398c 100644
>>>>>>>>>> --- a/include/standard-headers/linux/virtio_config.h
>>>>>>>>>> +++ b/include/standard-headers/linux/virtio_config.h
>>>>>>>>>> @@ -71,4 +71,11 @@
>>>>>>>>>>   * this is for compatibility with legacy systems.
>>>>>>>>>>   */
>>>>>>>>>>  #define VIRTIO_F_IOMMU_PLATFORM		33
>>>>>>>>>> +
>>>>>>>>>> +/*
>>>>>>>>>> + * Inorder feature indicates that all buffers are used by the device
>>>>>>>>>> + * in the same order in which they have been made available.
>>>>>>>>>> + */
>>>>>>>>>> +#define VIRTIO_F_IN_ORDER 35
>>>>>>>>>> +
>>>>>>>>>>  #endif /* _LINUX_VIRTIO_CONFIG_H */
>>>>>>>>>> -- 
>>>>>>>>>> 2.7.4

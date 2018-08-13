Received: from eggs.gnu.org ([2001:4830:134:3::10]:38822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fp9ao-0005RI-2I
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fp9ak-0001vr-VS
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:56:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41646 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fp9ak-0001vE-N6
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 05:56:50 -0400
Date: Mon, 13 Aug 2018 12:56:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180813124349-mutt-send-email-mst@kernel.org>
References: <CGME20180809165352eucas1p2359a46f1beb147fdcbd035c28bbd48d9@eucas1p2.samsung.com>
	<1533833677-27512-1-git-send-email-i.maximets@samsung.com>
	<20180810015124-mutt-send-email-mst@kernel.org>
	<20180810082754eucas1p2c5833c9292851a7009d348b00bbe811e~JeIgqEodG2498924989eucas1p2Z@eucas1p2.samsung.com>
	<20180810123104-mutt-send-email-mst@kernel.org>
	<20180810110354eucas1p10de168e685bd2e78406713f3650772b6~JgQuPiMgX3216532165eucas1p1q@eucas1p1.samsung.com>
	<20180810221826-mutt-send-email-mst@kernel.org>
	<20180813075427eucas1p21adcf34bd0197e9296394bc5932ae922~KYnKH281R0783607836eucas1p2t@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180813075427eucas1p21adcf34bd0197e9296394bc5932ae922~KYnKH281R0783607836eucas1p2t@eucas1p2.samsung.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: add support for in-order feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Maxime Coquelin <maxime.coquelin@redhat.com>

On Mon, Aug 13, 2018 at 10:55:23AM +0300, Ilya Maximets wrote:
> On 10.08.2018 22:19, Michael S. Tsirkin wrote:
> > On Fri, Aug 10, 2018 at 02:04:47PM +0300, Ilya Maximets wrote:
> >> On 10.08.2018 12:34, Michael S. Tsirkin wrote:
> >>> On Fri, Aug 10, 2018 at 11:28:47AM +0300, Ilya Maximets wrote:
> >>>> On 10.08.2018 01:51, Michael S. Tsirkin wrote:
> >>>>> On Thu, Aug 09, 2018 at 07:54:37PM +0300, Ilya Maximets wrote:
> >>>>>> New feature bit for in-order feature of the upcoming
> >>>>>> virtio 1.1. It's already supported by DPDK vhost-user
> >>>>>> and virtio implementations. These changes required to
> >>>>>> allow feature negotiation.
> >>>>>>
> >>>>>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> >>>>>> ---
> >>>>>>
> >>>>>> I just wanted to test this new feature in DPDK but failed
> >>>>>> to found required patch for QEMU side. So, I implemented it.
> >>>>>> At least it will be helpful for someone like me, who wants
> >>>>>> to evaluate VIRTIO_F_IN_ORDER with DPDK.
> >>>>>>
> >>>>>>  hw/net/vhost_net.c                             |  1 +
> >>>>>>  include/hw/virtio/virtio.h                     | 12 +++++++-----
> >>>>>>  include/standard-headers/linux/virtio_config.h |  7 +++++++
> >>>>>>  3 files changed, 15 insertions(+), 5 deletions(-)
> >>>>>>
> >>>>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> >>>>>> index e037db6..86879c5 100644
> >>>>>> --- a/hw/net/vhost_net.c
> >>>>>> +++ b/hw/net/vhost_net.c
> >>>>>> @@ -78,6 +78,7 @@ static const int user_feature_bits[] = {
> >>>>>>      VIRTIO_NET_F_MRG_RXBUF,
> >>>>>>      VIRTIO_NET_F_MTU,
> >>>>>>      VIRTIO_F_IOMMU_PLATFORM,
> >>>>>> +    VIRTIO_F_IN_ORDER,
> >>>>>>  
> >>>>>>      /* This bit implies RARP isn't sent by QEMU out of band */
> >>>>>>      VIRTIO_NET_F_GUEST_ANNOUNCE,
> >>>>>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> >>>>>> index 9c1fa07..a422025 100644
> >>>>>> --- a/include/hw/virtio/virtio.h
> >>>>>> +++ b/include/hw/virtio/virtio.h
> >>>>>> @@ -254,16 +254,18 @@ typedef struct virtio_input_conf virtio_input_conf;
> >>>>>>  typedef struct VirtIOSCSIConf VirtIOSCSIConf;
> >>>>>>  typedef struct VirtIORNGConf VirtIORNGConf;
> >>>>>>  
> >>>>>> -#define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
> >>>>>> +#define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field)     \
> >>>>>>      DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
> >>>>>>                        VIRTIO_RING_F_INDIRECT_DESC, true), \
> >>>>>>      DEFINE_PROP_BIT64("event_idx", _state, _field,        \
> >>>>>>                        VIRTIO_RING_F_EVENT_IDX, true),     \
> >>>>>>      DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
> >>>>>> -                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
> >>>>>> -    DEFINE_PROP_BIT64("any_layout", _state, _field, \
> >>>>>> -                      VIRTIO_F_ANY_LAYOUT, true), \
> >>>>>> -    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> >>>>>> +                      VIRTIO_F_NOTIFY_ON_EMPTY, true),    \
> >>>>>> +    DEFINE_PROP_BIT64("any_layout", _state, _field,       \
> >>>>>> +                      VIRTIO_F_ANY_LAYOUT, true),         \
> >>>>>> +    DEFINE_PROP_BIT64("in_order", _state, _field,         \
> >>>>>> +                      VIRTIO_F_IN_ORDER, true),           \
> >>>>>> +    DEFINE_PROP_BIT64("iommu_platform", _state, _field,   \
> >>>>>>                        VIRTIO_F_IOMMU_PLATFORM, false)
> >>>>>
> >>>>> Is in_order really right for all virtio devices?
> >>>>
> >>>> I see nothing device specific in this feature. It just specifies
> >>>> some restrictions on the descriptors handling. All virtio devices
> >>>> could use it to have performance benefits. Also, upcoming packed
> >>>> rings should give a good performance boost in case of enabled
> >>>> in-order feature. And packed rings RFC [1] implements
> >>>> VIRTIO_F_RING_PACKED for all virtio devices. So, I see no issues
> >>>> in enabling in-order negotiation for all of them.
> >>>>
> >>>> What do you think?
> >>>>
> >>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01028.html
> >>>>
> >>>> Best regards, Ilya Maximets.
> >>>
> >>> If guest assumes in-order use of buffers but device uses them out of
> >>> order then guest will crash. So there's a missing piece where
> >>> you actually make devices use buffers in order when the flag is set.
> >>
> >> I thought that feature negotiation is the mechanism that should
> >> protect us from situations like that. Isn't it?
> >> If device negotiates in-order feature, when it MUST (as described
> >> in spec) use buffers in the same order in which they have been
> >> available.
> > 
> > Exactly. And your patch does nothing to ensure that,

Let me elaborate. Your patch adds an in order property to
all virtio devices. When set, guests will assume that
all buffers are used in the order they have been made
available. However, IIUC current virtio code in qemu
sometimes uses buffers out of order. Therefore
with your patch applied devices behave out of spec.

You need to either make sure the flag forces in-order
behaviour, or limit the flag to devices which are
in-order.



> Are you requesting to validate every single ring operation?
> 
> Anyway,
> Buggy/malicious device is able to crash guest in a variety of ways.
> Device that flags support of the feature, but breaks this promise,
> IMHO, is buggy or malicious. So, why we need to protect from these
> devices only for this particular feature flag?
>
> If your HW is broken, you're replacing it with a better one.


This isn't what I was trying to say but in any case I'd like to point
out that generally we would prefer guests to be able to validate device
input at least optionally. It's useful for use-cases such as SEV.

Besides, a guest crashing in the field isn't necessarily user or
developer friendly.

However it's a separate discussion about guest behaviours that
would refer to a guest not host change.

> Do you have an example where both (device and driver) are compliant
> to virtio spec and something goes wrong?

My point was that with your patch qemu isn't compliant.

> > or limit to devices which use buffers in order.
> Do you have a full list?
> 
> Negotiation works well with current patch applied.

I think that's only true because guests ignore the in-order
flag even if negotiated. Once guests start relying on the
in-order flag.

> If device doesn't
> support feature, the driver is not able to negotiate it. If device
> supports it, the driver is able to use this feature.
> So, what is the point?

The point is that the feature implies a new promise about
device behaviour. You set the flag but don't change qemu
so it does not fulfill the promise.

> The feature flag VIRTIO_F_IN_ORDER is a common flag for all the
> devices. If not, maybe you need to fix the virtio spec?

Any device can make the promise. The point is that current qemu
code doesn't fulfill it for all device.

> > 
> >>>
> >>>>>
> >>>>>>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> >>>>>> diff --git a/include/standard-headers/linux/virtio_config.h b/include/standard-headers/linux/virtio_config.h
> >>>>>> index b777069..d20398c 100644
> >>>>>> --- a/include/standard-headers/linux/virtio_config.h
> >>>>>> +++ b/include/standard-headers/linux/virtio_config.h
> >>>>>> @@ -71,4 +71,11 @@
> >>>>>>   * this is for compatibility with legacy systems.
> >>>>>>   */
> >>>>>>  #define VIRTIO_F_IOMMU_PLATFORM		33
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * Inorder feature indicates that all buffers are used by the device
> >>>>>> + * in the same order in which they have been made available.
> >>>>>> + */
> >>>>>> +#define VIRTIO_F_IN_ORDER 35
> >>>>>> +
> >>>>>>  #endif /* _LINUX_VIRTIO_CONFIG_H */
> >>>>>> -- 
> >>>>>> 2.7.4
> >>>>>
> >>>>>
> >>>
> >>>
> > 
> > 

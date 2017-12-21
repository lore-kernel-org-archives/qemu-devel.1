Received: from eggs.gnu.org ([2001:4830:134:3::10]:32955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS7dp-0007eH-HI
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:40:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS7dl-0003Vx-H1
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:40:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS7dl-0003VV-79
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:40:29 -0500
Date: Thu, 21 Dec 2017 22:40:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171221223857-mutt-send-email-mst@kernel.org>
References: <cover.1513278334.git.jbaron@akamai.com>
	<cover.1513278334.git.jbaron@akamai.com>
	<1513280073-27515-1-git-send-email-jbaron@akamai.com>
	<C5089512-91B2-439E-B22D-D7D416BDD558@redhat.com>
	<9d600f3d-7e8d-153f-fd34-704c9975099b@akamai.com>
	<21A64922-D22E-4AE1-8B4C-B0D85357240C@redhat.com>
	<73e8811d-70fd-4920-1cb4-ad1809ebff82@akamai.com>
	<20171220162927-mutt-send-email-mst@kernel.org>
	<F096C867-C75B-4756-B4F6-9774DDF2FC8B@redhat.com>
	<c12c5c83-cc73-844f-2c37-3a4c364d4dd6@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c12c5c83-cc73-844f-2c37-3a4c364d4dd6@akamai.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu: add linkspeed and duplex setting
 to virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Baron <jbaron@akamai.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, jasowang@redhat.com, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org

On Thu, Dec 21, 2017 at 02:42:48PM -0500, Jason Baron wrote:
> 
> 
> On 12/20/2017 09:33 AM, Yan Vugenfirer wrote:
> > 
> >> On 20 Dec 2017, at 16:31, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Tue, Dec 19, 2017 at 11:52:39AM -0500, Jason Baron wrote:
> >>>
> >>>
> >>> On 12/19/2017 04:19 AM, Yan Vugenfirer wrote:
> >>>>
> >>>>> On 18 Dec 2017, at 18:04, Jason Baron via Qemu-devel
> >>>>> <qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> On 12/18/2017 06:34 AM, Yan Vugenfirer wrote:
> >>>>>>
> >>>>>>> On 14 Dec 2017, at 21:33, Jason Baron via Qemu-devel
> >>>>>>> <qemu-devel@nongnu.org <mailto:qemu-devel@nongnu.org>> wrote:
> >>>>>>>
> >>>>>>> Although they can be currently set in linux via 'ethtool -s', this
> >>>>>>> requires
> >>>>>>> guest changes, and thus it would be nice to extend this
> >>>>>>> functionality such
> >>>>>>> that it can be configured automatically from the host (as other network
> >>>>>>> do).
> >>>>>>>
> >>>>>>> Linkspeed and duplex settings can be set as:
> >>>>>>> '-device virtio-net,speed=10000,duplex=full'
> >>>>>>>
> >>>>>>> where speed is [-1...INT_MAX], and duplex is ["half"|"full"].
> >>>>>>>
> >>>>>>> Signed-off-by: Jason Baron <jbaron@akamai.com
> >>>>>>> <mailto:jbaron@akamai.com>>
> >>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>>
> >>>>>>> Cc: Jason Wang <jasowang@redhat.com <mailto:jasowang@redhat.com>>
> >>>>>>> ---
> >>>>>>> hw/net/virtio-net.c                         | 29
> >>>>>>> +++++++++++++++++++++++++++++
> >>>>>>> include/hw/virtio/virtio-net.h              |  3 +++
> >>>>>>> include/standard-headers/linux/virtio_net.h |  4 ++++
> >>>>>>> 3 files changed, 36 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>>>>>> index 38674b0..d63e790 100644
> >>>>>>> --- a/hw/net/virtio-net.c
> >>>>>>> +++ b/hw/net/virtio-net.c
> >>>>>>> @@ -40,6 +40,12 @@
> >>>>>>> #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
> >>>>>>> #define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
> >>>>>>>
> >>>>>>> +/* duplex and speed defines */
> >>>>>>> +#define DUPLEX_UNKNOWN          0xff
> >>>>>>> +#define DUPLEX_HALF             0x00
> >>>>>>> +#define DUPLEX_FULL             0x01
> >>>>>>> +#define SPEED_UNKNOWN           -1
> >>>>>>> +
> >>>>>>> /*
> >>>>>>> * Calculate the number of bytes up to and including the given 'field' of
> >>>>>>> * 'container'.
> >>>>>>> @@ -61,6 +67,8 @@ static VirtIOFeature feature_sizes[] = {
> >>>>>>>     .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
> >>>>>>>    {.flags = 1 << VIRTIO_NET_F_MTU,
> >>>>>>>     .end = endof(struct virtio_net_config, mtu)},
> >>>>>>> +    {.flags = 1 << VIRTIO_NET_F_SPEED_DUPLEX,
> >>>>>>> +     .end = endof(struct virtio_net_config, duplex)},
> >>>>>>>    {}
> >>>>>>> };
> >>>>>>>
> >>>>>>> @@ -88,6 +96,8 @@ static void virtio_net_get_config(VirtIODevice
> >>>>>>> *vdev, uint8_t *config)
> >>>>>>>    virtio_stw_p(vdev, &netcfg.status, n->status);
> >>>>>>>    virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
> >>>>>>>    virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
> >>>>>>> +    virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
> >>>>>>> +    netcfg.duplex = n->net_conf.duplex;
> >>>>>>>    memcpy(netcfg.mac, n->mac, ETH_ALEN);
> >>>>>>>    memcpy(config, &netcfg, n->config_size);
> >>>>>>> }
> >>>>>>> @@ -1941,6 +1951,23 @@ static void
> >>>>>>> virtio_net_device_realize(DeviceState *dev, Error **errp)
> >>>>>>>        n->host_features |= (0x1 << VIRTIO_NET_F_MTU);
> >>>>>>>    }
> >>>>>>>
> >>>>>>> +    n->host_features |= (0x1 << VIRTIO_NET_F_SPEED_DUPLEX);
> >>>>>>> +    if (n->net_conf.duplex_str) {
> >>>>>>> +        if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
> >>>>>>> +            n->net_conf.duplex = DUPLEX_HALF;
> >>>>>>> +        } else if (strncmp(n->net_conf.duplex_str, "full", 5) == 0) {
> >>>>>>> +            n->net_conf.duplex = DUPLEX_FULL;
> >>>>>>> +        } else {
> >>>>>>> +            error_setg(errp, "'duplex' must be 'half' or 'full'");
> >>>>>>> +        }
> >>>>>>> +    } else {
> >>>>>>> +        n->net_conf.duplex = DUPLEX_UNKNOWN;
> >>>>>>> +    }
> >>>>>>> +    if (n->net_conf.speed < SPEED_UNKNOWN) {
> >>>>>>> +            error_setg(errp, "'speed' must be between -1
> >>>>>>> (SPEED_UNKOWN) and "
> >>>>>>> +                       "INT_MAX");
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>>    virtio_net_set_config_size(n, n->host_features);
> >>>>>>>    virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
> >>>>>>>
> >>>>>>> @@ -2160,6 +2187,8 @@ static Property virtio_net_properties[] = {
> >>>>>>>    DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
> >>>>>>>    DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet,
> >>>>>>> mtu_bypass_backend,
> >>>>>>>                     true),
> >>>>>>> +    DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed,
> >>>>>>> SPEED_UNKNOWN),
> >>>>>>
> >>>>>> From Windows guest perspective I prefer to have some reasonable
> >>>>>> default (10G for example). 
> >>>>>
> >>>>>
> >>>>> hmmm, I didn't want to change/set the default here in case it broke
> >>>>> something, but I'm ok setting it to some 'reasonable' value - (10G and
> >>>>> duplex?), if the consensus is that that would be safe.
> >>>>
> >>>> OK from my side.
> >>>> Thanks.
> >>>
> >>> I presume your speaking for windows - i'm wondering if under linux the
> >>> virtio device suddenly start showing up as duplex, 10Gbps, will that
> >>> break anything? I can speak for the use-cases we have here and that
> >>> would certainly be fine for us, but i'm really not sure if that is ok
> >>> more generally.
> >>>
> >>> Thanks,
> >>>
> >>> -Jason
> >>
> >> How about not enabling the flag unless the user specified the speed?
> >> This way we also do not need an "unknown" value.
> > 
> > This is even better.
> > 
> We may still want "unknown" here as a setting, because otherwise we
> can't support dynamically changing the speed later (if we added say a
> qmp monitor command), because the flag would not have been set.
> 
> So I am ok with the 10Gps and full duplex defaults, if at least one of
> 'speed=' or 'duplex=' is supplied, but I would prefer to leave the
> "unknown" values as a setting (to still potentially allow dynamic
> updates in this case).
> 
> Thanks,
> 
> -Jason

That's fine. And I really think we should leave defaults to unknown
and not 10G.

> >>
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>>
> >>>>> -Jason
> >>>>>
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Yan.
> >>>>>>
> >>>>>>> +    DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> >>>>>>>    DEFINE_PROP_END_OF_LIST(),
> >>>>>>> };
> >>>>>>>
> >>>>>>> diff --git a/include/hw/virtio/virtio-net.h
> >>>>>>> b/include/hw/virtio/virtio-net.h
> >>>>>>> index b81b6a4..af74a94 100644
> >>>>>>> --- a/include/hw/virtio/virtio-net.h
> >>>>>>> +++ b/include/hw/virtio/virtio-net.h
> >>>>>>> @@ -38,6 +38,9 @@ typedef struct virtio_net_conf
> >>>>>>>    uint16_t rx_queue_size;
> >>>>>>>    uint16_t tx_queue_size;
> >>>>>>>    uint16_t mtu;
> >>>>>>> +    int32_t speed;
> >>>>>>> +    char *duplex_str;
> >>>>>>> +    uint8_t duplex;
> >>>>>>> } virtio_net_conf;
> >>>>>>>
> >>>>>>> /* Maximum packet size we can receive from tap device: header + 64k */
> >>>>>>> diff --git a/include/standard-headers/linux/virtio_net.h
> >>>>>>> b/include/standard-headers/linux/virtio_net.h
> >>>>>>> index 30ff249..0ff1447 100644
> >>>>>>> --- a/include/standard-headers/linux/virtio_net.h
> >>>>>>> +++ b/include/standard-headers/linux/virtio_net.h
> >>>>>>> @@ -36,6 +36,7 @@
> >>>>>>> #define VIRTIO_NET_F_GUEST_CSUM1/* Guest handles pkts w/ partial csum */
> >>>>>>> #define VIRTIO_NET_F_CTRL_GUEST_OFFLOADS 2 /* Dynamic offload
> >>>>>>> configuration. */
> >>>>>>> #define VIRTIO_NET_F_MTU3/* Initial MTU advice */
> >>>>>>> +#define VIRTIO_NET_F_SPEED_DUPLEX 4/* Host set linkspeed and duplex */
> >>>>>>> #define VIRTIO_NET_F_MAC5/* Host has given MAC address. */
> >>>>>>> #define VIRTIO_NET_F_GUEST_TSO47/* Guest can handle TSOv4 in. */
> >>>>>>> #define VIRTIO_NET_F_GUEST_TSO68/* Guest can handle TSOv6 in. */
> >>>>>>> @@ -76,6 +77,9 @@ struct virtio_net_config {
> >>>>>>> uint16_t max_virtqueue_pairs;
> >>>>>>> /* Default maximum transmit unit advice */
> >>>>>>> uint16_t mtu;
> >>>>>>> +/* Host exported linkspeed and duplex */
> >>>>>>> +uint32_t speed;
> >>>>>>> +uint8_t duplex;
> >>>>>>> } QEMU_PACKED;
> >>>>>>>
> >>>>>>> /*
> >>>>>>> -- 
> >>>>>>> 2.6.1
> > 

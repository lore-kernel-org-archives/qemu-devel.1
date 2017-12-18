Received: from eggs.gnu.org ([2001:4830:134:3::10]:49509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eQxts-00074Y-C1
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eQxtn-00012z-Ac
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:04:20 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:37676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1eQxtm-00010U-RT
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 11:04:15 -0500
References: <cover.1513278334.git.jbaron@akamai.com>
	<cover.1513278334.git.jbaron@akamai.com>
	<1513280073-27515-1-git-send-email-jbaron@akamai.com>
	<C5089512-91B2-439E-B22D-D7D416BDD558@redhat.com>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <9d600f3d-7e8d-153f-fd34-704c9975099b@akamai.com>
Date: Mon, 18 Dec 2017 11:04:08 -0500
MIME-Version: 1.0
In-Reply-To: <C5089512-91B2-439E-B22D-D7D416BDD558@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Yan Vugenfirer <yvugenfi@redhat.com>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, jasowang@redhat.com, mst@redhat.com



On 12/18/2017 06:34 AM, Yan Vugenfirer wrote:
> 
>> On 14 Dec 2017, at 21:33, Jason Baron via Qemu-devel <qemu-devel@nongnu.org> wrote:
>>
>> Although they can be currently set in linux via 'ethtool -s', this requires
>> guest changes, and thus it would be nice to extend this functionality such
>> that it can be configured automatically from the host (as other network
>> do).
>>
>> Linkspeed and duplex settings can be set as:
>> '-device virtio-net,speed=10000,duplex=full'
>>
>> where speed is [-1...INT_MAX], and duplex is ["half"|"full"].
>>
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> ---
>> hw/net/virtio-net.c                         | 29 +++++++++++++++++++++++++++++
>> include/hw/virtio/virtio-net.h              |  3 +++
>> include/standard-headers/linux/virtio_net.h |  4 ++++
>> 3 files changed, 36 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 38674b0..d63e790 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -40,6 +40,12 @@
>> #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
>> #define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
>>
>> +/* duplex and speed defines */
>> +#define DUPLEX_UNKNOWN          0xff
>> +#define DUPLEX_HALF             0x00
>> +#define DUPLEX_FULL             0x01
>> +#define SPEED_UNKNOWN           -1
>> +
>> /*
>>  * Calculate the number of bytes up to and including the given 'field' of
>>  * 'container'.
>> @@ -61,6 +67,8 @@ static VirtIOFeature feature_sizes[] = {
>>      .end = endof(struct virtio_net_config, max_virtqueue_pairs)},
>>     {.flags = 1 << VIRTIO_NET_F_MTU,
>>      .end = endof(struct virtio_net_config, mtu)},
>> +    {.flags = 1 << VIRTIO_NET_F_SPEED_DUPLEX,
>> +     .end = endof(struct virtio_net_config, duplex)},
>>     {}
>> };
>>
>> @@ -88,6 +96,8 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
>>     virtio_stw_p(vdev, &netcfg.status, n->status);
>>     virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
>>     virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
>> +    virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
>> +    netcfg.duplex = n->net_conf.duplex;
>>     memcpy(netcfg.mac, n->mac, ETH_ALEN);
>>     memcpy(config, &netcfg, n->config_size);
>> }
>> @@ -1941,6 +1951,23 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>>         n->host_features |= (0x1 << VIRTIO_NET_F_MTU);
>>     }
>>
>> +    n->host_features |= (0x1 << VIRTIO_NET_F_SPEED_DUPLEX);
>> +    if (n->net_conf.duplex_str) {
>> +        if (strncmp(n->net_conf.duplex_str, "half", 5) == 0) {
>> +            n->net_conf.duplex = DUPLEX_HALF;
>> +        } else if (strncmp(n->net_conf.duplex_str, "full", 5) == 0) {
>> +            n->net_conf.duplex = DUPLEX_FULL;
>> +        } else {
>> +            error_setg(errp, "'duplex' must be 'half' or 'full'");
>> +        }
>> +    } else {
>> +        n->net_conf.duplex = DUPLEX_UNKNOWN;
>> +    }
>> +    if (n->net_conf.speed < SPEED_UNKNOWN) {
>> +            error_setg(errp, "'speed' must be between -1 (SPEED_UNKOWN) and "
>> +                       "INT_MAX");
>> +    }
>> +
>>     virtio_net_set_config_size(n, n->host_features);
>>     virtio_init(vdev, "virtio-net", VIRTIO_ID_NET, n->config_size);
>>
>> @@ -2160,6 +2187,8 @@ static Property virtio_net_properties[] = {
>>     DEFINE_PROP_UINT16("host_mtu", VirtIONet, net_conf.mtu, 0),
>>     DEFINE_PROP_BOOL("x-mtu-bypass-backend", VirtIONet, mtu_bypass_backend,
>>                      true),
>> +    DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
> 
> From Windows guest perspective I prefer to have some reasonable default (10G for example). 


hmmm, I didn't want to change/set the default here in case it broke
something, but I'm ok setting it to some 'reasonable' value - (10G and
duplex?), if the consensus is that that would be safe.

Thanks,

-Jason

> 
> Thanks,
> Yan.
> 
>> +    DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
>>     DEFINE_PROP_END_OF_LIST(),
>> };
>>
>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
>> index b81b6a4..af74a94 100644
>> --- a/include/hw/virtio/virtio-net.h
>> +++ b/include/hw/virtio/virtio-net.h
>> @@ -38,6 +38,9 @@ typedef struct virtio_net_conf
>>     uint16_t rx_queue_size;
>>     uint16_t tx_queue_size;
>>     uint16_t mtu;
>> +    int32_t speed;
>> +    char *duplex_str;
>> +    uint8_t duplex;
>> } virtio_net_conf;
>>
>> /* Maximum packet size we can receive from tap device: header + 64k */
>> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
>> index 30ff249..0ff1447 100644
>> --- a/include/standard-headers/linux/virtio_net.h
>> +++ b/include/standard-headers/linux/virtio_net.h
>> @@ -36,6 +36,7 @@
>> #define VIRTIO_NET_F_GUEST_CSUM	1	/* Guest handles pkts w/ partial csum */
>> #define VIRTIO_NET_F_CTRL_GUEST_OFFLOADS 2 /* Dynamic offload configuration. */
>> #define VIRTIO_NET_F_MTU	3	/* Initial MTU advice */
>> +#define VIRTIO_NET_F_SPEED_DUPLEX 4	/* Host set linkspeed and duplex */
>> #define VIRTIO_NET_F_MAC	5	/* Host has given MAC address. */
>> #define VIRTIO_NET_F_GUEST_TSO4	7	/* Guest can handle TSOv4 in. */
>> #define VIRTIO_NET_F_GUEST_TSO6	8	/* Guest can handle TSOv6 in. */
>> @@ -76,6 +77,9 @@ struct virtio_net_config {
>> 	uint16_t max_virtqueue_pairs;
>> 	/* Default maximum transmit unit advice */
>> 	uint16_t mtu;
>> +	/* Host exported linkspeed and duplex */
>> +	uint32_t speed;
>> +	uint8_t duplex;
>> } QEMU_PACKED;
>>
>> /*
>> -- 
>> 2.6.1
>>
>>
> 

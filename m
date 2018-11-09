Received: from eggs.gnu.org ([2001:4830:134:3::10]:44896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gLBGA-0001uR-Qu
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 13:12:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gLBG4-0006Gj-Sp
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 13:11:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gLBG4-00069s-3K
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 13:11:52 -0500
Date: Fri, 9 Nov 2018 13:11:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181109125947-mutt-send-email-mst@kernel.org>
References: <20181109145827.23076-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109145827.23076-1-yuri.benditovich@daynix.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-net: support RSC v4/v6 tcp traffic
 for Windows HCK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com, qemu-devel@nongnu.org, yan@daynix.com

Looks good to me. Some comments below

On Fri, Nov 09, 2018 at 04:58:27PM +0200, Yuri Benditovich wrote:
> This commit adds implementation of RX packets
> coalescing, compatible with requirements of Windows
> Hardware compatibility kit.
> 
> The device enables feature VIRTIO_NET_F_RSC_EXT in
> host features if it supports extended RSC functionality
> as defined in the specification.
> This feature requires at least one of VIRTIO_NET_F_GUEST_TSO4,
> VIRTIO_NET_F_GUEST_TSO6. Windows guest driver acks
> this feature only if VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
> is also present.
> 
> In case vhost is enabled the feature bit is cleared in
> host_features during device initialization.
> 
> If the guest driver acks VIRTIO_NET_F_RSC_EXT feature,
> the device coalesces TCPv4 and TCPv6 packets (if
> respective VIRTIO_NET_F_GUEST_TSO feature is on,
> populates extended RSC information in virtio header
> and sets VIRTIO_NET_HDR_F_RSC_INFO bit in header flags.
> The device does not recalculate checksums in the coalesced
> packet, so they are not valid.
> 
> In this case:
> All the data packets in a tcp connection are cached
> to a single buffer in every receive interval, and will
> be sent out via a timer, the 'virtio_net_rsc_timeout'
> controls the interval, this value may impact the
> performance and response time of tcp connection,
> 50000(50us) is an experience value to gain a performance
> improvement, since the whql test sends packets every 100us,
> so '300000(300us)' passes the test case, it is the default
> value as well, tune it via the command line parameter
> 'rsc_interval' within 'virtio-net-pci' device, for example,
> to launch a guest with interval set as '500000':
> 
> 'virtio-net-pci,netdev=hostnet1,bus=pci.0,id=net1,mac=00,
> guest_rsc_ext=on,rsc_interval=500000'
> 
> The timer will only be triggered if the packets pool is not empty,
> and it'll drain off all the cached packets.
> 
> 'NetRscChain' is used to save the segments of IPv4/6 in a
> VirtIONet device.
> 
> A new segment becomes a 'Candidate' as well as it passed sanity check,
> the main handler of TCP includes TCP window update, duplicated
> ACK check and the real data coalescing.
> 
> An 'Candidate' segment means:
> 1. Segment is within current window and the sequence is the expected one.
> 2. 'ACK' of the segment is in the valid window.
> 
> Sanity check includes:
> 1. Incorrect version in IP header
> 2. An IP options or IP fragment
> 3. Not a TCP packet
> 4. Sanity size check to prevent buffer overflow attack.
> 5. An ECN packet
> 
> Even though, there might more cases should be considered such as
> ip identification other flags, while it breaks the test because
> windows set it to the same even it's not a fragment.
> 
> Normally it includes 2 typical ways to handle a TCP control flag,
> 'bypass' and 'finalize', 'bypass' means should be sent out directly,
> while 'finalize' means the packets should also be bypassed, but this
> should be done after search for the same connection packets in the
> pool and drain all of them out, this is to avoid out of order fragment.
> 
> All the 'SYN' packets will be bypassed since this always begin a new'
> connection, other flags such 'URG/FIN/RST/CWR/ECE' will trigger a
> finalization, because this normally happens upon a connection is going
> to be closed, an 'URG' packet also finalize current coalescing unit.
> 
> Statistics can be used to monitor the basic coalescing status, the
> 'out of order' and 'out of window' means how many retransmitting packets,
> thus describe the performance intuitively.
> 
> Difference between ip v4 and v6 processing:
>  Fragment length in ipv4 header includes itself, while it's not
>  included for ipv6, thus means ipv6 can carry a real 65535 payload.
> 
> Signed-off-by: Wei Xu <address@hidden>

Pls put in the full address, QEMU doesn't accept anonymous
code donations.

> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  hw/net/virtio-net.c                         | 648 +++++++++++++++++++-
>  include/hw/virtio/virtio-net.h              |  81 +++
>  include/net/eth.h                           |   2 +
>  include/standard-headers/linux/virtio_net.h |   8 +
>  4 files changed, 734 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 385b1a03e9..43a7021409 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -41,6 +41,28 @@
>  #define VIRTIO_NET_RX_QUEUE_MIN_SIZE VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE
>  #define VIRTIO_NET_TX_QUEUE_MIN_SIZE VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE
>  
> +#define VIRTIO_NET_IP4_ADDR_SIZE   8        /* ipv4 saddr + daddr */
> +
> +#define VIRTIO_NET_TCP_FLAG         0x3F
> +#define VIRTIO_NET_TCP_HDR_LENGTH   0xF000
> +
> +/* IPv4 max payload, 16 bits in the header */
> +#define VIRTIO_NET_MAX_IP4_PAYLOAD (65535 - sizeof(struct ip_header))
> +#define VIRTIO_NET_MAX_TCP_PAYLOAD 65535
> +
> +/* header length value in ip header without option */
> +#define VIRTIO_NET_IP4_HEADER_LENGTH 5
> +
> +#define ETH_IP6_HDR_SZ (ETH_HDR_SZ + IP6_HDR_SZ)

is this used anywhere?

> +#define VIRTIO_NET_IP6_ADDR_SIZE   32      /* ipv6 saddr + daddr */
> +#define VIRTIO_NET_MAX_IP6_PAYLOAD VIRTIO_NET_MAX_TCP_PAYLOAD
> +
> +/* Purge coalesced packets timer interval, This value affects the performance
> +   a lot, and should be tuned carefully, '300000'(300us) is the recommended
> +   value to pass the WHQL test, '50000' can gain 2x netperf throughput with
> +   tso/gso/gro 'off'. */
> +#define VIRTIO_NET_RSC_INTERVAL 300000

Maybe _DEFAULT_INTERVAL ?

> +
>  /*
>   * Calculate the number of bytes up to and including the given 'field' of
>   * 'container'.
> @@ -628,6 +650,9 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
>      if (!get_vhost_net(nc->peer)) {
>          return features;
>      }
> +    /* clear RSC_EXT feature in case of VHOST*/

space before *

> +    virtio_clear_feature(&features, VIRTIO_NET_F_RSC_EXT);
> +

why is vhost special?

>      features = vhost_net_get_features(get_vhost_net(nc->peer), features);
>      vdev->backend_features = features;
>  
> @@ -701,6 +726,11 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
>                                 virtio_has_feature(features,
>                                                    VIRTIO_F_VERSION_1));
>  
> +    n->rsc4_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
> +        virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO4);
> +    n->rsc6_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
> +        virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO6);
> +
>      if (n->has_vnet_hdr) {
>          n->curr_guest_offloads =
>              virtio_net_guest_offloads_by_features(features);
> @@ -781,6 +811,12 @@ static int virtio_net_handle_offloads(VirtIONet *n, uint8_t cmd,
>              return VIRTIO_NET_ERR;
>          }
>  
> +        n->rsc4_enabled = virtio_has_feature(offloads, VIRTIO_NET_F_RSC_EXT) &&
> +            virtio_has_feature(offloads, VIRTIO_NET_F_GUEST_TSO4);
> +        n->rsc6_enabled = virtio_has_feature(offloads, VIRTIO_NET_F_RSC_EXT) &&
> +            virtio_has_feature(offloads, VIRTIO_NET_F_GUEST_TSO6);
> +        virtio_clear_feature(&offloads, VIRTIO_NET_F_RSC_EXT);
> +
>          supported_offloads = virtio_net_supported_guest_offloads(n);
>          if (offloads & ~supported_offloads) {
>              return VIRTIO_NET_ERR;
> @@ -1253,6 +1289,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>              }
>  
>              receive_header(n, sg, elem->in_num, buf, size);
> +
>              offset = n->host_hdr_len;
>              total += n->guest_hdr_len;
>              guest_offset = n->guest_hdr_len;

let's not do unrelated whitespace tweaks pls

> @@ -1292,7 +1329,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
>      return size;
>  }
>  
> -static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf,
> +static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
>                                    size_t size)
>  {
>      ssize_t r;
> @@ -1303,6 +1340,601 @@ static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf,
>      return r;
>  }
>  
> +static void virtio_net_rsc_extract_unit4(NetRscChain *chain,
> +                                         const uint8_t *buf, NetRscUnit* unit)


space before * not after

> +{
> +    uint16_t ip_hdrlen;
> +    struct ip_header *ip;
> +
> +    ip = (struct ip_header *)(buf + chain->n->guest_hdr_len
> +                              + sizeof(struct eth_header));
> +    unit->ip = (void *)ip;
> +    ip_hdrlen = (ip->ip_ver_len & 0xF) << 2;
> +    unit->ip_plen = &ip->ip_len;
> +    unit->tcp = (struct tcp_header *)(((uint8_t *)unit->ip) + ip_hdrlen);
> +    unit->tcp_hdrlen = (htons(unit->tcp->th_offset_flags) & 0xF000) >> 10;
> +    unit->payload = htons(*unit->ip_plen) - ip_hdrlen - unit->tcp_hdrlen;
> +}
> +
> +static void virtio_net_rsc_extract_unit6(NetRscChain *chain,
> +                                         const uint8_t *buf, NetRscUnit* unit)
> +{
> +    struct ip6_header *ip6;
> +
> +    ip6 = (struct ip6_header *)(buf + chain->n->guest_hdr_len
> +                                 + sizeof(struct eth_header));
> +    unit->ip = ip6;
> +    unit->ip_plen = &(ip6->ip6_ctlun.ip6_un1.ip6_un1_plen);
> +    unit->tcp = (struct tcp_header *)(((uint8_t *)unit->ip)\
> +                                        + sizeof(struct ip6_header));
> +    unit->tcp_hdrlen = (htons(unit->tcp->th_offset_flags) & 0xF000) >> 10;
> +
> +    /* There is a difference between payload lenght in ipv4 and v6,
> +       ip header is excluded in ipv6 */
> +    unit->payload = htons(*unit->ip_plen) - unit->tcp_hdrlen;
> +}
> +
> +static size_t virtio_net_rsc_drain_seg(NetRscChain *chain, NetRscSeg *seg)
> +{
> +    int ret;
> +    struct virtio_net_hdr *h;
> +
> +    h = (struct virtio_net_hdr *)seg->buf;
> +    h->flags = 0;
> +    h->gso_type = VIRTIO_NET_HDR_GSO_NONE;
> +
> +    if (seg->is_coalesced) {
> +        h->rsc_ext_num_packets = seg->packets;
> +        h->rsc_ext_num_dupacks = seg->dup_ack;
> +        h->flags = VIRTIO_NET_HDR_F_RSC_INFO;
> +        if (chain->proto == ETH_P_IP) {
> +            h->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> +        } else {
> +            h->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> +        }
> +    }
> +
> +    ret = virtio_net_do_receive(seg->nc, seg->buf, seg->size);
> +    QTAILQ_REMOVE(&chain->buffers, seg, next);
> +    g_free(seg->buf);
> +    g_free(seg);
> +
> +    return ret;
> +}
> +
> +static void virtio_net_rsc_purge(void *opq)
> +{
> +    NetRscSeg *seg, *rn;
> +    NetRscChain *chain = (NetRscChain *)opq;
> +
> +    QTAILQ_FOREACH_SAFE(seg, &chain->buffers, next, rn) {
> +        if (virtio_net_rsc_drain_seg(chain, seg) == 0) {
> +            chain->stat.purge_failed++;
> +            continue;
> +        }
> +    }
> +
> +    chain->stat.timer++;
> +    if (!QTAILQ_EMPTY(&chain->buffers)) {
> +        timer_mod(chain->drain_timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
> +    }
> +}
> +
> +static void virtio_net_rsc_cleanup(VirtIONet *n)
> +{
> +    NetRscChain *chain, *rn_chain;
> +    NetRscSeg *seg, *rn_seg;
> +
> +    QTAILQ_FOREACH_SAFE(chain, &n->rsc_chains, next, rn_chain) {
> +        QTAILQ_FOREACH_SAFE(seg, &chain->buffers, next, rn_seg) {
> +            QTAILQ_REMOVE(&chain->buffers, seg, next);
> +            g_free(seg->buf);
> +            g_free(seg);
> +        }
> +
> +        timer_del(chain->drain_timer);
> +        timer_free(chain->drain_timer);
> +        QTAILQ_REMOVE(&n->rsc_chains, chain, next);
> +        g_free(chain);
> +    }
> +}
> +
> +static void virtio_net_rsc_cache_buf(NetRscChain *chain, NetClientState *nc,
> +                                     const uint8_t *buf, size_t size)
> +{
> +    uint16_t hdr_len;
> +    NetRscSeg *seg;
> +
> +    hdr_len = chain->n->guest_hdr_len;
> +    seg = g_malloc(sizeof(NetRscSeg));
> +    seg->buf = g_malloc(hdr_len + sizeof(struct eth_header)
> +        + sizeof(struct ip6_header) + VIRTIO_NET_MAX_TCP_PAYLOAD);
> +    memcpy(seg->buf, buf, size);
> +    seg->size = size;
> +    seg->packets = 1;
> +    seg->dup_ack = 0;
> +    seg->is_coalesced = 0;
> +    seg->nc = nc;
> +
> +    QTAILQ_INSERT_TAIL(&chain->buffers, seg, next);
> +    chain->stat.cache++;
> +
> +    switch (chain->proto) {
> +    case ETH_P_IP:
> +        virtio_net_rsc_extract_unit4(chain, seg->buf, &seg->unit);
> +        break;
> +    case ETH_P_IPV6:
> +        virtio_net_rsc_extract_unit6(chain, seg->buf, &seg->unit);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static int32_t virtio_net_rsc_handle_ack(NetRscChain *chain,
> +                                         NetRscSeg *seg, const uint8_t *buf,
> +                                         struct tcp_header *n_tcp,
> +                                         struct tcp_header *o_tcp)
> +{
> +    uint32_t nack, oack;
> +    uint16_t nwin, owin;
> +
> +    nack = htonl(n_tcp->th_ack);
> +    nwin = htons(n_tcp->th_win);
> +    oack = htonl(o_tcp->th_ack);
> +    owin = htons(o_tcp->th_win);
> +
> +    if ((nack - oack) >= VIRTIO_NET_MAX_TCP_PAYLOAD) {
> +        chain->stat.ack_out_of_win++;
> +        return RSC_FINAL;
> +    } else if (nack == oack) {
> +        /* duplicated ack or window probe */
> +        if (nwin == owin) {
> +            /* duplicated ack, add dup ack count due to whql test up to 1 */
> +            chain->stat.dup_ack++;
> +            return RSC_FINAL;
> +        } else {
> +            /* Coalesce window update */
> +            o_tcp->th_win = n_tcp->th_win;
> +            chain->stat.win_update++;
> +            return RSC_COALESCE;
> +        }
> +    } else {
> +        /* pure ack, go to 'C', finalize*/
> +        chain->stat.pure_ack++;
> +        return RSC_FINAL;
> +    }
> +}
> +
> +static int32_t virtio_net_rsc_coalesce_data(NetRscChain *chain,
> +                                            NetRscSeg *seg, const uint8_t *buf,
> +                                            NetRscUnit *n_unit)
> +{
> +    void *data;
> +    uint16_t o_ip_len;
> +    uint32_t nseq, oseq;
> +    NetRscUnit *o_unit;
> +
> +    o_unit = &seg->unit;
> +    o_ip_len = htons(*o_unit->ip_plen);
> +    nseq = htonl(n_unit->tcp->th_seq);
> +    oseq = htonl(o_unit->tcp->th_seq);
> +
> +    /* out of order or retransmitted. */
> +    if ((nseq - oseq) > VIRTIO_NET_MAX_TCP_PAYLOAD) {
> +        chain->stat.data_out_of_win++;
> +        return RSC_FINAL;
> +    }
> +
> +    data = ((uint8_t *)n_unit->tcp) + n_unit->tcp_hdrlen;
> +    if (nseq == oseq) {
> +        if ((o_unit->payload == 0) && n_unit->payload) {
> +            /* From no payload to payload, normal case, not a dup ack or etc */
> +            chain->stat.data_after_pure_ack++;
> +            goto coalesce;
> +        } else {
> +            return virtio_net_rsc_handle_ack(chain, seg, buf,
> +                                             n_unit->tcp, o_unit->tcp);
> +        }
> +    } else if ((nseq - oseq) != o_unit->payload) {
> +        /* Not a consistent packet, out of order */
> +        chain->stat.data_out_of_order++;
> +        return RSC_FINAL;
> +    } else {
> +coalesce:
> +        if ((o_ip_len + n_unit->payload) > chain->max_payload) {
> +            chain->stat.over_size++;
> +            return RSC_FINAL;
> +        }
> +
> +        /* Here comes the right data, the payload length in v4/v6 is different,
> +           so use the field value to update and record the new data len */
> +        o_unit->payload += n_unit->payload; /* update new data len */
> +
> +        /* update field in ip header */
> +        *o_unit->ip_plen = htons(o_ip_len + n_unit->payload);
> +
> +        /* Bring 'PUSH' big, the whql test guide says 'PUSH' can be coalesced
> +           for windows guest, while this may change the behavior for linux
> +           guest (only if it uses RSC feature). */
> +        o_unit->tcp->th_offset_flags = n_unit->tcp->th_offset_flags;
> +
> +        o_unit->tcp->th_ack = n_unit->tcp->th_ack;
> +        o_unit->tcp->th_win = n_unit->tcp->th_win;
> +
> +        memmove(seg->buf + seg->size, data, n_unit->payload);
> +        seg->size += n_unit->payload;
> +        seg->packets++;
> +        chain->stat.coalesced++;
> +        return RSC_COALESCE;
> +    }
> +}
> +
> +static int32_t virtio_net_rsc_coalesce4(NetRscChain *chain, NetRscSeg *seg,
> +                                        const uint8_t *buf, size_t size,
> +                                        NetRscUnit *unit)
> +{
> +    struct ip_header *ip1, *ip2;
> +
> +    ip1 = (struct ip_header *)(unit->ip);
> +    ip2 = (struct ip_header *)(seg->unit.ip);
> +    if ((ip1->ip_src ^ ip2->ip_src) || (ip1->ip_dst ^ ip2->ip_dst)
> +        || (unit->tcp->th_sport ^ seg->unit.tcp->th_sport)
> +        || (unit->tcp->th_dport ^ seg->unit.tcp->th_dport)) {
> +        chain->stat.no_match++;
> +        return RSC_NO_MATCH;
> +    }
> +
> +    return virtio_net_rsc_coalesce_data(chain, seg, buf, unit);
> +}
> +
> +static int32_t virtio_net_rsc_coalesce6(NetRscChain *chain, NetRscSeg *seg,
> +                        const uint8_t *buf, size_t size, NetRscUnit *unit)
> +{
> +    struct ip6_header *ip1, *ip2;
> +
> +    ip1 = (struct ip6_header *)(unit->ip);
> +    ip2 = (struct ip6_header *)(seg->unit.ip);
> +    if (memcmp(&ip1->ip6_src, &ip2->ip6_src, sizeof(struct in6_address))
> +        || memcmp(&ip1->ip6_dst, &ip2->ip6_dst, sizeof(struct in6_address))
> +        || (unit->tcp->th_sport ^ seg->unit.tcp->th_sport)
> +        || (unit->tcp->th_dport ^ seg->unit.tcp->th_dport)) {
> +            chain->stat.no_match++;
> +            return RSC_NO_MATCH;
> +    }
> +
> +    return virtio_net_rsc_coalesce_data(chain, seg, buf, unit);
> +}
> +
> +/* Packets with 'SYN' should bypass, other flag should be sent after drain
> + * to prevent out of order */
> +static int virtio_net_rsc_tcp_ctrl_check(NetRscChain *chain,
> +                                         struct tcp_header *tcp)
> +{
> +    uint16_t tcp_hdr;
> +    uint16_t tcp_flag;
> +
> +    tcp_flag = htons(tcp->th_offset_flags);
> +    tcp_hdr = (tcp_flag & VIRTIO_NET_TCP_HDR_LENGTH) >> 10;
> +    tcp_flag &= VIRTIO_NET_TCP_FLAG;
> +    tcp_flag = htons(tcp->th_offset_flags) & 0x3F;
> +    if (tcp_flag & TH_SYN) {
> +        chain->stat.tcp_syn++;
> +        return RSC_BYPASS;
> +    }
> +
> +    if (tcp_flag & (TH_FIN | TH_URG | TH_RST | TH_ECE | TH_CWR)) {
> +        chain->stat.tcp_ctrl_drain++;
> +        return RSC_FINAL;
> +    }
> +
> +    if (tcp_hdr > sizeof(struct tcp_header)) {
> +        chain->stat.tcp_all_opt++;
> +        return RSC_FINAL;
> +    }
> +
> +    return RSC_CANDIDATE;
> +}
> +
> +static size_t virtio_net_rsc_do_coalesce(NetRscChain *chain,
> +                                         NetClientState *nc,
> +                                         const uint8_t *buf, size_t size,
> +                                         NetRscUnit *unit)
> +{
> +    int ret;
> +    NetRscSeg *seg, *nseg;
> +
> +    if (QTAILQ_EMPTY(&chain->buffers)) {
> +        chain->stat.empty_cache++;
> +        virtio_net_rsc_cache_buf(chain, nc, buf, size);
> +        timer_mod(chain->drain_timer,
> +              qemu_clock_get_ns(QEMU_CLOCK_HOST) + chain->n->rsc_timeout);
> +        return size;
> +    }
> +
> +    QTAILQ_FOREACH_SAFE(seg, &chain->buffers, next, nseg) {
> +        if (chain->proto == ETH_P_IP) {
> +            ret = virtio_net_rsc_coalesce4(chain, seg, buf, size, unit);
> +        } else {
> +            ret = virtio_net_rsc_coalesce6(chain, seg, buf, size, unit);
> +        }
> +
> +        if (ret == RSC_FINAL) {
> +            if (virtio_net_rsc_drain_seg(chain, seg) == 0) {
> +                /* Send failed */
> +                chain->stat.final_failed++;
> +                return 0;
> +            }
> +
> +            /* Send current packet */
> +            return virtio_net_do_receive(nc, buf, size);
> +        } else if (ret == RSC_NO_MATCH) {
> +            continue;
> +        } else {
> +            /* Coalesced, mark coalesced flag to tell calc cksum for ipv4 */
> +            seg->is_coalesced = 1;
> +            return size;
> +        }
> +    }
> +
> +    chain->stat.no_match_cache++;
> +    virtio_net_rsc_cache_buf(chain, nc, buf, size);
> +    return size;
> +}
> +
> +/* Drain a connection data, this is to avoid out of order segments */
> +static size_t virtio_net_rsc_drain_flow(NetRscChain *chain, NetClientState *nc,
> +                                        const uint8_t *buf, size_t size,
> +                                        uint16_t ip_start, uint16_t ip_size,
> +                                        uint16_t tcp_port)
> +{
> +    NetRscSeg *seg, *nseg;
> +    uint32_t ppair1, ppair2;
> +
> +    ppair1 = *(uint32_t *)(buf + tcp_port);
> +    QTAILQ_FOREACH_SAFE(seg, &chain->buffers, next, nseg) {
> +        ppair2 = *(uint32_t *)(seg->buf + tcp_port);
> +        if (memcmp(buf + ip_start, seg->buf + ip_start, ip_size)
> +            || (ppair1 != ppair2)) {
> +            continue;
> +        }
> +        if (virtio_net_rsc_drain_seg(chain, seg) == 0) {
> +            chain->stat.drain_failed++;
> +        }
> +
> +        break;
> +    }
> +
> +    return virtio_net_do_receive(nc, buf, size);
> +}
> +
> +static int32_t virtio_net_rsc_sanity_check4(NetRscChain *chain,
> +                                            struct ip_header *ip,
> +                                            const uint8_t *buf, size_t size)
> +{
> +    uint16_t ip_len;
> +
> +    /* Not an ipv4 packet */
> +    if (((ip->ip_ver_len & 0xF0) >> 4) != IP_HEADER_VERSION_4) {
> +        chain->stat.ip_option++;
> +        return RSC_BYPASS;
> +    }
> +
> +    /* Don't handle packets with ip option */
> +    if ((ip->ip_ver_len & 0xF) != VIRTIO_NET_IP4_HEADER_LENGTH) {
> +        chain->stat.ip_option++;
> +        return RSC_BYPASS;
> +    }
> +
> +    if (ip->ip_p != IPPROTO_TCP) {
> +        chain->stat.bypass_not_tcp++;
> +        return RSC_BYPASS;
> +    }
> +
> +    /* Don't handle packets with ip fragment */
> +    if (!(htons(ip->ip_off) & IP_DF)) {
> +        chain->stat.ip_frag++;
> +        return RSC_BYPASS;
> +    }
> +
> +    /* Don't handle packets with ecn flag */
> +    if (IPTOS_ECN(ip->ip_tos)) {
> +        chain->stat.ip_ecn++;
> +        return RSC_BYPASS;
> +    }
> +
> +    ip_len = htons(ip->ip_len);
> +    if (ip_len < (sizeof(struct ip_header) + sizeof(struct tcp_header))
> +        || ip_len > (size - chain->n->guest_hdr_len -
> +                     sizeof(struct eth_header))) {
> +        chain->stat.ip_hacked++;
> +        return RSC_BYPASS;
> +    }
> +
> +    return RSC_CANDIDATE;
> +}
> +
> +static size_t virtio_net_rsc_receive4(NetRscChain *chain, NetClientState* nc,
> +                                      const uint8_t *buf, size_t size)
> +{
> +    int32_t ret;
> +    uint16_t hdr_len;
> +    NetRscUnit unit;
> +
> +    hdr_len = ((VirtIONet *)(chain->n))->guest_hdr_len;
> +
> +    if (size < (hdr_len + sizeof(struct eth_header) + sizeof(struct ip_header)
> +        + sizeof(struct tcp_header))) {
> +        chain->stat.bypass_not_tcp++;
> +        return virtio_net_do_receive(nc, buf, size);
> +    }
> +
> +    virtio_net_rsc_extract_unit4(chain, buf, &unit);
> +    if (virtio_net_rsc_sanity_check4(chain, unit.ip, buf, size)
> +        != RSC_CANDIDATE) {
> +        return virtio_net_do_receive(nc, buf, size);
> +    }
> +
> +    ret = virtio_net_rsc_tcp_ctrl_check(chain, unit.tcp);
> +    if (ret == RSC_BYPASS) {
> +        return virtio_net_do_receive(nc, buf, size);
> +    } else if (ret == RSC_FINAL) {
> +        return virtio_net_rsc_drain_flow(chain, nc, buf, size,
> +                ((hdr_len + sizeof(struct eth_header)) + 12),
> +                VIRTIO_NET_IP4_ADDR_SIZE,
> +                hdr_len + sizeof(struct eth_header) + sizeof(struct ip_header));
> +    }
> +
> +    return virtio_net_rsc_do_coalesce(chain, nc, buf, size, &unit);
> +}
> +
> +static int32_t virtio_net_rsc_sanity_check6(NetRscChain *chain,
> +                                            struct ip6_header *ip6,
> +                                            const uint8_t *buf, size_t size)
> +{
> +    uint16_t ip_len;
> +
> +    if (((ip6->ip6_ctlun.ip6_un1.ip6_un1_flow & 0xF0) >> 4)
> +        != IP_HEADER_VERSION_6) {
> +        return RSC_BYPASS;
> +    }
> +
> +    /* Both option and protocol is checked in this */
> +    if (ip6->ip6_ctlun.ip6_un1.ip6_un1_nxt != IPPROTO_TCP) {
> +        chain->stat.bypass_not_tcp++;
> +        return RSC_BYPASS;
> +    }
> +
> +    ip_len = htons(ip6->ip6_ctlun.ip6_un1.ip6_un1_plen);
> +    if (ip_len < sizeof(struct tcp_header) ||
> +        ip_len > (size - chain->n->guest_hdr_len - sizeof(struct eth_header)
> +                  - sizeof(struct ip6_header))) {
> +        chain->stat.ip_hacked++;
> +        return RSC_BYPASS;
> +    }
> +
> +    /* Don't handle packets with ecn flag */
> +    if (IP6_ECN(ip6->ip6_ctlun.ip6_un3.ip6_un3_ecn)) {
> +        chain->stat.ip_ecn++;
> +        return RSC_BYPASS;
> +    }
> +
> +    return RSC_CANDIDATE;
> +}
> +
> +static size_t virtio_net_rsc_receive6(void *opq, NetClientState* nc,
> +                                      const uint8_t *buf, size_t size)
> +{
> +    int32_t ret;
> +    uint16_t hdr_len;
> +    NetRscChain *chain;
> +    NetRscUnit unit;
> +
> +    chain = (NetRscChain *)opq;
> +    hdr_len = ((VirtIONet *)(chain->n))->guest_hdr_len;
> +
> +    if (size < (hdr_len + sizeof(struct eth_header) + sizeof(struct ip6_header)
> +        + sizeof(tcp_header))) {
> +        return virtio_net_do_receive(nc, buf, size);
> +    }
> +
> +    virtio_net_rsc_extract_unit6(chain, buf, &unit);
> +    if (RSC_CANDIDATE != virtio_net_rsc_sanity_check6(chain,
> +                                                 unit.ip, buf, size)) {
> +        return virtio_net_do_receive(nc, buf, size);
> +    }
> +
> +    ret = virtio_net_rsc_tcp_ctrl_check(chain, unit.tcp);
> +    if (ret == RSC_BYPASS) {
> +        return virtio_net_do_receive(nc, buf, size);
> +    } else if (ret == RSC_FINAL) {
> +        return virtio_net_rsc_drain_flow(chain, nc, buf, size,
> +                ((hdr_len + sizeof(struct eth_header)) + 8),
> +                VIRTIO_NET_IP6_ADDR_SIZE,
> +                hdr_len + sizeof(struct eth_header)
> +                + sizeof(struct ip6_header));
> +    }
> +
> +    return virtio_net_rsc_do_coalesce(chain, nc, buf, size, &unit);
> +}
> +
> +static NetRscChain *virtio_net_rsc_lookup_chain(VirtIONet * n,
> +                                                NetClientState *nc,
> +                                                uint16_t proto)
> +{
> +    NetRscChain *chain;
> +
> +    if ((proto != (uint16_t)ETH_P_IP) && (proto != (uint16_t)ETH_P_IPV6)) {
> +        return NULL;
> +    }
> +
> +    QTAILQ_FOREACH(chain, &n->rsc_chains, next) {
> +        if (chain->proto == proto) {
> +            return chain;
> +        }
> +    }
> +
> +    chain = g_malloc(sizeof(*chain));
> +    chain->n = n;
> +    chain->proto = proto;
> +    if (proto == (uint16_t)ETH_P_IP) {
> +        chain->max_payload = VIRTIO_NET_MAX_IP4_PAYLOAD;
> +        chain->gso_type = VIRTIO_NET_HDR_GSO_TCPV4;
> +    } else {
> +        chain->max_payload = VIRTIO_NET_MAX_IP6_PAYLOAD;
> +        chain->gso_type = VIRTIO_NET_HDR_GSO_TCPV6;
> +    }
> +    chain->drain_timer = timer_new_ns(QEMU_CLOCK_HOST,
> +                                      virtio_net_rsc_purge, chain);
> +    memset(&chain->stat, 0, sizeof(chain->stat));
> +
> +    QTAILQ_INIT(&chain->buffers);
> +    QTAILQ_INSERT_TAIL(&n->rsc_chains, chain, next);
> +
> +    return chain;
> +}
> +
> +static ssize_t virtio_net_rsc_receive(NetClientState *nc,
> +                                      const uint8_t *buf,
> +                                      size_t size)
> +{
> +    uint16_t proto;
> +    NetRscChain *chain;
> +    struct eth_header *eth;
> +    VirtIONet *n;
> +
> +    n = qemu_get_nic_opaque(nc);
> +    if (size < (n->host_hdr_len + sizeof(struct eth_header))) {
> +        return virtio_net_do_receive(nc, buf, size);
> +    }
> +
> +    eth = (struct eth_header *)(buf + n->guest_hdr_len);
> +    proto = htons(eth->h_proto);
> +
> +    chain = virtio_net_rsc_lookup_chain(n, nc, proto);
> +    if (chain) {
> +        chain->stat.received++;
> +        if (proto == (uint16_t)ETH_P_IP && n->rsc4_enabled) {
> +            return virtio_net_rsc_receive4(chain, nc, buf, size);
> +        } else if (proto == (uint16_t)ETH_P_IPV6 && n->rsc6_enabled) {
> +            return virtio_net_rsc_receive6(chain, nc, buf, size);
> +        }
> +    }
> +    return virtio_net_do_receive(nc, buf, size);
> +}
> +
> +static ssize_t virtio_net_receive(NetClientState *nc, const uint8_t *buf,
> +                                  size_t size)
> +{
> +    VirtIONet *n = qemu_get_nic_opaque(nc);
> +    if ((n->rsc4_enabled || n->rsc6_enabled)) {
> +        return virtio_net_rsc_receive(nc, buf, size);
> +    } else {
> +        return virtio_net_do_receive(nc, buf, size);
> +    }
> +}
> +
>  static int32_t virtio_net_flush_tx(VirtIONetQueue *q);
>  
>  static void virtio_net_tx_complete(NetClientState *nc, ssize_t len)
> @@ -1342,7 +1974,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>          ssize_t ret;
>          unsigned int out_num;
>          struct iovec sg[VIRTQUEUE_MAX_SIZE], sg2[VIRTQUEUE_MAX_SIZE + 1], *out_sg;
> -        struct virtio_net_hdr_mrg_rxbuf mhdr;
> +        struct virtio_net_hdr_mrg_rxbuf hdr;
>  
>          elem = virtqueue_pop(q->tx_vq, sizeof(VirtQueueElement));
>          if (!elem) {
> @@ -1359,7 +1991,7 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>          }
>  
>          if (n->has_vnet_hdr) {
> -            if (iov_to_buf(out_sg, out_num, 0, &mhdr, n->guest_hdr_len) <
> +            if (iov_to_buf(out_sg, out_num, 0, &hdr, n->guest_hdr_len) <
>                  n->guest_hdr_len) {
>                  virtio_error(vdev, "virtio-net header incorrect");
>                  virtqueue_detach_element(q->tx_vq, elem, 0);
> @@ -1367,8 +1999,8 @@ static int32_t virtio_net_flush_tx(VirtIONetQueue *q)
>                  return -EINVAL;
>              }
>              if (n->needs_vnet_hdr_swap) {
> -                virtio_net_hdr_swap(vdev, (void *) &mhdr);
> -                sg2[0].iov_base = &mhdr;
> +                virtio_net_hdr_swap(vdev, (void *) &hdr);
> +                sg2[0].iov_base = &hdr;
>                  sg2[0].iov_len = n->guest_hdr_len;
>                  out_num = iov_copy(&sg2[1], ARRAY_SIZE(sg2) - 1,
>                                     out_sg, out_num,
> @@ -2075,6 +2707,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
>      nc = qemu_get_queue(n->nic);
>      nc->rxfilter_notify_enabled = 1;
>  
> +    QTAILQ_INIT(&n->rsc_chains);
>      n->qdev = dev;
>  }
>  
> @@ -2104,6 +2737,7 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
>      timer_free(n->announce_timer);
>      g_free(n->vqs);
>      qemu_del_nic(n->nic);
> +    virtio_net_rsc_cleanup(n);
>      virtio_cleanup(vdev);
>  }
>  
> @@ -2184,6 +2818,10 @@ static Property virtio_net_properties[] = {
>      DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
>                      VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
>      DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
> +    DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
> +                    VIRTIO_NET_F_RSC_EXT, false),
> +    DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
> +                       VIRTIO_NET_RSC_INTERVAL),

what if interval is set without guest_rsc_ext? should init fail?

>      DEFINE_NIC_PROPERTIES(VirtIONet, nic_conf),
>      DEFINE_PROP_UINT32("x-txtimer", VirtIONet, net_conf.txtimer,
>                         TX_TIMER_INTERVAL),
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index 4d7f3c82ca..0da99dcfa0 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -44,6 +44,83 @@ typedef struct virtio_net_conf
>      uint8_t duplex;
>  } virtio_net_conf;
>  
> +/* Coalesced packets type & status */
> +typedef enum {
> +    RSC_COALESCE,           /* Data been coalesced */
> +    RSC_FINAL,              /* Will terminate current connection */
> +    RSC_NO_MATCH,           /* No matched in the buffer pool */
> +    RSC_BYPASS,             /* Packet to be bypass, not tcp, tcp ctrl, etc */
> +    RSC_CANDIDATE                /* Data want to be coalesced */
> +} COALESCE_STATUS;

Should be CoalesceStatus.

> +
> +typedef struct NetRscStat {
> +    uint32_t received;
> +    uint32_t coalesced;
> +    uint32_t over_size;
> +    uint32_t cache;
> +    uint32_t empty_cache;
> +    uint32_t no_match_cache;
> +    uint32_t win_update;
> +    uint32_t no_match;
> +    uint32_t tcp_syn;
> +    uint32_t tcp_ctrl_drain;
> +    uint32_t dup_ack;
> +    uint32_t dup_ack1;
> +    uint32_t dup_ack2;
> +    uint32_t pure_ack;
> +    uint32_t ack_out_of_win;
> +    uint32_t data_out_of_win;
> +    uint32_t data_out_of_order;
> +    uint32_t data_after_pure_ack;
> +    uint32_t bypass_not_tcp;
> +    uint32_t tcp_option;
> +    uint32_t tcp_all_opt;
> +    uint32_t ip_frag;
> +    uint32_t ip_ecn;
> +    uint32_t ip_hacked;
> +    uint32_t ip_option;
> +    uint32_t purge_failed;
> +    uint32_t drain_failed;
> +    uint32_t final_failed;
> +    int64_t  timer;
> +} NetRscStat;
> +
> +/* Rsc unit general info used to checking if can coalescing */
> +typedef struct NetRscUnit {
> +    void *ip;   /* ip header */
> +    uint16_t *ip_plen;      /* data len pointer in ip header field */
> +    struct tcp_header *tcp; /* tcp header */
> +    uint16_t tcp_hdrlen;    /* tcp header len */
> +    uint16_t payload;       /* pure payload without virtio/eth/ip/tcp */
> +} NetRscUnit;
> +
> +/* Coalesced segmant */
> +typedef struct NetRscSeg {
> +    QTAILQ_ENTRY(NetRscSeg) next;
> +    void *buf;
> +    size_t size;
> +    uint16_t packets;
> +    uint16_t dup_ack;
> +    bool is_coalesced;      /* need recal ipv4 header checksum, mark here */
> +    NetRscUnit unit;
> +    NetClientState *nc;
> +} NetRscSeg;


If these structs are generic and not virtio specific,
pls put them and code for handling them in generic files
under net/. OTOH if they are virtio specific, please
prefix names with Virtio.

> +
> +struct VirtIONet;
> +typedef struct VirtIONet VirtIONet;
> +
> +/* Chain is divided by protocol(ipv4/v6) and NetClientInfo */
> +typedef struct NetRscChain {
> +    QTAILQ_ENTRY(NetRscChain) next;
> +    VirtIONet *n;                            /* VirtIONet */
> +    uint16_t proto;
> +    uint8_t  gso_type;
> +    uint16_t max_payload;
> +    QEMUTimer *drain_timer;
> +    QTAILQ_HEAD(, NetRscSeg) buffers;
> +    NetRscStat stat;
> +} NetRscChain;
> +
>  /* Maximum packet size we can receive from tap device: header + 64k */
>  #define VIRTIO_NET_MAX_BUFSIZE (sizeof(struct virtio_net_hdr) + (64 * KiB))
>  
> @@ -66,12 +143,16 @@ typedef struct VirtIONet {
>      VirtIONetQueue *vqs;
>      VirtQueue *ctrl_vq;
>      NICState *nic;
> +    QTAILQ_HEAD(, NetRscChain) rsc_chains;

what exactly happens with these chains on migration?

>      uint32_t tx_timeout;
>      int32_t tx_burst;
>      uint32_t has_vnet_hdr;
>      size_t host_hdr_len;
>      size_t guest_hdr_len;
>      uint64_t host_features;
> +    uint32_t rsc_timeout;
> +    uint8_t rsc4_enabled;
> +    uint8_t rsc6_enabled;
>      uint8_t has_ufo;
>      uint32_t mergeable_rx_bufs;
>      uint8_t promisc;
> diff --git a/include/net/eth.h b/include/net/eth.h
> index e6dc8a7ba0..7f45c678e7 100644
> --- a/include/net/eth.h
> +++ b/include/net/eth.h
> @@ -177,6 +177,8 @@ struct tcp_hdr {
>  #define TH_PUSH 0x08
>  #define TH_ACK  0x10
>  #define TH_URG  0x20
> +#define TH_ECE  0x40
> +#define TH_CWR  0x80
>      u_short th_win;      /* window */
>      u_short th_sum;      /* checksum */
>      u_short th_urp;      /* urgent pointer */
> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> index 260c3681d7..0d8658c06a 100644
> --- a/include/standard-headers/linux/virtio_net.h
> +++ b/include/standard-headers/linux/virtio_net.h
> @@ -57,6 +57,10 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_RSC_EXT	38

Should it be VIRTIO_NET_F_GUEST_RSC_EXT ?

> +#define VIRTIO_NET_F_GUEST_RSC4_DONT_USE	41	/* reserved */
> +#define VIRTIO_NET_F_GUEST_RSC6_DONT_USE	42	/* reserved */
> +
>  #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
>  					 * with the same MAC.
>  					 */
> @@ -104,6 +108,7 @@ struct virtio_net_config {
>  struct virtio_net_hdr_v1 {
>  #define VIRTIO_NET_HDR_F_NEEDS_CSUM	1	/* Use csum_start, csum_offset */
>  #define VIRTIO_NET_HDR_F_DATA_VALID	2	/* Csum is valid */
> +#define VIRTIO_NET_HDR_F_RSC_INFO	4	/* rsc_ext data in csum_ fields */
>  	uint8_t flags;
>  #define VIRTIO_NET_HDR_GSO_NONE		0	/* Not a GSO frame */
>  #define VIRTIO_NET_HDR_GSO_TCPV4	1	/* GSO frame, IPv4 TCP (TSO) */
> @@ -118,6 +123,9 @@ struct virtio_net_hdr_v1 {
>  	__virtio16 num_buffers;	/* Number of merged rx buffers */
>  };
>  
> +#define rsc_ext_num_packets		csum_start
> +#define rsc_ext_num_dupacks		csum_offset

I would prefer an inline function to set the field, or a union.


> +
>  #ifndef VIRTIO_NET_NO_LEGACY
>  /* This header comes first in the scatter-gather list.
>   * For legacy virtio, if VIRTIO_F_ANY_LAYOUT is not negotiated, it must

This part needs to get into the Linux header. Pls post there.
Until it does you can put it in virtio-net.c


> -- 
> 2.17.1
